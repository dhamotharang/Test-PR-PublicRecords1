EXPORT Externals := MODULE
  IMPORT SALT44,BizLinkFull;// Gather up the UID counts from each of the children - provides 'we also found' capability
SHARED AllEfr0 := Mod_Ext_Data().EFR;
 
EXPORT EFRKeyName := '~'+'key::BizLinkFull::proxid::EFR';
 
// Need to compute the 'rolled up' counts for parents in hierarchy
  R1 := RECORD
    AllEFR0.Child_Id;
    AllEFR0.ChildId_BMap;
    Cnt := SUM(GROUP,AllEFR0.Cnt);
    SALT44.UIDType proxid := 0;
    AllEFR0.seleid;
    AllEFR0.orgid;
    AllEFR0.ultid;
  END;
  AllEFR1 := TABLE(AllEFR0,R1,seleid,orgid,ultid,Child_Id,ChildId_BMap,MERGE);
  R2 := RECORD
    AllEFR1.Child_Id;
    AllEFR1.ChildId_BMap;
    Cnt := SUM(GROUP,AllEFR1.Cnt);
    SALT44.UIDType proxid := 0;
    SALT44.UIDType seleid := 0;
    AllEFR1.orgid;
    AllEFR1.ultid;
  END;
  AllEFR2 := TABLE(AllEFR1,R2,orgid,ultid,Child_Id,ChildId_BMap,MERGE);
  R3 := RECORD
    AllEFR2.Child_Id;
    AllEFR2.ChildId_BMap;
    Cnt := SUM(GROUP,AllEFR2.Cnt);
    SALT44.UIDType proxid := 0;
    SALT44.UIDType seleid := 0;
    SALT44.UIDType orgid := 0;
    AllEFR2.ultid;
  END;
  AllEFR3 := TABLE(AllEFR2,R3,ultid,Child_Id,ChildId_BMap,MERGE);
  AllEFR4 := AllEFR0 + PROJECT(AllEFR1,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR2,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR3,Ext_Layouts.EFRR_Layout);
 
  m := GROUP(AllEfr4(~(proxid = 0 AND seleid = 0 AND orgid = 0 AND ultid = 0)),ultid,orgid,seleid,proxid,ALL);
  r := ROLLUP(m,GROUP,TRANSFORM(Ext_Layouts.EFR_Layout,
        SELF.ChildID_BMap := ROLLUP(ROWS(LEFT),TRANSFORM(Ext_Layouts.EFRR_Layout,SELF.ChildId_BMap := LEFT.ChildID_BMap | RIGHT.ChildId_BMap,SELF := RIGHT),ultid,orgid,seleid,proxid)[1].ChildId_BMap,
        SELF.Hits := PROJECT(ROWS(LEFT),Ext_Layouts.EFR_Child),SELF := LEFT));
 
EXPORT EFR := INDEX(r,{ultid,orgid,seleid,proxid},{r},EFRKeyName,OPT);
// Results will be aggregated by UniqueID from the idstream
EXPORT FetchEFR(DATASET(Process_Biz_Layouts.id_stream_layout) idstream) := FUNCTION
  Raw := JOIN(idstream,efr,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),LEFT OUTER);
  R := RECORD
    SALT44.UIDType UniqueID;
    UNSIGNED2 Child_Id;
    UNSIGNED4 Cnt;
  END;
  N := NORMALIZE(Raw,COUNT(LEFT.Hits),TRANSFORM(R,SELF.UniqueID := LEFT.UniqueID, SELF := LEFT.Hits[COUNTER]));
  RETURN TABLE(N,{ UniqueID, Child_Id, UNSIGNED Cnt := SUM(GROUP,Cnt)},UniqueId,Child_Id,FEW);
END;
EXPORT BuildEFR := BUILDINDEX(EFR, OVERWRITE);
 
EXPORT EFRStats := TABLE(AllEfr0,{ Child_ID,proxidCnt := COUNT(GROUP)}, Child_ID,FEW);
// Act as a central construction point for building ALL the external files.
// In reality - most of them will be individually built to different timescales
EXPORT BuildAll := SEQUENTIAL(PARALLEL(Mod_Ext_Data().BuildAll),BuildEFR);
 
// Construct a fetch interface for a 'comp report' of all the external files
EXPORT FetchParams := MODULE,VIRTUAL // Derive from here to change some of the default values
  EXPORT SET OF INTEGER2 ToFetch := [Ext_Layouts.ID_Ext_Data]; // Remove elements to prevent externals being fetched
  EXPORT MaxExt_Data := Config_BIP.MaxExt_Data; //Default of 0 fetches all
END;
EXPORT Layout := RECORD
  UNSIGNED4 Ref; // Will be the reference from the request
  DATASET(Mod_Ext_Data().FetchLayout) Ext_Data;
END;
EXPORT Fetch(DATASET(BizLinkFull.Process_Biz_Layouts.id_stream_layout) ins,FetchParams P=FetchParams) := FUNCTION
  Layout Get(DATASET(BizLinkFull.Process_Biz_Layouts.id_stream_layout) ids) := TRANSFORM
    SELF.Ref := ids[0].UniqueId;
    SELF.Ext_Data := IF ( Ext_Layouts.ID_Ext_Data IN p.ToFetch, Mod_Ext_Data().Fetch_(ids,p.MaxExt_Data),DATASET([],Mod_Ext_Data().FetchLayout));
  END;
  ig := GROUP(ins,UniqueId,ALL);
  RETURN ROLLUP(ig,GROUP,Get(ROWS(LEFT)));
END;
END;
