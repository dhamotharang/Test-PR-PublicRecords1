IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(One_Click_Data.Layouts.Base) pBase  = One_Click_Data.Files().base.qa) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(One_Click_Data.Layouts.Base l, INTEGER C) := TRANSFORM,
      SKIP((C=1 AND l.clean_phones.homephone=0 AND (l.clean_phones.mobilephone!=0 OR l.clean_phones.workphone!=0 OR l.clean_phones.ref1phone!=0)) OR
           (C=2 AND l.clean_phones.mobilephone=0) OR
           (C=3 AND l.clean_phones.workphone=0) OR
           (C=4 AND l.clean_phones.ref1phone=0))
				SELF.source                      := MDR.sourceTools.src_One_Click_Data;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.dt_last_seen), l.dt_last_seen, 0);
				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_first_reported), l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_last_reported), l.dt_vendor_last_reported, 0);
				// SELF.rcid       			   	       := l.gsa_id;
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.rawfields.workname;
				SELF.company_address.prim_range  := l.clean_home_address.prim_range;
				SELF.company_address.predir      := l.clean_home_address.predir;
				SELF.company_address.prim_name   := l.clean_home_address.prim_name;
				SELF.company_address.addr_suffix := l.clean_home_address.addr_suffix;
				SELF.company_address.postdir     := l.clean_home_address.postdir;
				SELF.company_address.unit_desig  := l.clean_home_address.unit_desig;
				SELF.company_address.sec_range   := l.clean_home_address.sec_range;
				SELF.company_address.p_city_name := l.clean_home_address.p_city_name;
				SELF.company_address.v_city_name := l.clean_home_address.v_city_name;
				SELF.company_address.st          := l.clean_home_address.st;
				SELF.company_address.zip	       := l.clean_home_address.zip;
				SELF.company_address.zip4        := l.clean_home_address.zip4;
				// SELF.company_fein 			         := (STRING)l.company_fein;
				// SELF.company_phone 			       := (STRING)l.company_phone;
				// SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.clean_name.title;
				SELF.contact_name.fname          := l.clean_name.fname;
				SELF.contact_name.mname          := l.clean_name.mname;
				SELF.contact_name.lname          := l.clean_name.lname;
				SELF.contact_name.name_suffix		 := l.clean_name.name_suffix;
				SELF.contact_ssn                 := l.rawfields.ssn;
				SELF.contact_email               := l.rawfields.emailaddress;
				SELF.contact_phone               := (STRING10)CHOOSE(C, l.clean_phones.homephone, l.clean_phones.mobilephone,
                                                                l.clean_phones.workphone, l.clean_phones.ref1phone);
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_ocd_norm	:= NORMALIZE(pBase(rawfields.workname <> '' AND (clean_name.fname <> '' OR clean_name.lname <> '')), 4, trfMAPBLInterface(LEFT,COUNTER));
																	
		from_ocd_dedp  := DEDUP(SORT(DISTRIBUTE(from_ocd_norm,HASH(company_bdid, company_name, contact_phone)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_ocd_dedp;
END;