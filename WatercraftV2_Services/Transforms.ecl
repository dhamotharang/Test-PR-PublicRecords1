IMPORT doxie, iesp, Census_data, FFD, STD;

EXPORT Transforms := MODULE

  EXPORT WatercraftV2_Services.Layouts.batch_out_pre xform_toFinalBatch(WatercraftV2_Services.Layouts.batch_report L , INTEGER c = 0 ) := TRANSFORM
    owners := PROJECT(L.Owners,watercraftV2_Services.Layouts.owner_report_rec);
    SELF.did_1:= owners[1].did ;
    SELF.bdid_1:= owners[1].bdid ;
    SELF.ultID_1:= owners[1].UltID ;
    SELF.orgID_1:= owners[1].OrgID ;
    SELF.seleID_1:= owners[1].SeleID ;
    SELF.proxID_1:= owners[1].ProxID ;
    SELF.powID_1:= owners[1].PowID ;
    SELF.empID_1:= owners[1].EmpID ;
    SELF.dotID_1:= owners[1].DotID ;
    SELF.orig_name_1:= owners[1].orig_name ;
    SELF.orig_name_type_code_1:= owners[1].orig_name_type_code;
    SELF.orig_name_type_description_1:= owners[1].orig_name_type_description ;
    SELF.orig_name_first_1:= owners[1].orig_name_first ;
    SELF.orig_name_middle_1:= owners[1].orig_name_middle ;
    SELF.orig_name_last_1:= owners[1].orig_name_last ;
    SELF.orig_address_1_1:= owners[1].orig_address_1 ;
    SELF.orig_address_2_1:= owners[1].orig_address_2 ;
    SELF.orig_fips_1:= owners[1].orig_fips ;
    SELF.orig_province_1:=owners[1].orig_province ;
    SELF.orig_country_1:=owners[1].orig_country ;
    SELF.dob_1:= owners[1].dob ;
    SELF.orig_ssn_1:= owners[1].orig_ssn ;
    SELF.orig_fein_1:= owners[1].orig_fein ;
    SELF.gender_1:= owners[1].gender ;
    SELF.phone_1_1:= owners[1].phone_1 ;
    SELF.phone_2_1:= owners[1].phone_2 ;
    SELF.title_1:= owners[1].title ;
    SELF.fname_1:= owners[1].fname ;
    SELF.mname_1:= owners[1].mname ;
    SELF.lname_1:= owners[1].lname ;
    SELF.name_suffix_1:= owners[1].name_suffix ;
    SELF.company_name_1:= owners[1].company_name ;
    SELF.prim_range_1:= owners[1].prim_range ;
    SELF.predir_1:= owners[1].predir ;
    SELF.prim_name_1:= owners[1].prim_name ;
    SELF.suffix_1:= owners[1].suffix ;
    SELF.postdir_1:= owners[1].postdir ;
    SELF.unit_desig_1:= owners[1].unit_Desig ;
    SELF.sec_range_1:= owners[1].sec_range ;
    SELF.p_city_name_1:= owners[1].p_city_name ;
    SELF.v_city_name_1:= owners[1].v_city_name ;
    SELF.st_1:= owners[1].st ;
    SELF.zip5_1:= owners[1].zip5 ;
    SELF.zip4_1:= owners[1].zip4 ;
    SELF.county_1:= owners[1].county ;
    
    LH := CHOOSEN(PROJECT(L.LienHolders,WatercraftV2_services.Layouts.lien_rec),2);
    
    SELF.lien_name_1:= LH[1].lien_name;
    SELF.lien_address_1_1:= LH[1].lien_address_1;
    SELF.lien_address_2_1:= LH[1].lien_address_2;
    SELF.lien_city_1:= LH[1].lien_city;
    SELF.lien_state_1:= LH[1].lien_state;
    SELF.lien_zip_1:= LH[1].lien_zip;
    SELF.lien_date_1:= LH[1].lien_date;
    SELF.lien_indicator_1:= LH[1].lien_indicator;

    SELF.lien_name_2:= LH[2].lien_name;
    SELF.lien_address_1_2:= LH[2].lien_address_1;
    SELF.lien_address_2_2:= LH[2].lien_address_2;
    SELF.lien_city_2:= LH[2].lien_city;
    SELF.lien_state_2:= LH[2].lien_state;
    SELF.lien_zip_2:= LH[2].lien_zip;
    SELF.lien_date_2:= LH[2].lien_date;
    SELF.lien_indicator_2:= LH[2].lien_indicator;

    SELF.did_2:= owners[2].did ;
    SELF.bdid_2:= owners[2].bdid ;
    SELF.ultID_2:= owners[2].UltID ;
    SELF.orgID_2:= owners[2].OrgID ;
    SELF.seleID_2:= owners[2].SeleID ;
    SELF.proxID_2:= owners[2].ProxID ;
    SELF.powID_2:= owners[2].PowID ;
    SELF.empID_2:= owners[2].EmpID ;
    SELF.dotID_2:= owners[2].DotID ;
    SELF.orig_name_2:= owners[2].orig_name ;
    SELF.orig_name_type_code_2:= owners[2].orig_name_type_code;
    SELF.orig_name_type_description_2:= owners[2].orig_name_type_description ;
    SELF.orig_name_first_2:= owners[2].orig_name_first ;
    SELF.orig_name_middle_2:= owners[2].orig_name_middle ;
    SELF.orig_name_last_2:= owners[2].orig_name_last ;
    SELF.orig_address_1_2:= owners[2].orig_address_1 ;
    SELF.orig_address_2_2:= owners[2].orig_address_2 ;
    SELF.orig_fips_2:= owners[2].orig_fips ;
    SELF.orig_province_2:=owners[2].orig_province ;
    SELF.orig_country_2:=owners[2].orig_country ;
    SELF.dob_2:= owners[2].dob ;
    SELF.orig_ssn_2:= owners[2].orig_ssn ;
    SELF.orig_fein_2:= owners[2].orig_fein ;
    SELF.gender_2:= owners[2].gender ;
    SELF.phone_1_2:= owners[2].phone_1 ;
    SELF.phone_2_2:= owners[2].phone_2 ;
    SELF.title_2:= owners[2].title ;
    SELF.fname_2:= owners[2].fname ;
    SELF.mname_2:= owners[2].mname ;
    SELF.lname_2:= owners[2].lname ;
    SELF.name_suffix_2:= owners[2].name_suffix ;
    SELF.company_name_2:= owners[2].company_name ;
    SELF.prim_range_2:= owners[2].prim_range ;
    SELF.predir_2:= owners[2].predir ;
    SELF.prim_name_2:= owners[2].prim_name ;
    SELF.suffix_2:= owners[2].suffix ;
    SELF.postdir_2:= owners[2].postdir ;
    SELF.unit_desig_2:= owners[2].unit_Desig ;
    SELF.sec_range_2:= owners[2].sec_range ;
    SELF.p_city_name_2:= owners[2].p_city_name ;
    SELF.v_city_name_2:= owners[2].v_city_name ;
    SELF.st_2:= owners[2].st ;
    SELF.zip5_2:= owners[2].zip5 ;
    SELF.zip4_2:= owners[2].zip4 ;
    SELF.county_2:= owners[2].county ;
    
    Engines := CHOOSEN(PROJECT(L.engines,WatercraftV2_services.Layouts.engine_rec),3);
    
    SELF.watercraft_number_of_engines := engines[1].watercraft_number_of_engines;
    SELF.engine_1_number := engines[1].engine_number;
    SELF.engine_1_make := engines[1].engine_make;
    SELF.engine_1_model := engines[1].engine_model;
    SELF.engine_1_year := engines[1].engine_year;
    SELF.watercraft_hp_1 := engines[1].watercraft_hp;
    
    SELF.engine_2_number := engines[2].engine_number;
    SELF.engine_2_make := engines[2].engine_make;
    SELF.engine_2_model := engines[2].engine_model;
    SELF.engine_2_year := engines[2].engine_year;
    SELF.watercraft_hp_2 := engines[2].watercraft_hp;

    SELF.engine_3_number := engines[3].engine_number;
    SELF.engine_3_make := engines[3].engine_make;
    SELF.engine_3_model := engines[3].engine_model;
    SELF.engine_3_year := engines[3].engine_year;
    SELF.watercraft_hp_3 := engines[3].watercraft_hp;
    SELF.watercraft_name := L.name_of_vessel;
// FFD
    SELF.SequenceNumber := c; // ROW COUNTER
    //The main row is a combo of watercraft details and watercraft coast guard
    mainDataGroup := TRIM(FFD.Constants.DataGroups.WATERCRAFT_COASTGUARD) +'/'+ TRIM(FFD.Constants.DataGroups.WATERCRAFT_DETAILS);
    main_statements := PROJECT (l.statementids,
                                  FFD.InitializeConsumerStatementBatch
                                    (LEFT,FFD.Constants.RecordType.RS ,'main',mainDataGroup, c,L.acctno));
    owner_1_statements := PROJECT (owners[1].statementids,
                                  FFD.InitializeConsumerStatementBatch
                                    (LEFT,FFD.Constants.RecordType.RS ,'owner1',FFD.Constants.DataGroups.WATERCRAFT, c,L.acctno));
    owner_2_statements := PROJECT (owners[2].statementids,
                                  FFD.InitializeConsumerStatementBatch
                                    (LEFT,FFD.Constants.RecordType.RS ,'owner2',FFD.Constants.DataGroups.WATERCRAFT, c,L.acctno));
    
    main_dispute := IF(L.isDisputed,ROW(FFD.InitializeConsumerStatementBatch
                                            (FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,
                                              'main',mainDataGroup, c,L.acctno)));
    owner_1_dispute := IF(owners[1].isDisputed,ROW(
                                  FFD.InitializeConsumerStatementBatch
                                    (FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,
                                     'owner1',FFD.Constants.DataGroups.WATERCRAFT, c,L.acctno)));
    owner_2_dispute := IF(owners[2].isDisputed,ROW(
                                  FFD.InitializeConsumerStatementBatch
                                    (FFD.Constants.BlankStatementid,FFD.Constants.RecordType.DR ,
                                     'owner2',FFD.Constants.DataGroups.WATERCRAFT, c,L.acctno)));
    SELF.statements := main_statements + owner_1_statements + owner_2_statements +
                        main_dispute + owner_1_dispute + owner_2_dispute;
    
    SELF := L;
  END;

  iesp.watercraft.t_WaterCraftReport2Owner GetOwnersReport2 (WatercraftV2_services.layouts.owner_report_rec L) := TRANSFORM
    SELF.UniqueId := INTFORMAT((UNSIGNED)L.did,12,1);
    SELF.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, L.orig_name);
    SELF.NameType := L.orig_name_type_description ;
    SELF.CompanyName := L.company_name;
    CountyName := IF(L.st!='' AND L.county!='',Census_data.Key_Fips2County(KEYED(L.st=state_code AND L.county=county_fips))[1].county_name,'');
    SELF.Address := iesp.ECL2ESP.SetUniversalAddress (L.prim_name, L.prim_range, L.predir, L.postdir,
                      L.suffix, L.unit_desig, L.sec_range, L.v_city_name,
                      L.st, L.zip5, L.zip4, CountyName);
    SELF.Gender := L.gender;
    SELF.DOB := iesp.ECL2ESP.toDate ((INTEGER) l.dob);
    SELF.SSN := L.ssn;
    SELF.FEIN := L.orig_fein;
    SELF.Phone1 := L.phone_1;
    SELF.Phone2 := L.phone_2;
  END;

  iesp.watercraft.t_WaterCraftReport2LienHolder GetLiensReport2 (WatercraftV2_services.Layouts.lien_rec l) := TRANSFORM
    SELF.Name := L.lien_name;
    SELF.Address := iesp.ECL2ESP.SetAddress ('', '', '', '', '', '', '', l.lien_city, l.lien_state, l.lien_zip,
                                             '', '', '', L.lien_address_1, L.lien_address_2);
    SELF.LienDate := iesp.ECL2ESP.toDate ((INTEGER4) L.lien_date);
  END;

  iesp.watercraft.t_WaterCraftReport2Engine GetEnginesReport2 (WatercraftV2_services.Layouts.engine_rec L) := TRANSFORM
    SELF.Number := L.engine_number;
    SELF.HorsePower := L.watercraft_hp;
    SELF.Make := L.engine_make;
    SELF.Model := L.engine_model;
    SELF.Year := (INTEGER) L.engine_year;
  END;

  EXPORT iesp.watercraft.t_WaterCraftReport2Record FormatReport2Record (watercraftV2_Services.Layouts.report_out L) := TRANSFORM
    SELF.isCurrent := L.rec_type[1] = 'C';// 'Current'
    SELF.WatercraftKey := L.watercraft_key;
    //Self.SequenceKey := L.sequence_key;
    SELF.DateLastSeen := iesp.ECL2ESP.toDate((INTEGER4) L.Date_Last_Seen);
    SELF.NonDMVSource := L.NonDMVSource;
    SELF.Registration.StateOrigin := L.state_origin;
    SELF.Registration.StateOriginName := L.state_origin_full;
    SELF.Registration.Number := L.registration_number;
    SELF.Registration.RegistrateDate := iesp.ECL2ESP.toDate((INTEGER4) L.registration_date);
    SELF.Registration.ExpirationDate := iesp.ECL2ESP.toDateString8( L.registration_expiration_date);
    
    SELF.Registration.Status := L.registration_status_description;
    SELF.Registration.RenewDate := iesp.ECL2ESP.toDate((INTEGER4) L.registration_renewal_date);
    SELF.Registration.DecalNumber := L.decal_number;
    SELF.Registration.PrevPlateState := '';
    SELF.Description.HullNumber := L.hull_number;
    SELF.Description.VesselId := L.vessel_id;
    SELF.Description.VesselDatabaseKey := L.vessel_database_key;
    SELF.Description.PartyIdNumber := L.party_identification_number;
    SELF.Description.IMONumber := L.imo_number;
    SELF.Description.CallSign := L.call_sign;
    SELF.Description.Propulsion := L.propulsion_description;
    SELF.Description.VesselType := L.vehicle_type_description;
    SELF.Description.Fuel := L.fuel_description;
    SELF.Description.HullType := L.hull_type_description;
    SELF.Description.Use := L.use_description;
    SELF.Description.ModelYear := (INTEGER4) L.model_year;
    SELF.Description.VesselName := L.name_of_vessel;
    SELF.Description.Class := L.watercraft_class_description;
    SELF.Description.Make := L.watercraft_make_description;
    SELF.Description.Model := L.watercraft_model_description;
    SELF.Description.LENGTH := L.watercraft_length;
    SELF.Description.Width := L.watercraft_width;
    SELF.Description.Weight := L.watercraft_weight;
    SELF.Description.Color1 := L.watercraft_color_1_description;
    SELF.Description.Color2 := L.watercraft_color_2_description;
    SELF.Description.Toilet := L.watercraft_toilet_description;
    SELF.Description.CoastGuardNumber := L.coast_guard_number;
    SELF.Description.StatePurchased := L.state_purchased;
    SELF.Description.PurchaseDate := iesp.ECL2ESP.toDate((INTEGER4) L.purchase_date);
    SELF.Description.Dealer := L.dealer;
    SELF.Description.PurchasePrice := L.purchase_price;
    val := STD.STR.ToUpperCase(L.new_used_flag);
    SELF.Description.NewOrUsed := IF(val='Y' OR val='T',TRUE,FALSE);
    SELF.Description.RegisteredMeasurements.GrossTons := L.registered_gross_tons;
    SELF.Description.RegisteredMeasurements.NetTons := L.registered_net_tons;
    SELF.Description.RegisteredMeasurements.LENGTH := L.registered_length;
    SELF.Description.RegisteredMeasurements.Breadth := L.registered_breadth;
    SELF.Description.RegisteredMeasurements.Depth := L.registered_depth;
    SELF.Description.InternationalTonnageConvention.GrossTons := L.itc_gross_tons;
    SELF.Description.InternationalTonnageConvention.NetTons := L.itc_net_tons;
    SELF.Description.InternationalTonnageConvention.LENGTH := L.itc_length;
    SELF.Description.InternationalTonnageConvention.Breadth := L.itc_breadth;
    SELF.Description.InternationalTonnageConvention.Depth := L.itc_depth;
    SELF.Description.HailingPort.Name := L.Hailing_Port;
    SELF.Description.HailingPort.State := L.hailing_port_state;
    SELF.Description.HailingPort.Province := L.hailing_port_province;
    SELF.Description.HomePort.Name := L.home_port_name;
    SELF.Description.HomePort.State := L.home_port_state;
    SELF.Description.HomePort.Province := L.home_port_province;
    SELF.Description.Manufacture.ShipYard := L.ship_yard;
    SELF.Description.Manufacture.YearBuilt := (INTEGER4) L.vessel_build_year;
    SELF.Description.Manufacture.HullBuildAddress := ROW ({'', '', '', '', '', '',
                          '', '', '', L.Vessel_Hull_Build_state, L.Vessel_Hull_Build_city, '', '', '',
                          '', '',L.Vessel_Hull_Build_Country,L.Vessel_Hull_Build_Province,''}, iesp.share.t_UniversalAddress);
                                                               
    SELF.Description.Manufacture.CompleteBuildAddress := ROW ({'', '', '', '', '', '',
                          '', '', '', L.vessel_complete_Build_state, L.vessel_complete_Build_city, '', '', '',
                          '', '',L.vessel_complete_Build_Country,L.vessel_complete_Build_Province,''}, iesp.share.t_UniversalAddress);
    SELF.Description.HPAstern := L.main_hp_astern;
    SELF.Description.HPAhead := L.main_hp_ahead;
    SELF.Description.FleetId := '';
    SELF.Title.TransactionType := L.transaction_type_description;
    SELF.Title.State := L.title_state;
    SELF.Title.Status := L.title_status_description;
    SELF.Title.Number := L.title_number;
    SELF.Title.IssueDate := iesp.ECL2ESP.toDate((INTEGER4) L.title_issue_date);
    SELF.Title._Type := L.title_type_description;
    SELF.Title.Signatory := L.signatory;
    SELF.owners := CHOOSEN (PROJECT(L.Owners, GetOwnersReport2(LEFT)), iesp.Constants.WATERCRAFTS.MaxOwners); // CHOOSEN (PROJECT (L.owners, GetOwners (LEFT)), iesp.Constants.WATERCRAFTS.MaxOwners);
    liens_ddp := DEDUP (SORT (L.lienholders, RECORD, -lien_date), EXCEPT lien_date);
    SELF.LienHolders := CHOOSEN (PROJECT (liens_ddp, GetLiensReport2 (LEFT)), iesp.Constants.WATERCRAFTS.MaxLienholders);
    eng_ddp := DEDUP (SORT (L.engines, watercraft_hp, engine_make, engine_model), watercraft_hp, engine_make, engine_model);
    SELF.engines := CHOOSEN (PROJECT (eng_ddp, GetEnginesReport2(LEFT)), iesp.Constants.WATERCRAFTS.MaxEngines);
    SELF := [];
  END;


  seqkey_plus_iesp_wc := RECORD
    watercraftV2_Services.Layouts.report_out.sequence_key;
    iesp.watercraft.t_WaterCraftReport2Record;
  END;

  EXPORT seqkey_plus_iesp_wc FormatReport2Record_plus (watercraftV2_services.Layouts.report_out L) := TRANSFORM
    SELF.sequence_key := L.sequence_key;
    SELF := PROJECT(L,FormatReport2Record(LEFT));
  END;

END;
