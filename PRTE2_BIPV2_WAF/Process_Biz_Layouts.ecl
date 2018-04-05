EXPORT Process_Biz_Layouts := MODULE
 
IMPORT SALT38;
SHARED h := File_BizHead;//The input file
 
EXPORT KeyName := '~'+'prte::key::PRTE2_BIPV2_WAF::proxid::meow';
 
EXPORT Key := INDEX(h,{ultid,orgid,seleid,proxid},{h},KeyName);
//Create keys to get from lower-order identifiers to the full hierarchy
 
EXPORT KeyproxidUpName := '~'+'prte::key::PRTE2_BIPV2_WAF::proxid::sup::proxid';
  s := TABLE(h,{ultid,orgid,seleid,proxid},ultid,orgid,seleid,proxid,MERGE);
 
EXPORT KeyproxidUp := INDEX(s,{proxid},{s},KeyproxidUpName);
 
EXPORT KeyseleidUpName := '~'+'prte::key::PRTE2_BIPV2_WAF::proxid::sup::seleid';
  s := TABLE(h,{ultid,orgid,seleid},ultid,orgid,seleid,MERGE);
 
EXPORT KeyseleidUp := INDEX(s,{seleid},{s},KeyseleidUpName);
 
EXPORT KeyorgidUpName := '~'+'prte::key::PRTE2_BIPV2_WAF::proxid::sup::orgid';
  s := TABLE(h,{ultid,orgid},ultid,orgid,MERGE);
 
EXPORT KeyorgidUp := INDEX(s,{orgid},{s},KeyorgidUpName);
// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := '~'+'prte::key::PRTE2_BIPV2_WAF::proxid::sup::rcid';
  SHARED sIDHist := TABLE(h,{ultid,orgid,seleid,proxid,rcid},rcid,ultid,orgid,seleid,proxid,MERGE);
 
EXPORT KeyIDHistory := INDEX(sIDHist,{rcid},{sIDHist},KeyIDHistoryName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(Key, OVERWRITE),BUILDINDEX(KeyproxidUp, OVERWRITE),BUILDINDEX(KeyseleidUp, OVERWRITE),BUILDINDEX(KeyorgidUp, OVERWRITE),BUILDINDEX(KeyIDHistory, OVERWRITE));
EXPORT layout_zip_cases := RECORD
  TYPEOF(h.zip) zip;
  INTEGER2 Weight; // we now always store weight in _cases
END;
EXPORT id_stream_layout := RECORD
    SALT38.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    SALT38.UIDType seleid;
    SALT38.UIDType orgid;
    SALT38.UIDType ultid;
    SALT38.UIDType proxid;
    SALT38.UIDType rcid := 0; // Unique record ID for external file
END;
// This function produces elements with the full hierarchy filled in - even if only a 'child' ID was provided
EXPORT id_stream_complete(DATASET(id_stream_layout) id) := FUNCTION
  CF0 := id.proxid<>0 AND id.seleid=0;
  C0 := id(CF0); // In need of filling up
  id_stream_layout Fill0(id_stream_layout le,KeyproxidUp ri) := TRANSFORM
    SELF.seleid := ri.seleid;
    SELF.orgid := ri.orgid;
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J0 := JOIN(C0,KeyproxidUp,LEFT.proxid=RIGHT.proxid,Fill0(LEFT,RIGHT),LEFT OUTER,LIMIT(Config.JoinLimit));
  CF1 := id.seleid<>0 AND id.orgid=0  AND ~CF0;
  C1 := id(CF1); // In need of filling up
  id_stream_layout Fill1(id_stream_layout le,KeyseleidUp ri) := TRANSFORM
    SELF.orgid := ri.orgid;
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J1 := JOIN(C1,KeyseleidUp,LEFT.seleid=RIGHT.seleid,Fill1(LEFT,RIGHT),LEFT OUTER,LIMIT(Config.JoinLimit));
  CF2 := id.orgid<>0 AND id.ultid=0  AND ~CF0  AND ~CF1;
  C2 := id(CF2); // In need of filling up
  id_stream_layout Fill2(id_stream_layout le,KeyorgidUp ri) := TRANSFORM
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J2 := JOIN(C2,KeyorgidUp,LEFT.orgid=RIGHT.orgid,Fill2(LEFT,RIGHT),LEFT OUTER,LIMIT(Config.JoinLimit));
  RETURN id(rcid<>0 AND proxid=0 OR ultid<>0  AND ~CF0  AND ~CF1  AND ~CF2)+J0+J1+J2;
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(rcid<>0,proxid=0); // Only record ID supplied
  id_stream_layout Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J_rec := JOIN(C,KeyIDHistory,LEFT.rcid=RIGHT.rcid,Load(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  C0 := id(proxid<>0); // proxid is the minormost element
  id_stream_layout Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J0 := JOIN(C0,KeyIDHistory,LEFT.proxid=RIGHT.rcid,Load0(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  C1 := id(seleid<>0,proxid=0); // seleid is the minormost element
  id_stream_layout Load1(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J1 := JOIN(C1,KeyIDHistory,LEFT.seleid=RIGHT.rcid,Load1(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  C2 := id(orgid<>0,seleid=0); // orgid is the minormost element
  id_stream_layout Load2(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J2 := JOIN(C2,KeyIDHistory,LEFT.orgid=RIGHT.rcid,Load2(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  C3 := id(ultid<>0,orgid=0); // ultid is the minormost element
  id_stream_layout Load3(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF.orgid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J3 := JOIN(C3,KeyIDHistory,LEFT.ultid=RIGHT.rcid,Load3(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  RETURN J_rec+J0+J1+J2+J3;
END;
EXPORT Fetch_Stream(DATASET(id_stream_layout) d) := FUNCTION
    k := Key;
    DLayout := RECORD
      id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(id_stream_layout le, k ri) := TRANSFORM
      SELF.did_fetch := ri.proxid<>0;
      SELF.proxid := IF ( SELF.did_fetch, ri.proxid, le.proxid ); // Copy from 'real data' if it exists
      SELF.seleid := IF ( SELF.did_fetch, ri.seleid, le.seleid ); // Copy from 'real data' if it exists
      SELF.orgid := IF ( SELF.did_fetch, ri.orgid, le.orgid ); // Copy from 'real data' if it exists
      SELF.ultid := IF ( SELF.did_fetch, ri.ultid, le.ultid ); // Copy from 'real data' if it exists
      SELF.rcid := IF ( SELF.did_fetch, ri.rcid, le.rcid ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J := JOIN( d,k,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(Config.JoinLimit)); // Ignore excess records without erroring
    RETURN J;
END;
 
EXPORT Fetch_Stream_Expanded(DATASET(id_stream_layout) d) := FUNCTION
  rd1 := Fetch_Stream(d);
  old := PROJECT(rd1(~did_fetch),id_stream_layout); // Failed to fetch
  renew_candidates := id_stream_historic(old); // See if more recent version of ID is fetchable
  renewed := Fetch_Stream(renew_candidates);
  RETURN rd1(did_fetch OR KeysFailed<>0)+renewed;
END;
 
EXPORT InputLayout := RECORD
  SALT38.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  BOOLEAN bGetAllScores := TRUE;
  UNSIGNED4 EFR_BitMap := 0; // External File BitMap; When Ext_Layouts.ID_XXX bit is set fetch only those DIDs which are represented in the ID_XXX external file
  h.parent_proxid;
  h.ultimate_proxid;
  h.has_lgid;
  h.empid;
  h.powid;
  h.source;
  h.source_record_id;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.cnp_name;
  h.company_phone;
  h.company_fein;
  h.company_sic_code1;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.p_city_name;
  h.st;
  SET OF TYPEOF(h.zip)zip_cases;
  h.company_url;
  h.isContact;
  h.title;
  h.fname;
  h.mname;
  h.lname;
  h.name_suffix;
  h.contact_email;
  SALT38.StrType CONTACTNAME;//Wordbag field for concept
  SALT38.StrType STREETADDRESS;//Wordbag field for concept
  UNSIGNED UserPermits := 0;
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show proxid if it has a record which fully matches
  SALT38.UIDType Entered_rcid := 0; // Allow user to enter rcid to pull data
  SALT38.UIDType Entered_proxid := 0; // Allow user to enter proxid to pull data
  SALT38.UIDType Entered_seleid := 0; // Allow user to enter seleid to pull data
  SALT38.UIDType Entered_orgid := 0; // Allow user to enter orgid to pull data
  SALT38.UIDType Entered_ultid := 0; // Allow user to enter ultid to pull data
END;
// Used to clean input to MEOW process that is already in input layout
EXPORT CleanInput(DATASET(InputLayout) inData) := FUNCTION
  InputLayout CleanT(inData le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.parent_proxid := (TYPEOF(SELF.parent_proxid))le.parent_proxid;
    SELF.ultimate_proxid := (TYPEOF(SELF.ultimate_proxid))le.ultimate_proxid;
    SELF.has_lgid := (TYPEOF(SELF.has_lgid))le.has_lgid;
    SELF.empid := (TYPEOF(SELF.empid))le.empid;
    SELF.powid := (TYPEOF(SELF.powid))le.powid;
    SELF.source := (TYPEOF(SELF.source))le.source;
    SELF.source_record_id := (TYPEOF(SELF.source_record_id))le.source_record_id;
    SELF.cnp_number := (TYPEOF(SELF.cnp_number))le.cnp_number;
    SELF.cnp_btype := (TYPEOF(SELF.cnp_btype))le.cnp_btype;
    SELF.cnp_lowv := (TYPEOF(SELF.cnp_lowv))le.cnp_lowv;
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))PRTE2_BIPV2_WAF.Fields.Make_cnp_name((SALT38.StrType)le.cnp_name);
    SELF.company_phone := (TYPEOF(SELF.company_phone))le.company_phone;
    SELF.company_fein := (TYPEOF(SELF.company_fein))PRTE2_BIPV2_WAF.Fields.Make_company_fein((SALT38.StrType)le.company_fein);
    SELF.company_sic_code1 := (TYPEOF(SELF.company_sic_code1))le.company_sic_code1;
    SELF.prim_range := (TYPEOF(SELF.prim_range))le.prim_range;
    SELF.prim_name := (TYPEOF(SELF.prim_name))PRTE2_BIPV2_WAF.Fields.Make_prim_name((SALT38.StrType)le.prim_name);
    SELF.sec_range := (TYPEOF(SELF.sec_range))PRTE2_BIPV2_WAF.Fields.Make_sec_range((SALT38.StrType)le.sec_range);
    SELF.p_city_name := (TYPEOF(SELF.p_city_name))PRTE2_BIPV2_WAF.Fields.Make_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.st := (TYPEOF(SELF.st))PRTE2_BIPV2_WAF.Fields.Make_st((SALT38.StrType)le.st);
    SELF.zip_cases := le.zip_cases;
    SELF.company_url := (TYPEOF(SELF.company_url))PRTE2_BIPV2_WAF.Fields.Make_company_url((SALT38.StrType)le.company_url);
    SELF.isContact := (TYPEOF(SELF.isContact))le.isContact;
    SELF.title := (TYPEOF(SELF.title))le.title;
    SELF.fname := (TYPEOF(SELF.fname))PRTE2_BIPV2_WAF.Fields.Make_fname((SALT38.StrType)le.fname);
    SELF.mname := (TYPEOF(SELF.mname))PRTE2_BIPV2_WAF.Fields.Make_mname((SALT38.StrType)le.mname);
    SELF.lname := (TYPEOF(SELF.lname))PRTE2_BIPV2_WAF.Fields.Make_lname((SALT38.StrType)le.lname);
    SELF.name_suffix := (TYPEOF(SELF.name_suffix))PRTE2_BIPV2_WAF.Fields.Make_name_suffix((SALT38.StrType)le.name_suffix);
    SELF.contact_email := (TYPEOF(SELF.contact_email))le.contact_email;
    SELF.CONTACTNAME := (TYPEOF(SELF.CONTACTNAME))le.CONTACTNAME;
    SELF.STREETADDRESS := (TYPEOF(SELF.STREETADDRESS))le.STREETADDRESS;
    SELF := le;
  END;
  RETURN PROJECT(inData, CleanT(LEFT));
END;
// A function to turn data in the input layout function into 'baby' match candidates form
EXPORT InputToMC(DATASET(InputLayout) inpu) := FUNCTION
s := Keys(h).Specificities_Key[1];
Layout_Candidates0 := RECORD
  inpu.parent_proxid;
  inpu.ultimate_proxid;
  inpu.has_lgid;
  inpu.empid;
  inpu.powid;
  inpu.source;
  inpu.source_record_id;
  inpu.cnp_number;
  inpu.cnp_btype;
  inpu.cnp_lowv;
  inpu.cnp_name;
  inpu.company_phone;
  inpu.company_fein;
  UNSIGNED1 company_fein_len := LENGTH(TRIM((SALT38.StrType)inpu.company_fein));
  inpu.company_sic_code1;
  inpu.prim_range;
  UNSIGNED1 prim_range_len := LENGTH(TRIM((SALT38.StrType)inpu.prim_range));
  inpu.prim_name;
  UNSIGNED1 prim_name_len := LENGTH(TRIM((SALT38.StrType)inpu.prim_name));
  inpu.sec_range;
  UNSIGNED1 sec_range_len := LENGTH(TRIM((SALT38.StrType)inpu.sec_range));
  inpu.p_city_name;
  UNSIGNED1 p_city_name_len := LENGTH(TRIM((SALT38.StrType)inpu.p_city_name));
  inpu.st;
  TYPEOF(h.zip) zip := inpu.zip_cases[1];
  inpu.company_url;
  inpu.isContact;
  inpu.title;
  inpu.fname;
  UNSIGNED1 fname_len := LENGTH(TRIM((SALT38.StrType)inpu.fname));
  inpu.mname;
  UNSIGNED1 mname_len := LENGTH(TRIM((SALT38.StrType)inpu.mname));
  inpu.lname;
  UNSIGNED1 lname_len := LENGTH(TRIM((SALT38.StrType)inpu.lname));
  inpu.name_suffix;
  inpu.contact_email;
  UNSIGNED4 CONTACTNAME := 0;
  UNSIGNED4 STREETADDRESS := 0;
  rcid := inpu.Entered_rcid;
  ultid := inpu.Entered_ultid;
  orgid := inpu.Entered_orgid;
  seleid := inpu.Entered_seleid;
  proxid := inpu.Entered_proxid;
END;
mc0 := TABLE(inpu,Layout_Candidates0);
Layout_Candidates := RECORD
  {mc0} AND NOT [cnp_name,company_url]; // remove wordbag fields which need to be expanded
  INTEGER2 empid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN empid_isnull := (mc0.empid  IN SET(s.nulls_empid,empid) OR mc0.empid = (TYPEOF(mc0.empid))''); // Simplify later processing 
  INTEGER2 powid_weight100 := 0; // Contains 100x the specificity
  BOOLEAN powid_isnull := (mc0.powid  IN SET(s.nulls_powid,powid) OR mc0.powid = (TYPEOF(mc0.powid))''); // Simplify later processing 
  INTEGER2 source_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_isnull := (mc0.source  IN SET(s.nulls_source,source) OR mc0.source = (TYPEOF(mc0.source))''); // Simplify later processing 
  INTEGER2 source_record_id_weight100 := 0; // Contains 100x the specificity
  BOOLEAN source_record_id_isnull := (mc0.source_record_id  IN SET(s.nulls_source_record_id,source_record_id) OR mc0.source_record_id = (TYPEOF(mc0.source_record_id))''); // Simplify later processing 
  INTEGER2 cnp_number_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_number_isnull := (mc0.cnp_number  IN SET(s.nulls_cnp_number,cnp_number) OR mc0.cnp_number = (TYPEOF(mc0.cnp_number))''); // Simplify later processing 
  INTEGER2 cnp_btype_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_btype_isnull := (mc0.cnp_btype  IN SET(s.nulls_cnp_btype,cnp_btype) OR mc0.cnp_btype = (TYPEOF(mc0.cnp_btype))''); // Simplify later processing 
  INTEGER2 cnp_lowv_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_lowv_isnull := (mc0.cnp_lowv  IN SET(s.nulls_cnp_lowv,cnp_lowv) OR mc0.cnp_lowv = (TYPEOF(mc0.cnp_lowv))''); // Simplify later processing 
  STRING240 cnp_name := mc0.cnp_name; // Expanded wordbag field
  INTEGER2 cnp_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN cnp_name_isnull := (mc0.cnp_name  IN SET(s.nulls_cnp_name,cnp_name) OR mc0.cnp_name = (TYPEOF(mc0.cnp_name))''); // Simplify later processing 
  INTEGER2 company_phone_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_phone_isnull := (mc0.company_phone  IN SET(s.nulls_company_phone,company_phone) OR mc0.company_phone = (TYPEOF(mc0.company_phone))''); // Simplify later processing 
  INTEGER2 company_fein_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_fein_isnull := (mc0.company_fein  IN SET(s.nulls_company_fein,company_fein) OR mc0.company_fein = (TYPEOF(mc0.company_fein))''); // Simplify later processing 
  UNSIGNED company_fein_cnt := 0; // Number of instances with this particular field value
  UNSIGNED company_fein_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 company_sic_code1_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_sic_code1_isnull := (mc0.company_sic_code1  IN SET(s.nulls_company_sic_code1,company_sic_code1) OR mc0.company_sic_code1 = (TYPEOF(mc0.company_sic_code1))''); // Simplify later processing 
  INTEGER2 prim_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_range_isnull := (mc0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR mc0.prim_range = (TYPEOF(mc0.prim_range))''); // Simplify later processing 
  UNSIGNED prim_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 prim_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN prim_name_isnull := (mc0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR mc0.prim_name = (TYPEOF(mc0.prim_name))''); // Simplify later processing 
  UNSIGNED prim_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED prim_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 sec_range_weight100 := 0; // Contains 100x the specificity
  BOOLEAN sec_range_isnull := (mc0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR mc0.sec_range = (TYPEOF(mc0.sec_range))''); // Simplify later processing 
  UNSIGNED sec_range_cnt := 0; // Number of instances with this particular field value
  UNSIGNED sec_range_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 p_city_name_weight100 := 0; // Contains 100x the specificity
  BOOLEAN p_city_name_isnull := (mc0.p_city_name  IN SET(s.nulls_p_city_name,p_city_name) OR mc0.p_city_name = (TYPEOF(mc0.p_city_name))''); // Simplify later processing 
  UNSIGNED p_city_name_cnt := 0; // Number of instances with this particular field value
  UNSIGNED p_city_name_e1_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 st_weight100 := 0; // Contains 100x the specificity
  BOOLEAN st_isnull := (mc0.st  IN SET(s.nulls_st,st) OR mc0.st = (TYPEOF(mc0.st))''); // Simplify later processing 
  INTEGER2 zip_weight100 := 0; // Contains 100x the specificity
  BOOLEAN zip_isnull := (mc0.zip  IN SET(s.nulls_zip,zip) OR mc0.zip = (TYPEOF(mc0.zip))''); // Simplify later processing 
  STRING240 company_url := mc0.company_url; // Expanded wordbag field
  INTEGER2 company_url_weight100 := 0; // Contains 100x the specificity
  BOOLEAN company_url_isnull := (mc0.company_url  IN SET(s.nulls_company_url,company_url) OR mc0.company_url = (TYPEOF(mc0.company_url))''); // Simplify later processing 
  INTEGER2 isContact_weight100 := 0; // Contains 100x the specificity
  BOOLEAN isContact_isnull := (mc0.isContact  IN SET(s.nulls_isContact,isContact) OR mc0.isContact = (TYPEOF(mc0.isContact))''); // Simplify later processing 
  INTEGER2 title_weight100 := 0; // Contains 100x the specificity
  BOOLEAN title_isnull := (mc0.title  IN SET(s.nulls_title,title) OR mc0.title = (TYPEOF(mc0.title))''); // Simplify later processing 
  INTEGER2 fname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 fname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN fname_isnull := (mc0.fname  IN SET(s.nulls_fname,fname) OR mc0.fname = (TYPEOF(mc0.fname))''); // Simplify later processing 
  UNSIGNED fname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED fname_e1_cnt := 0; // Number of names instances matching this one by edit distance
  STRING20 fname_PreferredName := (STRING20)'';
  UNSIGNED fname_PreferredName_cnt := 0; // Number of names instances matching this one using PreferredName
  INTEGER2 mname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 mname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN mname_isnull := (mc0.mname  IN SET(s.nulls_mname,mname) OR mc0.mname = (TYPEOF(mc0.mname))''); // Simplify later processing 
  UNSIGNED mname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED mname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 lname_weight100 := 0; // Contains 100x the specificity
  INTEGER2 lname_initial_char_weight100 := 0; // Contains 100x the specificity
  BOOLEAN lname_isnull := (mc0.lname  IN SET(s.nulls_lname,lname) OR mc0.lname = (TYPEOF(mc0.lname))''); // Simplify later processing 
  UNSIGNED lname_cnt := 0; // Number of instances with this particular field value
  UNSIGNED lname_e2_cnt := 0; // Number of names instances matching this one by edit distance
  INTEGER2 name_suffix_weight100 := 0; // Contains 100x the specificity
  BOOLEAN name_suffix_isnull := (mc0.name_suffix  IN SET(s.nulls_name_suffix,name_suffix) OR mc0.name_suffix = (TYPEOF(mc0.name_suffix))''); // Simplify later processing 
  UNSIGNED name_suffix_cnt := 0; // Number of instances with this particular field value
  STRING5 name_suffix_NormSuffix := (STRING5)'';
  UNSIGNED name_suffix_NormSuffix_cnt := 0; // Number of names instances matching this one using NormSuffix
  INTEGER2 contact_email_weight100 := 0; // Contains 100x the specificity
  BOOLEAN contact_email_isnull := (mc0.contact_email  IN SET(s.nulls_contact_email,contact_email) OR mc0.contact_email = (TYPEOF(mc0.contact_email))''); // Simplify later processing 
  INTEGER2 CONTACTNAME_weight100 := 0; // Contains 100x the specificity
  BOOLEAN CONTACTNAME_isnull := ((mc0.fname  IN SET(s.nulls_fname,fname) OR mc0.fname = (TYPEOF(mc0.fname))'') AND (mc0.mname  IN SET(s.nulls_mname,mname) OR mc0.mname = (TYPEOF(mc0.mname))'') AND (mc0.lname  IN SET(s.nulls_lname,lname) OR mc0.lname = (TYPEOF(mc0.lname))'')); // Simplify later processing 
  INTEGER2 STREETADDRESS_weight100 := 0; // Contains 100x the specificity
  BOOLEAN STREETADDRESS_isnull := ((mc0.prim_range  IN SET(s.nulls_prim_range,prim_range) OR mc0.prim_range = (TYPEOF(mc0.prim_range))'') AND (mc0.prim_name  IN SET(s.nulls_prim_name,prim_name) OR mc0.prim_name = (TYPEOF(mc0.prim_name))'') AND (mc0.sec_range  IN SET(s.nulls_sec_range,sec_range) OR mc0.sec_range = (TYPEOF(mc0.sec_range))'')); // Simplify later processing 
END;
mc1 := TABLE(mc0,Layout_Candidates);
Layout_Candidates do_computes(Layout_Candidates le) := TRANSFORM
  SELF.CONTACTNAME := IF (Fields.InValid_CONTACTNAME((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname)>0,0,HASH32((SALT38.StrType)le.fname,(SALT38.StrType)le.mname,(SALT38.StrType)le.lname)); // Combine child fields into 1 for specificity counting
  SELF.STREETADDRESS := IF (Fields.InValid_STREETADDRESS((SALT38.StrType)le.prim_range,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.sec_range)>0,0,HASH32((SALT38.StrType)le.prim_range,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.sec_range)); // Combine child fields into 1 for specificity counting
  SELF := le;
END;
mc := PROJECT(mc1,do_computes(LEFT));
ih := h;
//Now add the weights of each field one by one
 
layout_candidates add_contact_email(layout_candidates le,Specificities(ih).contact_email_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.contact_email_weight100 := MAP (le.contact_email_isnull => 0, patch_default and ri.field_specificity=0 => s.contact_email_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j29 := JOIN(mc,PULL(Specificities(ih).contact_email_values_persisted),LEFT.contact_email=RIGHT.contact_email,add_contact_email(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_lowv(layout_candidates le,Specificities(ih).cnp_lowv_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_lowv_weight100 := MAP (le.cnp_lowv_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_lowv_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j28 := JOIN(j29,PULL(Specificities(ih).cnp_lowv_values_persisted),LEFT.cnp_lowv=RIGHT.cnp_lowv,add_cnp_lowv(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_btype(layout_candidates le,Specificities(ih).cnp_btype_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_btype_weight100 := MAP (le.cnp_btype_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_btype_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j27 := JOIN(j28,PULL(Specificities(ih).cnp_btype_values_persisted),LEFT.cnp_btype=RIGHT.cnp_btype,add_cnp_btype(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_cnp_number(layout_candidates le,Specificities(ih).cnp_number_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_number_weight100 := MAP (le.cnp_number_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_number_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j26 := JOIN(j27,PULL(Specificities(ih).cnp_number_values_persisted),LEFT.cnp_number=RIGHT.cnp_number,add_cnp_number(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_powid(layout_candidates le,Specificities(ih).powid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.powid_weight100 := MAP (le.powid_isnull => 0, patch_default and ri.field_specificity=0 => s.powid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j25 := JOIN(j26,PULL(Specificities(ih).powid_values_persisted),LEFT.powid=RIGHT.powid,add_powid(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_empid(layout_candidates le,Specificities(ih).empid_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.empid_weight100 := MAP (le.empid_isnull => 0, patch_default and ri.field_specificity=0 => s.empid_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j24 := JOIN(j25,PULL(Specificities(ih).empid_values_persisted),LEFT.empid=RIGHT.empid,add_empid(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_title(layout_candidates le,Specificities(ih).title_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.title_weight100 := MAP (le.title_isnull => 0, patch_default and ri.field_specificity=0 => s.title_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j20 := JOIN(j24,PULL(Specificities(ih).title_values_persisted),LEFT.title=RIGHT.title,add_title(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_isContact(layout_candidates le,Specificities(ih).isContact_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.isContact_weight100 := MAP (le.isContact_isnull => 0, patch_default and ri.field_specificity=0 => s.isContact_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j19 := JOIN(j20,PULL(Specificities(ih).isContact_values_persisted),LEFT.isContact=RIGHT.isContact,add_isContact(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_source(layout_candidates le,Specificities(ih).source_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_weight100 := MAP (le.source_isnull => 0, patch_default and ri.field_specificity=0 => s.source_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j18 := JOIN(j19,PULL(Specificities(ih).source_values_persisted),LEFT.source=RIGHT.source,add_source(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_st(layout_candidates le,Specificities(ih).st_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.st_weight100 := MAP (le.st_isnull => 0, patch_default and ri.field_specificity=0 => s.st_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
j17 := JOIN(j18,PULL(Specificities(ih).st_values_persisted),LEFT.st=RIGHT.st,add_st(LEFT,RIGHT,TRUE),LOOKUP,FEW,LEFT OUTER);
layout_candidates add_name_suffix(layout_candidates le,Specificities(ih).name_suffix_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.name_suffix_cnt := ri.cnt;
  SELF.name_suffix_NormSuffix_cnt := ri.NormSuffix_cnt; // Copy in count of matching NormSuffix values for field name_suffix
  SELF.name_suffix_NormSuffix := ri.name_suffix_NormSuffix; // Copy NormSuffix value for field name_suffix
  SELF.name_suffix_weight100 := MAP (le.name_suffix_isnull => 0, patch_default and ri.field_specificity=0 => s.name_suffix_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j17,s.nulls_name_suffix,Specificities(ih).name_suffix_values_persisted,name_suffix,name_suffix_weight100,add_name_suffix,j16);
layout_candidates add_fname(layout_candidates le,Specificities(ih).fname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.fname_cnt := ri.cnt;
  SELF.fname_e1_cnt := ri.e1_cnt;
  SELF.fname_PreferredName_cnt := ri.PreferredName_cnt; // Copy in count of matching PreferredName values for field fname
  SELF.fname_PreferredName := ri.fname_PreferredName; // Copy PreferredName value for field fname
  SELF.fname_weight100 := MAP (le.fname_isnull => 0, patch_default and ri.field_specificity=0 => s.fname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.fname_initial_char_weight100 := MAP (le.fname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j16,s.nulls_fname,Specificities(ih).fname_values_persisted,fname,fname_weight100,add_fname,j15);
layout_candidates add_mname(layout_candidates le,Specificities(ih).mname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.mname_cnt := ri.cnt;
  SELF.mname_e2_cnt := ri.e2_cnt;
  SELF.mname_weight100 := MAP (le.mname_isnull => 0, patch_default and ri.field_specificity=0 => s.mname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.mname_initial_char_weight100 := MAP (le.mname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j15,s.nulls_mname,Specificities(ih).mname_values_persisted,mname,mname_weight100,add_mname,j14);
layout_candidates add_lname(layout_candidates le,Specificities(ih).lname_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.lname_cnt := ri.cnt;
  SELF.lname_e2_cnt := ri.e2_cnt;
  SELF.lname_weight100 := MAP (le.lname_isnull => 0, patch_default and ri.field_specificity=0 => s.lname_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.lname_initial_char_weight100 := MAP (le.lname_isnull => 0, ri.InitialChar_specificity) * 100;
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j14,s.nulls_lname,Specificities(ih).lname_values_persisted,lname,lname_weight100,add_lname,j13);
layout_candidates add_company_sic_code1(layout_candidates le,Specificities(ih).company_sic_code1_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_sic_code1_weight100 := MAP (le.company_sic_code1_isnull => 0, patch_default and ri.field_specificity=0 => s.company_sic_code1_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j13,s.nulls_company_sic_code1,Specificities(ih).company_sic_code1_values_persisted,company_sic_code1,company_sic_code1_weight100,add_company_sic_code1,j12);
layout_candidates add_p_city_name(layout_candidates le,Specificities(ih).p_city_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.p_city_name_cnt := ri.cnt;
  SELF.p_city_name_e1_cnt := ri.e1_cnt;
  SELF.p_city_name_weight100 := MAP (le.p_city_name_isnull => 0, patch_default and ri.field_specificity=0 => s.p_city_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j12,s.nulls_p_city_name,Specificities(ih).p_city_name_values_persisted,p_city_name,p_city_name_weight100,add_p_city_name,j11);
layout_candidates add_sec_range(layout_candidates le,Specificities(ih).sec_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.sec_range_cnt := ri.cnt;
  SELF.sec_range_e1_cnt := ri.e1_cnt;
  SELF.sec_range_weight100 := MAP (le.sec_range_isnull => 0, patch_default and ri.field_specificity=0 => s.sec_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j11,s.nulls_sec_range,Specificities(ih).sec_range_values_persisted,sec_range,sec_range_weight100,add_sec_range,j10);
layout_candidates add_prim_range(layout_candidates le,Specificities(ih).prim_range_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_range_cnt := ri.cnt;
  SELF.prim_range_e1_cnt := ri.e1_cnt;
  SELF.prim_range_weight100 := MAP (le.prim_range_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_range_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j10,s.nulls_prim_range,Specificities(ih).prim_range_values_persisted,prim_range,prim_range_weight100,add_prim_range,j9);
layout_candidates add_zip(layout_candidates le,Specificities(ih).zip_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.zip_weight100 := MAP (le.zip_isnull => 0, patch_default and ri.field_specificity=0 => s.zip_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j9,s.nulls_zip,Specificities(ih).zip_values_persisted,zip,zip_weight100,add_zip,j8);
layout_candidates add_prim_name(layout_candidates le,Specificities(ih).prim_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.prim_name_cnt := ri.cnt;
  SELF.prim_name_e1_cnt := ri.e1_cnt;
  SELF.prim_name_weight100 := MAP (le.prim_name_isnull => 0, patch_default and ri.field_specificity=0 => s.prim_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j8,s.nulls_prim_name,Specificities(ih).prim_name_values_persisted,prim_name,prim_name_weight100,add_prim_name,j7);
layout_candidates add_STREETADDRESS(layout_candidates le,Specificities(ih).STREETADDRESS_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.STREETADDRESS_weight100 := MAP (le.STREETADDRESS_isnull => 0, patch_default and ri.field_specificity=0 => s.STREETADDRESS_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j7,s.nulls_STREETADDRESS,Specificities(ih).STREETADDRESS_values_persisted,STREETADDRESS,STREETADDRESS_weight100,add_STREETADDRESS,j6);
layout_candidates add_CONTACTNAME(layout_candidates le,Specificities(ih).CONTACTNAME_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.CONTACTNAME_weight100 := MAP (le.CONTACTNAME_isnull => 0, patch_default and ri.field_specificity=0 => s.CONTACTNAME_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j6,s.nulls_CONTACTNAME,Specificities(ih).CONTACTNAME_values_persisted,CONTACTNAME,CONTACTNAME_weight100,add_CONTACTNAME,j5);
layout_candidates add_cnp_name(layout_candidates le,Specificities(ih).cnp_name_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.cnp_name_weight100 := MAP (le.cnp_name_isnull => 0, patch_default and ri.field_specificity=0 => s.cnp_name_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.cnp_name := IF( ri.field_specificity<>0 or ri.word<>'',SELF.cnp_name_weight100+' '+ri.word,SALT38.Fn_WordBag_AppendSpecs_Fake(le.cnp_name, s.cnp_name_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j5,s.nulls_cnp_name,Specificities(ih).cnp_name_values_persisted,cnp_name,cnp_name_weight100,add_cnp_name,j4);
layout_candidates add_company_url(layout_candidates le,Specificities(ih).company_url_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_url_weight100 := MAP (le.company_url_isnull => 0, patch_default and ri.field_specificity=0 => s.company_url_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF.company_url := IF( ri.field_specificity<>0 or ri.word<>'',SELF.company_url_weight100+' '+ri.word,SALT38.Fn_WordBag_AppendSpecs_Fake(le.company_url, s.company_url_specificity) );// Copy in annotated wordstring
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j4,s.nulls_company_url,Specificities(ih).company_url_values_persisted,company_url,company_url_weight100,add_company_url,j3);
layout_candidates add_company_fein(layout_candidates le,Specificities(ih).company_fein_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_fein_cnt := ri.cnt;
  SELF.company_fein_e1_cnt := ri.e1_cnt;
  SELF.company_fein_weight100 := MAP (le.company_fein_isnull => 0, patch_default and ri.field_specificity=0 => s.company_fein_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j3,s.nulls_company_fein,Specificities(ih).company_fein_values_persisted,company_fein,company_fein_weight100,add_company_fein,j2);
layout_candidates add_company_phone(layout_candidates le,Specificities(ih).company_phone_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.company_phone_weight100 := MAP (le.company_phone_isnull => 0, patch_default and ri.field_specificity=0 => s.company_phone_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j2,s.nulls_company_phone,Specificities(ih).company_phone_values_persisted,company_phone,company_phone_weight100,add_company_phone,j1);
layout_candidates add_source_record_id(layout_candidates le,Specificities(ih).source_record_id_values_persisted ri,BOOLEAN patch_default) := TRANSFORM
  SELF.source_record_id_weight100 := MAP (le.source_record_id_isnull => 0, patch_default and ri.field_specificity=0 => s.source_record_id_maximum, ri.field_specificity) * 100; // If never seen before - must be rare
  SELF := le;
END;
SALT38.MAC_Choose_JoinType(j1,s.nulls_source_record_id,Specificities(ih).source_record_id_values_persisted,source_record_id,source_record_id_weight100,add_source_record_id,j0);
Layout_Scaled_Candidates := RECORD
  j0;
  UNSIGNED2 prim_range_e1_Weight100;
  UNSIGNED2 prim_name_e1_Weight100;
  UNSIGNED2 sec_range_e1_Weight100;
  UNSIGNED2 fname_e1_Weight100;
  UNSIGNED2 fname_PreferredName_Weight100;
  UNSIGNED2 mname_e2_Weight100;
  UNSIGNED2 lname_e2_Weight100;
END;
Layout_Scaled_Candidates ProcessConceptScaling(j0 le) := TRANSFORM
  REAL CONTACTNAME_score_scale := le.CONTACTNAME_weight100 / (le.fname_weight100 + le.mname_weight100 + le.lname_weight100); // Scaling factor for this concept
  SELF.fname_weight100 := SALT38.Min0(le.fname_weight100*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale)); // Precompute the scale
  SELF.fname_e1_Weight100 := SALT38.Min0(le.fname_weight100 + 100*log(le.fname_cnt/le.fname_e1_cnt)/log(2))*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale); // Precompute edit-distance specificity
  SELF.fname_PreferredName_Weight100 := SALT38.Min0(le.fname_weight100 + 100*log(le.fname_cnt/le.fname_PreferredName_cnt)*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale)/log(2)); // Precompute PreferredName specificity
  SELF.mname_weight100 := SALT38.Min0(le.mname_weight100*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale)); // Precompute the scale
  SELF.mname_e2_Weight100 := SALT38.Min0(le.mname_weight100 + 100*log(le.mname_cnt/le.mname_e2_cnt)/log(2))*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale); // Precompute edit-distance specificity
  SELF.lname_weight100 := SALT38.Min0(le.lname_weight100*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale)); // Precompute the scale
  SELF.lname_e2_Weight100 := SALT38.Min0(le.lname_weight100 + 100*log(le.lname_cnt/le.lname_e2_cnt)/log(2))*IF(CONTACTNAME_score_scale=0,1,CONTACTNAME_score_scale); // Precompute edit-distance specificity
  REAL STREETADDRESS_score_scale := le.STREETADDRESS_weight100 / (le.prim_range_weight100 + le.prim_name_weight100 + le.sec_range_weight100); // Scaling factor for this concept
  SELF.prim_range_weight100 := SALT38.Min0(le.prim_range_weight100*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale)); // Precompute the scale
  SELF.prim_range_e1_Weight100 := SALT38.Min0(le.prim_range_weight100 + 100*log(le.prim_range_cnt/le.prim_range_e1_cnt)/log(2))*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale); // Precompute edit-distance specificity
  SELF.prim_name_weight100 := SALT38.Min0(le.prim_name_weight100*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale)); // Precompute the scale
  SELF.prim_name_e1_Weight100 := SALT38.Min0(le.prim_name_weight100 + 100*log(le.prim_name_cnt/le.prim_name_e1_cnt)/log(2))*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale); // Precompute edit-distance specificity
  SELF.sec_range_weight100 := SALT38.Min0(le.sec_range_weight100*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale)); // Precompute the scale
  SELF.sec_range_e1_Weight100 := SALT38.Min0(le.sec_range_weight100 + 100*log(le.sec_range_cnt/le.sec_range_e1_cnt)/log(2))*IF(STREETADDRESS_score_scale=0,1,STREETADDRESS_score_scale); // Precompute edit-distance specificity
  SELF := le;
END;
scaled := PROJECT(j0,ProcessConceptScaling(LEFT));
RETURN scaled;
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.cnp_name <> (typeof(le.cnp_name))'' OR le.cnp_name <> (typeof(le.cnp_name))'' AND le.st <> (typeof(le.st))'' OR le.prim_name <> (typeof(le.prim_name))'' AND le.p_city_name <> (typeof(le.p_city_name))'' AND le.st <> (typeof(le.st))'' OR le.prim_name <> (typeof(le.prim_name))'' AND le.zip_cases <> [] OR le.company_phone <> (typeof(le.company_phone))'' OR le.company_fein <> (typeof(le.company_fein))'' OR le.fname <> (typeof(le.fname))'' AND le.lname <> (typeof(le.lname))'' OR le.company_url <> (typeof(le.company_url))'' OR le.contact_email <> (typeof(le.contact_email))'' OR le.source_record_id <> (typeof(le.source_record_id))'' AND le.source <> (typeof(le.source))'';
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.proxid;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT38.UIDType Reference := 0;//Presently for batch
  h.seleid; // Parent id - in case child does not resolve
  h.orgid; // Parent id - in case child does not resolve
  h.ultid; // Parent id - in case child does not resolve
  SALT38.UIDType rcid := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.parent_proxid) parent_proxid := (TYPEOF(h.parent_proxid))'';
  INTEGER2 parent_proxidWeight := 0;
  INTEGER1 parent_proxid_match_code := 0;
  TYPEOF(h.ultimate_proxid) ultimate_proxid := (TYPEOF(h.ultimate_proxid))'';
  INTEGER2 ultimate_proxidWeight := 0;
  INTEGER1 ultimate_proxid_match_code := 0;
  TYPEOF(h.has_lgid) has_lgid := (TYPEOF(h.has_lgid))'';
  INTEGER2 has_lgidWeight := 0;
  INTEGER1 has_lgid_match_code := 0;
  TYPEOF(h.empid) empid := (TYPEOF(h.empid))'';
  INTEGER2 empidWeight := 0;
  INTEGER1 empid_match_code := 0;
  TYPEOF(h.powid) powid := (TYPEOF(h.powid))'';
  INTEGER2 powidWeight := 0;
  INTEGER1 powid_match_code := 0;
  TYPEOF(h.source) source := (TYPEOF(h.source))'';
  INTEGER2 sourceWeight := 0;
  INTEGER1 source_match_code := 0;
  TYPEOF(h.source_record_id) source_record_id := (TYPEOF(h.source_record_id))'';
  INTEGER2 source_record_idWeight := 0;
  INTEGER1 source_record_id_match_code := 0;
  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';
  INTEGER2 cnp_numberWeight := 0;
  INTEGER1 cnp_number_match_code := 0;
  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';
  INTEGER2 cnp_btypeWeight := 0;
  INTEGER1 cnp_btype_match_code := 0;
  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';
  INTEGER2 cnp_lowvWeight := 0;
  INTEGER1 cnp_lowv_match_code := 0;
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  INTEGER2 cnp_nameWeight := 0;
  INTEGER1 cnp_name_match_code := 0;
  TYPEOF(h.company_phone) company_phone := (TYPEOF(h.company_phone))'';
  INTEGER2 company_phoneWeight := 0;
  INTEGER1 company_phone_match_code := 0;
  TYPEOF(h.company_fein) company_fein := (TYPEOF(h.company_fein))'';
  INTEGER2 company_feinWeight := 0;
  INTEGER1 company_fein_match_code := 0;
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  INTEGER2 company_sic_code1Weight := 0;
  INTEGER1 company_sic_code1_match_code := 0;
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  INTEGER2 prim_rangeWeight := 0;
  INTEGER1 prim_range_match_code := 0;
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  INTEGER2 prim_nameWeight := 0;
  INTEGER1 prim_name_match_code := 0;
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  INTEGER2 sec_rangeWeight := 0;
  INTEGER1 sec_range_match_code := 0;
  TYPEOF(h.p_city_name) p_city_name := (TYPEOF(h.p_city_name))'';
  INTEGER2 p_city_nameWeight := 0;
  INTEGER1 p_city_name_match_code := 0;
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  INTEGER2 stWeight := 0;
  INTEGER1 st_match_code := 0;
  DATASET(layout_zip_cases) zip_cases := DATASET([],layout_zip_cases);
  INTEGER2 zipWeight := 0;
  INTEGER1 zip_match_code := 0;
  TYPEOF(h.company_url) company_url := (TYPEOF(h.company_url))'';
  INTEGER2 company_urlWeight := 0;
  INTEGER1 company_url_match_code := 0;
  TYPEOF(h.isContact) isContact := (TYPEOF(h.isContact))'';
  INTEGER2 isContactWeight := 0;
  INTEGER1 isContact_match_code := 0;
  TYPEOF(h.title) title := (TYPEOF(h.title))'';
  INTEGER2 titleWeight := 0;
  INTEGER1 title_match_code := 0;
  TYPEOF(h.fname) fname := (TYPEOF(h.fname))'';
  INTEGER2 fnameWeight := 0;
  INTEGER1 fname_match_code := 0;
  TYPEOF(h.mname) mname := (TYPEOF(h.mname))'';
  INTEGER2 mnameWeight := 0;
  INTEGER1 mname_match_code := 0;
  TYPEOF(h.lname) lname := (TYPEOF(h.lname))'';
  INTEGER2 lnameWeight := 0;
  INTEGER1 lname_match_code := 0;
  TYPEOF(h.name_suffix) name_suffix := (TYPEOF(h.name_suffix))'';
  INTEGER2 name_suffixWeight := 0;
  INTEGER1 name_suffix_match_code := 0;
  TYPEOF(h.contact_email) contact_email := (TYPEOF(h.contact_email))'';
  INTEGER2 contact_emailWeight := 0;
  INTEGER1 contact_email_match_code := 0;
  SALT38.StrType CONTACTNAME := ''; // Concepts always a wordbag
  INTEGER2 CONTACTNAMEWeight := 0;
  INTEGER1 CONTACTNAME_match_code := 0;
  SALT38.StrType STREETADDRESS := ''; // Concepts always a wordbag
  INTEGER2 STREETADDRESSWeight := 0;
  INTEGER1 STREETADDRESS_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT38.MatchCode.NoMatch, INTEGER1 r_mc=SALT38.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT38.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT38.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT38.MatchCode.NoMatch, INTEGER1 r_mc=SALT38.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  BOOLEAN parent_proxidWeightForcedDown := IF ( isWeightForcedDown(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code),TRUE,FALSE );
  SELF.parent_proxidWeight := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxidWeight, ri.parent_proxidWeight );
  SELF.parent_proxid := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxid, ri.parent_proxid );
  SELF.parent_proxid_match_code := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxid_match_code, ri.parent_proxid_match_code );
  BOOLEAN ultimate_proxidWeightForcedDown := IF ( isWeightForcedDown(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code),TRUE,FALSE );
  SELF.ultimate_proxidWeight := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code ), le.ultimate_proxidWeight, ri.ultimate_proxidWeight );
  SELF.ultimate_proxid := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code ), le.ultimate_proxid, ri.ultimate_proxid );
  SELF.ultimate_proxid_match_code := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code ), le.ultimate_proxid_match_code, ri.ultimate_proxid_match_code );
  BOOLEAN has_lgidWeightForcedDown := IF ( isWeightForcedDown(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code),TRUE,FALSE );
  SELF.has_lgidWeight := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code ), le.has_lgidWeight, ri.has_lgidWeight );
  SELF.has_lgid := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code ), le.has_lgid, ri.has_lgid );
  SELF.has_lgid_match_code := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code ), le.has_lgid_match_code, ri.has_lgid_match_code );
  BOOLEAN empidWeightForcedDown := IF ( isWeightForcedDown(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code),TRUE,FALSE );
  SELF.empidWeight := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code ), le.empidWeight, ri.empidWeight );
  SELF.empid := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code ), le.empid, ri.empid );
  SELF.empid_match_code := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code ), le.empid_match_code, ri.empid_match_code );
  BOOLEAN powidWeightForcedDown := IF ( isWeightForcedDown(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code),TRUE,FALSE );
  SELF.powidWeight := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code ), le.powidWeight, ri.powidWeight );
  SELF.powid := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code ), le.powid, ri.powid );
  SELF.powid_match_code := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code ), le.powid_match_code, ri.powid_match_code );
  BOOLEAN sourceWeightForcedDown := IF ( isWeightForcedDown(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code),TRUE,FALSE );
  SELF.sourceWeight := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.sourceWeight, ri.sourceWeight );
  SELF.source := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.source, ri.source );
  SELF.source_match_code := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.source_match_code, ri.source_match_code );
  BOOLEAN source_record_idWeightForcedDown := IF ( isWeightForcedDown(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code),TRUE,FALSE );
  SELF.source_record_idWeight := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_idWeight, ri.source_record_idWeight );
  SELF.source_record_id := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_id, ri.source_record_id );
  SELF.source_record_id_match_code := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_id_match_code, ri.source_record_id_match_code );
  BOOLEAN cnp_numberWeightForcedDown := IF ( isWeightForcedDown(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code),TRUE,FALSE );
  SELF.cnp_numberWeight := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code ), le.cnp_numberWeight, ri.cnp_numberWeight );
  SELF.cnp_number := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code ), le.cnp_number, ri.cnp_number );
  SELF.cnp_number_match_code := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code ), le.cnp_number_match_code, ri.cnp_number_match_code );
  BOOLEAN cnp_btypeWeightForcedDown := IF ( isWeightForcedDown(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code),TRUE,FALSE );
  SELF.cnp_btypeWeight := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code ), le.cnp_btypeWeight, ri.cnp_btypeWeight );
  SELF.cnp_btype := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code ), le.cnp_btype, ri.cnp_btype );
  SELF.cnp_btype_match_code := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code ), le.cnp_btype_match_code, ri.cnp_btype_match_code );
  BOOLEAN cnp_lowvWeightForcedDown := IF ( isWeightForcedDown(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code),TRUE,FALSE );
  SELF.cnp_lowvWeight := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code ), le.cnp_lowvWeight, ri.cnp_lowvWeight );
  SELF.cnp_lowv := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code ), le.cnp_lowv, ri.cnp_lowv );
  SELF.cnp_lowv_match_code := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code ), le.cnp_lowv_match_code, ri.cnp_lowv_match_code );
  BOOLEAN cnp_nameWeightForcedDown := IF ( isWeightForcedDown(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code),TRUE,FALSE );
  SELF.cnp_nameWeight := IF ( isLeftWinner(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code ), le.cnp_nameWeight, ri.cnp_nameWeight );
  SELF.cnp_name := IF ( isLeftWinner(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code ), le.cnp_name, ri.cnp_name );
  SELF.cnp_name_match_code := IF ( isLeftWinner(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code ), le.cnp_name_match_code, ri.cnp_name_match_code );
  BOOLEAN company_phoneWeightForcedDown := IF ( isWeightForcedDown(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code),TRUE,FALSE );
  SELF.company_phoneWeight := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phoneWeight, ri.company_phoneWeight );
  SELF.company_phone := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phone, ri.company_phone );
  SELF.company_phone_match_code := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phone_match_code, ri.company_phone_match_code );
  BOOLEAN company_feinWeightForcedDown := IF ( isWeightForcedDown(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code),TRUE,FALSE );
  SELF.company_feinWeight := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_feinWeight, ri.company_feinWeight );
  SELF.company_fein := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_fein, ri.company_fein );
  SELF.company_fein_match_code := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_fein_match_code, ri.company_fein_match_code );
  BOOLEAN company_sic_code1WeightForcedDown := IF ( isWeightForcedDown(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code),TRUE,FALSE );
  SELF.company_sic_code1Weight := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1Weight, ri.company_sic_code1Weight );
  SELF.company_sic_code1 := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1, ri.company_sic_code1 );
  SELF.company_sic_code1_match_code := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1_match_code, ri.company_sic_code1_match_code );
  BOOLEAN prim_rangeWeightForcedDown := IF ( isWeightForcedDown(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code),TRUE,FALSE );
  SELF.prim_rangeWeight := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_rangeWeight, ri.prim_rangeWeight );
  SELF.prim_range := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_range, ri.prim_range );
  SELF.prim_range_match_code := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_range_match_code, ri.prim_range_match_code );
  BOOLEAN prim_nameWeightForcedDown := IF ( isWeightForcedDown(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code),TRUE,FALSE );
  SELF.prim_nameWeight := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_nameWeight, ri.prim_nameWeight );
  SELF.prim_name := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_name, ri.prim_name );
  SELF.prim_name_match_code := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_name_match_code, ri.prim_name_match_code );
  BOOLEAN sec_rangeWeightForcedDown := IF ( isWeightForcedDown(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code),TRUE,FALSE );
  SELF.sec_rangeWeight := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_rangeWeight, ri.sec_rangeWeight );
  SELF.sec_range := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_range, ri.sec_range );
  SELF.sec_range_match_code := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_range_match_code, ri.sec_range_match_code );
  BOOLEAN p_city_nameWeightForcedDown := IF ( isWeightForcedDown(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code),TRUE,FALSE );
  SELF.p_city_nameWeight := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code ), le.p_city_nameWeight, ri.p_city_nameWeight );
  SELF.p_city_name := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code ), le.p_city_name, ri.p_city_name );
  SELF.p_city_name_match_code := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code ), le.p_city_name_match_code, ri.p_city_name_match_code );
  BOOLEAN stWeightForcedDown := IF ( isWeightForcedDown(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code),TRUE,FALSE );
  SELF.stWeight := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.stWeight, ri.stWeight );
  SELF.st := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st, ri.st );
  SELF.st_match_code := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st_match_code, ri.st_match_code );
  SELF.zip_cases := DEDUP(SORT(le.zip_cases & ri.zip_cases, zip,-weight ),zip);
  SELF.zipWeight := SUM(SELF.zip_cases(weight>0),weight);
  SELF.zip_match_code := IF ( isLeftWinner(le.zipWeight,ri.zipWeight,le.zip_match_code,ri.zip_match_code ), le.zip_match_code, ri.zip_match_code );
  BOOLEAN company_urlWeightForcedDown := IF ( isWeightForcedDown(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code),TRUE,FALSE );
  SELF.company_urlWeight := IF ( isLeftWinner(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code ), le.company_urlWeight, ri.company_urlWeight );
  SELF.company_url := IF ( isLeftWinner(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code ), le.company_url, ri.company_url );
  SELF.company_url_match_code := IF ( isLeftWinner(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code ), le.company_url_match_code, ri.company_url_match_code );
  BOOLEAN isContactWeightForcedDown := IF ( isWeightForcedDown(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code),TRUE,FALSE );
  SELF.isContactWeight := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContactWeight, ri.isContactWeight );
  SELF.isContact := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContact, ri.isContact );
  SELF.isContact_match_code := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContact_match_code, ri.isContact_match_code );
  BOOLEAN titleWeightForcedDown := IF ( isWeightForcedDown(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code),TRUE,FALSE );
  SELF.titleWeight := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.titleWeight, ri.titleWeight );
  SELF.title := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.title, ri.title );
  SELF.title_match_code := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.title_match_code, ri.title_match_code );
  BOOLEAN fnameWeightForcedDown := IF ( isWeightForcedDown(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code),TRUE,FALSE );
  SELF.fnameWeight := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fnameWeight, ri.fnameWeight );
  SELF.fname := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fname, ri.fname );
  SELF.fname_match_code := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fname_match_code, ri.fname_match_code );
  BOOLEAN mnameWeightForcedDown := IF ( isWeightForcedDown(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code),TRUE,FALSE );
  SELF.mnameWeight := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code ), le.mnameWeight, ri.mnameWeight );
  SELF.mname := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code ), le.mname, ri.mname );
  SELF.mname_match_code := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code ), le.mname_match_code, ri.mname_match_code );
  BOOLEAN lnameWeightForcedDown := IF ( isWeightForcedDown(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code),TRUE,FALSE );
  SELF.lnameWeight := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code ), le.lnameWeight, ri.lnameWeight );
  SELF.lname := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code ), le.lname, ri.lname );
  SELF.lname_match_code := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code ), le.lname_match_code, ri.lname_match_code );
  BOOLEAN name_suffixWeightForcedDown := IF ( isWeightForcedDown(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code),TRUE,FALSE );
  SELF.name_suffixWeight := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code ), le.name_suffixWeight, ri.name_suffixWeight );
  SELF.name_suffix := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code ), le.name_suffix, ri.name_suffix );
  SELF.name_suffix_match_code := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code ), le.name_suffix_match_code, ri.name_suffix_match_code );
  BOOLEAN contact_emailWeightForcedDown := IF ( isWeightForcedDown(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code),TRUE,FALSE );
  SELF.contact_emailWeight := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_emailWeight, ri.contact_emailWeight );
  SELF.contact_email := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_email, ri.contact_email );
  SELF.contact_email_match_code := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_email_match_code, ri.contact_email_match_code );
  BOOLEAN DirectCONTACTNAMEWeightForcedDown := IF ( isWeightForcedDown(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code),TRUE,FALSE );
  BOOLEAN CONTACTNAMEWeightForcedDown := fnameWeightForcedDown OR mnameWeightForcedDown OR lnameWeightForcedDown;
  SELF.CONTACTNAMEWeight := MAP (
      DirectCONTACTNAMEWeightForcedDown => IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code ), le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight ),
      CONTACTNAMEWeightForcedDown AND (le.CONTACTNAME_match_code = ri.CONTACTNAME_match_code) => MIN(le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight),
      IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code ), le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight ));
  SELF.CONTACTNAME_match_code :=  MAP (
      DirectCONTACTNAMEWeightForcedDown => IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code ), le.CONTACTNAME_match_code, ri.CONTACTNAME_match_code ),
      CONTACTNAMEWeightForcedDown AND (le.CONTACTNAME_match_code = ri.CONTACTNAME_match_code) AND MIN(le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight)=le.CONTACTNAMEWeight => le.CONTACTNAME_match_code,
      CONTACTNAMEWeightForcedDown AND (le.CONTACTNAME_match_code = ri.CONTACTNAME_match_code) AND MIN(le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight)=ri.CONTACTNAMEWeight => ri.CONTACTNAME_match_code,
      IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code ), le.CONTACTNAME_match_code, ri.CONTACTNAME_match_code ));
  BOOLEAN DirectSTREETADDRESSWeightForcedDown := IF ( isWeightForcedDown(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code),TRUE,FALSE );
  BOOLEAN STREETADDRESSWeightForcedDown := prim_rangeWeightForcedDown OR prim_nameWeightForcedDown OR sec_rangeWeightForcedDown;
  SELF.STREETADDRESSWeight := MAP (
      DirectSTREETADDRESSWeightForcedDown => IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code ), le.STREETADDRESSWeight, ri.STREETADDRESSWeight ),
      STREETADDRESSWeightForcedDown AND (le.STREETADDRESS_match_code = ri.STREETADDRESS_match_code) => MIN(le.STREETADDRESSWeight, ri.STREETADDRESSWeight),
      IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code ), le.STREETADDRESSWeight, ri.STREETADDRESSWeight ));
  SELF.STREETADDRESS_match_code :=  MAP (
      DirectSTREETADDRESSWeightForcedDown => IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code ), le.STREETADDRESS_match_code, ri.STREETADDRESS_match_code ),
      STREETADDRESSWeightForcedDown AND (le.STREETADDRESS_match_code = ri.STREETADDRESS_match_code) AND MIN(le.STREETADDRESSWeight, ri.STREETADDRESSWeight)=le.STREETADDRESSWeight => le.STREETADDRESS_match_code,
      STREETADDRESSWeightForcedDown AND (le.STREETADDRESS_match_code = ri.STREETADDRESS_match_code) AND MIN(le.STREETADDRESSWeight, ri.STREETADDRESSWeight)=ri.STREETADDRESSWeight => ri.STREETADDRESS_match_code,
      IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code ), le.STREETADDRESS_match_code, ri.STREETADDRESS_match_code ));
  SELF.proxid := IF ( le.proxid=ri.proxid, le.proxid, 0 ); // Zero out if collapsing a parent
  SELF.seleid := IF ( le.seleid=ri.seleid, le.seleid, 0 ); // Zero out if collapsing a parent
  SELF.orgid := IF ( le.orgid=ri.orgid, le.orgid, 0 ); // Zero out if collapsing a parent
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  INTEGER2 Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.powidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
  SELF.Weight := IF(Weight>0,Weight,MAX(le.Weight,ri.Weight));
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN IsTruncated := FALSE; // more results available than were returned
  BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  BOOLEAN Resolved_seleid := FALSE; // certain with 3 nines of accuracy
  BOOLEAN Resolved_orgid := FALSE; // certain with 3 nines of accuracy
  BOOLEAN Resolved_ultid := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  DATASET(LayoutScoredFetch) Results_seleid;
  DATASET(LayoutScoredFetch) Results_orgid;
  DATASET(LayoutScoredFetch) Results_ultid;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT38.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-5)) = 1;
  SELF.Resolved_seleid := COUNT(SELF.results_seleid(Weight>=MAX(SELF.results_seleid,Weight)-5)) = 1;
  SELF.Resolved_orgid := COUNT(SELF.results_orgid(Weight>=MAX(SELF.results_orgid,Weight)-5)) = 1;
  SELF.Resolved_ultid := COUNT(SELF.results_ultid(Weight>=MAX(SELF.results_ultid,Weight)-5)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT38.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.parent_proxidWeight = 0,'','|'+IF(le.parent_proxidWeight < 0,'-','')+'parent_proxid')+IF(le.ultimate_proxidWeight = 0,'','|'+IF(le.ultimate_proxidWeight < 0,'-','')+'ultimate_proxid')+IF(le.has_lgidWeight = 0,'','|'+IF(le.has_lgidWeight < 0,'-','')+'has_lgid')+IF(le.empidWeight = 0,'','|'+IF(le.empidWeight < 0,'-','')+'empid')+IF(le.powidWeight = 0,'','|'+IF(le.powidWeight < 0,'-','')+'powid')+IF(le.sourceWeight = 0,'','|'+IF(le.sourceWeight < 0,'-','')+'source')+IF(le.source_record_idWeight = 0,'','|'+IF(le.source_record_idWeight < 0,'-','')+'source_record_id')+IF(le.cnp_numberWeight = 0,'','|'+IF(le.cnp_numberWeight < 0,'-','')+'cnp_number')+IF(le.cnp_btypeWeight = 0,'','|'+IF(le.cnp_btypeWeight < 0,'-','')+'cnp_btype')+IF(le.cnp_lowvWeight = 0,'','|'+IF(le.cnp_lowvWeight < 0,'-','')+'cnp_lowv')+IF(le.cnp_nameWeight = 0,'','|'+IF(le.cnp_nameWeight < 0,'-','')+'cnp_name')+IF(le.company_phoneWeight = 0,'','|'+IF(le.company_phoneWeight < 0,'-','')+'company_phone')+IF(le.company_feinWeight = 0,'','|'+IF(le.company_feinWeight < 0,'-','')+'company_fein')+IF(le.company_sic_code1Weight = 0,'','|'+IF(le.company_sic_code1Weight < 0,'-','')+'company_sic_code1')+IF(le.prim_rangeWeight = 0,'','|'+IF(le.prim_rangeWeight < 0,'-','')+'prim_range')+IF(le.prim_nameWeight = 0,'','|'+IF(le.prim_nameWeight < 0,'-','')+'prim_name')+IF(le.sec_rangeWeight = 0,'','|'+IF(le.sec_rangeWeight < 0,'-','')+'sec_range')+IF(le.p_city_nameWeight = 0,'','|'+IF(le.p_city_nameWeight < 0,'-','')+'p_city_name')+IF(le.stWeight = 0,'','|'+IF(le.stWeight < 0,'-','')+'st')+IF(le.zipWeight = 0,'','|'+IF(le.zipWeight < 0,'-','')+'zip')+IF(le.company_urlWeight = 0,'','|'+IF(le.company_urlWeight < 0,'-','')+'company_url')+IF(le.isContactWeight = 0,'','|'+IF(le.isContactWeight < 0,'-','')+'isContact')+IF(le.titleWeight = 0,'','|'+IF(le.titleWeight < 0,'-','')+'title')+IF(le.fnameWeight = 0,'','|'+IF(le.fnameWeight < 0,'-','')+'fname')+IF(le.mnameWeight = 0,'','|'+IF(le.mnameWeight < 0,'-','')+'mname')+IF(le.lnameWeight = 0,'','|'+IF(le.lnameWeight < 0,'-','')+'lname')+IF(le.name_suffixWeight = 0,'','|'+IF(le.name_suffixWeight < 0,'-','')+'name_suffix')+IF(le.contact_emailWeight = 0,'','|'+IF(le.contact_emailWeight < 0,'-','')+'contact_email')+IF(le.CONTACTNAMEWeight = 0,'','|'+IF(le.CONTACTNAMEWeight < 0,'-','')+'CONTACTNAME')+IF(le.STREETADDRESSWeight = 0,'','|'+IF(le.STREETADDRESSWeight < 0,'-','')+'STREETADDRESS');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
 
EXPORT AdjustKeysUsedAndFailed(DATASET(LayoutScoredFetch) in_data) := FUNCTION
  LayoutScoredFetch AdjustFlags(LayoutScoredFetch le, UNSIGNED4 flag) := TRANSFORM
    SELF.keys_used := le.keys_used | flag;
    SELF.keys_failed := le.keys_failed | flag;
    SELF := le;
  END;
  outR := { UNSIGNED4 keys_failed;};
  outR AggregateFlags(LayoutScoredFetch le, outR ri) := TRANSFORM
    SELF.keys_failed := ri.keys_failed | le.keys_failed;
  END;
  flg := AGGREGATE(in_data(proxid=0),outR,AggregateFlags(LEFT,RIGHT),FEW)[1].keys_failed;
  RETURN IF(COUNT(in_data(proxid=0))>0,PROJECT(in_data(proxid<>0),AdjustFlags(LEFT,flg)),in_data);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  parent_proxidWeight := MAX(GROUP,IF( in_data.parent_proxid_match_code=SALT38.MatchCode.ExactMatch, in_data.parent_proxidWeight,0 ));
  ultimate_proxidWeight := MAX(GROUP,IF( in_data.ultimate_proxid_match_code=SALT38.MatchCode.ExactMatch, in_data.ultimate_proxidWeight,0 ));
  has_lgidWeight := MAX(GROUP,IF( in_data.has_lgid_match_code=SALT38.MatchCode.ExactMatch, in_data.has_lgidWeight,0 ));
  empidWeight := MAX(GROUP,IF( in_data.empid_match_code=SALT38.MatchCode.ExactMatch, in_data.empidWeight,0 ));
  powidWeight := MAX(GROUP,IF( in_data.powid_match_code=SALT38.MatchCode.ExactMatch, in_data.powidWeight,0 ));
  sourceWeight := MAX(GROUP,IF( in_data.source_match_code=SALT38.MatchCode.ExactMatch, in_data.sourceWeight,0 ));
  source_record_idWeight := MAX(GROUP,IF( in_data.source_record_id_match_code=SALT38.MatchCode.ExactMatch, in_data.source_record_idWeight,0 ));
  cnp_numberWeight := MAX(GROUP,IF( in_data.cnp_number_match_code=SALT38.MatchCode.ExactMatch, in_data.cnp_numberWeight,0 ));
  cnp_btypeWeight := MAX(GROUP,IF( in_data.cnp_btype_match_code=SALT38.MatchCode.ExactMatch, in_data.cnp_btypeWeight,0 ));
  cnp_lowvWeight := MAX(GROUP,IF( in_data.cnp_lowv_match_code=SALT38.MatchCode.ExactMatch, in_data.cnp_lowvWeight,0 ));
  cnp_nameWeight := MAX(GROUP,IF( in_data.cnp_name_match_code=SALT38.MatchCode.ExactMatch, in_data.cnp_nameWeight,0 ));
  company_phoneWeight := MAX(GROUP,IF( in_data.company_phone_match_code=SALT38.MatchCode.ExactMatch, in_data.company_phoneWeight,0 ));
  company_feinWeight := MAX(GROUP,IF( in_data.company_fein_match_code=SALT38.MatchCode.ExactMatch, in_data.company_feinWeight,0 ));
  company_sic_code1Weight := MAX(GROUP,IF( in_data.company_sic_code1_match_code=SALT38.MatchCode.ExactMatch, in_data.company_sic_code1Weight,0 ));
  prim_rangeWeight := MAX(GROUP,IF( in_data.prim_range_match_code=SALT38.MatchCode.ExactMatch, in_data.prim_rangeWeight,0 ));
  prim_nameWeight := MAX(GROUP,IF( in_data.prim_name_match_code=SALT38.MatchCode.ExactMatch, in_data.prim_nameWeight,0 ));
  sec_rangeWeight := MAX(GROUP,IF( in_data.sec_range_match_code=SALT38.MatchCode.ExactMatch, in_data.sec_rangeWeight,0 ));
  p_city_nameWeight := MAX(GROUP,IF( in_data.p_city_name_match_code=SALT38.MatchCode.ExactMatch, in_data.p_city_nameWeight,0 ));
  stWeight := MAX(GROUP,IF( in_data.st_match_code=SALT38.MatchCode.ExactMatch, in_data.stWeight,0 ));
  zipWeight := MAX(GROUP,IF( in_data.zip_match_code=SALT38.MatchCode.ExactMatch, in_data.zipWeight,0 ));
  company_urlWeight := MAX(GROUP,IF( in_data.company_url_match_code=SALT38.MatchCode.ExactMatch, in_data.company_urlWeight,0 ));
  isContactWeight := MAX(GROUP,IF( in_data.isContact_match_code=SALT38.MatchCode.ExactMatch, in_data.isContactWeight,0 ));
  titleWeight := MAX(GROUP,IF( in_data.title_match_code=SALT38.MatchCode.ExactMatch, in_data.titleWeight,0 ));
  fnameWeight := MAX(GROUP,IF( in_data.fname_match_code=SALT38.MatchCode.ExactMatch, in_data.fnameWeight,0 ));
  mnameWeight := MAX(GROUP,IF( in_data.mname_match_code=SALT38.MatchCode.ExactMatch, in_data.mnameWeight,0 ));
  lnameWeight := MAX(GROUP,IF( in_data.lname_match_code=SALT38.MatchCode.ExactMatch, in_data.lnameWeight,0 ));
  name_suffixWeight := MAX(GROUP,IF( in_data.name_suffix_match_code=SALT38.MatchCode.ExactMatch, in_data.name_suffixWeight,0 ));
  contact_emailWeight := MAX(GROUP,IF( in_data.contact_email_match_code=SALT38.MatchCode.ExactMatch, in_data.contact_emailWeight,0 ));
  CONTACTNAMEWeight := MAX(GROUP,IF( in_data.CONTACTNAME_match_code=SALT38.MatchCode.ExactMatch, in_data.CONTACTNAMEWeight,0 ));
  STREETADDRESSWeight := MAX(GROUP,IF( in_data.STREETADDRESS_match_code=SALT38.MatchCode.ExactMatch, in_data.STREETADDRESSWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.parent_proxidWeight := MAP( ri.parent_proxidWeight=0 OR le.parent_proxid_match_code=SALT38.MatchCode.ExactMatch => le.parent_proxidWeight,MIN(le.parent_proxidWeight,ri.parent_proxidWeight-1) );
  SELF.ultimate_proxidWeight := MAP( ri.ultimate_proxidWeight=0 OR le.ultimate_proxid_match_code=SALT38.MatchCode.ExactMatch => le.ultimate_proxidWeight,MIN(le.ultimate_proxidWeight,ri.ultimate_proxidWeight-1) );
  SELF.has_lgidWeight := MAP( ri.has_lgidWeight=0 OR le.has_lgid_match_code=SALT38.MatchCode.ExactMatch => le.has_lgidWeight,MIN(le.has_lgidWeight,ri.has_lgidWeight-1) );
  SELF.empidWeight := MAP( ri.empidWeight=0 OR le.empid_match_code=SALT38.MatchCode.ExactMatch => le.empidWeight,MIN(le.empidWeight,ri.empidWeight-1) );
  SELF.powidWeight := MAP( ri.powidWeight=0 OR le.powid_match_code=SALT38.MatchCode.ExactMatch => le.powidWeight,MIN(le.powidWeight,ri.powidWeight-1) );
  SELF.sourceWeight := MAP( ri.sourceWeight=0 OR le.source_match_code=SALT38.MatchCode.ExactMatch => le.sourceWeight,MIN(le.sourceWeight,ri.sourceWeight-1) );
  SELF.source_record_idWeight := MAP( ri.source_record_idWeight=0 OR le.source_record_id_match_code=SALT38.MatchCode.ExactMatch => le.source_record_idWeight,MIN(le.source_record_idWeight,ri.source_record_idWeight-1) );
  SELF.cnp_numberWeight := MAP( ri.cnp_numberWeight=0 OR le.cnp_number_match_code=SALT38.MatchCode.ExactMatch => le.cnp_numberWeight,MIN(le.cnp_numberWeight,ri.cnp_numberWeight-1) );
  SELF.cnp_btypeWeight := MAP( ri.cnp_btypeWeight=0 OR le.cnp_btype_match_code=SALT38.MatchCode.ExactMatch => le.cnp_btypeWeight,MIN(le.cnp_btypeWeight,ri.cnp_btypeWeight-1) );
  SELF.cnp_lowvWeight := MAP( ri.cnp_lowvWeight=0 OR le.cnp_lowv_match_code=SALT38.MatchCode.ExactMatch => le.cnp_lowvWeight,MIN(le.cnp_lowvWeight,ri.cnp_lowvWeight-1) );
  SELF.cnp_nameWeight := MAP( ri.cnp_nameWeight=0 OR le.cnp_name_match_code=SALT38.MatchCode.ExactMatch => le.cnp_nameWeight,MIN(le.cnp_nameWeight,ri.cnp_nameWeight-1) );
  SELF.company_phoneWeight := MAP( ri.company_phoneWeight=0 OR le.company_phone_match_code=SALT38.MatchCode.ExactMatch => le.company_phoneWeight,MIN(le.company_phoneWeight,ri.company_phoneWeight-1) );
  SELF.company_feinWeight := MAP( ri.company_feinWeight=0 OR le.company_fein_match_code=SALT38.MatchCode.ExactMatch => le.company_feinWeight,MIN(le.company_feinWeight,ri.company_feinWeight-1) );
  SELF.company_sic_code1Weight := MAP( ri.company_sic_code1Weight=0 OR le.company_sic_code1_match_code=SALT38.MatchCode.ExactMatch => le.company_sic_code1Weight,MIN(le.company_sic_code1Weight,ri.company_sic_code1Weight-1) );
  SELF.prim_rangeWeight := MAP( ri.prim_rangeWeight=0 OR le.prim_range_match_code=SALT38.MatchCode.ExactMatch => le.prim_rangeWeight,MIN(le.prim_rangeWeight,ri.prim_rangeWeight-1) );
  SELF.prim_nameWeight := MAP( ri.prim_nameWeight=0 OR le.prim_name_match_code=SALT38.MatchCode.ExactMatch => le.prim_nameWeight,MIN(le.prim_nameWeight,ri.prim_nameWeight-1) );
  SELF.sec_rangeWeight := MAP( ri.sec_rangeWeight=0 OR le.sec_range_match_code=SALT38.MatchCode.ExactMatch => le.sec_rangeWeight,MIN(le.sec_rangeWeight,ri.sec_rangeWeight-1) );
  SELF.p_city_nameWeight := MAP( ri.p_city_nameWeight=0 OR le.p_city_name_match_code=SALT38.MatchCode.ExactMatch => le.p_city_nameWeight,MIN(le.p_city_nameWeight,ri.p_city_nameWeight-1) );
  SELF.stWeight := MAP( ri.stWeight=0 OR le.st_match_code=SALT38.MatchCode.ExactMatch => le.stWeight,MIN(le.stWeight,ri.stWeight-1) );
  SELF.zipWeight := MAP( ri.zipWeight=0 OR le.zip_match_code=SALT38.MatchCode.ExactMatch => le.zipWeight,MIN(le.zipWeight,ri.zipWeight-1) );
  SELF.company_urlWeight := MAP( ri.company_urlWeight=0 OR le.company_url_match_code=SALT38.MatchCode.ExactMatch => le.company_urlWeight,MIN(le.company_urlWeight,ri.company_urlWeight-1) );
  SELF.isContactWeight := MAP( ri.isContactWeight=0 OR le.isContact_match_code=SALT38.MatchCode.ExactMatch => le.isContactWeight,MIN(le.isContactWeight,ri.isContactWeight-1) );
  SELF.titleWeight := MAP( ri.titleWeight=0 OR le.title_match_code=SALT38.MatchCode.ExactMatch => le.titleWeight,MIN(le.titleWeight,ri.titleWeight-1) );
  SELF.fnameWeight := MAP( ri.fnameWeight=0 OR le.fname_match_code=SALT38.MatchCode.ExactMatch => le.fnameWeight,MIN(le.fnameWeight,ri.fnameWeight-1) );
  SELF.mnameWeight := MAP( ri.mnameWeight=0 OR le.mname_match_code=SALT38.MatchCode.ExactMatch => le.mnameWeight,MIN(le.mnameWeight,ri.mnameWeight-1) );
  SELF.lnameWeight := MAP( ri.lnameWeight=0 OR le.lname_match_code=SALT38.MatchCode.ExactMatch => le.lnameWeight,MIN(le.lnameWeight,ri.lnameWeight-1) );
  SELF.name_suffixWeight := MAP( ri.name_suffixWeight=0 OR le.name_suffix_match_code=SALT38.MatchCode.ExactMatch => le.name_suffixWeight,MIN(le.name_suffixWeight,ri.name_suffixWeight-1) );
  SELF.contact_emailWeight := MAP( ri.contact_emailWeight=0 OR le.contact_email_match_code=SALT38.MatchCode.ExactMatch => le.contact_emailWeight,MIN(le.contact_emailWeight,ri.contact_emailWeight-1) );
  SELF.CONTACTNAMEWeight := MAP( ri.CONTACTNAMEWeight=0 OR le.CONTACTNAME_match_code=SALT38.MatchCode.ExactMatch => le.CONTACTNAMEWeight,MIN(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight-1) );
  SELF.STREETADDRESSWeight := MAP( ri.STREETADDRESSWeight=0 OR le.STREETADDRESS_match_code=SALT38.MatchCode.ExactMatch => le.STREETADDRESSWeight,MIN(le.STREETADDRESSWeight,ri.STREETADDRESSWeight-1) );
  INTEGER2 Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.powidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
  SELF.Weight := IF(Weight>0,Weight,MAX(0,le.Weight));
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,proxid);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_bGetAllScores = TRUE) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    SELF.Results_seleid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-seleid),LEFT.seleid=RIGHT.seleid,Combine_Scores(LEFT,RIGHT)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
    SELF.Results_orgid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_seleid,-orgid),LEFT.orgid=RIGHT.orgid,Combine_Scores(LEFT,RIGHT)),-Weight,-(seleid=SELF.Results[1].seleid),-seleid));
    SELF.Results_ultid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_orgid,-ultid),LEFT.ultid=RIGHT.ultid,Combine_Scores(LEFT,RIGHT)),-Weight,-(orgid=SELF.Results[1].orgid),-orgid));
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),proxid),LEFT.proxid=RIGHT.proxid,Combine_Scores(LEFT,RIGHT))(SALT38.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT38.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,26,R3);
  SALT38.MAC_External_AddPcnt(R3,LayoutScoredFetch,Results_seleid,OutputLayout_Batch,26,R4);
  SALT38.MAC_External_AddPcnt(R4,LayoutScoredFetch,Results_orgid,OutputLayout_Batch,26,R5);
  SALT38.MAC_External_AddPcnt(R5,LayoutScoredFetch,Results_ultid,OutputLayout_Batch,26,R6);
  RETURN r6;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, proxid, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, proxid, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT38.UIDType proxid;
  DATASET(SALT38.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) empid_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) powid_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) source_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) company_phone_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) company_fein_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) company_sic_code1_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) p_city_name_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) st_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) zip_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) company_url_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) isContact_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) title_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) contact_email_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) CONTACTNAME_Values := DATASET([],SALT38.Layout_FieldValueList);
  DATASET(SALT38.Layout_FieldValueList) STREETADDRESS_Values := DATASET([],SALT38.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SALT38.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
    SELF.ultimate_proxid_values := SALT38.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
    SELF.has_lgid_values := SALT38.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
    SELF.empid_values := SALT38.fn_combine_fieldvaluelist(le.empid_values,ri.empid_values);
    SELF.powid_values := SALT38.fn_combine_fieldvaluelist(le.powid_values,ri.powid_values);
    SELF.source_values := SALT38.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
    SELF.source_record_id_values := SALT38.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
    SELF.cnp_number_values := SALT38.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.cnp_btype_values := SALT38.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.cnp_lowv_values := SALT38.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
    SELF.cnp_name_values := SALT38.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.company_phone_values := SALT38.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
    SELF.company_fein_values := SALT38.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.company_sic_code1_values := SALT38.fn_combine_fieldvaluelist(le.company_sic_code1_values,ri.company_sic_code1_values);
    SELF.p_city_name_values := SALT38.fn_combine_fieldvaluelist(le.p_city_name_values,ri.p_city_name_values);
    SELF.st_values := SALT38.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip_values := SALT38.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.company_url_values := SALT38.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
    SELF.isContact_values := SALT38.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
    SELF.title_values := SALT38.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
    SELF.name_suffix_values := SALT38.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.contact_email_values := SALT38.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
    SELF.CONTACTNAME_values := SALT38.fn_combine_fieldvaluelist(le.CONTACTNAME_values,ri.CONTACTNAME_values);
    SELF.STREETADDRESS_values := SALT38.fn_combine_fieldvaluelist(le.STREETADDRESS_values,ri.STREETADDRESS_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(proxid) ), proxid, LOCAL ), LEFT.proxid = RIGHT.proxid, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SORT(le.parent_proxid_values, -cnt, val, LOCAL);
    SELF.ultimate_proxid_values := SORT(le.ultimate_proxid_values, -cnt, val, LOCAL);
    SELF.has_lgid_values := SORT(le.has_lgid_values, -cnt, val, LOCAL);
    SELF.empid_values := SORT(le.empid_values, -cnt, val, LOCAL);
    SELF.powid_values := SORT(le.powid_values, -cnt, val, LOCAL);
    SELF.source_values := SORT(le.source_values, -cnt, val, LOCAL);
    SELF.source_record_id_values := SORT(le.source_record_id_values, -cnt, val, LOCAL);
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.cnp_lowv_values := SORT(le.cnp_lowv_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.company_phone_values := SORT(le.company_phone_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.company_sic_code1_values := SORT(le.company_sic_code1_values, -cnt, val, LOCAL);
    SELF.p_city_name_values := SORT(le.p_city_name_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.company_url_values := SORT(le.company_url_values, -cnt, val, LOCAL);
    SELF.isContact_values := SORT(le.isContact_values, -cnt, val, LOCAL);
    SELF.title_values := SORT(le.title_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.contact_email_values := SORT(le.contact_email_values, -cnt, val, LOCAL);
    SELF.CONTACTNAME_values := SORT(le.CONTACTNAME_values, -cnt, val, LOCAL);
    SELF.STREETADDRESS_values := SORT(le.STREETADDRESS_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT38.StrType)le.parent_proxid)}],SALT38.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT38.StrType)le.ultimate_proxid)}],SALT38.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT38.StrType)le.has_lgid)}],SALT38.Layout_FieldValueList);
  SELF.empid_Values := IF ( (SALT38.StrType)le.empid = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.empid)}],SALT38.Layout_FieldValueList));
  SELF.powid_Values := IF ( (SALT38.StrType)le.powid = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.powid)}],SALT38.Layout_FieldValueList));
  SELF.source_Values := IF ( (SALT38.StrType)le.source = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.source)}],SALT38.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( (SALT38.StrType)le.source_record_id = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.source_record_id)}],SALT38.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (SALT38.StrType)le.cnp_number = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.cnp_number)}],SALT38.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (SALT38.StrType)le.cnp_btype = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.cnp_btype)}],SALT38.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( (SALT38.StrType)le.cnp_lowv = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.cnp_lowv)}],SALT38.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( (SALT38.StrType)le.cnp_name = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.cnp_name)}],SALT38.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( (SALT38.StrType)le.company_phone = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.company_phone)}],SALT38.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (SALT38.StrType)le.company_fein = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.company_fein)}],SALT38.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( (SALT38.StrType)le.company_sic_code1 = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.company_sic_code1)}],SALT38.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( (SALT38.StrType)le.p_city_name = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.p_city_name)}],SALT38.Layout_FieldValueList));
  SELF.st_Values := IF ( (SALT38.StrType)le.st = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.st)}],SALT38.Layout_FieldValueList));
  SELF.zip_Values := IF ( (SALT38.StrType)le.zip = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.zip)}],SALT38.Layout_FieldValueList));
  SELF.company_url_Values := IF ( (SALT38.StrType)le.company_url = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.company_url)}],SALT38.Layout_FieldValueList));
  SELF.isContact_Values := IF ( (SALT38.StrType)le.isContact = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.isContact)}],SALT38.Layout_FieldValueList));
  SELF.title_Values := IF ( (SALT38.StrType)le.title = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.title)}],SALT38.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (SALT38.StrType)le.name_suffix = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.name_suffix)}],SALT38.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( (SALT38.StrType)le.contact_email = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.contact_email)}],SALT38.Layout_FieldValueList));
  SELF.CONTACTNAME_Values := IF ( (SALT38.StrType)le.fname = '' AND (SALT38.StrType)le.mname = '' AND (SALT38.StrType)le.lname = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.fname) + ' ' + TRIM((SALT38.StrType)le.mname) + ' ' + TRIM((SALT38.StrType)le.lname)}],SALT38.Layout_FieldValueList));
  SELF.STREETADDRESS_Values := IF ( (SALT38.StrType)le.prim_range = '' AND (SALT38.StrType)le.prim_name = '' AND (SALT38.StrType)le.sec_range = '',DATASET([],SALT38.Layout_FieldValueList),DATASET([{TRIM((SALT38.StrType)le.prim_range) + ' ' + TRIM((SALT38.StrType)le.prim_name) + ' ' + TRIM((SALT38.StrType)le.sec_range)}],SALT38.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
// Records which already had the ultid,orgid,seleid,proxid on them may not be up to date. Update those IDs
EXPORT UpdateIDs(DATASET(InputLayout) in) := FUNCTION
  id_stream_layout init(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.seleid := le.Entered_seleid;
    SELF.orgid := le.Entered_orgid;
    SELF.ultid := le.Entered_ultid;
    SELF.proxid := le.Entered_proxid;
    SELF.rcid := le.Entered_rcid;
  END;
  idupdate_candidates := PROJECT(in,init(LEFT));
  ids_updated0 := id_stream_historic(idupdate_candidates);
  ids_updated := PROJECT(ids_updated0,TRANSFORM(LayoutScoredFetch,SELF.Reference:=LEFT.UniqueId,SELF.keys_used:=0,SELF.keys_failed:=0,SELF:=LEFT));
  RETURN CombineLinkpathScores(ids_updated);
END;
END;
