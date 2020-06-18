IMPORT ut, MDR, OneKey;

EXPORT Append_FileB(DATASET(OneKey.Layouts.Base)     pBaseFile
                   ,DATASET(OneKey.Layouts.Base)     pFileB) := FUNCTION

  dBase_Sort  := SORT(DISTRIBUTE(pBaseFile, HASH32(HCP_HCE_ID)), HCP_HCE_ID, LOCAL);
  dFileB_Sort := SORT(DISTRIBUTE(pFileB, HASH32(HCP_HCE_ID)), HCP_HCE_ID, LOCAL);
			 
  OneKey.Layouts.Base tLookupExclusion(dBase_Sort L, dFileB_Sort R) := TRANSFORM
    SELF.dt_vendor_first_reported            := MAX(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported             := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.RECORD_TYPE                         := IF(R.RECORD_TYPE = 'C', 'C', L.RECORD_TYPE);
    SELF.IMS_ID                              := R.IMS_ID;
    SELF.HCE_PRFSNL_STAT_CD                  := R.HCE_PRFSNL_STAT_CD;
    SELF.HCE_PRFSNL_STAT_DESC                := R.HCE_PRFSNL_STAT_DESC;
    SELF.EXCLD_RSN_DESC                      := R.EXCLD_RSN_DESC;
    SELF.NPI                                 := R.NPI;
    SELF.DEACTV_DT                           := R.DEACTV_DT;
    SELF.CLEANED_DEACTV_DT                   := R.CLEANED_DEACTV_DT;
    SELF.XREF_HCE_ID                         := R.XREF_HCE_ID;
    SELF                                     := L;
  END;  
  
  dExcludedBase := JOIN(dBase_Sort
                       ,dFileB_Sort
                       ,LEFT.HCP_HCE_ID = RIGHT.HCP_HCE_ID
                       ,tLookupExclusion(LEFT, RIGHT)
                       ,LEFT OUTER
                       ,LOCAL);
		
  RETURN dExcludedBase;

END;