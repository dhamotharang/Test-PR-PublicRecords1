IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(Diversity_Certification.Layouts.keybuild) pKey = Diversity_Certification.Files().KeyBuildSF) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(Diversity_Certification.Layouts.keybuild l, INTEGER C) := TRANSFORM,
      SKIP(((C = 1 OR C = 2) AND TRIM(l.phone) = '' AND (TRIM(l.cell) != '' OR TRIM(l.fax) != '')) OR           
           ((C = 2 OR C = 4 OR C = 6) AND TRIM(l.p_prim_range + l.p_predir + l.p_prim_name)  = '') OR
           ((C = 3 OR C = 4) AND TRIM(l.cell) = '') OR
           ((C = 5 OR C = 6) AND TRIM(l.fax) = ''))																							 
				SELF.source                      := MDR.sourceTools.src_Diversity_Cert;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid(l.dt_first_seen), (UNSIGNED4)l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(l.dt_last_seen), (UNSIGNED4)l.dt_last_seen, 0);
 				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid(l.dt_vendor_first_reported), (UNSIGNED4)l.dt_vendor_first_reported, 0);
				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid(l.dt_vendor_last_reported), (UNSIGNED4)l.dt_vendor_last_reported, 0);
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := ut.CleanSpacesAndUpper(l.businessname);
				SELF.company_address.prim_range  := IF(C % 2 = 1, l.m_prim_range, l.p_prim_range);
				SELF.company_address.predir      := IF(C % 2 = 1, l.m_predir, l.p_predir);
				SELF.company_address.prim_name   := IF(C % 2 = 1, l.m_prim_name, l.p_prim_name);
				SELF.company_address.addr_suffix := IF(C % 2 = 1, l.m_addr_suffix, l.p_addr_suffix);
				SELF.company_address.postdir     := IF(C % 2 = 1, l.m_postdir, l.p_postdir);
				SELF.company_address.unit_desig  := IF(C % 2 = 1, l.m_unit_desig, l.p_unit_desig);
				SELF.company_address.sec_range   := IF(C % 2 = 1, l.m_sec_range, l.p_sec_range);
				SELF.company_address.p_city_name := IF(C % 2 = 1, l.m_p_city_name, l.p_p_city_name);
				SELF.company_address.v_city_name := IF(C % 2 = 1, l.m_v_city_name, l.p_v_city_name);
				SELF.company_address.st          := IF(C % 2 = 1, l.m_st, l.p_st);
				SELF.company_address.zip	       := IF(C % 2 = 1, l.m_zip, l.p_zip);
				SELF.company_address.zip4        := IF(C % 2 = 1, l.m_zip4, l.p_zip4);
			  SELF.company_phone               := CHOOSE(C, l.phone, l.phone, l.cell, l.cell, l.fax, l.fax);
			  SELF.phone_type                  := CHOOSE(C, 
                                                   IF(l.phone != '', 'T', ''),
                                                   IF(l.phone != '', 'T', ''),
                                                   IF(l.phone != '', 'T', ''),
                                                   IF(l.phone != '', 'T', ''),
                                                   IF(l.phone != '', 'F', ''),
                                                   IF(l.phone != '', 'F', ''));
				SELF.contact_name.title          := l.title;
				SELF.contact_name.fname          := l.fname;
				SELF.contact_name.mname          := l.mname;
				SELF.contact_name.lname          := l.lname;
				SELF.contact_name.name_suffix		 := l.suffix;
				SELF.contact_email               := l.email;
			  SELF.contact_phone               := CHOOSE(C, l.phone, l.phone, l.cell, l.cell, l.fax, l.fax);
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_DivCert_norm	:= NORMALIZE(pKey, 6, trfMAPBLInterface(LEFT,COUNTER));

	  BIPV2.Layout_Business_Linking_Full RollupDivCert(BIPV2.Layout_Business_Linking_Full L, 
                                                     BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                             ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen             := max(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_last_reported  := max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		  SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
			SELF.company_phone            := IF(TRIM(L.company_phone) = '', R.company_phone, L.company_phone);
			SELF.phone_type               := IF(TRIM(L.phone_type) = '', R.phone_type, L.phone_type); 
			SELF.contact_phone            := IF(TRIM(L.contact_phone) = '', R.contact_phone, L.contact_phone);
		  SELF                          := L;
	  END;
		
    from_DivCert_dist   := DISTRIBUTE(from_DivCert_norm,HASH(company_bdid,company_name));
    from_DivCert_sort   := SORT(from_DivCert_dist, company_bdid, company_name, company_address.st, 
                                company_address.p_city_name, company_address.zip, company_address.prim_range,
                                company_address.predir, company_address.prim_name, company_address.addr_suffix,
                                company_address.postdir, company_address.unit_desig, contact_name.lname, 
                                contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                                contact_name.title, contact_email, company_phone, -dt_vendor_last_reported,
                                LOCAL);
		from_DivCert_rollup := ROLLUP(from_DivCert_sort, 
                                  LEFT.company_bdid                = RIGHT.company_bdid AND
                                  LEFT.company_name                = RIGHT.company_name AND
                                  LEFT.company_address.st          = RIGHT.company_address.st AND
                                  LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name AND
                                  LEFT.company_address.zip         = RIGHT.company_address.zip AND
                                  LEFT.company_address.prim_range  = RIGHT.company_address.prim_range AND
                                  LEFT.company_address.predir      = RIGHT.company_address.predir AND
                                  LEFT.company_address.prim_name   = RIGHT.company_address.prim_name AND
                                  LEFT.company_address.addr_suffix = RIGHT.company_address.addr_suffix AND
                                  LEFT.company_address.postdir     = RIGHT.company_address.postdir AND
                                  LEFT.company_address.unit_desig  = RIGHT.company_address.unit_desig AND
                                  LEFT.contact_name.lname          = RIGHT.contact_name.lname AND
                                  LEFT.contact_name.fname          = RIGHT.contact_name.fname AND
                                  LEFT.contact_name.mname          = RIGHT.contact_name.mname AND
                                  LEFT.contact_name.name_suffix    = RIGHT.contact_name.name_suffix AND
                                  LEFT.contact_name.title          = RIGHT.contact_name.title AND
                                  LEFT.contact_email               = RIGHT.contact_email AND
                                  (TRIM(LEFT.company_phone) = '' OR LEFT.company_phone = RIGHT.company_phone) AND
                                  (TRIM(LEFT.contact_phone) = '' OR LEFT.contact_phone = RIGHT.contact_phone),
                                  RollupDivCert(LEFT, RIGHT),
                                  LOCAL);

		RETURN from_DivCert_rollup;
END;
