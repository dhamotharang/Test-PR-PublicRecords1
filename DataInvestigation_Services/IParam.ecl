IMPORT BIPV2;

EXPORT IParam := 
  MODULE

    // Because this is an investigation service and we are returning the raw data
    // there is no need to implement DPM, DRM, SSNMask or DOBMasks
	  EXPORT DataInvestigationRawReport_IParams := 
      INTERFACE
        EXPORT DATASET (BIPV2.IDlayouts.l_xlink_ids2) BusinessIds := DATASET([], BIPV2.IDlayouts.l_xlink_ids2); 
        EXPORT STRING1 FetchLevel  := BIPV2.IDconstants.Fetch_Level_SELEID;
	    END;
      
  END;