EXPORT Externals := MODULE
  IMPORT SALT26,BizLinkFull;// Gather up the UID counts from each of the children - provides 'we also found' capability
  AllEfr0 := ;
// Need to compute the 'rolled up' counts for parents in hierarchy
  R1 := RECORD
    AllEFR0.Child_Id;
    Cnt := SUM(GROUP,AllEFR0.Cnt);
    SALT26.UIDType proxid := 0;
    AllEFR0.seleid;
    AllEFR0.orgid;
    AllEFR0.ultid;
  END;
  AllEFR1 := TABLE(AllEFR0,R1,seleid,orgid,ultid,Child_Id,MERGE);
  R2 := RECORD
    AllEFR1.Child_Id;
    Cnt := SUM(GROUP,AllEFR1.Cnt);
    SALT26.UIDType proxid := 0;
    SALT26.UIDType seleid := 0;
    AllEFR1.orgid;
    AllEFR1.ultid;
  END;
  AllEFR2 := TABLE(AllEFR1,R2,orgid,ultid,Child_Id,MERGE);
  R3 := RECORD
    AllEFR2.Child_Id;
    Cnt := SUM(GROUP,AllEFR2.Cnt);
    SALT26.UIDType proxid := 0;
    SALT26.UIDType seleid := 0;
    SALT26.UIDType orgid := 0;
    AllEFR2.ultid;
  END;
  AllEFR3 := TABLE(AllEFR2,R3,ultid,Child_Id,MERGE);
  AllEFR4 := AllEFR0 + PROJECT(AllEFR1,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR2,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR3,Ext_Layouts.EFRR_Layout);
  m := GROUP(AllEfr4(~(proxid = 0 AND seleid = 0 AND orgid = 0 AND ultid = 0)),ultid,orgid,seleid,proxid);
  r := ROLLUP(m,GROUP,TRANSFORM(Ext_Layouts.EFR_Layout,SELF.Hits := PROJECT(ROWS(LEFT),Ext_Layouts.EFR_Child),SELF := LEFT));
EXPORT EFR := INDEX(r,{ultid,orgid,seleid,proxid},{r},'~key::BizLinkFull::proxid::efr');
EXPORT BuildEFR := BUILDINDEX(EFR,OVERWRITE);
// Act as a central construction point for building ALL the external files.
// In reality - most of them will be individually built to different timescales
EXPORT BuildAll := SEQUENTIAL(PARALLEL(),BuildEFR);
// Construct a fetch interface for a 'comp report' of all the external files
EXPORT FetchParams := MODULE,VIRTUAL // Derive from here to change some of the default values
  EXPORT SET OF INTEGER2 ToFetch := []; // Remove elements to prevent externals being fetched
END;
EXPORT Layout := RECORD
  UNSIGNED4 Ref; // Will be the reference from the request
END;
EXPORT Fetch(DATASET(BizLinkFull.Process_Biz_Layouts.id_stream_layout) ins,FetchParams P=FetchParams) := FUNCTION
  Layout Get(DATASET(BizLinkFull.Process_Biz_Layouts.id_stream_layout) ids) := TRANSFORM
    SELF.Ref := ids[0].UniqueId;
  END;
  ig := GROUP(ins,UniqueId,ALL);
  RETURN ROLLUP(ig,GROUP,Get(ROWS(LEFT)));
END;
END;

