/***************************************************************************************************************************
 *                                                                                                                         *
 *  This module contains 
 *       function to build MIDEX did table from SANCTN, SANCTN_Mari, and MARI base files.                                  *
 *                                                                                                                         *
 ***************************************************************************************************************************/
IMPORT SANCTN, SANCTN_Mari, ut,bipv2, DID_Add,PromoteSupers, dx_common;

EXPORT fnMidexDid := MODULE

	SHARED	fSanctnParty:= sanctn.file_base_party;			//layout - SANCTN.layout_SANCTN_did
	SHARED	fSanctnLic:= sanctn.file_base_license;
	SHARED	fSanctnMariParty:= sanctn_mari.files_SANCTN_did.party_did;		//layout - SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base
	SHARED	fSanctnMariLic:= sanctn_mari.files_SANCTN_common.incident_codes;
	SHARED	fMari:= Prof_License_Mari.file_mari_search;  //layout - Prof_License_Mari.layouts.final

	SHARED layout_sanctn_party_plus := RECORD
		SANCTN.layout_SANCTN_did;
		STRING50  	CLN_LICENSE_NUMBER;
	END;

	SHARED layout_sanctn_np_party_plus := RECORD
	 SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base;
			STRING20	CODE_VALUE;
			STRING20	CLN_LICENSE_NUMBER;
	END;

	SHARED layout_mari_final_seq := record
				Prof_License_Mari.layouts.final;
				UNSIGNED4	seq;
				UNSIGNED3 did_score:=0;
	end;
	
	EXPORT layout_midex_did := RECORD
		STRING 	record_id;
		STRING 	source_code;
		STRING 	fname;
		STRING 	lname;
		STRING 	city;
		STRING2 state;
		STRING9 zip;
		STRING  license_nbr;
		UNSIGNED6 did := 0;
		UNSIGNED3 did_score := 0;
		//DF-28229 Add Delta build fields
		dx_common.layout_metadata;				

		// STRING 	party_name;
		// integer source_rec_id;   	//from sanctn file
		// STRING 	incident_num;			//from sanctn np
		// integer party_key;				//from sanctn np
		// integer cmc_slpk;					//from mari
	END;	
	
	//remove leading 0
	EXPORT STRING cleanLicenseNbr(STRING lic_nbr) := FUNCTION
		trimLicNbr						:= ut.CleanSpacesAndUpper(lic_nbr);
		cleanedLicense				:= StringLib.StringFilter(trimLicNbr,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		leadingAlphaChars			:= REGEXFIND('(^[A-Z]*)',cleanedLicense,1);
		theRest								:= REGEXREPLACE(leadingAlphaChars,cleanedLicense,'');
		s1										:= IF(REGEXFIND('(^0+)',theRest),
		                            REGEXREPLACE('(^0+)',theRest,''),
																theRest);
		RETURN TRIM(leadingAlphaChars+s1);														
	END;
	
  EXPORT file_MidexDid 		 := DATASET('~thor_data400::base::proflic_mari::midex_did',layout_midex_did,THOR);
	
	//This attribute builds Midex DID lookup table. It extracts the names, addresses, license numbers info from SANCTN base
	//files, SANCTN_NP base files, and 2 passed in MARI files in the function.
	//The first input file is the file with DID populated from names, business addresses, and license numbers.
	//The second input file is the file with DID populated from names, mail addresses, and license numbers.
	EXPORT buildMidexDidFile(DATASET(layout_mari_final_seq) mari_bus, DATASET(layout_mari_final_seq) mari_mail) := FUNCTION

		//build lname+fname+state+license to did mapping from SANCTN party base file
		sanctn_party_plus 		:= JOIN(SORT(DISTRIBUTE(fSanctnParty(did<>0),HASH(batch_number, incident_number, party_number)),
																			 batch_number, incident_number, party_number,local),
																	DEDUP(SORT(DISTRIBUTE(fSanctnLic(cln_license_number<>'' AND NOT REGEXFIND('NMLS',LICENSE_TYPE,NOCASE)), HASH(batch_number, incident_number, party_number)),
																			       batch_number, incident_number, party_number,local),
																				batch_number, incident_number, party_number,local),
																	TRIM(LEFT.batch_number)=TRIM(RIGHT.batch_number) AND
																	TRIM(LEFT.incident_number)=TRIM(RIGHT.incident_number) AND
																	TRIM(LEFT.party_number) = TRIM(RIGHT.party_number),
																	TRANSFORM(layout_sanctn_party_plus,
																						SELF.cln_license_number:=RIGHT.cln_license_number;
																						SELF:=LEFT;),
																	LEFT OUTER);
		lookup_sanctn 				:= PROJECT(sanctn_party_plus(cln_license_number<>'' and lname<>'' and st<>''),
																		 TRANSFORM(layout_midex_did,
																							 SELF.fname:=TRIM(LEFT.fname);
																							 SELF.lname:=TRIM(LEFT.lname);
																							 SELF.city:=TRIM(LEFT.p_city_name);
																							 SELF.state:=TRIM(LEFT.st);
																							 SELF.zip:=TRIM(LEFT.zip5)+TRIM(LEFT.zip4);
																							 SELF.license_nbr:=TRIM(LEFT.CLN_LICENSE_NUMBER);
																							 SELF.record_id:=TRIM(SELF.lname)+TRIM(SELF.fname)+TRIM(SELF.state)/*+TRIM(SELF.zip)*/
																							 +':'+cleanLicenseNbr(SELF.license_nbr);
																							 SELF.source_code:='SANCTN';
																							 SELF:=LEFT;SELF:=[];));

		//build lname+fname+state+license to did mapping from SANCTN NP party base file
		sanctn_mari_party_plus:= JOIN(SORT(DISTRIBUTE(fSanctnMariParty(did<>0 and NOT REGEXFIND('[0-9]+',name_first+name_last)),
		                                              HASH(batch, INCIDENT_NUM, dbcode)),
																			 batch, INCIDENT_NUM, dbcode,PARTY_NUM,local),
																	dedup(SORT(DISTRIBUTE(fSanctnMariLic(field_name='LICENSECODE' and cln_license_number<>'' AND NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE)),HASH(batch, INCIDENT_NUM, dbcode)),
                                             batch, INCIDENT_NUM, dbcode,NUMBER,local),
									                      batch, INCIDENT_NUM, dbcode,NUMBER,local),
																	TRIM(LEFT.batch)=TRIM(RIGHT.batch) AND
																	TRIM(LEFT.dbcode) = TRIM(RIGHT.dbcode) AND
																	TRIM(LEFT.INCIDENT_NUM) = TRIM(RIGHT.INCIDENT_NUM) AND
																	LEFT.PARTY_NUM = RIGHT.NUMBER,
																	TRANSFORM(layout_sanctn_np_party_plus,
																	          SELF.code_value:=RIGHT.code_value;
																						SELF.cln_license_number:=RIGHT.cln_license_number;
																						SELF:=LEFT;),
																	LEFT OUTER); // : PERSIST(SANCTN.cluster + 'persist::SANCTN_NP::party_license');
		lookup_sanctn_mari 		:= PROJECT(sanctn_mari_party_plus(cln_license_number<>'' and name_last<>'' and state<>''),
		                                 TRANSFORM(layout_midex_did,
                                               SELF.fname:=TRIM(LEFT.name_first);
																							 SELF.lname:=TRIM(LEFT.name_last);
                    													 SELF.license_nbr:=TRIM(LEFT.CLN_LICENSE_NUMBER);
																							 SELF.city:=TRIM(LEFT.city);
																							 SELF.state:=TRIM(LEFT.state);
																							 SELF.record_id:=TRIM(SELF.lname)+TRIM(SELF.fname)+/*TRIM(SELF.city)+*/TRIM(SELF.state)
																							 +':'+cleanLicenseNbr(SELF.license_nbr);
																							 SELF.source_code:='SANCTN_NP';
                                               SELF:=LEFT;SELF:=[];));

		//build lname+fname+state+license to did mapping from MARI files
		//mari_bus is the name + business address + license to did mapping
		lookup_mari1 					:= PROJECT(mari_bus(did<>0 and LICENSE_NBR<>'' and TRIM(LICENSE_NBR,LEFT,RIGHT)<>'NR' and name_last<>'' and bus_state<>''),																		 TRANSFORM(layout_midex_did,
																							 SELF.fname:=TRIM(LEFT.name_first);
																							 SELF.lname:=TRIM(LEFT.name_last);
																							 SELF.city:=TRIM(LEFT.bus_p_city_name);
																							 SELF.state:=TRIM(LEFT.bus_state);
																							 SELF.zip:=TRIM(LEFT.bus_zip5)+TRIM(LEFT.bus_zip4);
																							 SELF.license_nbr:=TRIM(LEFT.LICENSE_NBR);
																							 SELF.record_id:=TRIM(SELF.lname)+TRIM(SELF.fname)+/*TRIM(SELF.city)+*/TRIM(SELF.state)
																							 +':'+cleanLicenseNbr(SELF.license_nbr);
																							 SELF.source_code:='MARI';
																							 SELF:=LEFT;SELF:=[];));		
		//mari_mail is the name + mail address + license to did mapping
		lookup_mari2 					:= PROJECT(mari_mail(did<>0 and LICENSE_NBR<>'' and TRIM(LICENSE_NBR,LEFT,RIGHT)<>'NR' and name_last<>'' and mail_state<>''),
																		 TRANSFORM(layout_midex_did,
																							 SELF.fname:=TRIM(LEFT.name_first);
																							 SELF.lname:=TRIM(LEFT.name_last);
																							 SELF.city:=TRIM(LEFT.mail_p_city_name);
																							 SELF.state:=TRIM(LEFT.mail_state);
																							 SELF.zip:=TRIM(LEFT.bus_zip5)+TRIM(LEFT.bus_zip4);
																							 SELF.license_nbr:=TRIM(LEFT.LICENSE_NBR);
																							 SELF.record_id:=TRIM(SELF.lname)+TRIM(SELF.fname)+/*TRIM(SELF.city)+*/TRIM(SELF.state)
																							 +':'+cleanLicenseNbr(SELF.license_nbr);
																							 SELF.source_code:='MARI';
																							 SELF:=LEFT;SELF:=[];));		
		
		//If a record_id mapps to multiple DIDs or 1 DID with did scores, keep the one with hightest did_score																		
		lookups_dedp 					:= DEDUP(SORT(DISTRIBUTE(lookup_sanctn+lookup_sanctn_mari+lookup_mari1+lookup_mari2,HASH(record_id,did_score)),
		                                    record_id,-did_score,LOCAL),
																				record_id);
		
		PromoteSupers.MAC_SF_BuildProcess(lookups_dedp ,'~thor_data400::base::proflic_mari::midex_did',build_midex_did,2);

		ofile := build_midex_did;
		
		RETURN ofile;
		
	END;

	SANCTN_temprec := RECORD
		SANCTN.layout_SANCTN_party_clean;
		STRING		blk := '';
		bipv2.IDlayouts.l_xlink_ids;
		UNSIGNED6	did := 0;
		UNSIGNED3 did_score := 0;
		UNSIGNED6	bdid := 0;
		UNSIGNED3 bdid_score := 0;
		STRING9		ssn_appended := '';
		STRING9 	temp_ssn		 := '';
		UNSIGNED8 source_rec_id := 0;
		STRING1		enh_did_src	:= '';					//Ehanced did source; M for Mari, S for SANCTN, N for SANCTN Non-public
	END;
	
	// Sample usage
	EXPORT SANCTN_Enhance_Did(DATASET(RECORDOF(SANCTN_temprec)) fSanctn) := FUNCTION
		
		fSanctn_did 					:= fSanctn(did<>0);
		fSanctn_no_did 				:= fSanctn(did=0);
		midex_did							:= file_MidexDid;
		
		layout_sanctn_plus := RECORD
			fSanctn;
			STRING50	CLN_LICENSE_NUMBER;
			STRING  	record_id;
		END;

		layout_sanctn_ext := RECORD
			fSanctn;
			STRING1 enh_did_flag:='';
		END;

		f_sanctn_new 					:= JOIN(SORT(DISTRIBUTE(fSanctn_no_did,                    HASH(batch_number, incident_number, party_number)),
																			 batch_number, incident_number, party_number,LOCAL),
																  SORT(DISTRIBUTE(fSanctnLic(cln_license_number<>'' AND NOT REGEXFIND('NMLS',LICENSE_TYPE,NOCASE)),HASH(batch_number, incident_number, party_number)),
																			 batch_number, incident_number, party_number,LOCAL),
																  TRIM(LEFT.batch_number)=TRIM(RIGHT.batch_number) AND
																  TRIM(LEFT.incident_number) = TRIM(RIGHT.incident_number) AND
																  TRIM(LEFT.party_number) = TRIM(RIGHT.party_number), 
																  TRANSFORM(layout_sanctn_plus,
																	 				  SELF.cln_license_number:=RIGHT.cln_license_number;
																					  SELF.record_id:=TRIM(LEFT.lname)+TRIM(LEFT.fname)+TRIM(LEFT.st)+
																							              ':'+cleanLicenseNbr(SELF.cln_license_number);
																					 SELF:=LEFT;),
																	LEFT OUTER);		
		
		f_sanctn_enhance_did 	:= JOIN(SORT(DISTRIBUTE(f_sanctn_new,HASH(record_id)),record_id,LOCAL),
																	SORT(DISTRIBUTE(midex_did,HASH(record_id)),record_id,LOCAL),
																	LEFT.record_id=RIGHT.record_id,
																	TRANSFORM(SANCTN_temprec,
																					 SELF.did:=if(LEFT.did<>0,LEFT.did,RIGHT.did);
																					 SELF.did_score:=map(SELF.did<>0 and SELF.did=LEFT.did=>LEFT.did_score,
																					                     SELF.did<>0 and SELF.did=RIGHT.did=>RIGHT.did_score,
																					                     0);
																					 SELF.enh_did_src:= IF(SELF.did=0 OR LEFT.did<>0,'',
																																	CASE(RIGHT.source_code,'MARI'=>'M','SANCTN'=>'S','SANCTN_NP'=>'N','U'));
																						 SELF:=LEFT;),
																	LEFT OUTER);	

		new_sanctn					  := f_sanctn_enhance_did +fSanctn_did;
		//Dedup and keep the records with highest did score																
		new_sanctn_dedup		 := DEDUP(SORT(DISTRIBUTE(new_sanctn,HASH(batch_number, incident_number, party_number, record_type, order_number)),
		                                   batch_number, incident_number, party_number, record_type, order_number, fname, lname, st, -did_score,LOCAL),
																	RECORD, EXCEPT did, did_score, enh_did_src);

		RETURN new_sanctn_dedup;
		
	END;

	// Sample usage
	EXPORT SANCTN_Mari_Enhance_Did(DATASET(RECORDOF(SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did)) infile) := FUNCTION

		fSanctn_mari_did			:= infile(did<>0);
		fSanctn_mari_no_did 	:= infile(did=0);
		midex_did							:= file_MidexDid;

		layout_sanctn_mari_plus := RECORD
			SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did;
			STRING20	CODE_VALUE;
			STRING50	CLN_LICENSE_NUMBER;
			STRING  	record_id;
		END;

		//Get license number from incident code base file. Note that NMLS ID is excluded.
		f_sanctn_mari_new 		:= JOIN(SORT(DISTRIBUTE(fSanctn_mari_no_did,                   HASH(batch, INCIDENT_NUM, dbcode, party_num)),
																			 batch, INCIDENT_NUM, dbcode,party_num,LOCAL),
																  SORT(DISTRIBUTE(fSanctnMariLic(field_name='LICENSECODE' and cln_license_number<>'' AND NOT REGEXFIND('NMLS',CODE_TYPE,NOCASE)),
																	                HASH(batch, INCIDENT_NUM, dbcode, number)),
																			 batch, INCIDENT_NUM, dbcode, number,LOCAL),
																  TRIM(LEFT.batch)=TRIM(RIGHT.batch) AND
																  TRIM(LEFT.INCIDENT_NUM) = TRIM(RIGHT.INCIDENT_NUM) AND
																  TRIM(LEFT.dbcode) = TRIM(RIGHT.dbcode) AND
																	TRIM(LEFT.PARTY_NUM) = TRIM(RIGHT.NUMBER),
																  TRANSFORM(layout_sanctn_mari_plus,
																						SELF.code_value:=RIGHT.code_value;
																	 				  SELF.cln_license_number:=RIGHT.cln_license_number;
																					  SELF.record_id:=TRIM(LEFT.name_last)+TRIM(LEFT.name_first)+/*TRIM(LEFT.city)+*/TRIM(LEFT.state)+
																							              ':'+cleanLicenseNbr(RIGHT.cln_license_number);
																					 SELF:=LEFT;),
																	LEFT OUTER);		
		
		f_sanctn_mari_enhance_did := JOIN(SORT(DISTRIBUTE(f_sanctn_mari_new,HASH(record_id)),record_id,LOCAL),
																	SORT(DISTRIBUTE(midex_did,HASH(record_id)),record_id,LOCAL),
																	LEFT.record_id=RIGHT.record_id,
																	TRANSFORM(SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did,
																					 SELF.did:=if(LEFT.did<>0,LEFT.did,RIGHT.did);
																					 SELF.did_score:=map(SELF.did<>0 and SELF.did=LEFT.did=>LEFT.did_score,
																					                     SELF.did<>0 and SELF.did=RIGHT.did=>RIGHT.did_score,
																					                     0);
																					 SELF.enh_did_src:= IF(SELF.did=0 OR LEFT.did<>0,'',
																																	CASE(RIGHT.source_code,'MARI'=>'M','SANCTN'=>'S','SANCTN_NP'=>'N','U'));
																						 SELF:=LEFT;),
																	LEFT OUTER);	

		new_sanctn_mari				 := f_sanctn_mari_enhance_did +fSanctn_mari_did;

		//Dedup and keep the records with highest did score																
		new_sanctn_mari_dedup	 := DEDUP(SORT(DISTRIBUTE(new_sanctn_mari,HASH(batch,dbcode,incident_num,party_num,name_first,name_last,state)),
		                                     batch,dbcode,incident_num,party_num,name_first,name_last,state,-did_score,LOCAL),
																		RECORD, EXCEPT did, did_score, enh_did_src);
		RETURN new_sanctn_mari_dedup;
		
	END;

END;