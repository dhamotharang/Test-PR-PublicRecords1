Import BIPV2;

EXPORT modLayouts := MODULE
  //Change Field names to match your data. -ZRS 4/8/2019    
	
EXPORT lSrcLayout := RECORD
	//Common Layout
    UNSIGNED8 RID;
	STRING SRC_CATEGORY;
	//Header Specific Data
	UNSIGNED4 dt_last_seen;
	STRING company_name,
	STRING prim_range,
	STRING prim_name,
	STRING sec_range,
	STRING city,
	STRING state,
	STRING zip5,
	UNSIGNED zip_radius_miles := 0;
	STRING phone10,
	STRING fein,
	STRING url,
	STRING email,
	STRING contact_fname,
	STRING contact_mname,
	STRING contact_lname,
	STRING contact_ssn,
	UNSIGNED contact_did,
	STRING sic_code,
	UNSIGNED source_record_id,
	UNSIGNED proxid,
	UNSIGNED seleid
 END;
  
   
ambiguous := RECORD
    UNSIGNED6 reference;
    UNSIGNED6 proxid;
    INTEGER8 score;
  END;
	
EXPORT lSampleLayout := RECORD
	//Common layout
    UNSIGNED8 UniqueID;
    UNSIGNED8 RID;   					//added from input record
	STRING15  SRC_CATEGORY;  	//added from input record
    UNSIGNED8 TIMESTAMP; 
    UNSIGNED2 MODE;  					//added from profile
    UNSIGNED2 COMPAREMODE;  	//added from profile
	STRING    PROFILE_BUCKET; //added from profile
    STRING120 DESCRIPTION;		//added from profile
	STRING errorcode := '';
    INTEGER transaction_time{xpath('_call_latency_ms')} := 0;
	//Header specific data
	UNSIGNED4 dt_last_seen;
    STRING company_name,
	STRING prim_range,
	STRING prim_name,
	STRING sec_range,
	STRING city,
	STRING state,
	STRING zip5,
	UNSIGNED zip_radius_miles := 0;
	STRING phone10,
	STRING fein,
	STRING url,
	STRING email,
	STRING contact_fname,
	STRING contact_mname,
	STRING contact_lname,
	STRING contact_ssn,
	UNSIGNED contact_did,
	STRING sic_code,
	STRING source,
	UNSIGNED source_record_id,
	BIPV2.IdAppendLayouts.IdsOnlyOutput -error_code;
    UNSIGNED input_seleid := 0,
    UNSIGNED input_proxid := 0
  END;
	
EXPORT lSampleLayoutExp := RECORD
	recordof(lSampleLayout);
	UNSIGNED2 macroCallOrig := 0;
    UNSIGNED2 macroCallNew := 0;
    SET OF STRING ssFilter := [];
    unsigned filt_num := 0;
  END;
	
EXPORT profileRec := RECORD
    STRING srcCategory;
    SET OF STRING srcFilters;
    UNSIGNED2 weight := 0;
    UNSIGNED2 distance := 0;
    UNSIGNED2 score := 0;
    UNSIGNED2 macroCallOrig := 0;
    UNSIGNED2 macroCallNew := 0;
    STRING120 description := '';
    SET OF STRING ssFilter := [];
  END;
  
	
EXPORT profileQARec := RECORD
    STRING srcCategory;
	STRING srcFilter;
	UNSIGNED2 weight := 0;
	UNSIGNED2 distance := 0;
	UNSIGNED2 score := 0;
	UNSIGNED2 macroCall := 0;
  END;
	
EXPORT lHyperlinkProfile := RECORD
    STRING sIPAddress;
    STRING sClusterName;
    STRING sServiceName;
    STRING sRun;
    STRING sType;
  END;
  
  //These next couple of layouts are for individual headers, change to what you need. -ZRS 4/8/2019    
 
EXPORT lStatsRec := RECORD
    UNSIGNED iTimestamp;
    STRING sSource;
    UNSIGNED iMode;
    UNSIGNED iCompareMode;    
    STRING120 sDescription;
    STRING   sProfileBucket;
    UNSIGNED iTotalCnt;
    UNSIGNED iProdHits;
    REAL nProdHits;
    UNSIGNED iBaselineHits;
    REAL nBaselineHits;
    UNSIGNED iNewHits;
    REAL nNewHits;
    UNSIGNED iAllEqual;
    REAL nAllEqual;
    UNSIGNED iNoneEqual;
    REAL nNoneEqual;
    UNSIGNED iEqualNonZero;
    REAL nEqualNonZero;
    UNSIGNED iDiffNonZero;
    REAL nDiffNonZero;
    UNSIGNED iToZero;
    REAL nToZero;
    UNSIGNED iFromZero;
    REAL nFromZero;
    UNSIGNED iHeaderOrigAccuracy;
    REAL nHeaderOrigAccuracy;
    UNSIGNED iHeaderOrigDiff;
    REAL nHeaderOrigDiff;
    UNSIGNED iHeaderNewAccuracy;
    REAL nHeaderNewAccuracy;
    UNSIGNED iHeaderNewDiff;
    REAL nHeaderNewDiff;
    REAL nBaselineLatency;
    REAL nNewLatency;
    UNSIGNED iErrorsOrig;
    REAL nErrorsOrig;
    UNSIGNED iErrorsNew;
    REAL nErrorsNew;
  END;
  
EXPORT lReadableStatsHorizRec := RECORD
    STRING iMode;
    STRING iCompareMode;  
	STRING sProfileBucket;
    STRING sDescription;
    STRING iTotalCnt;
    STRING iProdHits;
    STRING nProdHits;
    STRING iBaselineHits;
    STRING nBaselineHits;
    STRING iNewHits;
    STRING nNewHits;
    STRING iAllEqual;
    STRING nAllEqual;
    STRING iNoneEqual;
    STRING nNoneEqual;
    STRING iEqualNonZero;
    STRING nEqualNonZero;
    STRING iDiffNonZero;
    STRING nDiffNonZero;
    STRING iToZero;
    STRING nToZero;
    STRING iFromZero;
    STRING nFromZero;
    STRING iHeaderOrigAccuracy;
    STRING nHeaderOrigAccuracy;
    STRING iHeaderOrigDiff;
    STRING nHeaderOrigDiff;
    STRING iHeaderNewAccuracy;
    STRING nHeaderNewAccuracy;
    STRING iHeaderNewDiff;
    STRING nHeaderNewDiff;
    STRING nBaselineLatency;
    STRING nNewLatency;
    STRING iErrorsOrig;
    STRING nErrorsOrig;
    STRING iErrorsNew;
    STRING nErrorsNew;
  END;
	
EXPORT lReadableStatsRec := RECORD
    STRING sText;
    STRING sCnt;
    STRING sPct;
  END;
  
  
  //Change Field names to match your data. -ZRS 4/8/2019    
  EXPORT lSampleStatsRec := RECORD
    TYPEOF(lSampleLayout.PROFILE_BUCKET) sProfileBucket;
    // TYPEOF(lSampleLayout.TIMESTAMP) iTimeStamp;
    STRING iTimeStamp;
    STRING iMode;
    STRING iCompareMode;
    STRING sDescription;
    REAL nTotalCnt;
    REAL ncompany_nameCnt,
	REAL nprim_rangeCnt,
	REAL nprim_nameCnt,
	REAL nsec_rangeCnt,
	REAL ncityCnt,
	REAL nstateCnt,
	REAL nzip5Cnt,
	REAL nzip_radius_milesCnt,
	REAL nphone10Cnt,
	REAL nfeinCnt,
	REAL nurlCnt,
	REAL nemailCnt,
	REAL ncontact_fnameCnt,
	REAL ncontact_mnameCnt,
	REAL ncontact_lnameCnt,
	REAL ncontact_ssnCnt,
	REAL ncontact_didCnt,
	REAL nsic_codeCnt;
  END;
END;