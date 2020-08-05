IMPORT AutoStandardI, doxie, doxie_crs, doxie_raw, ut, risk_indicators;

rec_hri := record
  string10 phone;
  string20 lname;
  string10 prim_range;
  string30 prim_name;
  string2  st;
  string5  zip;
  string10 sec_range;
  string2  predir;
  DATASET(risk_indicators.layout_desc) hri_phone {maxcount (ut.limits.HRI_MAX)} := dataset ([], risk_indicators.layout_desc);
	unsigned8  rawaid := 0; 
end;

// (private) macro to append pre-fetched HRIs
MAC_ReappendPhoneHRI (ds_in, ds_hri, ds_out, rec) := MACRO
  ds_out := join (ds_in, ds_hri, 
                  left.phone = right.phone and
                  left.lname = right.lname and
                  left.prim_range = right.prim_range and
                  left.prim_name = right.prim_name and
                  left.zip = right.zip and
                  left.sec_range = right.sec_range and
                  left.predir = right.predir,
                  transform (rec, self.hri_phone := right.hri_phone, self := left),
                  left outer, keep(1));
ENDMACRO;

// could be just one single integer, passing both seems a little cleaner
EXPORT COMP_PHONES (boolean include_hri = false, integer maxHriPer_value = 0,  boolean IncludePhoneMetadata = false) := MODULE
  // want to mirror the strict match on sec_range to be consistent with header search/append
  shared phones_wide := doxie.fn_phone_records_wide (doxie.Comp_Addresses, true);

  // suject's phones from header file: needed for "old phones"
  dsHeader_reg := doxie.Comp_Subject_Addresses_wrap.raw ((integer) phone > 0);
  doxie_raw.MAC_ENTRP_CLEAN(dsheader_reg,dt_last_seen,dsheader_entrp);
  shared phones_header := IF(ut.IndustryClass.is_entrp,dsHeader_entrp,dsHeader_reg);

  phone_addr_src := project (phones_wide, rec_hri);
  phone_hdr_src := project (phones_header, rec_hri);
  phone_all := dedup (phone_addr_src + phone_hdr_src, all);
	
  global_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

  // attach phones High Risk Indicators to all phones at once
  doxie.mac_AddHRIPhone (phone_all, shared phones_hri, mod_access);
	
	// pick HRIs for phones-by-address
  MAC_ReappendPhoneHRI (phones_wide, phones_hri, phones_wide_hri, doxie.Layout_AddPhoneMetadata);
  shared phones_hri_recs := if (include_hri, 
                              phones_wide_hri, 
                              project (phones_wide, transform (doxie.Layout_AddPhoneMetadata, self.hri_phone := [], self := left)));
	
	phone_all_recs := doxie.fn_AddPhoneMetadata(phones_hri_recs, '');
		
  // check if name "current" is accurately represents the semantics
  EXPORT CURRENT := if (IncludePhoneMetadata, 
                       phone_all_recs,  
         							 project (phones_hri_recs, 
         							 transform (doxie_crs.layout_phone_records, self.phonetype := [], self.dt_first_seen := [], self.dt_last_seen := [], self := left)));

  // ----------------------------- Old phones -----------------------------
  rec_old := doxie_crs.layout_phones_old;
  phones_header_old := phones_header (phone not in set (phones_wide, phone));

  // attach phones High Risk Indicators
  MAC_ReappendPhoneHRI (phones_header_old, phones_hri, phones_old_hri, rec_old);
  phones_old_w_hri := if (include_hri,
                          phones_old_hri,
                          project (phones_header_old, transform (doxie_crs.layout_phones_old, self.hri_phone := [], self := left)));


  // rollup to fill-in the earliest first-seen date
  phones_old_srt := sort (phones_old_w_hri, did, phone, -dt_last_seen, -dt_first_seen);
    
  doxie_crs.layout_phones_old roll_them (rec_old l, rec_old r) := transform
    self.dt_first_seen := if ((r.dt_first_seen <> 0) and 
            ((l.dt_first_seen = 0) or (r.dt_first_seen < l.dt_first_seen)),
             r.dt_first_seen, l.dt_first_seen);
    self := l;
  end;  
  phones_old_roll := rollup(phones_old_srt, roll_them(left, right), did,phone);

  ut.getTimeZone (phones_old_roll, phone, timezone, phones_old_w_tzone);

  EXPORT OLD := phones_old_w_tzone;

END;
