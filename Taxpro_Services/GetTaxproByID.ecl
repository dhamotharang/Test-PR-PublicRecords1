// =========================================================================================================
// Returns TAXPRO's info from the source file; Used for search/report/subreport
// TODO: change comments below
// Assumptions: (none)
// Result is penalized;
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT TAXPRO, ut, doxie, codes, census_data, STD, TAXPRO_Services;

OUT_REC := TAXPRO_Services.layouts.Layout_Common;
 
EXPORT out_rec GetTaxproByID (GROUPED DATASET (TAXPRO_Services.layouts.id) in_ids) := FUNCTION

  doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

  // choose best match (for penalties) between postal/vicinity cities
  GetBestCity (STRING25 vcity, STRING25 pcity) := MAP (
    vcity = '' => pcity,
    pcity = '' => vcity,
    ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
  );

  // Fetch common info, calculating penalty for every record.
  OUT_REC GetCommonInfo (TAXPRO.Key_tmsid L) := TRANSFORM
    SELF.tmsid := L.tmsid;

    // note: input Country is not penalized
    SELF.penalt := 
      doxie.FN_Tra_Penalty_Name (L.name.fname, L.name.mname, L.name.lname) +
      doxie.FN_Tra_Penalty_Addr (L.addr.predir, L.addr.prim_range, L.addr.prim_name, L.addr.addr_suffix,
                                L.addr.postdir, L.addr.sec_range,
                                GetBestCity (L.addr.v_city_name, L.addr.p_city_name),
                                L.addr.st, L.addr.zip5) +
      doxie.FN_Tra_Penalty_CName (L.company);

    // see if address is a foreign one, in which case cleaned address is not valid.
    // assumptions: US has state field always populated, Canada at least sometimes, others - don't.
    cntry := TRIM (L.country);
    stt := TRIM (L.state);
    BOOLEAN IsForeign := ((cntry != '') AND (cntry != 'UNITED STATES')) OR (stt = '');
    SELF.is_foreign := IsForeign;

    SELF.address := IF (~IsForeign, L.addr);

    // set state
    SELF.address.state := IF (IsForeign, '', codes.general.state_long (L.addr.st));
    // county full name calculated after
    SELF.address.county := '';

    // clean owner name
    SELF.name := L.name;

    SELF := L;
  END;

  fetched := JOIN (in_ids, TAXPRO.Key_tmsid,
    KEYED (LEFT.tmsid = RIGHT.tmsid),
    GetCommonInfo (RIGHT),
    KEEP (1)); // 1:1 relation

  // add county name
  census_data.MAC_Fips2County_Keyed (fetched, address.st, address.fips_county, address.county, ds_cnty);

  // filter by input country name (can be done in join above, but easier to read here, and join is 1:1)
  STRING30 country_val := '' : STORED('Country');
  STRING30 country_value := STD.STR.ToUpperCase (country_val);

  res := ds_cnty ((country_value = '') OR (country = country_value));

  RETURN res;
END;
