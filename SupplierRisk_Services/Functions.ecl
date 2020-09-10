IMPORT BIPV2;

EXPORT Functions := MODULE

 /* Module used to zero out the linkids based on the passed level. Can be used to allow grouping,
    sorting, rollup flexibilty based on the report level */
 EXPORT setLinkidFetchLev(inRecs,inLayout,inLevel) := FUNCTIONMACRO
    outrecs := PROJECT(inRecs,TRANSFORM(inLayout,
      SELF.ultID := LEFT.ultid,
      SELF.ProxID := IF(inLevel in bipv2.IDconstants.Set_Fetch_Level_ProxID_And_Down, LEFT.ProxID, 0),
      SELF.SELEID := IF(inLevel in bipv2.IDconstants.Set_Fetch_Level_SELEID_And_Down, LEFT.SELEID, 0),
      SELF.OrgID := IF(inLevel in bipv2.IDconstants.Set_Fetch_Level_OrgID_And_Down, LEFT.OrgID, 0),
      SELF.EmpID := 0,
      SELF.POWID := 0,
      SELF := LEFT));
    RETURN outrecs;
 ENDMACRO;
 
END;
