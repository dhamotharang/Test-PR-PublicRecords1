/*
  There's basically two mode of operation of this query. There's
  SourceDocView and not SourceDocView, switched by the SourceDocView soapcall
  parameter.
  SourceDocView accepts name, address, and phone number inputs and
  finds all the records in the history by those
  name, address, and phone number inputs. The did and hhid entries of
  the found records are used to find matching did and hhid records.
  The records are scored and returned to the caller.
  Not SourceDocView is used by phone and reverse phone lookup. Phone lookup
  takes name and address information as input , reverse phone takes a phone
  number as input. Records are found using the input information. The dids and
  hhids of the found records are NOT used to find additional records.
  The found records are rolled up by listing name, address, phone number.
  During the rollup, the dt_first_seen and dt_last_seen dates are calculated
  from the duplicate records. The records are scored and returned to the
  caller.

  Inputs
    ZipRadius. Sets search distance from the supplied Zip Code.
    PhoneticMatch. Sets phonetic matching on LastName.
    AllowNickNames. When true, the FirstName may be a nickname.
    MaxResults. Set the maximum number of records returned. This value
      can be smaller but cannot be greater than the default.
    ScoreThreshold. Return only records below this score threshold.

*/
IMPORT Gong_Services;
IMPORT dx_Gong, doxie, Census_Data, ut, Risk_Indicators, LIB_Word, NID, BIPV2, Address, Suppress, STD;

dummydidDS := Dataset([{0}],doxie.layout_references);
EXPORT Fetch_Gong_History (Dataset(doxie.layout_references) indids = dummydidDS,
  Doxie.IDataAccess mod_access,
  boolean noFail=false,
  boolean includeParsedDifferences=false,
  boolean include_HHID_DIDs = false,
  boolean did_onlyL = false,
  boolean SuppressNoncurrent = false,
  boolean AllowLeadingLnameMatch = false,
  boolean AllowFallBack = true,
  boolean AllowBlankFnameMatch = true,
  boolean AllowLooseSecRangeMatch = false,
  boolean AllowLooseSuffixMatch = true,
  unsigned2 RestrictRollupInDays=0,
  boolean UseHigherPenaltyScore = false,
  boolean UseBusinessIds = false)
:= FUNCTION
  //------------------------------------
  // Store off the soap parameters in local attributes.
  //------------------------------------
  doxie.MAC_Header_Field_Declare();

  boolean source_doc_view := false : stored('SourceDocView');
  boolean allow_name_wildcard := false : stored('AllowNameWildCard');
  boolean temp_allow_use_cnkey := false : stored('AllowUseCNkey');
  string40 first_word_val := '' : stored('FirstWord');
  string40 first_word_value := STD.Str.ToUpperCase(first_word_val);
  string40 any_word1_val := '' : stored('AnyWord1');
  string40 any_word1_value := STD.Str.ToUpperCase(any_word1_val);
  string40 any_word2_val := '' : stored('AnyWord2');
  string40 any_word2_value := STD.Str.ToUpperCase(any_word2_val);
  string30 dir_pname_val := '' : stored('PrimName');
  string10 dir_prange_value := '' : stored('PrimRange');
  string200 addr_line1_value := '' : stored('Addr');
  string addr_line2_value := '' : stored('Addr2');

  unsigned8 MaxResultsDefault := 2000;
  allow_use_cnkey := temp_allow_use_cnkey and fname_value = '' and addr_line1_value = '';

  f_int_zip := dataset(zip_value, {integer4 zip});
  f_str_zip := project(f_int_zip, transform({string5 zip},self.zip := intformat(left.zip,5,1)));
  str_zip_set := set(f_str_zip, zip);

  string line1 := trim(addr_line1_value) + ' ' + trim(addr_line2_value);
  string line2 := if(StateCityZip_val = '', city_val + ' ' + state_val + ' ' + zip_val, StateCityZip_val);
  dir_sec_range := Address.CleanAddress182(line1, line2)[57..64];
  dir_pname_value := Address.CleanAddress182(trim(dir_prange_value) + ' ' + trim(dir_pname_val), line2)[13..40];

  sec_range_better := if(sec_range_value<>'', sec_range_value, dir_sec_range);

  dir_prange_wild := STD.Str.Find(dir_prange_value, '*', 1) <> 0;
  dir_prange_range := STD.Str.Find(dir_prange_value, ':', 1) <> 0;
  dir_prange_beg_value := (unsigned)IF(dir_prange_range, dir_prange_value[1..STD.Str.Find(dir_prange_value, ':', 1)-1],'');
  dir_prange_end_value := (unsigned)IF(dir_prange_range, dir_prange_value[STD.Str.Find(dir_prange_value, ':', 1)+1..],'');
  lname_value_better := STD.Str.FilterOut(lname_value, '\'');
  lname_value_ph_better := (string6)metaphonelib.DMetaPhone1(STD.Str.FilterOut(lname_value_better,' '));

  MaxResults_value := if(MaxResults_val > MaxResultsDefault, MaxResultsDefault, MaxResults_val);

  Key_History_phone := dx_Gong.key_history_phone();
  typeof(Key_History_phone.p7) local_phone7 := if(phone_value[8..10]='',
                                                    phone_value[1..7],
                                                    phone_value[4..10]);
  typeof(Key_History_phone.p3) local_area_code := if(phone_value[8..10]='',
                                                          '',
                                                          phone_value[1..3]);

  nullRow := ROW({0,0,0,0,0,0,0},BIPV2.IDlayouts.l_header_ids);

  //--------------------------------------------------------------
  // Get the initial records from the indexes based on input parameters
  //--------------------------------------------------------------
  joinedRecord := Gong_Services.Layout_GongHistorySearchServiceBusinessIds;

  //joinedRecord layout affects final output, this is a temporary layout for suppression compliance.
  joinedRecord_w_compliance := RECORD
    joinedRecord;
    unsigned4 global_sid;
    unsigned4 record_sid;
  END;

  znm := dx_Gong.key_history_zip_name();
  joinedRecord_w_compliance doZipNameProject (znm l) := TRANSFORM,
      SKIP(Gong_Services.MAC_Gong_History_Penalty(l, false)>score_threshold_value)
    SELF.businessIds := nullRow;
    SELF.record_sid := l.record_sid;
    SELF.global_sid := l.global_sid;
    SELF.did := l.did;
    SELF := l;
  END;

  nm := dx_Gong.key_history_name();
  joinedRecord_w_compliance doNameProject (nm l) := TRANSFORM,
      SKIP(Gong_Services.MAC_Gong_History_Penalty(l,false)>score_threshold_value)
    SELF.businessIds := nullRow;
    SELF.record_sid := l.record_sid;
    SELF.global_sid := l.global_sid;
    SELF.did := l.did;
    SELF := l;
  END;

  nm_wild := dx_Gong.key_history_wild_name_zip();
  joinedRecord_w_compliance doWildNameProject (nm_wild l) := TRANSFORM,
      SKIP(Gong_Services.MAC_Gong_History_Penalty(l,false)>score_threshold_value)
    SELF.businessIds := nullRow;
    SELF.record_sid := l.record_sid;
    SELF.global_sid := l.global_sid;
    SELF.did := l.did;
    SELF := l;
  END;

  Key_History_Address := dx_Gong.key_history_address();
  joinedRecord doAddrProject (Key_History_Address l) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF := l;
  END;
  joinedRecord_w_compliance doPhoneProject (Key_History_phone l) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF.record_sid := l.record_sid;
    SELF.global_sid := l.global_sid;
    SELF.did := l.did;
    SELF := l;
  END;

  Key_History_did := dx_Gong.key_history_did();
  joinedRecord doDidProject (Key_History_did l) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF := l;
  END;

  key_history_companyname := dx_Gong.key_history_companyname();
  joinedRecord_w_compliance doCompanyNameProject (key_history_companyname l) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF.record_sid := l.record_sid;
    SELF.global_sid := l.global_sid;
    SELF.did := l.did;
    SELF := l;
  END;

  csnm := dx_Gong.key_history_city_st_name();
  joinedRecord_w_compliance doCityStNameProject (csnm l) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF := l;
  END;

  joinedRecord doDidJoin (Key_History_did r) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF.did := r.l_did;
    SELF := r;
  END;

  Key_History_HHID := dx_gong.key_history_hhid();
  joinedRecord doHHIDJoin (Key_History_HHID r) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF.hhid := r.s_hhid;
    SELF := r;
  END;


  // parse addr1 for use in source doc retrieval
  //parsed_addr1 := IF(addr_value<>'',doxie.CleanAddress182(addr_value,'AAA OH'),'') : global;
  city_upper := STD.Str.ToUpperCase(city_val);
  state_upper := STD.Str.ToUpperCase(state_val);
  // get the records based on name parameters
  pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);

  // --- name search

  phon_fil(i) := MACRO
      ut.phoneticLnameMatch(i.dph_name_last, STD.Str.FilterOut(lname_value_better,' '))
  ENDMACRO;
  lname_fil(i) := MACRO
    i.name_last=lname_value_better or (AllowLeadingLnameMatch and length(trim(lname_value_better)) >= 4 and i.name_last[1..length(trim(lname_value_better))] = lname_value_better)  //allow leading lname match when it is at least 4 characters
  ENDMACRO;
  pfname_fil(i) := MACRO
    (fname_value='' and AllowBlankFnameMatch) OR
    (fname_value<>'' and pfe(i.p_name_first,fname_value))
  ENDMACRO;
  pfname_fil_loose(i) := MACRO
    length(trim(fname_value))<2
    or pfe(i.p_name_first,fname_value)
    or i.p_name_first = (STRING1)fname_value
  ENDMACRO;
  fname_fil(i) := MACRO
    (fname_value='' and AllowBlankFnameMatch) OR
    i.name_first[1..LENGTH(trim(ut.cast2keyfield(i.name_first,fname_value)))]=trim(ut.cast2keyfield(i.name_first,fname_value))
  ENDMACRO;
  fname_fil_loose(i) := MACRO
    (fname_value = '' and AllowBlankFnameMatch)
    or i.name_first[1..length(trim(ut.cast2keyfield(i.name_first,fname_value)))]= trim(ut.cast2keyfield(i.name_first,fname_value))
    or (fname_value<>'' and i.name_first = (STRING1)fname_value)
    or (nicknames AND LENGTH(TRIM(fname_value))>=2)
  ENDMACRO;
  st_fil(i) := MACRO
    state_value='' OR i.st=state_value
  ENDMACRO;

     nm_postfil :=
        (prange_value = ''
            or (source_doc_view and nm.prim_range = prange_value)
            or (not source_doc_view and ut.StringSimilar(nm.prim_range,prange_value)<4 and zip_value = [])
            or (not source_doc_view and zip_value <> [] )
            or (addr_range and (INTEGER)nm.prim_range >= prange_beg_value AND (INTEGER)nm.prim_range <= prange_end_value)
            or (dir_prange_range and (INTEGER)nm.prim_range >= dir_prange_beg_value AND (INTEGER)nm.prim_range <= dir_prange_end_value)
            or (addr_wild and STD.Str.WildMatch(nm.prim_range, prange_wild_value, TRUE))
            or (dir_prange_wild and STD.Str.WildMatch(nm.prim_range, dir_prange_value, TRUE))
            )
        AND (pname_value = ''
            or (source_doc_view and nm.prim_name = pname_val)
            or (not source_doc_view and ut.StringSimilar(nm.prim_name,pname_val)<4 and zip_value = [])
            or (not source_doc_view and ut.StringSimilar(nm.prim_name,pname_value)<4 and zip_value = [])
            or (not source_doc_view and zip_value <> []))
        AND (city_value = '' //or addr_error_value
            or (source_doc_view and ( city_upper = nm.p_city_name or city_upper = nm.v_city_name))
            or (not source_doc_view and (ut.StringSimilar(city_value,nm.p_city_name)<4 or ut.StringSimilar(city_value,nm.v_city_name)<4) and zip_value = [])
            or (not source_doc_view and zip_value <> []))
        AND (AllowLooseSuffixMatch or addr_suffix_value = '' or nm.suffix = addr_suffix_value)
        AND (~SuppressNoncurrent OR nm.current_record_flag<>'');

  nm_filt1 := lname_value_better<>''
              AND keyed(phon_fil(nm))
              AND keyed(lname_fil(nm) or phonetics)
              AND keyed(st_fil(nm))
              AND keyed(pfname_fil(nm) or (nicknames or phonetics) and (nm.p_name_first=fname_value[1]and (fname_value[1] <> '' or AllowBlankFnameMatch)))
              AND keyed(fname_fil(nm) or nicknames or phonetics)
              AND (~nicknames and ~phonetics or pfname_fil_loose(nm))
              AND (~nicknames and ~phonetics or fname_fil_loose(nm))
              AND (~nicknames and ~phonetics or ut.StringSimilar(nm.name_last,lname_value_better)< if(phonetics,6,4))
              AND nm_postfil;

  nm_w_daily(unsigned1 flt_type) := FUNCTION
    res := CASE(flt_type,
      11 => LIMIT(LIMIT(nm(nm_filt1), 5000, FAIL(203,doxie.ErrorCodes(203)), keyed, count),
        2000, FAIL(203, doxie.ErrorCodes(203))),

      12 => LIMIT(LIMIT(nm(nm_filt1), 2000, SKIP, keyed, count),
        1000, SKIP));
    RETURN res;
  END;

  nm_read1_fail := project(nm_w_daily(11), doNameProject(LEFT));
  nm_read1_skip := project(nm_w_daily(12), doNameProject(LEFT));
  pre_nm_read1 := IF(noFail, nm_read1_skip, nm_read1_fail);
  nm_read1_optout := Suppress.MAC_SuppressSource(pre_nm_read1, mod_access);
  nm_read1 := project(nm_read1_optout, joinedRecord);

  zips_within_city_value := ut.ZipsWithinCity(state_value, city_value);

  nm_wild_raw := nm_wild(lname_value_better<>''
    AND keyed(name_last[1..length(trim(lname_value_better))]=trim(lname_value_better))
    AND keyed(st=state_value OR (state_value=''))
    AND keyed(name_first[1..length(trim(fname_value))]=fname_value)
    AND keyed(zip5 in zips_within_city_value+zip_value or zips_within_city_value+zip_value=[])
    AND (name_last=lname_value_better OR allow_name_wildcard)
    AND (~SuppressNoncurrent OR current_record_flag<>''));

  pre_nm_wild_read := project(LIMIT(LIMIT(nm_wild_raw, 3000, SKIP, keyed, count),
    3000, SKIP), doWildNameProject(left));

  nm_wild_optout := Suppress.MAC_SuppressSource(pre_nm_wild_read, mod_access);
  nm_wild_read := PROJECT(nm_wild_optout, joinedRecord);

  //-----------------
  zipnm_postfilt :=
        (prange_value = ''
            or (source_doc_view and znm.prim_range = prange_value)
            or (not source_doc_view and ut.StringSimilar(znm.prim_range,prange_value)<4 and zip_value = [])
            or (not source_doc_view and zip_value <> [] )
            or (addr_range and (INTEGER)znm.prim_range >= prange_beg_value AND (INTEGER)znm.prim_range <= prange_end_value)
            or (dir_prange_range and (INTEGER)znm.prim_range >= dir_prange_beg_value AND (INTEGER)znm.prim_range <= dir_prange_end_value)
            or (addr_wild and STD.Str.WildMatch(znm.prim_range, prange_wild_value, TRUE))
            or (dir_prange_wild and STD.Str.WildMatch(znm.prim_range, dir_prange_value, TRUE))
            )
        AND (pname_value = ''
            or (source_doc_view and znm.prim_name = pname_val)
            or (not source_doc_view and ut.StringSimilar(znm.prim_name,pname_val)<4 and zip_value = [])
            or (not source_doc_view and ut.StringSimilar(znm.prim_name,pname_value)<4 and zip_value = [])
            or (not source_doc_view and zip_value <> []))
        AND (city_value = '' //or addr_error_value
            or (source_doc_view and ( city_upper = znm.p_city_name or city_upper = znm.v_city_name))
            or (not source_doc_view and (ut.StringSimilar(city_value,znm.p_city_name)<4 or ut.StringSimilar(city_value,znm.v_city_name)<4) and zip_value = [])
            or (not source_doc_view and zip_value <> []))
        AND (AllowLooseSuffixMatch or addr_suffix_value = '' or znm.suffix = addr_suffix_value)
        AND (~SuppressNoncurrent OR znm.current_record_flag<>'');

  zipnm_filt1 :=
              zip_value<>[] AND lname_value_better<>''
              AND keyed(znm.zip5 in zip_value)
              AND keyed(phon_fil(znm))
              AND keyed(lname_fil(znm) or nicknames or phonetics)
              AND keyed(pfname_fil(znm) or nicknames or phonetics)
              AND keyed(fname_fil(znm) or nicknames or phonetics)
              AND (~nicknames and ~phonetics or pfname_fil_loose(znm))
              AND (~nicknames and ~phonetics or fname_fil_loose(znm))
              AND (~nicknames and ~phonetics or ut.StringSimilar(znm.name_last,lname_value_better)<4)
              AND zipnm_postfilt;

  znm_w_daily(unsigned1 flt_type) := FUNCTION
    znm_filtered := znm(zipnm_filt1);
    res := CASE(flt_type,
      11 => LIMIT(LIMIT(znm_filtered(~SuppressNoncurrent or current_record_flag<>''), 20000,
        FAIL(203, doxie.ErrorCodes(203)), keyed, count), 4000, FAIL(203, doxie.ErrorCodes(203))),

      12 => LIMIT(LIMIT(znm_filtered, 2000, SKIP, keyed, count), 1000, skip));
    return res;
  END;

  zipnm_read1_fail := project(znm_w_daily(11), doZipNameProject(LEFT));
  zipnm_read1_skip := project(znm_w_daily(12), doZipNameProject(LEFT));
  pre_zipnm_read1 := IF(noFail, zipnm_read1_skip, zipnm_read1_fail);
  zipnm_read1_optout := Suppress.MAC_SuppressSource(pre_zipnm_read1, mod_access);
  zipnm_read1 := PROJECT(zipnm_read1_optout, joinedRecord);
  // adding city state name search here

  city_st_name_read_skip := project(LIMIT(LIMIT(csnm(city_value<>'' AND lname_value_better<>''
    AND keyed(city_code in doxie.Make_CityCodes(city_value).rox )
    AND keyed(st=state_value OR (state_value=''))
    AND keyed(dph_name_last[1..if(phonetics,6,length(trim(lname_value_ph_better)))]= trim(lname_value_ph_better) OR (lname_value_better=''))
    AND keyed(name_last[1..length(trim(lname_value_better))]=trim(lname_value_better) OR phonetics OR lname_value_better='')
    AND keyed(NID.mod_PFirstTools.RinPFL(fname_value,p_name_first) OR
      NID.mod_PFirstTools.WholeRinPFL_Initial(fname_value,p_name_first) OR
      p_name_first[1..2] = fname_value[1] + ' ' OR
      (LENGTH(TRIM(fname_value))<2) OR ~nicknames)
    AND keyed(name_first[1..length(trim(fname_value))]=fname_value OR
      (nicknames and (LENGTH(TRIM(fname_value))>=2)) OR
      name_first[1..2] = fname_value[1] + ' ')
    AND (phonetics OR lname_value_better='' OR name_last=lname_value_better OR allow_name_wildcard)
    AND (~SuppressNoncurrent or current_record_flag<>'')),
    10000, SKIP,keyed,count),3000, SKIP), doCityStNameProject(left));

  city_st_name_read_fail := project(LIMIT(LIMIT(csnm(city_value<>'' AND lname_value_better<>''
    AND keyed(city_code in doxie.Make_CityCodes(city_value).rox )
    AND keyed(st=state_value OR (state_value=''))
    AND keyed(dph_name_last[1..if(phonetics,6,length(trim(lname_value_ph_better)))]= trim(lname_value_ph_better) OR (lname_value_better=''))
    AND keyed(name_last[1..length(trim(lname_value_better))]=trim(lname_value_better) OR phonetics OR lname_value_better='')
    AND keyed(NID.mod_PFirstTools.RinPFL(fname_value,p_name_first) OR
      NID.mod_PFirstTools.WholeRinPFL_Initial(fname_value,p_name_first) OR
      p_name_first[1..2] = fname_value[1] + ' ' OR
      (LENGTH(TRIM(fname_value))<2) OR ~nicknames)
    AND keyed(name_first[1..length(trim(fname_value))]=fname_value
      OR (nicknames and (LENGTH(TRIM(fname_value))>=2)) OR
      name_first[1..2] = fname_value[1] + ' ')
    AND (phonetics OR lname_value_better='' OR name_last=lname_value_better OR allow_name_wildcard)
    AND (~SuppressNoncurrent or current_record_flag<>'')),
      10000, FAIL(203,doxie.ErrorCodes(203)),keyed,count),
    3000, FAIL(203,doxie.ErrorCodes(203))), doCityStNameProject(left));

  pre_city_st_name_read	:= if(noFail, city_st_name_read_skip, city_st_name_read_fail);
  city_st_name_read_optout := Suppress.MAC_SuppressSource(pre_city_st_name_read, mod_access);
  city_st_name_read := PROJECT(city_st_name_read_optout, joinedRecord);
  //fetch by zip codes within the city

  city_st_name_read_by_zip_skip := project(LIMIT(LIMIT(znm(city_value<>'' AND lname_value_better<>''
    AND keyed(dph_name_last=(string6)metaphonelib.DMetaPhone1(STD.Str.FilterOut(lname_value_better,' ')))
    AND keyed(zip5 in zips_within_city_value + zip_value)
    AND keyed(pfe(p_name_first,fname_value) OR
      p_name_first[1..2] = fname_value[1] + ' ' OR
      (LENGTH(TRIM(fname_value))<2))
    AND keyed(name_last=lname_value_better OR ((phonetics OR lname_value_better='')))
    AND keyed(name_first[1..length(trim(fname_value))]=fname_value OR
      (nicknames and (LENGTH(TRIM(fname_value))>=2)) OR
      name_first[1..2] = fname_value[1] + ' ')
    AND (~SuppressNoncurrent or current_record_flag<>'')),
    20000, SKIP, keyed, count),4000,  SKIP), doZipNameProject(left));

  city_st_name_read_by_zip_fail := project(LIMIT(LIMIT(znm(city_value<>'' AND lname_value_better<>''
    AND keyed(dph_name_last=(string6)metaphonelib.DMetaPhone1(STD.Str.FilterOut(lname_value_better,' ')))
    AND keyed(zip5 in zips_within_city_value + zip_value)
    AND keyed(pfe(p_name_first,fname_value) OR
      p_name_first[1..2] = fname_value[1] + ' ' OR
      (LENGTH(TRIM(fname_value))<2))
    AND keyed(name_last=lname_value_better OR ((phonetics OR lname_value_better='')))
    AND keyed(name_first[1..length(trim(fname_value))]=fname_value OR
      (nicknames and (LENGTH(TRIM(fname_value))>=2)) OR
      name_first[1..2] = fname_value[1] + ' ')
    AND (~SuppressNoncurrent or current_record_flag<>'')),
    20000, FAIL(203,doxie.ErrorCodes(203)), keyed, count),
    4000,  FAIL(203,doxie.ErrorCodes(203))), doZipNameProject(left));

  pre_city_st_name_read_by_zip := if(noFail, city_st_name_read_by_zip_skip, city_st_name_read_by_zip_fail);
  city_st_name_read_by_zip_optout := Suppress.MAC_SuppressSource(pre_city_st_name_read_by_zip, mod_access);
  city_st_name_read_by_zip := PROJECT(city_st_name_read_by_zip_optout, joinedRecord);

  name_key_recs :=
  if(lname_value_better<>'',
      map( city_value<>'' => city_st_name_read + city_st_name_read_by_zip + if(allow_name_wildcard, nm_wild_read),
        zip_value<>[] => zipnm_read1 + if(allow_name_wildcard, nm_wild_read),
        nm_read1 + if(allow_name_wildcard, nm_wild_read)));

  // get the records based on address parameters
  // the order of the index is prim_name,st,z5, prim_range, sec_range
  castFname := trim(ut.cast2keyfield(Key_History_Address.name_first,fname_value));
  addr_key_read_history := Key_History_Address(pname_value != '' and (company_name='' or lname_value_better<>'' or fname_value<>''), zip_value <> [] or state_value <> ''
    ,keyed(prim_range = prange_value
          or prange_value = '' or addr_range or addr_wild or dir_prange_range or dir_prange_wild)
    ,keyed(prim_name = pname_value or prim_name = pname_val or prim_name = dir_pname_value)
    ,keyed(sec_range = sec_range_better or sec_range_better = '' or (AllowLooseSecRangeMatch and sec_range = ''))
    ,keyed(st = state_value or state_value = '')
    ,keyed(z5 in str_zip_set or zip_value = [])
    ,city_value = ''
      or ((city_value = p_city_name or city_value = v_city_name) and source_doc_view)
      or ((ut.StringSimilar(city_value,p_city_name)<4 or ut.StringSimilar(city_value,v_city_name)<4) and zip_value = [] and not source_doc_view)
      or (zip_value <> [] and not source_doc_view)
    ,(~addr_range or (INTEGER)prim_range >= prange_beg_value AND (INTEGER)prim_range <= prange_end_value)
    ,(~dir_prange_range or (INTEGER)prim_range >= dir_prange_beg_value AND (INTEGER)prim_range <= dir_prange_end_value)
    ,(~addr_wild or STD.Str.WildMatch(prim_range, prange_wild_value, TRUE))
    ,(~dir_prange_wild or STD.Str.WildMatch(prim_range, dir_prange_value, TRUE))
    ,(AllowLooseSuffixMatch or addr_suffix_value = '' or suffix = addr_suffix_value)
    ,(metaphonelib.DMetaPhone1(name_last)[1..6] = metaphonelib.DMetaPhone1(lname_value_better)[1..6] and phonetics
    or name_last[1..length(trim(lname_value_better))] = lname_value_better or lname_value_better = '')
    ,(NID.mod_PFirstTools.SUBPFLeqPFR(name_first, fname_value)
    or length(trim(fname_value))<2
    or name_first[1..length(castFname)]= castFname
    or name_first = (STRING1)fname_value or fname_value = '' or
    name_first[1..2] = fname_value[1] + ' ')
    ,(~SuppressNoncurrent or current_flag));

  // So far using default limit, since a lot of blank key-field are assumed here (theoretically)
  addr_key_recs_fail := LIMIT(addr_key_read_history, 10000, FAIL(203,doxie.ErrorCodes(203)));
  addr_key_recs_skip := LIMIT(LIMIT(addr_key_read_history, 10000, SKIP, keyed), 5000, SKIP);
  pre_addr_key_pick := IF(noFail, addr_key_recs_skip, addr_key_recs_fail);
  addr_key_pick := Suppress.MAC_SuppressSource(pre_addr_key_pick, mod_access);
  addr_key_recs := project(addr_key_pick,doAddrProject(LEFT));

  //get records by phone
  pre_phone_key_recs := project(choosen(Key_History_phone(local_phone7 != ''
    , keyed(p7 = local_phone7)
    , keyed(local_area_code = '' OR p3 = local_area_code)
    , (state_value = '') OR (st = state_value)
    , (~SuppressNoncurrent OR current_flag)
    ), MaxResultsDefault),
    doPhoneProject(LEFT));
  // if we didn't get a hit on phone_key_recs, change the search to phone7 and state
  best_state := CHOOSEN (Risk_Indicators.Key_Telcordia_NPA_St(npa = local_area_code), 1);
  phone_key_recs_optout := Suppress.MAC_SuppressSource(pre_phone_key_recs, mod_access);
  phone_key_recs := PROJECT(phone_key_recs_optout, joinedRecord);

  regional_phone_key_recs := project(LIMIT (LIMIT(key_history_phone(local_phone7 != ''
    , best_state[1].st != '' or state_value != ''
    , keyed(p7 = local_phone7)
    , st = best_state[1].st or st = state_value
    ),1000,SKIP,keyed,count), 500, SKIP),
    doPhoneProject(LEFT));

  pre_additional_phone_key_recs := if(AllowFallBack and not Exists(phone_key_recs),regional_phone_key_recs);
  additional_phone_key_recs_optout := Suppress.MAC_SuppressSource(pre_additional_phone_key_recs, mod_access);
  additional_phone_key_recs := PROJECT(additional_phone_key_recs_optout, joinedRecord);

  // need to output an indication message that we reverted to a 7-digit match within state
  fallback := (~SuppressNoncurrent and exists(additional_phone_key_recs)) or
              (SuppressNoncurrent and exists(additional_phone_key_recs(current_record_flag<>'')));

  if(fallback, ut.outputMessage(ut.constants_MessageCodes.PHONE_FALLBACK));

  // combine name and address and phone records
  name_addr_key_recs := if((pname_value='' and dir_pname_value='') or
                           ((pname_value<>'' or dir_pname_value<>'') and city_value='' and state_value='' and zip_value=[]), name_key_recs)
                        + addr_key_recs;

  name_addr_phone_key_recs0 := IF(source_doc_view = true,
                                name_addr_key_recs ,
                                if(phone_value='',name_addr_key_recs) + if(phone_value<>'', phone_key_recs + additional_phone_key_recs));

  // ensure that unnecessary work doesn't happen
  name_addr_phone_key_recs := name_addr_phone_key_recs0(~did_onlyL);

  // Get a list of unique dids from the name addr phone recs, for a did search later.
  name_addr_phone_key_recs_for_did := DEDUP(SORT(name_addr_phone_key_recs,did),did);

  // Get a list of unique hhids from the name addr phone recs, for a hhid search later.
  name_addr_phone_key_recs_for_hhid := DEDUP(SORT(name_addr_phone_key_recs,hhid),hhid);

  //Join the name_addr recs to did and hhid recs if source_doc_view

  MatchingNameAddrPhoneDidRawRecs := join(name_addr_phone_key_recs_for_did, key_history_did,
     keyed(left.did = right.l_did), TRANSFORM(right), LIMIT (ut.limits .GONG_HISTORY_MAX, SKIP));

  MatchingNameAddrPhoneDidRawRecs_OptOut := Suppress.MAC_SuppressSource(
    MatchingNameAddrPhoneDidRawRecs, mod_access);

  MatchingNameAddrPhoneDidRecs := project(MatchingNameAddrPhoneDidRawRecs_OptOut, doDidJoin(LEFT));

  MatchingNameAddrPhoneHHIDRawRecs := join(name_addr_phone_key_recs_for_hhid, key_history_hhid,
    keyed(left.hhid = right.s_hhid), TRANSFORM(right), LIMIT (ut.limits .GONG_HISTORY_MAX, SKIP));

  MatchingNameAddrPhoneHHIDRawRecs_OptOut := Suppress.MAC_SuppressSource(
    MatchingNameAddrPhoneHHIDRawRecs, mod_access);

  MatchingNameAddrPhoneHHIDRecs := project(MatchingNameAddrPhoneHHIDRawRecs_OptOut, doHHIDJoin(LEFT));

  // get the records based on phone parameters

  MatchingNameAddrPhone_in := dedup(sort(name_addr_phone_key_recs,phone10,name_last),phone10,name_last);

  pre_MatchingNameAddrPhoneToPhoneRecs := JOIN(MatchingNameAddrPhone_in, Key_History_phone,
                                           LEFT.phone10 <> ''
                                           and LEFT.phone10[4..10]  = RIGHT.p7
                                           and LEFT.phone10[1..3]  = RIGHT.p3
                                           and LEFT.name_last = RIGHT.name_last
                                           ,doPhoneProject(RIGHT),LIMIT(1000,SKIP));

  MatchingNameAddrPhoneToPhoneRecs_optout := Suppress.MAC_SuppressSource(pre_MatchingNameAddrPhoneToPhoneRecs, mod_access);
  MatchingNameAddrPhoneToPhoneRecs := PROJECT(MatchingNameAddrPhoneToPhoneRecs_optout, joinedRecord);

  hhid_dids := PROJECT(doxie.Get_Household_DIDs(indids(did<>0)),doxie.layout_references);
  use_dids := IF(include_HHID_DIDs, hhid_dids, indids(did<>0));
  // get the records based on did parameters
//  gong.Mac_History_Daily_Did(use_dids, mod_access, did, did_key_raw_recs);

  gong_did_history := join(use_dids, Key_History_did, keyed(left.did = right.l_did),
    TRANSFORM(right), LIMIT(ut.limits.GONG_HISTORY_MAX, SKIP));

  did_key_raw_recs := Suppress.MAC_SuppressSource(gong_did_history, mod_access);


  did_key_recs :=  project(did_key_raw_recs,doDidProject(LEFT));

  //perfect match or more words in listed name for company name match
  company_name_better := LIB_Word.StripTail(
                         LIB_Word.StripTail(
                         LIB_Word.StripTail(
                         LIB_Word.StripTail(
                         LIB_Word.StripTail(
                         LIB_Word.StripTail(company_name, ' CORPORATION'),
                                     ' CORP'),
                                  ' CORP.'),
                                  ' INCORPORATED'),
                                  ' INC'),
                                  ' INC.');

  company_name_clean := STD.Str.CleanSpaces(STD.Str.SubstituteIncluded(company_name,
    '~`!@#$%^&*()-_+={[}]|\\;:"\'<,>.?/',
    ' '));

  is_wild_company_name := STD.Str.Find(company_name, '*', 1) <> 0 OR STD.Str.Find(company_name, '?', 1) <> 0;

  MatchingCompanyNameRecs_regular_Fetch := key_history_companyname((listed_name_new = trim(company_name_better) or
    listed_name_new[1..length(trim(company_name_clean))+1] = trim(company_name_clean) or
    listed_name_new[1..length(trim(company_name_better))+1]= trim(company_name_better) + ' ') and
      company_name<>'',
    prim_range = prange_value or prange_value = '' or addr_range or addr_wild or dir_prange_range or dir_prange_wild,
    prim_name = pname_value or prim_name = pname_val or prim_name = dir_pname_value or pname_value = '',
    (state_value='' or state_value = st),
    (city_value = '' or (city_value = p_city_name or city_value = v_city_name)),
    (zip_value = [] or (integer4)z5 in zip_value),
    (AllowLooseSuffixMatch or addr_suffix_value = '' or suffix = addr_suffix_value),
    (~addr_range or (INTEGER)prim_range >= prange_beg_value AND (INTEGER)prim_range <= prange_end_value),
    (~dir_prange_range or (INTEGER)prim_range >= dir_prange_beg_value AND (INTEGER)prim_range <= dir_prange_end_value),
    (~addr_wild or STD.Str.WildMatch(prim_range, prange_wild_value, TRUE)),
    (~dir_prange_wild or STD.Str.WildMatch(prim_range, dir_prange_value, TRUE)),
    (~SuppressNoncurrent OR current_record_flag<>''));

  MatchingCompanyNameRecs_regular_Fetch_fail :=  project(limit(MatchingCompanyNameRecs_regular_Fetch,
    1000,FAIL(203,doxie.ErrorCodes(203))), doCompanyNameProject(left));

  MatchingCompanyNameRecs_regular_Fetch_skip :=  project(limit(MatchingCompanyNameRecs_regular_Fetch,
    1000,skip), doCompanyNameProject(left));

  pre_MatchingCompanyNameRecs_regular :=  if(noFail,
                                         MatchingCompanyNameRecs_regular_Fetch_skip,
                                         MatchingCompanyNameRecs_regular_Fetch_fail);

  MatchingCompanyNameRecs_regular_optout := Suppress.MAC_SuppressSource(pre_MatchingCompanyNameRecs_regular, mod_access);
  MatchingCompanyNameRecs_regular := PROJECT(MatchingCompanyNameRecs_regular_optout, joinedRecord);

  MatchingCompanyNameRecs_wild_keydata := key_history_companyname(
    listed_name_new[1..length(trim(company_name))] = trim(company_name) and company_name<>'',
    prim_range = prange_value or prange_value = '' or addr_range or addr_wild or dir_prange_range or dir_prange_wild,
    prim_name = pname_value or prim_name = pname_val or prim_name = dir_pname_value or pname_value = '',
    (state_value='' or state_value = st),
    (city_value = '' or (city_value = p_city_name or city_value = v_city_name)),
    (zip_value = [] or (integer4)z5 in zip_value),
    (AllowLooseSuffixMatch or addr_suffix_value = '' or suffix = addr_suffix_value),
    (~addr_range or (INTEGER)prim_range >= prange_beg_value AND (INTEGER)prim_range <= prange_end_value),
    (~dir_prange_range or (INTEGER)prim_range >= dir_prange_beg_value AND (INTEGER)prim_range <= dir_prange_end_value),
    (~addr_wild or STD.Str.WildMatch(prim_range, prange_wild_value, TRUE)),
    (~dir_prange_wild or STD.Str.WildMatch(prim_range, dir_prange_value, TRUE)),
    (~SuppressNoncurrent OR current_record_flag<>''));

  pre_MatchingCompanyNameRecs_wild := PROJECT(LIMIT(MatchingCompanyNameRecs_wild_keydata,
     1000, FAIL(203, doxie.ErrorCodes(203))), doCompanyNameProject(left));

  MatchingCompanyNameRecs_wild_OptOut := Suppress.MAC_SuppressSource(pre_MatchingCompanyNameRecs_wild, mod_access);
  MatchingCompanyNameRecs_wild := PROJECT(pre_MatchingCompanyNameRecs_wild, joinedRecord);

  cn_key_1_recs := limit(dx_Gong.key_cn()(keyed(dph_cn[1..if(phonetics,6,length(trim(metaphonelib.DMetaPhone1(lib_word.word(company_name,1)))))]=
        metaphonelib.DMetaPhone1(lib_word.word(company_name,1)) and length(trim(company_name))>0),
    keyed(cn[1..length(trim(lib_word.word(company_name,1)))]=lib_word.word(company_name,1) and length(trim(company_name))>0 or phonetics),
    keyed(st = state_value or state_value = ''),
    city_value = '' or (city_value = p_city_name or city_value = v_city_name) or z5<>'' and (integer4)z5 in zips_within_city_value or
    city_value<>'' and zipradius_value>0 and (integer4)z5 in zip_value,
    zip_value = [] or (integer4)z5 in zip_value,
    (~phonetics or lib_word.word(company_name,2)='' or
    metaphonelib.DMetaPhone1(lib_word.word(listed_name,1))=metaphonelib.DMetaPhone1(lib_word.word(company_name,1))),
    (lib_word.word(company_name,2)='' or STD.Str.Find(listed_name, trim(lib_word.word(company_name,2)), 1) <> 0 or
    phonetics and (metaphonelib.DMetaPhone1(lib_word.word(listed_name,2))=metaphonelib.DMetaPhone1(lib_word.word(company_name,2)) or
      lib_word.word(company_name,3) <> '' and lib_word.word(company_name,2)[1]=lib_word.word(listed_name,2)[1])),
    (lib_word.word(company_name,3)='' or lib_word.word(listed_name,3) = lib_word.word(company_name,3) or
    phonetics and (metaphonelib.DMetaPhone1(lib_word.word(listed_name,3))=metaphonelib.DMetaPhone1(lib_word.word(company_name,3)) or
      lib_word.word(company_name,3)[1]=lib_word.word(listed_name,2)[2])),
    (lib_word.word(company_name,4)='' or lib_word.word(listed_name,4) = lib_word.word(company_name,4) or
    phonetics and metaphonelib.DMetaPhone1(lib_word.word(listed_name,4))=metaphonelib.DMetaPhone1(lib_word.word(company_name,4)))),
    1000, FAIL(203,doxie.ErrorCodes(203)));

  ph_first_word_value := metaphonelib.DMetaPhone1(first_word_value)[1..6];
  ph_any_word1_value := metaphonelib.DMetaPhone1(any_word1_value)[1..6];
  ph_any_word2_value := metaphonelib.DMetaPhone1(any_word2_value)[1..6];
  word_set := [trim(first_word_value)[1..9], trim(any_word1_value)[1..9], trim(any_word2_value)[1..9]];
  ph_word_set := [ph_first_word_value, ph_any_word1_value, ph_any_word2_value];
  has_3_words := first_word_value<>'' or any_word1_value<>'' or any_word2_value<>'';

  cn_key_3_recs := limit(dx_Gong.key_cn()(keyed(dph_cn in ph_word_set and has_3_words),
    keyed(cn[1..9] in word_set and has_3_words or phonetics),
    keyed(st = state_value or state_value=''),
    city_value = '' or (city_value = p_city_name or city_value = v_city_name) or z5<>'' and (integer4)z5 in zips_within_city_value or
    city_value<>'' and zipradius_value>0 and (integer4)z5 in zip_value,
    zip_value = [] or (integer4)z5 in zip_value,
    (first_word_value='' or lib_word.word(listed_name,1)=trim(first_word_value)),
    (any_word1_value='' or STD.Str.Find(' ' + trim(listed_name) + ' ', ' '+trim(any_word1_value)+' ', 1) <> 0),
    (any_word2_value='' or STD.Str.Find(' ' + trim(listed_name) + ' ', ' '+trim(any_word2_value)+' ', 1) <> 0)),
    1000, FAIL(203,doxie.ErrorCodes(203)));

  cn_key_recs := if(has_3_words, cn_key_3_recs, cn_key_1_recs);

  key_cn_to_company := dx_Gong.key_cn_to_company();
  joinedRecord_w_compliance get_gong_by_cn(key_cn_to_company r) := TRANSFORM
    SELF.businessIds := nullRow;
    SELF := r;
  END;

  MatchingCompanyNameRecs_cn_pre_suppress := join(dedup(sort(cn_key_recs, record), record),
    key_cn_to_company,
    keyed(left.listed_name = right.listed_name) and
    keyed(left.st = right.st) and
    keyed(left.p_city_name = right.p_city_name) and
    keyed(left.z5 = right.z5) and
    keyed(left.phone10 = right.phone10),
    get_gong_by_cn(right), limit(ut.limits.PHONE_PER_ADDRESS, skip), keep(3));

  MatchingCompanyNameRecs_cn_suppressed := Suppress.MAC_SuppressSource(MatchingCompanyNameRecs_cn_pre_suppress, mod_access);

  MatchingCompanyNameRecs_cn_after_join := PROJECT(MatchingCompanyNameRecs_cn_suppressed, joinedRecord);

  MatchingCompanyNameRecs_cn := MatchingCompanyNameRecs_cn_after_join
    ((STD.Str.Find(' '+ trim(listed_name) + ' ' + trim(caption_text) + ' ',
      ' ' + lib_word.word(trim(company_name),1) + ' ', 1)<>0 or
    STD.Str.Find(' '+ trim(listed_name) + ' ' + trim(caption_text) + ' ',
      ' ' + lib_word.word(trim(company_name),1) + '|', 1)<>0 or
    STD.Str.Find(keyLib.GongDacName(listed_name),
      lib_word.word(trim(company_name),1), 1)<>0	or
    (phonetics and  (metaphonelib.DMetaPhone1(lib_word.word(trim(company_name),1))[1..6]=
      metaphonelib.DMetaPhone1(lib_word.word(trim(listed_name),1))[1..6] or
      lib_word.word(trim(company_name),2)<>''))
    or has_3_words) and
    ((prim_range = prange_value or prange_value = '' or addr_range or addr_wild or dir_prange_range or dir_prange_wild) and
    (prim_name = pname_value or prim_name = pname_val or prim_name = dir_pname_value or pname_value = '') and
    (~addr_range or (INTEGER)prim_range >= prange_beg_value AND (INTEGER)prim_range <= prange_end_value) and
    (AllowLooseSuffixMatch or addr_suffix_value = '' or suffix = addr_suffix_value) and
    (~dir_prange_range or (INTEGER)prim_range >= dir_prange_beg_value AND (INTEGER)prim_range <= dir_prange_end_value) and
    (~addr_wild or STD.Str.WildMatch(prim_range, prange_wild_value, TRUE)) and
    (~dir_prange_wild or STD.Str.WildMatch(prim_range, dir_prange_value, TRUE)))
    );

  MatchingCompanyNameRecs	:=
    if(is_wild_company_name, MatchingCompanyNameRecs_wild, MatchingCompanyNameRecs_regular) +
    if(allow_use_cnkey, MatchingCompanyNameRecs_cn + MatchingCompanyNameRecs_wild);

  MatchingNameAddrPhoneRecsReady := IF(source_doc_view = true,
    MatchingNameAddrPhoneDidRecs +
    MatchingNameAddrPhoneHHIDRecs +
    MatchingNameAddrPhoneToPhoneRecs +
    did_key_recs +
    name_addr_phone_key_recs,
    IF(did_onlyL, did_key_recs, did_key_recs +
    name_addr_phone_key_recs)) +
  IF(company_name<>'' or has_3_words, MatchingCompanyNameRecs);

   //check best ssn, DOB/Age and preferred first for best fname if provided
  MatchingNameAddrPhoneSSNDOBRec := record
    joinedRecord;
    string9 ssn;
    integer4 dob;
    string20 fname;
  end;

  doxie.mac_best_records(MatchingNameAddrPhoneRecsReady(did<>0),
    did,
    outfile,
    dppa_ok,
    glb_ok,
    ,
    doxie.DataRestriction.fixed_DRM);

  MatchingNameAddrPhoneSSNDOBRec get_best_ssn_dob_fname(MatchingNameAddrPhoneRecsReady l, outfile r) := transform
    self.ssn := r.ssn;
    self.dob := r.dob;
    self.fname := r.fname;
    self := l;
  end;

  MatchingNameAddrPhoneSSNDOBRecs	:= join(MatchingNameAddrPhoneRecsReady(did<>0), outfile,
                                            left.did = right.did,
                                        get_best_ssn_dob_fname(left, right), left outer, keep(1));

  mn := MatchingNameAddrPhoneSSNDOBRecs;
  ssn_len := length(trim(ssn_value));
  ssn_filt := ssn_len=9 and (mn.ssn=ssn_value or (unsigned)mn.ssn div 10000=0 and mn.ssn[6..9] = ssn_value[6..9]) or
    ssn_len=5 and mn.ssn[1..5]=ssn_value or
    ssn_len=4 and mn.ssn[6..9]=ssn_value or
    ssn_len=0;

  dob_filt := ((find_month=0 or (mn.dob div 100) % 100=find_month) AND
    // if record in the key has a DOB with a 00 or 01 day, don't cause a mismatch
    (find_day=0 or mn.dob % 100 in [0, 1] or mn.dob % 100=find_day)) AND
    (find_year_low=0 or mn.dob div 10000>=find_year_low) AND
    (find_year_high=0 or mn.dob div 10000<=find_year_high);

   // if nicknames enabled and a single char fname, at least make sure that the preferred first of the subject's
   // best name matches the input fname's preferred first
  pfname_filt := (~nicknames or fname_value = '' or length(trim(mn.name_first)) > 1 or mn.fname = '' or
    mn.name_first[1..2] = fname_value[1] + ' ' or
    NID.mod_PFirstTools.SUBPFLeqPFR(mn.fname, fname_value));

  MatchingNameAddrPhoneFilteredRecs := MatchingNameAddrPhoneSSNDOBRecs(ssn_filt,dob_filt,pfname_filt);
  // if SSN or DOB or Age Range or Nicknames entered as search criteria, use the Best file for any DIDed Gong record to determine
  // whether it should be filtered;
  // but only do this check if not didOnly
  MatchingNameAddrPhoneRecs := if((ssn_value<>'' or dob_val <> 0 or AgeLow_val <> 0 or AgeHigh_val <> 0 or nicknames)
    and not did_onlyL,
    project(MatchingNameAddrPhoneFilteredRecs, joinedRecord) +
    MatchingNameAddrPhoneRecsReady(did=0),
    MatchingNameAddrPhoneRecsReady);
  //--------------------------------------------------------------
  // Sort and Score the output
  //--------------------------------------------------------------

  DedupedMatchingRecs := SORT(MatchingNameAddrPhoneRecs,RECORD);

  joinedRecord doMatchingRecsRollup (joinedRecord l, joinedRecord r) := TRANSFORM
    SELF.dt_first_seen := if ( l.dt_first_seen=''
                                or r.dt_first_seen<>''
                                and r.dt_first_seen < l.dt_first_seen,
                                r.dt_first_seen,
                                l.dt_first_seen);
    SELF.dt_last_seen := if ( l.dt_last_seen=''
                                or r.dt_last_seen<>''
                                and r.dt_last_seen > l.dt_last_seen,
                                r.dt_last_seen,
                                l.dt_last_seen);
    SELF.current_record_flag := if(l.current_record_flag <> '',
                                l.current_record_flag,
                                r.current_record_flag);
    SELF.v_city_name := if(l.p_city_name = l.v_city_name and l.v_city_name <> r.v_city_name,
                              r.v_city_name,
                              l.v_city_name
                          );
    boolean substitute_vname := if(l.prim_name = l.v_prim_name and l.v_prim_name <> r.v_prim_name,
                              true,
                              false
                          );
    SELF.v_predir := if(substitute_vname,
                            r.v_predir,
                            l.v_predir
                        );
    SELF.v_prim_name := if(substitute_vname,
                            r.v_prim_name,
                            l.v_prim_name
                        );
    SELF.v_suffix := if(substitute_vname,
                            r.v_suffix,
                            l.v_suffix
                        );
    SELF.v_postdir := if(substitute_vname,
                            r.v_postdir,
                            l.v_postdir
                        );

    SELF := r;
  END;

  RolledMatchingRecs := ROLLUP(DedupedMatchingRecs
                                        ,doMatchingRecsRollup(LEFT,RIGHT)
                                        ,publish_code
                                        ,phone10
                                        ,prim_range
                                        ,predir
                                        ,prim_name
                                        ,suffix
                                        ,postdir
                                        ,unit_desig
                                        ,sec_range
                                        ,p_city_name
//																				,v_predir
//																				,v_prim_name
//																				,v_suffix
//																				,v_postdir
//																				,v_city_name
                                        ,st
                                        ,z5
                                        ,z4
                                        ,listed_name
                                        ,omit_address
                                        ,omit_phone
                                        ,omit_locality
                                        ,IF(includeParsedDifferences,name_first,'')
                                        ,IF(includeParsedDifferences,name_last,'')
//																				,did
//																				,hhid
                                        );
 // phones history added below here
 s_phones := sort(DedupedMatchingRecs, phone10,prim_name,prim_range,suffix, predir, postdir,listed_name,-dt_last_seen); // name_last,name_first,

  joinedRecord roller(s_phones l,s_phones r) := transform
    self.dt_first_seen := min(l.dt_first_seen,r.dt_first_seen);
    self.dt_last_seen := max(l.dt_last_seen,r.dt_last_seen,l.deletion_date,r.deletion_date);
    self.current_record_flag := max(l.current_record_flag,r.current_record_flag);
    self := l;
  end;

  fn_rollup(dataset(joinedRecord) in_ds) := function
  out_ds := rollup(in_ds,((left.name_first = right.name_first and left.name_last = right.name_last and left.name_first <>'' and left.name_last<>'')
                            or left.listed_name=right.listed_name or (left.did = right.did and left.did <> 0))
                            and left.prim_name = right.prim_name and left.prim_range = right.prim_range
                            and left.suffix = right.suffix and left.predir = right.predir and left.postdir = right.postdir
                            and left.phone10 = right.phone10 and
                            (ut.DaysApart(left.dt_first_seen,max(right.dt_last_seen,right.deletion_date)) < RestrictRollupInDays or right.dt_last_seen >= left.dt_first_seen) ,roller(left,right));
     return out_ds;
  end;

  f_phones := fn_rollup(s_phones);
  s2_phones := sort(f_phones, phone10,prim_name,prim_range,suffix, predir, postdir,name_last,name_first,-dt_last_seen); //listed_name,
  f2_phones := fn_rollup(s2_phones);

 // phones history added above here
 //
 final_rolled := if (RestrictRollupInDays <> 0,f2_phones,RolledMatchingRecs);
  // pull any DIDed records as necessary
  Suppress.MAC_Suppress(final_rolled,RecordsToBeScoredTemp,application_type_value,Suppress.Constants.LinkTypes.DID,did);

  // Start by business ids
  ds_inData := dataset([{company_name, prange_value, pname_value, zip_val, '',
                        city_value, state_value, phone_value,'','','','','',''}], BIPV2.IDFunctions.rec_SearchInput);

  ds_businessIdsInfoOut := Gong_Services.Fetch_Gong_History_By_BusinessIds(ds_inData, mod_access);

  ds_businessIdsInfoOutDeduped := dedup(ds_businessIdsInfoOut, all);

  RecordsToBeScoredTemp xform_temp(ds_businessIdsInfoOut le) := transform
    self.businessIds := ROW({le.DotID,le.EmpID,le.POWID,le.ProxID,le.SELEID,le.OrgID,le.UltID},BIPV2.IDlayouts.l_header_ids);
    self := le;
    self := [];
  end;

  MatchingRawRecsBusinessIds := project(ds_businessIdsInfoOutDeduped, xform_temp(left));


  RecordsToBeScored := if(UseBusinessIds, MatchingRawRecsBusinessIds, RecordsToBeScoredTemp);
  // End by business ids.


  scoredRecord := RECORD
    unsigned2 penlty;
    joinedRecord;
  END;
  scoredRecord doScoring (joinedRecord l) := TRANSFORM
    SELF.penlty := if(company_name<>'' and l.listing_type_bus<>'',
                      ut.CompanySimilar(company_name, l.listed_name)
                      + if(ut.CompanySimilar(company_name, l.listed_name)=0 and
                           ut.StringSimilar100(company_name, l.listed_name)>0, 1,0),
                      Gong_Services.MAC_Gong_History_Penalty(l, fallback));
    SELF.deletion_date := if(l.current_record_flag='Y', '', l.deletion_date);
    SELF := l;
  END;

  ScoredMatchingRecs := project(RecordsToBeScored, doScoring(LEFT));
  ScoredWithCountyNameRecord := RECORD
    scoredRecord;
    string18 county_name;
  END;
  ScoredWithCountyNameRecord doCountyName(ScoredMatchingRecs l, Census_Data.Key_Fips2County r) := TRANSFORM
    SELF.county_name := if (l.county_code <> '', r.county_name, '');
    SELF := l;
  END;
  ScoredWithCountyNamePreRecords := JOIN(ScoredMatchingRecs,Census_Data.Key_Fips2County,
                                      KEYED(LEFT.st = RIGHT.state_code and
                                            LEFT.county_code[3..5] = RIGHT.county_fips),
                                            doCountyName(LEFT,RIGHT), LEFT OUTER, KEEP (1));

  ScoredWithCountyNameRecords := project(ScoredWithCountyNamePreRecords,
                                         transform(ScoredWithCountyNameRecord,
                                                   self.penlty := left.penlty+doxie.FN_Tra_Penalty_County(left.county_name),
                                                   self := left));

  SortedScoredWithCountyNameRecords := SORT(ScoredWithCountyNameRecords(
                                             (penlty < if(UseHigherPenaltyScore, score_threshold_value+2, score_threshold_value)) and
                                             (current_record_flag = 'Y' or not SuppressNoncurrent)),
                                            penlty,-(current_record_flag ='Y'),-dt_last_seen,record);

  unsigned8 SSWCNRP := COUNT(SortedScoredWithCountyNameRecords(penlty = 0));
  rectype := recordof(SortedScoredWithCountyNameRecords);
  // put out the max results or however many there are that are less,
  // unless there are more penlty = 0 records than the desired number to put out,
  // in which case fail.
  outrec := if (SSWCNRP <= MaxResults_Value OR noFail,
                  choosen(SortedScoredWithCountyNameRecords,MaxResults_Value),
                  FAIL(rectype,203, doxie.ErrorCodes(203)));

  return outrec;

END;
