IMPORT header,business_header,mdr,_Validate,Address,PRTE2_UCC, UCCV2, _validate;

EXPORT as_headers := MODULE

	//For Person Records
	header.Layout_New_Records MapPeopleHeader(Layouts.Party l) := TRANSFORM
		SELF.did := (unsigned)l.did;
	  SELF.rid := 0;
		SELF.dt_first_seen						:= l.dt_first_seen;
		SELF.dt_last_seen							:= l.dt_last_seen;
		SELF.dt_vendor_first_reported	:= l.dt_vendor_first_reported;
		SELF.dt_vendor_last_reported	:= l.dt_vendor_last_reported;
	  SELF.dt_nonglb_last_seen 			:= l.dt_vendor_last_reported;
	  SELF.rec_type 	:= '';
	  SELF.vendor_id 	:= trim(l.Party_type) + '-' + l.tmsid;
	  SELF.dob 				:= 0;
	  SELF.ssn 				:= IF((integer)l.ssn=0,'',l.ssn);
	  SELF.city_name 	:= l.v_city_name;
	  SELF.phone 			:= '';
	  SELF.title 			:= l.title;
	  SELF.fname 			:= l.fname;
	  SELF.mname 			:= l.mname;
	  SELF.lname 			:= l.lname;
	  SELF.name_suffix := l.name_suffix;
	  SELF.src 				:= MDR.sourceTools.src_UCCV2;
	  SELF            := l;
		SELF            := [];
	 END;
		
	EXPORT person_header_ucc := PROJECT(PRTE2_UCC.Files.Party_base((unsigned)did>0), MapPeopleHeader(left));
	
	//For Business Records
	EXPORT business_header_ucc := FUNCTION
		RETURN	UCCV2.fUCCV2_As_Business_Header(PRTE2_UCC.Files.Party_base((unsigned)bdid>0), true);
	END;
	
	//For Business records with contacts
	EXPORT business_contacts_ucc := FUNCTION
		RETURN UCCV2.fUCCV2_As_Business_contact(PRTE2_UCC.Files.Party_base((unsigned)bdid>0), true);
	END;
																					
	//New Business Header with Contacts
	EXPORT new_business_header_ucc := FUNCTION
		RETURN UCCV2.As_Business_Linking(PRTE2_UCC.Files.Party_base, true);
	END;
	
END;
		
	