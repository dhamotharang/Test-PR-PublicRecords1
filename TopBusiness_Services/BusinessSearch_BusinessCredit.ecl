IMPORT BIPV2, BIPV2_Best, BIPV2_Best_SBFE, BusinessCredit_Services, doxie, iesp;

EXPORT BusinessSearch_BusinessCredit := 
  MODULE
  
  
    EXPORT fn_addBusinessCreditSingletons ( DATASET(BIPV2.IDFunctions.rec_SearchInput) InputSearch,
                                            DATASET(iesp.topbusinessSearch.t_TopBusinessSearchRecord) ds_HeaderRecs,
                                            DATASET(TopBusiness_Services.BusinessSearch_Layouts.TopBizSearchBizIdsWithWeightRec) ds_BipRecWeights, 
                                            STRING inDataPermissionMask
                                          ) :=
      FUNCTION

        mod_access := 
          MODULE(doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
            EXPORT STRING DataPermissionMask := inDataPermissionMask;
          END;    
          
        // the following key fetch to the SBFE Best key returns ONLY SBFE/Business Credit records
        ds_BusinessCredit_IDs_All   := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(InputSearch).uid_results_w_acct;
        ds_BusinessCredit_IDs_dedup := DEDUP(SORT(ds_BusinessCredit_IDs_All, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())), #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));
        
         ds_BizCreditIDsDedup_BipIds :=
          PROJECT( ds_BusinessCredit_IDs_dedup, 
		               TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2, 															
														 SELF := LEFT, 	
                             SELF := []
														 ));
        
        ds_BusinessCredit_Recs_raw     := BIPV2_Best_SBFE.Key_LinkIds().KFetch2(ds_BizCreditIDsDedup_BipIds,BIPV2.IDconstants.Fetch_Level_SELEID, 0, inDataPermissionMask,TopBusiness_Services.Constants.defaultJoinLimit);
        ds_BusinessCredit_Recs_deduped := DEDUP(SORT(ds_BusinessCredit_Recs_raw, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), ProxID), #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()));

      
				// Set Business credit indicator.
				ds_HeaderRecsWithBizCredInd := PROJECT(ds_HeaderRecs,TRANSFORM( iesp.topbusinessSearch.t_TopBusinessSearchRecord, 
															SELF.BusinessCreditIndicator := BusinessCredit_Services.Functions.fn_BuzCreditIndicator(LEFT.BusinessIds.ultId, 
                                                                                                                      LEFT.BusinessIds.OrgID,
                                                                                                                      LEFT.BusinessIds.SeleID,
                                                                                                                      mod_access,
                                                                                                                      TRUE);
															SELF                         := LEFT));
													 
        // Filter out D&B only records - 
        ds_filterDnbSingletonsHeaderRecsWithBizCredInd := ds_HeaderRecsWithBizCredInd( DNBDMIRecordOnly = FALSE OR BusinessCreditIndicator = BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BOTH);

        // get SBFE Recs that are not in the header
        ds_BusinessCreditSingleton_Recs := 
          JOIN( ds_BusinessCredit_Recs_deduped, ds_HeaderRecs,
                LEFT.ultId  = RIGHT.BusinessIds.ultId AND
                LEFT.orgId  = RIGHT.BusinessIds.orgId AND
                LEFT.seleId = RIGHT.BusinessIds.seleId,
                TRANSFORM( LEFT ),
                LEFT ONLY );
                
        
        // append weight to Bip records
        // shouldn't need the left outer, but it ensures we don't lose any records
        ds_BipRecsWithWeight :=
          JOIN( ds_filterDnbSingletonsHeaderRecsWithBizCredInd, ds_BipRecWeights, 
                LEFT.BusinessIds.ultId  = RIGHT.ultId AND
                LEFT.BusinessIds.orgId  = RIGHT.orgId AND
                LEFT.BusinessIds.seleId = RIGHT.seleId,
                TRANSFORM( TopBusiness_Services.BusinessSearch_Layouts.TopBizSearchRecWithWeightRec,
                           SELF.Weight := RIGHT.Weight,
                           SELF        := LEFT ),
                LEFT OUTER );
        
        // Now populate BusinessCredit Singleton records with Best info
        // Per data fabrication (Kevin Garrity), the BIPV2_Best.Layouts.Key has all DATASETS within the 
        // record layout, but since we are pulling the Best, there will never be 
        // more than one record in each DATASET.
        iesp.topbusinessSearch.t_TopBusinessBestRecord xfm_TopBusinessBest( RECORDOF(ds_BusinessCreditSingleton_Recs) L ) := 
          TRANSFORM
	          SELF.CompanyNameInfo.CompanyName := (STRING120)L.Company_Name[1].Company_Name,
	          SELF.AddressInfo.Address         := iesp.ECL2ESP.SetAddress (L.Company_Address[1].company_prim_name,
                                                  L.Company_Address[1].company_prim_range, L.Company_Address[1].company_predir, 
                                                  L.Company_Address[1].company_postdir, L.Company_Address[1].company_addr_suffix, 
                                                  L.Company_Address[1].company_unit_desig, L.Company_Address[1].company_sec_range, 
                                                  L.Company_Address[1].company_p_city_name, L.Company_Address[1].company_st, 
                                                  L.Company_Address[1].company_zip5, L.Company_Address[1].company_zip4, 
                                                  L.Company_Address[1].county_name), 
            SELF.PhoneInfo.Phone10           := L.Company_phone[1].Company_Phone,
            SELF.ToDate                      := iesp.ECL2ESP.toDate (L.Company_Name[1].dt_last_seen),
            SELF.FromDate                    := iesp.ECL2ESP.toDate (L.Company_Name[1].dt_first_seen),           
		        SELF.URLInfo.URL                 := L.Company_url[1].Company_url,
            SELF.SICInfo.SIC                 := (STRING4)L.Sic_code[1].company_sic_code1,
	          SELF.TINInfo.TIN                 := L.Company_fein[1].Company_fein,  // per Kevin Garrity for BusinessCredit/SBFE these are the same 
            SELF.TINInfo.TINSource           := L.Company_fein[1].Sources[1].Source,
            SELF                             := []
          END;        

        // per BIP requirements:
        // we are not supposed to run a report if search results yield a singleton tag as per BIP 
        // requirements. So that can be changed at all.
        // The SBFE/Business Credit singletons will always display FALSE for the displayReportLink field.  
        // Since these records are singletons, only the best section can be populated.
        ds_BusinessCredit_singletonRecsWithWeight := 
          JOIN( ds_BusinessCreditSingleton_Recs, ds_BusinessCredit_IDs_dedup,
                BIPV2.IDmacros.mac_JoinTop3Linkids(),
                TRANSFORM( TopBusiness_Services.BusinessSearch_Layouts.TopBizSearchRecWithWeightRec,
                           SELF.BusinessIds       := ROW({LEFT.DotID, LEFT.EmpID, LEFT.POWID, LEFT.ProxID,
                                                          LEFT.SeleID, LEFT.OrgID, LEFT.UltID}, iesp.share.t_BusinessIdentity ),
                           SELF.DisplayReportLink := FALSE,
                           SELF.Best              := PROJECT(LEFT, xfm_TopBusinessBest(LEFT)), 
                           SELF.BusinessCreditIndicator := BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BUSINESS_CREDIT_ONLY,   // 1- header only, 2 - bizCredit/SBFE only, 3 - Both
                           SELF.Weight                  := RIGHT.Weight,
                           SELF                         := []),
                LIMIT(TopBusiness_Services.Constants.defaultJoinLimit,SKIP));
                              
        // sort Bip & Business Credit/SBFE records by weight and project back to iesp layout
        // Per David Wheelock: The higher the weight, the better the match, sorting -weight, then BusinessCreditIncicator + both, BipHeaderOnly, SBFE only
        ds_combineSortBipBizCredRecs := SORT( ds_BipRecsWithWeight + ds_BusinessCredit_singletonRecsWithWeight, -Weight, CASE(BusinessCreditIndicator, BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.BOTH => 1,  
                                                                                                                                                       BusinessCredit_Services.Constants.BUSINESS_CREDIT_INDICATOR.HEADER_FILE_ONLY => 2,
                                                                                                                                                       3));
        ds_returnRecs := PROJECT( ds_combineSortBipBizCredRecs, iesp.topbusinessSearch.t_TopBusinessSearchRecord );

        // OUTPUT(ds_BipRecsWithWeight, NAMED('ds_BipRecsWithWeight'));  
        // OUTPUT(ds_BusinessCredit_singletonRecsWithWeight, NAMED('ds_BusinessCredit_singletonRecsWithWeight'));
        // OUTPUT(ds_combineSortBipBizCredRecs, NAMED('ds_combineSortBipBizCredRecs'));        

        RETURN ds_returnRecs;
      
      END;  //  fn_addBusinessCreditSingletons
  
  END;  // module BusinessSearch_BusinessCredit