IMPORT address, AutoStandardI, BIPV2, BusinessCredit_Services, LNSmallBusiness, TopBusiness_Services;
EXPORT fn_getCompPhone( LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams SmallBizCombined_inmod ):= 
  FUNCTION

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
        SELF               := []
      END;

    ds_SearchInput := DATASET([xfm_getInputForLinkIDsCall]);           
    ds_linkIDs := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_SearchInput).Data2_;		

    // Only keep the first record to get phone
    ds_linkIDs_deduped := CHOOSEN(DEDUP(SORT(ds_linkIDs, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), -weight), #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids())),1);

    in_topbusiness_ds := 
      PROJECT(ds_linkIDs_deduped, 
        TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
									SELF.acctno := '1';
									SELF := LEFT ));

    	TopBusiness_Services.BestSection_Layouts.rec_OptionsLayout xform_topbusiness_options() := 
        TRANSFORM
          SELF.return_only_best         := TRUE;
          SELF.internal_testing         := SmallBizCombined_inmod.TestDataEnabled;
          SELF.IncludeNameVariations    := FALSE;
          SELF.businessReportFetchLevel	:= SmallBizCombined_inmod.FetchLevel; 
          SELF                          := [];
        END;

      in_options := ROW(xform_topbusiness_options());

      in_topbusiness_mod	:= MODULE(PROJECT(SmallBizCombined_inmod, AutoStandardI.DataRestrictionI.params, OPT)) END;	

    	add_best := TopBusiness_Services.BestSection.fn_fullView(	in_topbusiness_ds, 
																														    in_options,
																														    in_topbusiness_mod,
																														    DATASET([],TopBusiness_Services.Layouts.rec_busHeaderLayout));

      ds_SBA_Input_withPhone := 
        PROJECT(SmallBizCombined_inmod.ds_SBA_Input,
          TRANSFORM( LNSmallBusiness.BIP_Layouts.Input,
                     SELF.Bus_Phone10 := add_best[1].PhoneInfo.Phone10,
                     SELF             := LEFT
                    ));

      RETURN ds_SBA_Input_withPhone;

  END;