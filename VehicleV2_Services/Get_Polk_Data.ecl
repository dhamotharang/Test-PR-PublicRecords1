import iesp, ut, AutoStandardI, Gateway, doxie, Codes;

export Get_Polk_Data := MODULE

	shared string inquiryType (IParam.polkParams in_mod, string2 PermissibleUse) := FUNCTION
			Boolean hasName  := in_mod.lastname<>'' or in_mod.companyname<>'';
			Boolean hasAddr  := in_mod.Addr <>'' and (in_mod.zip<>'' or in_mod.city<>'') and in_mod.state<>'';
			Boolean hasVin   := in_mod.vin_in<>'';
			Boolean hasModel := in_mod.ModelYear<>'' and in_mod.Make<>'';
			Boolean hasPlate := in_mod.LicensePlateNum<>'' and in_mod.state<>'';
			Boolean hasNameAddr	:= hasname and hasaddr;

			string typeCode := MAP(
							 PermissibleUse ='1A' => IF(hasNameAddr,IF(hasModel,'1','V'),'')
							,PermissibleUse ='1L' => MAP(
													hasVin =>'X',
													hasPlate => 'G',
													hasNameAddr AND hasModel => '1',
													hasNameAddr => 'V',
													'')
							,PermissibleUse ='1P' => IF(hasPlate,'G','')
							,PermissibleUse ='2'  => MAP(
													hasVin =>'X',
													hasNameAddr AND hasModel => '1',
													hasNameAddr => 'V',
                          hasPlate => 'P',
													'')
							,PermissibleUse ='3'  => IF(hasNameAddr,IF(hasModel,'1','V'),'')
							,PermissibleUse IN ['4C', '4U'] => MAP(
													hasVin =>'Z',
													hasPlate => 'P',
													hasNameAddr AND hasModel => '1',
													hasNameAddr => 'N',
													'')
							,PermissibleUse ='5' => MAP(
													hasVin =>'X',
													hasPlate => 'G',
													'')
							,PermissibleUse ='6' => IF(hasPlate,'G','')
							,'');
		return typeCode;
	 end;

	export string Operation (IParam.polkParams in_mod, string2 PermissibleUse):= FUNCTION
    inq := inquiryType (in_mod, PermissibleUse);
		return	map(inq='1' => 'NameAddressYearModelMake',
								inq in ['V','N'] => 'NameAddress',
								inq in ['G','P'] => 'LicPlateAndState',
								inq in ['X','Z'] => 'VIN',
								''
							  );
	end;
	 
	export val(IParam.polkParams in_mod, boolean doCombined = FALSE) := function

    // a lot of things depends on an input state value; calculate it here, once.
    state_in := in_mod.state;
	
		// for testing, only applies to polk gateway.
		BOOLEAN PerformGatewayDisallowedStateChecks := FALSE : STORED('PerformGatewayDisallowedStateChecks');  
		
    BOOLEAN hasPlate := in_mod.LicensePlateNum<>'' AND state_in<>'';
	
		gateway_cfg 		 := Gateway.Configuration.Get(); 
		// to be on the safe side, make sure we're always dealing with only one RTV gateway URL.
		polk_gateway_cfg := gateway_cfg(doxie.DataPermission.use_Polk, Gateway.Configuration.IsPolk(servicename));	
		 // string gateway_url := 'http://webapp_roxie_test:[PASSWORD_REDACTED]@10.176.68.164:7726/WsGateway?ver_=1.58';
    string PermissibleUse:=VehicleV2_Services.Polk_Code_Translations.RealTimePermissibleUse(in_mod.RealTimePermissibleUse);
	
		//***********************************************************
		//  Set Input record for SOAP Call
		//***********************************************************	 
    // 1/20/2015 - Claudio requested that the ESP changes be backwards compatible.
    //             The following change was requested/made to the ECL: 
    //             Add hardcoded flag WsGateway/VehicleCheck option.skipDisallowedStateChecks. 
    //             Set this flag to true and pass to WsGateway/VehicleCheck ESP.
 
		iesp.gateway_polk.t_VehicleCheckRequest prep_for_basic() := transform

      iesp.gateway_polk.t_VehicleCheckVehicleIn get_vehicles() :=transform
        self.VIN:= trim(in_mod.vin_in);
        self.ModelYear:= trim(in_mod.ModelYear);
        self.Make:= trim(in_mod.Make);
        self.Model:= trim(in_mod.Model);
        self.LicensePlateNum:= trim(in_mod.LicensePlateNum);
        self.LicenseStateCode:= state_in;
      end;

      self.RemoteLocations:=[];
      self.ServiceLocations:=[];
      self.user.GLBPurpose := (STRING) in_mod.glb;
      self.user.DLPurpose := (STRING) in_mod.dppa;
      self.user.QueryID := trim(in_mod.QueryId);
      self.user.ReferenceCode := trim(in_mod.ReferenceCode);
      self.user.BillingCode := trim(in_mod.BillingCode);		
      self.user:=[];
    
      self.searchby.SubCustomerId := trim(in_mod.SubCustomerID);
      self.searchby.BrandedTitleRequest := if(in_mod.companyname<>'',True,false);
    
      self.searchby.PermissibleUse := IF(PermissibleUse = '2' AND hasPlate, '2P', PermissibleUse);
      self.SearchBy.Name.First := trim(in_mod.firstname);
      self.SearchBy.Name.Middle := trim(in_mod.middlename);
      self.SearchBy.Name.Last := trim(in_mod.lastname);
      // Suffix for Polk search is only 2 char, standard namesuffis is string4 in Global Module
      self.SearchBy.Name.Suffix := trim (in_mod.name_suffix);
      self.SearchBy.Company := trim(in_mod.companyname);
      self.SearchBy.Address.StreetAddress := trim(in_mod.Addr);
      self.SearchBy.Address.City := trim(in_mod.city);
      self.SearchBy.Address.StateCode := state_in;
      self.SearchBy.Address.Zip5 := trim(in_mod.zip);
      self.SearchBy.Operation:= trim(Operation(in_mod,PermissibleUse));
      self.options.skipDisallowedStateChecks:= ~PerformGatewayDisallowedStateChecks; // skipDisallowedStateChecks has to default to true.
      self.searchby.listedvehicles:=dataset ([get_vehicles ()]);
      self := []; 
    end;

	Polk_in := dataset([prep_for_basic()]);
	 
	Search_Request:=trim(stringlib.stringtouppercase(in_mod.DataSource));	
	boolean valid_input := (in_mod.vin_in != '') OR (state_in != '') OR (in_mod.state != '') OR (in_mod.LicensePlateNum != '');
	realTime := [constant.realtime_val,constant.all_val,constant.report_val];

	INTEGER RESTRICTED := 520;
	emptyResponse := DATASET([],iesp.gateway_polk.t_VehicleCheckResponseEx);

	// IMPLEMENT 'ChoicePoint VVS Permitted Use - DPPA - June 2008.xls'
		// COVERS PERMISSIBLE USE AND STATE RESTRICTIONS UTILIZING CODESV3 TABLE 
    // Updates made 12/14:  See Bug: 169789 for spreadsheet 
    // Polk non covered all: states where all permissible uses are restricted/NO in the spreadsheet
    // 1L => states where all three sections are restricted in the spreadsheet: AR, OR
    // 1L_G => states where only 1L - G (Plate) is restricted: IA & NV
    // 1L_GX => states where the 1st and 3rd columns (Plate(G) & VIN,X,H (X)) 
    //          under IL/Law Inforcements are restricted, but not the middle column (VIN Cor/Sur/Ad 1 & V,F)
    // For 4C & 4U: There are six columns in the spreadsheet 
    //              The 2nd & 3rd columns from the left are ignored (don't have an explanation for this yet)
    //              The remaining four colums are broken out like this:
    //              4C = 4U => states where all four columns are restricted 
    //              4C_P = 4U_P => states where only the Plate column is restricted
    //              4C_NPZ = 4U_NPZ => states where the three right hand columns are restricted 
    // Per Polk Vehicle Verification System document, page 12 the Permissible use '2P' is not used and therefore not coded for.

  // POLK's field_name2 in codes V3 index has permissible use adjusted with respect to the inquiry type.
  string AdjustPermissibleUse (string perm, string inq_type) := MAP (
		// perm = '2'  AND inq_type <> 'P' => '2',
		perm = '1L' AND inq_type IN ['G'] => '1LG',
		perm = '1L' AND inq_type IN ['G','X'] => '1LGX',
		perm = '2'  AND inq_type IN ['P'] => '2P',
		perm = '4C' AND inq_type = 'P' => '4CP',
		perm = '4C' AND inq_type IN ['N','P','Z'] => '4CNPZ',
		perm = '4U' AND inq_type = 'P' => '4UP',
		perm = '4U' AND inq_type IN ['N','P','Z'] => '4UNPZ',
		perm = '5'  AND inq_type = 'G' => '5G',
    perm);

  inquiry := inquiryType (in_mod, permissibleUse);
  adj_perm := AdjustPermissibleUse (permissibleUse, inquiry);

  // Now have adjusted permissible use; check non-covered states:
  non_covered_states := Codes.Key_Codes_V3 (KEYED (file_name = 'POLK_GATEWAY'), KEYED (field_name = 'NON_COVERED'),
                                            KEYED (field_name2 IN ['ALL', adj_perm]), KEYED (code = state_in));

	BOOLEAN non_covered := EXISTS (non_covered_states);


	vMakeGWCall := polk_gateway_cfg[1].Url !='' and permissibleUse !='' and Search_Request in realTime AND 
                 Operation (in_mod, permissibleUse) != '';
	polk_data :=
		if(non_covered and Search_Request in realTime
			,if(~in_mod.noFail
				,fail(emptyResponse,1208,Polk_Code_Translations.ErrorCodes('1208'))
				,emptyResponse
			)
		,if(valid_input
			,if(vMakeGWCall
					,Gateway.SoapCall_Polk(Polk_in, polk_gateway_cfg[1],,,vMakeGWCall) 
				,if(Search_Request = constant.realtime_val and ~in_mod.noFail
					,if(permissibleUse=''
						,fail(emptyResponse,500,Polk_Code_Translations.ErrorCodes('500'))
						,fail(emptyResponse,510,Polk_Code_Translations.ErrorCodes('510')))
					,emptyResponse
				)
			)
			,if((Search_Request = constant.realtime_val OR (DoCombined and Search_Request != constant.local_val)) and ~in_mod.noFail
				,fail(emptyResponse,310,Polk_Code_Translations.ErrorCodes('310'))
				,emptyResponse)
			)
		);
	//*****************************************************

	iesp.gateway_polk.t_VehicleCheckVehicleOut norm_veh(iesp.gateway_polk.t_VehicleCheckVehicleOut R) := TRANSFORM
		SELF := R;
	END;
	polk_set := sort(NORMALIZE(polk_data,LEFT.response.response.vehicles,norm_veh(RIGHT)),-SeqNum,-ExpirationDate);

	vina_data:=VehicleV2_Services.Get_Polk_Vina_Data(project(polk_set,transform(Layout_Vehicle_Vin,self:=left)));
	polk_vina_layout:=record
		recordof(polk_set);
		recordof(vina_data) and not [vin];
		unsigned1	pen := 0;
	end;
	
	polk_vina_layout add_vina(polk_set l, vina_data r):=transform
		tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
			 EXPORT fname_field := l.Name.First;
			 EXPORT mname_field := l.Name.middle;
			 EXPORT lname_field := l.Name.last;
			 EXPORT allow_wildcard := false;
		END;
		self.pen := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
		self:=l;
		self:=r;
	end;

	polk_set_all:= join(polk_set,vina_data,left.vin=right.vin,add_vina(LEFT,RIGHT),left outer);
	// polk_set_tmp	:=sort(dedup(polk_set_all,record,all),-SeqNum);
	polk_set_tmp	:=sort(dedup(polk_set_all,record,all),pen);
	
	VehicleV2_Services.assorted_layouts.layout_lienholder	xform_lienholder(polk_set_tmp le) := transform
		self.fname := le.Name2.first;
		self.mname := le.Name2.middle;
		self.lname := le.Name2.last;
		self.name_suffix := le.Name2.suffix;
		self.append_clean_cname := le.Company2;
		self:=[];
	end;
	
	VehicleV2_Services.assorted_layouts.Layout_registrant xform_registrants(polk_set_tmp le, Unsigned1 namecounter) := TRANSFORM
		self.Reg_License_State :=le.LicenseStateCode ;
		self.Reg_Latest_Effective_Date :=le.LicenseDate ;
		self.Reg_Latest_Expiration_Date := le.ExpirationDate;
		self.Reg_License_Plate_Type_Desc := VehicleV2_Services.Polk_Code_Translations.Plate_Type_Description(le.PlateType);
		self.prim_range := if(namecounter=1,le.Address.HouseNum,'');
		self.predir := if(namecounter=1,le.Address.DirectionPrefix,'');
		self.prim_name := if(namecounter=1,if(le.Address.StreetName<>'',
					le.Address.StreetName,
					MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
					le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
					le.Address.StreetName)),'');
		self.addr_suffix := if(namecounter=1,le.Address.StreetSuffix,'');
		self.postdir := if(namecounter=1,le.Address.DirectionSuffix,'');
		self.unit_desig := if(namecounter=1,le.Address.UnitType,'');
		self.sec_range := if(namecounter=1,le.Address.UnitNum,'');
		self.v_city_name := if(namecounter=1,le.Address.City,'');
		self.st := if(namecounter=1,le.Address.StateCode,'');
		self.zip5 := if(namecounter=1,le.Address.Zip5,'');
		self.zip4 := if(namecounter=1,le.Address.Zip4,'');
		self.fname := if(namecounter=1,le.Name.first,le.Name2.first);
		self.mname := if(namecounter=1,le.Name.middle,le.Name2.middle);
		self.lname := if(namecounter=1,le.Name.last,le.Name2.last);
		self.name_suffix := if(namecounter=1,le.Name.suffix,le.Name2.suffix);
		self.append_clean_cname := if(namecounter=1,le.Company,le.Company2);
		self:=[];
	END;

	VehicleV2_Services.assorted_layouts.Layout_lessee xform_lessee(polk_set_tmp le, Unsigned1 namecounter) := TRANSFORM
		self.Reg_Latest_Effective_Date :=if(namecounter=1,le.LicenseDate,'') ;
		self.Reg_Latest_Expiration_Date := if(namecounter=1,le.ExpirationDate,'');
		self.Reg_License_Plate_Type_Desc := if(namecounter=1,VehicleV2_Services.Polk_Code_Translations.Plate_Type_Description(le.PlateType),'');
		self.prim_range := if(namecounter=1,le.Address.HouseNum,'');
		self.predir := if(namecounter=1,le.Address.DirectionPrefix,'');
		self.prim_name := if(namecounter=1,if(le.Address.StreetName<>'',
					le.Address.StreetName,
					MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
					le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
					le.Address.StreetName)),'');
		self.addr_suffix := if(namecounter=1,le.Address.StreetSuffix,'');
		self.postdir := if(namecounter=1,le.Address.DirectionSuffix,'');
		self.unit_desig := if(namecounter=1,le.Address.UnitType,'');
		self.sec_range := if(namecounter=1,le.Address.UnitNum,'');
		self.v_city_name := if(namecounter=1,le.Address.City,'');
		self.st := if(namecounter=1,le.Address.StateCode,'');
		self.zip5 := if(namecounter=1,le.Address.Zip5,'');
		self.zip4 := if(namecounter=1,le.Address.Zip4,'');
		self.fname := if(namecounter=1,le.Name.first,le.Name2.first);
		self.mname := if(namecounter=1,le.Name.middle,le.Name2.middle);
		self.lname := if(namecounter=1,le.Name.last,le.Name2.last);
		self.name_suffix := if(namecounter=1,le.Name.suffix,le.Name2.suffix);
		self.append_clean_cname := if(namecounter=1,le.Company,le.Company2);
		self:=[];
	END;

	VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor xform_lessor(polk_set_tmp le, Unsigned1 namecounter) := TRANSFORM
		self.prim_range := if(namecounter=1,le.Address.HouseNum,'');
		self.predir := if(namecounter=1,le.Address.DirectionPrefix,'');
		self.prim_name := if(namecounter=1,if(le.Address.StreetName<>'',
					le.Address.StreetName,
					MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
					le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
					le.Address.StreetName)),'');
		self.addr_suffix := if(namecounter=1,le.Address.StreetSuffix,'');
		self.postdir := if(namecounter=1,le.Address.DirectionSuffix,'');
		self.unit_desig := if(namecounter=1,le.Address.UnitType,'');
		self.sec_range := if(namecounter=1,le.Address.UnitNum,'');
		self.v_city_name := if(namecounter=1,le.Address.City,'');
		self.st := if(namecounter=1,le.Address.StateCode,'');
		self.zip5 := if(namecounter=1,le.Address.Zip5,'');
		self.zip4 := if(namecounter=1,le.Address.Zip4,'');
		self.fname := if(namecounter=1,le.Name.first,le.Name2.first);
		self.mname := if(namecounter=1,le.Name.middle,le.Name2.middle);
		self.lname := if(namecounter=1,le.Name.last,le.Name2.last);
		self.name_suffix := if(namecounter=1,le.Name.suffix,le.Name2.suffix);
		self.append_clean_cname := if(namecounter=1,le.Company,le.Company2);
		self:=[];
	END;

	Layout_Report_Realtime xform_Polk (polk_set_tmp le):=transform

		self.is_current :=True;
		self.vin:=le.vin;
		self.model_year :=le.ModelYear;
		self.make_desc := if(le.make_desc<>'',le.make_desc,VehicleV2_Services.Polk_Code_Translations.make_Description(le.Make));
		self.body_style_desc :=if(le.body_style_desc<>'',
														le.body_style_desc,
														VehicleV2_Services.Polk_Code_Translations.Body_Style_Description(le.BodyStyle));
		self.series_desc := le.Model;
		self.model_desc := le.VINA_VP_Series_Name;
		self.registrants :=NORMALIZE(dataset(le),
					if(((left.Name2.first<>'' and left.Name2.last<>'') or left.Company2<>'') and left.Name2Code not in ['4','5','6'],2,1),
					xform_registrants(LEFT,COUNTER));
	
		self.lessees :=if(le.LesseeLessorCode in ['1','4','7'],
					if(le.Name2Code='5',NORMALIZE(dataset(le),2,xform_lessee(LEFT,COUNTER)),
							project(dataset(le),xform_lessee(LEFT,1))),
					if(le.Name2Code='5',project(dataset(le),xform_lessee(LEFT,2))));
		self.lessors :=if(le.LesseeLessorCode in ['2','5','8'],
					if(le.Name2Code='4',NORMALIZE(dataset(le),2,xform_lessor(LEFT,COUNTER)),
							project(dataset(le),xform_lessor(LEFT,1))),
					if(le.Name2Code='4',project(dataset(le),xform_lessor(LEFT,2))));					
		self.lienholders := if (le.name2Code = '6',project(dataset(le),xform_lienholder(LEFT)));			
		self.DataSource:=constant.realtime_val_out;
		self:=le;
		self:=[];
	end;

	Polk_set_fmt:=project(polk_set_tmp,xform_Polk(LEFT));
	
	GatewayErrorCode := project(Polk_Data, transform({string ErrorCode}, 
																self.ErrorCode := LEFT.response.response.ErrorCode))[1].ErrorCode;
  string Polk_Exception := if(GatewayErrorCode<>'',GatewayErrorCode,'');

	Layout_Report_Realtime TxNonCovered(iesp.gateway_polk.t_VehicleCheckRequest L) := transform
		self.DataSource := constant.Realtime_val_out;
		self.vin := Polk_Code_Translations.ErrorCodes((STRING)RESTRICTED);
		self := [];
	end;

	Polk_results:=if(Polk_Exception='',
				  if(non_covered,project(polk_in,TxNonCovered(LEFT)),Polk_set_fmt),
				  if(Search_Request = constant.realtime_val and ~in_mod.noFail or doCombined,
						fail(Polk_set_fmt,(UNSIGNED)Polk_Exception,VehicleV2_Services.Polk_Code_Translations.ErrorCodes(Polk_Exception)),						
						dataset([],Layout_Report_Realtime))
				 );
	
rec := record
	integer code;
	string200 msg;
end;

	ds_blank:=dataset([],rec);
	ds_msg:= dataset([{ut.constants_MessageCodes.POLK_ERROR, VehicleV2_Services.Polk_Code_Translations.ErrorCodes(Polk_Exception)}],rec);
  ds_msg_val:=if(Polk_Exception != '' and Search_Request = constant.report_val ,ds_msg,ds_blank);
	ds_val:=if(doCombined or Search_Request = Constant.LOCAL_VAL,ds_blank,ds_msg_val);	
	output(ds_val, NAMED('MessageCodes'), extend);
			// output(Polk_Exception,named('Polk_Exception'));
			// output(polk_data,named('polk_dataresults'),extend);
			// output(Polk_results,named('Polk_results'));

	return Polk_results;
end;
END;
