IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(POEsFromEmails.Layouts.Base) pBase  = POEsFromEmails.Files().base.qa) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(POEsFromEmails.Layouts.Base l) := TRANSFORM																							 
				SELF.source                      := l.email_src;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.date_first_seen), l.date_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.date_last_seen), l.date_last_seen, 0);
				// SELF.dt_vendor_first_reported    := SELF.dt_first_seen;
				// SELF.dt_vendor_last_reported     := SELF.dt_last_seen;
				SELF.rcid       			   	       := l.bh_rec_key;
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.bh_company_name;
				SELF.company_address.prim_range  := l.person_addr.prim_range;
				SELF.company_address.predir      := l.person_addr.predir;
				SELF.company_address.prim_name   := l.person_addr.prim_name;
				SELF.company_address.addr_suffix := l.person_addr.addr_suffix;
				SELF.company_address.postdir     := l.person_addr.postdir;
				SELF.company_address.unit_desig  := l.person_addr.unit_desig;
				SELF.company_address.sec_range   := l.person_addr.sec_range;
				SELF.company_address.p_city_name := l.person_addr.p_city_name;
				SELF.company_address.v_city_name := l.person_addr.v_city_name;
				SELF.company_address.st          := l.person_addr.st;
				SELF.company_address.zip	       := l.person_addr.zip;
				SELF.company_address.zip4        := l.person_addr.zip4;
				// SELF.company_fein 			         := (STRING)l.company_fein;
				// SELF.company_phone 			         := (STRING)l.company_phone;
				// SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.pname.title;
				SELF.contact_name.fname          := l.pname.fname;
				SELF.contact_name.mname          := l.pname.mname;
				SELF.contact_name.lname          := l.pname.lname;
				SELF.contact_name.name_suffix		 := l.pname.name_suffix;
				SELF.contact_ssn                 := l.best_ssn;
				SELF.contact_email               := TRIM(l.clean_email);
				SELF.contact_phone               := (STRING)l.bh_phone;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_pfe_proj	:= PROJECT(pBase(bh_company_name <> '' AND (pname.fname <> '' OR pname.lname <> '')), trfMAPBLInterface(LEFT));
																	
		from_pfe_dedp  := DEDUP(SORT(DISTRIBUTE(from_pfe_proj,HASH(company_bdid, company_name, rcid)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_pfe_dedp;
END;