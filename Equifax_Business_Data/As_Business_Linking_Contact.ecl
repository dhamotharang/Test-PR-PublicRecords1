IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pContactBase = Equifax_Business_Data.files().base.contacts.qa) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(Equifax_Business_Data.Layouts.Base_Contacts l) := TRANSFORM			
        SELF.source_docid                := l.efx_id;
		    SELF.vl_id                       := l.efx_id;
				SELF.rcid                        := 0;
				SELF.source_record_id            := l.rcid;
				SELF.source                      := MDR.sourceTools.src_Equifax_Business_Data;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.dt_last_seen), l.dt_last_seen, 0);
 				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_first_reported), l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid((STRING)l.dt_vendor_last_reported), l.dt_vendor_last_reported, 0);
				SELF.company_name 			         := ut.CleanSpacesAndUpper(l.company_name);
				SELF.company_rawaid              := l.raw_aid;
				SELF.company_aceaid              := l.ace_aid;
				SELF.company_address.prim_range  := l.clean_company_address.prim_range;
				SELF.company_address.predir      := l.clean_company_address.predir;
				SELF.company_address.prim_name   := l.clean_company_address.prim_name;
				SELF.company_address.addr_suffix := l.clean_company_address.addr_suffix;
				SELF.company_address.postdir     := l.clean_company_address.postdir;
				SELF.company_address.unit_desig  := l.clean_company_address.unit_desig;
				SELF.company_address.sec_range   := l.clean_company_address.sec_range;
				SELF.company_address.p_city_name := l.clean_company_address.p_city_name;
				SELF.company_address.v_city_name := l.clean_company_address.v_city_name;
				SELF.company_address.st          := l.clean_company_address.st;
				SELF.company_address.zip	       := l.clean_company_address.zip;
				SELF.company_address.zip4        := l.clean_company_address.zip4;
			  SELF.company_phone               := l.clean_company_phone;
			  SELF.phone_type                  := IF(l.clean_company_phone != '', 'T', '');
				SELF.contact_did                 := l.did;
				SELF.contact_name.title          := l.clean_name.title;
				SELF.contact_name.fname          := l.clean_name.fname;
				SELF.contact_name.mname          := l.clean_name.mname;
				SELF.contact_name.lname          := l.clean_name.lname;
				SELF.contact_name.name_suffix		 := l.clean_name.name_suffix;
				SELF.contact_email               := l.efx_email;
			  SELF.contact_phone               := '';
				SELF.contact_type_raw            := l.efx_titlecd;
				SELF.contact_job_title_raw       := l.efx_titledesc;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;

		mapBL := PROJECT(pContactBase, trfMAPBLInterface(LEFT));

	  BIPV2.Layout_Business_Linking_Full RollupEquifax(BIPV2.Layout_Business_Linking_Full L, 
                                                     BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                             ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen             := max(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_last_reported  := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		  SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		  SELF                          := L;
	  END;
		
    equifaxDist   := DISTRIBUTE(mapBL,HASH(source_docid, company_name));
    equifaxSort   := SORT(equifaxDist, source_docid, company_name, company_rawaid, company_aceaid, company_address.st, 
                                company_address.p_city_name, company_address.v_city_name, company_address.zip, company_address.zip4, company_address.prim_range,
                                company_address.predir, company_address.prim_name, company_address.addr_suffix,
                                company_address.postdir, company_address.unit_desig, company_address.sec_range,  
                                contact_did, contact_name.lname, contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                                contact_name.title, contact_type_raw, contact_email, company_phone, dt_last_seen,
                                LOCAL);
		equifaxRollup := ROLLUP(equifaxSort, 
                                  LEFT.source_docid                = RIGHT.source_docid AND																	
																	LEFT.company_rawaid              = RIGHT.company_rawaid AND
																	LEFT.company_aceaid              = RIGHT.company_aceaid AND
                                  LEFT.company_name                = RIGHT.company_name AND
                                  LEFT.company_address.st          = RIGHT.company_address.st AND
                                  LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND																	
                                  LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name AND
                                  LEFT.company_address.zip         = RIGHT.company_address.zip AND
                                  LEFT.company_address.zip4        = RIGHT.company_address.zip4 AND
                                  LEFT.company_address.prim_range  = RIGHT.company_address.prim_range AND
                                  LEFT.company_address.predir      = RIGHT.company_address.predir AND
                                  LEFT.company_address.prim_name   = RIGHT.company_address.prim_name AND
                                  LEFT.company_address.addr_suffix = RIGHT.company_address.addr_suffix AND
                                  LEFT.company_address.postdir     = RIGHT.company_address.postdir AND
                                  LEFT.company_address.unit_desig  = RIGHT.company_address.unit_desig AND																	
                                  LEFT.company_address.sec_range   = RIGHT.company_address.sec_range AND
                                  LEFT.contact_did                 = RIGHT.contact_did AND
                                  LEFT.contact_name.lname          = RIGHT.contact_name.lname AND
                                  LEFT.contact_name.fname          = RIGHT.contact_name.fname AND
                                  LEFT.contact_name.mname          = RIGHT.contact_name.mname AND
                                  LEFT.contact_name.name_suffix    = RIGHT.contact_name.name_suffix AND
                                  LEFT.contact_name.title          = RIGHT.contact_name.title AND
                                  LEFT.contact_type_raw            = RIGHT.contact_type_raw AND
                                  LEFT.contact_email               = RIGHT.contact_email AND
                                  (TRIM(LEFT.company_phone) = '' OR LEFT.company_phone = RIGHT.company_phone),
                                  RollupEquifax(LEFT, RIGHT),
                                  LOCAL);

		RETURN equifaxRollup;
END;
