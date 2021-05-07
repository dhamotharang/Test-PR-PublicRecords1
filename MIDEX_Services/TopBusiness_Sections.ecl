IMPORT AutoStandardI, BIPV2, doxie, MIDEX_Services, TopBusiness_Services;
EXPORT TopBusiness_Sections( DATASET(BIPV2.IDlayouts.l_xlink_ids) in_linkid,
                             doxie.IDataAccess mod_access,
                             STRING1 BusinessIDFetchLevel, BOOLEAN IncludeVendorSourceB,
                             BOOLEAN IncludeAssignmentsAndReleases) :=
  FUNCTION
  
  in_topbusiness_ds := PROJECT(in_linkid,
      TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
        SELF.acctno := '001';
        SELF := LEFT));
        
  TopBusiness_Services.BusinessReportComprehensive_Layouts xform_topbusiness_options() := TRANSFORM
    SELF.IncludeAssociatedBusinesses := TRUE;
    SELF.IncludeBankruptcies := TRUE;
    SELF.IncludeContacts := TRUE; //executives (current and prior), individuals (current and prior), etc.
    SELF.IncludeLiensJudgments := TRUE;
    SELF.IncludeProperties := TRUE;
    SELF.IncludeNameVariations := TRUE;
    SELF.IncludeParents := TRUE;
    SELF.IncludeOpsSites := TRUE;
    SELF.IncludeIncorporation := TRUE;
    SELF.IncludeConnectedBusinesses := TRUE;
    SELF.IncludeRegisteredAgents := TRUE;
    SELF.BusinessReportFetchLevel := BusinessIDFetchLevel;
    SELF.ApplicationType := mod_access.Application_Type;
    SELF.IncludeVendorSourceB := IncludeVendorSourceB;
    SELF.IncludeAssignmentsAndReleases := IncludeAssignmentsAndReleases;
    SELF := [];
  END;
  in_topbusiness_options := ROW(xform_topbusiness_options());
  
  in_topbusiness_mod := MODULE (AutoStandardI.DataRestrictionI.params)
    EXPORT BOOLEAN AllowAll := mod_access.unrestricted = doxie.compliance.ALLOW.ALL;
    EXPORT BOOLEAN AllowGLB := mod_access.unrestricted & doxie.compliance.ALLOW.GLB > 0;
    EXPORT BOOLEAN AllowDPPA := mod_access.unrestricted & doxie.compliance.ALLOW.DPPA >0;
    EXPORT UNSIGNED1 DPPAPurpose := mod_access.dppa;
    EXPORT UNSIGNED1 GLBPurpose := mod_access.glb;
    EXPORT BOOLEAN IncludeMinors := mod_access.show_minors;
    EXPORT BOOLEAN restrictPreGLB := mod_access.isPreGlbRestricted();
    EXPORT STRING DataRestrictionMask := mod_access.DataRestrictionMask;
    EXPORT BOOLEAN ignoreFares := FALSE;
    EXPORT BOOLEAN ignoreFidelity := FALSE;
  END;

  // Per Don L., don't call Guts directly but rather call the TopBusiness_Services sections as needed in a similar fashion as Guts
  
  // set the dotid/empid/powid values to 0 regardless of what is in input
  // This is how the BIP report (TopBusiness_Services/BusinessReportService) currently works
  ds_input_data := PROJECT(in_linkid,
    TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
      SELF.acctno := '001';
      SELF.dotid := 0;
      SELF.empid := 0;
      SELF.powid := 0;
      SELF := LEFT));

  ds_in_unique_ids_only := PROJECT(in_linkid,
    TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
      SELF.dotid := 0;
      SELF.powid := 0;
      SELF.empid := 0;
      SELF.proxweight := 0;
      SELF.proxscore := 0;
      SELF.seleweight := 0;
      SELF.selescore := 0;
      SELF.ultscore := 0;
      SELF.ultweight := 0;
      SELF.dotscore := 0;
      SELF.dotweight := 0;
      SELF.orgscore := 0;
      SELF.orgweight := 0;
      SELF.powscore := 0;
      SELF.powweight := 0;
      SELF.empscore := 0;
      SELF.empweight := 0;
      SELF := LEFT,
      ));
                             
  ds_busHeaderRecs_pre := BIPV2.Key_BH_Linking_Ids.kfetch2(ds_in_unique_ids_only, BusinessIDFetchLevel,
                               ,, TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit, TRUE,,,, mod_access);
  ds_busHeaderRecs := PROJECT(ds_busHeaderRecs_pre, BIPV2.Key_BH_Linking_Ids.kFetchOutRec);
  seed_results := PROJECT(ds_input_data,
    TRANSFORM(MIDEX_Services.Layouts.rec_TopBusiness,
      SELF.acctno := '001',
      SELF := []));

    BestSection := TopBusiness_Services.BestSection.fn_fullView(
        in_topbusiness_ds, // passing IN full SET of ids with dot/emp/pow possibly populated
                      // will zero out as needed in best
        PROJECT(DATASET(in_topbusiness_options),
          TRANSFORM(TopBusiness_Services.BestSection_Layouts.rec_OptionsLayout, SELF := LEFT, SELF := []))[1],
        in_topbusiness_mod,
        ds_busheaderRecs
        );
 
  // save best cname and pass to property section below.
 bestCname := BestSection[1].CompanyName;

    ParentSection := TopBusiness_Services.ParentSection.fn_fullView(
      PROJECT(ds_input_data, TRANSFORM(TopBusiness_Services.ParentSection_Layouts.rec_Input, SELF := LEFT)),
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.layouts.rec_input_options)[1],
      in_topbusiness_mod,
      ds_busHeaderRecs);
    
    AssociateSection := TopBusiness_Services.AssociateSection.fn_fullView(
      ds_input_data,
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.Layouts.rec_input_options)[1],
      mod_access);

    ContactSection := TopBusiness_Services.ContactSection.fn_fullView(
      PROJECT(ds_input_data, TRANSFORM(TopBusiness_Services.ContactSection_Layouts.rec_Input, SELF := LEFT))
      ,PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.ContactSection_Layouts.rec_OptionsLayout)[1],
      in_topbusiness_mod);
      
    IncorporationSection := TopBusiness_Services.IncorporationSection.fn_fullView(
      ds_input_data,
      PROJECT(DATASET(in_topbusiness_options), TopBusiness_Services.Layouts.rec_input_options)[1],
      in_topbusiness_mod);
  
    PropertySection := TopBusiness_Services.PropertySection.fn_fullView(
      PROJECT(ds_input_data,
          TRANSFORM(TopBusiness_Services.PropertySection_Layouts.rec_Input, SELF := LEFT))
      ,PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.PropertySection_Layouts.rec_OptionsLayout)[1]
      ,in_topbusiness_mod
      ,bestCname);

  // Save off Property Section, "Properties" child dataset to pass into the Ops/Sites Section below.

   ds_properties := PropertySection[1].PropertyRecords.Properties;

    operationsSitesSection := TopBusiness_Services.OperationsSitesSection.fn_fullView(
      ds_input_data,
      PROJECT(DATASET(in_topbusiness_options), TopBusiness_Services.Layouts.rec_input_options)[1],
      in_topbusiness_mod,
      ds_properties
      ,ds_busHeaderRecs);
  
    BankruptcySection := TopBusiness_Services.BankruptcySection.fn_fullView(
      PROJECT(ds_input_data, TRANSFORM(TopBusiness_Services.BankruptcySection_Layouts.rec_Input, SELF := LEFT)),
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.BankruptcySection_Layouts.rec_OptionsLayout)[1],
      in_topbusiness_mod);

    liensSection := TopBusiness_Services.LienSection.fn_fullView(
      ds_input_data,
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.Layouts.rec_input_options)[1],
      in_topbusiness_mod);

    RegisteredAgentsSection := TopBusiness_Services.RegisteredAgentSection.fn_fullView(
      PROJECT(ds_input_data, TRANSFORM(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_Input, SELF := LEFT)),
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.RegisteredAgentSection_Layouts.rec_OptionsLayout)[1],
      in_topbusiness_mod);
    
    ConnectedBusinessSection := TopBusiness_Services.ConnectedBusinessSection.fn_fullView(
      PROJECT(ds_input_data, TRANSFORM(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_Input, SELF := LEFT)),
      PROJECT(DATASET(in_topbusiness_options),TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_OptionsLayout)[1],
      in_topbusiness_mod);
      
  MIDEX_Services.Layouts.rec_TopBusiness topBusinessSections() := TRANSFORM
        SELF.acctno := '001';
     SELF.BestSection := BestSection[1];
     SELF.ParentSection := ParentSection[1];
     SELF.AssociateSection := AssociateSection[1];
     SELF.ContactSection := ContactSection[1];
     SELF.IncorporationSection := IncorporationSection[1];
     SELF.PropertySection := PropertySection[1];
     SELF.OperationsSitesSection := operationsSitesSection[1];
     SELF.BankruptcySection := BankruptcySection[1];
     SELF.LienSection := liensSection[1];
     SELF.RegisteredAgentSection := RegisteredAgentsSection[1];
     SELF.ConnectedBusinessSection := ConnectedBusinessSection[1];
     SELF := [];
   END;
    topBusinessRecs := DATASET( [ topBusinessSections() ]);
    
  RETURN topBusinessRecs;
END;
