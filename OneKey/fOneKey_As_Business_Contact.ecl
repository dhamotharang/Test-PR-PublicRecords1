IMPORT Business_Header, ut, Address, OneKey;

EXPORT fOneKey_As_Business_Contact(DATASET(OneKey.Layouts.Base) pBaseFile = OneKey.Files().Base.qa) := FUNCTION

  /*//////////////////////////////////////////////////////////////////////
  // -- Convert Base File to Business Contact format
  /////////////////////////////////////////////////////////////////////*/
  Business_Header.Layout_Business_Contact_Full_New t2BusContactFormat(pBaseFile pInput, INTEGER CTR) := TRANSFORM, SKIP(CTR=2 AND (pInput.dba_nm = '' OR pInput.dba_nm = pInput.bus_nm))
    SELF.bdid                          := pInput.bdid;  // LN Risk Business Identifier
    SELF.did                           := 0;  // DID from Headers
    SELF.contact_score                 := IF(TRIM(pInput.fname + pInput.mname + pInput.lname, ALL) = '', 0, 1); 
    SELF.vendor_id                     := pInput.ska_id;  // Vendor key
    SELF.dt_first_seen                 := pInput.dt_vendor_first_reported;  // Historically this was populated with process date
    SELF.dt_last_seen                  := IF(pInput.cleaned_deactv_dt != '', (UNSIGNED4)pInput.cleaned_deactv_dt, pInput.dt_vendor_last_reported);
    SELF.source                        := pInput.source;  // Source file type
    SELF.record_type                   := 'C';  // Historically this has been populated as 'C'urrent
    SELF.from_hdr                      := 'N';  // 'Y' if contact is from address match with person headers.
    SELF.glb                           := FALSE;  // GLB restricted record (only possible for contacts pulled from header)
    SELF.dppa                          := FALSE;  // DPPA restricted record
    SELF.company_title                 := pInput.titl_typ_desc;  // Title of Contact at Company if available
    SELF.company_department            := pInput.prim_prfsn_desc;
    SELF.title                         := pInput.title;
    SELF.fname                         := pInput.fname;
    SELF.mname                         := pInput.mname;
    SELF.lname                         := pInput.lname;
    SELF.name_suffix                   := pInput.name_suffix;
    SELF.name_score                    := Business_Header.CleanName(SELF.fname, SELF.mname, SELF.lname, SELF.name_suffix)[142];
    SELF.prim_range                    := pInput.prim_range;       // Historically this has been populated with company address from data
    SELF.predir                        := pInput.predir;           // Historically this has been populated with company address from data
    SELF.prim_name                     := pInput.prim_name;        // Historically this has been populated with company address from data
    SELF.addr_suffix                   := pInput.addr_suffix;      // Historically this has been populated with company address from data
    SELF.postdir                       := pInput.postdir;          // Historically this has been populated with company address from data
    SELF.unit_desig                    := pInput.unit_desig;       // Historically this has been populated with company address from data
    SELF.sec_range                     := pInput.sec_range;        // Historically this has been populated with company address from data
    SELF.city                          := pInput.v_city_name;      // Historically this has been populated with company address from data
    SELF.state                         := pInput.st;               // Historically this has been populated with company address from data
    SELF.zip                           := (UNSIGNED3)pInput.zip;   // Historically this has been populated with company address from data
    SELF.zip4                          := (UNSIGNED2)pInput.zip4;  // Historically this has been populated with company address from data
    SELF.county                        := pInput.fips_county;      // Historically this has been populated with company address from data
    SELF.msa                           := pInput.msa;              // Historically this has been populated with company address from data
    SELF.geo_lat                       := pInput.geo_lat;          // Historically this has been populated with company address from data
    SELF.geo_long                      := pInput.geo_long;         // Historically this has been populated with company address from data
    SELF.phone                         := (UNSIGNED6)(pInput.Clean_Phone);  // Historically populated with company phone
    SELF.email_address                 := '';
    SELF.ssn                           := 0;
    SELF.company_source_group          := '';
    SELF.company_name                  := CHOOSE(CTR, pInput.bus_nm, pInput.dba_nm);
    SELF.company_prim_range            := pInput.prim_range;
    SELF.company_predir                := pInput.predir;
    SELF.company_prim_name             := pInput.prim_name;
    SELF.company_addr_suffix           := pInput.addr_suffix;
    SELF.company_postdir               := pInput.postdir;
    SELF.company_unit_desig            := pInput.unit_desig;
    SELF.company_sec_range             := pInput.sec_range;
    SELF.company_city                  := pInput.v_city_name;
    SELF.company_state                 := pInput.st;
    SELF.company_zip                   := (UNSIGNED3)pInput.zip;
    SELF.company_zip4                  := (UNSIGNED2)pInput.zip4;
    SELF.company_phone                 := (UNSIGNED6)(pInput.Clean_Phone);
    SELF.company_fein                  := 0;
    SELF.vl_id                         := TRIM(pInput.hcp_affil_xid);  // Vendor linking Identifier
    SELF.RawAID                        := pInput.raw_aid;  // Used for Address_id
    SELF.global_sid                    := 0;
    SELF.record_sid                    := 0;
    SELF                               := pInput;
    SELF                               := [];
   END;

	dOneKeyAsContactHdr := NORMALIZE(pBaseFile, 2, t2BusContactFormat(LEFT, COUNTER));

  /*//////////////////////////////////////////////////////////////////////
  // -- Rollup records to eliminate duplicates
  /////////////////////////////////////////////////////////////////////*/
  Business_Header.Layout_Business_Contact_Full_New RollupBC(dOneKeyAsContactHdr L, dOneKeyAsContactHdr R) := TRANSFORM
    SELF.bdid                        := IF(L.bdid = 0, R.bdid, L.bdid);
    SELF.did                         := IF(L.did = 0, R.did, L.did);
    SELF.contact_score               := IF(L.contact_score = 0, R.contact_score, L.contact_score); 
    SELF.vendor_id                   := IF(L.vendor_id = '', R.vendor_id, L.vendor_id);
    SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
                                                        ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen                := MAX(L.dt_last_seen,R.dt_last_seen);    
    SELF.source                      := IF(L.source = '', R.source, L.source);
    SELF.record_type                 := IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
    SELF.from_hdr                    := IF(L.from_hdr = 'Y' OR R.from_hdr = 'Y', 'Y', 'N');
    SELF.glb                         := IF(L.glb = TRUE OR R.glb = TRUE, TRUE, FALSE);
    SELF.dppa                        := IF(L.dppa = TRUE OR R.dppa = TRUE, TRUE, FALSE);
    SELF.company_title               := IF(L.company_title = '', R.company_title, L.company_title);
    SELF.company_department          := IF(L.company_department = '', R.company_department, L.company_department);
    SELF.title                       := IF(L.title = '', R.title, L.title);
    SELF.fname                       := IF(L.fname = '', R.fname, L.fname);
    SELF.mname                       := IF(L.mname = '', R.mname, L.mname);
    SELF.lname                       := IF(L.lname = '', R.lname, L.lname);    
    SELF.name_suffix                 := IF(L.name_suffix = '', R.name_suffix, L.name_suffix);
    SELF.name_score                  := IF(L.name_score = '', R.name_score, L.name_score);
    SELF.prim_range                  := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.prim_range, L.prim_range);
    SELF.predir                      := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.predir, L.predir);
    SELF.prim_name                   := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.prim_name, L.prim_name);
    SELF.addr_suffix                 := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.addr_suffix, L.addr_suffix);
    SELF.postdir                     := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.postdir, L.postdir);
    SELF.unit_desig                  := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.unit_desig, L.unit_desig);
    SELF.sec_range                   := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.sec_range, L.sec_range);
    SELF.city                        := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.city, L.city);
    SELF.state                       := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.state, L.state);
    SELF.zip                         := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.zip, L.zip);
    SELF.zip4                        := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.zip4, L.zip4);
    SELF.county                      := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.county, L.county);
    SELF.msa                         := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.msa, L.msa);
    SELF.geo_lat                     := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.geo_lat, L.geo_lat);
    SELF.geo_long                    := IF(L.city = '' OR L.state = '' OR L.zip = 0, R.geo_long, L.geo_long);
    SELF.phone                       := IF(L.phone = 0, R.phone, L.phone);
    SELF.email_address               := IF(L.email_address = '', R.email_address, L.email_address);
    SELF.ssn                         := IF(L.ssn = 0, R.ssn, L.ssn);
    SELF.company_source_group        := IF(L.company_source_group = '', R.company_source_group, L.company_source_group);
    SELF.company_name                := IF(L.company_name = '', R.company_name, L.company_name);
    SELF.company_prim_range          := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_prim_range, L.company_prim_range);
    SELF.company_predir              := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_predir, L.company_predir);
    SELF.company_prim_name           := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_prim_name, L.company_prim_name);
    SELF.company_addr_suffix         := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_addr_suffix, L.company_addr_suffix);
    SELF.company_postdir             := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_postdir, L.company_postdir);
    SELF.company_unit_desig          := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_unit_desig, L.company_unit_desig);
    SELF.company_sec_range           := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_sec_range, L.company_sec_range);
    SELF.company_city                := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_city, L.company_city);
    SELF.company_state               := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_state, L.company_state);
    SELF.company_zip                 := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_zip, L.company_zip);
    SELF.company_zip4                := IF(L.company_city = '' OR L.company_state = '' OR L.company_zip = 0, R.company_zip4, L.company_zip4);
    SELF.company_phone               := IF(L.company_phone = 0, R.company_phone, L.company_phone);
    SELF.company_fein                := IF(L.company_fein = 0, R.company_fein, L.company_fein);
    SELF.vl_id                       := IF(L.vl_id = '', R.vl_id, L.vl_id);
    SELF.RawAID                      := IF(L.RawAID = 0, R.RawAID, L.RawAID);
    SELF.global_sid                  := IF(L.global_sid = 0, R.global_sid, L.global_sid);
    SELF.record_sid                  := IF(L.record_sid = 0, R.record_sid, L.record_sid);
    SELF                             := L;
	END;
  
  dOneKey_Clean_Dist_Sort := SORT(DISTRIBUTE(dOneKeyAsContactHdr, HASH(vl_id)),
                                  vl_id, vendor_id, company_name, company_phone, RawAID, -dt_last_seen, LOCAL);

  dOneKey_Rollup := ROLLUP(dOneKey_Clean_Dist_Sort,
                           LEFT.vl_id = RIGHT.vl_id AND
                           LEFT.vendor_id = RIGHT.vendor_id AND
                           LEFT.company_name = RIGHT.company_name AND
                          (RIGHT.company_phone = 0 OR LEFT.company_phone = RIGHT.company_phone) AND
                           LEFT.RawAID = RIGHT.RawAID,
                           RollupBC(LEFT, RIGHT),
                           LOCAL); 
            
  RETURN dOneKey_Rollup;
  
END;
