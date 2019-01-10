IMPORT ut, STD;
EXPORT Fn_Rollup_Base(DATASET(RECORDOF(Layouts.Base_BIP)) email_in) := FUNCTION
	
	//This was part of the original email_data code.  Keeping as issue may still exist in history records
fix_dates := PROJECT(email_in, TRANSFORM(Layouts.Base_BIP,
															 SELF.process_date		:= IF(trim(LEFT.process_date) = '', LEFT.date_vendor_last_reported, LEFT.process_date);
															 SELF.date_first_seen := IF(LEFT.date_first_seen[..8] NOT BETWEEN '197001' AND (string8)STD.Date.Today(), '', LEFT.date_first_seen),
															 SELF.date_last_seen 	:= IF(LEFT.date_last_seen[..8] NOT BETWEEN '197001' AND (string8)STD.Date.Today(), '', LEFT.date_last_seen),
															 SELF.date_vendor_first_reported	:= IF(LEFT.date_vendor_first_reported[..8] NOT BETWEEN '197001' AND (string8)STD.Date.Today(), '', LEFT.date_vendor_first_reported),
															 SELF.date_vendor_last_reported 	:= IF(LEFT.date_vendor_last_reported[..8] NOT BETWEEN '197001' AND (string8)STD.Date.Today(), '', LEFT.date_vendor_last_reported),
															 //DF-16472
															 SELF.orig_email := REGEXREPLACE('[\n|\r]',LEFT.orig_email,'');
															 SELF := LEFT));
															 
	//Previous incremental base -  Reset current record flag to false																															
reset_prev_base := PROJECT(Email_DataV2.Files.Email_Base, TRANSFORM(RECORDOF(email_in), SELF.current_rec := false,
                                                                                                SELF := LEFT));

//Concatenate new and previous base
current_and_prev := IF(nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::email_dataV2')) = 0,
												fix_dates,
												fix_dates + reset_prev_base);

lTemp	:= RECORD
	RECORDOF(current_and_prev);
	STRING FullName;
	STRING FullAddr;
END;

pExtBase	:= PROJECT(current_and_prev, TRANSFORM(lTemp, SELF.FullName := STD.Str.FilterOut(STD.Str.CleanSpaces(LEFT.orig_first_name+LEFT.orig_last_name+LEFT.orig_middle_name),' ');
																					SELF.FullAddr := STD.Str.FilterOut(STD.Str.CleanSpaces(LEFT.orig_address+LEFT.orig_city+LEFT.orig_state),' ');
																					SELF := LEFT));
																					
current_and_prev_d := DISTRIBUTE(pExtBase, HASH(clean_email));
current_and_prev_s := SORT(current_and_prev_d,
													clean_email, 
													FullName,
													orig_CompanyName,
													FullAddr,
													orig_zip,
													clean_dob,
													clean_phone,
													clean_ssn,
													email_src,
													current_rec, LOCAL);

//Rollup files to eliminate duplications and to keep history on when a record was first and last included in the build
lTemp tRollup(current_and_prev_s le, current_and_prev_s ri) := TRANSFORM
  SELF.current_rec              	:=  IF(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
	SELF.process_date								:=	MAX(le.date_vendor_last_reported, ri.date_vendor_last_reported);  //Populate process_date since not all sets have it and it is not mapped
	SELF.date_first_seen 						:= (string)ut.EarliestDate((unsigned)le.date_first_seen, (unsigned)ri.date_first_seen);
	SELF.date_last_seen  						:= MAX(le.date_last_seen,ri.date_last_seen);
	SELF.date_vendor_first_reported := (string)ut.EarliestDate((unsigned)le.date_vendor_first_reported, (unsigned)ri.date_vendor_first_reported);
	SELF.date_vendor_last_reported	:= MAX(le.date_vendor_last_reported,ri.date_vendor_last_reported);
	SELF := ri;
END;
	
	
Rollup_file   := ROLLUP(current_and_prev_s, tRollup(LEFT, RIGHT),
												clean_email, 
												FullName,
												cln_CompanyName,
												FullAddr,
												orig_zip,
												clean_dob,
												clean_phone,
												clean_ssn,
												email_src, LOCAL);
												
pBaseOut	:= PROJECT(Rollup_file, TRANSFORM(Email_DataV2.Layouts.Base_BIP, SELF := LEFT));
												
//No longer required as records are no longer rolled up across sources
/*
//*****append num dids per email and num emails per did (including did = 0)
dids_email_dedp   := DEDUP(SORT(DISTRIBUTE(Rollup_file,HASH(clean_email)), did, clean_email, did, LOCAL), did, clean_email, LOCAL);


append_emails_per_did  := JOIN(DISTRIBUTE(Rollup_file(did > 0), HASH(did)),
                               DISTRIBUTE(num_emails_per_did, HASH(did)),
															 LEFT.did = RIGHT.did,
															 TRANSFORM(RECORDOF(email_in),
																				 SELF.num_email_per_did := RIGHT.cnt,
																				 SELF := LEFT),
															LEFT OUTER,
															LOCAL);

append_dids_per_email  := JOIN(DISTRIBUTE(Rollup_file(did = 0) + append_emails_per_did, HASH(clean_email)),
                               DISTRIBUTE(num_dids_per_email , HASH(clean_email)),
															 LEFT.clean_email = RIGHT.clean_email,
															 TRANSFORM(RECORDOF(email_in),
																				 SELF.num_did_per_email  := RIGHT.cnt,
																				 SELF := LEFT),
															LEFT OUTER,
															LOCAL);
*/															 		
RETURN pBaseOut;
END;
