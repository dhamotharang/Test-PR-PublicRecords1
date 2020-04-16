import topBusiness_services, iesp, AutoStandardI, BIPV2, Doxie;

export Guts := MODULE
 
// PLEASE NOTE DO NOT CHANGE THE ORDERING OF THE WAY THE SECTIONS ARE CALLED IN THIS ATTRIBUTE
// it is done this way in order to implement future changes for BIP 2.0 project.
//
	export getReport(
		dataset( TopBusiness_Services.Layouts.rec_input_ids) ds_tmpinput_data,		
		TopBusiness_Services.BusinessReportComprehensive_Layouts in_options,
		AutoStandardI.DataRestrictionI.params in_mod
		) := function
// inputs -- ultid, orgid, seleid, proxid, powid, empid, dotid
//  options
	mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
// output rows from the various base files
 
	section_aircraft      := in_options.IncludeAircrafts OR in_options.IncludeBusinessInsight;
	section_associateBus  := in_options.IncludeAssociatedBusinesses;
	section_bankruptcy    := in_options.IncludeBankruptcies; 
  section_BusinessInsight := in_options.IncludeBusinessInsight;
  section_connectedBusinesses := in_options.IncludeConnectedBusinesses;
	section_contact       := in_options.IncludeContacts  OR in_options.IncludeBusinessInsight;
	section_finance       := in_options.IncludeFinances OR in_options.IncludeBusinessInsight;
	section_incorporation := in_options.IncludeIncorporation; 
	section_industry      := in_options.IncludeIndustries  OR in_options.IncludeBusinessInsight;
	section_licenses      := in_options.IncludeProfessionalLicenses;
	section_lien          := in_options.IncludeLiensJudgments; 
	section_motorvehicle  := in_options.IncludeMotorVehicles OR in_options.IncludeBusinessInsight;
	section_opssites      := in_options.IncludeOpsSites;
	section_parent        := in_options.IncludeParents; 
	section_property      := in_options.IncludeProperties OR in_options.IncludeBusinessInsight;
	section_registeredAgents := in_options.IncludeRegisteredAgents;
	section_sources       := in_options.IncludeSourceCounts OR in_options.IncludeBusinessInsight;
	section_ucc           := in_options.IncludeUCCFilings OR in_options.IncludeBusinessInsight;
	section_uccSecureds   := (in_options.IncludeUCCFilings AND in_options.IncludeUCCFilingsSecureds) OR in_options.IncludeBusinessInsight;;
	section_url           := in_options.IncludeInternetDomains; 
  section_watercraft    := in_options.IncludeWatercrafts OR in_options.IncludeBusinessInsight;

  // For "Accurint" only additional sections	
	section_businessRegistrations := in_options.IncludeBusinessRegistrations;
	section_companyVerification   := in_options.IncludeCompanyVerification;
	section_dnb                   := in_options.IncludeDunBradStreet;
	section_ebr                   := in_options.IncludeExperianBusinessReports;
	section_IRS5500               := in_options.IncludeIRS5500;
	section_sanctions             := in_options.IncludeSanctions;
// based on what report user selects:

  // set the FETCH LEVEL for join to main bus header key 
  FETCH_LEVEL := in_options.BusinessReportFetchLevel;
	
	  // set the last 3 values of linkids to 0 regardless of what is input															  
  ds_input_data := project(ds_tmpInput_data, transform(TopBusiness_Services.Layouts.rec_input_ids,
	                          self.dotid := 0;
														self.empid := 0;
														self.powid := 0;
														self := left));

  ds_in_unique_ids_only := project(ds_tmpInput_data, 
	                            transform(BIPV2.IDlayouts.l_xlink_ids2, 	
															 self.dotid := 0;
                               self.powid := 0;															 
															 self.empid := 0;															
															 self.proxweight := 0;
															 self.proxscore := 0;
															 self.seleweight := 0;
															 self.selescore := 0;
															 self.ultscore := 0;
															 self.ultweight := 0;
															 self.dotscore := 0;
															 self.dotweight := 0;
															 self.orgscore := 0;
															 self.orgweight := 0;
															 self.powscore := 0;
															 self.powweight := 0;
															 self.empscore := 0;
															 self.empweight := 0;																
															 self := left, 														
															 ));									
  
  /////////////////////////////////////////////////////////////////////////////////															 
  // only do calls to the bus header key here for whole Business Report Query for BIP
	// and pass this along as a parameter into other functions/sections as needed.
	//
	// NOTE passing TRUE as last param here will remove any source D recs (DUN AND BRADSTREET)
	// from being
	// returned.
	// RR 188676 pass the ds_busHeaderRecs as param to sourceSection so as to eliminate
	// multiple calls to this kfetch hoping to reduce memory footprint of query and improve efficiency.
	   
       ds_busHeaderRecsForCnameVariations := project(BIPV2.Key_BH_Linking_Ids.kfetch2(ds_in_unique_ids_only,FETCH_LEVEL,
	                             , ,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimitLarger,
															 TRUE,,,,mod_access), BIPV2.Key_BH_Linking_Ids.kFetchOutRec);	
       ds_busHeaderRecs := choosen(ds_busHeaderRecsForCnameVariations,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit);											 
       											     		                          		
    BestSection :=  TopBusiness_Services.BestSection.fn_fullView(
			  ds_tmpinput_data, // passing in full set of ids with dot/emp/pow possibly populated 
		                      // will zero out as needed in best
		    project(dataset(in_options), 
					   transform(TopBusiness_Services.BestSection_Layouts.rec_OptionsLayout, self := left, self := []))[1],
				in_mod,
				ds_busHeaderRecsForCnameVariations);	
	 // save best cname and pass to property section below.
    bestCname := BestSection[1].companyName;		
	 
    parentSection := IF(section_parent, TopBusiness_Services.ParentSection.fn_fullView(
				project(ds_input_data, transform(TopBusiness_Services.ParentSection_Layouts.rec_Input, self := left)),
				project(dataset(in_options),TopBusiness_Services.ParentSection_Layouts.rec_OptionsLayout)[1],
				in_mod,
				ds_busHeaderRecs
				)
		 );
		
     AssociateSection := if (section_associateBus, TopBusiness_Services.AssociateSection.fn_fullView(
		    ds_input_data,
				project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
				mod_access)
		 );
     
		 ContactSection := if (section_contact, TopBusiness_Services.ContactSection.fn_fullView(
				project(ds_input_data, transform(TopBusiness_Services.ContactSection_Layouts.rec_Input, self := left))
				,project(dataset(in_options),TopBusiness_Services.ContactSection_Layouts.rec_OptionsLayout)[1],
				in_mod)
		 );

     IncorporationSection := if (section_incorporation, TopBusiness_Services.IncorporationSection.fn_fullView(
				ds_input_data,
				project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
				in_mod)
			);
			
      PropertySection := If (section_property, TopBusiness_Services.PropertySection.fn_fullView(			
				project(ds_input_data, 
				    transform(TopBusiness_Services.PropertySection_Layouts.rec_Input, self := left))
				,project(dataset(in_options),TopBusiness_Services.PropertySection_Layouts.rec_OptionsLayout)[1]
				,in_mod
				,bestCname)
			);
 
      ds_properties := PropertySection[1].PropertyRecords.Properties;
			 
			OperationsSitesSection := If (section_opssites, TopBusiness_Services.OperationsSitesSection.fn_fullView(
					ds_input_data,
					project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
						in_mod
						,ds_properties
						,ds_busHeaderRecs
					)
			);
			
                FinanceSection := if (section_finance,  TopBusiness_Services.FinanceSection.fn_fullView(
			  ds_input_data,				
				project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
				in_mod)
			);
				
			IndustrySection := if (section_industry, TopBusiness_Services.industrySection.fn_fullView(
					ds_input_data,				
					project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
					in_mod)
			 );
			 
                  LicenseSection := if (section_licenses, TopBusiness_Services.LicenseSection.fn_fullView(
					ds_input_data,				
					project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
					in_mod)
				);
				
				UrlSection := if (section_url, TopBusiness_Services.urlSection.fn_fullView(
					ds_input_data,				
					project(dataset(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
					in_mod,
					ds_busHeaderRecs)
				);
				
				BankruptcySection := if (section_bankruptcy,  TopBusiness_Services.BankruptcySection.fn_fullView(
					project(ds_input_data, transform(TopBusiness_Services.BankruptcySection_Layouts.rec_Input, self := left)),
					project(dataset(in_options),TopBusiness_Services.BankruptcySection_Layouts.rec_OptionsLayout)[1],
					in_mod)
				);
				
				LienSection := if (section_lien, TopBusiness_Services.LienSection.fn_fullView(
					ds_input_data,
					project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
					in_mod)
				);
				
				UccSEction := if (section_ucc,  TopBusiness_Services.UCCSection.fn_fullView(
					ds_input_data,
					project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options_ucc)[1],
				  in_mod)
				);
				
				AircraftSection := if (section_aircraft,  TopBusiness_Services.AircraftSection.fn_fullView(
					project(ds_input_data, transform(TopBusiness_Services.aircraftSection_Layouts.rec_Input, self := left)),
					project(dataset(in_options),TopBusiness_Services.AircraftSection_Layouts.rec_OptionsLayout)[1],
					in_mod)
				);
				
				MotorVehicleSection := if (section_motorVehicle,  TopBusiness_Services.MotorVehicleSection.fn_fullView(
					ds_input_data,
					project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
					mod_access)
				);
				
				WatercraftSection := if (Section_watercraft,  TopBusiness_Services.WatercraftSection.fn_fullView(
					ds_input_data,
					project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
					in_mod)
				);
				
				RegisteredAgentSection := if (Section_registeredAgents, TopBusiness_Services.RegisteredAgentSection.fn_fullView(
					project(ds_input_data, transform(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_Input, self := left)),
					project(dataset(in_options),TopBusiness_Services.RegisteredAgentSection_Layouts.rec_OptionsLayout)[1],
					in_mod)
				);
				
				ConnectedBusinessSection := if (Section_connectedBusinesses,  TopBusiness_Services.ConnectedBusinessSection.fn_fullView(
					project(ds_input_data, transform(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_Input, self := left)),
					project(dataset(in_options),TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_OptionsLayout)[1],
					in_mod)
				);
				
				Irs5500Section := if (section_irs5500,  TopBusiness_Services.IRS5500Section.fn_fullView(
					 project(ds_input_data, transform(TopBusiness_Services.IRS5500Section_Layouts.rec_Input, self := left)),
					 project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
					 in_mod)
				);
				
				BusinessRegistrationSection := if (section_businessRegistrations, TopBusiness_Services.BusinessRegistrationSection.fn_fullView(
		       project(ds_input_data, transform(TopBusiness_Services.BusinessRegistrationSection_Layouts.rec_Input, self := left)),
				   project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
				   in_mod)
				);
				
				SanctionsSection := if (section_sanctions, TopBusiness_Services.SanctionSection.fn_fullView(
						project(ds_input_data, transform(TopBusiness_Services.SanctionSection_Layouts.rec_Input, self := left)),
						project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
						in_mod)
				);
				
				ExperianBusinessReportSection := IF (section_ebr,  TopBusiness_Services.EBRSection.fn_fullView(
						project(ds_input_data, transform(TopBusiness_Services.Layouts.rec_input_ids, self := left)),
						project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
						in_mod)
				);
				
				DunBradStreetSection := if (section_DNB,  TopBusiness_Services.DNBSection.fn_fullView(
						project(ds_input_data, transform(TopBusiness_Services.Layouts.rec_input_ids, self := left)),
						project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
						mod_access)
				);
				
				source_mod_access := module(mod_access)
	    	  export boolean log_record_source := mod_access.log_record_source AND section_sources;
                    end;

				SourceSection := if (section_sources, TopBusiness_Services.SourceSection.fn_FullView(
						ds_input_data,
						project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
						source_mod_access,ds_busHeaderRecs)
				);              
                  
            TmpBusinessInsightPreLayoutPopulation := if (section_BusinessInsight,                           
                           TopBusiness_Services.BusinessInsightSection.FromBipReportBusinessEvidence(
                            project(ds_input_data, transform(BIPV2.IDlayouts.l_xlink_ids, self := left))
                            ,project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1]
                            ,BestSection[1]
                           ,ContactSection[1]                                         
                           ,SourceSection[1].AllSourcesCount
                           ,SourceSection[1].SourceDocs[1].source                          
                           ,FinanceSection[1]
                           )
                           );
              tmpBusinessInsightSection := if (section_BusinessInsight, TopBusiness_Services.BusinessInsightSection.fn_FullViewBusinessEvidence( 
                                                                            TmpBusinessInsightPreLayoutPopulation[1] ));
             BusinessInsightSection := if (section_businessInsight,
                           TopBusiness_Services.BusinessInsightSection.fn_FullViewRisk(
                            project(ds_input_data, transform(BIPV2.IDlayouts.l_xlink_ids, self := left))
                            ,project(dataset(in_options),TopBusiness_Services.Layouts.rec_input_options)[1]                        
                           ,TmpBusinessInsightSection[1]
                           ,BestSection[1]
                           ,ContactSection[1]         
                            ,FinanceSection[1]                           
                            ,Industrysection[1]
                            ,MotorVehicleSection[1].MotorVehicleRecords.CurrentRecordCount
                            ,WatercraftSection[1].WatercraftRecords.CurrentRecordCount
                            ,AircraftSection[1].AircraftRecords.CurrentRecordCount
                            ,PropertySection[1].propertyRecords.CurrentRecordsCount             
                            ,PropertySection[1].propertyRecords.ForeclosureNODRecordCount
                            )
                            );
                            
                    SourceSectionFinal := if (in_options.IncludeSourceCounts, SourceSection);
                    ContactSectionFinal := if (in_options.IncludeContacts, ContactSection);
                    IndustrySectionFinal := if ( in_options.IncludeIndustries, IndustrySection);
                    MotorVehicleSectionFinal :=   if ( in_options.IncludeMotorVehicles,  MotorVehicleSection);
                    PropertySectionFinal := if (in_options.IncludeProperties, PropertySection);
                    AircraftSectionFinal := if (in_options.IncludeAircrafts, AircraftSection);
                    WatercraftSectionFinal := if (in_options.IncludeWatercrafts, WatercraftSection);
			    FinanceSectionFinal := if (in_options.IncludeFinances, FinanceSection);
 				
				
 TopBusiness_Services.BranchReport_Layouts.Final BIPREPORTXFORM() := TRANSFORM
      SELF.acctno := ds_tmpinput_data[1].acctno;
		     SELF.BestSection := BestSection[1];
			SELF.ParentSection := parentSection[1];
			SELF.AssociateSEction := AssociateSection[1];
			SELF.ContactSection := ContactSectionFinal[1];
			SELF.IncorporationSection := IncorporationSection[1];
			SELF.PropertySection := PropertySectionFinal[1];
			SELF.OperationsSitesSection := OperationsSitesSection[1];
			SELF.FinanceSection :=  FinanceSectionFinal[1];
			SELF.IndustrySection := IndustrySectionFinal[1];
			SELF.LicenseSection := LicenseSection[1];
			SELF.UrlSection      := UrlSection[1];
			SELF.BankruptcySection := BankruptcySection[1];
			SELF.LienSection := LienSection[1];
			SELF.UCCSection :=  UccSection[1];
			SELF.AircraftSEction := AircraftSectionFinal[1];
			SELF.MotorVehicleSection         := MotorVehicleSectionFinal[1];
			SELF.WatercraftSection           := WatercraftSectionFinal[1];
			SELF.ConnectedBusinessSection    := ConnectedBusinessSection[1];
			SELF.RegisteredAgentSEction      := RegisteredAgentSection[1];
			SELF.IRS5500Section              := IRS5500Section[1];
			SELF.BusinessRegistrationSection := BusinessRegistrationSection[1];
			SELF.SanctionSection             := SanctionsSection[1];
			SElf.ExperianBusinessReportSection := ExperianBusinessReportSection[1];
			SELF.DunBradStreetSection        := DunBradStreetSection[1];		
                SELF.SourceSection               := SourceSectionFinal[1];
      
                //SELF.businessInsightSection := BusinessInsightSection[1];
                SELF.BusinessInsightSection := TmpBusinessInsightSection[1];
			//SELF.CompanyVerifcationSection := []		//purposely like this not a typo.	
		  SELF := [];
	END;
  SectionReport := DATASET([ BIPREPORTXFORM() ]);		 

	return(sectionReport);

	end; // getReport

end; // best Module