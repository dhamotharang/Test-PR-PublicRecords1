import autokey,utilfile,doxie_raw,Census_Data, ut, data_services;

export Fetch_Utility_Daily(
  Dataset(doxie.layout_references_hh) indids = dataset([], doxie.layout_references_hh),
  doxie.IDataAccess mod_access,
  boolean allow_wildcard = false,
  set of STRING1 autokey_skipset=[],
  boolean ApplyBpsFilter = false) := 
FUNCTION

//***** SEARCH AUTOKEYS

Doxie_Raw.Layout_Utility_Raw get_ut(UtilFile.Key_Util_Daily_FDID ri) :=
TRANSFORM
  SELF.county := ri.county;
  SELF := ri;
  SELF.county_name := '';
  SELF.includedByHHID := false;
END;
skipset := ['-'] + autokey_skipset;
fake_fetch := JOIN(autokey.get_dids(data_services.foreign_prod+'thor_data400::key::utility::daily.',skipset,false),
                   UtilFile.Key_Util_Daily_FDID, keyed(left.did=right.fdid) and 
                   (not ApplyBpsFilter or doxie.bpssearch_filter.rec_OK(
                        right.ssn, right.lname,right.fname,right.mname,
                        right.prim_range,right.prim_name,right.addr_suffix,
                        right.sec_range,right.v_city_name,right.zip,
                        right.phone,'',(integer4)right.dob)), 
                   get_ut(right),
                   KEEP(ut.limits.HEADER_PER_DID));


//***** FETCH BASED ON DID

Doxie_Raw.Layout_Utility_Raw get_ut2(layout_references_hh le, doxie_Raw.Layout_Utility_Raw ri) :=
TRANSFORM
  SELF.includedByHHID := le.includedByHHID;
  SELF.county := ri.county;
  SELF.county_name := '';
  SELF := ri;
END;
         
dids := indids;
fromdids := Doxie_Raw.Util_Daily_Raw(dids,mod_access,ApplyBpsFilter);
did_fetch := JOIN(dids, fromdids,
                  (unsigned)left.did = (unsigned)right.did,
                  get_ut2(left, right));

all_fetched := DEDUP(SORT(did_fetch+fake_fetch,record),record);

Census_Data.MAC_Fips2County_Keyed(all_fetched,st,county,county_name,countied)

glb_ok := mod_access.isValidGLB ();

return IF(~mod_access.isUtility() and glb_ok, countied);

END;