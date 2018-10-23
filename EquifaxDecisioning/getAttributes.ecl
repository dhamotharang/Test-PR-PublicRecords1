IMPORT autoHeaderV2,AutoStandardI,doxie,EquifaxDecisioning,
       Gateway,iesp,riskwisefcra; 

EXPORT getAttributes (DATASET(doxie.layout_best) infile, 
                      DATASET(Gateway.Layouts.Config) gateways,
                      BOOLEAN gw_Requested,
                      STRING  in_DataPermissionMask,
                      BOOLEAN suppress_due_alerts = FALSE
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
        gatewayOutput := Gateway.SoapCall_EquifaxDecisioning(gatewayInput,ds_gatewayConfig,pMakeGatewayCall); 
        _rowGw := gatewayOutput[1].Response.Report;
        
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
            SELF := [];
          END;

        ds_gatewayRecToGetDid := DATASET([xfm_intoGetDidLayout(_rowGw)]);
        ds_gatewayRecDid := AutoHeaderV2.get_dids(ds_gatewayRecToGetDid,,FALSE); 
        
        useGatewayResults := ds_gatewayRecDid[1].DID = _rowInf.DID;

        fn_getAttributeValue(iesp.equifax_attributes.t_EquifaxAttributes gw_attributes, STRING4 CodeValueToReturn) := 
          CASE( CodeValueToReturn,
                gw_attributes.Field1[1..4] => gw_attributes.Field1[6..],
                gw_attributes.Field2[1..4] => gw_attributes.Field2[6..],
                gw_attributes.Field3[1..4] => gw_attributes.Field3[6..],
                gw_attributes.Field4[1..4] => gw_attributes.Field4[6..],
                gw_attributes.Field5[1..4] => gw_attributes.Field5[6..],
                gw_attributes.Field6[1..4] => gw_attributes.Field6[6..],
                gw_attributes.Field7[1..4] => gw_attributes.Field7[6..],
                gw_attributes.Field8[1..4] => gw_attributes.Field8[6..],
                gw_attributes.Field9[1..4] => gw_attributes.Field9[6..],
                gw_attributes.Field10[1..4] => gw_attributes.Field10[6..],
                gw_attributes.Field11[1..4] => gw_attributes.Field11[6..],
                gw_attributes.Field12[1..4] => gw_attributes.Field12[6..],
                gw_attributes.Field13[1..4] => gw_attributes.Field13[6..],
                gw_attributes.Field14[1..4] => gw_attributes.Field14[6..],
                gw_attributes.Field15[1..4] => gw_attributes.Field15[6..],
                gw_attributes.Field16[1..4] => gw_attributes.Field16[6..],
                gw_attributes.Field17[1..4] => gw_attributes.Field17[6..],
                gw_attributes.Field18[1..4] => gw_attributes.Field18[6..],
                gw_attributes.Field19[1..4] => gw_attributes.Field19[6..],
                gw_attributes.Field20[1..4] => gw_attributes.Field20[6..],
                                               '');

       EquifaxDecisioning.Layouts.Eq_DecisioningAttr xfm_getValidOutput (iesp.equifax_attributes.t_EquifaxAttributes gw_attributes) :=
          TRANSFORM
            SELF.EQUIFAX_GATEWAY_USAGE :=  EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.RESULTS_RETURNED;  
            SELF.BalOpenAutoAcctsWithin3Months :=  fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_AUTO_3MONTHS);
            SELF.BalOpenMortgageAcctsWithin3Months := fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_MORT_3MONTHS);
            SELF.BalOpenHomeEquityLineAcctsWithin3Months :=  fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.BAL_OPEN_HOME_EQ_3MONTHS);
            SELF.NumberUnpaidThirdPartyCollections := fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.NUM_UNPAID_3RD_PARTY_COL);
            SELF.PercentBalToHighCredBankcardsWithin3Months := fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_HIGH_CRED_BANKCARD_3MONTHS);
            SELF.PercentBalToTotalLoanAmtAutoWithin3Months :=  fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_TOTAL_AUTO_LOAN_3MONTHS);
            SELF.PercentBalToTotalLoanAmtMortgageWithin3Months := fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.PERCENT_BAL_TO_TOTAL_MORT_LOAN_3MONTHS);
            SELF.NumberOfThirdPartyCollections := fn_getAttributeValue(gw_attributes, EquifaxDecisioning.Constants.ATTRIBUTE_TYPES.NUM_3RD_PARTY_COLLECTIONS);
          END;

        ds_GatewayResultsToReturn := 
          MAP(~gw_Requested =>
                    DATASET([{EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_NOT_REQUESTED}],EquifaxDecisioning.Layouts.Eq_DecisioningAttr),
              ~pMakeGatewayCall OR ~hasEquifaxAccess OR suppress_due_alerts => 
                    DATASET([{EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.GATEWAY_NOT_CALLED}],EquifaxDecisioning.Layouts.Eq_DecisioningAttr),
              ~EXISTS(_rowGw.Attributes) => 
                    DATASET([{EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.NO_GATEWAY_ATTRIUBTES_RETURNED}],EquifaxDecisioning.Layouts.Eq_DecisioningAttr),
              ~useGatewayResults =>
                   DATASET([{EquifaxDecisioning.Constants.EQUIFAX_GATEWAY_USAGE.NO_DID_MATCH}],EquifaxDecisioning.Layouts.Eq_DecisioningAttr),
                   DATASET([xfm_getValidOutput(_rowGw.Attributes[1])])
              );

       RETURN ds_GatewayResultsToReturn; 
     END;    
  