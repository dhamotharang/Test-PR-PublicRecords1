IMPORT autoHeaderV2,AutoStandardI,doxie,EquifaxDecisioning,
       Gateway,iesp,riskwisefcra,Suppress; 

EXPORT getAttributes (DATASET(doxie.layout_best) infile, 
                      DATASET(Gateway.Layouts.Config) gateways,
                      BOOLEAN gw_Requested,
                      STRING  in_DataPermissionMask,
                      BOOLEAN suppress_due_alerts = FALSE,
                      STRING32 ApplicationType_in = Suppress.Constants.ApplicationTypes.DEFAULT
                     ) := 
      FUNCTION
        dataPermissionTempMod := MODULE( AutoStandardI.DataPermissionI.params )
                                         EXPORT dataPermissionMask := in_dataPermissionMask;
		                                     END;
        
        hasEquifaxAccess := AutoStandardI.DataPermissionI.val(dataPermissionTempMod).use_EquifaxAcctDecisioning;     
        _rowInf := infile[1];

        ssn2send := IF(LENGTH(TRIM(_rowInf.ssn_unmasked,LEFT,RIGHT)) = 9,
                       _rowInf.ssn_unmasked,
                       _rowInf.ssn);
                       
        fnamelnamePopulated := _rowInf.fname != '' AND _rowInf.lname != '';
        minAddressPopulated := _rowInf.prim_range != '' AND
                               _rowInf.prim_name != '' AND
                               _rowInf.city_name != '' AND
                               _rowInf.st != '';
                            
        BOOLEAN pMakeGatewayCall := gw_Requested AND
                                    hasEquifaxAccess AND
                                    _rowInf.did != 0 AND
                                    fnamelnamePopulated  AND
                                    minAddressPopulated;

        iesp.equifax_attributes.t_EquifaxAttributesRequest xfm_populateEqfAcctDecSearch() :=
          TRANSFORM				
            SELF.SearchBy.Name.Prefix := _rowInf.title;
            SELF.SearchBy.Name.First := _rowInf.fname;
            SELF.SearchBy.Name.Middle := _rowInf.mname;
            SELF.SearchBy.Name.Last := _rowInf.lname;
            SELF.SearchBy.Name.Suffix := _rowInf.name_suffix; 
            SELF.SearchBy.Address.HouseNumber := _rowInf.prim_range;
            SELF.SearchBy.Address.Quadrant := _rowInf.postdir;
            SELF.SearchBy.Address.StreetName := _rowInf.prim_name;
            SELF.SearchBy.Address.StreetType := _rowInf.suffix;
            SELF.SearchBy.Address.ApartmentNumber := _rowInf.sec_range;
            SELF.SearchBy.Address.City := _rowInf.city_name;
            SELF.SearchBy.Address.State := _rowInf.st;
            SELF.SearchBy.Address.Zip := _rowInf.zip;
            SELF.SearchBy.SSN := ssn2send;
            SELF.SearchBy.DOB := iesp.ECL2ESP.toTDate2((UNSIGNED4)_rowInf.dob);
            SELF.SearchBy.EndUser.CompanyName := EquifaxDecisioning.Constants.GATEWAY_END_USER_COMPANY_NAME;
            SELF.SearchBy.EndUser.PermisablePurpose := EquifaxDecisioning.Constants.GATEWAY_END_USER_PERMISABLE_PURPOSE;
            SELF.SearchBy.Models := DATASET([{EquifaxDecisioning.Constants.GATEWAY_MODEL_NUMBER,'',''}],iesp.equifax_sts.t_EqSTSModel);
            SELF := [];  // gateway params
          END;																
        
        gatewayInput := DATASET([xfm_populateEqfAcctDecSearch()]);
        
        ds_gatewayConfig := gateways(Gateway.Configuration.IsEquifaxAcctDecisioning(serviceName))[1];
        gatewayOutput := Gateway.SoapCall_EquifaxDecisioning(gatewayInput,ds_gatewayConfig,pMakeGatewayCall):INDEPENDENT; 
        _rowGw := gatewayOutput[1].Response.Report;
        _rowGwHeader := gatewayOutput[1].Response._Header;
        
        // FCRA URL needed for the remote header search
        gateway_check := gateways (servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
        STRING remote_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);
        
        AutoHeaderV2.layouts.unprocessed_input xfm_intoGetDidLayout(iesp.equifax_attributes.t_EquifaxAttributesReport l) := 
          TRANSFORM
            useGatewayDOB := LENGTH(TRIM(l.EquifaxHeader.DateOfBirthOrAge,LEFT,RIGHT)) = 8;

            SELF.ssn := l.EquifaxHeader.SubjectsSSN;
            SELF.dob := (IF(useGatewayDOB,(UNSIGNED8)l.EquifaxHeader.DateOfBirthOrAge, 0));
            SELF.phone := l.CurrentAddress.TelephoneNumber;
            SELF.firstname := l.EquifaxHeader.SubjectsFirstName;
            SELF.middlename := l.EquifaxHeader.SubjectsMiddleName;
            SELF.lastname := l.EquifaxHeader.SubjectsLastName;
            SELF.primrange := l.CurrentAddress.StreetNumber;
            SELF.primname := l.CurrentAddress.StreetName;
            SELF.city := l.CurrentAddress.City;
            SELF.state := l.CurrentAddress.StateCode;
            SELF.zip := l.CurrentAddress.ZipCode[1..5];
            SELF.seisintadlservice := remote_ip;
            SELF.useonlybestdid := TRUE;
            SELF.ApplicationType := ApplicationType_in;
            SELF := [];
          END;

        ds_gatewayRecToGetDid := DATASET([xfm_intoGetDidLayout(_rowGw)]);
        ds_gatewayRecDid := AutoHeaderV2.get_dids(ds_gatewayRecToGetDid,,FALSE); 
        
        useGatewayResults := ds_gatewayRecDid[1].DID = _rowInf.DID;

       EquifaxDecisioning.Layouts.Eq_DecisioningAttr xfm_getValidOutput (iesp.equifax_attributes.t_EquifaxAttributes gw_attributes) := 
          TRANSFORM
            SELF.EQUIFAX_GATEWAY_USAGE :=  EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.RESULTS_RETURNED;  
            BalOpenAutoAcctsWithin3MonthsRaw :=  EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_AUTO_3MONTHS);
            BalOpenMortgageAcctsWithin3MonthsRaw := EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_MORT_3MONTHS);
            BalOpenHomeEquityLineAcctsWithin3MonthsRaw :=  EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_HOME_EQ_3MONTHS);
            NumberUnpaidThirdPartyCollectionsRaw := EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.NUM_UNPAID_3RD_PARTY_COL);
            PercentBalToHighCredBankcardsWithin3MonthsRaw := EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_HIGH_CRED_BANKCARD_3MONTHS);
            PercentBalToTotalLoanAmtAutoWithin3MonthsRaw :=  EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_TOTAL_AUTO_LOAN_3MONTHS);
            PercentBalToTotalLoanAmtMortgageWithin3MonthsRaw := EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_TOTAL_MORT_LOAN_3MONTHS);
            NumberOfThirdPartyCollectionsRaw := EquifaxDecisioning.Functions.getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.NUM_3RD_PARTY_COLLECTIONS);
            SELF.BalOpenAutoAcctsWithin3Months :=  BalOpenAutoAcctsWithin3MonthsRaw;
            SELF.BalOpenMortgageAcctsWithin3Months := BalOpenMortgageAcctsWithin3MonthsRaw;
            SELF.BalOpenHomeEquityLineAcctsWithin3Months :=  BalOpenHomeEquityLineAcctsWithin3MonthsRaw;
            SELF.NumberUnpaidThirdPartyCollections := NumberUnpaidThirdPartyCollectionsRaw;
            SELF.PercentBalToHighCredBankcardsWithin3Months := PercentBalToHighCredBankcardsWithin3MonthsRaw;
            SELF.PercentBalToTotalLoanAmtAutoWithin3Months :=  PercentBalToTotalLoanAmtAutoWithin3MonthsRaw;
            SELF.PercentBalToTotalLoanAmtMortgageWithin3Months := PercentBalToTotalLoanAmtMortgageWithin3MonthsRaw;
            SELF.NumberOfThirdPartyCollections := NumberOfThirdPartyCollectionsRaw;
            SELF.BalOpenAutoAcctsWithin3MonthsVal :=  EquifaxDecisioning.Functions.fn_processTotalOpenAuto(BalOpenAutoAcctsWithin3MonthsRaw);
            SELF.BalOpenMortgageAcctsWithin3MonthsVal := EquifaxDecisioning.Functions.fn_processTotalOpenMortgage(BalOpenMortgageAcctsWithin3MonthsRaw);
            SELF.BalOpenHomeEquityLineAcctsWithin3MonthsVal :=  EquifaxDecisioning.Functions.fn_processTotalOpenHomeEquity(BalOpenHomeEquityLineAcctsWithin3MonthsRaw);
            SELF.NumberUnpaidThirdPartyCollectionsVal := EquifaxDecisioning.Functions.fn_processUnpaid3rdParty(NumberUnpaidThirdPartyCollectionsRaw);
            SELF.PercentBalToHighCredBankcardsWithin3MonthsVal := EquifaxDecisioning.Functions.fn_processPercentBankcards(PercentBalToHighCredBankcardsWithin3MonthsRaw);
            SELF.PercentBalToTotalLoanAmtAutoWithin3MonthsVal :=  EquifaxDecisioning.Functions.fn_processPercentAuto(PercentBalToTotalLoanAmtAutoWithin3MonthsRaw);
            SELF.PercentBalToTotalLoanAmtMortgageWithin3MonthsVal := EquifaxDecisioning.Functions.fn_processPercentMortgage(PercentBalToTotalLoanAmtMortgageWithin3MonthsRaw);
            SELF.NumberOfThirdPartyCollectionsVal := EquifaxDecisioning.Functions.fn_processNum3rdParty(NumberOfThirdPartyCollectionsRaw);
            SELF.EqfxGatewayErrorStatus := 0;
            SELF.EqfxGatewayMessage := '';
          END;
        
        ds_resultsToReturn := DATASET([xfm_getValidOutput(_rowGw.Attributes[1])]);
        
        ds_GatewayResultsToReturn := 
          MAP(~gw_Requested =>
                 EquifaxDecisioning.Functions.fn_formatGatewayUsageOutput(EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_NOT_REQUESTED),
              ~pMakeGatewayCall OR ~hasEquifaxAccess OR suppress_due_alerts => 
                 EquifaxDecisioning.Functions.fn_formatGatewayUsageOutput(EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_NOT_CALLED),
              _rowGwHeader.Status != 0  OR _rowGW.ERROR.NumberOfFormatErrors != '' OR _rowGW.ERROR.NumberOfValidityErrors != '' OR _rowGW.ERROR.NumberOfProcessingErrors != '' OR _rowGW.ModelError.ErrorCode != '' =>
                 EquifaxDecisioning.Functions.fn_formatGatewayUsageOutput(EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_ERROR_RETURNED,_rowGwHeader.Status,_rowGW.ERROR,_rowGW.ModelError),
              ~EXISTS(_rowGw.Attributes) => 
                 EquifaxDecisioning.Functions.fn_formatGatewayUsageOutput(EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.NO_GATEWAY_ATTRIBUTES_RETURNED),
              ~useGatewayResults =>
                 EquifaxDecisioning.Functions.fn_formatGatewayUsageOutput(EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.NO_DID_MATCH),
                 ds_resultsToReturn
              );
OUTPUT(gatewayInput, NAMED('gatewayInput'));
OUTPUT(gatewayOutput, NAMED('gatewayOutput'));
OUTPUT(ds_gatewayRecToGetDid, NAMED('ds_gatewayRecToGetDid'));
OUTPUT(ds_gatewayRecDid, NAMED('ds_gatewayRecDid'));
OUTPUT(useGatewayResults, NAMED('useGatewayResults'));

       RETURN ds_GatewayResultsToReturn; 
     END;    
  