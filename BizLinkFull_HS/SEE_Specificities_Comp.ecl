// Modified on 01 Mar 2016 17:29:43 GMT by HIPIE on machine BCTLW7WHEELODX
  IMPORT BizLinkFull_HS as HIPIE;
  EXPORT SEE_Specificities_Comp := MODULE
  // Code for SEE_Specificities(Ins001)
  IMPORT SALT33,BizLinkFull_HS;
  outLayout:={STRING label,REAL4 specificity,REAL4 switch,REAL4 maximum};
    Spec := BizLinkFull_HS.specificities(BizLinkFull_HS.In_BizHead).Specificities;
    
EXPORT Ins001_PivotedSpecificities := SALT33.MAC_Pivot(Spec,outLayout);
  
EXPORT Ins001_vSpecificities := NORMALIZE(Ins001_PivotedSpecificities,3,TRANSFORM({INTEGER stattype, STRING field_name, REAL4 value},SELF.field_name:=LEFT.label,SELF.stattype:=COUNTER,SELF.value:=CHOOSE(COUNTER,LEFT.specificity,LEFT.switch,LEFT.maximum)));
  
EXPORT Ins001_StatsType := DATASET([{1, 'specificity'},{2, 'switch'},{3, 'maximum'}], {INTEGER stattype, STRING Description});
  
EXPORT Ins001_vDetail := TABLE(Ins001_vSpecificities,{stattype,REAL maximum:=MAX(GROUP,value),REAL minimum:=MIN(GROUP,value),REAL average:=AVE(GROUP,value)},stattype);
 
  EXPORT SEE_Specificities_Comp_Ins001_DDL := '[{"visualizations":[{"id":"PickStatsTypes","source":{"output":"View_PickStatsTypes","mappings":{"value":["stattype","description"]},"id":"Ins001_StatsType"},"label":["StatType","Description"],"type":"TABLE","fields":[{"id":"stattype","properties":{"label":"StatType"}},{"id":"description","properties":{"label":"Description"}}],"events":{"click":{"mappings":{"stattype":"stattype"},"updates":[{"visualization":"Stats","instance":"Ins001","datasource":"Ins001_vSpecificities","merge":false},{"visualization":"Detail","instance":"Ins001","datasource":"Ins001_vDetail","merge":false}]}}},{"id":"Stats","source":{"output":"View_Stats","mappings":{"weight":"value","label":"field_name"},"id":"Ins001_vSpecificities"},"type":"BAR","fields":[{"id":"stattype"},{"id":"field_name"},{"id":"value"}]},{"id":"Detail","source":{"output":"View_Detail","mappings":{"value":["maximum","minimum","average"]},"id":"Ins001_vDetail"},"label":["MAX","MIN","AVG"],"type":"TABLE","fields":[{"id":"maximum","properties":{"label":"MAX"}},{"id":"minimum","properties":{"label":"MIN"}},{"id":"average","properties":{"label":"AVG"}}]}],"datasources":[{"filter":["stattype"],"outputs":[{"filter":["stattype"],"from":"Ins001_vDetail_View_Detail","id":"View_Detail","notify":["Detail"]}],"WUID":true,"id":"Ins001_vDetail"},{"outputs":[{"from":"Ins001_StatsType_View_PickStatsTypes","id":"View_PickStatsTypes","notify":["PickStatsTypes"]}],"WUID":true,"id":"Ins001_StatsType"},{"filter":["stattype"],"outputs":[{"filter":["stattype"],"from":"Ins001_vSpecificities_View_Stats","id":"View_Stats","notify":["Stats"]}],"WUID":true,"id":"Ins001_vSpecificities"}],"id":"Ins001_BWR_Specificities","label":"BWR_Specificities","title":"BWR_Specificities"}]';
 
// Generate code for datasource Ins001_vSpecificities
  EXPORT Build_Ins001_vSpecificities := MODULE
    SHARED Base1 := Ins001_vSpecificities;
    // Will be used by View_Stats
    Base:=Base1;
      In := TABLE(Base,{stattype,field_name,value});
    EXPORT View_Stats := OUTPUT( in, NAMED('Ins001_vSpecificities_View_Stats'),ALL);
    EXPORT BuildAll := PARALLEL(View_Stats);
  END;
// Generate code for datasource Ins001_StatsType
  EXPORT Build_Ins001_StatsType := MODULE
    SHARED Base1 := Ins001_StatsType;
    // Will be used by View_PickStatsTypes
    Base:=Base1;
      In := TABLE(Base,{stattype,description});
    EXPORT View_PickStatsTypes := OUTPUT( in, NAMED('Ins001_StatsType_View_PickStatsTypes'),ALL);
    EXPORT BuildAll := PARALLEL(View_PickStatsTypes);
  END;
// Generate code for datasource Ins001_vDetail
  EXPORT Build_Ins001_vDetail := MODULE
    SHARED Base1 := Ins001_vDetail;
    // Will be used by View_Detail
    Base:=Base1;
      In := TABLE(Base,{stattype,maximum,minimum,average});
    EXPORT View_Detail := OUTPUT( in, NAMED('Ins001_vDetail_View_Detail'),ALL);
    EXPORT BuildAll := PARALLEL(View_Detail);
  END;
END;
 
 
 
