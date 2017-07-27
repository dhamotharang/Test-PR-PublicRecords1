IMPORT BIPV2, ut, mdr, _Validate;

EXPORT As_Business_Linking_Contact (
	  DATASET(Martindale_Hubbell.layouts.base.Organizations         ) pOrgBase  = Martindale_Hubbell.files().base.Organizations.qa,
    DATASET(Martindale_Hubbell.layouts.base.Affiliated_Individuals) pAffBase	= Martindale_Hubbell.files().base.Affiliated_individuals.qa) := FUNCTION

	  // get company address first
	  lay_aff_plus := RECORD
		  layouts.base.Affiliated_Individuals;
		  STRING10 CONTACT_PHONES_PHONE_NUMBER;
	  END;

	  daffbase_plus := JOIN(
		  pAffBase,
		  pOrgBase,
		  LEFT.rawfields.ORG_AUDIT_FIRMNO = RIGHT.rawfields.ORG_AUDIT_FIRMNO
		  AND LEFT.dt_vendor_first_reported BETWEEN RIGHT.dt_vendor_first_reported AND RIGHT.dt_vendor_last_reported,
		  TRANSFORM(lay_aff_plus,
			  SELF.CONTACT_PHONES_PHONE_NUMBER	:= RIGHT.clean_phones.CONTACT_PHONES_PHONE_NUMBER;
			  SELF													    := LEFT;),
		  KEEP(1));
  	 	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(lay_aff_plus l, INTEGER C) := TRANSFORM
				
        phone :=	CHOOSE(((C - 1) % 5) + 1,
			    l.clean_phones.CONTACT_FAXS_FAX_NUMBER,								
			    l.clean_phones.CONTACT_PHONES_PHONE_NUMBER,							
			    l.clean_phones.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER,	
			    l.clean_phones.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER,		
			    l.clean_phones.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER);

        phone_type  :=	CHOOSE(((C - 1) % 5) + 1, 'F', 'T', 'T', 'F', 'T');

		    contaddcnt	:= ((C - 1) % 2) + 1;

        SELF.source                      := Martindale_Hubbell.Source_Codes.Affiliated_Individuals;       
				SELF.dt_first_seen               := l.dt_first_seen;
				SELF.dt_last_seen                := l.dt_last_seen;
				SELF.dt_vendor_first_reported    := l.dt_vendor_first_reported;
				SELF.dt_vendor_last_reported     := l.dt_vendor_last_reported;
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.rawfields.HEADER_AFF_INDIV_NAME_ORG_NAME;
				SELF.company_address.prim_range  := CHOOSE(contaddcnt, l.Clean_contact_location_address.prim_range, l.Clean_contact_mailing_address.prim_range);
				SELF.company_address.predir      := CHOOSE(contaddcnt, l.Clean_contact_location_address.predir, l.Clean_contact_mailing_address.predir);
				SELF.company_address.prim_name   := CHOOSE(contaddcnt, l.Clean_contact_location_address.prim_name, l.Clean_contact_mailing_address.prim_name);
				SELF.company_address.addr_suffix := CHOOSE(contaddcnt, l.Clean_contact_location_address.addr_suffix, l.Clean_contact_mailing_address.addr_suffix);
				SELF.company_address.postdir     := CHOOSE(contaddcnt, l.Clean_contact_location_address.postdir, l.Clean_contact_mailing_address.postdir);
				SELF.company_address.unit_desig  := CHOOSE(contaddcnt, l.Clean_contact_location_address.unit_desig, l.Clean_contact_mailing_address.unit_desig);
				SELF.company_address.sec_range   := CHOOSE(contaddcnt, l.Clean_contact_location_address.sec_range, l.Clean_contact_mailing_address.sec_range);
				SELF.company_address.p_city_name := CHOOSE(contaddcnt, l.Clean_contact_location_address.p_city_name, l.Clean_contact_mailing_address.p_city_name);
				SELF.company_address.v_city_name := CHOOSE(contaddcnt, l.Clean_contact_location_address.v_city_name, l.Clean_contact_mailing_address.v_city_name);
				SELF.company_address.st          := CHOOSE(contaddcnt, l.Clean_contact_location_address.st, l.Clean_contact_mailing_address.st);
				SELF.company_address.zip	       := CHOOSE(contaddcnt, l.Clean_contact_location_address.zip, l.Clean_contact_mailing_address.zip);
				SELF.company_address.zip4        := CHOOSE(contaddcnt, l.Clean_contact_location_address.zip4, l.Clean_contact_mailing_address.zip4);
				SELF.company_phone               := phone;
				SELF.phone_type                  := IF(phone <> '', phone_type, '');
				SELF.contact_name.title          := l.clean_contact_name.title;
				SELF.contact_name.fname          := l.clean_contact_name.fname;
				SELF.contact_name.mname          := l.clean_contact_name.mname;
				SELF.contact_name.lname          := l.clean_contact_name.lname;
				SELF.contact_name.name_suffix		 := l.clean_contact_name.name_suffix;
				SELF.contact_email               := l.rawfields.contact_emails_email_addr;
				SELF.contact_phone               := l.CONTACT_PHONES_PHONE_NUMBER;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_MH_norm	:= NORMALIZE(daffbase_plus, 10, trfMAPBLInterface(LEFT,COUNTER));

	  BIPV2.Layout_Business_Linking_Full RollupMH(BIPV2.Layout_Business_Linking_Full L, 
                                                BIPV2.Layout_Business_Linking_Full R) := TRANSFORM
		  SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
					                                ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		  SELF.dt_last_seen                := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
		  SELF.dt_vendor_first_reported    := ut.EarliestDate(ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported),
					                                ut.EarliestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported));
		  SELF.dt_vendor_last_reported     := ut.LatestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
		  SELF.company_address.prim_range  := IF(L.company_address.prim_range  <> '', L.company_address.prim_range,  R.company_address.prim_range);
			SELF.company_address.predir      := IF(L.company_address.predir      <> '', L.company_address.predir,      R.company_address.predir);
			SELF.company_address.prim_name   := IF(L.company_address.prim_name   <> '', L.company_address.prim_name,   R.company_address.prim_name);
			SELF.company_address.addr_suffix := IF(L.company_address.addr_suffix <> '', L.company_address.addr_suffix, R.company_address.addr_suffix);
			SELF.company_address.postdir     := IF(L.company_address.postdir     <> '', L.company_address.postdir,     R.company_address.postdir);
			SELF.company_address.unit_desig  := IF(L.company_address.unit_desig  <> '', L.company_address.unit_desig,  R.company_address.unit_desig);
			SELF.company_address.sec_range   := IF(L.company_address.sec_range   <> '', L.company_address.sec_range,   R.company_address.sec_range);
			SELF.company_address.p_city_name := IF(L.company_address.p_city_name <> '', L.company_address.p_city_name, R.company_address.p_city_name);
			SELF.company_address.v_city_name := IF(L.company_address.v_city_name <> '', L.company_address.v_city_name, R.company_address.v_city_name);
			SELF.company_address.st          := IF(L.company_address.st          <> '', L.company_address.st,          R.company_address.st);
			SELF.company_address.zip	       := IF(L.company_address.zip         <> '', L.company_address.zip,         R.company_address.zip);
			SELF.company_address.zip4        := IF(L.company_address.zip4        <> '', L.company_address.zip4,        R.company_address.zip4);
			SELF.company_phone               := IF(L.company_phone               <> '', L.company_phone,               R.company_phone);
			SELF.phone_type                  := IF(L.company_phone               <> '', L.phone_type,                  R.phone_type);
			SELF.contact_phone               := IF(L.contact_phone               <> '', L.contact_phone,               R.contact_phone);
		  SELF                             := L;
	  END;
		
    from_MH_dist   := DISTRIBUTE(from_MH_norm,HASH(company_bdid,company_name));
    from_MH_sort   := SORT(from_MH_dist, company_bdid, company_name, company_address.st, 
                           company_address.p_city_name, company_address.zip, company_address.prim_range,
                           company_address.predir, company_address.prim_name, company_address.addr_suffix,
                           company_address.postdir, company_address.unit_desig, contact_name.lname, 
                           contact_name.fname, contact_name.mname, contact_name.name_suffix, 
                           contact_name.title, company_phone, contact_phone, dt_first_seen,
                           LOCAL);
		from_MH_rollup := ROLLUP(from_MH_sort, 
                             LEFT.company_bdid                = RIGHT.company_bdid AND
                             LEFT.company_name                = RIGHT.company_name AND
                             (LEFT.company_address.st = '' OR RIGHT.company_address.st = '' OR
                              LEFT.company_address.st = RIGHT.company_address.st) AND
                             (LEFT.company_address.p_city_name = '' OR RIGHT.company_address.p_city_name = '' OR
                              LEFT.company_address.p_city_name = RIGHT.company_address.p_city_name) AND
                             (LEFT.company_address.v_city_name = '' OR RIGHT.company_address.v_city_name = '' OR
                              LEFT.company_address.v_city_name = RIGHT.company_address.v_city_name) AND
                             (LEFT.company_address.zip = '' OR RIGHT.company_address.zip = '' OR
                              LEFT.company_address.zip = RIGHT.company_address.zip) AND
                             (LEFT.company_address.prim_range = '' OR RIGHT.company_address.prim_range = '' OR
                              LEFT.company_address.prim_range = RIGHT.company_address.prim_range) AND
                             (LEFT.company_address.predir = '' OR RIGHT.company_address.predir = '' OR
                              LEFT.company_address.predir = RIGHT.company_address.predir) AND
                             (LEFT.company_address.prim_name = '' OR RIGHT.company_address.prim_name = '' OR
                              LEFT.company_address.prim_name = RIGHT.company_address.prim_name) AND
                             (LEFT.company_address.addr_suffix = '' OR RIGHT.company_address.addr_suffix = '' OR
                              LEFT.company_address.addr_suffix = RIGHT.company_address.addr_suffix) AND
                             (LEFT.company_address.postdir = '' OR RIGHT.company_address.postdir = '' OR
                              LEFT.company_address.postdir = RIGHT.company_address.postdir) AND
                             (LEFT.company_address.unit_desig = '' OR RIGHT.company_address.unit_desig = '' OR
                              LEFT.company_address.unit_desig = RIGHT.company_address.unit_desig) AND
                             (LEFT.company_phone = '' OR RIGHT.company_phone = '' OR LEFT.company_phone = RIGHT.company_phone) AND
                             LEFT.contact_name.lname          = RIGHT.contact_name.lname AND
                             LEFT.contact_name.fname          = RIGHT.contact_name.fname AND
                             LEFT.contact_name.mname          = RIGHT.contact_name.mname AND
                             LEFT.contact_name.name_suffix    = RIGHT.contact_name.name_suffix AND
                             LEFT.contact_name.title          = RIGHT.contact_name.title AND
                             (LEFT.contact_phone = '' OR RIGHT.contact_phone = '' OR LEFT.contact_phone = RIGHT.contact_phone),
                             RollupMH(LEFT, RIGHT),
                             LOCAL);
    
    //Returning records that have a company name and either an address or phone
		RETURN from_MH_rollup(company_name != '' AND ((company_address.prim_name != '' OR company_address.p_city_name != '' OR
                                                  company_address.v_city_name != '' OR company_address.st != '' OR company_address.zip != '')
							            OR (company_phone != '' OR contact_phone != ''))
                          );
END;
