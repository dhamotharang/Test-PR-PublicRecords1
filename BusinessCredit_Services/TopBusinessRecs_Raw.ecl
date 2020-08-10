IMPORT Address, AutoStandardI, doxie, TopBusiness_Services, iesp, bipv2;

EXPORT TopBusinessRecs_Raw(BusinessCredit_Services.Iparam.reportrecords inmod , 
													 DATASET(TopBusiness_Services.Layouts.rec_busHeaderLayout) ds_busheaderRecs,
													 boolean buzCreditAccess = FALSE) := FUNCTION
		
	in_topbusiness_ds := PROJECT(inmod.BusinessIds, TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
																										SELF.acctno := '1';
																										SELF := LEFT ));
																						
	TopBusiness_Services.BusinessReportComprehensive_Layouts xform_topbusiness_options() := TRANSFORM
		SELF.BusinessReportFetchLevel	:= inmod.FetchLevel;
		SELF.ApplicationType					:= inmod.ApplicationType;
		SELF.IncludeNameVariations		:= TRUE; //We wanted to return name variations.
		SELF.IncludeUCCFilingsSecureds:= TRUE; //We wanted to return Secured Assests.
		SELF.restrictexperian         := TRUE; // we want to restrict ER and Q3 sources
		SELF 													:= [];
	END;
	
  in_options 					:= ROW(xform_topbusiness_options());
  in_topbusiness_mod	:= MODULE(PROJECT(inmod, AutoStandardI.DataRestrictionI.params, OPT))
    EXPORT boolean ignoreFares := FALSE;
    EXPORT boolean ignoreFidelity := FALSE;
  END;	
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
     
	add_best := TopBusiness_Services.BestSection.fn_fullView(	in_topbusiness_ds, 
																														PROJECT(DATASET(in_options),TRANSFORM(TopBusiness_Services.BestSection_Layouts.rec_OptionsLayout, self := left, self := []))[1],
																														in_topbusiness_mod,
																														ds_busheaderRecs,
                                                            iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
	// restricting experian sources																													
	rec_comp := record
	  unsigned cnt;
	  bipv2.Idlayouts.l_key_ids_bare;
    iesp.TopBusinessReport.t_TopBusinessBestOtherCompany;
  end;
	norm_comp := normalize(add_best, left.OtherCompanyNames, transform(rec_comp,
	                       self.cnt := counter,
                         self.DotID := left.BusinessIds.DotID,
                         self.EmpID:= left.BusinessIds.EmpID,
                         self.POWID:= left.BusinessIds.POWID,
                         self.ProxID:= left.BusinessIds.ProxID,
                         self.SeleID:= left.BusinessIds.SeleID,
                         self.OrgID:= left.BusinessIds.OrgID,
                         self.UltID:= left.BusinessIds.UltID,
                         self := right));
																															 
  rec_src := record
	  unsigned cntr;
	  iesp.topbusiness_share.t_TopBusinessSourceDocInfo;
	end;
	
	norm_src := normalize(norm_comp, left.SourceDocs,transform(rec_src,
	                      self.cntr := left.cnt,
                        self := right));	
	 
	ds_restrct_src := norm_src(source not in BusinessCredit_Services.Constants.EXCLUDED_EXPERIAN_SRC);
	
	rec_comp tr_src(rec_comp l, dataset(rec_src) r) := transform
	
	self.sourcedocs := choosen(project(r, transform(iesp.topbusiness_share.t_TopBusinessSourceDocInfo, self := left)),iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
	self:= l;
	
	end;
	denorm_comp := denormalize(norm_comp, ds_restrct_src, left.cnt = right.cntr, group, tr_src(left, rows(right)));
	
	iesp.TopBusinessReport.t_TopBusinessBestSection tr_final(recordof(add_best) l, dataset(rec_comp) r) := transform
	street_addr := Address.Addr1FromComponents(l.Address.StreetNumber, l.Address.StreetPreDirection, l.Address.StreetName, l.Address.StreetSuffix,
                                              l.Address.StreetPostDirection, l.Address.UnitDesignation, l.Address.UnitNumber);
  csz := Address.Addr2FromComponents(l.Address.City, l.Address.State, l.Address.Zip5);
  
  self.Address.StreetAddress1 := street_addr;
  self.Address.StateCityZip   := csz;
	self.OtherCompanyNames      := choosen(project(r, transform(iesp.TopBusinessReport.t_TopBusinessBestOtherCompany, self := left)), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_OTHER_COMPANIES);
	self                        := l;
	
	end;
	 // denorm back to parent dataset after restriction
	ds_denorm_best := denormalize(add_best, denorm_comp, 
	                              left.BusinessIds.DotID = right.DotID and
                                left.BusinessIds.EmpID  = right.EmpID and
                                left.BusinessIds.POWID = right.POWID and
                                left.BusinessIds.ProxID = right.ProxID and
                                left.BusinessIds.SeleID = right.SeleID and
                                left.BusinessIds.OrgID = right.OrgID and
                                left.BusinessIds.UltID = right.UltID,
                                group, tr_final(left, rows(right)));
                               																												
	

	add_bankruptcy := TopBusiness_Services.BankruptcySection.fn_fullView(	PROJECT(in_topbusiness_ds, TopBusiness_Services.BankruptcySection_Layouts.rec_Input),
																																				PROJECT(DATASET(in_options),TopBusiness_Services.BankruptcySection_Layouts.rec_OptionsLayout)[1],
																																				in_topbusiness_mod,
                                                                        iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
																																			
	add_liens	:= TopBusiness_Services.LienSection.fn_fullView(in_topbusiness_ds,
																														PROJECT(DATASET(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
																														in_topbusiness_mod,
                                                            iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
																													
	add_ucc := TopBusiness_Services.UCCSection.fn_fullView(	in_topbusiness_ds,
																													PROJECT(DATASET(in_options),TopBusiness_Services.Layouts.rec_input_options_ucc)[1],
																													in_topbusiness_mod,
                                                          iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);

	add_aircraft := TopBusiness_Services.AircraftSection.fn_fullView(	PROJECT(in_topbusiness_ds, TopBusiness_Services.aircraftSection_Layouts.rec_Input),
																																		PROJECT(DATASET(in_options),TopBusiness_Services.layouts.rec_input_options)[1],
																																		in_topbusiness_mod,
                                                                    iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
																																	
	add_motorvehicle:= TopBusiness_Services.MotorVehicleSection.fn_fullView(in_topbusiness_ds,
																																					PROJECT(DATASET(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
																																					mod_access,
                                                                          iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
		
	add_watercraft 	:= TopBusiness_Services.WatercraftSection.fn_fullView(in_topbusiness_ds,
																																				PROJECT(DATASET(in_options),TopBusiness_Services.Layouts.rec_input_options)[1],
																																				in_topbusiness_mod,
                                                                        iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);

	bestCname	:= ds_denorm_best[1].companyname;
	add_property := TopBusiness_Services.PropertySection.fn_fullView(	PROJECT(in_topbusiness_ds, TopBusiness_Services.PropertySection_Layouts.rec_Input),
																																		PROJECT(DATASET(in_options),TopBusiness_Services.PropertySection_Layouts.rec_OptionsLayout)[1],
																																		in_topbusiness_mod,
																																		bestCname,
                                                                    iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS,
                                                                    iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_PROPERTY_RECORDS, 
                                                                    iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS);	
 
	iesp.TopBusinessReport.t_TopBusinessProperty propertyChild(iesp.TopBusinessReport.t_TopBusinessProperty R) := TRANSFORM
		SELF := R;	
	END; 

	ds_Properties	:= NORMALIZE(add_property,LEFT.PropertyRecords.Properties, propertyChild(RIGHT));
	ds_Properties_sorted	:= CHOOSEN(SORT(ds_Properties, -IsNoticeOfDefault, -IsForeclosed, RECORD), iesp.Constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS);
 
  iesp.TopBusinessReport.t_TopBusinessPropertySection xfm_createProperties() := TRANSFORM
		SELF.PropertyRecords := PROJECT(add_property[1].PropertyRecords , 
                                    TRANSFORM(iesp.TopBusinessReport.t_TopBusinessPropertySummary,
                                        SELF.Properties := ds_Properties_sorted,
                                        SELF := LEFT)),
    SELF.PropertyRecordCount := add_property[1].PropertyRecordCount,
	  SELF.TotalPropertyRecordCount := add_property[1].TotalPropertyRecordCount
	END;
  
  ds_Properties_sorted_final := DATASET([xfm_createProperties()]);
																															
	add_licenses := TopBusiness_Services.LicenseSection.fn_fullView( in_topbusiness_ds,
																																	 PROJECT(DATASET(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
																																	 in_topbusiness_mod,
                                                                   iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS
                                                                   );
																																
	add_incorporation := TopBusiness_Services.IncorporationSection.fn_fullView( in_topbusiness_ds,
																																							PROJECT(DATASET(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
																																							in_topbusiness_mod,
                                                                              iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_INCORP_RECORDS,
                                                                              iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);

	iesp.TopBusinessReport.t_TopBusinessIncorporationInfo corpChild(iesp.TopBusinessReport.t_TopBusinessIncorporationInfo R) := TRANSFORM
		SELF := R;
	END; 

	ds_CorpFilings	:= NORMALIZE(add_incorporation,LEFT.CorpFilings, corpChild(RIGHT));
	ds_CorpFilings_sorted	:= SORT(ds_CorpFilings,  -(BusinessStatus = 'ACTIVE'), -(BusinessType = 'CORPORATION-BUSINESS'), -(BusinessType = 'FOREIGN CORPORATION'), -FilingDate, RECORD);
	ds_CorpFilings_choosen:= CHOOSEN(ds_CorpFilings_sorted ,iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_INCORP_RECORDS);
                                
  iesp.TopBusinessReport.t_TopBusinessIncorporationSection xfm_createCorpFilings() := TRANSFORM
		SELF.CorpFilings := ds_CorpFilings_choosen,
		SELF.ReturnedCorpFilings := add_incorporation[1].ReturnedCorpFilings,
		SELF.TotalCorpFilings := add_incorporation[1].TotalCorpFilings,
		SELF.SourceDocs := add_incorporation[1].SourceDocs
	END;
  
  ds_incorporation_sorted := DATASET([xfm_createCorpFilings()]);
  
	add_parent :=	TopBusiness_Services.ParentSection.fn_fullView( PROJECT(in_topbusiness_ds, TopBusiness_Services.ParentSection_Layouts.rec_Input),
																																PROJECT(DATASET(in_options),TopBusiness_Services.layouts.rec_input_options)[1],
																																in_topbusiness_mod,
																																ds_busHeaderRecs,
                                                                iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
																																
	ds_add_parent := PROJECT(add_parent, 	TRANSFORM(iesp.businesscreditreport.t_BusinessCreditParentSection,
																					SELF.BusinessIds := LEFT.Parents[1].BusinessIds,
																					SELF.CompanyName := LEFT.Parents[1].CompanyName,
																					SELF.Address 		 := LEFT.Parents[1].Address,
																					SELF.PhoneInfo := LEFT.Parents[1].PhoneInfo,
																					SELF.BusinessCreditIndicator := BusinessCredit_Services.Functions.fn_BuzCreditIndicator(LEFT.Parents[1].BusinessIds.UltId, 
																																																																	LEFT.Parents[1].BusinessIds.OrgID,
																																																																	LEFT.Parents[1].BusinessIds.SeleID,
																																																																	mod_access,
																																																																	buzCreditAccess))
													);
													
	add_ConnectedBusinesses := TopBusiness_Services.ConnectedBusinessSection.fn_fullView(	PROJECT(in_topbusiness_ds, TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_Input),
																																												PROJECT(DATASET(in_options),TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_OptionsLayout)[1],
																																												in_topbusiness_mod );

     add_connectedBusinesses_final := BusinessCredit_Services.Functions.AddSBFEIndicatorFunction(Add_connectedBusinesses,mod_access,BuzCreditAccess);             	
   
	add_contact := TopBusiness_Services.ContactSection.fn_fullView( PROJECT(in_topbusiness_ds, TopBusiness_Services.ContactSection_Layouts.rec_Input),
																																	PROJECT(DATASET(in_options),TopBusiness_Services.ContactSection_Layouts.rec_OptionsLayout)[1],
																																	in_topbusiness_mod,
                                                                  iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);

	ds_properties_opssite := ds_Properties_sorted_final[1].PropertyRecords.Properties;
	add_opssites := TopBusiness_Services.OperationsSitesSection.fn_fullView(in_topbusiness_ds,
																																					PROJECT(DATASET(in_options), TopBusiness_Services.Layouts.rec_input_options)[1],
																																					in_topbusiness_mod,
																																					ds_properties_opssite,
																																					ds_busHeaderRecs,
                                                                          iesp.Constants.BusinessCredit.MAX_COUNT_BIZRPT_SRCDOC_RECORDS);
																																					
	BusinessCredit_Services.Layouts.TopBusinessRecord transform_TopBusinessRecs() := TRANSFORM
		SELF.acctno 									:= '1';
		SELF.BestSection							:= ds_denorm_best[1];
		SELF.BankruptcySection				:= add_bankruptcy[1];
		SELF.LienSection							:= add_liens[1];
		SELF.UCCSection								:= add_ucc[1];
		SELF.AircraftSection					:= add_aircraft[1];
		SELF.MotorVehicleSection			:= add_motorvehicle[1];
		SELF.WatercraftSection				:= add_watercraft[1];
		SELF.PropertySection					:= ds_Properties_sorted_final[1];
		SELF.LicenseSection						:= add_licenses[1];
		SELF.IncorporationSection			:= ds_incorporation_sorted[1];
		SELF.ParentSection						:= ds_add_parent[1];
		SELF.ConnectedBusinessSection	:= add_ConnectedBusinesses_final[1];
		SELF.ContactSection						:= add_contact[1];
		SELF.OperationsSitesSection		:= add_opssites[1];		
	END;
	
	BusinessCredit_Services.Layouts.TopBusinessRecord transform_TopBusinessRecsLNOnlyCreditReport() := TRANSFORM
		SELF.acctno 									:= '1';
		SELF.BestSection							:= ds_denorm_best[1];	
		SELF.IncorporationSection			:= ds_incorporation_sorted[1];	
		SELF.ParentSection						:= ds_add_parent[1];
		SELF.OperationsSitesSection		:= add_opssites[1];			
		SELF := []
	END;

	final_recsDefault := DATASET([transform_TopBusinessRecs()]);
	final_recsLNOnlyCreditReport := DATASET([transform_TopBusinessRecsLNOnlyCreditReport()]);
	
	// use the restricted topbusiness records only for the LNOnlyBusinessCreditReport option.
	// the other LNOnly... options will use the larger set of records
	final_recs := if (inmod.BusinessCreditReportType = BusinessCredit_Services.Constants.LNOnlyBusinessCreditReport, 
	                                  final_recsLNOnlyCreditReport, final_recsDefault );

// OUTPUT(add_parent, NAMED('add_parent_MAX_COUNT_CONNECTED_BUSINESSES'));
// OUTPUT(add_bankruptcy[1], NAMED('add_bankruptcy'));
// OUTPUT(add_liens[1], NAMED('add_liens'));
// OUTPUT(add_ucc[1], NAMED('add_ucc'));
// OUTPUT(add_aircraft[1], NAMED('add_aircraft'));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));
// OUTPUT(, NAMED(''));


	RETURN final_recs;
END;