IMPORT ut, UtilFile, yellowpages, Cellphone;
#OPTION('multiplePersistInstances',FALSE);

EXPORT map_csd(STRING8 filedate) := FUNCTION

	pm_csd 						:= PhoneMart.Files.PhoneMart_CSD;
	//Filter out records with invalid phone numbers
	yellowpages.NPA_PhoneType(pm_csd, phone, phonetype, outfile);
	pm_csd_sel	:= PROJECT(outfile(phonetype<>'INVALID-NPA/NXX/TB'), {pm_csd}) : PERSIST('~persist::phonemart::pm_csd_sel');
	
	//Not using UtilFile.file_util.full_did because it only returns records within last 5 years
	util_did					:= PROJECT(dataset(ut.foreign_prod + 'thor_data400::base::utility_DID', UtilFile.Layout_DID_Out, flat)
											                (did NOT IN ['','000000000000'] and Exchange_Serial_Number<>''),
															 {LEFT.Exchange_Serial_Number, LEFT.did, LEFT.title, LEFT.fname, LEFT.mname, LEFT.lname, LEFT.name_suffix});				
	
	//CSD lookup table is provided by Equifax when they migrated to their new system and changed CSD numbers.
	//This table provides the mapping of old CSD numbers to new ones.
	util_lookupfile 	:= UtilFile.file_utility_nctue_in.lookupfile;
	
	//Populate old CSD reference number for future use
	pm_csd_sel_plus 	:= JOIN(SORT(DISTRIBUTE(pm_csd_sel,HASH(CSD_REF_NUMBER)),CSD_REF_NUMBER,LOCAL),
                            SORT(DISTRIBUTE(util_lookupfile,HASH(digit_New_ref_nbr)),digit_New_ref_nbr,LOCAL),
													  LEFT.csd_ref_number=right.digit_New_ref_nbr,
													  TRANSFORM(PhoneMart.Layouts.base,
														          SELF.OLD_CSD_REF_NUMBER:=right.digit_Old_ref_nbr;
																			SELF.DT_VENDOR_FIRST_REPORTED:=(UNSIGNED4) filedate;
																			SELF.DT_VENDOR_LAST_REPORTED:=(UNSIGNED4) filedate;
																			SELF.DT_FIRST_SEEN:=(UNSIGNED4) LEFT.FIRST_SEEN_DATE;
																			SELF.DT_LAST_SEEN:=(UNSIGNED4) LEFT.LAST_SEEN_DATE;
																			SELF.SSN := '';             
																			SELF:=LEFT;SELF:=[];),
													  LEFT OUTER, local);
														
	base_csd 					:= JOIN(SORT(DISTRIBUTE(pm_csd_sel_plus, hash(CSD_REF_NUMBER)),csd_ref_number,LOCAL),
														SORT(DISTRIBUTE(util_did,hash(Exchange_Serial_Number)),Exchange_Serial_Number,LOCAL),
														TRIM(LEFT.CSD_REF_NUMBER)=TRIM(right.Exchange_Serial_Number),
														TRANSFORM(PhoneMart.Layouts.base,SELF.record_type:='2';
																														 SELF.did := (UNSIGNED6) RIGHT.did;
																														 SELF.title := RIGHT.title;
																														 SELF.fname := RIGHT.fname;
																														 SELF.mname := RIGHT.mname;
																														 SELF.lname := RIGHT.lname;
																														 SELF.name_suffix := RIGHT.name_suffix;
																														 SELF:=LEFT;SELF:=RIGHT;),
														LEFT OUTER, LOCAL);
														
	base_csd_plus 		:= JOIN(SORT(DISTRIBUTE(base_csd(OLD_CSD_REF_NUMBER<>'' AND did=0), hash(CSD_REF_NUMBER)),csd_ref_number,LOCAL),
														SORT(DISTRIBUTE(util_did,hash(Exchange_Serial_Number)),Exchange_Serial_Number,LOCAL),
														LEFT.did=0 AND LEFT.OLD_CSD_REF_NUMBER<>'' AND
														TRIM(LEFT.OLD_CSD_REF_NUMBER)=TRIM(right.Exchange_Serial_Number),
														TRANSFORM(PhoneMart.Layouts.base,SELF.record_type:='2';
																														 SELF.did := (UNSIGNED6) RIGHT.did;
																														 SELF.title := RIGHT.title;
																														 SELF.fname := RIGHT.fname;
																														 SELF.mname := RIGHT.mname;
																														 SELF.lname := RIGHT.lname;
																														 SELF.name_suffix := RIGHT.name_suffix;
																														 SELF:=LEFT;SELF:=RIGHT;),
														LEFT OUTER, LOCAL);

	base_csd_dedup := DEDUP(SORT(DISTRIBUTE(base_csd(OLD_CSD_REF_NUMBER='' OR did<>0)+base_csd_plus,HASH(CSD_REF_NUMBER)),RECORD,LOCAL),RECORD,ALL,LOCAL)
	                  : PERSIST('~thor_data400::persist::phonemart::map_csd');										

	RETURN base_csd_dedup; 
	
END;