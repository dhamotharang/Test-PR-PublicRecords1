IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(RedBooks.layouts.Base.Layout_Combined) pBase = RedBooks.files().base.Combined.qa) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(RedBooks.layouts.Base.Layout_Combined l) := TRANSFORM																							 
				SELF.source                      := MDR.sourceTools.src_Redbooks;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.dt_last_seen), l.dt_last_seen, 0);
				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_first_reported), l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_last_reported), l.dt_vendor_last_reported, 0);
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.rawfields.name;
				SELF.company_address.prim_range  := l.clean_address.prim_range;
				SELF.company_address.predir      := l.clean_address.predir;
				SELF.company_address.prim_name   := l.clean_address.prim_name;
				SELF.company_address.addr_suffix := l.clean_address.addr_suffix;
				SELF.company_address.postdir     := l.clean_address.postdir;
				SELF.company_address.unit_desig  := l.clean_address.unit_desig;
				SELF.company_address.sec_range   := l.clean_address.sec_range;
				SELF.company_address.p_city_name := l.clean_address.p_city_name;
				SELF.company_address.v_city_name := l.clean_address.v_city_name;
				SELF.company_address.st          := l.clean_address.st;
				SELF.company_address.zip	       := l.clean_address.zip;
				SELF.company_address.zip4        := l.clean_address.zip4;
				//SELF.company_fein 			         := l.employer_fein;
				//SELF.company_phone 			         := (STRING)l.company_phone;
				//SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.clean_name.title;
				SELF.contact_name.fname          := l.clean_name.fname;
				SELF.contact_name.mname          := l.clean_name.mname;
				SELF.contact_name.lname          := l.clean_name.lname;
				SELF.contact_name.name_suffix		 := l.clean_name.name_suffix;
				//SELF.contact_ssn                 := IF(ut.ssn_length(l.claimant_ssn) = 9, l.claimant_ssn, '');
				//SELF.contact_email               := l.email_address;
				SELF.contact_phone               := (STRING)l.clean_phone;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_rb_proj	:= PROJECT(pBase(rawfields.name <> ''), trfMAPBLInterface(LEFT));

		from_rb_dist  := DISTRIBUTE(from_rb_proj(contact_name.fname <> '' OR contact_name.lname <> ''),HASH(company_bdid, company_name, company_address.zip));
    
		from_rb_dedp  := DEDUP(SORT(from_rb_dist,RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_rb_dedp;
END;