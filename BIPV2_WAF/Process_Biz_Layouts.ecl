EXPORT Process_Biz_Layouts := MODULE
 
IMPORT SALT29;
SHARED h := File_BizHead;//The input file
 
EXPORT KeyName := '~'+'key::BIPV2_WAF::proxid::meow';
 
EXPORT Key := INDEX(h,{ultid,orgid,seleid,proxid},{h},KeyName);
//Create keys to get from lower-order identifiers to the full hierarchy
 
EXPORT KeyproxidUpName := '~'+'key::BIPV2_WAF::proxid::sup::proxid';
  s := TABLE(h,{ultid,orgid,seleid,proxid},ultid,orgid,seleid,proxid,MERGE);
 
EXPORT KeyproxidUp := INDEX(s,{proxid},{s},KeyproxidUpName);
 
EXPORT KeyseleidUpName := '~'+'key::BIPV2_WAF::proxid::sup::seleid';
  s := TABLE(h,{ultid,orgid,seleid},ultid,orgid,seleid,MERGE);
 
EXPORT KeyseleidUp := INDEX(s,{seleid},{s},KeyseleidUpName);
 
EXPORT KeyorgidUpName := '~'+'key::BIPV2_WAF::proxid::sup::orgid';
  s := TABLE(h,{ultid,orgid},ultid,orgid,MERGE);
 
EXPORT KeyorgidUp := INDEX(s,{orgid},{s},KeyorgidUpName);
// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := '~'+'key::BIPV2_WAF::proxid::sup::rcid';
  s := TABLE(h,{ultid,orgid,seleid,proxid,rcid},rcid,ultid,orgid,seleid,proxid,MERGE);
 
EXPORT KeyIDHistory := INDEX(s,{rcid},{s},KeyIDHistoryName);
EXPORT BuildAll := SEQUENTIAL(PARALLEL(BUILDINDEX(Key, OVERWRITE),BUILDINDEX(KeyproxidUp, OVERWRITE),BUILDINDEX(KeyseleidUp, OVERWRITE),BUILDINDEX(KeyorgidUp, OVERWRITE),BUILDINDEX(KeyIDHistory, OVERWRITE)));
EXPORT layout_zip_cases := RECORD
  TYPEOF(h.zip) zip;
END;
EXPORT id_stream_layout := RECORD
    UNSIGNED4 UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    SALT29.UIDType seleid;
    SALT29.UIDType orgid;
    SALT29.UIDType ultid;
    SALT29.UIDType proxid;
    SALT29.UIDType rcid := 0; // Unique record ID for external file
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
  J0 := JOIN(C0,KeyproxidUp,LEFT.proxid=RIGHT.proxid,Fill0(LEFT,RIGHT),LEFT OUTER);
  CF1 := id.seleid<>0 AND id.orgid=0  AND ~CF0;
  C1 := id(CF1); // In need of filling up
  id_stream_layout Fill1(id_stream_layout le,KeyseleidUp ri) := TRANSFORM
    SELF.orgid := ri.orgid;
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J1 := JOIN(C1,KeyseleidUp,LEFT.seleid=RIGHT.seleid,Fill1(LEFT,RIGHT),LEFT OUTER);
  CF2 := id.orgid<>0 AND id.ultid=0  AND ~CF0  AND ~CF1;
  C2 := id(CF2); // In need of filling up
  id_stream_layout Fill2(id_stream_layout le,KeyorgidUp ri) := TRANSFORM
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J2 := JOIN(C2,KeyorgidUp,LEFT.orgid=RIGHT.orgid,Fill2(LEFT,RIGHT),LEFT OUTER);
  RETURN id(rcid<>0 AND proxid=0 OR ultid<>0  AND ~CF0  AND ~CF1  AND ~CF2)+J0+J1+J2;
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(rcid<>0,proxid=0); // Only record ID supplied
  id_stream_layout Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J := JOIN(C,KeyIDHistory,LEFT.rcid=RIGHT.rcid,Load(LEFT,RIGHT));
  C0 := id(proxid<>0); // proxid is the minormost element
  id_stream_layout Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J0 := JOIN(C0,KeyIDHistory,LEFT.proxid=RIGHT.rcid,Load0(LEFT,RIGHT));
  C1 := id(seleid<>0,proxid=0); // seleid is the minormost element
  id_stream_layout Load1(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J1 := JOIN(C1,KeyIDHistory,LEFT.seleid=RIGHT.rcid,Load1(LEFT,RIGHT));
  C2 := id(orgid<>0,seleid=0); // orgid is the minormost element
  id_stream_layout Load2(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J2 := JOIN(C2,KeyIDHistory,LEFT.orgid=RIGHT.rcid,Load2(LEFT,RIGHT));
  C3 := id(ultid<>0,orgid=0); // ultid is the minormost element
  id_stream_layout Load3(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF.orgid := 0; // Make sure more minor elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J3 := JOIN(C3,KeyIDHistory,LEFT.ultid=RIGHT.rcid,Load3(LEFT,RIGHT));
  RETURN J+J0+J1+J2+J3;
END;
EXPORT InputLayout := RECORD
  UNSIGNED4 UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
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
  SET OF SALT29.StrType zip_cases;
  h.company_url;
  h.isContact;
  h.title;
  h.fname;
  h.mname;
  h.lname;
  h.name_suffix;
  h.contact_email;
  SALT29.StrType CONTACTNAME;//Wordbag field for concept
  SALT29.StrType STREETADDRESS;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show proxid if it has a record which fully matches
  SALT29.UIDType Entered_rcid := 0; // Allow user to enter rcid to pull data
  SALT29.UIDType Entered_proxid := 0; // Allow user to enter proxid to pull data
  SALT29.UIDType Entered_seleid := 0; // Allow user to enter seleid to pull data
  SALT29.UIDType Entered_orgid := 0; // Allow user to enter orgid to pull data
  SALT29.UIDType Entered_ultid := 0; // Allow user to enter ultid to pull data
END;
// A function to turn data in the input layout function into 'baby' match candidates form
EXPORT InputToMC(DATASET(InputLayout) Inp) := FUNCTION
  r := RECORD
    inp.parent_proxid;
    inp.ultimate_proxid;
    inp.has_lgid;
    inp.empid;
    inp.powid;
    inp.source;
    inp.source_record_id;
    inp.cnp_number;
    inp.cnp_btype;
    inp.cnp_lowv;
    STRING240 cnp_name := SALT29.fn_WordBag_AppendSpecs_Fake(inp.cnp_name); // Needs to look like a wordbag 
    inp.company_phone;
    inp.company_fein;
    inp.company_sic_code1;
    inp.prim_range;
    inp.prim_name;
    inp.sec_range;
    inp.p_city_name;
    inp.st;
    TYPEOF(h.zip) zip := inp.zip_cases[1];
    STRING240 company_url := SALT29.fn_WordBag_AppendSpecs_Fake(inp.company_url); // Needs to look like a wordbag 
    inp.isContact;
    inp.title;
    inp.fname;
    STRING20 fname_PreferredName := fn_PreferredName(inp.fname);
    inp.mname;
    inp.lname;
    inp.name_suffix;
    STRING5 name_suffix_NormSuffix := fn_normSuffix(inp.name_suffix);
    inp.contact_email;
    rcid := inp.Entered_rcid;
    ultid := inp.Entered_ultid;
    orgid := inp.Entered_orgid;
    seleid := inp.Entered_seleid;
    proxid := inp.Entered_proxid;
  END;
  RETURN TABLE(inp,r);
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.cnp_name <> (typeof(le.cnp_name))'' OR le.cnp_name <> (typeof(le.cnp_name))'' AND le.st <> (typeof(le.st))'' OR le.prim_name <> (typeof(le.prim_name))'' AND le.p_city_name <> (typeof(le.p_city_name))'' AND le.st <> (typeof(le.st))'' OR le.prim_name <> (typeof(le.prim_name))'' AND le.zip_cases <> [] OR le.company_phone <> (typeof(le.company_phone))'' OR le.company_fein <> (typeof(le.company_fein))'' OR le.fname <> (typeof(le.fname))'' AND le.lname <> (typeof(le.lname))'' OR le.company_url <> (typeof(le.company_url))'' OR le.contact_email <> (typeof(le.contact_email))'' OR le.source_record_id <> (typeof(le.source_record_id))'' AND le.source <> (typeof(le.source))'';
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.proxid;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT29.UIDType Reference := 0;//Presently for batch
  h.seleid; // Parent id - in case child does not resolve
  h.orgid; // Parent id - in case child does not resolve
  h.ultid; // Parent id - in case child does not resolve
  SALT29.UIDType rcid := 0;
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
  DATASET(SALT29.layout_gss_cases) cnp_name_GSS_cases := DATASET([],SALT29.layout_gss_cases);
  INTEGER2 cnp_name_GSS_Weight := 0;
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
  DATASET(SALT29.layout_gss_cases) company_url_GSS_cases := DATASET([],SALT29.layout_gss_cases);
  INTEGER2 company_url_GSS_Weight := 0;
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
  SALT29.StrType CONTACTNAME := ''; // Concepts always a wordbag
  INTEGER2 CONTACTNAMEWeight := 0;
  INTEGER1 CONTACTNAME_match_code := 0;
  SALT29.StrType STREETADDRESS := ''; // Concepts always a wordbag
  INTEGER2 STREETADDRESSWeight := 0;
  INTEGER1 STREETADDRESS_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT29.MatchCode.ExactMatch, INTEGER1 r_mc=SALT29.MatchCode.ExactMatch) :=
  MAP(l_mc=SALT29.MatchCode.ExactMatch AND r_mc=SALT29.MatchCode.ExactMatch AND l_weight>r_weight => true,
      NOT(l_mc=SALT29.MatchCode.ExactMatch OR r_mc=SALT29.MatchCode.ExactMatch) AND l_weight>r_weight => true,
      l_mc=SALT29.MatchCode.ExactMatch => true,false);
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT29.MatchCode.ExactMatch, INTEGER1 r_mc=SALT29.MatchCode.ExactMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri) := TRANSFORM
  BOOLEAN parent_proxidWeightForcedDown := IF ( isWeightForcedDown(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code),true,false );
  SELF.parent_proxidWeight := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code), le.parent_proxidWeight, ri.parent_proxidWeight );
  SELF.parent_proxid := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxid, ri.parent_proxid );
  SELF.parent_proxid_match_code := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code), le.parent_proxid_match_code, ri.parent_proxid_match_code );
  BOOLEAN ultimate_proxidWeightForcedDown := IF ( isWeightForcedDown(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code),true,false );
  SELF.ultimate_proxidWeight := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code), le.ultimate_proxidWeight, ri.ultimate_proxidWeight );
  SELF.ultimate_proxid := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code ), le.ultimate_proxid, ri.ultimate_proxid );
  SELF.ultimate_proxid_match_code := IF ( isLeftWinner(le.ultimate_proxidWeight,ri.ultimate_proxidWeight,le.ultimate_proxid_match_code,ri.ultimate_proxid_match_code), le.ultimate_proxid_match_code, ri.ultimate_proxid_match_code );
  BOOLEAN has_lgidWeightForcedDown := IF ( isWeightForcedDown(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code),true,false );
  SELF.has_lgidWeight := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code), le.has_lgidWeight, ri.has_lgidWeight );
  SELF.has_lgid := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code ), le.has_lgid, ri.has_lgid );
  SELF.has_lgid_match_code := IF ( isLeftWinner(le.has_lgidWeight,ri.has_lgidWeight,le.has_lgid_match_code,ri.has_lgid_match_code), le.has_lgid_match_code, ri.has_lgid_match_code );
  BOOLEAN empidWeightForcedDown := IF ( isWeightForcedDown(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code),true,false );
  SELF.empidWeight := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code), le.empidWeight, ri.empidWeight );
  SELF.empid := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code ), le.empid, ri.empid );
  SELF.empid_match_code := IF ( isLeftWinner(le.empidWeight,ri.empidWeight,le.empid_match_code,ri.empid_match_code), le.empid_match_code, ri.empid_match_code );
  BOOLEAN powidWeightForcedDown := IF ( isWeightForcedDown(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code),true,false );
  SELF.powidWeight := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code), le.powidWeight, ri.powidWeight );
  SELF.powid := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code ), le.powid, ri.powid );
  SELF.powid_match_code := IF ( isLeftWinner(le.powidWeight,ri.powidWeight,le.powid_match_code,ri.powid_match_code), le.powid_match_code, ri.powid_match_code );
  BOOLEAN sourceWeightForcedDown := IF ( isWeightForcedDown(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code),true,false );
  SELF.sourceWeight := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code), le.sourceWeight, ri.sourceWeight );
  SELF.source := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.source, ri.source );
  SELF.source_match_code := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code), le.source_match_code, ri.source_match_code );
  BOOLEAN source_record_idWeightForcedDown := IF ( isWeightForcedDown(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code),true,false );
  SELF.source_record_idWeight := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code), le.source_record_idWeight, ri.source_record_idWeight );
  SELF.source_record_id := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_id, ri.source_record_id );
  SELF.source_record_id_match_code := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code), le.source_record_id_match_code, ri.source_record_id_match_code );
  BOOLEAN cnp_numberWeightForcedDown := IF ( isWeightForcedDown(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code),true,false );
  SELF.cnp_numberWeight := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code), le.cnp_numberWeight, ri.cnp_numberWeight );
  SELF.cnp_number := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code ), le.cnp_number, ri.cnp_number );
  SELF.cnp_number_match_code := IF ( isLeftWinner(le.cnp_numberWeight,ri.cnp_numberWeight,le.cnp_number_match_code,ri.cnp_number_match_code), le.cnp_number_match_code, ri.cnp_number_match_code );
  BOOLEAN cnp_btypeWeightForcedDown := IF ( isWeightForcedDown(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code),true,false );
  SELF.cnp_btypeWeight := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code), le.cnp_btypeWeight, ri.cnp_btypeWeight );
  SELF.cnp_btype := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code ), le.cnp_btype, ri.cnp_btype );
  SELF.cnp_btype_match_code := IF ( isLeftWinner(le.cnp_btypeWeight,ri.cnp_btypeWeight,le.cnp_btype_match_code,ri.cnp_btype_match_code), le.cnp_btype_match_code, ri.cnp_btype_match_code );
  BOOLEAN cnp_lowvWeightForcedDown := IF ( isWeightForcedDown(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code),true,false );
  SELF.cnp_lowvWeight := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code), le.cnp_lowvWeight, ri.cnp_lowvWeight );
  SELF.cnp_lowv := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code ), le.cnp_lowv, ri.cnp_lowv );
  SELF.cnp_lowv_match_code := IF ( isLeftWinner(le.cnp_lowvWeight,ri.cnp_lowvWeight,le.cnp_lowv_match_code,ri.cnp_lowv_match_code), le.cnp_lowv_match_code, ri.cnp_lowv_match_code );
  SELF.cnp_name_gss_Weight := IF ( EXISTS(le.cnp_name_gss_cases(ri.cnp_name_gss_cases[1].gss_hash=gss_hash)), le.cnp_name_gss_Weight, le.cnp_name_gss_Weight + ri.cnp_name_gss_Weight );
  SELF.cnp_name_gss_cases := IF ( EXISTS(le.cnp_name_gss_cases(ri.cnp_name_gss_cases[1].gss_hash=gss_hash)), le.cnp_name_gss_cases, le.cnp_name_gss_cases + ri.cnp_name_gss_cases );
  SELF.cnp_nameWeight := MAP ( SELF.cnp_name_GSS_Weight > le.cnp_nameWeight AND SELF.cnp_name_GSS_Weight > ri.cnp_nameWeight => SELF.cnp_name_GSS_Weight,
                         le.cnp_nameWeight>ri.cnp_nameWeight => le.cnp_nameWeight, ri.cnp_nameWeight );
  SELF.cnp_name := IF ( le.cnp_nameWeight>ri.cnp_nameWeight AND le.cnp_name <> (TYPEOF(le.cnp_name))'', le.cnp_name, ri.cnp_name );
  SELF.cnp_name_match_code := IF ( isLeftWinner(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code), le.cnp_name_match_code, ri.cnp_name_match_code );
  BOOLEAN company_phoneWeightForcedDown := IF ( isWeightForcedDown(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code),true,false );
  SELF.company_phoneWeight := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code), le.company_phoneWeight, ri.company_phoneWeight );
  SELF.company_phone := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phone, ri.company_phone );
  SELF.company_phone_match_code := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code), le.company_phone_match_code, ri.company_phone_match_code );
  BOOLEAN company_feinWeightForcedDown := IF ( isWeightForcedDown(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code),true,false );
  SELF.company_feinWeight := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code), le.company_feinWeight, ri.company_feinWeight );
  SELF.company_fein := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_fein, ri.company_fein );
  SELF.company_fein_match_code := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code), le.company_fein_match_code, ri.company_fein_match_code );
  BOOLEAN company_sic_code1WeightForcedDown := IF ( isWeightForcedDown(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code),true,false );
  SELF.company_sic_code1Weight := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code), le.company_sic_code1Weight, ri.company_sic_code1Weight );
  SELF.company_sic_code1 := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1, ri.company_sic_code1 );
  SELF.company_sic_code1_match_code := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code), le.company_sic_code1_match_code, ri.company_sic_code1_match_code );
  BOOLEAN prim_rangeWeightForcedDown := IF ( isWeightForcedDown(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code),true,false );
  SELF.prim_rangeWeight := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code), le.prim_rangeWeight, ri.prim_rangeWeight );
  SELF.prim_range := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code ), le.prim_range, ri.prim_range );
  SELF.prim_range_match_code := IF ( isLeftWinner(le.prim_rangeWeight,ri.prim_rangeWeight,le.prim_range_match_code,ri.prim_range_match_code), le.prim_range_match_code, ri.prim_range_match_code );
  BOOLEAN prim_nameWeightForcedDown := IF ( isWeightForcedDown(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code),true,false );
  SELF.prim_nameWeight := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code), le.prim_nameWeight, ri.prim_nameWeight );
  SELF.prim_name := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code ), le.prim_name, ri.prim_name );
  SELF.prim_name_match_code := IF ( isLeftWinner(le.prim_nameWeight,ri.prim_nameWeight,le.prim_name_match_code,ri.prim_name_match_code), le.prim_name_match_code, ri.prim_name_match_code );
  BOOLEAN sec_rangeWeightForcedDown := IF ( isWeightForcedDown(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code),true,false );
  SELF.sec_rangeWeight := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code), le.sec_rangeWeight, ri.sec_rangeWeight );
  SELF.sec_range := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code ), le.sec_range, ri.sec_range );
  SELF.sec_range_match_code := IF ( isLeftWinner(le.sec_rangeWeight,ri.sec_rangeWeight,le.sec_range_match_code,ri.sec_range_match_code), le.sec_range_match_code, ri.sec_range_match_code );
  BOOLEAN p_city_nameWeightForcedDown := IF ( isWeightForcedDown(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code),true,false );
  SELF.p_city_nameWeight := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code), le.p_city_nameWeight, ri.p_city_nameWeight );
  SELF.p_city_name := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code ), le.p_city_name, ri.p_city_name );
  SELF.p_city_name_match_code := IF ( isLeftWinner(le.p_city_nameWeight,ri.p_city_nameWeight,le.p_city_name_match_code,ri.p_city_name_match_code), le.p_city_name_match_code, ri.p_city_name_match_code );
  BOOLEAN stWeightForcedDown := IF ( isWeightForcedDown(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code),true,false );
  SELF.stWeight := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code), le.stWeight, ri.stWeight );
  SELF.st := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st, ri.st );
  SELF.st_match_code := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code), le.st_match_code, ri.st_match_code );
  SELF.zip_cases := IF ( EXISTS(le.zip_cases(ri.zip_cases[1].zip=zip)), le.zip_cases, le.zip_cases + ri.zip_cases );
  SELF.zipWeight := MAP ( EXISTS(le.zip_cases(ri.zip_cases[1].zip=zip)) => le.zipWeight, le.zipWeight > 0 => le.zipWeight + MAX(0,ri.zipWeight), ri.zipWeight > 0 => ri.zipWeight + MAX(0,le.zipWeight), le.zipWeight+ri.zipWeight );
  SELF.zip_match_code := IF ( isLeftWinner(le.zipWeight,ri.zipWeight,le.zip_match_code,ri.zip_match_code), le.zip_match_code, ri.zip_match_code );
  SELF.company_url_gss_Weight := IF ( EXISTS(le.company_url_gss_cases(ri.company_url_gss_cases[1].gss_hash=gss_hash)), le.company_url_gss_Weight, le.company_url_gss_Weight + ri.company_url_gss_Weight );
  SELF.company_url_gss_cases := IF ( EXISTS(le.company_url_gss_cases(ri.company_url_gss_cases[1].gss_hash=gss_hash)), le.company_url_gss_cases, le.company_url_gss_cases + ri.company_url_gss_cases );
  SELF.company_urlWeight := MAP ( SELF.company_url_GSS_Weight > le.company_urlWeight AND SELF.company_url_GSS_Weight > ri.company_urlWeight => SELF.company_url_GSS_Weight,
                         le.company_urlWeight>ri.company_urlWeight => le.company_urlWeight, ri.company_urlWeight );
  SELF.company_url := IF ( le.company_urlWeight>ri.company_urlWeight AND le.company_url <> (TYPEOF(le.company_url))'', le.company_url, ri.company_url );
  SELF.company_url_match_code := IF ( isLeftWinner(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code), le.company_url_match_code, ri.company_url_match_code );
  BOOLEAN isContactWeightForcedDown := IF ( isWeightForcedDown(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code),true,false );
  SELF.isContactWeight := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code), le.isContactWeight, ri.isContactWeight );
  SELF.isContact := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContact, ri.isContact );
  SELF.isContact_match_code := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code), le.isContact_match_code, ri.isContact_match_code );
  BOOLEAN titleWeightForcedDown := IF ( isWeightForcedDown(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code),true,false );
  SELF.titleWeight := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code), le.titleWeight, ri.titleWeight );
  SELF.title := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.title, ri.title );
  SELF.title_match_code := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code), le.title_match_code, ri.title_match_code );
  BOOLEAN fnameWeightForcedDown := IF ( isWeightForcedDown(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code),true,false );
  SELF.fnameWeight := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code), le.fnameWeight, ri.fnameWeight );
  SELF.fname := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fname, ri.fname );
  SELF.fname_match_code := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code), le.fname_match_code, ri.fname_match_code );
  BOOLEAN mnameWeightForcedDown := IF ( isWeightForcedDown(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code),true,false );
  SELF.mnameWeight := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code), le.mnameWeight, ri.mnameWeight );
  SELF.mname := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code ), le.mname, ri.mname );
  SELF.mname_match_code := IF ( isLeftWinner(le.mnameWeight,ri.mnameWeight,le.mname_match_code,ri.mname_match_code), le.mname_match_code, ri.mname_match_code );
  BOOLEAN lnameWeightForcedDown := IF ( isWeightForcedDown(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code),true,false );
  SELF.lnameWeight := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code), le.lnameWeight, ri.lnameWeight );
  SELF.lname := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code ), le.lname, ri.lname );
  SELF.lname_match_code := IF ( isLeftWinner(le.lnameWeight,ri.lnameWeight,le.lname_match_code,ri.lname_match_code), le.lname_match_code, ri.lname_match_code );
  BOOLEAN name_suffixWeightForcedDown := IF ( isWeightForcedDown(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code),true,false );
  SELF.name_suffixWeight := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code), le.name_suffixWeight, ri.name_suffixWeight );
  SELF.name_suffix := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code ), le.name_suffix, ri.name_suffix );
  SELF.name_suffix_match_code := IF ( isLeftWinner(le.name_suffixWeight,ri.name_suffixWeight,le.name_suffix_match_code,ri.name_suffix_match_code), le.name_suffix_match_code, ri.name_suffix_match_code );
  BOOLEAN contact_emailWeightForcedDown := IF ( isWeightForcedDown(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code),true,false );
  SELF.contact_emailWeight := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code), le.contact_emailWeight, ri.contact_emailWeight );
  SELF.contact_email := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_email, ri.contact_email );
  SELF.contact_email_match_code := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code), le.contact_email_match_code, ri.contact_email_match_code );
  BOOLEAN CONTACTNAMEWeightForcedDown := fnameWeightForcedDown OR mnameWeightForcedDown OR lnameWeightForcedDown;
  SELF.CONTACTNAMEWeight := IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code), IF(CONTACTNAMEWeightForcedDown,MIN(le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight),le.CONTACTNAMEWeight), IF(CONTACTNAMEWeightForcedDown,MIN(le.CONTACTNAMEWeight, ri.CONTACTNAMEWeight),ri.CONTACTNAMEWeight));
  SELF.CONTACTNAME_match_code := IF ( isLeftWinner(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight,le.CONTACTNAME_match_code,ri.CONTACTNAME_match_code), le.CONTACTNAME_match_code, ri.CONTACTNAME_match_code );
  BOOLEAN STREETADDRESSWeightForcedDown := prim_rangeWeightForcedDown OR prim_nameWeightForcedDown OR sec_rangeWeightForcedDown;
  SELF.STREETADDRESSWeight := IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code), IF(STREETADDRESSWeightForcedDown,MIN(le.STREETADDRESSWeight, ri.STREETADDRESSWeight),le.STREETADDRESSWeight), IF(STREETADDRESSWeightForcedDown,MIN(le.STREETADDRESSWeight, ri.STREETADDRESSWeight),ri.STREETADDRESSWeight));
  SELF.STREETADDRESS_match_code := IF ( isLeftWinner(le.STREETADDRESSWeight,ri.STREETADDRESSWeight,le.STREETADDRESS_match_code,ri.STREETADDRESS_match_code), le.STREETADDRESS_match_code, ri.STREETADDRESS_match_code );
  SELF.proxid := IF ( le.proxid=ri.proxid, le.proxid, 0 ); // Zero out if collapsing a parent
  SELF.seleid := IF ( le.seleid=ri.seleid, le.seleid, 0 ); // Zero out if collapsing a parent
  SELF.orgid := IF ( le.orgid=ri.orgid, le.orgid, 0 ); // Zero out if collapsing a parent
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.powidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
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
  SALT29.UIDType Reference;
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
    SALT29.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.parent_proxidWeight=0,'','|'+IF(le.parent_proxidWeight<0,'-','')+'parent_proxid')+IF(le.ultimate_proxidWeight=0,'','|'+IF(le.ultimate_proxidWeight<0,'-','')+'ultimate_proxid')+IF(le.has_lgidWeight=0,'','|'+IF(le.has_lgidWeight<0,'-','')+'has_lgid')+IF(le.empidWeight=0,'','|'+IF(le.empidWeight<0,'-','')+'empid')+IF(le.powidWeight=0,'','|'+IF(le.powidWeight<0,'-','')+'powid')+IF(le.sourceWeight=0,'','|'+IF(le.sourceWeight<0,'-','')+'source')+IF(le.source_record_idWeight=0,'','|'+IF(le.source_record_idWeight<0,'-','')+'source_record_id')+IF(le.cnp_numberWeight=0,'','|'+IF(le.cnp_numberWeight<0,'-','')+'cnp_number')+IF(le.cnp_btypeWeight=0,'','|'+IF(le.cnp_btypeWeight<0,'-','')+'cnp_btype')+IF(le.cnp_lowvWeight=0,'','|'+IF(le.cnp_lowvWeight<0,'-','')+'cnp_lowv')+IF(le.cnp_nameWeight=0,'','|'+IF(le.cnp_nameWeight<0,'-','')+'cnp_name')+IF(le.company_phoneWeight=0,'','|'+IF(le.company_phoneWeight<0,'-','')+'company_phone')+IF(le.company_feinWeight=0,'','|'+IF(le.company_feinWeight<0,'-','')+'company_fein')+IF(le.company_sic_code1Weight=0,'','|'+IF(le.company_sic_code1Weight<0,'-','')+'company_sic_code1')+IF(le.prim_rangeWeight=0,'','|'+IF(le.prim_rangeWeight<0,'-','')+'prim_range')+IF(le.prim_nameWeight=0,'','|'+IF(le.prim_nameWeight<0,'-','')+'prim_name')+IF(le.sec_rangeWeight=0,'','|'+IF(le.sec_rangeWeight<0,'-','')+'sec_range')+IF(le.p_city_nameWeight=0,'','|'+IF(le.p_city_nameWeight<0,'-','')+'p_city_name')+IF(le.stWeight=0,'','|'+IF(le.stWeight<0,'-','')+'st')+IF(le.zipWeight=0,'','|'+IF(le.zipWeight<0,'-','')+'zip')+IF(le.company_urlWeight=0,'','|'+IF(le.company_urlWeight<0,'-','')+'company_url')+IF(le.isContactWeight=0,'','|'+IF(le.isContactWeight<0,'-','')+'isContact')+IF(le.titleWeight=0,'','|'+IF(le.titleWeight<0,'-','')+'title')+IF(le.fnameWeight=0,'','|'+IF(le.fnameWeight<0,'-','')+'fname')+IF(le.mnameWeight=0,'','|'+IF(le.mnameWeight<0,'-','')+'mname')+IF(le.lnameWeight=0,'','|'+IF(le.lnameWeight<0,'-','')+'lname')+IF(le.name_suffixWeight=0,'','|'+IF(le.name_suffixWeight<0,'-','')+'name_suffix')+IF(le.contact_emailWeight=0,'','|'+IF(le.contact_emailWeight<0,'-','')+'contact_email')+IF(le.CONTACTNAMEWeight=0,'','|'+IF(le.CONTACTNAMEWeight<0,'-','')+'CONTACTNAME')+IF(le.STREETADDRESSWeight=0,'','|'+IF(le.STREETADDRESSWeight<0,'-','')+'STREETADDRESS');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  t := TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW);
  RETURN SORT(t,-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  parent_proxidWeight := MAX(GROUP,IF( in_data.parent_proxid_match_code=SALT29.MatchCode.ExactMatch, in_data.parent_proxidWeight,0 ));
  ultimate_proxidWeight := MAX(GROUP,IF( in_data.ultimate_proxid_match_code=SALT29.MatchCode.ExactMatch, in_data.ultimate_proxidWeight,0 ));
  has_lgidWeight := MAX(GROUP,IF( in_data.has_lgid_match_code=SALT29.MatchCode.ExactMatch, in_data.has_lgidWeight,0 ));
  empidWeight := MAX(GROUP,IF( in_data.empid_match_code=SALT29.MatchCode.ExactMatch, in_data.empidWeight,0 ));
  powidWeight := MAX(GROUP,IF( in_data.powid_match_code=SALT29.MatchCode.ExactMatch, in_data.powidWeight,0 ));
  sourceWeight := MAX(GROUP,IF( in_data.source_match_code=SALT29.MatchCode.ExactMatch, in_data.sourceWeight,0 ));
  source_record_idWeight := MAX(GROUP,IF( in_data.source_record_id_match_code=SALT29.MatchCode.ExactMatch, in_data.source_record_idWeight,0 ));
  cnp_numberWeight := MAX(GROUP,IF( in_data.cnp_number_match_code=SALT29.MatchCode.ExactMatch, in_data.cnp_numberWeight,0 ));
  cnp_btypeWeight := MAX(GROUP,IF( in_data.cnp_btype_match_code=SALT29.MatchCode.ExactMatch, in_data.cnp_btypeWeight,0 ));
  cnp_lowvWeight := MAX(GROUP,IF( in_data.cnp_lowv_match_code=SALT29.MatchCode.ExactMatch, in_data.cnp_lowvWeight,0 ));
  cnp_nameWeight := MAX(GROUP,IF( in_data.cnp_name_match_code=SALT29.MatchCode.ExactMatch, in_data.cnp_nameWeight,0 ));
  company_phoneWeight := MAX(GROUP,IF( in_data.company_phone_match_code=SALT29.MatchCode.ExactMatch, in_data.company_phoneWeight,0 ));
  company_feinWeight := MAX(GROUP,IF( in_data.company_fein_match_code=SALT29.MatchCode.ExactMatch, in_data.company_feinWeight,0 ));
  company_sic_code1Weight := MAX(GROUP,IF( in_data.company_sic_code1_match_code=SALT29.MatchCode.ExactMatch, in_data.company_sic_code1Weight,0 ));
  prim_rangeWeight := MAX(GROUP,IF( in_data.prim_range_match_code=SALT29.MatchCode.ExactMatch, in_data.prim_rangeWeight,0 ));
  prim_nameWeight := MAX(GROUP,IF( in_data.prim_name_match_code=SALT29.MatchCode.ExactMatch, in_data.prim_nameWeight,0 ));
  sec_rangeWeight := MAX(GROUP,IF( in_data.sec_range_match_code=SALT29.MatchCode.ExactMatch, in_data.sec_rangeWeight,0 ));
  p_city_nameWeight := MAX(GROUP,IF( in_data.p_city_name_match_code=SALT29.MatchCode.ExactMatch, in_data.p_city_nameWeight,0 ));
  stWeight := MAX(GROUP,IF( in_data.st_match_code=SALT29.MatchCode.ExactMatch, in_data.stWeight,0 ));
  zipWeight := MAX(GROUP,IF( in_data.zip_match_code=SALT29.MatchCode.ExactMatch, in_data.zipWeight,0 ));
  company_urlWeight := MAX(GROUP,IF( in_data.company_url_match_code=SALT29.MatchCode.ExactMatch, in_data.company_urlWeight,0 ));
  isContactWeight := MAX(GROUP,IF( in_data.isContact_match_code=SALT29.MatchCode.ExactMatch, in_data.isContactWeight,0 ));
  titleWeight := MAX(GROUP,IF( in_data.title_match_code=SALT29.MatchCode.ExactMatch, in_data.titleWeight,0 ));
  fnameWeight := MAX(GROUP,IF( in_data.fname_match_code=SALT29.MatchCode.ExactMatch, in_data.fnameWeight,0 ));
  mnameWeight := MAX(GROUP,IF( in_data.mname_match_code=SALT29.MatchCode.ExactMatch, in_data.mnameWeight,0 ));
  lnameWeight := MAX(GROUP,IF( in_data.lname_match_code=SALT29.MatchCode.ExactMatch, in_data.lnameWeight,0 ));
  name_suffixWeight := MAX(GROUP,IF( in_data.name_suffix_match_code=SALT29.MatchCode.ExactMatch, in_data.name_suffixWeight,0 ));
  contact_emailWeight := MAX(GROUP,IF( in_data.contact_email_match_code=SALT29.MatchCode.ExactMatch, in_data.contact_emailWeight,0 ));
  CONTACTNAMEWeight := MAX(GROUP,IF( in_data.CONTACTNAME_match_code=SALT29.MatchCode.ExactMatch, in_data.CONTACTNAMEWeight,0 ));
  STREETADDRESSWeight := MAX(GROUP,IF( in_data.STREETADDRESS_match_code=SALT29.MatchCode.ExactMatch, in_data.STREETADDRESSWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.parent_proxidWeight := MAP( ri.parent_proxidWeight=0 OR le.parent_proxid_match_code=SALT29.MatchCode.ExactMatch => le.parent_proxidWeight,MIN(le.parent_proxidWeight,ri.parent_proxidWeight-1) );
  SELF.ultimate_proxidWeight := MAP( ri.ultimate_proxidWeight=0 OR le.ultimate_proxid_match_code=SALT29.MatchCode.ExactMatch => le.ultimate_proxidWeight,MIN(le.ultimate_proxidWeight,ri.ultimate_proxidWeight-1) );
  SELF.has_lgidWeight := MAP( ri.has_lgidWeight=0 OR le.has_lgid_match_code=SALT29.MatchCode.ExactMatch => le.has_lgidWeight,MIN(le.has_lgidWeight,ri.has_lgidWeight-1) );
  SELF.empidWeight := MAP( ri.empidWeight=0 OR le.empid_match_code=SALT29.MatchCode.ExactMatch => le.empidWeight,MIN(le.empidWeight,ri.empidWeight-1) );
  SELF.powidWeight := MAP( ri.powidWeight=0 OR le.powid_match_code=SALT29.MatchCode.ExactMatch => le.powidWeight,MIN(le.powidWeight,ri.powidWeight-1) );
  SELF.sourceWeight := MAP( ri.sourceWeight=0 OR le.source_match_code=SALT29.MatchCode.ExactMatch => le.sourceWeight,MIN(le.sourceWeight,ri.sourceWeight-1) );
  SELF.source_record_idWeight := MAP( ri.source_record_idWeight=0 OR le.source_record_id_match_code=SALT29.MatchCode.ExactMatch => le.source_record_idWeight,MIN(le.source_record_idWeight,ri.source_record_idWeight-1) );
  SELF.cnp_numberWeight := MAP( ri.cnp_numberWeight=0 OR le.cnp_number_match_code=SALT29.MatchCode.ExactMatch => le.cnp_numberWeight,MIN(le.cnp_numberWeight,ri.cnp_numberWeight-1) );
  SELF.cnp_btypeWeight := MAP( ri.cnp_btypeWeight=0 OR le.cnp_btype_match_code=SALT29.MatchCode.ExactMatch => le.cnp_btypeWeight,MIN(le.cnp_btypeWeight,ri.cnp_btypeWeight-1) );
  SELF.cnp_lowvWeight := MAP( ri.cnp_lowvWeight=0 OR le.cnp_lowv_match_code=SALT29.MatchCode.ExactMatch => le.cnp_lowvWeight,MIN(le.cnp_lowvWeight,ri.cnp_lowvWeight-1) );
  SELF.cnp_nameWeight := MAP( ri.cnp_nameWeight=0 OR le.cnp_name_match_code=SALT29.MatchCode.ExactMatch => le.cnp_nameWeight,MIN(le.cnp_nameWeight,ri.cnp_nameWeight-1) );
  SELF.company_phoneWeight := MAP( ri.company_phoneWeight=0 OR le.company_phone_match_code=SALT29.MatchCode.ExactMatch => le.company_phoneWeight,MIN(le.company_phoneWeight,ri.company_phoneWeight-1) );
  SELF.company_feinWeight := MAP( ri.company_feinWeight=0 OR le.company_fein_match_code=SALT29.MatchCode.ExactMatch => le.company_feinWeight,MIN(le.company_feinWeight,ri.company_feinWeight-1) );
  SELF.company_sic_code1Weight := MAP( ri.company_sic_code1Weight=0 OR le.company_sic_code1_match_code=SALT29.MatchCode.ExactMatch => le.company_sic_code1Weight,MIN(le.company_sic_code1Weight,ri.company_sic_code1Weight-1) );
  SELF.prim_rangeWeight := MAP( ri.prim_rangeWeight=0 OR le.prim_range_match_code=SALT29.MatchCode.ExactMatch => le.prim_rangeWeight,MIN(le.prim_rangeWeight,ri.prim_rangeWeight-1) );
  SELF.prim_nameWeight := MAP( ri.prim_nameWeight=0 OR le.prim_name_match_code=SALT29.MatchCode.ExactMatch => le.prim_nameWeight,MIN(le.prim_nameWeight,ri.prim_nameWeight-1) );
  SELF.sec_rangeWeight := MAP( ri.sec_rangeWeight=0 OR le.sec_range_match_code=SALT29.MatchCode.ExactMatch => le.sec_rangeWeight,MIN(le.sec_rangeWeight,ri.sec_rangeWeight-1) );
  SELF.p_city_nameWeight := MAP( ri.p_city_nameWeight=0 OR le.p_city_name_match_code=SALT29.MatchCode.ExactMatch => le.p_city_nameWeight,MIN(le.p_city_nameWeight,ri.p_city_nameWeight-1) );
  SELF.stWeight := MAP( ri.stWeight=0 OR le.st_match_code=SALT29.MatchCode.ExactMatch => le.stWeight,MIN(le.stWeight,ri.stWeight-1) );
  SELF.zipWeight := MAP( ri.zipWeight=0 OR le.zip_match_code=SALT29.MatchCode.ExactMatch => le.zipWeight,MIN(le.zipWeight,ri.zipWeight-1) );
  SELF.company_urlWeight := MAP( ri.company_urlWeight=0 OR le.company_url_match_code=SALT29.MatchCode.ExactMatch => le.company_urlWeight,MIN(le.company_urlWeight,ri.company_urlWeight-1) );
  SELF.isContactWeight := MAP( ri.isContactWeight=0 OR le.isContact_match_code=SALT29.MatchCode.ExactMatch => le.isContactWeight,MIN(le.isContactWeight,ri.isContactWeight-1) );
  SELF.titleWeight := MAP( ri.titleWeight=0 OR le.title_match_code=SALT29.MatchCode.ExactMatch => le.titleWeight,MIN(le.titleWeight,ri.titleWeight-1) );
  SELF.fnameWeight := MAP( ri.fnameWeight=0 OR le.fname_match_code=SALT29.MatchCode.ExactMatch => le.fnameWeight,MIN(le.fnameWeight,ri.fnameWeight-1) );
  SELF.mnameWeight := MAP( ri.mnameWeight=0 OR le.mname_match_code=SALT29.MatchCode.ExactMatch => le.mnameWeight,MIN(le.mnameWeight,ri.mnameWeight-1) );
  SELF.lnameWeight := MAP( ri.lnameWeight=0 OR le.lname_match_code=SALT29.MatchCode.ExactMatch => le.lnameWeight,MIN(le.lnameWeight,ri.lnameWeight-1) );
  SELF.name_suffixWeight := MAP( ri.name_suffixWeight=0 OR le.name_suffix_match_code=SALT29.MatchCode.ExactMatch => le.name_suffixWeight,MIN(le.name_suffixWeight,ri.name_suffixWeight-1) );
  SELF.contact_emailWeight := MAP( ri.contact_emailWeight=0 OR le.contact_email_match_code=SALT29.MatchCode.ExactMatch => le.contact_emailWeight,MIN(le.contact_emailWeight,ri.contact_emailWeight-1) );
  SELF.CONTACTNAMEWeight := MAP( ri.CONTACTNAMEWeight=0 OR le.CONTACTNAME_match_code=SALT29.MatchCode.ExactMatch => le.CONTACTNAMEWeight,MIN(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight-1) );
  SELF.STREETADDRESSWeight := MAP( ri.STREETADDRESSWeight=0 OR le.STREETADDRESS_match_code=SALT29.MatchCode.ExactMatch => le.STREETADDRESSWeight,MIN(le.STREETADDRESSWeight,ri.STREETADDRESSWeight-1) );
  SELF.Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.powidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.p_city_nameWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN GROUP(R2,Reference,ALL);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
  SELF.Results := ri;
  SELF.Reference := le.Reference;
  SELF.Results_seleid := SORT( ROLLUP( SORT( SELF.Results,seleid),LEFT.seleid=RIGHT.seleid,Combine_Scores(LEFT,RIGHT)),-Weight);
  SELF.Results_orgid := SORT( ROLLUP( SORT( SELF.Results_seleid,orgid),LEFT.orgid=RIGHT.orgid,Combine_Scores(LEFT,RIGHT)),-Weight);
  SELF.Results_ultid := SORT( ROLLUP( SORT( SELF.Results_orgid,ultid),LEFT.ultid=RIGHT.ultid,Combine_Scores(LEFT,RIGHT)),-Weight);
  MAC_Add_ResolutionFlags()
END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),proxid),LEFT.proxid=RIGHT.proxid,Combine_Scores(LEFT,RIGHT))(SALT29.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT29.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,26,R3);
  SALT29.MAC_External_AddPcnt(R3,LayoutScoredFetch,Results_seleid,OutputLayout_Batch,26,R4);
  SALT29.MAC_External_AddPcnt(R4,LayoutScoredFetch,Results_orgid,OutputLayout_Batch,26,R5);
  SALT29.MAC_External_AddPcnt(R5,LayoutScoredFetch,Results_ultid,OutputLayout_Batch,26,R6);
  RETURN r6;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, proxid, LOCAL), Combine_Scores(LEFT,RIGHT), Reference, proxid, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'L_CNPNAME,','') + IF(k&(1<<2)<>0,'L_CNPNAME_ST,','') + IF(k&(1<<3)<>0,'L_ADDRESS1,','') + IF(k&(1<<4)<>0,'L_ADDRESS2,','') + IF(k&(1<<5)<>0,'L_PHONE,','') + IF(k&(1<<6)<>0,'L_FEIN,','') + IF(k&(1<<7)<>0,'L_CONTACT,','') + IF(k&(1<<8)<>0,'L_URL,','') + IF(k&(1<<9)<>0,'L_EMAIL,','') + IF(k&(1<<10)<>0,'L_SOURCE,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT29.UIDType proxid;
  DATASET(SALT29.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) empid_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) powid_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) source_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) company_phone_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) company_fein_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) company_sic_code1_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) p_city_name_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) st_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) zip_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) company_url_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) isContact_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) title_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) contact_email_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) CONTACTNAME_Values := DATASET([],SALT29.Layout_FieldValueList);
  DATASET(SALT29.Layout_FieldValueList) STREETADDRESS_Values := DATASET([],SALT29.Layout_FieldValueList);
END;
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
 
Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_values := SALT29.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
  SELF.ultimate_proxid_values := SALT29.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
  SELF.has_lgid_values := SALT29.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
  SELF.empid_values := SALT29.fn_combine_fieldvaluelist(le.empid_values,ri.empid_values);
  SELF.powid_values := SALT29.fn_combine_fieldvaluelist(le.powid_values,ri.powid_values);
  SELF.source_values := SALT29.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
  SELF.source_record_id_values := SALT29.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
  SELF.cnp_number_values := SALT29.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
  SELF.cnp_btype_values := SALT29.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
  SELF.cnp_lowv_values := SALT29.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
  SELF.cnp_name_values := SALT29.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
  SELF.company_phone_values := SALT29.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
  SELF.company_fein_values := SALT29.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
  SELF.company_sic_code1_values := SALT29.fn_combine_fieldvaluelist(le.company_sic_code1_values,ri.company_sic_code1_values);
  SELF.p_city_name_values := SALT29.fn_combine_fieldvaluelist(le.p_city_name_values,ri.p_city_name_values);
  SELF.st_values := SALT29.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
  SELF.zip_values := SALT29.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
  SELF.company_url_values := SALT29.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
  SELF.isContact_values := SALT29.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
  SELF.title_values := SALT29.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
  SELF.name_suffix_values := SALT29.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
  SELF.contact_email_values := SALT29.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
  SELF.CONTACTNAME_values := SALT29.fn_combine_fieldvaluelist(le.CONTACTNAME_values,ri.CONTACTNAME_values);
  SELF.STREETADDRESS_values := SALT29.fn_combine_fieldvaluelist(le.STREETADDRESS_values,ri.STREETADDRESS_values);
END;
  RETURN ROLLUP( SORT( DISTRIBUTE( infile, HASH(proxid) ), proxid, LOCAL ), LEFT.proxid = RIGHT.proxid, RollValues(LEFT,RIGHT),LOCAL);
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_Values := DATASET([{TRIM((SALT29.StrType)le.parent_proxid)}],SALT29.Layout_FieldValueList);
  SELF.ultimate_proxid_Values := DATASET([{TRIM((SALT29.StrType)le.ultimate_proxid)}],SALT29.Layout_FieldValueList);
  SELF.has_lgid_Values := DATASET([{TRIM((SALT29.StrType)le.has_lgid)}],SALT29.Layout_FieldValueList);
  SELF.empid_Values := IF ( (SALT29.StrType)le.empid = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.empid)}],SALT29.Layout_FieldValueList));
  SELF.powid_Values := IF ( (SALT29.StrType)le.powid = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.powid)}],SALT29.Layout_FieldValueList));
  SELF.source_Values := IF ( (SALT29.StrType)le.source = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.source)}],SALT29.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( (SALT29.StrType)le.source_record_id = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.source_record_id)}],SALT29.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (SALT29.StrType)le.cnp_number = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.cnp_number)}],SALT29.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (SALT29.StrType)le.cnp_btype = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.cnp_btype)}],SALT29.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( (SALT29.StrType)le.cnp_lowv = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.cnp_lowv)}],SALT29.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( (SALT29.StrType)le.cnp_name = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.cnp_name)}],SALT29.Layout_FieldValueList));
  SELF.company_phone_Values := IF ( (SALT29.StrType)le.company_phone = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.company_phone)}],SALT29.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (SALT29.StrType)le.company_fein = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.company_fein)}],SALT29.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( (SALT29.StrType)le.company_sic_code1 = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.company_sic_code1)}],SALT29.Layout_FieldValueList));
  SELF.p_city_name_Values := IF ( (SALT29.StrType)le.p_city_name = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.p_city_name)}],SALT29.Layout_FieldValueList));
  SELF.st_Values := IF ( (SALT29.StrType)le.st = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.st)}],SALT29.Layout_FieldValueList));
  SELF.zip_Values := IF ( (SALT29.StrType)le.zip = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.zip)}],SALT29.Layout_FieldValueList));
  SELF.company_url_Values := IF ( (SALT29.StrType)le.company_url = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.company_url)}],SALT29.Layout_FieldValueList));
  SELF.isContact_Values := IF ( (SALT29.StrType)le.isContact = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.isContact)}],SALT29.Layout_FieldValueList));
  SELF.title_Values := IF ( (SALT29.StrType)le.title = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.title)}],SALT29.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (SALT29.StrType)le.name_suffix = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.name_suffix)}],SALT29.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( (SALT29.StrType)le.contact_email = '',DATASET([],SALT29.Layout_FieldValueList),DATASET([{TRIM((SALT29.StrType)le.contact_email)}],SALT29.Layout_FieldValueList));
  self.CONTACTNAME_Values := IF ( (SALT29.StrType)le.fname = '' AND (SALT29.StrType)le.mname = '' AND (SALT29.StrType)le.lname = '',dataset([],SALT29.Layout_FieldValueList),dataset([{TRIM((SALT29.StrType)le.fname) + ' ' + TRIM((SALT29.StrType)le.mname) + ' ' + TRIM((SALT29.StrType)le.lname)}],SALT29.Layout_FieldValueList));
  self.STREETADDRESS_Values := IF ( (SALT29.StrType)le.prim_range = '' AND (SALT29.StrType)le.prim_name = '' AND (SALT29.StrType)le.sec_range = '',dataset([],SALT29.Layout_FieldValueList),dataset([{TRIM((SALT29.StrType)le.prim_range) + ' ' + TRIM((SALT29.StrType)le.prim_name) + ' ' + TRIM((SALT29.StrType)le.sec_range)}],SALT29.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
END;
