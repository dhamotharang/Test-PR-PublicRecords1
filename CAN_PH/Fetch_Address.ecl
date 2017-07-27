IMPORT ut, doxie, autokey, CanadianPhones,NID;

// !!! compare to autokey.Fetch_Address !!!
EXPORT Fetch_Address (String t, boolean workHard,boolean noFail = true) := FUNCTION

  doxie.MAC_Header_Field_Declare ();

  d := DATASET([], CanadianPhones.layouts.address);
  ind := if (stringlib.stringfind(trim(t),'::qa::',1) > 0,
	           INDEX(d, {d}, TRIM(t)+'address'), INDEX(d, {d}, TRIM(t)+'Address' + '_' + doxie.Version_SuperKey));

  limit_inner := 10000;
  limit_outer := ut.limits.FETCH_LEV2_UNKEYED;

  pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

// Second Lookup bit checks for representative address
isLeadingLnameMatch(string lnv,string lnk) := length(trim(lnv)) >= 3 and lnk[1..length(trim(lnv))] = lnv;
f_exact := PROJECT (ind (
                keyed (prim_name = pname_value),
                keyed (prim_range = prange_value), 
                keyed (state_value=st),
                keyed (city_code in city_codes_set or city_value=''),
                keyed ((can_poscode_value='') or (zip = can_poscode_value)) ,
                keyed (sec_range=sec_range_value or sec_range_value=''),
                keyed (dph_lname=metaphonelib.DMetaPhone1(lname_value) or lname_value='' or AllowLeadingLname_value),
                keyed (lname = lname_value  or lname_value='' or (AllowLeadingLname_value and isLeadingLnameMatch(lname_value,lname))),
                keyed (pfe(pfname,fname_value) or fname_value =''),
                ut.bit_test(lookups, lookup_value),
                ut.bit_test(lookups, lookup_value2)),
           AutoKey.layout_fetch);

f_fuzzy := PROJECT (ind (
                keyed(prim_name=pname_value), 
                keyed((workHard and (prange_value = '' OR addr_loose)) OR prange_value=prim_range),
                keyed(city_code in city_codes_set OR (city_codes_set = [] and workHard) OR (input_city_value = '' and zip_val0 <> '')), //we dont yet do a good job of generating city_codes from zip in canada, so give a pass here if zip entered and city not
                keyed(state_value=st OR (state_value='' and workHard)),
                keyed((can_poscode_value='') or (zip = can_poscode_value)),
                keyed(sec_range_value='' or sec_range_value=sec_range),
                keyed(lname_value='' or dph_lname=metaphonelib.DMetaPhone1(lname_value) or AllowLeadingLname_value),
								keyed(not AllowLeadingLname_value or isLeadingLnameMatch(lname_value,lname)), //we only need to check this field when the dph_lname field got a free pass via AllowLeadingLname_value
                ut.bit_test(lookups, lookup_value),
                ut.bit_test(lookups, lookup_value2)
								),
           AutoKey.layout_fetch);
	   

  boolean addr_search :=	pname_value != ''; 

  Autokey.mac_Limits(f_exact,f_ret_exact)	

  doxie.mac_FetchLimitLimitSkipFail (f_fuzzy, limit_inner, limit_outer, EXISTS (f_ret_exact), 203, false, true, f_ret_fuzzy)

  RETURN IF (addr_search, IF (exists (f_ret_fuzzy), f_ret_fuzzy, f_ret_exact));
END;