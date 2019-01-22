IMPORT AutoStandardI,Address,ut, std;

EXPORT RealTime_Batch_Service_Records(DATASET(Batch_Layout.RealTime_InLayout) inputData,UNSIGNED1 Operation,Boolean GatewayNameMatch = False,Boolean Is_UseDate = False) := FUNCTION

	inputParams := AutoStandardI.GlobalModule();

	layoutAcctNoRpt := RECORD
		Batch_Layout.RealTime_InLayout.AcctNo;
		VehicleV2_Services.Layout_Report_RealTime;
	END;

	layoutAcctNoChildRpt := RECORD
		Batch_Layout.RealTime_InLayout.AcctNo;
		DATASET(layoutAcctNoRpt) gatewayData {MAXCOUNT(Constant.max_child_count)};
	END;

	Batch_Layout.RealTime_InLayout vinOnly(Batch_Layout.RealTime_InLayout L) := TRANSFORM
		SELF.acctNo := L.acctNo;
		SELF.vinIn := L.vinIn;
		SELF := [];
	END;

	Batch_Layout.RealTime_InLayout plateStateOnly(Batch_Layout.RealTime_InLayout L) := TRANSFORM
		SELF.acctNo := L.acctNo;
		SELF.plate  := L.plate;
		SELF.st     := IF(L.plateState<>'',L.plateState,L.st);
		SELF := [];
	END;

	layoutAcctNoChildRpt vehicleGateway(Batch_Layout.RealTime_InLayout L) := TRANSFORM
		BOOLEAN fullName := L.name_full != '' AND L.name_last = '';
		cln := address.CleanNameFields(address.CleanPerson73(L.name_full));
		tempmod := MODULE(PROJECT(inputParams,VehicleV2_Services.IParam.polkParams,opt))
			EXPORT STRING30  firstName := IF(fullName,cln.fName,L.name_first);
			EXPORT STRING30  middleName := IF(fullName,cln.mName,L.name_middle);
			EXPORT STRING30  lastName := IF(fullName,cln.lName,L.name_last);
			EXPORT STRING    name_Suffix := IF(fullName,cln.name_suffix,L.name_suffix);
			EXPORT STRING120 companyName := L.comp_name;
			EXPORT STRING200 addr := TRIM(L.addr1) + ' ' + L.addr2;
			EXPORT STRING25  city := L.p_city_name;
			EXPORT STRING2   state := IF(L.st<>'',L.st,L.plateState);
			EXPORT STRING6   zip := L.z5;
			EXPORT STRING    licensePlateNum := L.plate;
			EXPORT STRING    vin_In := L.vinIn;
			EXPORT STRING    modelYear := L.year;
			EXPORT STRING    make := stringlib.stringtouppercase(trim(L.make, left, right));
			EXPORT STRING    model := stringlib.stringtouppercase(trim(L.model, left, right));
			EXPORT STRING50	 ReferenceCode := '' : STORED('ReferenceCode');
			EXPORT STRING20	 BillingCode := '' : STORED('BillingCode');
			EXPORT STRING50	 QueryId := '' : STORED('QueryId');
			EXPORT STRING    RealTimePermissibleUse := '' : STORED('RealTimePermissibleUse');
			EXPORT STRING    SubCustomerID := '' : STORED('SubCustomerID');
			EXPORT STRING    DataSource := VehicleV2_Services.Constant.Realtime_val;
			EXPORT BOOLEAN   noFail := TRUE;
		END;
		validAddr := (L.addr1+L.p_city_name+L.st+L.z5)!='';
		validInput := validAddr OR L.vinIn!='' OR (L.plate+L.plateState)!='';
		gatewayData := IF(validInput,CHOOSEN(SORT(VehicleV2_Services.Get_Gateway_Data(tempmod),
									-registrants[1].reg_latest_effective_date,-registrants[1].reg_latest_expiration_date),
									Constant.max_child_count),DATASET([],Layout_Report_RealTime));

		BOOLEAN filterByDate := LENGTH(TRIM(L.date))=8;
		BOOLEAN filterByYear := LENGTH(TRIM(L.date))=4;
			
		filtered_gateways := MAP(filterByDate => MAP(Is_UseDate => gatewayData(L.date BETWEEN Functions_RTBatch_V2.min_date(registrants[1].reg_latest_effective_date , registrants[1].reg_earliest_effective_date) 
																								 AND registrants[1].reg_latest_expiration_date)
																																 ,gatewayData(L.date BETWEEN registrants[1].reg_latest_effective_date 
																								 AND registrants[1].reg_latest_expiration_date)),
														 filterByYear => MAP(Is_UseDate => gatewayData(L.date BETWEEN Functions_RTBatch_V2.min_date(registrants[1].reg_latest_effective_date[1..4] , registrants[1].reg_earliest_effective_date[1..4]) 
																								 AND registrants[1].reg_latest_expiration_date[1..4])
																																 ,gatewayData(registrants[1].reg_latest_effective_date[1..4] >= L.date))
												,gatewayData);
   // filters records based on name.														
   filtered := if(GatewayNameMatch AND L.name_first<>'' AND L.name_last<>'',filtered_gateways(
			 stringLib.stringToUpperCase(TRIM(L.name_first[1])) IN [registrants[1].fname[1],registrants[2].fname[1]]
	 AND stringLib.stringToUpperCase(TRIM(L.name_last)) IN [registrants[1].lname ,registrants[2].lname]),filtered_gateways);	 
	 

		BOOLEAN restricted := Polk_Code_Translations.ErrorCodes('520') IN SET(filtered,VIN);
		yearFilter  := IF(~restricted AND LENGTH(TRIM(L.year))=4,
			filtered(model_year=L.year),filtered);
		makeFilter  := IF(~restricted AND L.make<>'',
			yearFilter(stringLib.stringFind(stringLib.stringToUpperCase(make_desc),
			           stringLib.stringToUpperCase(TRIM(L.make)),1)=1),
			yearFilter);
		modelFilter := IF(~restricted AND L.model<>'',
			makeFilter(stringLib.stringFind(stringLib.stringToUpperCase(model_desc),
			           stringLib.stringToUpperCase(TRIM(L.model)),1)=1),
			makeFilter);
		SELF.acctNo := L.acctNo;
		SELF.gatewayData := PROJECT(modelFilter,TRANSFORM(LayoutAcctNoRpt,SELF.AcctNo:=L.AcctNo,SELF:=LEFT));
	END;

	// RR ticket #127542 - Gateways return historical records as well hence hardcoded Is_Current Flag modified.
	Batch_Layout.RealTime_OutLayout gatewayJoin(Batch_Layout.RealTime_InLayout L, layoutAcctNoRpt R) := TRANSFORM
		reg_1 := R.registrants[1];
		SELF.is_current := IF((INTEGER)reg_1.reg_latest_expiration_date >= (INTEGER)Std.Date.Today(),TRUE,FALSE);
		SELF.reg_license_plate_type_desc := reg_1.reg_license_plate_type_desc;
		SELF.reg_license_state := reg_1.reg_license_state;
		SELF.reg_latest_effective_date := reg_1.reg_latest_effective_date;
		SELF.reg_latest_expiration_date := reg_1.reg_latest_expiration_date;
		SELF.Reg_True_License_Plate := reg_1.Reg_True_License_Plate; // Only returned from Experian gateways.
		SELF.Reg_License_Plate := reg_1.reg_license_plate; 					 // Only returned from Experian gateways.
		SELF.reg_1_fname := reg_1.fName;
		SELF.reg_1_mname := reg_1.mName;
		SELF.reg_1_lname := reg_1.lName;
		SELF.reg_1_name_suffix := reg_1.name_suffix;
		SELF.reg_1_addr1 := StringLib.StringCleanSpaces(reg_1.prim_range+' '+reg_1.predir+' '
			+reg_1.prim_name+' '+reg_1.addr_suffix+' '+reg_1.postdir);
		SELF.reg_1_addr2 := StringLib.StringCleanSpaces(reg_1.unit_desig+' '+reg_1.sec_range);
		SELF.reg_1_v_city_name := reg_1.v_city_name;
		SELF.reg_1_state := reg_1.st;
		SELF.reg_1_zip := reg_1.zip5+reg_1.zip4;
		SELF.reg_1_company_name := reg_1.append_clean_cname;
		reg_2 := R.registrants[2];
		SELF.reg_2_fname := reg_2.fName;
		SELF.reg_2_mname := reg_2.mName;
		SELF.reg_2_lname := reg_2.lName;
		SELF.reg_2_name_suffix := reg_2.name_suffix;
		SELF.reg_2_addr1 := StringLib.StringCleanSpaces(reg_2.prim_range+' '+reg_2.predir+' '
			+reg_2.prim_name+' '+reg_2.addr_suffix+' '+reg_2.postdir);
		SELF.reg_2_addr2 := StringLib.StringCleanSpaces(reg_2.unit_desig+' '+reg_2.sec_range);
		SELF.reg_2_v_city_name := reg_2.v_city_name;
		SELF.reg_2_state := reg_2.st;
		SELF.reg_2_zip := reg_2.zip5+reg_2.zip4;
		SELF.reg_2_company_name := reg_2.append_clean_cname;
		LE_1 := R.lessees[1]; // <--- coding revised for RQ-14898 fix. Store "Lessee" data in LE fields.
		SELF.le_1_orig_name:=LE_1.Orig_Name;
		SELF.le_1_company_name:=LE_1.append_clean_cname;
		SELF.le_1_fname:=LE_1.fname;
		SELF.le_1_mname:=LE_1.mname;
		SELF.le_1_lname:=LE_1.lname;
		SELF.le_1_name_suffix:=LE_1.name_suffix;
		// v--- "Lessor"(lo_1_***) coding added for RQ-14898 fix.
		// Per Julie Gardner on 01/10/19, Experian GW only returns "Lessor" info, not "Lessee".
		LO_1 := R.lessors[1];
		SELF.lo_1_orig_name:=LO_1.Orig_Name;
		SELF.lo_1_company_name:=LO_1.append_clean_cname;
		SELF.lo_1_fname:=LO_1.fname;
		SELF.lo_1_mname:=LO_1.mname;
		SELF.lo_1_lname:=LO_1.lname;
		SELF.lo_1_name_suffix:=LO_1.name_suffix;
		LH_1 := R.lienholders[1];
		SELF.lh_1_orig_name:=LH_1.Orig_Name;
		SELF.lh_1_company_name:=LH_1.append_clean_cname;
		SELF.lh_1_fname:=LH_1.fname;
		SELF.lh_1_mname:=LH_1.mname;
		SELF.lh_1_lname:=LH_1.lname;
		SELF.lh_1_name_suffix:=LH_1.name_suffix;
		SELF.documenttypeCode :=R.documenttypecode;
		SELF.safety_type:= R.safety_type;
		SELF.airbags := R.airbags;
		SELF.tod_flag := R.tod_flag;
		SELF.min_door_count := R.min_door_count;
		SELF.airbag_driver := R.airbag_driver;
		SELF.airbag_front_driver_side := R.airbag_front_driver_side;
		SELF.airbag_front_head_curtain := R.airbag_front_head_curtain;
		SELF.airbag_front_pass := R.airbag_front_pass;
		SELF.airbag_front_pass_side := R.airbag_front_pass_side;
		BR_1 := R.brands[1];
		BR_2 := R.brands[2];
		BR_3 := R.brands[3];
		BR_4 := R.brands[4];
		BR_5 := R.brands[5];
		SELF.brand_code_1 := BR_1.brand_code;
		SELF.brand_type_1 := BR_1.brand_type;
		SELF.brand_state_1:= BR_1.brand_state;
		SELF.brand_date_1 := BR_1.brand_date;
		SELF.brand_code_2 := BR_2.brand_code;
		SELF.brand_type_2 := BR_2.brand_type;
		SELF.brand_state_2:= BR_2.brand_state;
		SELF.brand_date_2 := BR_2.brand_date;
		SELF.brand_code_3 := BR_3.brand_code;
		SELF.brand_type_3 := BR_3.brand_type;
		SELF.brand_state_3:= BR_3.brand_state;
		SELF.brand_date_3 := BR_3.brand_date;
		SELF.brand_code_4 := BR_4.brand_code;
		SELF.brand_type_4 := BR_4.brand_type;
		SELF.brand_state_4:= BR_4.brand_state;
		SELF.brand_date_4 := BR_4.brand_date;
		SELF.brand_code_5 := BR_5.brand_code;
		SELF.brand_type_5 := BR_5.brand_type;
		SELF.brand_state_5:= BR_5.brand_state;
		SELF.brand_date_5	:= BR_5.brand_date;
		SELF := L;
		SELF := R;
	END;

	// Main
	filtered := MAP(Operation=Constant.VIN_VAL => PROJECT(inputData,vinOnly(LEFT)),
									Operation=Constant.LICPLATEANDSTATE_VAL => PROJECT(inputData,plateStateOnly(LEFT)),
									inputData);
	gatewayData := PROJECT(filtered,vehicleGateway(LEFT));
	gatewayNorm := NORMALIZE(gatewayData,LEFT.gatewayData,TRANSFORM(layoutAcctNoRpt,SELF:=RIGHT));
	
// All the outputs
// output(inputData,NAMED('inputData'));
// output(Include_HouseVeh,NAMED('Include_HouseVeh'));
// output(filtered_gateways,NAMED('filtered_gateways'));
// output(filtered,NAMED('filtered'));
// output(gatewayData,NAMED('gatewayData'));
// output(gatewayNorm,NAMED('gatewayNorm'));
// Fnloutput:=JOIN(inputData,gatewayNorm,LEFT.AcctNo=RIGHT.AcctNo,gatewayJoin(LEFT,RIGHT),LEFT OUTER,LIMIT(Constant.MAX_GATEWAY_RECORDS,SKIP));
// output(Fnloutput,NAMED('Fnloutput'));

	RETURN JOIN(inputData,gatewayNorm,LEFT.AcctNo=RIGHT.AcctNo,gatewayJoin(LEFT,RIGHT),LEFT OUTER,LIMIT(Constant.MAX_GATEWAY_RECORDS,SKIP));

END;