EXPORT Externals := MODULE
  IMPORT SALT29,BIPV2_WAF;// Gather up the UID counts from each of the children - provides 'we also found' capability
SHARED AllEfr0 := Mod_Corps().EFR+Mod_UCC().EFR+Mod_Vehicle().EFR+Mod_PropertyV2().EFR+Mod_BizContacts().EFR;
// Need to compute the 'rolled up' counts for parents in hierarchy
  R1 := RECORD
    AllEFR0.Child_Id;
    Cnt := SUM(GROUP,AllEFR0.Cnt);
    SALT29.UIDType proxid := 0;
    AllEFR0.seleid;
    AllEFR0.orgid;
    AllEFR0.ultid;
  END;
  AllEFR1 := TABLE(AllEFR0,R1,seleid,orgid,ultid,Child_Id,MERGE);
  R2 := RECORD
    AllEFR1.Child_Id;
    Cnt := SUM(GROUP,AllEFR1.Cnt);
    SALT29.UIDType proxid := 0;
    SALT29.UIDType seleid := 0;
    AllEFR1.orgid;
    AllEFR1.ultid;
  END;
  AllEFR2 := TABLE(AllEFR1,R2,orgid,ultid,Child_Id,MERGE);
  R3 := RECORD
    AllEFR2.Child_Id;
    Cnt := SUM(GROUP,AllEFR2.Cnt);
    SALT29.UIDType proxid := 0;
    SALT29.UIDType seleid := 0;
    SALT29.UIDType orgid := 0;
    AllEFR2.ultid;
  END;
  AllEFR3 := TABLE(AllEFR2,R3,ultid,Child_Id,MERGE);
  AllEFR4 := AllEFR0 + PROJECT(AllEFR1,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR2,Ext_Layouts.EFRR_Layout) + PROJECT(AllEFR3,Ext_Layouts.EFRR_Layout);
  m := GROUP(AllEfr4(~(proxid = 0 AND seleid = 0 AND orgid = 0 AND ultid = 0)),ultid,orgid,seleid,proxid,ALL);
  r := ROLLUP(m,GROUP,TRANSFORM(Ext_Layouts.EFR_Layout,SELF.Hits := PROJECT(ROWS(LEFT),Ext_Layouts.EFR_Child),SELF := LEFT));
EXPORT EFR := INDEX(r,{ultid,orgid,seleid,proxid},{r},'~thor_data400::key::BIPV2_WAF::QA::proxid::efr');
// Results will be aggregated by UniqueID from the idstream
EXPORT FetchEFR(DATASET(process_Biz_layouts.id_stream_layout) idstream,UNSIGNED User_Permits) := FUNCTION
  Raw := JOIN(idstream,efr,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),keep(2500));
  R := RECORD
    UNSIGNED4 UniqueID;
    UNSIGNED2 Child_Id;
    UNSIGNED4 Cnt;
    UNSIGNED2 Permits;
  END;
	//*** Jira DF-27682, Modified code as suggested in the ticket.
	//*** A change was made to bip2.mod_sources.in_mod_values.my_bmap to remove the +  [code.MARKETING_UNRESTRICTED]
	//*** Thus as a result, changed the below code to ensure results are same. Changed the bip map value from 1022 to 510 below (i.e 1022-512).
  N := NORMALIZE(Raw,COUNT(LEFT.Hits),TRANSFORM(R,SELF.UniqueID := LEFT.UniqueID, SELF := LEFT.Hits[COUNTER]))(((User_Permits|(~Permits))&510 = 510) and permits <> 0);
  RETURN TABLE(N,{ UniqueID, Child_Id, UNSIGNED Cnt := SUM(GROUP,Cnt)},UniqueId,Child_Id,FEW);
END;
EXPORT BuildEFR := BUILDINDEX(EFR,OVERWRITE);
 
EXPORT EFRStats := TABLE(AllEfr0,{ Child_ID,Permits,proxidCnt := COUNT(GROUP)}, Child_ID,Permits,FEW);
// Act as a central construction point for building ALL the external files.
// In reality - most of them will be individually built to different timescales
EXPORT BuildAll := SEQUENTIAL(PARALLEL(Mod_Corps().BuildAll,Mod_UCC().BuildAll,Mod_Vehicle().BuildAll,Mod_PropertyV2().BuildAll,Mod_BizContacts().BuildAll),BuildEFR);
 
// Construct a fetch interface for a 'comp report' of all the external files
EXPORT FetchParams := MODULE,VIRTUAL // Derive from here to change some of the default values
  EXPORT SET OF INTEGER2 ToFetch := [Ext_Layouts.ID_Corps,Ext_Layouts.ID_UCC,Ext_Layouts.ID_Vehicle,Ext_Layouts.ID_PropertyV2,Ext_Layouts.ID_BizContacts]; // Remove elements to prevent externals being fetched
  EXPORT MaxCorps := 0; //Default of 0 fetches all
  EXPORT MaxUCC := 0; //Default of 0 fetches all
  EXPORT MaxVehicle := 0; //Default of 0 fetches all
  EXPORT MaxPropertyV2 := 0; //Default of 0 fetches all
  EXPORT MaxBizContacts := 0; //Default of 0 fetches all
END;
EXPORT Layout := RECORD
  UNSIGNED4 Ref; // Will be the reference from the request
  DATASET(Mod_Corps().FetchLayout) Corps;
  DATASET(Mod_UCC().FetchLayout) UCC;
  DATASET(Mod_Vehicle().FetchLayout) Vehicle;
  DATASET(Mod_PropertyV2().FetchLayout) PropertyV2;
  DATASET(Mod_BizContacts().FetchLayout) BizContacts;
END;
EXPORT Fetch(DATASET(BIPV2_WAF.Process_Biz_Layouts.id_stream_layout) ins,FetchParams P=FetchParams) := FUNCTION
  Layout Get(DATASET(BIPV2_WAF.Process_Biz_Layouts.id_stream_layout) ids) := TRANSFORM
    SELF.Ref := ids[0].UniqueId;
    SELF.Corps := IF ( Ext_Layouts.ID_Corps IN p.ToFetch, Mod_Corps().Fetch_(ids,p.MaxCorps),DATASET([],Mod_Corps().FetchLayout));
    SELF.UCC := IF ( Ext_Layouts.ID_UCC IN p.ToFetch, Mod_UCC().Fetch_(ids,p.MaxUCC),DATASET([],Mod_UCC().FetchLayout));
    SELF.Vehicle := IF ( Ext_Layouts.ID_Vehicle IN p.ToFetch, Mod_Vehicle().Fetch_(ids,p.MaxVehicle),DATASET([],Mod_Vehicle().FetchLayout));
    SELF.PropertyV2 := IF ( Ext_Layouts.ID_PropertyV2 IN p.ToFetch, Mod_PropertyV2().Fetch_(ids,p.MaxPropertyV2),DATASET([],Mod_PropertyV2().FetchLayout));
    SELF.BizContacts := IF ( Ext_Layouts.ID_BizContacts IN p.ToFetch, Mod_BizContacts().Fetch_(ids,p.MaxBizContacts),DATASET([],Mod_BizContacts().FetchLayout));
  END;
  ig := GROUP(ins,UniqueId,ALL);
  RETURN ROLLUP(ig,GROUP,Get(ROWS(LEFT)));
END;
END;
