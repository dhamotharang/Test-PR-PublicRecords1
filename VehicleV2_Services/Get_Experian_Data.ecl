IMPORT iesp,AutoStandardI,Address,doxie,Gateway,VehicleV2_Services;

EXPORT Get_Experian_Data := MODULE

	EXPORT get_processType(IParam.polkParams in_mod, STRING addr182) := FUNCTION
		clnAddr := Address.CleanFields(addr182);
		BOOLEAN hasName := TRIM(in_mod.lastname)!='' OR TRIM(in_mod.companyname)!='';
		BOOLEAN hasPrimRange := TRIM(clnAddr.prim_range)!='';
		BOOLEAN hasPrimName := TRIM(clnAddr.prim_name)!='';
		BOOLEAN isPoBox := clnAddr.prim_name[1..7] = 'PO BOX ';
		BOOLEAN isRRTyp := clnAddr.prim_name[1..3] IN ['RR ','HC '];
		BOOLEAN hasCSZ := TRIM(clnAddr.p_city_name)!='' AND TRIM(clnAddr.st)!='' AND TRIM(clnAddr.zip)!='';
		BOOLEAN hasAddr := (hasPrimRange AND hasPrimName AND hasCSZ) OR (isRRTyp AND hasCSZ) OR	(isPoBox AND hasCSZ);
		BOOLEAN hasNameAddr	:= hasName AND hasAddr;
		BOOLEAN hasPlateState := TRIM(in_mod.LicensePlateNum)!='' AND TRIM(functions.get_state(in_mod))!='';
		BOOLEAN hasVin := TRIM(in_mod.vin_in)!='';
		STRING1 processType := 
		MAP(hasNameAddr AND hasVin => Constant.EXP_SRCH.VIN_STANDARD,
				hasPlateState => Constant.EXP_SRCH.PLATE_ONLY,
				hasNameAddr => IF(in_mod.authenticationUsage,Constant.EXP_SRCH.AUTHENTICATION,Constant.EXP_SRCH.VIN_HOUSEHOLD),
				hasVin => Constant.EXP_SRCH.VIN_ONLY,
				'');
		RETURN processType;
	END;

	EXPORT val(IParam.polkParams in_mod, BOOLEAN doCombined=FALSE) := FUNCTION
		// STRING serviceURL := 'http://webapp_roxie_test:[PASSWORD_REDACTED]@10.194.9.67:8082/';
		// STRING serviceURL := 'http://webapp_roxie_test:[PASSWORD_REDACTED]@10.194.5.12:5004/';		
		gateway_cfg					 := Gateway.Configuration.Get();
		// to be on the safe side, make sure we're always dealing with only one RTV gateway URL.
		experian_gateway_cfg := gateway_cfg(~doxie.DataPermission.use_Polk, Gateway.Configuration.IsExperian(servicename));	
		
		dppa := Exp_Code_Translations.get_dppa(in_mod.RealTimePermissibleUse);		

		STRING2 state := functions.get_state(in_mod);
		STRING64 cityStateZip := TRIM(in_mod.city)+' '+state+' '+TRIM(in_mod.zip);
		addr182 := IF(in_mod.clnAddr182!='',in_mod.clnAddr182,
			address.GetCleanAddress(TRIM(in_mod.addr),cityStateZip,address.Components.Country.US).str_addr);
		clnAddr := Address.CleanFields(addr182);
		STRING1 process_type := get_processType(in_mod,addr182);
		BOOLEAN isPoBox := clnAddr.prim_name[1..7] = 'PO BOX ';
		BOOLEAN isRRTyp := clnAddr.prim_name[1..3] IN ['RR ','HC '];

		iesp.experian_vin.t_ExperianVinRequest setVinReq() := TRANSFORM
			SELF.User.ReferenceCode := TRIM(in_mod.ReferenceCode);
			SELF.User.BillingCode := TRIM(in_mod.BillingCode);
			SELF.User.QueryID := TRIM(in_mod.QueryId);
			SELF.User.GLBPurpose := TRIM((STRING)in_mod.GLBPurpose);
			SELF.User.DLPurpose := TRIM((STRING)in_mod.DPPAPurpose);
			SELF.Options := [];
			SELF.getVinVerifyPlus.quoteback := 'quoteback';// default?
			SELF.getVinVerifyPlus.dppaUseCode := dppa[1].useCode;
			SELF.getVinVerifyPlus.dppaSubCategoryCode := dppa[1].subCategoryCode;
			STRING SubCustomerID := TRIM(in_mod.SubCustomerID);
			SELF.getVinVerifyPlus.SubCustomerId := IF(SubCustomerID!='',SubCustomerID,'BR');
			SELF.getVinVerifyPlus.processType := process_type;
			SELF.getVinVerifyPlus.inquiryType := IF(TRIM(in_mod.companyname)!='','2','1');
			SELF.getVinVerifyPlus.firstName := TRIM(in_mod.firstname);
			SELF.getVinVerifyPlus.middleName := TRIM(in_mod.middlename);
			SELF.getVinVerifyPlus.lastName := TRIM(in_mod.lastname);
			SELF.getVinVerifyPlus.nameSuffix := TRIM (in_mod.name_suffix);
			SELF.getVinVerifyPlus.firmBusinessName := TRIM(in_mod.companyname);
			SELF.getVinVerifyPlus.addressType := clnAddr.rec_type;
			SELF.getVinVerifyPlus.range := clnAddr.prim_range;
			SELF.getVinVerifyPlus.preDirectional := clnAddr.predir;
			SELF.getVinVerifyPlus.streetName := IF(~isPoBox AND ~isRRTyp,clnAddr.prim_name,'');
			SELF.getVinVerifyPlus.addressSuffix := clnAddr.addr_suffix;
			SELF.getVinVerifyPlus.postDirectional := clnAddr.postdir;
			SELF.getVinVerifyPlus.pob := IF(isPoBox,clnAddr.prim_name[8..],'');
			SELF.getVinVerifyPlus.ruralRouteNumber := IF(isRRTyp,clnAddr.prim_name[3..],'');
			SELF.getVinVerifyPlus.ruralRouteBox := IF(isRRTyp,clnAddr.sec_range,'');
			SELF.getVinVerifyPlus.apartmentNumber := IF(isRRTyp,'',clnAddr.sec_range);
			SELF.getVinVerifyPlus.city := clnAddr.p_city_name;
			SELF.getVinVerifyPlus.state := clnAddr.st;
			SELF.getVinVerifyPlus.zipCode := clnAddr.zip;
			SELF.getVinVerifyPlus.zipFour := clnAddr.zip4;
			SELF.getVinVerifyPlus.vin := TRIM(in_mod.vin_in);
			SELF.getVinVerifyPlus.year := TRIM(in_mod.ModelYear);
			SELF.getVinVerifyPlus.make := TRIM(in_mod.Make);
			SELF.getVinVerifyPlus.model := TRIM(in_mod.Model);
			SELF.getVinVerifyPlus.plateNumber := TRIM(in_mod.LicensePlateNum);
			SELF.getVinVerifyPlus.plateState := state;
			SELF := [];
		END;

		vinReq := DATASET([setVinReq()]);

		dataSource := TRIM(stringlib.stringtouppercase(in_mod.DataSource));	
		BOOLEAN validInput := process_type!='';
		// prevent query from hitting gateway if no permitted use detected
		BOOLEAN non_covered := ~Exp_Code_Translations.get_permittedUse(state,dppa);
		emptyResponse := DATASET([],iesp.experian_vin.t_ExperianVinResponseEx);
		realTime := [constant.realtime_val,constant.all_val,constant.report_val];
		string PermissibleUse := dppa[1].useCode + dppa[1].subCategoryCode;
		
		// changing the logic below to be as close as possible to the one used in Get_Polk_Data.
		vMakeGWCall := experian_gateway_cfg[1].Url !='' and permissibleUse != '' and dataSource in realtime;
		vinRespEx :=
					if(non_covered and dataSource in realtime
						,if(~in_mod.noFail
							,fail(emptyResponse,1208,Polk_Code_Translations.ErrorCodes('1208'))
							,emptyResponse
						)
					,if(validInput
						,if(vMakeGWCall
								,Gateway.SoapCall_Experian(vinReq, experian_gateway_cfg[1],,,vMakeGWCall) 
							,if(dataSource=constant.realtime_val and ~in_mod.noFail
								,if(permissibleUse=''
									,fail(emptyResponse,500,Polk_Code_Translations.ErrorCodes('500'))
									,fail(emptyResponse,510,VehicleV2_Services.Polk_Code_Translations.ErrorCodes('510')))
								,emptyResponse
							)
						)
						,if((dataSource=constant.realtime_val OR (doCombined AND dataSource!=constant.local_val)) AND ~in_mod.noFail
											,FAIL(emptyResponse,310,VehicleV2_Services.Polk_Code_Translations.ErrorCodes('310'))
											,emptyResponse)
							)
						);
						
		vinResp  := PROJECT(vinRespEx,TRANSFORM(iesp.experian_vin.t_getVinVerifyPlusResponse,SELF:=LEFT.Response.Response));
		vehicles := NORMALIZE(vinResp,LEFT.Vehicles,TRANSFORM(iesp.experian_vin.t_VehicleStruct,SELF:=RIGHT));
		vinSrcSt := PROJECT(vehicles,TRANSFORM(VehicleV2_Services.Layout_Vehicle_Vin,SELF.VIN:=LEFT.VIN,SELF.state_origin:=LEFT.sourceState));
		vinaData := VehicleV2_Services.Get_Polk_Vina_Data(vinSrcSt);

		vinaLayout := RECORD
			RECORDOF(vehicles);
			RECORDOF(vinaData) AND NOT [matchCode,VIN];
			UNSIGNED1	pen := 0;
		END;

		vinaLayout addVinaData(vehicles L, vinaData R) := TRANSFORM
			tm := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,OPT))
				EXPORT fname_field := L.RegisteredOwners[1].firstName;
				EXPORT mname_field := L.RegisteredOwners[1].middleName;
				EXPORT lname_field := L.RegisteredOwners[1].lastName;
				EXPORT allow_wildcard := FALSE;
			END;
			SELF.pen := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);			
			SELF := L;
			SELF := R;			
		END;

		joinData := JOIN(vehicles,vinaData,LEFT.VIN=RIGHT.VIN,addVinaData(LEFT,RIGHT),
			LEFT OUTER,KEEP(1),LIMIT(VehicleV2_Services.Constant.MAX_VEHS_PER_SRCH,SKIP));

		VehicleV2_Services.assorted_layouts.Layout_registrant xformRegistrants(vinaLayout L,INTEGER C) := TRANSFORM
			SELF.fname := IF(TRIM(L.RegisteredOwners[C].nameRole)='OWNER',L.RegisteredOwners[C].firstName,SKIP);
			SELF.mname := L.RegisteredOwners[C].middleName;
			SELF.lname := L.RegisteredOwners[C].lastName;
			SELF.name_suffix := L.RegisteredOwners[C].nameSuffix;
			SELF.append_clean_cname := L.RegisteredOwners[C].orgName;
			SELF.prim_range := L.address.range;
			SELF.predir := L.address.preDirectional;
			SELF.prim_name :=
			MAP(TRIM(L.address.POB)!='' => 'PO BOX '+L.address.POB,
					TRIM(L.address.ruralRouteNumber)!='' => 'RR '+L.address.ruralRouteNumber,
					L.address.streetName);
			SELF.addr_suffix := L.address.suffix;
			SELF.postdir := L.address.postDirectional;
			SELF.unit_desig := IF(TRIM(L.address.ruralRouteBox)!='','BOX',L.address.secondDesignation);
			SELF.sec_range := IF(TRIM(L.address.ruralRouteBox)!='',L.address.ruralRouteBox,L.address.secondRange);;
			SELF.v_city_name := L.address.cityName;
			SELF.st := L.address.state;
			SELF.zip5 := L.address.zip;
			SELF.zip4 := L.address.zipFour;
			SELF.reg_latest_effective_date := stringlib.StringFilter(TRIM(L.lastTitleRegDate),'0123456789');
			SELF.reg_latest_expiration_date := stringlib.StringFilter(TRIM(L.registrationExpireDate),'0123456789');
			SELF.reg_true_license_plate := L.plateNumber;
			SELF.reg_license_plate := L.plateNumber;
			SELF.reg_license_plate_type_code := L.plateTypeCode;
			SELF.reg_license_plate_type_desc := Exp_Code_Translations.plate_type_description(L.plateTypeCode);
			SELF.reg_license_state := L.plateState;
			SELF.matchFlags.surnameFlag := IF(L.RegisteredOwners[C].surnameFlag='',' ',L.RegisteredOwners[C].surnameFlag);
			SELF.matchFlags.fullNameFlag := IF(L.RegisteredOwners[C].fullNameFlag='',' ',L.RegisteredOwners[C].fullNameFlag);
			SELF.matchFlags.addressMatchFlag := IF(TRIM(L.addressMatchFlag)='',' ',L.addressMatchFlag);
			SELF.name_source_cd := L.RegisteredOwners[C].nameSourceCd;
			SELF.name_source := Exp_Code_Translations.name_source_cd_description(L.RegisteredOwners[C].nameSourceCd);
			SELF.title_issue_date := stringlib.StringFilter(TRIM(L.titleIssueDate),'0123456789');
			SELF.title_number := L.titleNumber;
			SELF.reported_name := L.RegisteredOwners[C].ReportedName;
			SELF:=[];
		END;

		VehicleV2_Services.assorted_layouts.Layout_lienholder xformLienholder(vinaLayout L,INTEGER C) := TRANSFORM
			SELF.orig_name := IF(TRIM(L.RegisteredOwners[C].nameRole)='LIENHOLDER',L.RegisteredOwners[C].orgName,SKIP);
			SELF.fname := L.RegisteredOwners[C].firstName;
			SELF.mname := L.RegisteredOwners[C].middleName;
			SELF.lname := L.RegisteredOwners[C].lastName;
			SELF.name_suffix := L.RegisteredOwners[C].nameSuffix;
			SELF.append_clean_cname := L.RegisteredOwners[C].orgName;
			SELF.matchFlags.surnameFlag := IF(L.RegisteredOwners[C].surnameFlag='',' ',L.RegisteredOwners[C].surnameFlag);
			SELF.matchFlags.fullNameFlag := IF(L.RegisteredOwners[C].fullNameFlag='',' ',L.RegisteredOwners[C].fullNameFlag);
			SELF.name_source_cd := L.RegisteredOwners[C].nameSourceCd;
			SELF.name_source := Exp_Code_Translations.name_source_cd_description(L.RegisteredOwners[C].nameSourceCd);
			SELF:=[];
		END;

		VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor xformLessor(vinaLayout L,INTEGER C) := TRANSFORM
			SELF.orig_name := IF(TRIM(L.RegisteredOwners[C].nameRole)='LESSOR',L.RegisteredOwners[C].orgName,SKIP);
			SELF.fname := L.RegisteredOwners[C].firstName;
			SELF.mname := L.RegisteredOwners[C].middleName;
			SELF.lname := L.RegisteredOwners[C].lastName;
			SELF.name_suffix := L.RegisteredOwners[C].nameSuffix;
			SELF.append_clean_cname := L.RegisteredOwners[C].orgName;
			SELF.matchFlags.surnameFlag := IF(L.RegisteredOwners[C].surnameFlag='',' ',L.RegisteredOwners[C].surnameFlag);
			SELF.matchFlags.fullNameFlag := IF(L.RegisteredOwners[C].fullNameFlag='',' ',L.RegisteredOwners[C].fullNameFlag);
			SELF.name_source_cd := L.RegisteredOwners[C].nameSourceCd;
			SELF.name_source := Exp_Code_Translations.name_source_cd_description(L.RegisteredOwners[C].nameSourceCd);
			SELF:=[];
		END;		
					
		VehicleV2_Services.assorted_layouts.layout_brand xformBrand(iesp.experian_vin.t_VehicleBrandsStruct L) := TRANSFORM
			SELF.Brand_Date := stringlib.stringfilter(trim(L.brandDate),'0123456789'),
			SELF.Brand_State := L.brandState,
			SELF.Brand_Code := L.brandCode,
			SELF.Brand_Type := Exp_Code_Translations.get_brandType(L.brandCode)
		END;

			VehicleV2_Services.Layout_Report_Realtime xformReport(vinaLayout L) := TRANSFORM,
			SKIP(~in_mod.includeDevelopedVehicles AND L.matchCode='D')
			SELF.is_current := TRUE;
			SELF.matchCode := L.matchCode;
			SELF.dataSource := constant.realtime_val_out;
			SELF.state_origin := L.sourceState;
			SELF.vin := L.vin;
			SELF.model_year := L.modelYear;
			SELF.make_desc := IF(TRIM(L.make_desc)!='',L.make_desc,L.makeText);
			SELF.vehicle_type_desc := IF(TRIM(L.vehicle_type_desc)!='',L.vehicle_type_desc,L.modelClassText);
			SELF.model_desc := IF(TRIM(L.model_desc)!='',L.model_desc,L.modelText);
			SELF.body_style_desc := IF(TRIM(L.body_style_desc)!='',L.body_style_desc,L.bodyStyle);
			SELF.major_color_desc := L.primaryColor;
			SELF.minor_color_desc := L.secondaryColor;
			own := DATASET([L],vinaLayout);
			cnt := COUNT(L.RegisteredOwners);
			SELF.matched_party := [];
			SELF.registrants := CHOOSEN(NORMALIZE(own,cnt,xformRegistrants(LEFT,COUNTER)),Constant.MAX_CHILD_COUNT);
			SELF.lienholders := CHOOSEN(NORMALIZE(own,cnt,xformLienholder(LEFT,COUNTER)),Constant.MAX_CHILD_COUNT);
			SELF.lessors := CHOOSEN(NORMALIZE(own,cnt,xformLessor(LEFT,COUNTER)),Constant.MAX_CHILD_COUNT);
			SELF.brands := CHOOSEN(PROJECT(L.VehicleBrands, xformBrand(LEFT)), Constant.MAX_BRANDS_PER_VEHICLE);
			SELF.documenttypecode := L.documentTypeCode;
			SELF.safety_type:= L.safetytype;
			SELF.airbags := L.airbag;
			SELF.tod_flag := L.tod;
			SELF.min_door_count := L.doorCount;
			SELF.airbag_driver := L.driverairbag;
			SELF.airbag_front_driver_side := L.frontdriversideairbag;
			SELF.airbag_front_head_curtain := L.frontheadcurtainairbag;
			SELF.airbag_front_pass := L.frontpassengerairbag;
			SELF.airbag_front_pass_side := L.frontpassengersideairbag;
			SELF := L;
		END;

		vinReport := PROJECT(joinData,xformReport(LEFT));

		// #65577 YEAR/MAKE not filtering NAME/ADDR searches when provided
		// We need the filter below because, when YEAR/MAKE is provided, Experian returns ALL vehicles 
		// titled/registered at the input address, whereas Polk only returns the matched vehicle.
		// #121147 Since both Polk and Experian will 'loose' match against the input make, filtering by exact 
		// name may cause some valid records to be dropped (e.g. Harley Davidson vs. Harley-Davidson). I'm 
		// changing the code to match against the first 5 characters instead to alleviate that problem a little bit. 
		// A more comprehensive solution would probably involve including the make field when penalizing the records. 
		nameAddr := [Constant.EXP_SRCH.VIN_STANDARD,Constant.EXP_SRCH.VIN_HOUSEHOLD];
		vinRpt := IF(process_type IN nameAddr AND in_mod.ModelYear!='' AND in_mod.Make!='',
			vinReport(model_year=in_mod.ModelYear AND make_desc[1..5]=in_mod.Make[1..5]),vinReport);	

		STRING1 gatewayDataCode := PROJECT(vinResp,TRANSFORM({STRING1 DataCode},SELF.DataCode:=LEFT.noDataCode))[1].DataCode;
		STRING1 gatewayErrorCode := PROJECT(vinResp,TRANSFORM({STRING1 ErrorCode},SELF.ErrorCode:=LEFT.errorIndicator))[1].ErrorCode;
		STRING1 gatewayCode := MAP(
			gatewayErrorCode!='' => gatewayErrorCode,
			gatewayDataCode!='' => gatewayDataCode,'');

		Layout_Report_Realtime nonCovered(iesp.experian_vin.t_ExperianVinRequest L) := transform
			self.DataSource := constant.Realtime_val_out;
			self.vin := Polk_Code_Translations.ErrorCodes('520'); // RESTRICTED
			self := [];
		end;

		emptyRpt := DATASET([],Layout_Report_Realtime);
		results := IF(gatewayErrorCode='',
									if(non_covered, project(vinReq, nonCovered(left)), vinRpt),
									IF(dataSource=constant.realtime_val AND ~in_mod.noFail OR doCombined
											,FAIL(vinRpt,TRANSFER(gatewayErrorCode,UNSIGNED1),Exp_Code_Translations.errorIndicator(gatewayErrorCode)[1].msg)
											,emptyRpt
										)
									);
		ds_blank := DATASET([],Exp_Code_Translations.errCdMsg);
		ds_msg_val := IF(gatewayCode!='' AND dataSource=constant.report_val,Exp_Code_Translations.noDataCode(gatewayCode),ds_blank);
		ds_val := IF(doCombined OR dataSource=Constant.LOCAL_VAL,ds_blank,ds_msg_val);
		// OUTPUT to NAMED('MessageCodes') matched to VehicleV2_Services.Get_Polk_Data
		ds_tmp := PROJECT(ds_val,TRANSFORM({INTEGER code,STRING200 msg},SELF.code:=TRANSFER(LEFT.code,INTEGER1),SELF:=LEFT));
		OUTPUT(ds_tmp,NAMED('MessageCodes'),EXTEND);

		// All the outputs 
		// output(vinResp,NAMED('vinResp'));				
		// output(vehicles,NAMED('vehicles'));
		// output(vinaData,NAMED('vinaData'));
		// output(joinData,NAMED('joinData'));
		// output(vinSrcSt,NAMED('vinSrcSt'));
		// output(vinReport,NAMED('vinReport'));
		// output(vinRpt,NAMED('vinRpt'));

		RETURN results;
	END;

END;
