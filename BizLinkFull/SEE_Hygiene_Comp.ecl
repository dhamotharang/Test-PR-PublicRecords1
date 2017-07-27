// Modified on 01 Mar 2016 17:29:46 GMT by HIPIE on machine BCTLW7WHEELODX
  IMPORT BizLinkFull as HIPIE;
  EXPORT SEE_Hygiene_Comp := MODULE
  EXPORT SEE_Hygiene_Comp_Ins001_DDL := '[{"visualizations":[{"id":"Chart1","source":{"output":"View_Chart1","mappings":{"weight":"cnt_SUM","label":"source"},"id":"Ins001_Validity_Errors"},"type":"BAR","fields":[{"id":"source"},{"id":"cnt_SUM"}],"properties":{"chartType":"BAR"},"events":{"click":{"mappings":{"source":"source"},"updates":[{"visualization":"Chart2","instance":"Ins001","datasource":"Ins001_Validity_Errors","merge":false},{"visualization":"Chart3","instance":"Ins001","datasource":"Ins001_Validity_Errors","merge":false}]}}},{"id":"Chart2","source":{"output":"View_Chart2","mappings":{"weight":"cnt_SUM","label":"fieldnme"},"id":"Ins001_Validity_Errors"},"type":"PIE","fields":[{"id":"fieldnme"},{"id":"source"},{"id":"cnt_SUM"}],"properties":{"chartType":"PIE"}},{"id":"Chart3","source":{"output":"View_Chart3","mappings":{"weight":"cnt_SUM","label":"errormessage"},"id":"Ins001_Validity_Errors"},"type":"PIE","fields":[{"id":"errormessage"},{"id":"source"},{"id":"cnt_SUM"}],"properties":{"chartType":"BUBBLE"}}],"datasources":[{"filter":["source"],"outputs":[{"from":"Ins001_Validity_Errors_View_Chart1","id":"View_Chart1","notify":["Chart1"]},{"filter":["source"],"from":"Ins001_Validity_Errors_View_Chart2","id":"View_Chart2","notify":["Chart2"]},{"filter":["source"],"from":"Ins001_Validity_Errors_View_Chart3","id":"View_Chart3","notify":["Chart3"]}],"WUID":true,"id":"Ins001_Validity_Errors"}],"id":"Ins001_Errors","label":"Errors","title":"Errors"}]';
 
// Generate code for datasource Ins001_Validity_Errors
  EXPORT Build_Ins001_Validity_Errors := MODULE
    SHARED Base1 := DATASET(WORKUNIT('ValidityErrors'),{ STRING2 source, STRING fieldnme, STRING7 fieldtype, STRING errormessage, UNSIGNED8 cnt, INTEGER8 numberofrecords});
    // Will be used by View_Chart1
    Base:=Base1;
      In := TABLE(Base,{source,REAL cnt_SUM := SUM(GROUP,cnt)},source,MERGE);
    EXPORT View_Chart1 := OUTPUT( in, NAMED('Ins001_Validity_Errors_View_Chart1'),ALL);
    // Will be used by View_Chart2
    Base:=Base1;
      In := TABLE(Base,{source,fieldnme,REAL cnt_SUM := SUM(GROUP,cnt)},source,fieldnme,MERGE);
    EXPORT View_Chart2 := OUTPUT( in, NAMED('Ins001_Validity_Errors_View_Chart2'),ALL);
    // Will be used by View_Chart3
    Base:=Base1;
      In := TABLE(Base,{source,errormessage,REAL cnt_SUM := SUM(GROUP,cnt)},source,errormessage,MERGE);
    EXPORT View_Chart3 := OUTPUT( in, NAMED('Ins001_Validity_Errors_View_Chart3'),ALL);
    EXPORT BuildAll := PARALLEL(View_Chart1,View_Chart2,View_Chart3);
  END;
END;
 
 
