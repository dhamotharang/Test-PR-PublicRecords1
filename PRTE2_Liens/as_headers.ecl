IMPORT Header, Business_Header, PRTE2_Liens, LiensV2, MDR, ut, _Validate;

EXPORT as_headers := MODULE

	//For Person Records -- Not pointing to Prod attribute as Prod has filters for '999999001000' or greater DID's so may filter PRCT records
	header.Layout_New_Records MapPeopleHeader(PRTE2_Liens.Layouts.party_base l) := TRANSFORM
	  self.did := (unsigned)l.did;
	  self.rid := 0;
		SELF.dt_first_seen 	           := IF(_validate.date.fIsValid(l.date_first_seen),
                                         (UNSIGNED4)(l.date_first_seen[1..6]), 0);
		SELF.dt_last_seen 	           := IF(_validate.date.fIsValid(l.date_last_seen),
                                         (UNSIGNED4)(l.date_last_seen[1..6]), 0);
		SELF.dt_vendor_first_reported  := IF(_validate.date.fIsValid(l.date_vendor_first_reported),
                                         (UNSIGNED4)(l.date_vendor_first_reported[1..6]), 0);
		SELF.dt_vendor_last_reported 	 := IF(_validate.date.fIsValid(l.date_vendor_last_reported),
                                         (UNSIGNED4)(l.date_vendor_last_reported[1..6]), 0);
	  self.dt_nonglb_last_seen 			 := IF(_validate.date.fIsValid(l.date_vendor_last_reported),
                                          (UNSIGNED4)(l.date_vendor_last_reported[1..6]), 0);
	  self.rec_type 	:= '1';
	  self.vendor_id 	:= trim(l.tmsid) + trim(l.rmsid);
	  self.dob 				:= 0;
	  self.ssn 				:= if ((integer)l.ssn=0 or length(trim(l.ssn, all)) <> 9 or regexfind('[^0-9]', l.ssn),'',l.ssn); //existing code in Prod. May not need for prte
	  self.city_name 	:= l.v_city_name;
	  self.phone 			:= '';
	  self.title 			:= l.title;
	  self.fname 			:= l.fname;
	  self.mname 			:= l.mname;
	  self.lname 			:= l.lname;
	  self.name_suffix := l.name_suffix;
	  self.county 		:= l.county[3..5];
	  self.cbsa 			:= if(l.msa!='',l.msa+'0','');
	  self.src 				:= MDR.sourceTools.src_Liens_v2;
	  self.suffix 		:= l.addr_suffix;
	  self            := l;
		self            := [];
	 END;
		
	EXPORT person_header_liens := project(PRTE2_Liens.files.Party_out((unsigned)did>0), MapPeopleHeader(left));
	
	//For Business Records
	EXPORT business_header_liens := FUNCTION
		lp_bip_flag	:= PROJECT(PRTE2_Liens.files.Party_out,TRANSFORM(LiensV2.Layout_liens_party_SSN_BIPV2_with_LinkFlags, SELF := LEFT, self := []));
		RETURN LiensV2.fliensV2_As_Business_Header(lp_bip_flag, true)(bdid>0);
	END;
	
		
	EXPORT new_business_header_liens := FUNCTION
		lp_bip	:= PROJECT(PRTE2_Liens.files.Party_out,TRANSFORM(LiensV2.layout_liens_party_ssn_BIPV2, SELF := LEFT, self := []));
		RETURN LiensV2.fLiensV2_As_Business_Linking(lp_bip);
	END;
	
	END;