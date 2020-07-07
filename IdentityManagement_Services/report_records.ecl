/***
 ** Module calls each individual service and exports each dataset returned.
***/

IMPORT doxie, DriversV2_Services, Gong_services, American_Student_Services,
        VehicleV2_Services, WatercraftV2_Services, LN_PropertyV2_Services,
        FaaV2_Services, PersonReports, iesp, doxie_raw, IdentityManagement_Services;

EXPORT report_records  (DATASET(doxie.layout_references) dids, IdentityManagement_Services.IParam._report in_params) := MODULE

      SHARED mod_access := PROJECT(in_params, Doxie.IDataAccess);
// =======================================================================
// ============================= Person Section ==========================
// =======================================================================
      esp_person := IdentityManagement_Services.format_person(dids);

      EXPORT person_report := esp_person;

// =======================================================================
// =============================  Properties =============================
// =======================================================================
      properties_r := LN_PropertyV2_Services.resultFmt.narrow_view.get_by_did(dids);

      esp_propertyV2 := IdentityManagement_Services.format_property(properties_r);

      EXPORT property_v2 := esp_propertyV2;

// =======================================================================
// ====================== Driver License (Sub)Section ====================
// =======================================================================
      dlsr := DriversV2_Services.DLRaw.narrow_view.by_did (dids);

      esp_drivers_v2 := IdentityManagement_Services.format_dl(dlsr);

      EXPORT driver_licenses_v2 := esp_drivers_v2;

// =======================================================================
// ====================== Insurance Driver License =======================
// =======================================================================
      insdlr := IdentityManagement_Services.InsuranceDLRecords (in_params, dids);

      esp_ins_dl := IdentityManagement_Services.format_insurance_dl(insdlr);

      EXPORT insurance_dl := esp_ins_dl;

// =======================================================================
// =============================    Phones   =============================
// =======================================================================

      //Gong
      phone_rec := Gong_Services.Layout_GongHistorySearchService;
      phonesr := PROJECT(Gong_Services.Fetch_Gong_History(dids, mod_access,
        did_onlyL:= true, SuppressNoncurrent := true), phone_rec);

      //Phones Plus
      UNSIGNED1 score_threshold_value := 10; // used in macro
      phonespp := doxie.MAC_Get_GLB_DPPA_PhonesPlus(dids, mod_access, true, , 0, , , false);

      did_set := SET(dids, did); //there should only be one did in did_set

      esp_hist_phones := IdentityManagement_Services.format_phone(phonesr(did IN did_set), phonespp(did IN did_set)); //Use only records with same did as input

      EXPORT hist_phones := esp_hist_phones;

// =======================================================================
// =============================   Student   =============================
// =======================================================================
     students_rest_mod := PROJECT (in_params, American_Student_Services.IParam.reportParams);
     students_raw := American_Student_Services.Raw.getPayloadByDIDS(PROJECT(dids, American_Student_Services.Layouts.deepDids),students_rest_mod);
      studentsr := American_Student_Services.Functions.apply_restrictions(students_raw, students_rest_mod);
      studentsf := IdentityManagement_Services.Functions.debatable_names(studentsr,American_Student_Services.Layouts.finalrecs,LN_college_name);

      esp_students := IdentityManagement_Services.format_students(studentsf);

      EXPORT students := esp_students;

// =======================================================================
// =========================  Vehicles Section ===========================
// =======================================================================

      veh_mod := module (PROJECT (in_params, VehicleV2_Services.IParam.reportParams, OPT))
        export boolean displayMatchedParty := true; // this corresponds to #CONSTANT('DisplayMatchedParty', true); at the top level
        export boolean IncludeNonRegulatedSources := in_params.include_noregulatedvehicles;
        export unsigned4 lookupValue := doxie.lookup_bit('');
            // this is to avoid a call to AutoStandardI.InterfaceTranslator.lookup_value.val();
      end;

      vehi := VehicleV2_Services.raw.get_vehicle_crs_report (veh_mod, dids);

      esp_vehicles_V2 := IdentityManagement_Services.format_vehicles(vehi);

      EXPORT vehicles_V2 := esp_vehicles_V2;

// =======================================================================
// ==========================  Watercraft ================================
// =======================================================================
      watercraftsr := WatercraftV2_Services.WatercraftV2_raw.Report_View.by_did (
                        dids,
                        in_params.SSN_mask,
                        true,
                        include_non_regulated_sources := in_params.include_noregulatedwatercrafts);

      esp_watercrafts_V2 := IdentityManagement_Services.format_watercraft(watercraftsr);

      EXPORT watercrafts_V2 := esp_watercrafts_V2;

// =======================================================================
// ==========================  Aircraft  =================================
// =======================================================================
      aircraft_ids := PROJECT (FaaV2_Services.raw.ByDids (dids), FaaV2_Services.layouts.search_id);

      aircraft_recs := FaaV2_Services.raw.getFullAircraft(aircraft_ids,in_params.application_type);

      esp_aircraft_V2 := IdentityManagement_Services.format_FAA(aircraft_recs);

      EXPORT aircrafts_V2 := esp_aircraft_V2;

// =======================================================================
// =========================  Relatives ==================================
// =======================================================================
      EXPORT relatives := IdentityManagement_Services.RARecords(in_params, dids).relatives;

// =======================================================================
// ========================   Associates   ===============================
// =======================================================================
      EXPORT associates := IdentityManagement_Services.RARecords(in_params, dids).associates;

// =======================================================================
// ==========================  Nbrs Data   ===============================
// =======================================================================
      EXPORT neighbors  := IdentityManagement_Services.NeighborsRecords(in_params, dids);

// =======================================================================
// ======================  People At Work   ===============================
// =======================================================================
      paw_recs := PersonReports.peopleatwork_records(dids,Module(PROJECT (in_params,PersonReports.IParam.peopleatwork, OPT))end);
      EXPORT peopleatwork := IdentityManagement_Services.Functions.debatable_names(paw_recs,iesp.peopleatwork.t_PeopleAtWorkRecord, CompanyName);

// =======================================================================
// ===================== Corp Affiliation  ================================
// =======================================================================
      corp_aff_recs := PersonReports.CorpAffiliation_records(dids);
      EXPORT corpaffiliation := IdentityManagement_Services.Functions.debatable_names(corp_aff_recs,iesp.bpsreport.t_BpsCorpAffiliation, CompanyName);

// =======================================================================
// ========================   Emails   ===================================
// =======================================================================
      EXPORT emails := PersonReports.email_records(dids, PROJECT(in_params, PersonReports.IParam.emails, OPT));

// =======================================================================
// =====================  Vehicle From Gateways   =========================
// =======================================================================
      EXPORT veh_gateways  := doxie.Comp_RealTime_Vehicles(dids).do;

// =======================================================================
// ==========================  Chase Data   ===============================
// =======================================================================
      EXPORT transactions  := doxie.TransactionHistory_Records(dids);

// =======================================================================
// ====================  Professional License Data  ======================
// =======================================================================
      profmod  :=  personReports.proflic_records(dids, PROJECT (in_params, PersonReports.IParam.proflic));
      esp_proflicense :=  PROJECT(profmod.proflicenses_v2, iesp.identitymanagementreport.t_IdmProfessionalLicense)(LicenseNumber <> '');
      filtered_proflicense := DEDUP(SORT(esp_proflicense,LicenseNumber,ProfessionOrBoard,-DateLastSeen),LicenseNumber,ProfessionOrBoard);

      EXPORT proflicense := SORT(filtered_proflicense,-DateLastSeen);
// =======================================================================
// ====================  Internet Domain Names  ======================
// =======================================================================

  //Fetching internet domain names from Key_Whois_Did
  domain_raw :=  Doxie_Raw.WhoIs_Raw(dids, ,'',,,);

  EXPORT domain_names := IdentityManagement_Services.format_domainnames(domain_raw);

END;
