import BIPV2;

EXPORT Functions := MODULE

 /* Module used to zero out the linkids based on the passed level. Can be used to allow grouping,
	  sorting, rollup flexibilty based on the report level */
 EXPORT setLinkidFetchLev(inRecs,inLayout,inLevel) := FUNCTIONMACRO
		outrecs := PROJECT(inRecs,TRANSFORM(inLayout,
									self.ultID := left.ultid,
									self.ProxID := if(inLevel in bipv2.IDconstants.Set_Fetch_Level_ProxID_And_Down, left.ProxID, 0),
									self.SELEID := if(inLevel in bipv2.IDconstants.Set_Fetch_Level_SELEID_And_Down, left.SELEID, 0),
									self.OrgID :=  if(inLevel in bipv2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  left.OrgID, 0),
									self.EmpID := 0,
									self.POWID := 0,		
									self := left));
		return(outrecs);
 ENDMACRO;
 
END;
