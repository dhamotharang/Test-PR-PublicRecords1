
IMPORT AutoStandardI, BatchServices, iesp, PAW_Services, doxie;

EXPORT Plus_SearchService_Records() :=
  MODULE

    SHARED input_params := AutoStandardI.GlobalModule();
    SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);

    EXPORT params := INTERFACE
      EXPORT BOOLEAN include_spouse;
      EXPORT STRING excluded_sources;
      EXPORT UNSIGNED2 penaltThreshold;
    END;
  
    // Formal parameter for WorkPlace Locator (WPL).
    SHARED tempmod_for_WPL_Search(params in_mod) :=
      MODULE(PROJECT(input_params,WorkPlace_Services.Search_Records.params,OPT));
        SHARED application_type := AutoStandardI.InterfaceTranslator.application_type_val;
        EXPORT BOOLEAN include_spouse := in_mod.include_spouse;
        EXPORT STRING excluded_sources := in_mod.excluded_sources;
        EXPORT STRING32 applicationType := application_type.val(PROJECT(input_params,application_type.params));
      end;

    // Formal parameter for People-At-Work (PAW): since the output layout will be that of the Workplace
    // Plus Search Service, i.e. having no child datasets, we need to set most of the cardinalities listed
    // below to '1'. The only cardinality we'll set to something other than '1' will be the number of
    // employers, which will themselves consistute separate records and not any particular child dataset.
    SHARED tempmod_for_PAW_Search(params in_mod) := FUNCTION
      mod_temp := MODULE(input_params, mod_access)
        EXPORT string DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition
        EXPORT string DataRestrictionMask := mod_access.DataRestrictionMask; //conflicting definition
        EXPORT UNSIGNED2 REQ_PHONES_PER_ADDR := 1;
        EXPORT UNSIGNED2 REQ_DATES_PER_POSITION := 1;
        EXPORT UNSIGNED2 REQ_DATES_PER_EMPLOYER := 1;
        EXPORT UNSIGNED2 REQ_FEINS_PER_EMPLOYER := 1;
        EXPORT UNSIGNED2 REQ_COMPANY_NAMES_PER_EMPLOYER := 1;
        EXPORT UNSIGNED2 REQ_ADDRS_PER_EMPLOYER := 1;
        EXPORT UNSIGNED2 REQ_POSITIONS_PER_EMPLOYER := 1;
        EXPORT UNSIGNED2 REQ_SSNS_PER_PERSON := 1;
        EXPORT UNSIGNED2 REQ_NAMES_PER_PERSON := 1;
        EXPORT UNSIGNED2 REQ_EMPLOYERS_PER_PERSON := PAW_Services.Constants.MAX_EMPLOYERS_PER_PERSON;
        EXPORT AllowNicknames := FALSE;
        EXPORT CleanFMLName := FALSE;
        EXPORT PhoneticMatch := FALSE;
        EXPORT PenaltThreshold := in_mod.PenaltThreshold;
        EXPORT includeAlsoFound := FALSE;
      END;
      RETURN PROJECT(mod_temp, PAW_Services.PAWSearchService_Records.params, OPT);
    END;

    EXPORT get_PAW_records(params in_mod) :=
      FUNCTION
        tempmod_paw := tempmod_for_PAW_Search(in_mod);
        paw_contact_ids := paw_services.PAWSearchService_IDs.val(tempmod_paw);
        ds_paw_records := PAW_Services.PAWSearchService_Records.val(paw_contact_ids,tempmod_paw);

        iesp.workplaceplus.t_WorkPlacePlusSearchRecord formatPAW(paw_services.PAW_OutRecsLayout le, INTEGER c) :=
          TRANSFORM
            SELF.SSN := le.ssns[1].ssn;
            SELF.SubjectUniqueId := (STRING)le.did;
            SELF.Name.First := le.names[1].fname;
            SELF.Name.Middle := le.names[1].mname;
            SELF.Name.Last := le.names[1].lname;
            SELF.Name.Suffix := le.names[1].name_suffix;
            SELF.Name.Prefix := le.names[1].title;
            SELF.CompanyData.CompanyName := le.employers[c].company_names[1].company_name;
            SELF.CompanyData.Address.StreetNumber := le.employers[c].addrs[1].prim_range;
            SELF.CompanyData.Address.StreetPreDirection := le.employers[c].addrs[1].predir;
            SELF.CompanyData.Address.StreetName := le.employers[c].addrs[1].prim_name;
            SELF.CompanyData.Address.StreetSuffix := le.employers[c].addrs[1].addr_suffix;
            SELF.CompanyData.Address.StreetPostDirection := le.employers[c].addrs[1].postdir;
            SELF.CompanyData.Address.UnitDesignation := le.employers[c].addrs[1].unit_desig;
            SELF.CompanyData.Address.UnitNumber := le.employers[c].addrs[1].sec_range;
            SELF.CompanyData.Address.City := le.employers[c].addrs[1].city;
            SELF.CompanyData.Address.State := le.employers[c].addrs[1].state;
            SELF.CompanyData.Address.Zip5 := le.employers[c].addrs[1].zip;
            SELF.CompanyData.Address.Zip4 := le.employers[c].addrs[1].zip4;
            SELF.CompanyData.Phone10 := le.employers[c].addrs[1].phones[1].phone10;
            SELF.CompanyData._FEIN := le.employers[c].feins[1].fein;
            SELF.BusinessId := (STRING12)le.employers[c].bdid;
            SELF.BusinessIds.DotID := le.employers[c].DotID;
            SELF.BusinessIds.EmpID := le.employers[c].EmpID;
            SELF.BusinessIds.POWID := le.employers[c].POWID;
            SELF.BusinessIds.ProxID := le.employers[c].ProxID;
            SELF.BusinessIds.SeleID := le.employers[c].SeleID;
            SELF.BusinessIds.OrgID := le.employers[c].OrgID;
            SELF.BusinessIds.UltID := le.employers[c].UltID;
            SELF.DateLastSeen := iesp.ECL2ESP.toDate((UNSIGNED4)le.employers[c].positions[1].dates[1].dt_last_seen);
            SELF := [];
          END;
        
        ds_results_PAW_search := NORMALIZE(ds_paw_records, COUNT(LEFT.employers), formatPAW(LEFT,COUNTER));
                
        RETURN ds_results_PAW_search;
      END;
    
    EXPORT get_WPL_records(params in_mod) :=
      FUNCTION
        tempmod_wpl := tempmod_for_WPL_Search(in_mod);
          
        // Since WorkPlace_Services.Functions.getSubjectDids will Fail( ) if the input criteria
        // evaluate to more than 1 did--thus failing the entire "Plus" search, we must cause
        // Search_Records in such a case to avoid the Fail( ) so that the PAW can continue
        // to run. To do this, we'll cause Search_Records to retrieve no dids at all.
        
        // 1. Check here first to see if there's more than 1 did.

        // 1.a. Convert input soap/xml fields into a single record batch to obtains dids.
        ds_batch_in := Search_Records.get_single_record_batch(tempmod_wpl);

        // 1.b. Convert to upper case.
        ds_batch_in_caps :=
          project(ds_batch_in, BatchServices.transforms.xfm_capitalize_input(left));

        // 1.c. Get the DID(s) associated with the input record.
        ds_acctnos_dids_appended :=
            BatchServices.Functions.fn_find_dids_and_append_to_acctno(ds_batch_in_caps);

        // 2. Count the dids and sett the boolean flag.
        
        // 2.a. Determine whether the input resolved to 1 did.
        layout_dids_count := RECORD
          ds_acctnos_dids_appended.acctno;
          did_count := COUNT(GROUP);
        END;
      
        ds_acctnos_dids_table := table(ds_acctnos_dids_appended,layout_dids_count,acctno,few);
        
        // Since this is a search service, there will only ever be 1 accno./record in this
        // dataset. Therefore reference [1].
        too_many_dids := ds_acctnos_dids_table[1].did_count > BatchServices.WorkPlace_Constants.Limits.DID_LIMIT;
            
        // 4. Define a tempmod that will cause Search_Records to retrieve no dids before
        // the FAIL( ) action is invoked if there are too_many_dids, thereby allowing the
        // PAW branch to continue.
        //
        // NOTE: Using a simple IF-statement to not run Search_Records when too_many_dids = TRUE
        // doesn't work: the 'then' and 'else' branches are both evaluated, and the query fails.
        
        mod_wpl := MODULE( PROJECT(tempmod_wpl, WorkPlace_Services.Search_Records.params) )
          EXPORT hasTooManyDidsButAvoidFail := too_many_dids;
        END;
        
        // 5. Get the WPL records (or not) and project into the "plus" layout.
        workplace_records_pre := WorkPlace_Services.Search_Records.val(mod_wpl);

        workplace_records := PROJECT( workplace_records_pre, iesp.workplaceplus.t_WorkPlacePlusSearchRecord );
        
        RETURN workplace_records;
      END;
      
  END;
