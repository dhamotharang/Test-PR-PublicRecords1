// =========================================================================================================
// Returns FCC's info from the source file; Used for search/report/subreport
/* TODO: change comments below */
// Assumptions:
//    only most recent records (for any given abi-number) are used;
//    contacts are rolled into child dataset, ordered by title-hierarchy; 
//    in rare cases when records (per contact) have different addresses, address is taken from the
//       "most VIP" contact (actually, all business info is taken from such a record);
//
// Result is penalized;
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT FCC, ut, doxie, codes, suppress, census_data, standard;

OUT_REC := FCC_Services.layouts.ReportSearchShared;
 
EXPORT out_rec GetFCCByID (GROUPED DATASET (FCC_Services.layouts.id) in_ids, String32 appType) := FUNCTION

  // Fetch common info, calculating penalty for every record.
  OUT_REC GetCommonInfo (FCC.key_fcc_seq L) := TRANSFORM
    SELF.name_attention.title := L.attention_title;
    SELF.name_attention.fname := L.attention_fname;
    SELF.name_attention.mname := L.attention_mname;
    SELF.name_attention.lname := L.attention_lname;
    SELF.name_attention.name_suffix := L.attention_name_suffix;
    SELF.name_attention.name_score := L.attention_name_score;

    // address penalty portion is calculated as minimum of addr1 and addr2 addresses penalty;
    addr_penalty := doxie.FN_Tra_Penalty_Addr 
      (L.predir, L.prim_range, L.prim_name, L.addr_suffix,
       L.postdir, L.sec_range, 
       L.v_city_name, L.st, L.zip5, , L.p_city_name);

    SELF.penalt := doxie.FN_Tra_Penalty_Name (L.attention_fname, L.attention_mname, L.attention_lname) +
                   addr_penalty; // + doxie.FN_Tra_Penalty_CName ();

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

    // translations
    SELF.license_type_desc := FCC_Services.MapLicenseType (L.license_type);
    SELF.pending_granted_desc := MAP (
      L.pending_or_granted = 'P' => 'PENDING',
      L.pending_or_granted = 'G' => 'GRANTED',
      '');
    SELF.service_code_desc := FCC_Services.MapServiceCode (L.radio_service_code);
    // get class description
    v3codes := codes.key_codes_v3 (keyed(file_name='FCC'), keyed(field_name='CLASS_OF_STATION'), keyed(field_name2=''), keyed(code='MO'));
    SELF.class_desc := SET (LIMIT (v3codes, 1, KEYED), long_desc)[1];

    SELF.last_change_desc := MAP (
      L.type_of_last_change = 'A' => 'ASSIGNMENT',
      L.type_of_last_change = 'C' => 'CONVERSION',
      L.type_of_last_change = 'D' => 'DUPLICATE',
      L.type_of_last_change = 'E' => 'EXPIRED',
      L.type_of_last_change = 'F' => 'MODIFICATION, ASSIGNMENT, RENEWAL',
      L.type_of_last_change = 'G' => 'ASSIGNMENT, RENEWAL',
      L.type_of_last_change = 'H' => 'MODIFICATION, RENEWAL',
      L.type_of_last_change = 'M' => 'MODIFICATION',
      L.type_of_last_change = 'N' => 'NEW',
      L.type_of_last_change = 'O' => 'OTHER',
      L.type_of_last_change = 'R' => 'RENEWAL FROM 574',
      L.type_of_last_change = 'S' => 'SUPERSEDE',
      L.type_of_last_change = 'T' => 'TRANSFER OF CONTROL',
      L.type_of_last_change = 'U' => 'RENEWAL FROM FORM 574R OR 405A',
      L.type_of_last_change = 'W' => 'WITHDRAWN',
      L.type_of_last_change = 'X' => 'REINSTATEMENT',
      L.type_of_last_change = 'Z' => 'CHANGE OF NAME OR MAILING ADDRESS',
      '');

    SELF := L;
  END;

  fetched := JOIN (in_ids, FCC.key_fcc_seq,
                   keyed (Left.fcc_seq = Right.fcc_seq),
                   GetCommonInfo (Right),
                   KEEP (1)); //

  fetched_srt := SORT (fetched,      callsign_of_license, licensees_name, 
                                     name_attention.lname, name_attention.lname, name_attention.mname, 
                                     address,
                                     licensees_phone); 
  fetched_ddp := DEDUP (fetched_srt, callsign_of_license, licensees_name, 
  // cannot use named layouts in dedup...
                                     name_attention.lname, name_attention.lname, name_attention.mname,
                                     address.prim_range, address.predir, address.prim_name, address.addr_suffix,
                                     address.postdir, address.unit_desig, address.sec_range, address.p_city_name,
                                     address.v_city_name, address.st, address.zip5, address.zip4,
                                     licensees_phone); 
//RECORD, except fcc_seq, ALL);
  // pull DIDs
	Suppress.MAC_Suppress(fetched_ddp,did_pulled,appType,Suppress.Constants.LinkTypes.DID,attention_did);

  // add county name
  census_data.MAC_Fips2County_Keyed (did_pulled, address.st, address.fips_county, address.county, ds_cnty);

  res := ds_cnty;
  RETURN res;
END;