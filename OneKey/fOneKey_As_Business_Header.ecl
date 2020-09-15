IMPORT Business_Header, ut, OneKey;

EXPORT fOneKey_As_Business_Header(DATASET(OneKey.Layouts.base) pBaseFile = OneKey.Files().Base.qa) := FUNCTION

  /*//////////////////////////////////////////////////////////////////////
  // -- Convert Base File to Business Header format
  /////////////////////////////////////////////////////////////////////*/
  Business_Header.Layout_Business_Header_New t2BusHeaderFormat(pBaseFile pInput, INTEGER CTR) := TRANSFORM, SKIP(CTR=2 AND (pInput.dba_nm = '' OR pInput.dba_nm = pInput.bus_nm))
    SELF.rcid                          := 0;
    SELF.bdid                          := pInput.bdid;  // LN Risk Business Identifier
    SELF.source                        := pInput.source;  // Source file type
    SELF.source_group                  := '';  // Source group identifier for merging of records only within source and group
    SELF.pflag                         := '';  // Internal processing flags
    SELF.group1_id                     := 0;  // Group identifier (temporary) for matching groups of records pre-linked
    SELF.vendor_id                     := pInput.ska_id;  // Vendor key
    SELF.dt_first_seen                 := pInput.dt_vendor_first_reported;  // Historically this has been populated with process date
    SELF.dt_last_seen                  := IF(pInput.cleaned_deactv_dt != '', (UNSIGNED4)pInput.cleaned_deactv_dt,  pInput.dt_vendor_last_reported);
    SELF.dt_vendor_last_reported       := pInput.dt_vendor_last_reported;
    SELF.dt_vendor_first_reported      := pInput.dt_vendor_first_reported;
    SELF.company_name                  := CHOOSE(CTR, pInput.bus_nm, pInput.dba_nm);
    SELF.prim_range                    := pInput.prim_range;
    SELF.predir                        := pInput.predir;
    SELF.prim_name                     := pInput.prim_name;
    SELF.addr_suffix                   := pInput.addr_suffix;
    SELF.postdir                       := pInput.postdir;
    SELF.unit_desig                    := pInput.unit_desig;
    SELF.sec_range                     := pInput.sec_range;
    SELF.city                          := pInput.v_city_name;
    SELF.state                         := pInput.st;
    SELF.zip                           := (UNSIGNED3)pInput.zip;
    SELF.zip4                          := (UNSIGNED2)pInput.zip4;
    SELF.county                        := pInput.fips_county;
    SELF.msa                           := pInput.msa;
    SELF.geo_lat                       := pInput.geo_lat;
    SELF.geo_long                      := pInput.geo_long;
    SELF.phone                         := (UNSIGNED6)pInput.Clean_Phone;
    SELF.phone_score                   := IF(SELF.phone = 0, 0, 1);
    SELF.fein                          := 0;
    SELF.current                       := IF(pInput.record_type = 'C', TRUE, FALSE);
    SELF.dppa                          := FALSE;
    SELF.vl_id                         := TRIM(pInput.hcp_affil_xid);  // Vendor linking Identifier
    SELF.RawAID                        := pInput.raw_aid;  // Used for Address_id
    SELF                               := pInput;
    SELF                               := [];
   END;

	dOneKeyAsBusHdr := NORMALIZE(pBaseFile, 2, t2BusHeaderFormat(LEFT, COUNTER));

  /*//////////////////////////////////////////////////////////////////////
  // -- Rollup records to eliminate duplicates
  /////////////////////////////////////////////////////////////////////*/
  Business_Header.Layout_Business_Header_New tRollupBH(dOneKeyAsBusHdr L, dOneKeyAsBusHdr R) := TRANSFORM
    SELF.rcid                        := IF(L.rcid = 0, R.rcid, L.rcid);
    SELF.bdid                        := IF(L.bdid = 0, R.bdid, L.bdid);
    SELF.source                      := IF(L.source = '', R.source, L.source);
    SELF.source_group                := IF(L.source_group = '', R.source_group, L.source_group);
    SELF.pflag                       := IF(L.pflag = '', R.pflag, L.pflag);
    SELF.group1_id                   := IF(L.group1_id = 0, R.group1_id, L.group1_id);
    SELF.vendor_id                   := IF(L.vendor_id = '', R.vendor_id, L.vendor_id);
    SELF.dt_first_seen               := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen),
                                                        ut.EarliestDate(L.dt_last_seen, R.dt_last_seen));
    SELF.dt_last_seen                := MAX(L.dt_last_seen,R.dt_last_seen);
    SELF.dt_vendor_last_reported     := MAX(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
    SELF.dt_vendor_first_reported    := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.company_name                := IF(L.company_name = '', R.company_name, L.company_name);
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
    SELF.phone_score                 := IF(L.phone = 0, R.phone_score, L.phone_score);
    SELF.fein                        := IF(L.fein = 0, R.fein, L.fein);
    SELF.current                     := IF(L.current = TRUE OR R.current = TRUE, TRUE, FALSE);
    SELF.dppa                        := IF(L.dppa = TRUE OR R.dppa = TRUE, TRUE, FALSE);
    SELF.vl_id                       := IF(L.vl_id = '', R.vl_id, L.vl_id);
    SELF.RawAID                      := IF(L.RawAID = 0, R.RawAID, L.RawAID);
    SELF                             := L;
	END;
  
  dOneKey_Clean_Dist_Sort := SORT(DISTRIBUTE(dOneKeyAsBusHdr, HASH(vl_id)), 
                                  vl_id, vendor_id, company_name, phone, RawAID, -dt_vendor_last_reported, LOCAL);

  dOneKey_Rollup := ROLLUP(dOneKey_Clean_Dist_Sort,
                           LEFT.vl_id = RIGHT.vl_id AND
                           LEFT.vendor_id = RIGHT.vendor_id AND
                           LEFT.company_name = RIGHT.company_name AND
                          (RIGHT.phone = 0 OR LEFT.phone = RIGHT.phone) AND
                           LEFT.RawAID = RIGHT.RawAID,
                           tRollupBH(LEFT, RIGHT),
                           LOCAL); 
            
  RETURN dOneKey_Rollup;
  
END;
