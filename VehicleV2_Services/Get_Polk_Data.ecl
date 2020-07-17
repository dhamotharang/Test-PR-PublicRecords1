IMPORT iesp, ut, AutoStandardI, Gateway, doxie, Codes, STD;

EXPORT Get_Polk_Data := MODULE

  SHARED STRING inquiryType (IParam.polkParams in_mod, STRING2 PermissibleUse) := FUNCTION
      BOOLEAN hasName := in_mod.lastname<>'' OR in_mod.companyname<>'';
      BOOLEAN hasAddr := in_mod.Addr <>'' AND (in_mod.zip<>'' OR in_mod.city<>'') AND in_mod.state<>'';
      BOOLEAN hasVin := in_mod.vin_in<>'';
      BOOLEAN hasModel := in_mod.ModelYear<>'' AND in_mod.Make<>'';
      BOOLEAN hasPlate := in_mod.LicensePlateNum<>'' AND in_mod.state<>'';
      BOOLEAN hasNameAddr := hasname AND hasaddr;

      STRING typeCode := MAP(
               PermissibleUse ='1A' => IF(hasNameAddr,IF(hasModel,'1','V'),'')
              ,PermissibleUse ='1L' => MAP(
                          hasVin =>'X',
                          hasPlate => 'G',
                          hasNameAddr AND hasModel => '1',
                          hasNameAddr => 'V',
                          '')
              ,PermissibleUse ='1P' => IF(hasPlate,'G','')
              ,PermissibleUse ='2' => MAP(
                          hasVin =>'X',
                          hasNameAddr AND hasModel => '1',
                          hasNameAddr => 'V',
                          hasPlate => 'P',
                          '')
              ,PermissibleUse ='3' => IF(hasNameAddr,IF(hasModel,'1','V'),'')
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
    RETURN typeCode;
   END;

  EXPORT STRING Operation (IParam.polkParams in_mod, STRING2 PermissibleUse):= FUNCTION
    inq := inquiryType (in_mod, PermissibleUse);
    RETURN MAP(inq='1' => 'NameAddressYearModelMake',
                inq in ['V','N'] => 'NameAddress',
                inq in ['G','P'] => 'LicPlateAndState',
                inq in ['X','Z'] => 'VIN',
                ''
                );
  END;
   
  EXPORT val(IParam.polkParams in_mod, BOOLEAN doCombined = FALSE) := FUNCTION

    // a lot of things depends on an input state value; calculate it here, once.
    state_in := in_mod.state;
  
    // for testing, only applies to polk gateway.
    BOOLEAN PerformGatewayDisallowedStateChecks := FALSE : STORED('PerformGatewayDisallowedStateChecks');
    
    BOOLEAN hasPlate := in_mod.LicensePlateNum<>'' AND state_in<>'';
  
    gateway_cfg := Gateway.Configuration.Get();
    // to be on the safe side, make sure we're always dealing with only one RTV gateway URL.
    polk_gateway_cfg := gateway_cfg(doxie.DataPermission.use_Polk, Gateway.Configuration.IsPolk(servicename));
     // string gateway_url := 'http://webapp_roxie_test:[PASSWORD_REDACTED]@10.176.68.164:7726/WsGateway?ver_=1.58';
    STRING PermissibleUse:=VehicleV2_Services.Polk_Code_Translations.RealTimePermissibleUse(in_mod.RealTimePermissibleUse);
  
    //***********************************************************
    // Set Input record for SOAP Call
    //***********************************************************
    // 1/20/2015 - Claudio requested that the ESP changes be backwards compatible.
    // The following change was requested/made to the ECL:
    // Add hardcoded flag WsGateway/VehicleCheck option.skipDisallowedStateChecks.
    // Set this flag to true and pass to WsGateway/VehicleCheck ESP.
 
    iesp.gateway_polk.t_VehicleCheckRequest prep_for_basic() := TRANSFORM

      iesp.gateway_polk.t_VehicleCheckVehicleIn get_vehicles() :=TRANSFORM
        SELF.VIN:= TRIM(in_mod.vin_in);
        SELF.ModelYear:= TRIM(in_mod.ModelYear);
        SELF.Make:= TRIM(in_mod.Make);
        SELF.Model:= TRIM(in_mod.Model);
        SELF.LicensePlateNum:= TRIM(in_mod.LicensePlateNum);
        SELF.LicenseStateCode:= state_in;
      END;

      SELF.RemoteLocations:=[];
      SELF.ServiceLocations:=[];
      SELF.user.GLBPurpose := (STRING) in_mod.glb;
      SELF.user.DLPurpose := (STRING) in_mod.dppa;
      SELF.user.QueryID := TRIM(in_mod.QueryId);
      SELF.user.ReferenceCode := TRIM(in_mod.ReferenceCode);
      SELF.user.BillingCode := TRIM(in_mod.BillingCode);
      SELF.user:=[];
    
      SELF.searchby.SubCustomerId := TRIM(in_mod.SubCustomerID);
      SELF.searchby.BrandedTitleRequest := IF(in_mod.companyname<>'',TRUE,FALSE);
    
      SELF.searchby.PermissibleUse := IF(PermissibleUse = '2' AND hasPlate, '2P', PermissibleUse);
      SELF.SearchBy.Name.First := TRIM(in_mod.firstname);
      SELF.SearchBy.Name.Middle := TRIM(in_mod.middlename);
      SELF.SearchBy.Name.Last := TRIM(in_mod.lastname);
      // Suffix for Polk search is only 2 char, standard namesuffis is string4 in Global Module
      SELF.SearchBy.Name.Suffix := TRIM (in_mod.name_suffix);
      SELF.SearchBy.Company := TRIM(in_mod.companyname);
      SELF.SearchBy.Address.StreetAddress := TRIM(in_mod.Addr);
      SELF.SearchBy.Address.City := TRIM(in_mod.city);
      SELF.SearchBy.Address.StateCode := state_in;
      SELF.SearchBy.Address.Zip5 := TRIM(in_mod.zip);
      SELF.SearchBy.Operation:= TRIM(Operation(in_mod,PermissibleUse));
      SELF.options.skipDisallowedStateChecks:= ~PerformGatewayDisallowedStateChecks; // skipDisallowedStateChecks has to default to TRUE.
      SELF.searchby.listedvehicles:=DATASET ([get_vehicles ()]);
      SELF := [];
    END;

  Polk_in := DATASET([prep_for_basic()]);
   
  Search_Request:=TRIM(STD.STR.ToUpperCase(in_mod.DataSource));
  BOOLEAN valid_input := (in_mod.vin_in != '') OR (state_in != '') OR (in_mod.state != '') OR (in_mod.LicensePlateNum != '');
  realTime := [constant.realtime_val,constant.all_val,constant.report_val];

  INTEGER RESTRICTED := 520;
  emptyResponse := DATASET([],iesp.gateway_polk.t_VehicleCheckResponseEx);

  // IMPLEMENT 'ChoicePoint VVS Permitted Use - DPPA - June 2008.xls'
    // COVERS PERMISSIBLE USE AND STATE RESTRICTIONS UTILIZING CODESV3 TABLE
    // Updates made 12/14: See Bug: 169789 for spreadsheet
    // Polk non covered all: states where all permissible uses are restricted/NO in the spreadsheet
    // 1L => states where all three sections are restricted in the spreadsheet: AR, OR
    // 1L_G => states where only 1L - G (Plate) is restricted: IA & NV
    // 1L_GX => states where the 1st and 3rd columns (Plate(G) & VIN,X,H (X))
    // under IL/Law Inforcements are restricted, but not the middle column (VIN Cor/Sur/Ad 1 & V,F)
    // For 4C & 4U: There are six columns in the spreadsheet
    // The 2nd & 3rd columns from the LEFT are ignored (don't have an explanation for this yet)
    // The remaining four colums are broken out like this:
    // 4C = 4U => states where all four columns are restricted
    // 4C_P = 4U_P => states where only the Plate column is restricted
    // 4C_NPZ = 4U_NPZ => states where the three RIGHT hand columns are restricted
    // Per Polk Vehicle VerIFication System document, page 12 the Permissible use '2P' is not used and therefore not coded for.

  // POLK's field_name2 in codes V3 index has permissible use adjusted with respect to the inquiry type.
  STRING AdjustPermissibleUse (STRING perm, STRING inq_type) := MAP (
    // perm = '2' AND inq_type <> 'P' => '2',
    perm = '1L' AND inq_type IN ['G'] => '1LG',
    perm = '1L' AND inq_type IN ['G','X'] => '1LGX',
    perm = '2' AND inq_type IN ['P'] => '2P',
    perm = '4C' AND inq_type = 'P' => '4CP',
    perm = '4C' AND inq_type IN ['N','P','Z'] => '4CNPZ',
    perm = '4U' AND inq_type = 'P' => '4UP',
    perm = '4U' AND inq_type IN ['N','P','Z'] => '4UNPZ',
    perm = '5' AND inq_type = 'G' => '5G',
    perm);

  inquiry := inquiryType (in_mod, permissibleUse);
  adj_perm := AdjustPermissibleUse (permissibleUse, inquiry);

  // Now have adjusted permissible use; check non-covered states:
  non_covered_states := Codes.Key_Codes_V3 (KEYED (file_name = 'POLK_GATEWAY'), KEYED (field_name = 'NON_COVERED'),
                                            KEYED (field_name2 IN ['ALL', adj_perm]), KEYED (code = state_in));

  BOOLEAN non_covered := EXISTS (non_covered_states);


  vMakeGWCall := polk_gateway_cfg[1].Url !='' AND permissibleUse !='' AND Search_Request in realTime AND
                 Operation (in_mod, permissibleUse) != '';
  polk_data :=
    IF(non_covered AND Search_Request in realTime
      ,IF(~in_mod.noFail
        ,FAIL(emptyResponse,1208,Polk_Code_Translations.ErrorCodes('1208'))
        ,emptyResponse
      )
    ,IF(valid_input
      ,IF(vMakeGWCall
          ,Gateway.SoapCall_Polk(Polk_in, polk_gateway_cfg[1],,,vMakeGWCall)
        ,IF(Search_Request = constant.realtime_val AND ~in_mod.noFail
          ,IF(permissibleUse=''
            ,FAIL(emptyResponse,500,Polk_Code_Translations.ErrorCodes('500'))
            ,FAIL(emptyResponse,510,Polk_Code_Translations.ErrorCodes('510')))
          ,emptyResponse
        )
      )
      ,IF((Search_Request = constant.realtime_val OR (DoCombined AND Search_Request != constant.local_val)) AND ~in_mod.noFail
        ,FAIL(emptyResponse,310,Polk_Code_Translations.ErrorCodes('310'))
        ,emptyResponse)
      )
    );
  //*****************************************************

  iesp.gateway_polk.t_VehicleCheckVehicleOut norm_veh(iesp.gateway_polk.t_VehicleCheckVehicleOut R) := TRANSFORM
    SELF := R;
  END;
  polk_set := SORT(NORMALIZE(polk_data,LEFT.response.response.vehicles,norm_veh(RIGHT)),-SeqNum,-ExpirationDate);

  vina_data:=VehicleV2_Services.Get_Polk_Vina_Data(PROJECT(polk_set,TRANSFORM(Layout_Vehicle_Vin,SELF:=LEFT)));
  polk_vina_layout:=RECORD
    RECORDOF(polk_set);
    RECORDOF(vina_data) AND NOT [vin];
    UNSIGNED1 pen := 0;
  END;
  
  polk_vina_layout add_vina(polk_set l, vina_data r):=TRANSFORM
    tm := MODULE(PROJECT(in_mod, AutoStandardI.LIBIN.PenaltyI_Indv_Name.full, OPT))
       EXPORT fname_field := l.Name.First;
       EXPORT mname_field := l.Name.middle;
       EXPORT lname_field := l.Name.last;
       EXPORT allow_wildcard := FALSE;
    END;
    SELF.pen := AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tm);
    SELF:=l;
    SELF:=r;
  END;

  polk_set_all:= JOIN(polk_set,vina_data,LEFT.vin=RIGHT.vin,add_vina(LEFT,RIGHT),LEFT OUTER);
  // polk_set_tmp :=SORT(DEDUP(polk_set_all,record,all),-SeqNum);
  polk_set_tmp :=SORT(DEDUP(polk_set_all,RECORD,all),pen);
  
  VehicleV2_Services.assorted_layouts.layout_lienholder xform_lienholder(polk_set_tmp le) := TRANSFORM
    SELF.fname := le.Name2.first;
    SELF.mname := le.Name2.middle;
    SELF.lname := le.Name2.last;
    SELF.name_suffix := le.Name2.suffix;
    SELF.append_clean_cname := le.Company2;
    SELF:=[];
  END;
  
  VehicleV2_Services.assorted_layouts.Layout_registrant xform_registrants(polk_set_tmp le, UNSIGNED1 namecounter) := TRANSFORM
    SELF.Reg_License_State :=le.LicenseStateCode ;
    SELF.Reg_Latest_Effective_Date :=le.LicenseDate ;
    SELF.Reg_Latest_Expiration_Date := le.ExpirationDate;
    SELF.Reg_License_Plate_Type_Desc := VehicleV2_Services.Polk_Code_Translations.Plate_Type_Description(le.PlateType);
    SELF.prim_range := IF(namecounter=1,le.Address.HouseNum,'');
    SELF.predir := IF(namecounter=1,le.Address.DirectionPrefix,'');
    SELF.prim_name := IF(namecounter=1,IF(le.Address.StreetName<>'',
          le.Address.StreetName,
          MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
          le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
          le.Address.StreetName)),'');
    SELF.addr_suffix := IF(namecounter=1,le.Address.StreetSuffix,'');
    SELF.postdir := IF(namecounter=1,le.Address.DirectionSuffix,'');
    SELF.unit_desig := IF(namecounter=1,le.Address.UnitType,'');
    SELF.sec_range := IF(namecounter=1,le.Address.UnitNum,'');
    SELF.v_city_name := IF(namecounter=1,le.Address.City,'');
    SELF.st := IF(namecounter=1,le.Address.StateCode,'');
    SELF.zip5 := IF(namecounter=1,le.Address.Zip5,'');
    SELF.zip4 := IF(namecounter=1,le.Address.Zip4,'');
    SELF.fname := IF(namecounter=1,le.Name.first,le.Name2.first);
    SELF.mname := IF(namecounter=1,le.Name.middle,le.Name2.middle);
    SELF.lname := IF(namecounter=1,le.Name.last,le.Name2.last);
    SELF.name_suffix := IF(namecounter=1,le.Name.suffix,le.Name2.suffix);
    SELF.append_clean_cname := IF(namecounter=1,le.Company,le.Company2);
    SELF:=[];
  END;

  VehicleV2_Services.assorted_layouts.Layout_lessee xform_lessee(polk_set_tmp le, UNSIGNED1 namecounter) := TRANSFORM
    SELF.Reg_Latest_Effective_Date :=IF(namecounter=1,le.LicenseDate,'') ;
    SELF.Reg_Latest_Expiration_Date := IF(namecounter=1,le.ExpirationDate,'');
    SELF.Reg_License_Plate_Type_Desc := IF(namecounter=1,VehicleV2_Services.Polk_Code_Translations.Plate_Type_Description(le.PlateType),'');
    SELF.prim_range := IF(namecounter=1,le.Address.HouseNum,'');
    SELF.predir := IF(namecounter=1,le.Address.DirectionPrefix,'');
    SELF.prim_name := IF(namecounter=1,IF(le.Address.StreetName<>'',
          le.Address.StreetName,
          MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
          le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
          le.Address.StreetName)),'');
    SELF.addr_suffix := IF(namecounter=1,le.Address.StreetSuffix,'');
    SELF.postdir := IF(namecounter=1,le.Address.DirectionSuffix,'');
    SELF.unit_desig := IF(namecounter=1,le.Address.UnitType,'');
    SELF.sec_range := IF(namecounter=1,le.Address.UnitNum,'');
    SELF.v_city_name := IF(namecounter=1,le.Address.City,'');
    SELF.st := IF(namecounter=1,le.Address.StateCode,'');
    SELF.zip5 := IF(namecounter=1,le.Address.Zip5,'');
    SELF.zip4 := IF(namecounter=1,le.Address.Zip4,'');
    SELF.fname := IF(namecounter=1,le.Name.first,le.Name2.first);
    SELF.mname := IF(namecounter=1,le.Name.middle,le.Name2.middle);
    SELF.lname := IF(namecounter=1,le.Name.last,le.Name2.last);
    SELF.name_suffix := IF(namecounter=1,le.Name.suffix,le.Name2.suffix);
    SELF.append_clean_cname := IF(namecounter=1,le.Company,le.Company2);
    SELF:=[];
  END;

  VehicleV2_Services.assorted_layouts.layout_lessee_or_lessor xform_lessor(polk_set_tmp le, UNSIGNED1 namecounter) := TRANSFORM
    SELF.prim_range := IF(namecounter=1,le.Address.HouseNum,'');
    SELF.predir := IF(namecounter=1,le.Address.DirectionPrefix,'');
    SELF.prim_name := IF(namecounter=1,IF(le.Address.StreetName<>'',
          le.Address.StreetName,
          MAP(le.Address.AddressTypeCode='2' => le.Address.POBoxAddress,
          le.Address.AddressTypeCode in ['3','4'] => le.Address.RuralRouteAddress,
          le.Address.StreetName)),'');
    SELF.addr_suffix := IF(namecounter=1,le.Address.StreetSuffix,'');
    SELF.postdir := IF(namecounter=1,le.Address.DirectionSuffix,'');
    SELF.unit_desig := IF(namecounter=1,le.Address.UnitType,'');
    SELF.sec_range := IF(namecounter=1,le.Address.UnitNum,'');
    SELF.v_city_name := IF(namecounter=1,le.Address.City,'');
    SELF.st := IF(namecounter=1,le.Address.StateCode,'');
    SELF.zip5 := IF(namecounter=1,le.Address.Zip5,'');
    SELF.zip4 := IF(namecounter=1,le.Address.Zip4,'');
    SELF.fname := IF(namecounter=1,le.Name.first,le.Name2.first);
    SELF.mname := IF(namecounter=1,le.Name.middle,le.Name2.middle);
    SELF.lname := IF(namecounter=1,le.Name.last,le.Name2.last);
    SELF.name_suffix := IF(namecounter=1,le.Name.suffix,le.Name2.suffix);
    SELF.append_clean_cname := IF(namecounter=1,le.Company,le.Company2);
    SELF:=[];
  END;

  Layout_Report_Realtime xform_Polk (polk_set_tmp le):=TRANSFORM

    SELF.is_current :=TRUE;
    SELF.vin:=le.vin;
    SELF.model_year :=le.ModelYear;
    SELF.make_desc := IF(le.make_desc<>'',le.make_desc,VehicleV2_Services.Polk_Code_Translations.make_Description(le.Make));
    SELF.body_style_desc :=IF(le.body_style_desc<>'',
                            le.body_style_desc,
                            VehicleV2_Services.Polk_Code_Translations.Body_Style_Description(le.BodyStyle));
    SELF.series_desc := le.Model;
    SELF.model_desc := le.VINA_VP_Series_Name;
    SELF.registrants :=NORMALIZE(DATASET(le),
          IF(((LEFT.Name2.first<>'' AND LEFT.Name2.last<>'') OR LEFT.Company2<>'') AND LEFT.Name2Code NOT in ['4','5','6'],2,1),
          xform_registrants(LEFT,COUNTER));
  
    SELF.lessees :=IF(le.LesseeLessorCode in ['1','4','7'],
          IF(le.Name2Code='5',NORMALIZE(DATASET(le),2,xform_lessee(LEFT,COUNTER)),
              PROJECT(DATASET(le),xform_lessee(LEFT,1))),
          IF(le.Name2Code='5',PROJECT(DATASET(le),xform_lessee(LEFT,2))));
    SELF.lessors :=IF(le.LesseeLessorCode in ['2','5','8'],
          IF(le.Name2Code='4',NORMALIZE(DATASET(le),2,xform_lessor(LEFT,COUNTER)),
              PROJECT(DATASET(le),xform_lessor(LEFT,1))),
          IF(le.Name2Code='4',PROJECT(DATASET(le),xform_lessor(LEFT,2))));
    SELF.lienholders := IF (le.name2Code = '6',PROJECT(DATASET(le),xform_lienholder(LEFT)));
    SELF.DataSource:=constant.realtime_val_out;
    SELF:=le;
    SELF:=[];
  END;

  Polk_set_fmt:=PROJECT(polk_set_tmp,xform_Polk(LEFT));
  
  GatewayErrorCode := PROJECT(Polk_Data, TRANSFORM({STRING ErrorCode},
                                SELF.ErrorCode := LEFT.response.response.ErrorCode))[1].ErrorCode;
  STRING Polk_Exception := IF(GatewayErrorCode<>'',GatewayErrorCode,'');

  Layout_Report_Realtime TxNonCovered(iesp.gateway_polk.t_VehicleCheckRequest L) := TRANSFORM
    SELF.DataSource := constant.Realtime_val_out;
    SELF.vin := Polk_Code_Translations.ErrorCodes((STRING)RESTRICTED);
    SELF := [];
  END;

  Polk_results:=IF(Polk_Exception='',
    IF(non_covered,PROJECT(polk_in,TxNonCovered(LEFT)),Polk_set_fmt),
    IF(Search_Request = constant.realtime_val AND ~in_mod.noFail OR doCombined,
      FAIL(Polk_set_fmt,(UNSIGNED)Polk_Exception,VehicleV2_Services.Polk_Code_Translations.ErrorCodes(Polk_Exception)),
      DATASET([],Layout_Report_Realtime))
    );
  
rec := RECORD
  INTEGER code;
  STRING200 msg;
END;

  ds_blank:=DATASET([],rec);
  ds_msg:= DATASET([{ut.constants_MessageCodes.POLK_ERROR, VehicleV2_Services.Polk_Code_Translations.ErrorCodes(Polk_Exception)}],rec);
  ds_msg_val:=IF(Polk_Exception != '' AND Search_Request = constant.report_val ,ds_msg,ds_blank);
  ds_val:=IF(doCombined OR Search_Request = Constant.LOCAL_VAL,ds_blank,ds_msg_val);
  OUTPUT(ds_val, NAMED('MessageCodes'), extend);
      // output(Polk_Exception,named('Polk_Exception'));
      // output(polk_data,named('polk_dataresults'),extend);
      // output(Polk_results,named('Polk_results'));

  RETURN Polk_results;
END;
END;
