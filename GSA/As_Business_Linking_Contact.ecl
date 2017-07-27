IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(GSA.Layouts_GSA.Layout_Base) pBase  = GSA.File_GSA_Base) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(GSA.Layouts_GSA.Layout_Base l) := TRANSFORM																							 
				SELF.source                      := MDR.sourceTools.src_GSA;       
				// SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(l.dt_last_seen), (UNSIGNED4)l.dt_last_seen, 0);
				// SELF.dt_vendor_first_reported    := SELF.dt_first_seen;
				// SELF.dt_vendor_last_reported     := SELF.dt_last_seen;
				SELF.rcid       			   	       := l.gsa_id;
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.name;
				SELF.company_address.prim_range  := l.prim_range;
				SELF.company_address.predir      := l.predir;
				SELF.company_address.prim_name   := l.prim_name;
				SELF.company_address.addr_suffix := l.addr_suffix;
				SELF.company_address.postdir     := l.postdir;
				SELF.company_address.unit_desig  := l.unit_desig;
				SELF.company_address.sec_range   := l.sec_range;
				SELF.company_address.p_city_name := l.p_city_name;
				SELF.company_address.v_city_name := l.v_city_name;
				SELF.company_address.st          := l.st;
				SELF.company_address.zip	       := l.zip5;
				SELF.company_address.zip4        := l.zip4;
				// SELF.company_fein 			         := (STRING)l.company_fein;
				// SELF.company_phone 			         := (STRING)l.company_phone;
				// SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.title;
				SELF.contact_name.fname          := l.fname;
				SELF.contact_name.mname          := l.mname;
				SELF.contact_name.lname          := l.lname;
				SELF.contact_name.name_suffix		 := l.name_suffix;
				// SELF.contact_ssn                 := (STRING)l.ssn;
				// SELF.contact_email               := l.email_address;
				// SELF.contact_phone               := (STRING)l.phone;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_gsa_proj	:= PROJECT(pBase(name <> '' AND (fname <> '' OR lname <> '')), trfMAPBLInterface(LEFT));
																	
		from_gsa_dedp  := DEDUP(SORT(DISTRIBUTE(from_gsa_proj,HASH(company_bdid, company_name, rcid)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_gsa_dedp;
END;