IMPORT ut, AutoStandardI, AutoHeaderI, doxie, Address, Vehiclev2_services, Codes;

export SearchRecords := MODULE

	setMatchFlags(IParam.searchParams srch, DATASET(Layout_Report) rpt, STRING addr182) := FUNCTION
		clnAddr := Address.CleanFields(addr182);
		STRING1 processType := Get_Experian_Data.get_processType(PROJECT(srch,IParam.polkParams),addr182);
		BOOLEAN insuranceUsage := srch.insuranceUsage;
		BOOLEAN includeDevelopedVehicles := srch.includeDevelopedVehicles;
		BOOLEAN vinStandard := processType=Constant.EXP_SRCH.VIN_STANDARD;
		BOOLEAN developedVehicle := insuranceUsage AND includeDevelopedVehicles AND vinStandard;
	
		MACsetMatchFlags() := MACRO
			BOOLEAN matchPrimRange := TRIM(clnAddr.prim_range)!='' AND TRIM(clnAddr.prim_range)=TRIM(LEFT.prim_range);
			BOOLEAN matchPrimName := TRIM(clnAddr.prim_name)!='' AND TRIM(clnAddr.prim_name)=TRIM(LEFT.prim_name);
			BOOLEAN isPoBox := LEFT.prim_name[1..7] = 'PO BOX ';
			BOOLEAN isRRTyp := LEFT.prim_name[1..3] IN ['RR ','HC '];
			BOOLEAN matchStreet := (matchPrimRange AND matchPrimName) OR ((isPoBox OR isRRTyp) AND matchPrimName);
			BOOLEAN matchCity := TRIM(clnAddr.v_city_name)!='' AND TRIM(clnAddr.v_city_name)=TRIM(LEFT.v_city_name);
			BOOLEAN matchState := TRIM(clnAddr.st)!='' AND TRIM(clnAddr.st)=TRIM(LEFT.st);
			BOOLEAN matchZip := TRIM(clnAddr.zip)!='' AND TRIM(clnAddr.zip)=TRIM(LEFT.zip5);
			BOOLEAN matchAddr := matchStreet AND ((matchCity AND matchState) OR matchZip);
			STRING fname := TRIM(srch.firstName);
			STRING lname := TRIM(srch.lastName);
			STRING cname := TRIM(srch.CompanyName);
			SELF.matchFlags.surnameFlag := IF(lname='' AND cname='','',
				IF(lname=TRIM(LEFT.lname)	OR cname=TRIM(LEFT.Append_Clean_CName),'Y','N'));
			SELF.matchFlags.fullNameFlag := IF(fname='' AND lname='','',
				IF(fname=TRIM(LEFT.fname) AND lname=TRIM(LEFT.lname),'Y','N'));
			SELF.matchFlags.addressMatchFlag := IF(TRIM(clnAddr.prim_name)='','',IF(matchAddr,'Y','N'));
			SELF := LEFT;
		ENDMACRO;

		Layout_Report setFlags(Layout_Report L) := TRANSFORM
			BOOLEAN exactVinMatch := TRIM(srch.vin_in)!='' AND TRIM(srch.vin_in)=TRIM(L.vin);
			BOOLEAN plateMatch := TRIM(srch.licensePlateNum)!='' AND TRIM(srch.licensePlateNum) IN SET(L.registrants,TRIM(reg_true_license_plate));
			BOOLEAN yearMatch := TRIM(srch.modelYear)!='' AND TRIM(srch.modelYear)=TRIM(L.model_year);
			BOOLEAN makeMatch := TRIM(srch.make)!='' AND TRIM(srch.make)=TRIM(StringLib.StringToUpperCase(L.make_desc));
			BOOLEAN modelMatch := TRIM(srch.model)!='' AND TRIM(srch.model)=TRIM(StringLib.StringToUpperCase(L.model_desc));
			BOOLEAN yearMakeModelMatch := yearMatch AND makeMatch AND modelMatch;
			BOOLEAN yearMakeMatch := yearMatch AND makeMatch;
			BOOLEAN partialVinMatch := TRIM(srch.vin_in)!='' AND stringlib.stringFind(L.vin,TRIM(srch.vin_in),1)>0;  
			BOOLEAN partialVinYearMakeModelMatch := partialVinMatch AND yearMatch AND makeMatch AND modelMatch;
			SELF.matchCode := 
				MAP(exactVinMatch => Constant.EXP_SRCH.EXACT_VIN_MATCH,
						plateMatch => Constant.EXP_SRCH.PLATE_MATCH,
						partialVinYearMakeModelMatch => Constant.EXP_SRCH.PARTIAL_VIN_YEAR_MAKE_MODEL_MATCH,
						partialVinMatch => Constant.EXP_SRCH.PARTIAL_VIN_MATCH,
						yearMakeModelMatch => Constant.EXP_SRCH.YEAR_MAKE_MODEL_MATCH,
						yearMakeMatch => Constant.EXP_SRCH.YEAR_MAKE_MATCH,
						IF(developedVehicle,Constant.EXP_SRCH.DEVELOPED_VEHICLE,''));
			SELF.registrants := PROJECT(L.registrants,TRANSFORM(assorted_layouts.Layout_registrant,MACsetMatchFlags()));
			SELF.owners := PROJECT(L.owners,TRANSFORM(assorted_layouts.Layout_owner,MACsetMatchFlags()));
			SELF.lienholders := PROJECT(L.lienholders,TRANSFORM(assorted_layouts.Layout_lienholder,MACsetMatchFlags()));
			SELF.lessees := PROJECT(L.lessees,TRANSFORM(assorted_layouts.Layout_lessee,MACsetMatchFlags()));
			SELF.lessors := PROJECT(L.lessors,TRANSFORM(assorted_layouts.layout_lessee_or_lessor,MACsetMatchFlags()));
			SELF := L;
		END;

		RETURN PROJECT(rpt,setFlags(LEFT));
	END;

	shared VehicleSearch_New(IParam.searchParams aInputData, IParam.polkParams aGatewayInputData) := FUNCTION
							
		addrInputData := MODULE(PROJECT(aInputData,IParam.searchParams,OPT))
			EXPORT STRING vin_in := '';
			EXPORT STRING ModelYear := '';
			EXPORT STRING Make := '';
			EXPORT STRING Model := '';
			EXPORT STRING LicensePlateNum := '';
			EXPORT STRING30 FirstName := '';
			EXPORT STRING30 LastName := '';
			EXPORT STRING120 Company := '';
			EXPORT STRING120 CompanyName := '';
		END;

		vehIds := SearchServiceIds(aInputData).ids; // specific vehicle
		addrIds := SearchServiceIds(addrInputData).ids; // vehicles at address
		
		// for insurance usage: mimic Experian developed vehicles when 'VIN Standard' or 'VIN Household'
		addr182 := address.GetCleanAddress(aGatewayInputData.addr,aGatewayInputData.city+' '+aGatewayInputData.state+' '+aGatewayInputData.zip,address.Components.Country.US).str_addr;
		STRING1 processType := Get_Experian_Data.get_processType(aGatewayInputData,addr182);
		BOOLEAN insuranceUsage := aInputData.insuranceUsage;
		BOOLEAN includeDevelopedVehicles := aInputData.includeDevelopedVehicles;
		BOOLEAN vinStndHousehold := processType IN [Constant.EXP_SRCH.VIN_STANDARD,Constant.EXP_SRCH.VIN_HOUSEHOLD];
		BOOLEAN developedVehicles := insuranceUsage AND includeDevelopedVehicles AND vinStndHousehold;
		
		allIds := IF(developedVehicles,vehIds+addrIds,vehIds);

		ids := sort(allIds,Vehicle_key, Iteration_Key, Sequence_key, if(is_deep_dive,1,0));
		
		grouped_ids := GROUP(ids, Vehicle_key, Iteration_key);

		deduped_ids := dedup(grouped_ids, Vehicle_key, Iteration_Key, Sequence_key);

		vehicles := Ungroup(Raw.get_vehicle_search( aInputData, 
						deduped_ids(Vehicle_key = aInputData.vehicleKey or aInputData.vehicleKey =''), aInputData.ssnMask));
		
		vehiclesAtAddress := Ungroup(Raw.get_vehicle_search( addrInputData, 
						deduped_ids(Vehicle_key = aInputData.vehicleKey or aInputData.vehicleKey =''), aInputData.ssnMask));

		// for insurance usage: set current flag for both registrants and owners
		currentVehiclesAtAddress := PROJECT(vehiclesAtAddress,TRANSFORM(Layout_Report,
			SELF.is_current := 'CURRENT' IN SET(LEFT.registrants,history_desc) + SET(LEFT.owners,history_desc);
			SELF := LEFT;));

		vehs0 := IF(developedVehicles,currentVehiclesAtAddress(is_current=TRUE),vehicles);

		rep_w_seq :=record
			Layout_report;
			unsigned2 seq;
		end;
		
		rep_w_seq add_seq(vehs0 l,integer C):=transform
			self.seq := C;
			self := l;
		END;

		vehs_wseq := project(sort(dedup(sort(vehs0, Vehicle_key,if(is_current,0,1), -iteration_key),vehicle_key),
		if(is_current,0,1),	-iteration_key), add_seq(left,counter));
	
		vehs1 := join(vehs0,vehs_wseq,left.vehicle_key=right.vehicle_key,transform(rep_w_seq,self.seq := right.seq,
			self := left));
		
		sorted_vehs := project(sort(vehs1, if(is_deep_dive,1,0),min_party_penalty, seq,-(unsigned1) is_current, -iteration_key, -Sequence_Key, record), Layout_report);
  
		Layout_Report xform_local (sorted_vehs le):=transform
			self.DataSource:=constant.local_val_out;
			self:=le;
		end;
		
		sorted_vehs_fmt:=project(sorted_vehs,xform_local(LEFT));
				
		matchFlag_vehs := setMatchFlags(aInputData,sorted_vehs_fmt,addr182);

		Local_Data := IF(~insuranceUsage,matchFlag_vehs,
			// for insurance usage: current only, sort by matched then developed, limit to max vehicles per search
			CHOOSEN(SORT(matchFlag_vehs(is_current=TRUE),IF(matchCode!=Constant.EXP_SRCH.DEVELOPED_VEHICLE,0,1),-model_year),Constant.MAX_VEHS_PER_SRCH));

		//*************************
		// Call for Gateway Data - Start
		//*************************

		dtSource := Functions.getSearchDataSource(aGatewayInputData, aInputData.doCombinedSearch);	
		Search_Request:=TRIM(stringlib.stringtouppercase(dtSource));

		BOOLEAN useAll := Search_Request = constant.ALL_val;
		BOOLEAN realTime := Search_Request = constant.realtime_val;
		BOOLEAN useExperian := ~doxie.DataPermission.use_Polk;
		STRING2 queryState := Functions.get_state(aGatewayInputData);

    exp_only_state := LIMIT (Codes.Key_Codes_V3 (keyed (file_name='EXPERIAN_GATEWAY'), keyed (field_name='INSURANCE_USAGE'),
                                                 wild (field_name2), keyed (code = queryState)), 1, SKIP);
    BOOLEAN gatewayONLY := useExperian AND insuranceUsage AND EXISTS (exp_only_state);


		aPolkInputMod := MODULE(PROJECT(aGatewayInputData,IParam.polkParams,OPT))
			EXPORT BOOLEAN noFail := useAll or aGatewayInputData.noFail or useExperian;
		END;
		aExperianInputMod := MODULE(PROJECT(aGatewayInputData,IParam.polkParams,OPT))
			EXPORT BOOLEAN noFail := useAll or aGatewayInputData.noFail or ~useExperian;
			EXPORT STRING clnAddr182 := addr182;
		END;

		Gateway_Data_:=
		MAP((useAll OR realTime) AND ~useExperian =>
					Get_Polk_Data.val(aPolkInputMod,aInputData.doCombinedSearch),
				(useAll OR realTime OR gatewayONLY) AND useExperian =>
					Get_Experian_Data.val(aExperianInputMod,aInputData.doCombinedSearch),
					DATASET([],Layout_Report_RealTime));

  // Projected the Layout back to old layout.					
     Gateway_Data :=Project(Gateway_Data_,Layout_Report);
  //The 520 error code goes into the VIN field when gateway is restricted    
     Gateway_Data_unrestricted := Gateway_Data(vin <> VehicleV2_Services.Polk_Code_Translations.ErrorCodes('520')); 
  // What failed 
     boolean isLocalEmpty := ~exists(Local_Data);
     boolean isGatewayFailed := isLocalEmpty and exists(Gateway_Data(vin = VehicleV2_Services.Polk_Code_Translations.ErrorCodes('520')));
     boolean isAllEmpty      := isLocalEmpty and ~exists(Gateway_Data);
    
    
		//*************************
		// Call for Gateway Data - End
		//*************************
		
		final_result_pre :=
		MAP(gatewayONLY => Gateway_Data_unrestricted,
				useALL =>  Gateway_Data_unrestricted & Local_Data,
				realTime => Gateway_Data_unrestricted,
				Local_Data); // LOCAL
      
    
    final_result :=  map(
           aGatewayInputData.noFail => final_result_pre, 
           isGatewayFailed          => fail(final_result_pre,1208,VehicleV2_Services.Polk_Code_Translations.ErrorCodes('1208')),
         //isAllEmpty               => fail(final_result_pre,10,Doxie.ErrorCodes(10)), /* */ 
                                       final_result_pre);
                                                            
 
   //Bug 132024 - apply new sorting rules to results (adding comment)
		//RETURN final_result; 
		RETURN sort(final_result, -MAX( MAX(owners,(unsigned4)ttl_latest_issue_date), MAX(registrants,(unsigned4)reg_latest_effective_date), 
																		MAX(owners, if((unsigned4)src_last_date = 0, (unsigned4)src_first_date, (unsigned4)src_last_date))), 
															nonDMVSource,
															min_party_penalty, 
															Vehicle_Key);
	END;
	
	SHARED  getCombinedRecords(IParam.searchParams aInputData) :=FUNCTION			

    mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
      EXPORT unsigned1 glb := aInputData.glbpurpose;
	    EXPORT unsigned1 dppa := aInputData.dppapurpose;	
      EXPORT string DataPermissionMask := aInputData.DataPermissionMask;
      EXPORT boolean ln_branded := aInputData.lnbranded;
      EXPORT string5 industry_class := aInputData.industryclass; 
      EXPORT string32 application_type := aInputData.applicationtype;
      EXPORT string ssn_mask := aInputData.ssnmask; 
      EXPORT unsigned1 dl_mask :=	IF (aInputData.dl_mask, 1, 0);
		END;	

		STRING PermissibleUse:=Polk_Code_Translations.RealTimePermissibleUse(aInputData.RealTimePermissibleUse);
		
		tempmod:= module(project(aInputData,IParam.polkParams))					
		end;
		
		/* polk search operation based on the search arguments in tempmod and PermissibleUse */
		STRING polkOperation := Get_Polk_Data.Operation(tempmod, PermissibleUse);
		
		/* polkOperation = 0 means that input search criteria does not the type of operation 
					allowed by POLK, 
				Also if the permissble type is in POLK_PERMISSIBLE_NOT_NAMEADDR it should to search
				best data because name and address will not be permissible by POLK, sample is SSN */
		BOOLEAN isBestDataSearch := LENGTH(TRIM(polkOperation)) = 0 AND tempmod.ssn != '' AND
					PermissibleUse not in Constant.POLK_PERMISSIBLE_NOT_NAMEADDR;
				
		bestRecords := doxie.best_records(AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do (aInputData),
			                                doSuppress := false, includeDOD:=true, modAccess := mod_access);
		
		dids := project(bestRecords, doxie.layout_references_hh);
		
		validSSN := doxie.header_records_byDID(dids)(valid_ssn='G');
		
		dedupValidSSN := dedup(sort(validSSN, did), did);

		
		dedupBestRecords := if (COUNT(dedupValidSSN) = 1, BestRecords(did = dedupValidSSN[1].did), BestRecords);
		
		uniqueBestRecords := COUNT(bestRecords) = 1;
		
		/* only search header if the best records does not return unique records */
		polkSearchRecords := IF (isBestDataSearch  
															, IF (uniqueBestRecords, bestRecords, dedupBestRecords)
															, dataset([], doxie.layout_best));
		
		tempmodBestData := module(project(aInputData,IParam.polkParams,opt))			
			export string30 firstname := polkSearchRecords[1].fname;
			export string30 middlename := polkSearchRecords[1].mname;
			export string30 lastname := polkSearchRecords[1].lname;	
			export string200 addr := Address.Addr1FromComponents(polkSearchRecords[1].prim_range, 
						polkSearchRecords[1].predir,
						polkSearchRecords[1].prim_name,
						polkSearchRecords[1].suffix,
						polkSearchRecords[1].postdir,
						polkSearchRecords[1].unit_desig,
						polkSearchRecords[1].sec_range);								
			export string25 city := polkSearchRecords[1].city_name;
			export string2 state := polkSearchRecords[1].st;
			export string6 zip := polkSearchRecords[1].zip;		
			export string datasource := IF (isBestDataSearch, aInputData.dataSource, Constant.LOCAL_VAL);
		end;
//		OUTPUT('searching polk ' + tempmodBestData.LASTNAME + ' ' + tempmodBestData.ADDR + tempmodBestData.STATE + ' ' + tempmodBestData.DATASOURCE);
		resultBest :=  VehicleSearch_New(aInputData, tempmodBestData);
		
		result := VehicleSearch_New(aInputData, tempmod);
		
		BOOLEAN isResultFromBestData := isBestDataSearch AND COUNT(polkSearchRecords) = 1 AND aInputData.doCombinedSearch;

		returnResult := IF (isResultFromBestData , resultBest, result);
		
		/*  If fails if it is the new behavior for search and 
		    it cannot unique identify a person in best file (count(bestRecords)) */
				
		RETURN IF (aInputData.doCombinedSearch and aInputData.datasource != Constant.LOCAL_VAL and count (polkSearchRecords) > 1
      ,fail (dataset([], VehicleV2_Services.Layout_Report), 320, Polk_Code_Translations.ErrorCodes('320')) // 320
			, returnResult);
		
	END;
	
	EXPORT getVehicleRecords(IParam.searchParams aInputData) := FUNCTION		
		// output('Name: ' + aInputData.firstname + ' ' + aInputData.lastname + ' Address: ' + aInputData.addr + 
		// ' City: ' + aInputDAta.city + ' State: ' + aInputData.state + ' doCombined: ' + aInputData.doCombinedSearch + ' datasource: ' + aInputData.datasource);
		outputRecords := getCombinedRecords(aInputData);		
		
		// apply county post-filtering
		tmp_state := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(aInputData,AutoStandardI.InterfaceTranslator.state_value.params));
		tmp_county := AutoStandardI.InterfaceTranslator.county_value.val(PROJECT(aInputData,AutoStandardI.InterfaceTranslator.county_value.params));
		do_county_filt := map(
			tmp_county=''	=> false,
			tmp_state=''	=> error(301, doxie.ErrorCodes(301) + ' - State required to search by County'),
			true
		);
		filtRecords := if(
			do_county_filt,
			outputRecords(tmp_county in (set(registrants,county_name) + set(owners,county_name) + set(lienholders,county_name) + set(lessees,county_name) + set(lessors,county_name))),
			outputRecords
		);
		
		RETURN filtRecords;
	END;
		
END;
