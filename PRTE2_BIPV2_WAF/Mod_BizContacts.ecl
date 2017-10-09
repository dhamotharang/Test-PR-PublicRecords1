IMPORT SALT38,PRTE2_BIPV2_WAF;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result
 
EXPORT Mod_BizContacts(BOOLEAN MultiRec = FALSE,SET OF SALT38.UIDType ButNot=[], DATASET(RECORDOF(File_BizHead_Contacts))  inefile = File_BizHead_Contacts) := MODULE
  R := RECORD
    inefile;
    SALT38.UIDType UniqueId;
    UNSIGNED2 proxid_Score := 0;
    UNSIGNED2 proxid_Weight := 0;
  END;
SHARED  input := PROJECT(inefile,TRANSFORM(R,SELF := LEFT,SELF.UniqueId:=COUNTER)); // UniqueID is required
 
SHARED s := CHOOSEN(Keys(File_BizHead).Specificities_Key,1)[1];
  Mapping0 := 'cnp_name:company_name,prim_range:prim_range,prim_name:prim_name,sec_range:sec_range,p_city_name:p_city_name,st:st,zip_cases:zip,company_phone:company_phone,company_fein:company_fein'; // Tweaks for non-standard field names
  UniChange0 := input;
  Mapped0 := SALT38.FromFlat(UniChange0,Process_Biz_Layouts.InputLayout,Mapping0); // Copy out the linkable indicative
 
// Create the mappings and links for data in the main external file
  Process_Biz_layouts.InputLayout tr(Process_Biz_layouts.InputLayout le) := TRANSFORM,SKIP(~Process_Biz_Layouts.HardKeyMatch(le))
    SELF := le;
  END;
EXPORT Mapped := PROJECT(Mapped0,tr(LEFT)) : PERSIST('~temp::proxid::PRTE2_BIPV2_WAF::Mapped::UID::BizContacts',EXPIRE(PRTE2_BIPV2_WAF.Config.PersistExpire));
  PRTE2_BIPV2_WAF.MAC_PopulationStatistics(Mapped,UniqueId,,parent_proxid,ultimate_proxid,has_lgid,empid,powid,source,source_record_id,cnp_number,cnp_btype,cnp_lowv,cnp_name,company_phone,company_fein,company_sic_code1,prim_range,prim_name,sec_range,p_city_name,st,zip_cases,company_url,isContact,title,fname,mname,lname,name_suffix,contact_email,CONTACTNAME,STREETADDRESS,ml);
EXPORT MappedStats := ml;
EXPORT WithUID := input(ultid>0); // Only take those that have values
 
// Now we need to construct a payload key for the primary file
// We need this payload key to be indexed by proxid
  RLayout := RECORD
  SALT38.UIDType Fetch_proxid;
  SALT38.UIDType Fetch_seleid;
  SALT38.UIDType Fetch_orgid;
  SALT38.UIDType Fetch_ultid;
  SALT38.UIDType Fetch_rcid;
    WithUID;
  END;
  SHARED T := PROJECT(WithUID,TRANSFORM(RLayout,SELF.Fetch_proxid := LEFT.proxid,SELF.Fetch_seleid := LEFT.seleid,SELF.Fetch_orgid := LEFT.orgid,SELF.Fetch_ultid := LEFT.ultid,SELF.Fetch_rcid := LEFT.UniqueId, SELF := LEFT)); // Copy the fetches out
 
EXPORT PayloadByproxidName := '~'+'key::PRTE2_BIPV2_WAF::proxid::BizContactsbyproxid::Payload';
 
EXPORT PayloadByproxid := INDEX(T,{Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,Fetch_rcid},{T},PayloadByproxidName);
 
EXPORT BuildAll := BUILDINDEX(PayloadByproxid, OVERWRITE);
 
//Having built all the data - we need to be able to fetch it all too!
EXPORT FetchLayout := RECORD
  UNSIGNED4 Ref; // Will store UniqueID of QUERY
  UNSIGNED2 Weight;
  UNSIGNED4 KeysUsed;
  UNSIGNED4 KeysFailed;
  BOOLEAN Is_Permitted := FALSE; // to be updated later on
  WithUID;
END;
EXPORT Fetch_(DATASET(PRTE2_BIPV2_WAF.Process_Biz_Layouts.id_stream_layout) ins,INTEGER MaxRecs=0) := FUNCTION
  RData := JOIN(ins,PayloadByproxid,(LEFT.ultid = RIGHT.Fetch_ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.Fetch_orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.Fetch_seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.Fetch_proxid),TRANSFORM(FetchLayout,SELF.Ref := LEFT.UniqueId, SELF.Weight := LEFT.Weight, SELF.KeysUsed := LEFT.KeysUsed, SELF.KeysFailed := LEFT.KeysFailed, SELF := RIGHT),LEFT OUTER,LIMIT(Config.JoinLimit));
  RLimit := IF ( MaxRecs>0, DEDUP( SORT( RData, Ref, -UniqueID ), Ref, KEEP(MaxRecs) ), RData );
  RETURN RLimit;
END;
//Provide a record of those proxid in the payload keys
  // If you get a syntax error on the line below; it is probably because you did NOT provide a good mapping for your source field
// and did not provide a constant for your permissions for this external file
  permits := TABLE(PayloadByproxid,{PayloadByproxid,UNSIGNED2 Permits := fn_sources(source)}); // Compute the permits of each record
  cnts := TABLE(permits,{Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,Permits,Cnt := COUNT(GROUP)},Fetch_ultid,Fetch_orgid,Fetch_seleid,Fetch_proxid,Permits,MERGE); // ,MERGE should not be needed 
//EXPORT EFR := PROJECT(cnts,TRANSFORM(Ext_Layouts.EFRR_Layout,SELF.Child_Id := Ext_Layouts.ID_BizContacts,SELF.ChildId_BMap := 1<<(Ext_Layouts.ID_BizContacts-1),SELF.proxid := LEFT.Fetch_proxid,SELF.seleid := LEFT.Fetch_seleid,SELF.orgid := LEFT.Fetch_orgid,SELF.ultid := LEFT.Fetch_ultid,SELF := LEFT));
EXPORT EFR := PROJECT(cnts,TRANSFORM(Ext_Layouts.EFRR_Layout,SELF.Child_Id := Ext_Layouts.ID_BizContacts,SELF.proxid := LEFT.Fetch_proxid,SELF.seleid := LEFT.Fetch_seleid,SELF.orgid := LEFT.Fetch_orgid,SELF.ultid := LEFT.Fetch_ultid,SELF := LEFT));
END;
