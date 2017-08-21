IMPORT header,business_header,mdr,_Validate,Address,PRTE2_Bankruptcy, BankruptcyV2, ut, BIPV2;

EXPORT as_headers := MODULE
	
	SHARED bs_v2 := PROJECT(PRTE2_Bankruptcy.Files.Search_Base,TRANSFORM(BankruptcyV2.layout_bankruptcy_search, SELF := LEFT));
	SHARED bm_v2 := PROJECT(PRTE2_Bankruptcy.Files.Main_BaseV2,TRANSFORM(BankruptcyV2.layout_bankruptcy_main.layout_bankruptcy_main_filing, SELF := LEFT));
/*************************************************************************
	Person Records
	*************************************************************************/
	header.Layout_New_Records MapPeopleHeader(BankruptcyV2.layout_bankruptcy_search l) := TRANSFORM
	  self.did := (unsigned)l.did;
	  self.rid := 0;
		SELF.dt_first_seen 	           := IF(_validate.date.fIsValid(l.date_first_seen),
                                         (UNSIGNED3)(l.date_first_seen[1..6]), 0);
		SELF.dt_last_seen 	           := IF(_validate.date.fIsValid(l.date_last_seen),
                                         (UNSIGNED3)(l.date_last_seen[1..6]), 0);
		SELF.dt_vendor_first_reported  := IF(_validate.date.fIsValid(l.date_vendor_first_reported),
                                         (UNSIGNED3)(l.date_vendor_first_reported[1..6]), 0);
		SELF.dt_vendor_last_reported 	 := IF(_validate.date.fIsValid(l.date_vendor_last_reported),
                                         (UNSIGNED3)(l.date_vendor_last_reported[1..6]), 0);
	  self.dt_nonglb_last_seen 			 := IF(_validate.date.fIsValid(l.date_vendor_last_reported),
                                          (UNSIGNED3)(l.date_vendor_last_reported[1..6]), 0);
	  self.rec_type 	:= '';
	  self.vendor_id 	:= TRIM(L.tmsid) + TRIM(L.debtor_type,LEFT,RIGHT);
	  self.dob 				:= 0;
	  self.ssn 				:= if((integer)l.ssn=0 ,l.app_SSN,l.ssn);
	  self.city_name 	:= l.v_city_name;
	  self.phone 			:= '';
	  self.title 			:= l.title;
	  self.fname 			:= l.fname;
	  self.mname 			:= l.mname;
	  self.lname 			:= l.lname;
	  self.name_suffix := l.name_suffix;
	  self.county 		:= l.county[3..5];
	  self.cbsa 			:= if(l.msa!='',l.msa+'0','');
	  self.src 				:= MDR.sourceTools.src_Bankruptcy;
	  self.suffix 		:= l.addr_suffix;
	  self            := l;
		self            := [];
	 END;
		
	EXPORT person_header_Bankruptcy := project(bs_v2((unsigned)did>0), MapPeopleHeader(left));
	
/*************************************************************************
	Business Records
	*************************************************************************/
	EXPORT business_header_Bankruptcy := FUNCTION
		RETURN BankruptcyV2.fBankruptv2_As_Business_Header(bs_v2, bm_v2);
	END;
	
	/*************************************************************************
	 Business records with contacts
	 *************************************************************************/
	EXPORT business_contacts_bankruptcy := FUNCTION
		RETURN BankruptcyV2.fBankruptv2_As_Business_Contact(bs_v2, bm_v2);
	END;
	
	/*************************************************************************
		Business Contacts Linking
	 *************************************************************************/							 
	EXPORT business_linking_bankruptcy := FUNCTION
		bs_bip	:= PROJECT(PRTE2_Bankruptcy.Files.Search_Base,TRANSFORM(BankruptcyV2.layout_bankruptcy_search_v3_supp_bip, SELF.scrubsbits1 := 0; SELF := LEFT));
		RETURN BankruptcyV2.fBankruptv2_As_Business_Linking(bs_bip, bm_v2);
	END;
	
END;
	
