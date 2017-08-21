IMPORT BIPV2, ut, mdr, _Validate, OIG;

EXPORT OIG_As_Business_Linking_Contact (
	  DATASET(OIG.Layouts.KeyBuild) pKey = OIG.File_OIG_KeyBaseTemp_bid) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(OIG.Layouts.KeyBuild l) := TRANSFORM																							 
				SELF.source                      := MDR.sourceTools.src_OIG;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid(l.dt_first_seen), (UNSIGNED4)l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(l.dt_last_seen), (UNSIGNED4)l.dt_last_seen, 0);
 				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid(l.dt_vendor_first_reported), (UNSIGNED4)l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid(l.dt_vendor_last_reported), (UNSIGNED4)l.dt_vendor_last_reported, 0);
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := ut.fnTrim2Upper(l.busname);
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
				SELF.company_address.zip	       := l.zip;
				SELF.company_address.zip4        := l.zip4;
				SELF.contact_name.title          := l.title;
				SELF.contact_name.fname          := l.fname;
				SELF.contact_name.mname          := l.mname;
				SELF.contact_name.lname          := l.lname;
				SELF.contact_name.name_suffix		 := l.name_suffix;
				SELF.contact_ssn                 := l.ssn;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_oig_proj	:= PROJECT(pKey, trfMAPBLInterface(LEFT));
																	
		from_oig_dedp  := DEDUP(SORT(DISTRIBUTE(from_oig_proj,HASH(company_bdid,company_name)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_oig_dedp;
END;
