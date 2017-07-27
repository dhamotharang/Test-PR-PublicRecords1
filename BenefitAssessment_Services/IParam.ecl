IMPORT address, BatchShare, gateway, suppress, iesp, ut;

EXPORT IParam := MODULE

	EXPORT batch_params := interface (BatchShare.IParam.BatchParams)
			export boolean include_sex_offenders := FALSE ;
			export boolean include_assets_and_wealth := FALSE ;
			export boolean include_criminal_derogatory := FALSE ;
			export boolean include_family_comp := FALSE ;
			export integer property_return_count:= 3 ;
			export integer property_transfer_period:= 12 ;
	end;
  
	EXPORT SetInputSearchBy (iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchBy searchBy) := FUNCTION
		iesp.ECL2ESP.SetInputName (global(searchBy).Name, true);
    iesp.ECL2ESP.SetInputAddress (global(searchBy).Address);
		RETURN OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;
	
	EXPORT SetInputSearchOptions (iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchOptions options) := FUNCTION	
		iesp.ECL2ESP.SetInputSearchOptions(options);	  
		iesp.ECL2ESP.Marshall.Mac_Set(options);
		return OUTPUT (dataset ([],{integer x}), named('__internal__'), extend);
  END;	
	EXPORT getSearchModule(iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchOptions options, integer1 nss) := FUNCTION
	  batch_params_mod		:= BatchShare.IParam.getBatchParams();
    tempmod := module(project(batch_params_mod, batch_params, opt))
	  	EXPORT dataset (Gateway.layouts.config) gateways 	:= Gateway.Configuration.Get();	
		  EXPORT integer1 non_subject_suppression := nss;
	  	EXPORT BOOLEAN include_sex_offenders := options.IncludeSexOffenderData;
		  EXPORT BOOLEAN include_assets_and_wealth := options.IncludeAssetsAndWealth;
		  EXPORT BOOLEAN include_criminal_derogatory := options.IncludeCriminalDerogatory;
		  EXPORT BOOLEAN include_family_comp := options.IncludeFamilyComp;
		  EXPORT integer property_return_count:= options.PropertyReturnCount;
		  EXPORT integer property_transfer_period:= options.PropertyTransferPeriod;	
	  END;
	  RETURN tempMod;
	END;
	EXPORT GetInput(iesp.benefitassessment_fcra.t_FcraBenefitAssessSearchBy search_By) := FUNCTION
		in_streetaddr := address.Addr1FromComponents(search_by.Address.StreetNumber,
		                                             search_by.Address.StreetPreDirection,
																								 search_by.Address.streetName,
																								 search_by.Address.StreetSuffix,
																								 search_by.Address.StreetPostDirection,
																								 search_by.Address.UnitDesignation,
																								 search_by.Address.UnitNumber);
    string60 in_streetAddress1 := IF(search_by.Address.StreetAddress1='',in_streetAddr,search_by.Address.StreetAddress1);
    string60 in_streetAddress2 := search_by.Address.StreetAddress2;
    string searchAddress := trim (in_streetAddress1) + ' ' + trim (in_streetAddress2);
		
// create 1 row batch request format/layout
	  BenefitAssessment_Services.Layouts.Batch_In createBatchInput() := TRANSFORM
		  SELF.name_First  := search_by.Name.first;//firstN
		  SELF.name_Middle := search_by.Name.middle;//middleN
		  SELF.name_Last 	 := search_by.Name.last; //lastN
		  SELF.Addr        := searchAddress;//addr
		  SELF.Prim_Range := search_by.Address.StreetNumber;
		  SELF.predir :=  search_by.Address.StreetPreDirection;
		  SELF.prim_name := search_by.Address.StreetName;
		  SELF.addr_suffix := search_by.Address.StreetSuffix;
		  SELF.postdir := search_by.Address.StreetPostDirection;
		  SELF.unit_desig := search_by.Address.UnitDesignation;
		  SELF.sec_range := search_by.Address.UnitNumber;
		  SELF.p_city_name := search_by.Address.City;
		  SELF.st := search_by.Address.State;
		  SELF.z5 := search_by.Address.Zip5;
		  SELF.dob := iesp.ECL2ESP.t_DateToString8(search_by.DOB);
		  SELF.DID := (INTEGER)search_by.UNIQUEID;
		  SELF.ssn := search_by.SSN;
		  SELF.INPUT_STATE := search_by.inputState;
		  SELF.homephone := search_by.homephone;
		  SELF.workphone := search_by.workphone;
		  SELF := [];
	  END;		
 	  ds_xml_in := dataset([createBatchInput()]);
		//Upper Case, add acctno, and clean input address 
  	BatchShare.MAC_SequenceInput(ds_xml_in, ds_xml_in_seq);		
	  BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_capital);
    BatchShare.MAC_CleanAddresses(ds_capital, ds_batch_in);
	
	  RETURN ds_batch_in;
	END;
END;