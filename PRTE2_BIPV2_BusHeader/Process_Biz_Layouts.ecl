EXPORT Process_Biz_Layouts := MODULE
 
IMPORT BizLinkFull,SALT37;
SHARED h := PRTE2_BIPV2_BusHeader.File_BizHead;//The input file
 
EXPORT KeyName := PRTE2_BIPV2_BusHeader.Filename_keys.meow; /*HACK07meow*/
 
/*HACK15  Removing aid fields and cnp_nameid field from base file before building the key.
         also not including rcid, vl_id, and source_record_id in the sort/dedup
         which preserves those values for singletons (which we need) and leaves those
         values as arbitrary where we dont care about them.  */
import bipv2;
  s01:=DEDUP(SORT(DISTRIBUTE(h(BIPV2.mod_sources.srcInBase(source)),HASH32(proxid)),EXCEPT rcid,vl_id,source_record_id,LOCAL),EXCEPT rcid,vl_id,source_record_id,LOCAL);
/* HACK  Now taking the post-collapsed key data and truncating the few remaining proxids
         that have more than 9999 records */  
  s:=DEDUP(SORT(s01,proxid,rcid,LOCAL),proxid,LOCAL,KEEP(9999));
EXPORT Key := INDEX(s,{ultid,orgid,seleid,proxid,powid},{s},KeyName);
//Create keys to get from lower-order identifiers to the full hierarchy
 
EXPORT KeyproxidUpName := PRTE2_BIPV2_BusHeader.Filename_keys.sup_proxid; /*HACK07sup_proxid*/
  s := TABLE(h,{ultid,orgid,seleid,proxid,powid},ultid,orgid,seleid,proxid,powid,MERGE);
 
EXPORT KeyproxidUp := INDEX(s,{proxid},{s},KeyproxidUpName);
 
EXPORT KeyseleidUpName := PRTE2_BIPV2_BusHeader.Filename_keys.sup_seleid; /*HACK07sup_seleid*/
  s := TABLE(h,{ultid,orgid,seleid},ultid,orgid,seleid,MERGE);
 
EXPORT KeyseleidUp := INDEX(s,{seleid},{s},KeyseleidUpName);
 
EXPORT KeyorgidUpName := PRTE2_BIPV2_BusHeader.Filename_keys.sup_orgid; /*HACK07sup_orgid*/
  s := TABLE(h,{ultid,orgid},ultid,orgid,MERGE);
 
EXPORT KeyorgidUp := INDEX(s,{orgid},{s},KeyorgidUpName);
// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := PRTE2_BIPV2_BusHeader.Filename_keys.sup_rcid; /*HACK07sup_rcid*/
  SHARED sIDHist := TABLE(h,{ultid,orgid,seleid,proxid,powid,rcid},rcid,ultid,orgid,seleid,proxid,powid,MERGE);
 
EXPORT KeyIDHistory := INDEX(sIDHist,{rcid},{sIDHist},KeyIDHistoryName);
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(Key, OVERWRITE),BUILDINDEX(KeyproxidUp, OVERWRITE),BUILDINDEX(KeyseleidUp, OVERWRITE),BUILDINDEX(KeyorgidUp, OVERWRITE),BUILDINDEX(KeyIDHistory, OVERWRITE));
EXPORT layout_zip_cases := RECORD
  TYPEOF(h.zip) zip;
  INTEGER2 Weight; // we now always store weight in _cases
END;
EXPORT id_stream_layout := RECORD
    SALT37.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    SALT37.UIDType seleid;
    SALT37.UIDType orgid;
    SALT37.UIDType ultid;
    SALT37.UIDType proxid;
    SALT37.UIDType powid; // Is an UNCLE - may be left blank unless required for filtering
    SALT37.UIDType rcid := 0; // Unique record ID for external file
END;
// This function produces elements with the full hierarchy filled in - even if only a 'child' ID was provided
EXPORT id_stream_complete(DATASET(id_stream_layout) id) := FUNCTION
  CF0 := id.proxid<>0 AND id.seleid=0;
  C0 := id(CF0); // In need of filling up
  id_stream_layout Fill0(id_stream_layout le,KeyproxidUp ri) := TRANSFORM
    SELF.seleid := ri.seleid;
    SELF.orgid := ri.orgid;
    SELF.ultid := ri.ultid;
    SELF.powid := ri.powid;
    SELF := le;
  END;
  J0 := JOIN(C0,KeyproxidUp,LEFT.proxid=RIGHT.proxid,Fill0(LEFT,RIGHT),LEFT OUTER,LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  CF1 := id.seleid<>0 AND id.orgid=0  AND ~CF0;
  C1 := id(CF1); // In need of filling up
  id_stream_layout Fill1(id_stream_layout le,KeyseleidUp ri) := TRANSFORM
    SELF.orgid := ri.orgid;
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J1 := JOIN(C1,KeyseleidUp,LEFT.seleid=RIGHT.seleid,Fill1(LEFT,RIGHT),LEFT OUTER,LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  CF2 := id.orgid<>0 AND id.ultid=0  AND ~CF0  AND ~CF1;
  C2 := id(CF2); // In need of filling up
  id_stream_layout Fill2(id_stream_layout le,KeyorgidUp ri) := TRANSFORM
    SELF.ultid := ri.ultid;
    SELF := le;
  END;
  J2 := JOIN(C2,KeyorgidUp,LEFT.orgid=RIGHT.orgid,Fill2(LEFT,RIGHT),LEFT OUTER,LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  RETURN id(rcid<>0 AND proxid=0 OR ultid<>0  AND ~CF0  AND ~CF1  AND ~CF2)+J0+J1+J2;
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(rcid<>0,proxid=0); // Only record ID supplied
  id_stream_layout Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J_rec := JOIN(C,KeyIDHistory,LEFT.rcid=RIGHT.rcid,Load(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  C0 := id(proxid<>0); // proxid is the minormost element
  id_stream_layout Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J0 := JOIN(C0,KeyIDHistory,LEFT.proxid=RIGHT.rcid,Load0(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  C1 := id(seleid<>0,proxid=0); // seleid is the minormost element
  id_stream_layout Load1(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.powid := 0; // Make sure uncles are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J1 := JOIN(C1,KeyIDHistory,LEFT.seleid=RIGHT.rcid,Load1(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  C2 := id(orgid<>0,seleid=0); // orgid is the minormost element
  id_stream_layout Load2(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF.powid := 0; // Make sure uncles are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J2 := JOIN(C2,KeyIDHistory,LEFT.orgid=RIGHT.rcid,Load2(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  C3 := id(ultid<>0,orgid=0); // ultid is the minormost element
  id_stream_layout Load3(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure more minor elements are 0
    SELF.seleid := 0; // Make sure more minor elements are 0
    SELF.orgid := 0; // Make sure more minor elements are 0
    SELF.powid := 0; // Make sure uncles are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J3 := JOIN(C3,KeyIDHistory,LEFT.ultid=RIGHT.rcid,Load3(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  C4 := id(powid<>0,proxid=0); // powid is available and proxid is not
  id_stream_layout Load4(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.rcid := 0; // Don't want record id
    SELF.proxid := 0; // Make sure minor and sibling elements are 0
    SELF.seleid := 0; // Make sure minor and sibling elements are 0
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J4 := JOIN(C4,KeyIDHistory,LEFT.powid=RIGHT.rcid,Load4(LEFT,RIGHT),LIMIT(BizLinkFull.Config_BIP.JoinLimit));
  RETURN J_rec+J0+J1+J2+J3+J4;
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
      SELF.powid := IF ( SELF.did_fetch, ri.powid, le.powid ); // Copy from 'real data' if it exists
      SELF.rcid := IF ( SELF.did_fetch, ri.rcid, le.rcid ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J := JOIN( d,k,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid) AND (LEFT.powid = 0 OR LEFT.powid = RIGHT.powid),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000)/*, LIMIT(Config_BIP.JoinLimit)*/); // Ignore excess records without erroring
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
  SALT37.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  BOOLEAN bGetAllScores := TRUE;
  BOOLEAN disableForce := FALSE;
  h.parent_proxid;
  h.sele_proxid;
  h.org_proxid;
  h.ultimate_proxid;
  h.has_lgid;
  h.empid;
  h.source;
  h.source_record_id;
  h.source_docid;
  h.company_name;
  h.company_name_prefix;
  h.cnp_name;
  h.cnp_number;
  h.cnp_btype;
  h.cnp_lowv;
  h.company_phone;
  h.company_phone_3;
  h.company_phone_3_ex;
  h.company_phone_7;
  h.company_fein;
  h.company_sic_code1;
  h.active_duns_number;
  h.prim_range;
  h.prim_name;
  h.sec_range;
  h.city;
  h.city_clean;
  h.st;
  DATASET(layout_zip_cases) zip_cases;
  h.company_url;
  h.isContact;
  h.contact_did;
  h.title;
  h.fname;
  h.fname_preferred;
  h.mname;
  h.lname;
  h.name_suffix;
  h.contact_ssn;
  h.contact_email;
  h.sele_flag;
  h.org_flag;
  h.ult_flag;
  h.fallback_value;
  SALT37.StrType CONTACTNAME;//Wordbag field for concept
  SALT37.StrType STREETADDRESS;//Wordbag field for concept
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show proxid if it has a record which fully matches
  SALT37.UIDType Entered_rcid := 0; // Allow user to enter rcid to pull data
  SALT37.UIDType Entered_proxid := 0; // Allow user to enter proxid to pull data
  SALT37.UIDType Entered_seleid := 0; // Allow user to enter seleid to pull data
  SALT37.UIDType Entered_orgid := 0; // Allow user to enter orgid to pull data
  SALT37.UIDType Entered_ultid := 0; // Allow user to enter ultid to pull data
  SALT37.UIDType Entered_powid := 0; // Allow user to enter powid to pull data
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.cnp_name <> (TYPEOF(le.cnp_name))'' AND BizLinkFull.Fields.InValid_cnp_name((SALT37.StrType)le.cnp_name)=0 AND EXISTS(le.zip_cases) OR le.cnp_name <> (TYPEOF(le.cnp_name))'' AND BizLinkFull.Fields.InValid_cnp_name((SALT37.StrType)le.cnp_name)=0 AND le.st <> (TYPEOF(le.st))'' AND BizLinkFull.Fields.InValid_st((SALT37.StrType)le.st)=0 OR le.cnp_name <> (TYPEOF(le.cnp_name))'' AND BizLinkFull.Fields.InValid_cnp_name((SALT37.StrType)le.cnp_name)=0 OR le.company_name_prefix <> (TYPEOF(le.company_name_prefix))'' AND BizLinkFull.Fields.InValid_company_name_prefix((SALT37.StrType)le.company_name_prefix)=0 OR le.prim_name <> (TYPEOF(le.prim_name))'' AND BizLinkFull.Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0 AND le.city <> (TYPEOF(le.city))'' AND BizLinkFull.Fields.InValid_city((SALT37.StrType)le.city)=0 AND le.st <> (TYPEOF(le.st))'' AND BizLinkFull.Fields.InValid_st((SALT37.StrType)le.st)=0 OR le.prim_name <> (TYPEOF(le.prim_name))'' AND BizLinkFull.Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0 AND EXISTS(le.zip_cases) OR le.prim_name <> (TYPEOF(le.prim_name))'' AND BizLinkFull.Fields.InValid_prim_name((SALT37.StrType)le.prim_name)=0 AND le.prim_range <> (TYPEOF(le.prim_range))'' AND BizLinkFull.Fields.InValid_prim_range((SALT37.StrType)le.prim_range)=0 AND EXISTS(le.zip_cases) OR le.company_phone_7 <> (TYPEOF(le.company_phone_7))'' AND BizLinkFull.Fields.InValid_company_phone_7((SALT37.StrType)le.company_phone_7)=0 OR le.company_fein <> (TYPEOF(le.company_fein))'' AND BizLinkFull.Fields.InValid_company_fein((SALT37.StrType)le.company_fein)=0 OR le.company_url <> (TYPEOF(le.company_url))'' AND BizLinkFull.Fields.InValid_company_url((SALT37.StrType)le.company_url)=0 OR le.fname_preferred <> (TYPEOF(le.fname_preferred))'' AND BizLinkFull.Fields.InValid_fname_preferred((SALT37.StrType)le.fname_preferred)=0 AND le.lname <> (TYPEOF(le.lname))'' AND BizLinkFull.Fields.InValid_lname((SALT37.StrType)le.lname)=0 OR le.contact_ssn <> (TYPEOF(le.contact_ssn))'' AND BizLinkFull.Fields.InValid_contact_ssn((SALT37.StrType)le.contact_ssn)=0 OR le.contact_email <> (TYPEOF(le.contact_email))'' AND BizLinkFull.Fields.InValid_contact_email((SALT37.StrType)le.contact_email)=0 OR le.company_sic_code1 <> (TYPEOF(le.company_sic_code1))'' AND BizLinkFull.Fields.InValid_company_sic_code1((SALT37.StrType)le.company_sic_code1)=0 AND EXISTS(le.zip_cases) OR le.source_record_id <> (TYPEOF(le.source_record_id))'' AND BizLinkFull.Fields.InValid_source_record_id((SALT37.StrType)le.source_record_id)=0 AND le.source <> (TYPEOF(le.source))'' AND BizLinkFull.Fields.InValid_source((SALT37.StrType)le.source)=0 OR le.contact_did <> (TYPEOF(le.contact_did))'' AND BizLinkFull.Fields.InValid_contact_did((SALT37.StrType)le.contact_did)=0;
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.proxid;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT37.UIDType Reference := 0;//Presently for batch
  h.seleid; // Parent id - in case child does not resolve
  h.orgid; // Parent id - in case child does not resolve
  h.ultid; // Parent id - in case child does not resolve
  h.powid; // Uncle id - in case child does not resolve
  SALT37.UIDType rcid := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.parent_proxid) parent_proxid := (TYPEOF(h.parent_proxid))'';
  INTEGER2 parent_proxidWeight := 0;
  INTEGER1 parent_proxid_match_code := 0;
  TYPEOF(h.sele_proxid) sele_proxid := (TYPEOF(h.sele_proxid))'';
  INTEGER2 sele_proxidWeight := 0;
  INTEGER1 sele_proxid_match_code := 0;
  TYPEOF(h.org_proxid) org_proxid := (TYPEOF(h.org_proxid))'';
  INTEGER2 org_proxidWeight := 0;
  INTEGER1 org_proxid_match_code := 0;
  TYPEOF(h.ultimate_proxid) ultimate_proxid := (TYPEOF(h.ultimate_proxid))'';
  INTEGER2 ultimate_proxidWeight := 0;
  INTEGER1 ultimate_proxid_match_code := 0;
  TYPEOF(h.has_lgid) has_lgid := (TYPEOF(h.has_lgid))'';
  INTEGER2 has_lgidWeight := 0;
  INTEGER1 has_lgid_match_code := 0;
  TYPEOF(h.empid) empid := (TYPEOF(h.empid))'';
  INTEGER2 empidWeight := 0;
  INTEGER1 empid_match_code := 0;
  TYPEOF(h.source) source := (TYPEOF(h.source))'';
  INTEGER2 sourceWeight := 0;
  INTEGER1 source_match_code := 0;
  TYPEOF(h.source_record_id) source_record_id := (TYPEOF(h.source_record_id))'';
  INTEGER2 source_record_idWeight := 0;
  INTEGER1 source_record_id_match_code := 0;
  TYPEOF(h.source_docid) source_docid := (TYPEOF(h.source_docid))'';
  INTEGER2 source_docidWeight := 0;
  INTEGER1 source_docid_match_code := 0;
  TYPEOF(h.company_name) company_name := (TYPEOF(h.company_name))'';
  INTEGER2 company_nameWeight := 0;
  INTEGER1 company_name_match_code := 0;
  TYPEOF(h.company_name_prefix) company_name_prefix := (TYPEOF(h.company_name_prefix))'';
  INTEGER2 company_name_prefixWeight := 0;
  INTEGER1 company_name_prefix_match_code := 0;
  TYPEOF(h.cnp_name) cnp_name := (TYPEOF(h.cnp_name))'';
  INTEGER2 cnp_nameWeight := 0;
  DATASET(SALT37.layout_gss_cases) cnp_name_GSS_cases := DATASET([],SALT37.layout_gss_cases);
  INTEGER2 cnp_name_GSS_Weight := 0;
  INTEGER1 cnp_name_match_code := 0;
  TYPEOF(h.cnp_number) cnp_number := (TYPEOF(h.cnp_number))'';
  INTEGER2 cnp_numberWeight := 0;
  INTEGER1 cnp_number_match_code := 0;
  TYPEOF(h.cnp_btype) cnp_btype := (TYPEOF(h.cnp_btype))'';
  INTEGER2 cnp_btypeWeight := 0;
  INTEGER1 cnp_btype_match_code := 0;
  TYPEOF(h.cnp_lowv) cnp_lowv := (TYPEOF(h.cnp_lowv))'';
  INTEGER2 cnp_lowvWeight := 0;
  INTEGER1 cnp_lowv_match_code := 0;
  TYPEOF(h.company_phone) company_phone := (TYPEOF(h.company_phone))'';
  INTEGER2 company_phoneWeight := 0;
  INTEGER1 company_phone_match_code := 0;
  TYPEOF(h.company_phone_3) company_phone_3 := (TYPEOF(h.company_phone_3))'';
  INTEGER2 company_phone_3Weight := 0;
  INTEGER1 company_phone_3_match_code := 0;
  TYPEOF(h.company_phone_3_ex) company_phone_3_ex := (TYPEOF(h.company_phone_3_ex))'';
  INTEGER2 company_phone_3_exWeight := 0;
  INTEGER1 company_phone_3_ex_match_code := 0;
  TYPEOF(h.company_phone_7) company_phone_7 := (TYPEOF(h.company_phone_7))'';
  INTEGER2 company_phone_7Weight := 0;
  INTEGER1 company_phone_7_match_code := 0;
  TYPEOF(h.company_fein) company_fein := (TYPEOF(h.company_fein))'';
  INTEGER2 company_feinWeight := 0;
  INTEGER1 company_fein_match_code := 0;
  TYPEOF(h.company_sic_code1) company_sic_code1 := (TYPEOF(h.company_sic_code1))'';
  INTEGER2 company_sic_code1Weight := 0;
  INTEGER1 company_sic_code1_match_code := 0;
  TYPEOF(h.active_duns_number) active_duns_number := (TYPEOF(h.active_duns_number))'';
  INTEGER2 active_duns_numberWeight := 0;
  INTEGER1 active_duns_number_match_code := 0;
  TYPEOF(h.prim_range) prim_range := (TYPEOF(h.prim_range))'';
  INTEGER2 prim_rangeWeight := 0;
  INTEGER1 prim_range_match_code := 0;
  TYPEOF(h.prim_name) prim_name := (TYPEOF(h.prim_name))'';
  INTEGER2 prim_nameWeight := 0;
  INTEGER1 prim_name_match_code := 0;
  TYPEOF(h.sec_range) sec_range := (TYPEOF(h.sec_range))'';
  INTEGER2 sec_rangeWeight := 0;
  INTEGER1 sec_range_match_code := 0;
  TYPEOF(h.city) city := (TYPEOF(h.city))'';
  INTEGER2 cityWeight := 0;
  INTEGER1 city_match_code := 0;
  TYPEOF(h.city_clean) city_clean := (TYPEOF(h.city_clean))'';
  INTEGER2 city_cleanWeight := 0;
  INTEGER1 city_clean_match_code := 0;
  TYPEOF(h.st) st := (TYPEOF(h.st))'';
  INTEGER2 stWeight := 0;
  INTEGER1 st_match_code := 0;
  DATASET(layout_zip_cases) zip_cases := DATASET([],layout_zip_cases);
  INTEGER2 zipWeight := 0;
  INTEGER1 zip_match_code := 0;
  TYPEOF(h.company_url) company_url := (TYPEOF(h.company_url))'';
  INTEGER2 company_urlWeight := 0;
  DATASET(SALT37.layout_gss_cases) company_url_GSS_cases := DATASET([],SALT37.layout_gss_cases);
  INTEGER2 company_url_GSS_Weight := 0;
  INTEGER1 company_url_match_code := 0;
  TYPEOF(h.isContact) isContact := (TYPEOF(h.isContact))'';
  INTEGER2 isContactWeight := 0;
  INTEGER1 isContact_match_code := 0;
  TYPEOF(h.contact_did) contact_did := (TYPEOF(h.contact_did))'';
  INTEGER2 contact_didWeight := 0;
  INTEGER1 contact_did_match_code := 0;
  TYPEOF(h.title) title := (TYPEOF(h.title))'';
  INTEGER2 titleWeight := 0;
  INTEGER1 title_match_code := 0;
  TYPEOF(h.fname) fname := (TYPEOF(h.fname))'';
  INTEGER2 fnameWeight := 0;
  INTEGER1 fname_match_code := 0;
  TYPEOF(h.fname_preferred) fname_preferred := (TYPEOF(h.fname_preferred))'';
  INTEGER2 fname_preferredWeight := 0;
  INTEGER1 fname_preferred_match_code := 0;
  TYPEOF(h.mname) mname := (TYPEOF(h.mname))'';
  INTEGER2 mnameWeight := 0;
  INTEGER1 mname_match_code := 0;
  TYPEOF(h.lname) lname := (TYPEOF(h.lname))'';
  INTEGER2 lnameWeight := 0;
  INTEGER1 lname_match_code := 0;
  TYPEOF(h.name_suffix) name_suffix := (TYPEOF(h.name_suffix))'';
  INTEGER2 name_suffixWeight := 0;
  INTEGER1 name_suffix_match_code := 0;
  TYPEOF(h.contact_ssn) contact_ssn := (TYPEOF(h.contact_ssn))'';
  INTEGER2 contact_ssnWeight := 0;
  INTEGER1 contact_ssn_match_code := 0;
  TYPEOF(h.contact_email) contact_email := (TYPEOF(h.contact_email))'';
  INTEGER2 contact_emailWeight := 0;
  INTEGER1 contact_email_match_code := 0;
  TYPEOF(h.sele_flag) sele_flag := (TYPEOF(h.sele_flag))'';
  INTEGER2 sele_flagWeight := 0;
  INTEGER1 sele_flag_match_code := 0;
  TYPEOF(h.org_flag) org_flag := (TYPEOF(h.org_flag))'';
  INTEGER2 org_flagWeight := 0;
  INTEGER1 org_flag_match_code := 0;
  TYPEOF(h.ult_flag) ult_flag := (TYPEOF(h.ult_flag))'';
  INTEGER2 ult_flagWeight := 0;
  INTEGER1 ult_flag_match_code := 0;
  TYPEOF(h.fallback_value) fallback_value := (TYPEOF(h.fallback_value))'';
  INTEGER2 fallback_valueWeight := 0;
  INTEGER1 fallback_value_match_code := 0;
  SALT37.StrType CONTACTNAME := ''; // Concepts always a wordbag
  INTEGER2 CONTACTNAMEWeight := 0;
  INTEGER1 CONTACTNAME_match_code := 0;
  SALT37.StrType STREETADDRESS := ''; // Concepts always a wordbag
  INTEGER2 STREETADDRESSWeight := 0;
  INTEGER1 STREETADDRESS_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
END;
 
EXPORT LayoutScoredFetch update_forcefailed(LayoutScoredFetch le, BOOLEAN disableForce = FALSE) := TRANSFORM
  SELF.ForceFailed := IF(disableForce, FALSE, (le.prim_rangeWeight < BizLinkFull.Config_BIP.prim_range_Force));
  SELF := le;
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT37.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT37.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri, BOOLEAN In_disableForce = FALSE) := TRANSFORM
  BOOLEAN parent_proxidWeightForcedDown := IF ( isWeightForcedDown(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code),TRUE,FALSE );
  SELF.parent_proxidWeight := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxidWeight, ri.parent_proxidWeight );
  SELF.parent_proxid := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxid, ri.parent_proxid );
  SELF.parent_proxid_match_code := IF ( isLeftWinner(le.parent_proxidWeight,ri.parent_proxidWeight,le.parent_proxid_match_code,ri.parent_proxid_match_code ), le.parent_proxid_match_code, ri.parent_proxid_match_code );
  BOOLEAN sele_proxidWeightForcedDown := IF ( isWeightForcedDown(le.sele_proxidWeight,ri.sele_proxidWeight,le.sele_proxid_match_code,ri.sele_proxid_match_code),TRUE,FALSE );
  SELF.sele_proxidWeight := IF ( isLeftWinner(le.sele_proxidWeight,ri.sele_proxidWeight,le.sele_proxid_match_code,ri.sele_proxid_match_code ), le.sele_proxidWeight, ri.sele_proxidWeight );
  SELF.sele_proxid := IF ( isLeftWinner(le.sele_proxidWeight,ri.sele_proxidWeight,le.sele_proxid_match_code,ri.sele_proxid_match_code ), le.sele_proxid, ri.sele_proxid );
  SELF.sele_proxid_match_code := IF ( isLeftWinner(le.sele_proxidWeight,ri.sele_proxidWeight,le.sele_proxid_match_code,ri.sele_proxid_match_code ), le.sele_proxid_match_code, ri.sele_proxid_match_code );
  BOOLEAN org_proxidWeightForcedDown := IF ( isWeightForcedDown(le.org_proxidWeight,ri.org_proxidWeight,le.org_proxid_match_code,ri.org_proxid_match_code),TRUE,FALSE );
  SELF.org_proxidWeight := IF ( isLeftWinner(le.org_proxidWeight,ri.org_proxidWeight,le.org_proxid_match_code,ri.org_proxid_match_code ), le.org_proxidWeight, ri.org_proxidWeight );
  SELF.org_proxid := IF ( isLeftWinner(le.org_proxidWeight,ri.org_proxidWeight,le.org_proxid_match_code,ri.org_proxid_match_code ), le.org_proxid, ri.org_proxid );
  SELF.org_proxid_match_code := IF ( isLeftWinner(le.org_proxidWeight,ri.org_proxidWeight,le.org_proxid_match_code,ri.org_proxid_match_code ), le.org_proxid_match_code, ri.org_proxid_match_code );
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
  BOOLEAN sourceWeightForcedDown := IF ( isWeightForcedDown(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code),TRUE,FALSE );
  SELF.sourceWeight := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.sourceWeight, ri.sourceWeight );
  SELF.source := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.source, ri.source );
  SELF.source_match_code := IF ( isLeftWinner(le.sourceWeight,ri.sourceWeight,le.source_match_code,ri.source_match_code ), le.source_match_code, ri.source_match_code );
  BOOLEAN source_record_idWeightForcedDown := IF ( isWeightForcedDown(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code),TRUE,FALSE );
  SELF.source_record_idWeight := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_idWeight, ri.source_record_idWeight );
  SELF.source_record_id := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_id, ri.source_record_id );
  SELF.source_record_id_match_code := IF ( isLeftWinner(le.source_record_idWeight,ri.source_record_idWeight,le.source_record_id_match_code,ri.source_record_id_match_code ), le.source_record_id_match_code, ri.source_record_id_match_code );
  BOOLEAN source_docidWeightForcedDown := IF ( isWeightForcedDown(le.source_docidWeight,ri.source_docidWeight,le.source_docid_match_code,ri.source_docid_match_code),TRUE,FALSE );
  SELF.source_docidWeight := IF ( isLeftWinner(le.source_docidWeight,ri.source_docidWeight,le.source_docid_match_code,ri.source_docid_match_code ), le.source_docidWeight, ri.source_docidWeight );
  SELF.source_docid := IF ( isLeftWinner(le.source_docidWeight,ri.source_docidWeight,le.source_docid_match_code,ri.source_docid_match_code ), le.source_docid, ri.source_docid );
  SELF.source_docid_match_code := IF ( isLeftWinner(le.source_docidWeight,ri.source_docidWeight,le.source_docid_match_code,ri.source_docid_match_code ), le.source_docid_match_code, ri.source_docid_match_code );
  BOOLEAN company_nameWeightForcedDown := IF ( isWeightForcedDown(le.company_nameWeight,ri.company_nameWeight,le.company_name_match_code,ri.company_name_match_code),TRUE,FALSE );
  SELF.company_nameWeight := IF ( isLeftWinner(le.company_nameWeight,ri.company_nameWeight,le.company_name_match_code,ri.company_name_match_code ), le.company_nameWeight, ri.company_nameWeight );
  SELF.company_name := IF ( isLeftWinner(le.company_nameWeight,ri.company_nameWeight,le.company_name_match_code,ri.company_name_match_code ), le.company_name, ri.company_name );
  SELF.company_name_match_code := IF ( isLeftWinner(le.company_nameWeight,ri.company_nameWeight,le.company_name_match_code,ri.company_name_match_code ), le.company_name_match_code, ri.company_name_match_code );
  BOOLEAN company_name_prefixWeightForcedDown := IF ( isWeightForcedDown(le.company_name_prefixWeight,ri.company_name_prefixWeight,le.company_name_prefix_match_code,ri.company_name_prefix_match_code),TRUE,FALSE );
  SELF.company_name_prefixWeight := IF ( isLeftWinner(le.company_name_prefixWeight,ri.company_name_prefixWeight,le.company_name_prefix_match_code,ri.company_name_prefix_match_code ), le.company_name_prefixWeight, ri.company_name_prefixWeight );
  SELF.company_name_prefix := IF ( isLeftWinner(le.company_name_prefixWeight,ri.company_name_prefixWeight,le.company_name_prefix_match_code,ri.company_name_prefix_match_code ), le.company_name_prefix, ri.company_name_prefix );
  SELF.company_name_prefix_match_code := IF ( isLeftWinner(le.company_name_prefixWeight,ri.company_name_prefixWeight,le.company_name_prefix_match_code,ri.company_name_prefix_match_code ), le.company_name_prefix_match_code, ri.company_name_prefix_match_code );
  BOOLEAN cnp_nameWeightForcedDown := IF ( isWeightForcedDown(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code),TRUE,FALSE );
  SELF.cnp_name_gss_Weight := IF ( EXISTS(le.cnp_name_gss_cases(ri.cnp_name_gss_cases[1].gss_hash=gss_hash)), le.cnp_name_gss_Weight, le.cnp_name_gss_Weight + ri.cnp_name_gss_Weight );
  SELF.cnp_name_gss_cases := IF ( EXISTS(le.cnp_name_gss_cases(ri.cnp_name_gss_cases[1].gss_hash=gss_hash)), le.cnp_name_gss_cases, le.cnp_name_gss_cases + ri.cnp_name_gss_cases );
  SELF.cnp_nameWeight := MAP ( SELF.cnp_name_GSS_Weight > le.cnp_nameWeight AND SELF.cnp_name_GSS_Weight > ri.cnp_nameWeight => SELF.cnp_name_GSS_Weight,
                         le.cnp_nameWeight>ri.cnp_nameWeight => le.cnp_nameWeight, ri.cnp_nameWeight );
  SELF.cnp_name := IF ( le.cnp_nameWeight>ri.cnp_nameWeight AND le.cnp_name <> (TYPEOF(le.cnp_name))'', le.cnp_name, ri.cnp_name );
  SELF.cnp_name_match_code := IF ( isLeftWinner(le.cnp_nameWeight,ri.cnp_nameWeight,le.cnp_name_match_code,ri.cnp_name_match_code ), le.cnp_name_match_code, ri.cnp_name_match_code );
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
  BOOLEAN company_phoneWeightForcedDown := IF ( isWeightForcedDown(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code),TRUE,FALSE );
  SELF.company_phoneWeight := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phoneWeight, ri.company_phoneWeight );
  SELF.company_phone := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phone, ri.company_phone );
  SELF.company_phone_match_code := IF ( isLeftWinner(le.company_phoneWeight,ri.company_phoneWeight,le.company_phone_match_code,ri.company_phone_match_code ), le.company_phone_match_code, ri.company_phone_match_code );
  BOOLEAN company_phone_3WeightForcedDown := IF ( isWeightForcedDown(le.company_phone_3Weight,ri.company_phone_3Weight,le.company_phone_3_match_code,ri.company_phone_3_match_code),TRUE,FALSE );
  SELF.company_phone_3Weight := IF ( isLeftWinner(le.company_phone_3Weight,ri.company_phone_3Weight,le.company_phone_3_match_code,ri.company_phone_3_match_code ), le.company_phone_3Weight, ri.company_phone_3Weight );
  SELF.company_phone_3 := IF ( isLeftWinner(le.company_phone_3Weight,ri.company_phone_3Weight,le.company_phone_3_match_code,ri.company_phone_3_match_code ), le.company_phone_3, ri.company_phone_3 );
  SELF.company_phone_3_match_code := IF ( isLeftWinner(le.company_phone_3Weight,ri.company_phone_3Weight,le.company_phone_3_match_code,ri.company_phone_3_match_code ), le.company_phone_3_match_code, ri.company_phone_3_match_code );
  BOOLEAN company_phone_3_exWeightForcedDown := IF ( isWeightForcedDown(le.company_phone_3_exWeight,ri.company_phone_3_exWeight,le.company_phone_3_ex_match_code,ri.company_phone_3_ex_match_code),TRUE,FALSE );
  SELF.company_phone_3_exWeight := IF ( isLeftWinner(le.company_phone_3_exWeight,ri.company_phone_3_exWeight,le.company_phone_3_ex_match_code,ri.company_phone_3_ex_match_code ), le.company_phone_3_exWeight, ri.company_phone_3_exWeight );
  SELF.company_phone_3_ex := IF ( isLeftWinner(le.company_phone_3_exWeight,ri.company_phone_3_exWeight,le.company_phone_3_ex_match_code,ri.company_phone_3_ex_match_code ), le.company_phone_3_ex, ri.company_phone_3_ex );
  SELF.company_phone_3_ex_match_code := IF ( isLeftWinner(le.company_phone_3_exWeight,ri.company_phone_3_exWeight,le.company_phone_3_ex_match_code,ri.company_phone_3_ex_match_code ), le.company_phone_3_ex_match_code, ri.company_phone_3_ex_match_code );
  BOOLEAN company_phone_7WeightForcedDown := IF ( isWeightForcedDown(le.company_phone_7Weight,ri.company_phone_7Weight,le.company_phone_7_match_code,ri.company_phone_7_match_code),TRUE,FALSE );
  SELF.company_phone_7Weight := IF ( isLeftWinner(le.company_phone_7Weight,ri.company_phone_7Weight,le.company_phone_7_match_code,ri.company_phone_7_match_code ), le.company_phone_7Weight, ri.company_phone_7Weight );
  SELF.company_phone_7 := IF ( isLeftWinner(le.company_phone_7Weight,ri.company_phone_7Weight,le.company_phone_7_match_code,ri.company_phone_7_match_code ), le.company_phone_7, ri.company_phone_7 );
  SELF.company_phone_7_match_code := IF ( isLeftWinner(le.company_phone_7Weight,ri.company_phone_7Weight,le.company_phone_7_match_code,ri.company_phone_7_match_code ), le.company_phone_7_match_code, ri.company_phone_7_match_code );
  BOOLEAN company_feinWeightForcedDown := IF ( isWeightForcedDown(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code),TRUE,FALSE );
  SELF.company_feinWeight := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_feinWeight, ri.company_feinWeight );
  SELF.company_fein := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_fein, ri.company_fein );
  SELF.company_fein_match_code := IF ( isLeftWinner(le.company_feinWeight,ri.company_feinWeight,le.company_fein_match_code,ri.company_fein_match_code ), le.company_fein_match_code, ri.company_fein_match_code );
  BOOLEAN company_sic_code1WeightForcedDown := IF ( isWeightForcedDown(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code),TRUE,FALSE );
  SELF.company_sic_code1Weight := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1Weight, ri.company_sic_code1Weight );
  SELF.company_sic_code1 := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1, ri.company_sic_code1 );
  SELF.company_sic_code1_match_code := IF ( isLeftWinner(le.company_sic_code1Weight,ri.company_sic_code1Weight,le.company_sic_code1_match_code,ri.company_sic_code1_match_code ), le.company_sic_code1_match_code, ri.company_sic_code1_match_code );
  BOOLEAN active_duns_numberWeightForcedDown := IF ( isWeightForcedDown(le.active_duns_numberWeight,ri.active_duns_numberWeight,le.active_duns_number_match_code,ri.active_duns_number_match_code),TRUE,FALSE );
  SELF.active_duns_numberWeight := IF ( isLeftWinner(le.active_duns_numberWeight,ri.active_duns_numberWeight,le.active_duns_number_match_code,ri.active_duns_number_match_code ), le.active_duns_numberWeight, ri.active_duns_numberWeight );
  SELF.active_duns_number := IF ( isLeftWinner(le.active_duns_numberWeight,ri.active_duns_numberWeight,le.active_duns_number_match_code,ri.active_duns_number_match_code ), le.active_duns_number, ri.active_duns_number );
  SELF.active_duns_number_match_code := IF ( isLeftWinner(le.active_duns_numberWeight,ri.active_duns_numberWeight,le.active_duns_number_match_code,ri.active_duns_number_match_code ), le.active_duns_number_match_code, ri.active_duns_number_match_code );
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
  BOOLEAN cityWeightForcedDown := IF ( isWeightForcedDown(le.cityWeight,ri.cityWeight,le.city_match_code,ri.city_match_code),TRUE,FALSE );
  SELF.cityWeight := IF ( isLeftWinner(le.cityWeight,ri.cityWeight,le.city_match_code,ri.city_match_code ), le.cityWeight, ri.cityWeight );
  SELF.city := IF ( isLeftWinner(le.cityWeight,ri.cityWeight,le.city_match_code,ri.city_match_code ), le.city, ri.city );
  SELF.city_match_code := IF ( isLeftWinner(le.cityWeight,ri.cityWeight,le.city_match_code,ri.city_match_code ), le.city_match_code, ri.city_match_code );
  BOOLEAN city_cleanWeightForcedDown := IF ( isWeightForcedDown(le.city_cleanWeight,ri.city_cleanWeight,le.city_clean_match_code,ri.city_clean_match_code),TRUE,FALSE );
  SELF.city_cleanWeight := IF ( isLeftWinner(le.city_cleanWeight,ri.city_cleanWeight,le.city_clean_match_code,ri.city_clean_match_code ), le.city_cleanWeight, ri.city_cleanWeight );
  SELF.city_clean := IF ( isLeftWinner(le.city_cleanWeight,ri.city_cleanWeight,le.city_clean_match_code,ri.city_clean_match_code ), le.city_clean, ri.city_clean );
  SELF.city_clean_match_code := IF ( isLeftWinner(le.city_cleanWeight,ri.city_cleanWeight,le.city_clean_match_code,ri.city_clean_match_code ), le.city_clean_match_code, ri.city_clean_match_code );
  BOOLEAN stWeightForcedDown := IF ( isWeightForcedDown(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code),TRUE,FALSE );
  SELF.stWeight := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.stWeight, ri.stWeight );
  SELF.st := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st, ri.st );
  SELF.st_match_code := IF ( isLeftWinner(le.stWeight,ri.stWeight,le.st_match_code,ri.st_match_code ), le.st_match_code, ri.st_match_code );
  SELF.zip_cases := DEDUP(SORT(le.zip_cases & ri.zip_cases, zip,-weight ),zip);
  SELF.zipWeight := MAX(SELF.zip_cases,weight); // KEEP(1) means you can take the maximum value
  SELF.zip_match_code := IF ( isLeftWinner(le.zipWeight,ri.zipWeight,le.zip_match_code,ri.zip_match_code ), le.zip_match_code, ri.zip_match_code );
  BOOLEAN company_urlWeightForcedDown := IF ( isWeightForcedDown(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code),TRUE,FALSE );
  SELF.company_url_gss_Weight := IF ( EXISTS(le.company_url_gss_cases(ri.company_url_gss_cases[1].gss_hash=gss_hash)), le.company_url_gss_Weight, le.company_url_gss_Weight + ri.company_url_gss_Weight );
  SELF.company_url_gss_cases := IF ( EXISTS(le.company_url_gss_cases(ri.company_url_gss_cases[1].gss_hash=gss_hash)), le.company_url_gss_cases, le.company_url_gss_cases + ri.company_url_gss_cases );
  SELF.company_urlWeight := MAP ( SELF.company_url_GSS_Weight > le.company_urlWeight AND SELF.company_url_GSS_Weight > ri.company_urlWeight => SELF.company_url_GSS_Weight,
                         le.company_urlWeight>ri.company_urlWeight => le.company_urlWeight, ri.company_urlWeight );
  SELF.company_url := IF ( le.company_urlWeight>ri.company_urlWeight AND le.company_url <> (TYPEOF(le.company_url))'', le.company_url, ri.company_url );
  SELF.company_url_match_code := IF ( isLeftWinner(le.company_urlWeight,ri.company_urlWeight,le.company_url_match_code,ri.company_url_match_code ), le.company_url_match_code, ri.company_url_match_code );
  BOOLEAN isContactWeightForcedDown := IF ( isWeightForcedDown(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code),TRUE,FALSE );
  SELF.isContactWeight := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContactWeight, ri.isContactWeight );
  SELF.isContact := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContact, ri.isContact );
  SELF.isContact_match_code := IF ( isLeftWinner(le.isContactWeight,ri.isContactWeight,le.isContact_match_code,ri.isContact_match_code ), le.isContact_match_code, ri.isContact_match_code );
  BOOLEAN contact_didWeightForcedDown := IF ( isWeightForcedDown(le.contact_didWeight,ri.contact_didWeight,le.contact_did_match_code,ri.contact_did_match_code),TRUE,FALSE );
  SELF.contact_didWeight := IF ( isLeftWinner(le.contact_didWeight,ri.contact_didWeight,le.contact_did_match_code,ri.contact_did_match_code ), le.contact_didWeight, ri.contact_didWeight );
  SELF.contact_did := IF ( isLeftWinner(le.contact_didWeight,ri.contact_didWeight,le.contact_did_match_code,ri.contact_did_match_code ), le.contact_did, ri.contact_did );
  SELF.contact_did_match_code := IF ( isLeftWinner(le.contact_didWeight,ri.contact_didWeight,le.contact_did_match_code,ri.contact_did_match_code ), le.contact_did_match_code, ri.contact_did_match_code );
  BOOLEAN titleWeightForcedDown := IF ( isWeightForcedDown(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code),TRUE,FALSE );
  SELF.titleWeight := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.titleWeight, ri.titleWeight );
  SELF.title := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.title, ri.title );
  SELF.title_match_code := IF ( isLeftWinner(le.titleWeight,ri.titleWeight,le.title_match_code,ri.title_match_code ), le.title_match_code, ri.title_match_code );
  BOOLEAN fnameWeightForcedDown := IF ( isWeightForcedDown(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code),TRUE,FALSE );
  SELF.fnameWeight := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fnameWeight, ri.fnameWeight );
  SELF.fname := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fname, ri.fname );
  SELF.fname_match_code := IF ( isLeftWinner(le.fnameWeight,ri.fnameWeight,le.fname_match_code,ri.fname_match_code ), le.fname_match_code, ri.fname_match_code );
  BOOLEAN fname_preferredWeightForcedDown := IF ( isWeightForcedDown(le.fname_preferredWeight,ri.fname_preferredWeight,le.fname_preferred_match_code,ri.fname_preferred_match_code),TRUE,FALSE );
  SELF.fname_preferredWeight := IF ( isLeftWinner(le.fname_preferredWeight,ri.fname_preferredWeight,le.fname_preferred_match_code,ri.fname_preferred_match_code ), le.fname_preferredWeight, ri.fname_preferredWeight );
  SELF.fname_preferred := IF ( isLeftWinner(le.fname_preferredWeight,ri.fname_preferredWeight,le.fname_preferred_match_code,ri.fname_preferred_match_code ), le.fname_preferred, ri.fname_preferred );
  SELF.fname_preferred_match_code := IF ( isLeftWinner(le.fname_preferredWeight,ri.fname_preferredWeight,le.fname_preferred_match_code,ri.fname_preferred_match_code ), le.fname_preferred_match_code, ri.fname_preferred_match_code );
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
  BOOLEAN contact_ssnWeightForcedDown := IF ( isWeightForcedDown(le.contact_ssnWeight,ri.contact_ssnWeight,le.contact_ssn_match_code,ri.contact_ssn_match_code),TRUE,FALSE );
  SELF.contact_ssnWeight := IF ( isLeftWinner(le.contact_ssnWeight,ri.contact_ssnWeight,le.contact_ssn_match_code,ri.contact_ssn_match_code ), le.contact_ssnWeight, ri.contact_ssnWeight );
  SELF.contact_ssn := IF ( isLeftWinner(le.contact_ssnWeight,ri.contact_ssnWeight,le.contact_ssn_match_code,ri.contact_ssn_match_code ), le.contact_ssn, ri.contact_ssn );
  SELF.contact_ssn_match_code := IF ( isLeftWinner(le.contact_ssnWeight,ri.contact_ssnWeight,le.contact_ssn_match_code,ri.contact_ssn_match_code ), le.contact_ssn_match_code, ri.contact_ssn_match_code );
  BOOLEAN contact_emailWeightForcedDown := IF ( isWeightForcedDown(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code),TRUE,FALSE );
  SELF.contact_emailWeight := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_emailWeight, ri.contact_emailWeight );
  SELF.contact_email := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_email, ri.contact_email );
  SELF.contact_email_match_code := IF ( isLeftWinner(le.contact_emailWeight,ri.contact_emailWeight,le.contact_email_match_code,ri.contact_email_match_code ), le.contact_email_match_code, ri.contact_email_match_code );
  BOOLEAN sele_flagWeightForcedDown := IF ( isWeightForcedDown(le.sele_flagWeight,ri.sele_flagWeight,le.sele_flag_match_code,ri.sele_flag_match_code),TRUE,FALSE );
  SELF.sele_flagWeight := IF ( isLeftWinner(le.sele_flagWeight,ri.sele_flagWeight,le.sele_flag_match_code,ri.sele_flag_match_code ), le.sele_flagWeight, ri.sele_flagWeight );
  SELF.sele_flag := IF ( isLeftWinner(le.sele_flagWeight,ri.sele_flagWeight,le.sele_flag_match_code,ri.sele_flag_match_code ), le.sele_flag, ri.sele_flag );
  SELF.sele_flag_match_code := IF ( isLeftWinner(le.sele_flagWeight,ri.sele_flagWeight,le.sele_flag_match_code,ri.sele_flag_match_code ), le.sele_flag_match_code, ri.sele_flag_match_code );
  BOOLEAN org_flagWeightForcedDown := IF ( isWeightForcedDown(le.org_flagWeight,ri.org_flagWeight,le.org_flag_match_code,ri.org_flag_match_code),TRUE,FALSE );
  SELF.org_flagWeight := IF ( isLeftWinner(le.org_flagWeight,ri.org_flagWeight,le.org_flag_match_code,ri.org_flag_match_code ), le.org_flagWeight, ri.org_flagWeight );
  SELF.org_flag := IF ( isLeftWinner(le.org_flagWeight,ri.org_flagWeight,le.org_flag_match_code,ri.org_flag_match_code ), le.org_flag, ri.org_flag );
  SELF.org_flag_match_code := IF ( isLeftWinner(le.org_flagWeight,ri.org_flagWeight,le.org_flag_match_code,ri.org_flag_match_code ), le.org_flag_match_code, ri.org_flag_match_code );
  BOOLEAN ult_flagWeightForcedDown := IF ( isWeightForcedDown(le.ult_flagWeight,ri.ult_flagWeight,le.ult_flag_match_code,ri.ult_flag_match_code),TRUE,FALSE );
  SELF.ult_flagWeight := IF ( isLeftWinner(le.ult_flagWeight,ri.ult_flagWeight,le.ult_flag_match_code,ri.ult_flag_match_code ), le.ult_flagWeight, ri.ult_flagWeight );
  SELF.ult_flag := IF ( isLeftWinner(le.ult_flagWeight,ri.ult_flagWeight,le.ult_flag_match_code,ri.ult_flag_match_code ), le.ult_flag, ri.ult_flag );
  SELF.ult_flag_match_code := IF ( isLeftWinner(le.ult_flagWeight,ri.ult_flagWeight,le.ult_flag_match_code,ri.ult_flag_match_code ), le.ult_flag_match_code, ri.ult_flag_match_code );
  BOOLEAN fallback_valueWeightForcedDown := IF ( isWeightForcedDown(le.fallback_valueWeight,ri.fallback_valueWeight,le.fallback_value_match_code,ri.fallback_value_match_code),TRUE,FALSE );
  SELF.fallback_valueWeight := IF ( isLeftWinner(le.fallback_valueWeight,ri.fallback_valueWeight,le.fallback_value_match_code,ri.fallback_value_match_code ), le.fallback_valueWeight, ri.fallback_valueWeight );
  SELF.fallback_value := IF ( isLeftWinner(le.fallback_valueWeight,ri.fallback_valueWeight,le.fallback_value_match_code,ri.fallback_value_match_code ), le.fallback_value, ri.fallback_value );
  SELF.fallback_value_match_code := IF ( isLeftWinner(le.fallback_valueWeight,ri.fallback_valueWeight,le.fallback_value_match_code,ri.fallback_value_match_code ), le.fallback_value_match_code, ri.fallback_value_match_code );
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
  SELF.powid := IF ( le.powid=ri.powid, le.powid, 0 ); // Zero out if collapsing a parent
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.ForceFailed := IF(In_disableForce, FALSE, (SELF.prim_rangeWeight < BizLinkFull.Config_BIP.prim_range_Force))/*HACK03*/ OR SELF.cnp_nameWeight < 4;
  INTEGER2 Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.sele_proxidWeight) + MAX(0,SELF.org_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.source_docidWeight) + MAX(0,SELF.company_nameWeight) + MAX(0,SELF.company_name_prefixWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_phone_3Weight) + MAX(0,SELF.company_phone_3_exWeight) + MAX(0,SELF.company_phone_7Weight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.active_duns_numberWeight) + MAX(0,SELF.cityWeight) + MAX(0,SELF.city_cleanWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.contact_didWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.fname_preferredWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_ssnWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.sele_flagWeight) + MAX(0,SELF.org_flagWeight) + MAX(0,SELF.ult_flagWeight) + MAX(0,SELF.fallback_valueWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
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
  BOOLEAN Resolved_powid := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  DATASET(LayoutScoredFetch) Results_seleid;
  DATASET(LayoutScoredFetch) Results_orgid;
  DATASET(LayoutScoredFetch) Results_ultid;
  DATASET(LayoutScoredFetch) Results_powid;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT37.UIDType Reference;
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
  SELF.Resolved_powid := COUNT(SELF.results_powid(Weight>=MAX(SELF.results_powid,Weight)-5)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.parent_proxidWeight = 0,'','|'+IF(le.parent_proxidWeight < 0,'-','')+'parent_proxid')+IF(le.sele_proxidWeight = 0,'','|'+IF(le.sele_proxidWeight < 0,'-','')+'sele_proxid')+IF(le.org_proxidWeight = 0,'','|'+IF(le.org_proxidWeight < 0,'-','')+'org_proxid')+IF(le.ultimate_proxidWeight = 0,'','|'+IF(le.ultimate_proxidWeight < 0,'-','')+'ultimate_proxid')+IF(le.has_lgidWeight = 0,'','|'+IF(le.has_lgidWeight < 0,'-','')+'has_lgid')+IF(le.empidWeight = 0,'','|'+IF(le.empidWeight < 0,'-','')+'empid')+IF(le.sourceWeight = 0,'','|'+IF(le.sourceWeight < 0,'-','')+'source')+IF(le.source_record_idWeight = 0,'','|'+IF(le.source_record_idWeight < 0,'-','')+'source_record_id')+IF(le.source_docidWeight = 0,'','|'+IF(le.source_docidWeight < 0,'-','')+'source_docid')+IF(le.company_nameWeight = 0,'','|'+IF(le.company_nameWeight < 0,'-','')+'company_name')+IF(le.company_name_prefixWeight = 0,'','|'+IF(le.company_name_prefixWeight < 0,'-','')+'company_name_prefix')+IF(le.cnp_nameWeight = 0,'','|'+IF(le.cnp_nameWeight < 0,'-','')+'cnp_name')+IF(le.cnp_numberWeight = 0,'','|'+IF(le.cnp_numberWeight < 0,'-','')+'cnp_number')+IF(le.cnp_btypeWeight = 0,'','|'+IF(le.cnp_btypeWeight < 0,'-','')+'cnp_btype')+IF(le.cnp_lowvWeight = 0,'','|'+IF(le.cnp_lowvWeight < 0,'-','')+'cnp_lowv')+IF(le.company_phoneWeight = 0,'','|'+IF(le.company_phoneWeight < 0,'-','')+'company_phone')+IF(le.company_phone_3Weight = 0,'','|'+IF(le.company_phone_3Weight < 0,'-','')+'company_phone_3')+IF(le.company_phone_3_exWeight = 0,'','|'+IF(le.company_phone_3_exWeight < 0,'-','')+'company_phone_3_ex')+IF(le.company_phone_7Weight = 0,'','|'+IF(le.company_phone_7Weight < 0,'-','')+'company_phone_7')+IF(le.company_feinWeight = 0,'','|'+IF(le.company_feinWeight < 0,'-','')+'company_fein')+IF(le.company_sic_code1Weight = 0,'','|'+IF(le.company_sic_code1Weight < 0,'-','')+'company_sic_code1')+IF(le.active_duns_numberWeight = 0,'','|'+IF(le.active_duns_numberWeight < 0,'-','')+'active_duns_number')+IF(le.prim_rangeWeight = 0,'','|'+IF(le.prim_rangeWeight < 0,'-','')+'prim_range')+IF(le.prim_nameWeight = 0,'','|'+IF(le.prim_nameWeight < 0,'-','')+'prim_name')+IF(le.sec_rangeWeight = 0,'','|'+IF(le.sec_rangeWeight < 0,'-','')+'sec_range')+IF(le.cityWeight = 0,'','|'+IF(le.cityWeight < 0,'-','')+'city')+IF(le.city_cleanWeight = 0,'','|'+IF(le.city_cleanWeight < 0,'-','')+'city_clean')+IF(le.stWeight = 0,'','|'+IF(le.stWeight < 0,'-','')+'st')+IF(le.zipWeight = 0,'','|'+IF(le.zipWeight < 0,'-','')+'zip')+IF(le.company_urlWeight = 0,'','|'+IF(le.company_urlWeight < 0,'-','')+'company_url')+IF(le.isContactWeight = 0,'','|'+IF(le.isContactWeight < 0,'-','')+'isContact')+IF(le.contact_didWeight = 0,'','|'+IF(le.contact_didWeight < 0,'-','')+'contact_did')+IF(le.titleWeight = 0,'','|'+IF(le.titleWeight < 0,'-','')+'title')+IF(le.fnameWeight = 0,'','|'+IF(le.fnameWeight < 0,'-','')+'fname')+IF(le.fname_preferredWeight = 0,'','|'+IF(le.fname_preferredWeight < 0,'-','')+'fname_preferred')+IF(le.mnameWeight = 0,'','|'+IF(le.mnameWeight < 0,'-','')+'mname')+IF(le.lnameWeight = 0,'','|'+IF(le.lnameWeight < 0,'-','')+'lname')+IF(le.name_suffixWeight = 0,'','|'+IF(le.name_suffixWeight < 0,'-','')+'name_suffix')+IF(le.contact_ssnWeight = 0,'','|'+IF(le.contact_ssnWeight < 0,'-','')+'contact_ssn')+IF(le.contact_emailWeight = 0,'','|'+IF(le.contact_emailWeight < 0,'-','')+'contact_email')+IF(le.sele_flagWeight = 0,'','|'+IF(le.sele_flagWeight < 0,'-','')+'sele_flag')+IF(le.org_flagWeight = 0,'','|'+IF(le.org_flagWeight < 0,'-','')+'org_flag')+IF(le.ult_flagWeight = 0,'','|'+IF(le.ult_flagWeight < 0,'-','')+'ult_flag')+IF(le.fallback_valueWeight = 0,'','|'+IF(le.fallback_valueWeight < 0,'-','')+'fallback_value')+IF(le.CONTACTNAMEWeight = 0,'','|'+IF(le.CONTACTNAMEWeight < 0,'-','')+'CONTACTNAME')+IF(le.STREETADDRESSWeight = 0,'','|'+IF(le.STREETADDRESSWeight < 0,'-','')+'STREETADDRESS');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
aggregateRec := RECORD
  in_data.reference;
  parent_proxidWeight := MAX(GROUP,IF( in_data.parent_proxid_match_code=SALT37.MatchCode.ExactMatch, in_data.parent_proxidWeight,0 ));
  sele_proxidWeight := MAX(GROUP,IF( in_data.sele_proxid_match_code=SALT37.MatchCode.ExactMatch, in_data.sele_proxidWeight,0 ));
  org_proxidWeight := MAX(GROUP,IF( in_data.org_proxid_match_code=SALT37.MatchCode.ExactMatch, in_data.org_proxidWeight,0 ));
  ultimate_proxidWeight := MAX(GROUP,IF( in_data.ultimate_proxid_match_code=SALT37.MatchCode.ExactMatch, in_data.ultimate_proxidWeight,0 ));
  has_lgidWeight := MAX(GROUP,IF( in_data.has_lgid_match_code=SALT37.MatchCode.ExactMatch, in_data.has_lgidWeight,0 ));
  empidWeight := MAX(GROUP,IF( in_data.empid_match_code=SALT37.MatchCode.ExactMatch, in_data.empidWeight,0 ));
  sourceWeight := MAX(GROUP,IF( in_data.source_match_code=SALT37.MatchCode.ExactMatch, in_data.sourceWeight,0 ));
  source_record_idWeight := MAX(GROUP,IF( in_data.source_record_id_match_code=SALT37.MatchCode.ExactMatch, in_data.source_record_idWeight,0 ));
  source_docidWeight := MAX(GROUP,IF( in_data.source_docid_match_code=SALT37.MatchCode.ExactMatch, in_data.source_docidWeight,0 ));
  company_nameWeight := MAX(GROUP,IF( in_data.company_name_match_code=SALT37.MatchCode.ExactMatch, in_data.company_nameWeight,0 ));
  company_name_prefixWeight := MAX(GROUP,IF( in_data.company_name_prefix_match_code=SALT37.MatchCode.ExactMatch, in_data.company_name_prefixWeight,0 ));
  cnp_nameWeight := MAX(GROUP,IF( in_data.cnp_name_match_code=SALT37.MatchCode.ExactMatch, in_data.cnp_nameWeight,0 ));
  cnp_numberWeight := MAX(GROUP,IF( in_data.cnp_number_match_code=SALT37.MatchCode.ExactMatch, in_data.cnp_numberWeight,0 ));
  cnp_btypeWeight := MAX(GROUP,IF( in_data.cnp_btype_match_code=SALT37.MatchCode.ExactMatch, in_data.cnp_btypeWeight,0 ));
  cnp_lowvWeight := MAX(GROUP,IF( in_data.cnp_lowv_match_code=SALT37.MatchCode.ExactMatch, in_data.cnp_lowvWeight,0 ));
  company_phoneWeight := MAX(GROUP,IF( in_data.company_phone_match_code=SALT37.MatchCode.ExactMatch, in_data.company_phoneWeight,0 ));
  company_phone_3Weight := MAX(GROUP,IF( in_data.company_phone_3_match_code=SALT37.MatchCode.ExactMatch, in_data.company_phone_3Weight,0 ));
  company_phone_3_exWeight := MAX(GROUP,IF( in_data.company_phone_3_ex_match_code=SALT37.MatchCode.ExactMatch, in_data.company_phone_3_exWeight,0 ));
  company_phone_7Weight := MAX(GROUP,IF( in_data.company_phone_7_match_code=SALT37.MatchCode.ExactMatch, in_data.company_phone_7Weight,0 ));
  company_feinWeight := MAX(GROUP,IF( in_data.company_fein_match_code=SALT37.MatchCode.ExactMatch, in_data.company_feinWeight,0 ));
  company_sic_code1Weight := MAX(GROUP,IF( in_data.company_sic_code1_match_code=SALT37.MatchCode.ExactMatch, in_data.company_sic_code1Weight,0 ));
  active_duns_numberWeight := MAX(GROUP,IF( in_data.active_duns_number_match_code=SALT37.MatchCode.ExactMatch, in_data.active_duns_numberWeight,0 ));
  prim_rangeWeight := MAX(GROUP,IF( in_data.prim_range_match_code=SALT37.MatchCode.ExactMatch, in_data.prim_rangeWeight,0 ));
  prim_nameWeight := MAX(GROUP,IF( in_data.prim_name_match_code=SALT37.MatchCode.ExactMatch, in_data.prim_nameWeight,0 ));
  sec_rangeWeight := MAX(GROUP,IF( in_data.sec_range_match_code=SALT37.MatchCode.ExactMatch, in_data.sec_rangeWeight,0 ));
  cityWeight := MAX(GROUP,IF( in_data.city_match_code=SALT37.MatchCode.ExactMatch, in_data.cityWeight,0 ));
  city_cleanWeight := MAX(GROUP,IF( in_data.city_clean_match_code=SALT37.MatchCode.ExactMatch, in_data.city_cleanWeight,0 ));
  stWeight := MAX(GROUP,IF( in_data.st_match_code=SALT37.MatchCode.ExactMatch, in_data.stWeight,0 ));
  zipWeight := MAX(GROUP,IF( in_data.zip_match_code=SALT37.MatchCode.ExactMatch, in_data.zipWeight,0 ));
  company_urlWeight := MAX(GROUP,IF( in_data.company_url_match_code=SALT37.MatchCode.ExactMatch, in_data.company_urlWeight,0 ));
  isContactWeight := MAX(GROUP,IF( in_data.isContact_match_code=SALT37.MatchCode.ExactMatch, in_data.isContactWeight,0 ));
  contact_didWeight := MAX(GROUP,IF( in_data.contact_did_match_code=SALT37.MatchCode.ExactMatch, in_data.contact_didWeight,0 ));
  titleWeight := MAX(GROUP,IF( in_data.title_match_code=SALT37.MatchCode.ExactMatch, in_data.titleWeight,0 ));
  fnameWeight := MAX(GROUP,IF( in_data.fname_match_code=SALT37.MatchCode.ExactMatch, in_data.fnameWeight,0 ));
  fname_preferredWeight := MAX(GROUP,IF( in_data.fname_preferred_match_code=SALT37.MatchCode.ExactMatch, in_data.fname_preferredWeight,0 ));
  mnameWeight := MAX(GROUP,IF( in_data.mname_match_code=SALT37.MatchCode.ExactMatch, in_data.mnameWeight,0 ));
  lnameWeight := MAX(GROUP,IF( in_data.lname_match_code=SALT37.MatchCode.ExactMatch, in_data.lnameWeight,0 ));
  name_suffixWeight := MAX(GROUP,IF( in_data.name_suffix_match_code=SALT37.MatchCode.ExactMatch, in_data.name_suffixWeight,0 ));
  contact_ssnWeight := MAX(GROUP,IF( in_data.contact_ssn_match_code=SALT37.MatchCode.ExactMatch, in_data.contact_ssnWeight,0 ));
  contact_emailWeight := MAX(GROUP,IF( in_data.contact_email_match_code=SALT37.MatchCode.ExactMatch, in_data.contact_emailWeight,0 ));
  sele_flagWeight := MAX(GROUP,IF( in_data.sele_flag_match_code=SALT37.MatchCode.ExactMatch, in_data.sele_flagWeight,0 ));
  org_flagWeight := MAX(GROUP,IF( in_data.org_flag_match_code=SALT37.MatchCode.ExactMatch, in_data.org_flagWeight,0 ));
  ult_flagWeight := MAX(GROUP,IF( in_data.ult_flag_match_code=SALT37.MatchCode.ExactMatch, in_data.ult_flagWeight,0 ));
  fallback_valueWeight := MAX(GROUP,IF( in_data.fallback_value_match_code=SALT37.MatchCode.ExactMatch, in_data.fallback_valueWeight,0 ));
  CONTACTNAMEWeight := MAX(GROUP,IF( in_data.CONTACTNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.CONTACTNAMEWeight,0 ));
  STREETADDRESSWeight := MAX(GROUP,IF( in_data.STREETADDRESS_match_code=SALT37.MatchCode.ExactMatch, in_data.STREETADDRESSWeight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.parent_proxidWeight := MAP( ri.parent_proxidWeight=0 OR le.parent_proxid_match_code=SALT37.MatchCode.ExactMatch => le.parent_proxidWeight,MIN(le.parent_proxidWeight,ri.parent_proxidWeight-1) );
  SELF.sele_proxidWeight := MAP( ri.sele_proxidWeight=0 OR le.sele_proxid_match_code=SALT37.MatchCode.ExactMatch => le.sele_proxidWeight,MIN(le.sele_proxidWeight,ri.sele_proxidWeight-1) );
  SELF.org_proxidWeight := MAP( ri.org_proxidWeight=0 OR le.org_proxid_match_code=SALT37.MatchCode.ExactMatch => le.org_proxidWeight,MIN(le.org_proxidWeight,ri.org_proxidWeight-1) );
  SELF.ultimate_proxidWeight := MAP( ri.ultimate_proxidWeight=0 OR le.ultimate_proxid_match_code=SALT37.MatchCode.ExactMatch => le.ultimate_proxidWeight,MIN(le.ultimate_proxidWeight,ri.ultimate_proxidWeight-1) );
  SELF.has_lgidWeight := MAP( ri.has_lgidWeight=0 OR le.has_lgid_match_code=SALT37.MatchCode.ExactMatch => le.has_lgidWeight,MIN(le.has_lgidWeight,ri.has_lgidWeight-1) );
  SELF.empidWeight := MAP( ri.empidWeight=0 OR le.empid_match_code=SALT37.MatchCode.ExactMatch => le.empidWeight,MIN(le.empidWeight,ri.empidWeight-1) );
  SELF.sourceWeight := MAP( ri.sourceWeight=0 OR le.source_match_code=SALT37.MatchCode.ExactMatch => le.sourceWeight,MIN(le.sourceWeight,ri.sourceWeight-1) );
  SELF.source_record_idWeight := MAP( ri.source_record_idWeight=0 OR le.source_record_id_match_code=SALT37.MatchCode.ExactMatch => le.source_record_idWeight,MIN(le.source_record_idWeight,ri.source_record_idWeight-1) );
  SELF.source_docidWeight := MAP( ri.source_docidWeight=0 OR le.source_docid_match_code=SALT37.MatchCode.ExactMatch => le.source_docidWeight,MIN(le.source_docidWeight,ri.source_docidWeight-1) );
  SELF.company_nameWeight := MAP( ri.company_nameWeight=0 OR le.company_name_match_code=SALT37.MatchCode.ExactMatch => le.company_nameWeight,MIN(le.company_nameWeight,ri.company_nameWeight-1) );
  SELF.company_name_prefixWeight := MAP( ri.company_name_prefixWeight=0 OR le.company_name_prefix_match_code=SALT37.MatchCode.ExactMatch => le.company_name_prefixWeight,MIN(le.company_name_prefixWeight,ri.company_name_prefixWeight-1) );
  SELF.cnp_nameWeight := MAP( ri.cnp_nameWeight=0 OR le.cnp_name_match_code=SALT37.MatchCode.ExactMatch => le.cnp_nameWeight,MIN(le.cnp_nameWeight,ri.cnp_nameWeight-1) );
  SELF.cnp_numberWeight := MAP( ri.cnp_numberWeight=0 OR le.cnp_number_match_code=SALT37.MatchCode.ExactMatch => le.cnp_numberWeight,MIN(le.cnp_numberWeight,ri.cnp_numberWeight-1) );
  SELF.cnp_btypeWeight := MAP( ri.cnp_btypeWeight=0 OR le.cnp_btype_match_code=SALT37.MatchCode.ExactMatch => le.cnp_btypeWeight,MIN(le.cnp_btypeWeight,ri.cnp_btypeWeight-1) );
  SELF.cnp_lowvWeight := MAP( ri.cnp_lowvWeight=0 OR le.cnp_lowv_match_code=SALT37.MatchCode.ExactMatch => le.cnp_lowvWeight,MIN(le.cnp_lowvWeight,ri.cnp_lowvWeight-1) );
  SELF.company_phoneWeight := MAP( ri.company_phoneWeight=0 OR le.company_phone_match_code=SALT37.MatchCode.ExactMatch => le.company_phoneWeight,MIN(le.company_phoneWeight,ri.company_phoneWeight-1) );
  SELF.company_phone_3Weight := MAP( ri.company_phone_3Weight=0 OR le.company_phone_3_match_code=SALT37.MatchCode.ExactMatch => le.company_phone_3Weight,MIN(le.company_phone_3Weight,ri.company_phone_3Weight-1) );
  SELF.company_phone_3_exWeight := MAP( ri.company_phone_3_exWeight=0 OR le.company_phone_3_ex_match_code=SALT37.MatchCode.ExactMatch => le.company_phone_3_exWeight,MIN(le.company_phone_3_exWeight,ri.company_phone_3_exWeight-1) );
  SELF.company_phone_7Weight := MAP( ri.company_phone_7Weight=0 OR le.company_phone_7_match_code=SALT37.MatchCode.ExactMatch => le.company_phone_7Weight,MIN(le.company_phone_7Weight,ri.company_phone_7Weight-1) );
  SELF.company_feinWeight := MAP( ri.company_feinWeight=0 OR le.company_fein_match_code=SALT37.MatchCode.ExactMatch => le.company_feinWeight,MIN(le.company_feinWeight,ri.company_feinWeight-1) );
  SELF.company_sic_code1Weight := MAP( ri.company_sic_code1Weight=0 OR le.company_sic_code1_match_code=SALT37.MatchCode.ExactMatch => le.company_sic_code1Weight,MIN(le.company_sic_code1Weight,ri.company_sic_code1Weight-1) );
  SELF.active_duns_numberWeight := MAP( ri.active_duns_numberWeight=0 OR le.active_duns_number_match_code=SALT37.MatchCode.ExactMatch => le.active_duns_numberWeight,MIN(le.active_duns_numberWeight,ri.active_duns_numberWeight-1) );
  SELF.prim_rangeWeight := MAP( ri.prim_rangeWeight=0 OR le.prim_range_match_code=SALT37.MatchCode.ExactMatch => le.prim_rangeWeight,MIN(le.prim_rangeWeight,ri.prim_rangeWeight-1) );
  SELF.prim_nameWeight := MAP( ri.prim_nameWeight=0 OR le.prim_name_match_code=SALT37.MatchCode.ExactMatch => le.prim_nameWeight,MIN(le.prim_nameWeight,ri.prim_nameWeight-1) );
  SELF.sec_rangeWeight := MAP( ri.sec_rangeWeight=0 OR le.sec_range_match_code=SALT37.MatchCode.ExactMatch => le.sec_rangeWeight,MIN(le.sec_rangeWeight,ri.sec_rangeWeight-1) );
  SELF.cityWeight := MAP( ri.cityWeight=0 OR le.city_match_code=SALT37.MatchCode.ExactMatch => le.cityWeight,MIN(le.cityWeight,ri.cityWeight-1) );
  SELF.city_cleanWeight := MAP( ri.city_cleanWeight=0 OR le.city_clean_match_code=SALT37.MatchCode.ExactMatch => le.city_cleanWeight,MIN(le.city_cleanWeight,ri.city_cleanWeight-1) );
  SELF.stWeight := MAP( ri.stWeight=0 OR le.st_match_code=SALT37.MatchCode.ExactMatch => le.stWeight,MIN(le.stWeight,ri.stWeight-1) );
  SELF.zipWeight := MAP( ri.zipWeight=0 OR le.zip_match_code=SALT37.MatchCode.ExactMatch => le.zipWeight,MIN(le.zipWeight,ri.zipWeight-1) );
  SELF.company_urlWeight := MAP( ri.company_urlWeight=0 OR le.company_url_match_code=SALT37.MatchCode.ExactMatch => le.company_urlWeight,MIN(le.company_urlWeight,ri.company_urlWeight-1) );
  SELF.isContactWeight := MAP( ri.isContactWeight=0 OR le.isContact_match_code=SALT37.MatchCode.ExactMatch => le.isContactWeight,MIN(le.isContactWeight,ri.isContactWeight-1) );
  SELF.contact_didWeight := MAP( ri.contact_didWeight=0 OR le.contact_did_match_code=SALT37.MatchCode.ExactMatch => le.contact_didWeight,MIN(le.contact_didWeight,ri.contact_didWeight-1) );
  SELF.titleWeight := MAP( ri.titleWeight=0 OR le.title_match_code=SALT37.MatchCode.ExactMatch => le.titleWeight,MIN(le.titleWeight,ri.titleWeight-1) );
  SELF.fnameWeight := MAP( ri.fnameWeight=0 OR le.fname_match_code=SALT37.MatchCode.ExactMatch => le.fnameWeight,MIN(le.fnameWeight,ri.fnameWeight-1) );
  SELF.fname_preferredWeight := MAP( ri.fname_preferredWeight=0 OR le.fname_preferred_match_code=SALT37.MatchCode.ExactMatch => le.fname_preferredWeight,MIN(le.fname_preferredWeight,ri.fname_preferredWeight-1) );
  SELF.mnameWeight := MAP( ri.mnameWeight=0 OR le.mname_match_code=SALT37.MatchCode.ExactMatch => le.mnameWeight,MIN(le.mnameWeight,ri.mnameWeight-1) );
  SELF.lnameWeight := MAP( ri.lnameWeight=0 OR le.lname_match_code=SALT37.MatchCode.ExactMatch => le.lnameWeight,MIN(le.lnameWeight,ri.lnameWeight-1) );
  SELF.name_suffixWeight := MAP( ri.name_suffixWeight=0 OR le.name_suffix_match_code=SALT37.MatchCode.ExactMatch => le.name_suffixWeight,MIN(le.name_suffixWeight,ri.name_suffixWeight-1) );
  SELF.contact_ssnWeight := MAP( ri.contact_ssnWeight=0 OR le.contact_ssn_match_code=SALT37.MatchCode.ExactMatch => le.contact_ssnWeight,MIN(le.contact_ssnWeight,ri.contact_ssnWeight-1) );
  SELF.contact_emailWeight := MAP( ri.contact_emailWeight=0 OR le.contact_email_match_code=SALT37.MatchCode.ExactMatch => le.contact_emailWeight,MIN(le.contact_emailWeight,ri.contact_emailWeight-1) );
  SELF.sele_flagWeight := MAP( ri.sele_flagWeight=0 OR le.sele_flag_match_code=SALT37.MatchCode.ExactMatch => le.sele_flagWeight,MIN(le.sele_flagWeight,ri.sele_flagWeight-1) );
  SELF.org_flagWeight := MAP( ri.org_flagWeight=0 OR le.org_flag_match_code=SALT37.MatchCode.ExactMatch => le.org_flagWeight,MIN(le.org_flagWeight,ri.org_flagWeight-1) );
  SELF.ult_flagWeight := MAP( ri.ult_flagWeight=0 OR le.ult_flag_match_code=SALT37.MatchCode.ExactMatch => le.ult_flagWeight,MIN(le.ult_flagWeight,ri.ult_flagWeight-1) );
  SELF.fallback_valueWeight := MAP( ri.fallback_valueWeight=0 OR le.fallback_value_match_code=SALT37.MatchCode.ExactMatch => le.fallback_valueWeight,MIN(le.fallback_valueWeight,ri.fallback_valueWeight-1) );
  SELF.CONTACTNAMEWeight := MAP( ri.CONTACTNAMEWeight=0 OR le.CONTACTNAME_match_code=SALT37.MatchCode.ExactMatch => le.CONTACTNAMEWeight,MIN(le.CONTACTNAMEWeight,ri.CONTACTNAMEWeight-1) );
  SELF.STREETADDRESSWeight := MAP( ri.STREETADDRESSWeight=0 OR le.STREETADDRESS_match_code=SALT37.MatchCode.ExactMatch => le.STREETADDRESSWeight,MIN(le.STREETADDRESSWeight,ri.STREETADDRESSWeight-1) );
  Weight := MAX(0,SELF.parent_proxidWeight) + MAX(0,SELF.sele_proxidWeight) + MAX(0,SELF.org_proxidWeight) + MAX(0,SELF.ultimate_proxidWeight) + MAX(0,SELF.has_lgidWeight) + MAX(0,SELF.empidWeight) + MAX(0,SELF.sourceWeight) + MAX(0,SELF.source_record_idWeight) + MAX(0,SELF.source_docidWeight) + MAX(0,SELF.company_nameWeight) + MAX(0,SELF.company_name_prefixWeight) + MAX(0,SELF.cnp_nameWeight) + MAX(0,SELF.cnp_numberWeight) + MAX(0,SELF.cnp_btypeWeight) + MAX(0,SELF.cnp_lowvWeight) + MAX(0,SELF.company_phoneWeight) + MAX(0,SELF.company_phone_3Weight) + MAX(0,SELF.company_phone_3_exWeight) + MAX(0,SELF.company_phone_7Weight) + MAX(0,SELF.company_feinWeight) + MAX(0,SELF.company_sic_code1Weight) + MAX(0,SELF.active_duns_numberWeight) + MAX(0,SELF.cityWeight) + MAX(0,SELF.city_cleanWeight) + MAX(0,SELF.stWeight) + MAX(0,SELF.zipWeight) + MAX(0,SELF.company_urlWeight) + MAX(0,SELF.isContactWeight) + MAX(0,SELF.contact_didWeight) + MAX(0,SELF.titleWeight) + MAX(0,SELF.fname_preferredWeight) + MAX(0,SELF.name_suffixWeight) + MAX(0,SELF.contact_ssnWeight) + MAX(0,SELF.contact_emailWeight) + MAX(0,SELF.sele_flagWeight) + MAX(0,SELF.org_flagWeight) + MAX(0,SELF.ult_flagWeight) + MAX(0,SELF.fallback_valueWeight) + MAX(0,SELF.fnameWeight) + MAX(0,SELF.mnameWeight) + MAX(0,SELF.lnameWeight) + MAX(0,SELF.prim_rangeWeight) + MAX(0,SELF.prim_nameWeight) + MAX(0,SELF.sec_rangeWeight);
  SELF.Weight := IF(Weight>0,Weight,MAX(0,le.Weight)); // JA 20171109: I had this commented out to mimic SALT 3.3, but changed it back in order to implement Edin's recommended hack
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,proxid);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_bGetAllScores = TRUE, BOOLEAN In_disableForce = FALSE) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    SELF.Results_seleid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-seleid),LEFT.seleid=RIGHT.seleid,Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
    SELF.Results_orgid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_seleid,-orgid),LEFT.orgid=RIGHT.orgid,Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(seleid=SELF.Results[1].seleid),-seleid));
    SELF.Results_ultid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_orgid,-ultid),LEFT.ultid=RIGHT.ultid,Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(orgid=SELF.Results[1].orgid),-orgid));
    SELF.Results_powid := IF(In_bGetAllScores, SORT( ROLLUP( SORT( SELF.Results,-powid),LEFT.powid=RIGHT.powid,Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),proxid),LEFT.proxid=RIGHT.proxid,Combine_Scores(LEFT,RIGHT,In_disableForce))(SALT37.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT37.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,27,R3);
  SALT37.MAC_External_AddPcnt(R3,LayoutScoredFetch,Results_seleid,OutputLayout_Batch,27,R4);
  SALT37.MAC_External_AddPcnt(R4,LayoutScoredFetch,Results_orgid,OutputLayout_Batch,27,R5);
  SALT37.MAC_External_AddPcnt(R5,LayoutScoredFetch,Results_ultid,OutputLayout_Batch,27,R6);
  SALT37.MAC_External_AddPcnt(R6,LayoutScoredFetch,Results_powid,OutputLayout_Batch,27,R7);
  RETURN r7;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_disableForce = TRUE) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, proxid, LOCAL), Combine_Scores(LEFT,RIGHT, In_disableForce), Reference, proxid, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(BizLinkFull.Config_BIP.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'L_CNPNAME_ZIP,','') + IF(k&(1<<2)<>0,'L_CNPNAME_ST,','') + IF(k&(1<<3)<>0,'L_CNPNAME,','') + IF(k&(1<<4)<>0,'L_CNPNAME_FUZZY,','') + IF(k&(1<<5)<>0,'L_ADDRESS1,','') + IF(k&(1<<6)<>0,'L_ADDRESS2,','') + IF(k&(1<<7)<>0,'L_ADDRESS3,','') + IF(k&(1<<8)<>0,'L_PHONE,','') + IF(k&(1<<9)<>0,'L_FEIN,','') + IF(k&(1<<10)<>0,'L_URL,','') + IF(k&(1<<11)<>0,'L_CONTACT,','') + IF(k&(1<<12)<>0,'L_CONTACT_SSN,','') + IF(k&(1<<13)<>0,'L_EMAIL,','') + IF(k&(1<<14)<>0,'L_SIC,','') + IF(k&(1<<15)<>0,'L_SOURCE,','') + IF(k&(1<<16)<>0,'L_CONTACT_DID,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  SALT37.UIDType proxid;
  DATASET(SALT37.Layout_FieldValueList) parent_proxid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) sele_proxid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) org_proxid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) ultimate_proxid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) has_lgid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) empid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) source_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) source_record_id_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) source_docid_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_name_prefix_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) cnp_name_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) cnp_number_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) cnp_btype_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) cnp_lowv_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_phone_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_phone_3_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_phone_3_ex_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_phone_7_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_fein_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_sic_code1_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) active_duns_number_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) city_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) city_clean_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) st_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) zip_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) company_url_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) isContact_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) contact_did_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) title_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) fname_preferred_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) name_suffix_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) contact_ssn_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) contact_email_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) sele_flag_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) org_flag_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) ult_flag_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) fallback_value_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) CONTACTNAME_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) STREETADDRESS_Values := DATASET([],SALT37.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SALT37.fn_combine_fieldvaluelist(le.parent_proxid_values,ri.parent_proxid_values);
    SELF.sele_proxid_values := SALT37.fn_combine_fieldvaluelist(le.sele_proxid_values,ri.sele_proxid_values);
    SELF.org_proxid_values := SALT37.fn_combine_fieldvaluelist(le.org_proxid_values,ri.org_proxid_values);
    SELF.ultimate_proxid_values := SALT37.fn_combine_fieldvaluelist(le.ultimate_proxid_values,ri.ultimate_proxid_values);
    SELF.has_lgid_values := SALT37.fn_combine_fieldvaluelist(le.has_lgid_values,ri.has_lgid_values);
    SELF.empid_values := SALT37.fn_combine_fieldvaluelist(le.empid_values,ri.empid_values);
    SELF.source_values := SALT37.fn_combine_fieldvaluelist(le.source_values,ri.source_values);
    SELF.source_record_id_values := SALT37.fn_combine_fieldvaluelist(le.source_record_id_values,ri.source_record_id_values);
    SELF.source_docid_values := SALT37.fn_combine_fieldvaluelist(le.source_docid_values,ri.source_docid_values);
    SELF.company_name_values := SALT37.fn_combine_fieldvaluelist(le.company_name_values,ri.company_name_values);
    SELF.company_name_prefix_values := SALT37.fn_combine_fieldvaluelist(le.company_name_prefix_values,ri.company_name_prefix_values);
    SELF.cnp_name_values := SALT37.fn_combine_fieldvaluelist(le.cnp_name_values,ri.cnp_name_values);
    SELF.cnp_number_values := SALT37.fn_combine_fieldvaluelist(le.cnp_number_values,ri.cnp_number_values);
    SELF.cnp_btype_values := SALT37.fn_combine_fieldvaluelist(le.cnp_btype_values,ri.cnp_btype_values);
    SELF.cnp_lowv_values := SALT37.fn_combine_fieldvaluelist(le.cnp_lowv_values,ri.cnp_lowv_values);
    SELF.company_phone_values := SALT37.fn_combine_fieldvaluelist(le.company_phone_values,ri.company_phone_values);
    SELF.company_phone_3_values := SALT37.fn_combine_fieldvaluelist(le.company_phone_3_values,ri.company_phone_3_values);
    SELF.company_phone_3_ex_values := SALT37.fn_combine_fieldvaluelist(le.company_phone_3_ex_values,ri.company_phone_3_ex_values);
    SELF.company_phone_7_values := SALT37.fn_combine_fieldvaluelist(le.company_phone_7_values,ri.company_phone_7_values);
    SELF.company_fein_values := SALT37.fn_combine_fieldvaluelist(le.company_fein_values,ri.company_fein_values);
    SELF.company_sic_code1_values := SALT37.fn_combine_fieldvaluelist(le.company_sic_code1_values,ri.company_sic_code1_values);
    SELF.active_duns_number_values := SALT37.fn_combine_fieldvaluelist(le.active_duns_number_values,ri.active_duns_number_values);
    SELF.city_values := SALT37.fn_combine_fieldvaluelist(le.city_values,ri.city_values);
    SELF.city_clean_values := SALT37.fn_combine_fieldvaluelist(le.city_clean_values,ri.city_clean_values);
    SELF.st_values := SALT37.fn_combine_fieldvaluelist(le.st_values,ri.st_values);
    SELF.zip_values := SALT37.fn_combine_fieldvaluelist(le.zip_values,ri.zip_values);
    SELF.company_url_values := SALT37.fn_combine_fieldvaluelist(le.company_url_values,ri.company_url_values);
    SELF.isContact_values := SALT37.fn_combine_fieldvaluelist(le.isContact_values,ri.isContact_values);
    SELF.contact_did_values := SALT37.fn_combine_fieldvaluelist(le.contact_did_values,ri.contact_did_values);
    SELF.title_values := SALT37.fn_combine_fieldvaluelist(le.title_values,ri.title_values);
    SELF.fname_preferred_values := SALT37.fn_combine_fieldvaluelist(le.fname_preferred_values,ri.fname_preferred_values);
    SELF.name_suffix_values := SALT37.fn_combine_fieldvaluelist(le.name_suffix_values,ri.name_suffix_values);
    SELF.contact_ssn_values := SALT37.fn_combine_fieldvaluelist(le.contact_ssn_values,ri.contact_ssn_values);
    SELF.contact_email_values := SALT37.fn_combine_fieldvaluelist(le.contact_email_values,ri.contact_email_values);
    SELF.sele_flag_values := SALT37.fn_combine_fieldvaluelist(le.sele_flag_values,ri.sele_flag_values);
    SELF.org_flag_values := SALT37.fn_combine_fieldvaluelist(le.org_flag_values,ri.org_flag_values);
    SELF.ult_flag_values := SALT37.fn_combine_fieldvaluelist(le.ult_flag_values,ri.ult_flag_values);
    SELF.fallback_value_values := SALT37.fn_combine_fieldvaluelist(le.fallback_value_values,ri.fallback_value_values);
    SELF.CONTACTNAME_values := SALT37.fn_combine_fieldvaluelist(le.CONTACTNAME_values,ri.CONTACTNAME_values);
    SELF.STREETADDRESS_values := SALT37.fn_combine_fieldvaluelist(le.STREETADDRESS_values,ri.STREETADDRESS_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(proxid) ), proxid, LOCAL ), LEFT.proxid = RIGHT.proxid, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.proxid := le.proxid;
    SELF.parent_proxid_values := SORT(le.parent_proxid_values, -cnt, val, LOCAL);
    SELF.sele_proxid_values := SORT(le.sele_proxid_values, -cnt, val, LOCAL);
    SELF.org_proxid_values := SORT(le.org_proxid_values, -cnt, val, LOCAL);
    SELF.ultimate_proxid_values := SORT(le.ultimate_proxid_values, -cnt, val, LOCAL);
    SELF.has_lgid_values := SORT(le.has_lgid_values, -cnt, val, LOCAL);
    SELF.empid_values := SORT(le.empid_values, -cnt, val, LOCAL);
    SELF.source_values := SORT(le.source_values, -cnt, val, LOCAL);
    SELF.source_record_id_values := SORT(le.source_record_id_values, -cnt, val, LOCAL);
    SELF.source_docid_values := SORT(le.source_docid_values, -cnt, val, LOCAL);
    SELF.company_name_values := SORT(le.company_name_values, -cnt, val, LOCAL);
    SELF.company_name_prefix_values := SORT(le.company_name_prefix_values, -cnt, val, LOCAL);
    SELF.cnp_name_values := SORT(le.cnp_name_values, -cnt, val, LOCAL);
    SELF.cnp_number_values := SORT(le.cnp_number_values, -cnt, val, LOCAL);
    SELF.cnp_btype_values := SORT(le.cnp_btype_values, -cnt, val, LOCAL);
    SELF.cnp_lowv_values := SORT(le.cnp_lowv_values, -cnt, val, LOCAL);
    SELF.company_phone_values := SORT(le.company_phone_values, -cnt, val, LOCAL);
    SELF.company_phone_3_values := SORT(le.company_phone_3_values, -cnt, val, LOCAL);
    SELF.company_phone_3_ex_values := SORT(le.company_phone_3_ex_values, -cnt, val, LOCAL);
    SELF.company_phone_7_values := SORT(le.company_phone_7_values, -cnt, val, LOCAL);
    SELF.company_fein_values := SORT(le.company_fein_values, -cnt, val, LOCAL);
    SELF.company_sic_code1_values := SORT(le.company_sic_code1_values, -cnt, val, LOCAL);
    SELF.active_duns_number_values := SORT(le.active_duns_number_values, -cnt, val, LOCAL);
    SELF.city_values := SORT(le.city_values, -cnt, val, LOCAL);
    SELF.city_clean_values := SORT(le.city_clean_values, -cnt, val, LOCAL);
    SELF.st_values := SORT(le.st_values, -cnt, val, LOCAL);
    SELF.zip_values := SORT(le.zip_values, -cnt, val, LOCAL);
    SELF.company_url_values := SORT(le.company_url_values, -cnt, val, LOCAL);
    SELF.isContact_values := SORT(le.isContact_values, -cnt, val, LOCAL);
    SELF.contact_did_values := SORT(le.contact_did_values, -cnt, val, LOCAL);
    SELF.title_values := SORT(le.title_values, -cnt, val, LOCAL);
    SELF.fname_preferred_values := SORT(le.fname_preferred_values, -cnt, val, LOCAL);
    SELF.name_suffix_values := SORT(le.name_suffix_values, -cnt, val, LOCAL);
    SELF.contact_ssn_values := SORT(le.contact_ssn_values, -cnt, val, LOCAL);
    SELF.contact_email_values := SORT(le.contact_email_values, -cnt, val, LOCAL);
    SELF.sele_flag_values := SORT(le.sele_flag_values, -cnt, val, LOCAL);
    SELF.org_flag_values := SORT(le.org_flag_values, -cnt, val, LOCAL);
    SELF.ult_flag_values := SORT(le.ult_flag_values, -cnt, val, LOCAL);
    SELF.fallback_value_values := SORT(le.fallback_value_values, -cnt, val, LOCAL);
    SELF.CONTACTNAME_values := SORT(le.CONTACTNAME_values, -cnt, val, LOCAL);
    SELF.STREETADDRESS_values := SORT(le.STREETADDRESS_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data) := FUNCTION
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.proxid := le.proxid;
  SELF.parent_proxid_Values := IF ( (SALT37.StrType)le.parent_proxid = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.parent_proxid)}],SALT37.Layout_FieldValueList));
  SELF.sele_proxid_Values := IF ( (SALT37.StrType)le.sele_proxid = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.sele_proxid)}],SALT37.Layout_FieldValueList));
  SELF.org_proxid_Values := IF ( (SALT37.StrType)le.org_proxid = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.org_proxid)}],SALT37.Layout_FieldValueList));
  SELF.ultimate_proxid_Values := IF ( (SALT37.StrType)le.ultimate_proxid = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.ultimate_proxid)}],SALT37.Layout_FieldValueList));
  SELF.has_lgid_Values := DATASET([{TRIM((SALT37.StrType)le.has_lgid)}],SALT37.Layout_FieldValueList);
  SELF.empid_Values := DATASET([{TRIM((SALT37.StrType)le.empid)}],SALT37.Layout_FieldValueList);
  SELF.source_Values := IF ( (SALT37.StrType)le.source = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.source)}],SALT37.Layout_FieldValueList));
  SELF.source_record_id_Values := IF ( (SALT37.StrType)le.source_record_id = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.source_record_id)}],SALT37.Layout_FieldValueList));
  SELF.source_docid_Values := DATASET([{TRIM((SALT37.StrType)le.source_docid)}],SALT37.Layout_FieldValueList);
  SELF.company_name_Values := IF ( (SALT37.StrType)le.company_name = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_name)}],SALT37.Layout_FieldValueList));
  SELF.company_name_prefix_Values := IF ( (SALT37.StrType)le.company_name_prefix = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_name_prefix)}],SALT37.Layout_FieldValueList));
  SELF.cnp_name_Values := IF ( (SALT37.StrType)le.cnp_name = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cnp_name)}],SALT37.Layout_FieldValueList));
  SELF.cnp_number_Values := IF ( (SALT37.StrType)le.cnp_number = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cnp_number)}],SALT37.Layout_FieldValueList));
  SELF.cnp_btype_Values := IF ( (SALT37.StrType)le.cnp_btype = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cnp_btype)}],SALT37.Layout_FieldValueList));
  SELF.cnp_lowv_Values := IF ( (SALT37.StrType)le.cnp_lowv = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.cnp_lowv)}],SALT37.Layout_FieldValueList));
  SELF.company_phone_Values := DATASET([{TRIM((SALT37.StrType)le.company_phone)}],SALT37.Layout_FieldValueList);
  SELF.company_phone_3_Values := IF ( (SALT37.StrType)le.company_phone_3 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_phone_3)}],SALT37.Layout_FieldValueList));
  SELF.company_phone_3_ex_Values := IF ( (SALT37.StrType)le.company_phone_3_ex = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_phone_3_ex)}],SALT37.Layout_FieldValueList));
  SELF.company_phone_7_Values := IF ( (SALT37.StrType)le.company_phone_7 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_phone_7)}],SALT37.Layout_FieldValueList));
  SELF.company_fein_Values := IF ( (SALT37.StrType)le.company_fein = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_fein)}],SALT37.Layout_FieldValueList));
  SELF.company_sic_code1_Values := IF ( (SALT37.StrType)le.company_sic_code1 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_sic_code1)}],SALT37.Layout_FieldValueList));
  SELF.active_duns_number_Values := DATASET([{TRIM((SALT37.StrType)le.active_duns_number)}],SALT37.Layout_FieldValueList);
  SELF.city_Values := IF ( (SALT37.StrType)le.city = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.city)}],SALT37.Layout_FieldValueList));
  SELF.city_clean_Values := IF ( (SALT37.StrType)le.city_clean = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.city_clean)}],SALT37.Layout_FieldValueList));
  SELF.st_Values := IF ( (SALT37.StrType)le.st = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.st)}],SALT37.Layout_FieldValueList));
  SELF.zip_Values := IF ( (SALT37.StrType)le.zip = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.zip)}],SALT37.Layout_FieldValueList));
  SELF.company_url_Values := IF ( (SALT37.StrType)le.company_url = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.company_url)}],SALT37.Layout_FieldValueList));
  SELF.isContact_Values := IF ( (SALT37.StrType)le.isContact = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.isContact)}],SALT37.Layout_FieldValueList));
  SELF.contact_did_Values := IF ( (SALT37.StrType)le.contact_did = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.contact_did)}],SALT37.Layout_FieldValueList));
  SELF.title_Values := IF ( (SALT37.StrType)le.title = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.title)}],SALT37.Layout_FieldValueList));
  SELF.fname_preferred_Values := IF ( (SALT37.StrType)le.fname_preferred = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.fname_preferred)}],SALT37.Layout_FieldValueList));
  SELF.name_suffix_Values := IF ( (SALT37.StrType)le.name_suffix = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.name_suffix)}],SALT37.Layout_FieldValueList));
  SELF.contact_ssn_Values := IF ( (SALT37.StrType)le.contact_ssn = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.contact_ssn)}],SALT37.Layout_FieldValueList));
  SELF.contact_email_Values := IF ( (SALT37.StrType)le.contact_email = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.contact_email)}],SALT37.Layout_FieldValueList));
  SELF.sele_flag_Values := IF ( (SALT37.StrType)le.sele_flag = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.sele_flag)}],SALT37.Layout_FieldValueList));
  SELF.org_flag_Values := IF ( (SALT37.StrType)le.org_flag = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.org_flag)}],SALT37.Layout_FieldValueList));
  SELF.ult_flag_Values := IF ( (SALT37.StrType)le.ult_flag = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.ult_flag)}],SALT37.Layout_FieldValueList));
  SELF.fallback_value_Values := IF ( (SALT37.StrType)le.fallback_value = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.fallback_value)}],SALT37.Layout_FieldValueList));
  SELF.CONTACTNAME_Values := IF ( (SALT37.StrType)le.fname = '' AND (SALT37.StrType)le.mname = '' AND (SALT37.StrType)le.lname = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.fname) + ' ' + TRIM((SALT37.StrType)le.mname) + ' ' + TRIM((SALT37.StrType)le.lname)}],SALT37.Layout_FieldValueList));
  SELF.STREETADDRESS_Values := IF ( (SALT37.StrType)le.prim_range = '' AND (SALT37.StrType)le.prim_name = '' AND (SALT37.StrType)le.sec_range = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.prim_range) + ' ' + TRIM((SALT37.StrType)le.prim_name) + ' ' + TRIM((SALT37.StrType)le.sec_range)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT));
  RETURN RollEntities(AsFieldValues);
END;
// Records which already had the ultid,orgid,seleid,proxid on them may not be up to date. Update those IDs
EXPORT UpdateIDs(DATASET(InputLayout) in) := FUNCTION
  id_stream_layout init(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := BizLinkFull.Config_BIP.MatchThreshold; // Assume at least 'threshold' met
    SELF.seleid := le.Entered_seleid;
    SELF.orgid := le.Entered_orgid;
    SELF.ultid := le.Entered_ultid;
    SELF.powid := le.Entered_powid;
    SELF.proxid := le.Entered_proxid;
    SELF.rcid := le.Entered_rcid;
  END;
  idupdate_candidates := PROJECT(in,init(LEFT));
  ids_updated0 := id_stream_historic(idupdate_candidates);
  ids_updated := PROJECT(ids_updated0,TRANSFORM(LayoutScoredFetch,SELF.Reference:=LEFT.UniqueId,SELF.keys_used:=0,SELF.keys_failed:=0,SELF:=LEFT));
  RETURN CombineLinkpathScores(ids_updated);
END;
// JA 20171114
EXPORT AdjustKeysUsedAndFailed(DATASET(LayoutScoredFetch) in_data) := FUNCTION
  LayoutScoredFetch AdjustFlags(LayoutScoredFetch le, UNSIGNED4 flagFail) := TRANSFORM // JA 20171114: UNSIGNED4 substituted for Config_BIP.KeysBitmapType 
    SELF.keys_used := le.keys_used | flagFail;
    SELF.keys_failed := le.keys_failed | flagFail;
    SELF := le;
  END;
  outR := {UNSIGNED4 keys_failed; };
  outR AggregateFlags(LayoutScoredFetch le, outR ri) := TRANSFORM
    SELF.keys_failed := ri.keys_failed | le.keys_failed;
  END;
  agg := AGGREGATE(in_data(proxid=0),outR,AggregateFlags(LEFT,RIGHT),FEW);
  flgFail := agg[1].keys_failed;
  RETURN IF(COUNT(in_data(proxid = 0)) > 0, IF(COUNT(in_data(proxid <> 0)) > 0, PROJECT(in_data(proxid <> 0), AdjustFlags(LEFT, flgFail)), PROJECT(in_data(proxid = 0)[1..1], AdjustFlags(LEFT, flgFail))), in_data);
  END;

// if at least one key failed and at least one not key failed row, remove keys failed rows and put keys failed into put into existing rows
// if you have only key failed rows - aggregate, and return one with all aggregated
END;
