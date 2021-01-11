// =========================================================================================================
// Returns OSHAIR's info from the source file; Used for search/report/subreport
// TODO: change comments below
// Assumptions:
//    only most recent records (for any given abi-number) are used;
//    contacts are rolled into child dataset, ordered by title-hierarchy;
//    in rare cases when records (per contact) have different addresses, address is taken from the
//       "most VIP" contact (actually, all business info is taken from such a record);
//
// Result is penalized;
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT OSHAIR_Services, ut, doxie, dx_OSHAIR, codes, suppress, census_data, standard;

OUT_REC := OSHAIR_Services.layouts.ReportSearchShared;

EXPORT out_rec GetOshairByID (GROUPED DATASET (OSHAIR_Services.layouts.id) in_ids) := FUNCTION

  doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

  // choose best match (for penalties) between postal/vicinity cities
  GetBestCity (string25 vcity, string25 pcity) := MAP (
    vcity = '' => pcity,
    pcity = '' => vcity,
    ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
  );

  // Fetch common info, calculating penalty for every record.
  OUT_REC GetCommonInfo (dx_OSHAIR.key_payload_inspection L) := TRANSFORM
    // As of now activity number is considered always to be an integer, represented by 10-chars string,
    // padded with leading zeros, if needed, so that "12345", "012345" and "0000012345" are the same.
    // TODO: consider creating field with other name (different types)
    SELF.activity_number := INTFORMAT (L.activity_number, 10, 1);
    SELF.report_id := L.Region_Code + L.Area_Code + L.Office_Code;

    // address penalty portion is calculated as minimum of addr1 and addr2 addresses penalty;
    addr_penalty := doxie.FN_Tra_Penalty_Addr
      (L.predir, L.prim_range, L.prim_name, L.addr_suffix,
       L.postdir, L.sec_range,
       GetBestCity (L.v_city_name, L.p_city_name),
       L.st, L.zip5);

		cname_penalty := doxie.FN_Tra_Penalty_Cname(L.cname);

    SELF.penalt := addr_penalty + cname_penalty;

    SELF.address.prim_range := l.prim_range;
    SELF.address.predir := l.predir;
    SELF.address.prim_name := l.prim_name;
    SELF.address.addr_suffix := l.addr_suffix;
    SELF.address.postdir := l.postdir;
    SELF.address.unit_desig := l.unit_desig;
    SELF.address.sec_range := l.sec_range;
    SELF.address.p_city_name := l.p_city_name;
    SELF.address.v_city_name := l.v_city_name;
    SELF.address.st := l.st;
    SELF.address.zip5 := l.zip5;
    SELF.address.zip4 := l.zip4;
    SELF.address.fips_state := l.fips_state;
    SELF.address.fips_county := l.fips_county;
    SELF.address.addr_rec_type := l.addr_rec_type;

    // set state
    SELF.address.state := stringlib.StringToUpperCase (codes.general.state_long (L.st));
    // county full name calculated after
    SELF.address.county := '';

    // Codes and descriptions
    SELF.industry_codes.DUNS_Number := L.DUNS_Number;
    SELF.industry_codes.sic_code    := L.sic_code;
    SELF.industry_codes.secondary_sic := L.SIC_Guide;

    sic_codes_set := [INTFORMAT (L.sic_code, 4, 1), INTFORMAT (L.SIC_Guide, 4, 1)];
    sic_codes := SET (LIMIT (codes.Key_SIC4 (sic4_code IN sic_codes_set), 2, skip), sic4_description);
    SELF.industry_codes.sic_code_desc      := sic_codes[1];
    SELF.industry_codes.secondary_sic_desc := sic_codes[2];

    naics_codes := DATASET ([{'primary', L.NAICS_Code}, {'secondary', L.NAICS_Secondary_Code}, {'inspected', L.NAIC_Inspected}],
                             layouts.naics_codes);
    naics_codes_descript := JOIN (naics_codes ((integer) code != 0), codes.Key_NAICS,
                                  keyed (Left.code = Right.naics_code),
                                  transform (layouts.naics_codes, Self.description := Right.naics_description, Self := Left),
                                  ATMOST (1));
    SELF.industry_codes.naics := naics_codes_descript;

    SELF := L;
  END;

  src_fetched := JOIN (in_ids, dx_OSHAIR.key_payload_inspection,
                   keyed (Left.activity_number = Right.activity_number),
                   GetCommonInfo (Right),
                   KEEP (100)); //

  fetched := src_fetched;
  // add county name
  census_data.MAC_Fips2County_Keyed (fetched, address.st, address.fips_county, address.county, ds_cnty);

  res := ds_cnty;
  RETURN res;
END;
