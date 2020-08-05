IMPORT AutoKeyI, AutoHeaderI, BatchShare, suppress,FCRA, BIPV2;
EXPORT Interfaces := MODULE
  
  SHARED common_params := INTERFACE
    EXPORT STRING32 seqk := '';
    EXPORT STRING30 wk := '';
    EXPORT STRING30 hull_num := '';
    EXPORT STRING50 vesl_nam := '';
    EXPORT STRING6 ssn_mask := 'NONE';
    EXPORT UNSIGNED2 pt := 10;
    EXPORT STRING10 off_num := '';
    EXPORT INTEGER1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
    EXPORT BOOLEAN include_non_regulated_sources := FALSE;
  END;
    
  EXPORT ak_params := INTERFACE(
    AutoKeyI.AutoKeyStandardFetchBaseInterface,
    AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
    AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
    EXPORT BOOLEAN nodeepdive := FALSE;
  END;
  
  EXPORT search_params := INTERFACE(common_params, ak_params,FCRA.iRules)
    EXPORT UNSIGNED2 min_vesl_len := 0;
    EXPORT UNSIGNED2 max_vesl_len := 0;
  END;
    
  EXPORT report_params := INTERFACE(common_params, ak_params,FCRA.iRules)
    EXPORT BOOLEAN summarize := FALSE;
  END;
  
  EXPORT batch_params := INTERFACE(BatchShare.IParam.BatchParams,FCRA.iRules)
    EXPORT INTEGER1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
    EXPORT BOOLEAN include_non_regulated_sources := FALSE;
    EXPORT STRING1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
  END;
  
END;
