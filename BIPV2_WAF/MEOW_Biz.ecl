IMPORT ut,SALT29;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT MEOW_Biz(DATASET(Process_Biz_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT29.UIDType ButNot=[]) := MODULE
Process_Biz_Layouts.OutputLayout GetResults(Process_Biz_Layouts.InputLayout le) := TRANSFORM
// Need to annotate wordbags with specificities
  SALT29.mac_wordbag_appendspecs_rx(le.cnp_name,Specificities(File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec)
  SALT29.mac_wordbag_appendspecs_rx(le.company_url,Specificities(File_BizHead).company_url_values_key,company_url,company_url_spec)
  CONTACTNAME_spec := le.CONTACTNAME; //Concept wordbags not in regular linkpaths yet
  STREETADDRESS_spec := le.STREETADDRESS; //Concept wordbags not in regular linkpaths yet
  SELF.keys_tried := IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 1,0) + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2,0) + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 3,0) + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 4,0) + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 5,0) + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 6,0) + IF (Key_BizHead_L_CONTACT.CanSearch(le),1 << 7,0) + IF (Key_BizHead_L_URL.CanSearch(le),1 << 8,0) + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 9,0) + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 10,0);
  SELF.Results := TOPN(ROLLUP(IF ( Process_Biz_Layouts.HardKeyMatch(le) ,
    MERGE(
    SORTED(Key_BizHead_L_CNPNAME.ScoredproxidFetch(cnp_name_spec,le.zip_cases,le.prim_name,le.p_city_name,le.st,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_CNPNAME_ST.ScoredproxidFetch(cnp_name_spec,le.st,le.zip_cases,le.prim_name,le.p_city_name,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_ADDRESS1.ScoredproxidFetch(le.prim_name,le.p_city_name,le.st,le.prim_range,cnp_name_spec,le.zip_cases,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_ADDRESS2.ScoredproxidFetch(le.prim_name,le.zip_cases,le.st,le.prim_range,cnp_name_spec,le.p_city_name,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_PHONE.ScoredproxidFetch(le.company_phone,le.company_sic_code1,cnp_name_spec,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.zip_cases,le.prim_name,le.p_city_name,le.st,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_FEIN.ScoredproxidFetch(le.company_fein,le.company_sic_code1,cnp_name_spec,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.zip_cases,le.prim_name,le.p_city_name,le.st,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_CONTACT.ScoredproxidFetch(le.fname,le.lname,le.mname,cnp_name_spec,le.st,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.zip_cases,le.prim_name,le.p_city_name,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_URL.ScoredproxidFetch(company_url_spec,le.st,le.company_sic_code1,cnp_name_spec,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.zip_cases,le.prim_name,le.p_city_name,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_EMAIL.ScoredproxidFetch(le.contact_email,le.company_sic_code1,cnp_name_spec,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.zip_cases,le.prim_name,le.p_city_name,le.st,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid)
    ,SORTED(Key_BizHead_L_SOURCE.ScoredproxidFetch(le.source_record_id,le.source,cnp_name_spec,le.prim_name,le.p_city_name,le.st,le.zip_cases,le.company_sic_code1,le.cnp_number,le.cnp_btype,le.cnp_lowv,le.prim_range,le.sec_range),ultid,orgid,seleid,proxid),SORTED(ultid,orgid,seleid,proxid)) /* Merged */
    ,SORTED(Key_BizHead_.ScoredproxidFetch(le.parent_proxid,le.ultimate_proxid,le.has_lgid,le.empid,le.powid,le.source,le.source_record_id,le.cnp_number,le.cnp_btype,le.cnp_lowv,cnp_name_spec,le.company_phone,le.company_fein,le.company_sic_code1,le.prim_range,le.prim_name,le.sec_range,le.p_city_name,le.st,le.zip_cases,company_url_spec,le.isContact,le.title,le.fname,le.mname,le.lname,le.name_suffix,le.contact_email,le.CONTACTNAME,le.STREETADDRESS),ultid,orgid,seleid,proxid)) /* IF */ 
 
    , RIGHT.proxid > 0 AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT))(proxid NOT IN ButNot),le.MaxIDs,-Weight)(SALT29.DebugMode OR ~ForceFailed OR ButNot<>[]); // Warning - is a fetch to keys etc
  SELF.Results_seleid := SORT( ROLLUP( SORT( SELF.Results,seleid),LEFT.seleid=RIGHT.seleid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT)),-Weight);
  SELF.Results_orgid := SORT( ROLLUP( SORT( SELF.Results_seleid,orgid),LEFT.orgid=RIGHT.orgid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT)),-Weight);
  SELF.Results_ultid := SORT( ROLLUP( SORT( SELF.Results_orgid,ultid),LEFT.ultid=RIGHT.ultid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT)),-Weight);
  Process_Biz_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
END;
  RR0 := PROJECT(in(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0),GetResults(left),PREFETCH(20,PARALLEL));
  Process_Biz_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    SELF.Results := TOPN(ROLLUP( SORT( le.Results+ri.Results, proxid )
    , RIGHT.proxid > 0 AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT))(proxid NOT IN ButNot),le.MaxIds,-Weight);
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR2 := IF ( MultiRec, RR1, RR0 );
  Process_Biz_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF.Results_seleid := le.Results_seleid(weight >= MAX(le.Results_seleid,weight)-le.LeadThreshold);
    SELF.Results_orgid := le.Results_orgid(weight >= MAX(le.Results_orgid,weight)-le.LeadThreshold);
    SELF.Results_ultid := le.Results_ultid(weight >= MAX(le.Results_ultid,weight)-le.LeadThreshold);
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT29.MAC_External_AddPcnt(RR3,Process_Biz_Layouts.LayoutScoredFetch,Results,Process_Biz_Layouts.OutputLayout,26,RR4);
  SALT29.MAC_External_AddPcnt(RR4,Process_Biz_Layouts.LayoutScoredFetch,Results_seleid,Process_Biz_Layouts.OutputLayout,26,RR5);
  SALT29.MAC_External_AddPcnt(RR5,Process_Biz_Layouts.LayoutScoredFetch,Results_orgid,Process_Biz_Layouts.OutputLayout,26,RR6);
  SALT29.MAC_External_AddPcnt(RR6,Process_Biz_Layouts.LayoutScoredFetch,Results_ultid,Process_Biz_Layouts.OutputLayout,26,RR7);
EXPORT Raw_Results := IF(EXISTS(RR0),RR7);
// Pass-thru any records which already had the proxid on them
  process_Biz_layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.seleid := le.Entered_seleid;
    SELF.orgid := le.Entered_orgid;
    SELF.ultid := le.Entered_ultid;
    SELF.proxid := le.Entered_proxid;
    SELF.rcid := le.Entered_rcid;
  END;
  pass_thru0 := PROJECT(in(~(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0)),ptt(LEFT));
  pass_thru := Process_Biz_layouts.id_stream_complete(pass_thru0);
// Transform to process 'real' results
  process_Biz_layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
  END;
  EXPORT Uid_Results := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER))+pass_thru;
  EXPORT Fetch_Stream(DATASET(process_Biz_layouts.id_stream_layout) d) := FUNCTION
    k := Process_Biz_Layouts.Key;
    DLayout := RECORD
      process_Biz_layouts.id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT process_Biz_layouts.id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(Uid_Results le, k ri) := TRANSFORM
      SELF.did_fetch := ri.proxid<>0;
      SELF.proxid := IF ( SELF.did_fetch, ri.proxid, le.proxid ); // Copy from 'real data' if it exists
      SELF.seleid := IF ( SELF.did_fetch, ri.seleid, le.seleid ); // Copy from 'real data' if it exists
      SELF.orgid := IF ( SELF.did_fetch, ri.orgid, le.orgid ); // Copy from 'real data' if it exists
      SELF.ultid := IF ( SELF.did_fetch, ri.ultid, le.ultid ); // Copy from 'real data' if it exists
      SELF.rcid := IF ( SELF.did_fetch, ri.rcid, le.rcid ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    RETURN JOIN( d,k,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000)); // Ignore excess records without erroring
    END;
 
    rd1 := Fetch_Stream(Uid_Results);
    old := PROJECT(rd1(~did_fetch),process_Biz_layouts.id_stream_layout); // Failed to fetch
    renewed := Fetch_Stream(process_Biz_layouts.id_stream_historic(old)); // See if more recent version of ID is fetchable
  EXPORT Raw_Data := rd1(did_fetch OR KeysFailed<>0)+renewed;
 
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_parent_proxid;
      INTEGER2 Match_ultimate_proxid;
      INTEGER2 Match_has_lgid;
      INTEGER2 Match_empid;
      INTEGER2 Match_powid;
      INTEGER2 Match_source;
      INTEGER2 Match_source_record_id;
      INTEGER2 Match_cnp_number;
      INTEGER2 Match_cnp_btype;
      INTEGER2 Match_cnp_lowv;
      INTEGER2 Match_cnp_name;
      INTEGER2 Match_company_phone;
      INTEGER2 Match_company_fein;
      INTEGER2 Match_company_sic_code1;
      INTEGER2 Match_prim_range;
      INTEGER2 Match_prim_name;
      INTEGER2 Match_sec_range;
      INTEGER2 Match_p_city_name;
      INTEGER2 Match_st;
      INTEGER2 Match_zip;
      INTEGER2 Match_company_url;
      INTEGER2 Match_isContact;
      INTEGER2 Match_title;
      INTEGER2 Match_fname;
      INTEGER2 Match_mname;
      INTEGER2 Match_lname;
      INTEGER2 Match_name_suffix;
      INTEGER2 Match_contact_email;
      INTEGER2 Match_CONTACTNAME;
      INTEGER2 Match_STREETADDRESS;
    END;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM
    SELF.Match_parent_proxid := MAP ( ri.parent_proxid = (typeof(ri.parent_proxid))'' => 0, le.parent_proxid = (typeof(ri.parent_proxid))'' => -1, ri.parent_proxid = le.parent_proxid => 2,-2);
    SELF.Match_ultimate_proxid := MAP ( ri.ultimate_proxid = (typeof(ri.ultimate_proxid))'' => 0, le.ultimate_proxid = (typeof(ri.ultimate_proxid))'' => -1, ri.ultimate_proxid = le.ultimate_proxid => 2,-2);
    SELF.Match_has_lgid := MAP ( ri.has_lgid = (typeof(ri.has_lgid))'' => 0, le.has_lgid = (typeof(ri.has_lgid))'' => -1, ri.has_lgid = le.has_lgid => 2,-2);
    SELF.Match_empid := MAP ( ri.empid = (typeof(ri.empid))'' => 0, le.empid = (typeof(ri.empid))'' => -1, ri.empid = le.empid => 2,-2);
    SELF.Match_powid := MAP ( ri.powid = (typeof(ri.powid))'' => 0, le.powid = (typeof(ri.powid))'' => -1, ri.powid = le.powid => 2,-2);
    SELF.Match_source := MAP ( ri.source = (typeof(ri.source))'' => 0, le.source = (typeof(ri.source))'' => -1, ri.source = le.source => 2,-2);
    SELF.Match_source_record_id := MAP ( ri.source_record_id = (typeof(ri.source_record_id))'' => 0, le.source_record_id = (typeof(ri.source_record_id))'' => -1, ri.source_record_id = le.source_record_id => 2,-2);
    SELF.Match_cnp_number := MAP ( ri.cnp_number = (typeof(ri.cnp_number))'' => 0, le.cnp_number = (typeof(ri.cnp_number))'' => -1, ri.cnp_number = le.cnp_number => 2,-2);
    SELF.Match_cnp_btype := MAP ( ri.cnp_btype = (typeof(ri.cnp_btype))'' => 0, le.cnp_btype = (typeof(ri.cnp_btype))'' => -1, ri.cnp_btype = le.cnp_btype => 2,-2);
    SELF.Match_cnp_lowv := MAP ( ri.cnp_lowv = (typeof(ri.cnp_lowv))'' => 0, le.cnp_lowv = (typeof(ri.cnp_lowv))'' => -1, ri.cnp_lowv = le.cnp_lowv => 2,-2);
    le_cnp_name := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)le.cnp_name);//For later scoring
    ri_cnp_name := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.cnp_name);//For later scoring
    SELF.Match_cnp_name := MAP ( ri.cnp_name = (typeof(ri.cnp_name))'' => 0, le.cnp_name = (typeof(ri.cnp_name))'' => -1, ri.cnp_name = le.cnp_name => 2,SALT29.MatchBagOfWords(le_cnp_name,ri_cnp_name,31744,0) > Config.cnp_name_Force * 100 => 1,-2);
    SELF.Match_company_phone := MAP ( ri.company_phone = (typeof(ri.company_phone))'' => 0, le.company_phone = (typeof(ri.company_phone))'' => -1, ri.company_phone = le.company_phone => 2,-2);
    SELF.Match_company_fein := MAP ( ri.company_fein = (typeof(ri.company_fein))'' => 0, le.company_fein = (typeof(ri.company_fein))'' => -1, ri.company_fein = le.company_fein => 2, SALT29.WithinEditN(le.company_fein,ri.company_fein,1, 0) => 1,-2);
    SELF.Match_company_sic_code1 := MAP ( ri.company_sic_code1 = (typeof(ri.company_sic_code1))'' => 0, le.company_sic_code1 = (typeof(ri.company_sic_code1))'' => -1, ri.company_sic_code1 = le.company_sic_code1 => 2,-2);
    SELF.Match_prim_range := MAP ( ri.prim_range = (typeof(ri.prim_range))'' => 0, le.prim_range = (typeof(ri.prim_range))'' => -1, ri.prim_range = le.prim_range => 2, SALT29.WithinEditN(le.prim_range,ri.prim_range,1, 0) => 1,-2);
    SELF.Match_prim_name := MAP ( ri.prim_name = (typeof(ri.prim_name))'' => 0, le.prim_name = (typeof(ri.prim_name))'' => -1, ri.prim_name = le.prim_name => 2, SALT29.WithinEditN(le.prim_name,ri.prim_name,1, 0) => 1,-2);
    SELF.Match_sec_range := MAP ( ri.sec_range = (typeof(ri.sec_range))'' => 0, le.sec_range = (typeof(ri.sec_range))'' => -1, ri.sec_range = le.sec_range => 2, SALT29.WithinEditN(le.sec_range,ri.sec_range,1, 0) => 1,-2);
    SELF.Match_p_city_name := MAP ( ri.p_city_name = (typeof(ri.p_city_name))'' => 0, le.p_city_name = (typeof(ri.p_city_name))'' => -1, ri.p_city_name = le.p_city_name => 2, SALT29.WithinEditN(le.p_city_name,ri.p_city_name,1, 0) => 1,-2);
    SELF.Match_st := MAP ( ri.st = (typeof(ri.st))'' => 0, le.st = (typeof(ri.st))'' => -1, ri.st = le.st => 2,-2);
    SELF.Match_zip := MAP ( ri.zip_cases = [] => 0, le.zip = '' => -1, le.zip IN ri.zip_cases => 2, -2 );
    le_company_url := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)le.company_url);//For later scoring
    ri_company_url := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.company_url);//For later scoring
    SELF.Match_company_url := MAP ( ri.company_url = (typeof(ri.company_url))'' => 0, le.company_url = (typeof(ri.company_url))'' => -1, ri.company_url = le.company_url => 2,SALT29.MatchBagOfWords(le_company_url,ri_company_url,31744,0) > Config.company_url_Force * 100 => 1,-2);
    SELF.Match_isContact := MAP ( ri.isContact = (typeof(ri.isContact))'' => 0, le.isContact = (typeof(ri.isContact))'' => -1, ri.isContact = le.isContact => 2,-2);
    SELF.Match_title := MAP ( ri.title = (typeof(ri.title))'' => 0, le.title = (typeof(ri.title))'' => -1, ri.title = le.title => 2,-2);
    SELF.Match_fname := MAP ( ri.fname = (typeof(ri.fname))'' => 0, le.fname = (typeof(ri.fname))'' => -1, ri.fname = le.fname => 2, SALT29.WithinEditN(le.fname,ri.fname,1, 0) => 1,le.fname = ri.fname[length(trim(le.fname))] or ri.fname = le.fname[length(trim(ri.fname))] => 1,-2);
    SELF.Match_mname := MAP ( ri.mname = (typeof(ri.mname))'' => 0, le.mname = (typeof(ri.mname))'' => -1, ri.mname = le.mname => 2, SALT29.WithinEditN(le.mname,ri.mname,2, 0) => 1,le.mname = ri.mname[length(trim(le.mname))] or ri.mname = le.mname[length(trim(ri.mname))] => 1,-2);
    SELF.Match_lname := MAP ( ri.lname = (typeof(ri.lname))'' => 0, le.lname = (typeof(ri.lname))'' => -1, ri.lname = le.lname => 2, SALT29.WithinEditN(le.lname,ri.lname,2, 0) => 1,le.lname = ri.lname[length(trim(le.lname))] or ri.lname = le.lname[length(trim(ri.lname))] => 1,-2);
    SELF.Match_name_suffix := MAP ( ri.name_suffix = (typeof(ri.name_suffix))'' => 0, le.name_suffix = (typeof(ri.name_suffix))'' => -1, ri.name_suffix = le.name_suffix => 2,-2);
    SELF.Match_contact_email := MAP ( ri.contact_email = (typeof(ri.contact_email))'' => 0, le.contact_email = (typeof(ri.contact_email))'' => -1, ri.contact_email = le.contact_email => 2,-2);
    ri_CONTACTNAME := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.CONTACTNAME);//For later scoring
    le_CONTACTNAME := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.fname) + ' ' + TRIM((SALT29.StrType)le.mname) + ' ' + TRIM((SALT29.StrType)le.lname));//For later scoring
    SELF.Match_CONTACTNAME := MAP ( ri.CONTACTNAME = (typeof(ri.CONTACTNAME))'' => 0, le_CONTACTNAME = (typeof(ri.CONTACTNAME))'' => -1, ri_CONTACTNAME = le_CONTACTNAME => 2, -2);
    ri_STREETADDRESS := SALT29.Fn_WordBag_AppendSpecs_Fake((SALT29.StrType)ri.STREETADDRESS);//For later scoring
    le_STREETADDRESS := SALT29.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT29.StrType)le.prim_range) + ' ' + TRIM((SALT29.StrType)le.prim_name) + ' ' + TRIM((SALT29.StrType)le.sec_range));//For later scoring
    SELF.Match_STREETADDRESS := MAP ( ri.STREETADDRESS = (typeof(ri.STREETADDRESS))'' => 0, le_STREETADDRESS = (typeof(ri.STREETADDRESS))'' => -1, ri_STREETADDRESS = le_STREETADDRESS => 2, -2);
      SELF.Record_Score := SELF.Match_parent_proxid + SELF.Match_ultimate_proxid + SELF.Match_has_lgid + SELF.Match_empid + SELF.Match_powid + SELF.Match_source + SELF.Match_source_record_id + SELF.Match_cnp_number + SELF.Match_cnp_btype + SELF.Match_cnp_lowv + SELF.Match_cnp_name + SELF.Match_company_phone + SELF.Match_company_fein + SELF.Match_company_sic_code1 + SELF.Match_prim_range + SELF.Match_prim_name + SELF.Match_sec_range + SELF.Match_p_city_name + SELF.Match_st + SELF.Match_zip + SELF.Match_company_url + SELF.Match_isContact + SELF.Match_title + SELF.Match_fname + SELF.Match_mname + SELF.Match_lname + SELF.Match_name_suffix + SELF.Match_contact_email + SELF.Match_CONTACTNAME + SELF.Match_STREETADDRESS;
      SELF.Is_FullMatch := SELF.Match_parent_proxid>=0 AND SELF.Match_ultimate_proxid>=0 AND SELF.Match_has_lgid>=0 AND SELF.Match_empid>=0 AND SELF.Match_powid>=0 AND SELF.Match_source>=0 AND SELF.Match_source_record_id>=0 AND SELF.Match_cnp_number>=0 AND SELF.Match_cnp_btype>=0 AND SELF.Match_cnp_lowv>=0 AND SELF.Match_cnp_name>=0 AND SELF.Match_company_phone>=0 AND SELF.Match_company_fein>=0 AND SELF.Match_company_sic_code1>=0 AND SELF.Match_prim_range>=0 AND SELF.Match_prim_name>=0 AND SELF.Match_sec_range>=0 AND SELF.Match_p_city_name>=0 AND SELF.Match_st>=0 AND SELF.Match_zip>=0 AND SELF.Match_company_url>=0 AND SELF.Match_isContact>=0 AND SELF.Match_title>=0 AND SELF.Match_fname>=0 AND SELF.Match_mname>=0 AND SELF.Match_lname>=0 AND SELF.Match_name_suffix>=0 AND SELF.Match_contact_email>=0 AND SELF.Match_CONTACTNAME>=0 AND SELF.Match_STREETADDRESS>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
  	  SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.proxid=ri.proxid AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;
 
  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,proxid,-(Record_Score+Weight-W1)),WHOLE RECORD);
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_Biz_Layouts.InputLayout tr(Raw_Data le) := TRANSFORM
  SELF.Entered_rcid := 0;
    SELF.Entered_proxid := 0; // Blank out the specific IDs
    SELF.Entered_seleid := 0; // Blank out the specific IDs
    SELF.Entered_orgid := 0; // Blank out the specific IDs
    SELF.Entered_ultid := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := []
;  END;
// If there are any simple prop fields; they can be applied here
  DSAfter_company_fein := SALT29.MAC_Field_Prop_Do(Raw_Data,company_fein,proxid);
  ds := PROJECT(DSAfter_company_fein,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
END;
 
