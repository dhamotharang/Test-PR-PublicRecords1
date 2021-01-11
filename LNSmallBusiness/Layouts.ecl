import iesp,LNSmallBusiness;

export Layouts := MODULE
	export Model_With_Seq := RECORD
		unsigned4 seq;
		iesp.ws_analytics.t_SmallBusinessModelHRI;
	END;


	export Batch_In := record
		UNSIGNED4 seq;
		STRING30  AcctNo;
		UNSIGNED3 HistoryDateYYYYMM;
		
		/* business info */
		string50 bus_name;
		string50 bus_altname;
		
		string28 bus_streetname;
		string10 bus_streetnumber;
		string2  bus_streetpredirection;
		string2  bus_streetpostdirection;
		string4  bus_streetsuffix;
		string10 bus_unitdesignation;
		string8  bus_unitnumber;
		string65 bus_streetaddress1;
		string65 bus_streetaddress2;
		string2  bus_state;
		string25 bus_city;
		string5  bus_zip5;
		string4  bus_zip4;
		string18 bus_county;
		string6  bus_postalcode;
		string50 bus_statecityzip;
		
		string9  bus_fein;
		string10 bus_phone10;
		
		
		/* rep info */
		string62 rep_fullname;
		string20 rep_first;
		string20 rep_middle;
		string20 rep_last;
		string5  rep_suffix;
		string5  rep_prefix;
		
		string28 rep_streetname;
		string10 rep_streetnumber;
		string2  rep_streetpredirection;
		string2  rep_streetpostdirection;
		string4  rep_streetsuffix;
		string10 rep_unitdesignation;
		string8  rep_unitnumber;
		string60 rep_streetaddress1;
		string60 rep_streetaddress2;
		string2  rep_state;
		string25 rep_city;
		string5  rep_zip5;
		string4  rep_zip4;
		string18 rep_county;
		string6  rep_postalcode;
		string50 rep_statecityzip;
		
		string9  rep_ssn;
		string4  rep_dob_year;
		string2  rep_dob_month;
		string2  rep_dob_day;
		string10 rep_phone10;
		string20 rep_driverlicensenumber;
		string2  rep_driverlicensestate;
	end;
	export Batch_Out := RECORD
		Batch_In - HistoryDateYYYYMM;
		
		// data for the first model. batch output defines two model outputs per discussion with todd.
		// the first will be for generic models and the second is for custom, even though it's not likely
		// that more than one model will be called at any given time (at least not as of now).
		string3   index1; // billing index; see Risk_Indicators.BillingIndex
		string10  name1; // eg, RVS811_0
		string3   score1; // actual score (eg, 500-999)
		string4   rep_rc11; // rep reason codes and descriptions
		string4   rep_rc21;
		string4   rep_rc31;
		string4   rep_rc41;
		string4   bus_rc11; // business reason codes and descriptions
		string4   bus_rc21;
		string4   bus_rc31;
		string4   bus_rc41;


		string3   index2; // billing index; see Risk_Indicators.BillingIndex
		string10  name2; // eg, RVS811_0
		string3   score2;
		string4   rep_rc12;
		string4   rep_rc22;
		string4   rep_rc32;
		string4   rep_rc42;
		string4   bus_rc12;
		string4   bus_rc22;
		string4   bus_rc32;
		string4   bus_rc42;

	END;

	export Testseeds := RECORD
		STRING10 modelname;
		STRING10 table_name;

		Batch_In - HistoryDateYYYYMM;
		
		string10  name1; // eg, RVS811_0
		string60  ModelDescription1;
		string10  type1;  // no clue what the 'type' field is intended for
		string3   score1; // actual score (eg, 500-999)
		string3   index1; // billing index; see Risk_Indicators.BillingIndex
		string4   rep_rc11; // rep reason codes and descriptions
		string150 rep_desc11;
		string4   rep_rc21;
		string150 rep_desc21;
		string4   rep_rc31;
		string150 rep_desc31;
		string4   rep_rc41;
		string150 rep_desc41;
		string4   bus_rc11; // bus reason codes and descriptions
		string150 bus_desc11;
		string4   bus_rc21;
		string150 bus_desc21;
		string4   bus_rc31;
		string150 bus_desc31;
		string4   bus_rc41;
		string150 bus_desc41;

		string10  name2; // eg, RVS811_0
		string60  ModelDescription2;
		string10  type2;  // no clue what the 'type' field is intended for
		string3   score2; // actual score (eg, 500-999)
		string3   index2; // billing index; see Risk_Indicators.BillingIndex
		string4   rep_rc12; // rep reason codes and descriptions
		string150 rep_desc12;
		string4   rep_rc22;
		string150 rep_desc22;
		string4   rep_rc32;
		string150 rep_desc32;
		string4   rep_rc42;
		string150 rep_desc42;
		string4   bus_rc12; // bus reason codes and descriptions
		string150 bus_desc12;
		string4   bus_rc22;
		string150 bus_desc22;
		string4   bus_rc32;
		string150 bus_desc32;
		string4   bus_rc42;
		string150 bus_desc42;
	END;

	export RequestEx := RECORD
		unsigned4 seq;
		string30 AcctNo;
		unsigned3 historydate;
		iesp.ws_analytics.t_SmallBusinessRiskRequest;
	END;
	export ResponseEx := RECORD
		// even though this layout no longer references iesp.ws_analytics.t_SmallBusinessRiskResponseEx,
		// it's still called ResponseEx in order to keep the testseed attribute from having to be changed
		unsigned4 seq;
		string30  AcctNo;
		iesp.ws_analytics.t_SmallBusinessRiskResponse;
	END;
  
  EXPORT ModelOptionsRec :=
    RECORD
      STRING OptionName; 
      STRING OptionValue;
    END;
  
  EXPORT AttributeGroupRec :=
    RECORD
      STRING AttributeGroup;
    END;
    
  EXPORT ModelNameRec :=
    RECORD
      STRING ModelName;
    END;
  
  EXPORT SmallBusinessBipCombinedReportIntermediateResponse := 
    RECORD
      iesp.smallbusinessbipcombinedreport.t_SmallBusinessBipCombinedReportResponse;
      DATASET(LNSmallBusiness.BIP_Layouts.IntermediateLayout) SBA_Results;
      BOOLEAN SmallBiz_SBFE_Royalty;
      UNSIGNED6 Rep_LexID;
      STRING20 LNSmallBizModelsType;
      SET OF STRING NewLNSmallBizModelsType;
    END;

END;