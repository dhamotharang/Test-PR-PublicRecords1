// =========================================================================================================
// Returns USABIZ's info from the source file; Used for search/report/subreport
// Assumptions:
//    only most recent records (for any given abi-number) are used;
//    contacts are rolled into child dataset, ordered by title-hierarchy; 
//    in rare cases when records (per contact) have different addresses, address is taken from the
//       "most VIP" contact (actually, all business info is taken from such a record);
//
// Result is penalized;
// The output layout is shared among subreport and search views (it's a little larger than any one of those)
// =========================================================================================================

IMPORT InfoUSA, UsabizV2_Services, ut, doxie, codes, suppress, census_data, standard;

OUT_REC := UsabizV2_Services.layouts.ReportSearchShared;
 
EXPORT out_rec GetUsabizByID (GROUPED DATASET (UsabizV2_Services.layouts.id) in_ids) := FUNCTION

  doxie.MAC_Header_Field_Declare (); // unfortunately: only to get input city name! Should be gone after interfaces are done

  // choose best match (for penalties) between postal/vicinity cities
  GetBestCity (string25 vcity, string25 pcity) := MAP (
    vcity = '' => pcity, 
    pcity = '' => vcity,
    ut.StringSimilar (vcity, city_value) <= ut.StringSimilar (pcity, city_value) => vcity, pcity
  );

  // fetch franchise description (up to 6 different values)
  fr_rec := UsabizV2_Services.layouts.layout_franchise;
  GetFranchise (string scode, string fr_code) := FUNCTION
    set of string1 fr_codes := [fr_code[1], fr_code[2], fr_code[3], fr_code[4], fr_code[5], fr_code[6]];
    key_read := InfoUSA.Key_ABIUS_FranCode (keyed (sic_code = scode), keyed (franchise_char IN fr_codes));
    franchise := LIMIT (key_read, 6, keyed, SKIP); // up to 6 chars only
    return PROJECT (franchise (description != ''), fr_rec);
  END;


  // Fetch common info, calculating penalty for every record.
  // Later grouped rollup will uses one "main" record (not considering penalty as criteria)
  // for compacting contacts into child dataset, and minimal penalty will be choosed at that time.
  layout_base := RECORD (InfoUSA.Layout_Key_ABius_ABI_Number)
    unsigned2 penalt := 0;
  END;

  layout_base SetPenalty (InfoUSA.Key_ABIUS_abi_number L) := TRANSFORM
    // address penalty portion is calculated as minimum of addr1 and addr2 addresses penalty;
    addr1_penalty := doxie.FN_Tra_Penalty_Addr 
      (L.addr1.predir, L.addr1.prim_range, L.addr1.prim_name, L.addr1.addr_suffix,
       L.addr1.postdir, L.addr1.sec_range, 
       GetBestCity (L.addr1.v_city_name, L.addr1.p_city_name),
       L.addr1.st, L.addr1.zip5);
       // + doxie.FN_Tra_Penalty_County (L.addr1.county); // county is not in the input so far

    addr2_penalty := doxie.FN_Tra_Penalty_Addr 
      (L.addr2.predir, L.addr2.prim_range, L.addr2.prim_name, L.addr2.addr_suffix,
       L.addr2.postdir, L.addr2.sec_range,
       GetBestCity (L.addr2.v_city_name, L.addr2.p_city_name),
       L.addr2.st, L.addr2.zip5);

    SELF.penalt := doxie.FN_Tra_Penalty_Name   (L.name.fname, L.name.mname, L.name.lname) +
                   IF (addr1_penalty <= addr2_penalty, addr1_penalty, addr2_penalty) +
                   doxie.Fn_Tra_Penalty_Phone  (L.phone);
    SELF := L;
  END;

  src_fetched := JOIN (in_ids, InfoUSA.Key_ABIUS_abi_number,
                   keyed (Left.abi_number = Right.abi_number),
                   SetPenalty (Right),
                   KEEP (ut.limits.USABIZ_PER_ABI)); //


  // sort and group by abi_number for further rollup;
  // sorting by process_date and title is important for taking some data from most important record only.
  ds_grp := GROUP (SORT (src_fetched, abi_number, -process_date, CONTACT_TITLE), abi_number);


  OUT_REC RollContacts (layout_base L, DATASET (layout_base) all_records) := TRANSFORM
    SELF.penalt := MIN (all_records, penalt);
    // create secondary SICs descriptions child
    sec_sics := DATASET ([
      {L.SECONDARY_SIC_1, L.secondary_sic_desc1}, {L.SECONDARY_SIC_2, L.secondary_sic_desc2},
      {L.SECONDARY_SIC_3, L.secondary_sic_desc3}, {L.SECONDARY_SIC_4, L.secondary_sic_desc4}
    ], UsabizV2_Services.layouts.layout_secondary_sic) (code != '');
    SELF.SECONDARY_SIC := sec_sics;

    //create franchise descriptions child
    SELF.franchise := GetFranchise (L.sic_cd, L.franchise_cd);

    // set state name
    SELF.addr1.state := codes.general.state_long (L.addr1.st);	
    SELF.addr2.state := codes.general.state_long (L.addr2.st);	

    // county calculated below
    SELF.addr1.county := '';
    SELF.addr2.county := '';

    // Rollup contact info into child dataset (sorting/deduping can be done here, if required)
    USABIZV2_Services.layouts.ContactTranslated GetContactInfo (layout_base LL) := TRANSFORM
      SELF.GENDER_CD := LL.GENDER_CD;
      SELF.gender_exp := codes.GENERAL.gender (stringlib.stringtouppercase (LL.GENDER_CD)[1]);
      SELF.CONTACT_TITLE := LL.CONTACT_TITLE;
      SELF.title_description := USAbizV2_Services.GetContactTitle (LL.contact_title);
      SELF := LL.name;
    END;
      
    // take most recent records only
    SELF.contact := CHOOSEN (PROJECT (all_records ((integer) process_date = (integer) all_records[1].process_date,
                                      name.fname != '' AND name.lname != ''),
                                      GetContactInfo (Left)), ut.limits.USABIZ_CONTACTS_MAX);

    // Get data from "most VIP" record (usually all data is the same (assumingly))

    // blank those fields, if zeros, which makes ESP job easier
    // SELF.SUBSIDIARY_PARENT_NUM := IF ((integer) L.SUBSIDIARY_PARENT_NUM = 0, '', L.SUBSIDIARY_PARENT_NUM);
    // SELF.ULTIMATE_PARENT_NUM := IF ((integer) L.ULTIMATE_PARENT_NUM = 0, '', L.ULTIMATE_PARENT_NUM);
    // TODO: check if the above is done in the key
    SELF := L;
  END;

  fetched := ROLLUP (ds_grp, GROUP, RollContacts (Left, ROWS (Left)));

//TODO: currently we don't have procedures for pulling by bdid and abi_number (can be confused with did/ssn)
  //pull IDs

  // add county name
  census_data.MAC_Fips2County_Keyed (fetched,   addr1.st, addr1.fips_county, addr1.county, ds_cnty_1);
  census_data.MAC_Fips2County_Keyed (ds_cnty_1, addr2.st, addr2.fips_county, addr2.county, ds_cnty_2);

  res := ds_cnty_2;
  RETURN res;
END;