IMPORT SALT29,BIPV2_WAF;// Gather up the UID counts from each of the children - provides 'we also found' capability

EXPORT Key_BIPV2_WAF := Module

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
	
	EXPORT Key := INDEX(r,{ultid,orgid,seleid,proxid},{r},'~thor_data400::key::BIPV2_WAF::QA::proxid::efr');
 
	// Results will be aggregated by UniqueID from the idstream
	EXPORT FetchEFR(DATASET(process_Biz_layouts.id_stream_layout) idstream,UNSIGNED User_Permits) := FUNCTION
		Raw := JOIN(idstream,Key,(LEFT.ultid = RIGHT.ultid) AND (LEFT.orgid = 0 OR LEFT.orgid = RIGHT.orgid) AND (LEFT.seleid = 0 OR LEFT.seleid = RIGHT.seleid) AND (LEFT.proxid = 0 OR LEFT.proxid = RIGHT.proxid),keep(2500));
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

end;

