IMPORT address, BIPV2, BIPV2_Best, doxie, LNSmallBusiness, TopBusiness_Services;

EXPORT fn_addBestInfo (LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams SmallBizCombined_inmod, 
                       INTEGER BestInfoNeeded
                      )  := 
  FUNCTION

    mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule ()))
      EXPORT unsigned1 glb := SmallBizCombined_inmod.glbpurpose;
      EXPORT unsigned1 dppa := SmallBizCombined_inmod.dppapurpose;	
      EXPORT string DataPermissionMask := SmallBizCombined_inmod.datapermissionmask;
      EXPORT string DataRestrictionMask := SmallBizCombined_inmod.datarestrictionmask;
      EXPORT boolean ln_branded := SmallBizCombined_inmod.lnbranded;
      EXPORT string5 industry_class := SmallBizCombined_inmod.industryclass; 
      EXPORT string32 application_type := SmallBizCombined_inmod.applicationtype;
      EXPORT string ssn_mask := SmallBizCombined_inmod.ssnmask; 
    END;

    // When the search input does not contain an company phone number, we need to 
    //   find it using the Best function.
    // As of 2016-06-17, there is ONLY one input company to search, so ds_SBA_Input will never have more than one record.
    CleanBizAddress :=  Address.GetCleanAddress( SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Street_Address1, 
                                                 SmallBizCombined_inmod.ds_SBA_Input[1].Bus_City + ', ' + SmallBizCombined_inmod.ds_SBA_Input[1].Bus_State + ' ' + SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Zip5,
                                                 address.Components.Country.US ).results; 
    
    BIPV2.IDFunctions.rec_SearchInput xfm_getInputForLinkIDsCall :=
      TRANSFORM
        SELF.company_name  := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Company_Name,
        SELF.prim_range    := CleanBizAddress.prim_range,
        SELF.prim_name     := CleanBizAddress.prim_name,
        SELF.sec_range     := CleanBizAddress.sec_range,
        SELF.city          := CleanBizAddress.v_city,
        SELF.state         := CleanBizAddress.state,
        SELF.zip5          := CleanBizAddress.zip,
        SELF.Contact_fname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_First_Name,
        SELF.Contact_mname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Middle_Name,
        SELF.Contact_lname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Last_Name,
        SELF.Contact_ssn   := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_SSN,
        SELF.contact_did   := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID;
        SELF               := []
      END;
   
    
    BIPV2.IDFunctions.rec_SearchInput xfm_getLinkIDsFromSeleForLinkIDsCall :=
      TRANSFORM
        SELF.inSeleid      := (STRING)SmallBizCombined_inmod.ds_SBA_Input[1].SeleID,
        SELF.Contact_fname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_First_Name,
        SELF.Contact_mname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Middle_Name,
        SELF.Contact_lname := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Last_Name,
        SELF.contact_did   := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID;
        SELF.Contact_ssn   := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_SSN,
        SELF               := []
      END;

    ds_SearchInput := IF( BestInfoNeeded = LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID,
                          DATASET([xfm_getLinkIDsFromSeleForLinkIDsCall]),
                          DATASET([xfm_getInputForLinkIDsCall])
                         );  
                          
    ds_linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_SearchInput).Data2_;		

    // Only keep the first record to get phone
    ds_linkIDs_deduped := CHOOSEN(DEDUP(SORT(ds_linkIDs, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -weight), #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),1);

    ds_in_ids := PROJECT(ds_linkIDs_deduped, BIPV2.IDlayouts.l_xlink_ids);
      
    // to ensure the restrictions are made and
    // so that we do not have another global mod fetch
    biz_kfetch_temp_mod := 
      MODULE(PROJECT(SmallBizCombined_inmod,BIPV2.mod_sources.iParams, OPT));
      END;
       
    ds_best := 
      BIPV2_Best.Key_LinkIds.KFetch( ds_in_ids,
                                     BIPV2.IDconstants.Fetch_Level_SELEID,
                                     ,
                                     biz_kfetch_temp_mod,
                                     FALSE,
                                     TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit
                                    )(proxid = 0);	
                  
      // there will always only be one input record
      ds_SBA_InputPlusPhone := 
        PROJECT(SmallBizCombined_inmod.ds_SBA_Input,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Bus_Phone10 := (STRING10)ds_best[1].Company_phone[1].company_phone,
                     SELF             := LEFT
                    ));

      ds_SBA_InputFromSeleID := 
        PROJECT(SmallBizCombined_inmod.ds_SBA_Input,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Bus_Phone10         := (STRING10)ds_best[1].Company_phone[1].company_phone,
                     SELF.Bus_Company_Name    := ds_best[1].Company_name[1].Company_Name,   
                     SELF.Bus_Street_Address1 := (STRING120)Address.Addr1FromComponents(ds_best[1].company_address[1].company_prim_range, 
                                                                                        ds_best[1].company_address[1].company_predir, 
                                                                                        ds_best[1].company_address[1].company_prim_name,
                                                                                        ds_best[1].company_address[1].company_addr_suffix, 
                                                                                        ds_best[1].company_address[1].company_postdir, '', ''),      
                     SELF.Bus_City            := ds_best[1].company_address[1].company_p_city_name,  
                     SELF.Bus_State           := ds_best[1].company_address[1].company_st, 
                     SELF.Bus_Zip             := ds_best[1].company_address[1].company_zip5,  
                     SELF.SeleID              := ds_best[1].SeleID,
                     SELF.OrgID               := ds_best[1].OrgID,
                     SELF.UltID               := ds_best[1].UltID,       
                     SELF                     := LEFT
                    ));

      ds_SBA_Company_withPhone :=  
        CASE( BestInfoNeeded,
              LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID 
                => ds_SBA_InputFromSeleID,
              LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.PHONE 
                => ds_SBA_InputPlusPhone,
                   SmallBizCombined_inmod.ds_SBA_Input // LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.LEXID_ONLY
             );
     
      //GET Person Best Record for Auth Rep1
		  authRep1_BestRec := doxie.best_records(DATASET([SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID], Doxie.layout_references),
                                             FALSE,  // IsFCRA
                                             FALSE,  // doSuppress
                                             FALSE,  // doTimeZone
                                             FALSE,  // useNonBlankKey
                                             FALSE,  // checkRNA
                                             FALSE,  // includeDOD
                                             FALSE,  // include_minors
                                             FALSE,   // getSSNBest
                                             mod_access
                                            );
		
      ds_SBA_Company_withPhone_add_Rep1Info  :=  
        PROJECT(ds_SBA_Company_withPhone,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Rep_1_First_Name      := authRep1_BestRec[1].fname,
                     SELF.Rep_1_Middle_Name     := authRep1_BestRec[1].mname,
                     SELF.Rep_1_Last_Name       := authRep1_BestRec[1].lname,
                     SELF.Rep_1_Suffix          := authRep1_BestRec[1].name_suffix,
                     SELF.Rep_1_DOB             := (STRING8)authRep1_BestRec[1].DOB,
                     SELF.Rep_1_SSN             := authRep1_BestRec[1].ssn,
                     SELF.Rep_1_Street_Address1 := (STRING120) Address.Addr1FromComponents(authRep1_BestRec[1].prim_range, 
                                                                                           authRep1_BestRec[1].predir, 
                                                                                           authRep1_BestRec[1].prim_Name,
                                                                                           authRep1_BestRec[1].suffix, 
                                                                                           authRep1_BestRec[1].postdir, '', ''),  
                     SELF.Rep_1_City            := authRep1_BestRec[1].city_name,
                     SELF.Rep_1_State           := authRep1_BestRec[1].st,
                     SELF.Rep_1_Zip             := authRep1_BestRec[1].zip,
                     SELF.Rep_1_Phone10         := authRep1_BestRec[1].phone,
                     SELF.Rep_1_Age             := (STRING3)authRep1_BestRec[1].age,
                     SELF.Rep_1_DL_Number       := authRep1_BestRec[1].dl_number,
                     SELF                       := LEFT
                  )); 
      
      ds_withAuthRep1 := IF( SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID != 0, 
                             ds_SBA_Company_withPhone_add_Rep1Info,
                             ds_SBA_Company_withPhone 
                           );

           
      //GET Person Best Record for Auth Rep2
		  authRep2_BestRec := doxie.best_records(DATASET([SmallBizCombined_inmod.ds_SBA_Input[1].Rep_2_LexID], Doxie.layout_references),
                                             FALSE,  // IsFCRA
                                             FALSE,  // doSuppress
                                             FALSE,  // doTimeZone
                                             FALSE,  // useNonBlankKey
                                             FALSE,  // checkRNA
                                             FALSE,  // includeDOD
                                             FALSE,  // include_minors
                                             FALSE,   // getSSNBest
                                             mod_access
                                            );
		
      ds_SBA_Company_withPhone_add_Rep2Info  :=  
        PROJECT(ds_withAuthRep1,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Rep_2_First_Name      := authRep2_BestRec[1].fname,
                     SELF.Rep_2_Middle_Name     := authRep2_BestRec[1].mname,
                     SELF.Rep_2_Last_Name       := authRep2_BestRec[1].lname,
                     SELF.Rep_2_Suffix          := authRep2_BestRec[1].name_suffix,
                     SELF.Rep_2_DOB             := (STRING8)authRep2_BestRec[1].DOB,
                     SELF.Rep_2_SSN             := authRep2_BestRec[1].ssn,
                     SELF.Rep_2_Street_Address1 := (STRING120) Address.Addr1FromComponents(authRep2_BestRec[1].prim_range, 
                                                                                           authRep2_BestRec[1].predir, 
                                                                                           authRep2_BestRec[1].prim_Name,
                                                                                           authRep2_BestRec[1].suffix, 
                                                                                           authRep2_BestRec[1].postdir, '', ''),  
                     SELF.Rep_2_City            := authRep2_BestRec[1].city_name,
                     SELF.Rep_2_State           := authRep2_BestRec[1].st,
                     SELF.Rep_2_Zip             := authRep2_BestRec[1].zip,
                     SELF.Rep_2_Phone10         := authRep2_BestRec[1].phone,
                     SELF.Rep_2_Age             := (STRING3)authRep2_BestRec[1].age,
                     SELF.Rep_2_DL_Number       := authRep2_BestRec[1].dl_number,
                     SELF                       := LEFT
                  )); 
      
      ds_withAuthRep2 := IF( SmallBizCombined_inmod.ds_SBA_Input[1].Rep_2_LexID != 0, 
                             ds_SBA_Company_withPhone_add_Rep2Info,
                             ds_withAuthRep1 
                           );
      //GET Person Best Record for Auth Rep3
		  authRep3_BestRec := doxie.best_records(DATASET([SmallBizCombined_inmod.ds_SBA_Input[1].Rep_3_LexID], Doxie.layout_references),
                                             FALSE,  // IsFCRA
                                             FALSE,  // doSuppress
                                             FALSE,  // doTimeZone
                                             FALSE,  // useNonBlankKey
                                             FALSE,  // checkRNA
                                             FALSE,  // includeDOD
                                             FALSE,  // include_minors
                                             FALSE,   // getSSNBest
                                             mod_access
                                            );
		
      ds_SBA_Company_withPhone_add_Rep3Info  :=  
        PROJECT(ds_withAuthRep2,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Rep_3_First_Name      := authRep3_BestRec[1].fname,
                     SELF.Rep_3_Middle_Name     := authRep3_BestRec[1].mname,
                     SELF.Rep_3_Last_Name       := authRep3_BestRec[1].lname,
                     SELF.Rep_3_Suffix          := authRep3_BestRec[1].name_suffix,
                     SELF.Rep_3_DOB             := (STRING8)authRep3_BestRec[1].DOB,
                     SELF.Rep_3_SSN             := authRep3_BestRec[1].ssn,
                     SELF.Rep_3_Street_Address1 := (STRING120) Address.Addr1FromComponents(authRep3_BestRec[1].prim_range, 
                                                                                           authRep3_BestRec[1].predir, 
                                                                                           authRep3_BestRec[1].prim_Name,
                                                                                           authRep3_BestRec[1].suffix, 
                                                                                           authRep3_BestRec[1].postdir, '', ''),  
                     SELF.Rep_3_City            := authRep3_BestRec[1].city_name,
                     SELF.Rep_3_State           := authRep3_BestRec[1].st,
                     SELF.Rep_3_Zip             := authRep3_BestRec[1].zip,
                     SELF.Rep_3_Phone10         := authRep3_BestRec[1].phone,
                     SELF.Rep_3_Age             := (STRING3)authRep3_BestRec[1].age,
                     SELF.Rep_3_DL_Number       := authRep3_BestRec[1].dl_number,
                     SELF                       := LEFT
                  )); 
      
      ds_SBA_Input := IF( SmallBizCombined_inmod.ds_SBA_Input[1].Rep_3_LexID != 0, 
                          ds_SBA_Company_withPhone_add_Rep3Info,
                          ds_withAuthRep2 
                        );


    RETURN ds_SBA_Input;

  END;