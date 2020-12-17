// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
import AutoStandardI, iesp, std;

EXPORT SearchService := MACRO

	 	#constant('StrictMatch', false);

		//to do : Can move a lot of code from here to Iparams.

    //get XML input
		initial_default_ESP_URL := '';
		initial_default_ESP_NAME := 'DeltaBaseSql';
		gateways_record := Risk_Indicators.Layout_Gateways_In;

    rec_in := iesp.ecrash.t_ECrashSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('eCrashSearchRequest', FEW);
		gateways_in := dataset([], gateways_record) : stored ('Gateways', FEW);

    first_row := ds_in[1] : independent;
		// string tmpURLString := gateways_in[1].url;
		// 7/14/17 - For alias - since we get more than 1 gateway information, we check if it belongs to delta_ec and use that
		string tmpURLString := gateways_in(STD.Str.ToUpperCase (TRIM(servicename,ALL)) = 'DELTA_EC')[1].url;

		// 7/16 - Tino said they are populating servicename with 'delta_ec' which will not work for the servicename.
		// string tmpNAMEString := gateways_in[1].servicename;
		string tmpNAMEString := initial_default_ESP_NAME;
		// remove the temporary definition above and go back to the gateway if they fix the populated value

		string SQL_SEARCH_ESP_URL := if(tmpURLString <> '', tmpURLString, initial_default_ESP_URL);
		string SQL_SEARCH_ESP_NAME := if(tmpNAMEString <> '', tmpNAMEString, initial_default_ESP_NAME);

    //set options
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    Search_opt := global (first_row.Options);

    //set search criteria
    search_by := global (first_row.searchBy);

    #stored ('AccidentLocationCrossStreet', TRIM(STD.Str.ToUpperCase (search_by.AccidentLocation.CrossStreet),left,right));
    #stored ('AccidentLocationStreet', TRIM(STD.Str.ToUpperCase (search_by.AccidentLocation.Street),left,right));
		#stored ('ReportNumber', TRIM(search_by.ReportNumber,left,right));
		#stored ('Jurisdiction', TRIM(STD.Str.ToUpperCase (search_by.Jurisdiction),left,right));
		#stored ('JurisdictionState', TRIM(STD.Str.ToUpperCase (search_by.JurisdictionState),left,right));
		#stored ('Agencies', search_by.Agencies);
		#stored ('UserType', TRIM(STD.Str.ToUpperCase (search_by.UserType),left,right));
		#stored ('AgencyORI', TRIM(STD.Str.ToUpperCase (search_by.AgencyORI),left,right));
		#stored ('RequestHashKey', search_by.RequestHashKey);
		#stored('OfficerBadgeNumber', TRIM(search_by.OfficerBadgeNumber,left,right));
		#stored('DriversLicense', TRIM(STD.Str.ToUpperCase (search_by.DriversLicense),left,right));
		#stored('Vin', TRIM(STD.Str.ToUpperCase (search_by.Vin),left,right));
		#stored('LicensePlate', TRIM(STD.Str.ToUpperCase (search_by.LicensePlate),left,right));
		#stored ('GroupRecords', Search_opt.GroupRecords);
		#stored ('CustomerType', Search_opt.CustomerType);
		#stored ('BlockNumber', TRIM(STD.Str.ToUpperCase (search_by.AccidentLocation.BlockNumber),left,right));

		#stored ('SortOrder', Search_opt.SortOrder);
		#stored ('SortField', Search_opt.SortField);
		#stored ('SubscriptionReports', Search_opt.SubscriptionReports);
		#stored ('MaxResults', Search_opt.MaxResults);

		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		iesp.ECL2ESP.Marshall.Mac_Set(Search_opt);

		dol_date_calc:=search_by.DateOfLoss.Year*10000 + search_by.DateOfLoss.Month*100 + search_by.DateOfLoss.Day;
		dol_date := if(dol_date_calc=0,'',(string)dol_date_calc);

		dol_start_date_calc:=search_by.StartDate.Year*10000 + search_by.StartDate.Month*100 + search_by.StartDate.Day;
		dol_start_date := if(dol_start_date_calc=0,'',(string)dol_start_date_calc);

		dol_end_date_calc:=search_by.EndDate.Year*10000 + search_by.EndDate.Month*100 + search_by.EndDate.Day;
		dol_end_date := if(dol_end_date_calc=0,'',(string)dol_end_date_calc);

		DateOfBirth := iesp.ECL2ESP.t_DateToString8(search_By.DOB);

		#stored('DateOfLoss', dol_date);
		#stored('DolStartdate', dol_start_date);
		#stored('DolEnddate', dol_end_date);
		#stored('DateOfBirth', DateOfBirth);



		string Jurisdiction_tmp 					:= '' : stored('Jurisdiction');
		string Jurisdiction_old 					:= TRIM(STD.Str.ToUpperCase (Jurisdiction_tmp),left,right);
		string JurisdictionState_tmp 			:= '' : stored('JurisdictionState');
		string JurisdictionState_old 			:= TRIM(STD.Str.ToUpperCase (JurisdictionState_tmp),left,right);
		string AgencyORI_old 							:= '' : stored('AgencyORI');
		//added empty dataset if no state or jurisdiction information is supplied in request
		recordof(iesp.ecrash.t_ECrashSearchAgency) xform_emptyagency():=TRANSFORM
					self:=[];
		END;

		DATASET(iesp.ecrash.t_ECrashSearchAgency) Agencies_stored := DATASET([], iesp.ecrash.t_ECrashSearchAgency) : stored('Agencies', FEW);
		DATASET(iesp.ecrash.t_ECrashSearchAgency) Agencies_tmp 		:= PROJECT(IF(EXISTS(Agencies_stored), Agencies_stored, dataset([xform_emptyagency()])), TRANSFORM(iesp.ecrash.t_ECrashSearchAgency,
																																								SELF.Jurisdiction := TRIM(STD.Str.ToUpperCase (LEFT.Jurisdiction),left,right);
																																								SELF.JurisdictionState := TRIM(STD.Str.ToUpperCase (LEFT.JurisdictionState),left,right);
																																								SELF.AgencyID := TRIM(STD.Str.ToUpperCase (LEFT.AgencyID),left,right);
																																								SELF.AgencyORI := TRIM(STD.Str.ToUpperCase (LEFT.AgencyORI),left,right);
																																								SELF := LEFT;));
		recordof(iesp.ecrash.t_ECrashSearchAgency) xform_agency():=TRANSFORM
					SELF.Jurisdiction := Jurisdiction_old;
					SELF.JurisdictionState := JurisdictionState_old;
					SELF.AgencyORI := AgencyORI_old;
					SELF.PrimaryAgency := TRUE;
					SELF:=[];
	  END;
		boolean old_agency_exists := 	Jurisdiction_old <> '' OR JurisdictionState_old <> '';
		agency_ds := IF(old_agency_exists, dataset([xform_agency()]), Agencies_tmp);

    tempmod := MODULE(PROJECT(AutoStandardI.GlobalModule(),eCrash_Services.IParam.searchrecords,opt));
        export string AccidentLocationCrossStreet  := '' : stored('AccidentLocationCrossStreet');
        export string AccidentLocationStreet  := '' : stored('AccidentLocationStreet');
				export string ReportNumber_raw 			:= '' : stored('ReportNumber');
        export string ReportNumber 			:= stringlib.stringfilter(STD.Str.ToUpperCase (ReportNumber_raw), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				export dataset(iesp.ecrash.t_ECrashSearchAgency) Agencies := agency_ds;
				export string DateOfLoss 				:= '' : stored('DateOfLoss');
				export string DolStartdate 				:= '' : stored('DolStartdate');
				export string DolEnddate 				:= '' : stored('DolEnddate');
				export string UserType 				:= '' : stored('UserType');
				export boolean RequestHashKey := false : stored('RequestHashKey');
				export boolean GroupRecords 				:= false : stored('GroupRecords');
				export boolean SubscriptionReports 				:= false : stored('SubscriptionReports');
				export string SortOrder 				:= '' : stored('SortOrder');
				export string SortField 				:= '' : stored('SortField');
				export integer MaxLimit 				:= 750 : stored('MaxResults');
				export string200 SqlSearchEspURL := SQL_SEARCH_ESP_URL;
				export string SqlSearchEspNAME := SQL_SEARCH_ESP_NAME;
				export string   OfficerBadgeNumber 	  :=  '' : stored('OfficerBadgeNumber');
				export string   driversLicenseNumber  :=  '' : stored('DriversLicense');
				export string   VehicleVin  :=  '' : stored('Vin');
				export string   LicensePlate  :=  '' : stored('LicensePlate');
			  export string200 GatewayEspURL := gateways_in(STD.Str.ToUpperCase (TRIM(servicename,ALL)) = 'GATEWAY_ESP')[1].url;
			  export string KY_SearchEspNAME 	:= 'KYCrashSearch';
			  export string HPD_SearchEspNAME 	:= 'HPDReportSearch';
				export string	BlockNumber			:= '' : stored('BlockNumber');
				export string	CustomerType			:= '' : stored('CustomerType');
				export string	DateOfBirth			:= '' : stored('DateOfBirth');
    END;


		Recs_in := eCrash_Services.Records(tempmod );

		GW_results := Recs_in.getGatewayrecords();


		recs := if (tempmod.SubscriptionReports = true, Recs_in.getSubscriptionRecords()
																									, Recs_in.getSearchRecords(GW_results.alias_agencies
																																					,  GW_results.response_final));

		//look to pass Max limit in Macro.
		//could be this maxRetCnt:=MaxLimit
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs, results,iesp.eCrash.t_ECrashSearchResponse, Records, false);

		output(results,named('Results'));

ENDMACRO;
