import ut;

// outrec_lay := record
	// string datasetname;
	// string envment;
	// string location;
	// string cluster;
	// string buildversion;
	// string keycount;
	// string releasedate;
// end;

outrec := record
			Scoring_Project_DailyTracking.Attributes.ddt_layout;
end;

outrec_2 := record
			outrec;
			string other_version;
			string other_date;
end;

// Dataset with data
// environment = 'P' or 'Q'
// location [optional] = 'B' or 'Q' or '' or '*'
// cluster [optional] = 'N' or 'F' or '' or '*' or 'S' - Customer Support or 'FS' - FCRA Customer Support or 'T' - Customer Test
// date deployed = <blank> if previous day, else a date can be input.  Note that a dataset will not return if it has been redeployed on a subsequent date

EXPORT DDT_StaleReport( dataset(outrec) ddt_set, string env, string loc, string clus, string histdt) := function
		
		yesterday := ut.date_math(ut.getdate, -1.5);
		
		environment_name := 	map(	env = 'P' 		=>		'Prod',
																env = 'Q'			=>		'Cert',
																										'Unknown');
		other_envment_name := map(	env = 'P' 		=>		'Cert',
																env = 'Q'			=>		'Prod',
																										'Unknown');
		
		// cluster_name 		:= 	map(		clus = 'F' 		=>		'FCRA',
																// clus = 'N'		=>		'NonFCRA',
																										// 'Unknown');
		date_name				:=	map(	histdt = '' 		=> 	yesterday,
															histdt = 'all'	=>	'all current datasets',
																									histdt);
		
		date_form(string rel_date) := function
				a := Stringlib.StringFind(rel_date, '/', 1);
				b := Stringlib.StringFind(rel_date, '/', 2);
				c := b + 4;
				mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
				dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
				yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
				return yr + mo + dom;
		end;
		
		// filter the dataset according to the input parameters
		temp_set := map(		histdt = '' 		=> 	ddt_set(envment = env and location = loc  and date_form(releasedate) = yesterday),
												histdt = 'all'	=>	ddt_set(envment = env and location = loc ),
																						ddt_set(envment = env and location = loc  and date_form(releasedate) = histdt));
		
		opposite_set := join(	temp_set, ddt_set, 	left.datasetname = right.datasetname
																							and left.envment <> right.envment
																							and left.cluster = right.cluster,
																							transform(	outrec_2,	
																													self.other_version := right.buildversion;
																													self.other_date := right.releasedate;
																													self := left; ) );
																													
			
opposite_set_pjt_lay:=record
	string datasetname;
	string envment;
	string location;
	string cluster;
	string buildversion;
	// string keycount;
	string releasedate;
	integer days_since_updated;
end;
		
	// converting dates to numbers 
		
	opposite_set_pjt:=project(opposite_set,transform(opposite_set_pjt_lay,
	                                self.releasedate:= Scoring_Project_DailyTracking.Functions.date_form(TRIM(left.releasedate[1..10],LEFT,RIGHT));
	                                self.days_since_updated:= Scoring_Project_DailyTracking.Functions.get_past_date((integer)Scoring_Project_DailyTracking.Functions.date_form(TRIM(left.releasedate[1..10],LEFT,RIGHT)));
	                                self:=left
	                                ));
			
	customRulesRec:=record
   	recordof(opposite_set_pjt);
   	string threshold;
  end;
      
			
// add custom threshold's below
			
 customRulesRec nonFCRA_customRules_func(opposite_set_pjt_lay l)	:=	transform
             
self.threshold:=map(								                     
l.datasetname='AddressFeedbackKeys'=>'3',
l.datasetname='FDNKeys'=>'3',   							//had 0 threshold, added threshold
l.datasetname='PhonemartKeys'=>'46',					//had 0 threshold, added threshold
l.datasetname='SBFECVKeys'=>'3',							//had 0 threshold, added threshold
l.datasetname='QHsourceKeys'=>'14',						//had 0 threshold, added threshold
l.datasetname='PersonAncillaryKeys'=>'46',		//had 0 threshold, added threshold
l.datasetname='RelativeV3Keys'=>'46',					//had 0 threshold, added threshold
l.datasetname='FraudPoint3Keys'=>'NA',				//had 0 threshold, added threshold
l.datasetname='BKEventsKeys'=>'3',
l.datasetname='BankruptcyV2Keys'=>'3',
l.datasetname='BusinessRegKeys'=>'46',
l.datasetname='CaseConnectKeys'=>'3',
l.datasetname='CivilCourtKeys'=>'46',
l.datasetname='Corp2Keys'=>'42',
l.datasetname='DLV2Keys'=>'14',
l.datasetname='Death_MIKeys'=>'3',
l.datasetname='DoNotMailKeys'=>'46',
l.datasetname='EBRKeys'=>'14',
l.datasetname='EcrashV2Keys'=>'3',
l.datasetname='FedexKeys'=>'3',
l.datasetname='GongKeys'=>'3',
l.datasetname='IngenixKeys'=>'14',
l.datasetname='InquiryTableUpdateKeys'=>'3',
l.datasetname='LiensV2Keys'=>'3',
l.datasetname='LitigiousDebtorKeys'=>'3',
l.datasetname='MMCPKeys'=>'3',
l.datasetname='NACKeys'=>'3',
l.datasetname='OverrideKeys'=>'3',
l.datasetname='POEKeys'=>'46',
l.datasetname='PhoneFeedbackKeys'=>'3',
l.datasetname='SANCTN_NPKeys'=>'3',
l.datasetname='SAOKeys'=>'3',
l.datasetname='SanctnKeys'=>'6',
l.datasetname='SheilaGrecoKeys'=>'14',
l.datasetname='SuppressionKeys'=>'3',
l.datasetname='TxbusKeys'=>'14',
l.datasetname='UCCV2Keys'=>'3',
l.datasetname='UtilityDailyKeys'=>'3',
l.datasetname='VehicleV2Keys'=>'28',
l.datasetname='WebclickKeys'=>'28',
l.datasetname='WorldCheckKeys'=>'3',
l.datasetname='ZoomKeys'=>'46',
l.datasetname='NppesKeys'=>'14',
l.datasetname='PSSKeys'=>'14',
l.datasetname='SalesChannelKeys'=>'28',
l.datasetname='VotersV2Keys'=>'46',
l.datasetname='iBehaviorKeys'=>'46',
l.datasetname='DNBKeys'=>'46',
l.datasetname='DeathMasterKeys'=>'14',
l.datasetname='DeathMasterSsaKeys'=>'14',
l.datasetname='EnclarityKeys'=>'14',
l.datasetname='ForeclosureKeys'=>'14',
l.datasetname='ImpulseEmailKeys'=>'14',
l.datasetname='InquirytableKeys'=>'14',
l.datasetname='MDV2Keys'=>'28',
l.datasetname='TestseedKeys'=>'NA',
l.datasetname='Vina_VinKeys'=>'46',
l.datasetname='BadAddressesKeys'=>'14',
l.datasetname='DiversityCertKeys'=>'46',
l.datasetname='DoNotCallKeys'=>'14',
l.datasetname='ECRulingKeys'=>'46',
l.datasetname='GlobalWatchListV2Keys'=>'14',
l.datasetname='QuickHeaderKeys'=>'14',
l.datasetname='RiskTableKeys'=>'14',
l.datasetname='SourceKeys'=>'14',
l.datasetname='CLIAKeys'=>'46',
l.datasetname='CityStZipKeys'=>'46',
l.datasetname='DOCImagesKeys'=>'46',
l.datasetname='DOCKeys'=>'46',
l.datasetname='GSAKeys'=>'14',
l.datasetname='GlobalWatchListKeys'=>'9',
l.datasetname='OneClickDataKeys'=>'90',
l.datasetname='OshairKeys'=>'46',
l.datasetname='PatriotKeys'=>'14',
l.datasetname='ABMSKeys'=>'46',
l.datasetname='BBBKeys'=>'14',
l.datasetname='PersonHeaderLookupKeys'=>'14',
l.datasetname='PhonesPlusV2Keys'=>'20',
l.datasetname='BIPV2WeeklyKeys'=>'46',
l.datasetname='BipV2FullKeys'=>'46',
l.datasetname='CalbusKeys'=>'14',
l.datasetname='FAAKeys'=>'46',
l.datasetname='QsentKeys'=>'20',
l.datasetname='ThriveKeys'=>'46',
l.datasetname='CodesV3Keys'=>'28',
l.datasetname='GarnishmentKeys'=>'46',
l.datasetname='LNPropertyV2FullKeys'=>'14',
l.datasetname='LNPropertyV2Keys'=>'14',
l.datasetname='NDRKeys'=>'46',
l.datasetname='WatchdogKeys'=>'14',
l.datasetname='CanadianPhonesKeys'=>'46',
l.datasetname='FrandxKeys'=>'NA',
l.datasetname='HealthHDRKeys'=>'28',
l.datasetname='InfutorKeys'=>'46',
l.datasetname='InstantIDArchiveKeys'=>'14',
l.datasetname='MarketingHeaderKeys'=>'28',
l.datasetname='POEsFromEmailsKeys'=>'46',
l.datasetname='PropertyInformationKeys'=>'46',
l.datasetname='NCPDPKeys'=>'46',
l.datasetname='OfficialRecordsKeys'=>'46',
l.datasetname='InsuranceCertKeys'=>'46',
l.datasetname='BipV2WAFKeys'=>'46',
l.datasetname='ExperianPhonesKeys'=>'46',
l.datasetname='FacilityHeaderKeys'=>'42',
l.datasetname='ACAInstitutionsKeys'=>'46',
l.datasetname='ATFKeys'=>'46',
l.datasetname='AddressHRIKeys'=>'46',
l.datasetname='BusinessBestKeys'=>'46',
l.datasetname='BusinessHeaderKeys'=>'46',
l.datasetname='ConsumerStatementKeys'=>'14',
l.datasetname='Fbn2Keys'=>'67',
l.datasetname='GovdataKeys'=>'46',
l.datasetname='HeaderNonUpdatingKeys'=>'46',
l.datasetname='PAWV2Keys'=>'46',
l.datasetname='SexOffenderImagesKeys'=>'46',
l.datasetname='SexOffenderKeys'=>'46',
l.datasetname='AMSKeys'=>'46',
l.datasetname='WorkersCompensationKeys'=>'28',
l.datasetname='EmergesKeys'=>'46',
l.datasetname='SpokeKeys'=>'NA',
l.datasetname='YellowPagesKeys'=>'46',
l.datasetname='CDSKeys'=>'46',
l.datasetname='CertegyKeys'=>'46',
l.datasetname='ExperianFEINKeys'=>'46',
l.datasetname='PersonLABKeys'=>'46',
l.datasetname='PCNSRKeys'=>'46',
l.datasetname='NeighborhoodKeys'=>'46',
l.datasetname='InfutorNARCKeys'=>'46',
l.datasetname='DEAKeys'=>'14',
l.datasetname='LaborActionsWHDKeys'=>'NA',
l.datasetname='TargusKeys'=>'46',
l.datasetname='CanadianPhonesV2Keys'=>'46',
l.datasetname='EmailDataKeys'=>'46',
l.datasetname='SNAKeys'=>'46',
l.datasetname='FCCKeys'=>'135',
l.datasetname='AmericanstudentKeys'=>'46',
l.datasetname='InfutorcidKeys'=>'46',
l.datasetname='OIGKeys'=>'46',
l.datasetname='ProfLicKeys'=>'90',
l.datasetname='AVMV2Keys'=>'46',
l.datasetname='PersonHeaderKeys'=>'46',
l.datasetname='PersonSlimsortKeys'=>'46',
l.datasetname='RelativeKeys'=>'46',
l.datasetname='WatercraftKeys'=>'46',
l.datasetname='ExperianCRDBKeys'=>'90',
l.datasetname='FraudpointseedKeys'=>'NA',
l.datasetname='SICCodeKeys'=>'NA',
l.datasetname='TelcordiaTdsKeys'=>'46',
l.datasetname='TelcordiaTpmKeys'=>'46',
l.datasetname='MariKeys'=>'90',
l.datasetname='CrashCarrierKeys'=>'135',
l.datasetname='DCAKeys'=>'46',
l.datasetname='DNBFEINV2Keys'=>'135',
l.datasetname='BusRiskBIPKeys'=>'NA',
l.datasetname='LaborActionsEBSAKeys'=>'NA',
l.datasetname='EquifaxTotalSolutionKeys'=>'135',
l.datasetname='SSNIssue2Keys'=>'NA',
l.datasetname='AMIDIR_Keys'=>'NA',
l.datasetname='IRSKeys'=>'NA',
l.datasetname='Debt_SettlementKeys'=>'NA',
l.datasetname='ABIKeys'=>'NA',
l.datasetname='SeedKeys'=>'NA',
l.datasetname='MXDocketKeys'=>'NA',
l.datasetname='MXNamesKeys'=>'NA',
l.datasetname='MXProfessionKeys'=>'NA',
l.datasetname='DEADCOKeys'=>'NA',
l.datasetname='CNLDFacilitiesKeys'=>'NA',
l.datasetname='WhoisKeys'=>'NA',
l.datasetname='DriversVTSAKeys'=>'NA',
l.datasetname='CourtSearchKeys'=>'NA',
l.datasetname='CustomBankTransactionKeys'=>'NA',
l.datasetname='LaborActionsMSHAKeys'=>'NA',
l.datasetname='ModelsKeys'=>'NA',
l.datasetname='AreaCodeChangeKeys'=>'NA',
l.datasetname='AlloyKeys'=>'NA',
l.datasetname='SourceBKeys'=>'NA',
l.datasetname='ERO_Keys'=>'NA',
l.datasetname='CompIDKeys'=>'NA',
l.datasetname='EASI2000Keys'=>'NA',
l.datasetname='SiteSecISMSKeys'=>'NA',
l.datasetname='LabDIDMappingKeys'=>'NA',
l.datasetname='EASIKeys'=>'NA',
l.datasetname='SmartJuryKeys'=>'NA',
l.datasetname='CNLDPractitionerKeys'=>'NA',
l.datasetname='StatedeathKeys'=>'NA',
l.datasetname='ZipbyCounty2Keys'=>'NA',
l.datasetname='AccidentStateResKeys'=>'NA',
l.datasetname='TaxproKeys'=>'NA',
l.datasetname='MFindKeys'=>'NA',
l.datasetname='CourtLocatorLookupKeys'=>'NA',
l.datasetname='CountyKeys'=>'NA',
l.datasetname='LSSIDailyKeys'=>'NA',
l.datasetname='LSSIWeeklyKeys'=>'NA',
l.datasetname='GongDailyKeys'=>'NA',
l.datasetname='PhoneBlacklistKeys'=>'NA',
l.datasetname='NonUpdatingKeys'=>'NA',
l.datasetname='BKCourtKeys'=>'NA',
l.datasetname='JigsawKeys'=>'NA',
l.datasetname='PullZipKeys'=>'NA',
l.datasetname='SAMKeys'=>'14',
 '0' );
self:=l;
end;
			
			 
		 customRulesRec FCRA_customRules_func(opposite_set_pjt_lay l)	:=transform

  self.threshold:=map(
										// left.datasetname='BKCourtKeys'=>30,25 );
l.datasetname='FCRA_BKEventsKeys'=>'3',
l.datasetname='FCRA_BankruptcyKeys'=>'3',
l.datasetname='FCRA_CDSKeys'=>'46',
l.datasetname='FCRA_GongKeys'=>'3',
l.datasetname='FCRA_LiensV2Keys'=>'3',
l.datasetname='FCRA_OptOutKeys'=>'14',
l.datasetname='FCRA_OverrideKeys'=>'3',
l.datasetname='FCRA_PersonHeaderKeys'=>'46',
l.datasetname='FCRA_ProfLicKeys'=>'46',
l.datasetname='FCRA_QuickHeaderKeys'=>'14',
l.datasetname='FCRA_RiskTableKeys'=>'14',
l.datasetname='FCRA_TargusKeys'=>'46',
l.datasetname='FCRA_UCCKeys'=>'3',
l.datasetname='FCRA_UtilityDailyKeys'=>'3',
l.datasetname='RiskviewseedKeys'=>'NA',
l.datasetname='SuppressionKeys'=>'3',
l.datasetname='FCRA_EmailDataKeys'=>'46',
l.datasetname='FCRA_LNPropertyV2FullKeys'=>'14',
l.datasetname='FCRA_LNPropertyV2Keys'=>'14',
l.datasetname='FCRA_DeathMasterKeys'=>'14',
l.datasetname='FCRA_DeathMasterSsaKeys'=>'14',
l.datasetname='FCRA_iBehaviorKeys'=>'46',
l.datasetname='FCRA_ImpulseEmailKeys'=>'14',
l.datasetname='FCRA_MDV2Keys'=>'21',
l.datasetname='FCRA_SexOffenderKeys'=>'46',
l.datasetname='FCRA_VotersV2Keys'=>'46',
l.datasetname='FCRA_InfutorcidKeys'=>'46',
l.datasetname='FCRA_TelcordiaTpmKeys'=>'46',
l.datasetname='FCRA_DOCKeys'=>'21',
l.datasetname='FCRA_InquirytableKeys'=>'14',
l.datasetname='FCRA_ThriveKeys'=>'46',
l.datasetname='CityStZipKeys'=>'46',
l.datasetname='CodesV3Keys'=>'21',
l.datasetname='FCRA_FAAKeys'=>'46',
l.datasetname='FCRA_ConsmrStmtKeys'=>'NA',
l.datasetname='FCRA_EmergesKeys'=>'46',
l.datasetname='FCRA_ATFKeys'=>'46',
l.datasetname='FCRA_AddressHRIKeys'=>'46',
l.datasetname='FCRA_PAWV2Keys'=>'46',
l.datasetname='FCRA_MariKeys'=>'46',
l.datasetname='FCRA_AmericanstudentKeys'=>'46',
l.datasetname='FCRA_AVMV2Keys'=>'46',
l.datasetname='TelcordiaTdsKeys'=>'46',
l.datasetname='FCRA_WatercraftKeys'=>'46',
l.datasetname='RiskViewReportKeys'=>'NA',
l.datasetname='ProfileSeedKeys'=>'NA',
l.datasetname='FCRA_SSNIssue2Keys'=>'NA',
l.datasetname='SeedKeys'=>'NA',
l.datasetname='FCRA_AlloyKeys'=>'NA',
l.datasetname='CountyKeys'=>'NA',
l.datasetname='ZipbyCounty2Keys'=>'NA',
l.datasetname='FCRA_AreaCodeChangeKeys'=>'NA',
l.datasetname='FCRA_NonUpdatingKeys'=>'NA',
l.datasetname='BKCourtKeys'=>'NA',
l.datasetname='FCRA_ModelsKeys'=>'NA',
l.datasetname='0'=>'0',
 '0' );										
self:=l;
end;
									
  qa_nonFCRA_customRulesDS :=project(opposite_set_pjt(envment='Q' and location='B' and cluster ='N'),nonFCRA_customRules_func(left));
			
	qa_FCRA_customRulesDS :=project(opposite_set_pjt(envment='Q' and location='B' and cluster ='F'),FCRA_customRules_func(left));
	 
  prod_nonFCRA_customRulesDS :=project(opposite_set_pjt(envment='P' and location='B' and cluster ='N'),nonFCRA_customRules_func(left));
	 
  prod_FCRA_customRulesDS :=project(opposite_set_pjt(envment='P' and location='B' and cluster ='F'),FCRA_customRules_func(left));
																									
																									
																									
	FCRA_combine_results:=	if(env = 'Q',	qa_FCRA_customRulesDS, prod_FCRA_customRulesDS);				
	
	Non_FCRA_combine_results:=	if(env = 'Q', qa_nonFCRA_customRulesDS , prod_nonFCRA_customRulesDS);	
	
	FCRA_combine_results_filter:=sort(FCRA_combine_results(threshold<>'NA' and days_since_updated>=(integer)threshold),-(integer)threshold,days_since_updated);
	
	Non_FCRA_combine_results_filter:=sort(Non_FCRA_combine_results(threshold<>'NA' and days_since_updated>=(integer)threshold),-(integer)threshold,days_since_updated);
	
		// generate the report
		MyRec := RECORD
			INTEGER order;
			STRING line;
		END;
		
		Non_FCRA_ds_no_data := DATASET([{3, 'No data deployed on the given date'}], MyRec);
		
		FCRA_ds_no_data := DATASET([{5, 'No data deployed on the given date'}], MyRec);
		
		STRING filler := '                                                                                                                    ';
		
		

	
											
		Non_FCRA_result_set := if(count(Non_FCRA_combine_results_filter) > 0,
											project(Non_FCRA_combine_results_filter, 
												transform(MyRec, 
													self.order := 3;
													self.line :=	(left.datasetname + filler)[1..25] + 
																				(left.buildversion + filler)[1..20] + 	
																				(left.releasedate + filler)[1..20] + 	
																				(left.days_since_updated + filler)[1..14] +
      																	(left.threshold + filler)[1..20] ;
																				) ),
											Non_FCRA_ds_no_data);
											
		FCRA_result_set := if(count(FCRA_combine_results_filter) > 0,
											project(FCRA_combine_results_filter, 
												transform(MyRec, 
													self.order := 5;
													self.line :=	(left.datasetname + filler)[1..25] + 
																				(left.buildversion + filler)[1..20] + 	
																				(left.releasedate + filler)[1..20] + 	
																				(left.days_since_updated + filler)[1..14] +
      																	(left.threshold + filler)[1..20] ;
																				) ),
											FCRA_ds_no_data);										
											
											
/* 	base_head := 	'*************************************************************************************' + '\n' +
         									 environment_name + 'Stale Dataset' + '\n' +
         									// '    This report is produced by Scoring QA. Please send comments to Nathan Koubsky' + '\n' +
         									'*************************************************************************************';										
*/
											
	line_heading := ('Dataset' + filler)[1..25] + 
										// (trim(environment_name, right) + filler)[1..20] + 
										// (trim(environment_name, right) + filler)[1..28] + 
										// (trim(other_envment_name, right) + filler)[1..20] +
										// (trim(other_envment_name, right) + filler)[1..28] +
										// '\n' +
										// ('Name' + filler)[1..25] + 
										('Build Version' + filler)[1..20] + 
										('Last Update' + filler)[1..20] + 
										('Days Ago' + filler)[1..14] + 
										('Threshold' + filler)[1..16] ;
										// ('Release Date' + filler)[1..28];

		// main_head := DATASET([{1,   'Data Deployment Tracking Report' + '\n'
													// + '*** This report is produced by Scoring QA. Please send comments to Nathan Koubsky ***' + '\n\n'
													// }], MyRec); 		
			
	detailed_head := DATASET([{1,    
														// 'Environment:  '	+ environment_name + '\n'
												  // cluster_name + '\n'
													// + 'Data Date:  ' + date_name + '\n\n'
													 line_heading + '\n'
													// + '--------------------------------------------------------------------------------------------------------------------------------------------'
													+ '----------------------------------------------------------------------------------------'
													}], MyRec); 
	Non_FCRA_head := DATASET([{2,    
														// 'Environment:  '	+ environment_name + '\n'
												  // cluster_name + '\n'
													// + 'Data Date:  ' + date_name + '\n\n'
													 'NONFCRA' 
													// + '--------------------------------------------------------------------------------------------------------------------------------------------'
													// + '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 												
													
	FCRA_head := DATASET([{4,    
														// 'Environment:  '	+ environment_name + '\n'
												  // cluster_name + '\n'
													// + 'Data Date:  ' + date_name + '\n\n'
													 '\n' +'FCRA' 
													// + '--------------------------------------------------------------------------------------------------------------------------------------------'
													// + '-----------------------------------------------------------------------------------------------------------------'
													}], MyRec); 
													
		spacer := DATASET([{6,    
														'\n' 
													+ '\n'  
													}], MyRec);
		
		// spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
		// spacer3 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));

		output_data := PROJECT(SORT(detailed_head + Non_FCRA_head + Non_FCRA_result_set, order), TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));
		
		output_data1 := PROJECT(SORT( FCRA_head + FCRA_result_set, order), TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));

		// output_append := main_head + output_data + spacer;
		output_append := output_data + output_data1 + spacer;
		output_full := SORT(output_append, order);
		// OUTPUT(output_full, NAMED('output_full'));

		MyRec Xform(myrec L,myrec R) := TRANSFORM
				SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
				self := L;
		END;

		XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));
  	// OUTPUT(XtabOut, NAMED('XtabOut'));

		return XtabOut[COUNT(XtabOut)].line;
		// return opposite_set;


end;