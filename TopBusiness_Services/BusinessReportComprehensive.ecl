/*--SOAP--
<message name="BusinessReportComprehensive BIP 2.0 Report">
	<!-- COMPLIANCE/USER SETTINGS -->
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>

  <part name="UltID" type="xsd:string"/>
	<part name="OrgID" type="xsd:string"/>
  <part name="SeleID" type="xsd:string"/>
	<part name="ProxID" type="xsd:string"/>
	<part name="PowID" type="xsd:string"/>
	<part name="EmpID" type="xsd:string"/>
	<part name="DotID" type="xsd:string"/>

	<part name="IncludeAircrafts" type="xsd:boolean"/>
	<part name="IncludeAssociatedBusinesses" type="xsd:boolean"/>
	<part name="IncludeBankruptcies" type="xsd:boolean"/>
  <part name="IncludeBusinessRegistrations" type="xsd:boolean"/>
  <part name="IncludeCompanyVerification" type="xsd:boolean"/>
	<part name="IncludeConnectedBusinesses" type="xsd:boolean"/>
	<part name="IncludeContacts" type="xsd:boolean"/>
  <part name="IncludeDunBradStreet" type="xsd:boolean"/>
  <part name="IncludeExperianBusinessReports" type="xsd:boolean"/>
	<part name="IncludeFinances" type="xsd:boolean"/>
  <part name="IncludeIncorporation" type="xsd:boolean"/>
	<part name="IncludeIndustries" type="xsd:boolean"/>
	<part name="IncludeInternetDomains" type="xsd:boolean"/>
  <part name="IncludeIRS5500" type="xsd:boolean"/>
	<part name="IncludeProfessionalLicenses" type="xsd:boolean"/>
	<part name="IncludeLiensJudgments" type="xsd:boolean"/>
	<part name="IncludeMotorVehicles" type="xsd:boolean"/>
  <part name="IncludeNameVariations" type="xsd:boolean"/>
	<part name="IncludeOpsSites" type="xsd:boolean"/>
	<part name="IncludeParents" type="xsd:boolean"/>
	<part name="IncludeProperties" type="xsd:boolean"/>
	<part name="IncludeUCCFilings" type="xsd:boolean"/>
	<part name="IncludeUCCFilingsSecureds" type = "xsd:boolean"/>
	<part name="IncludeRegisteredAgents" type="xsd:boolean"/>
  <part name="IncludeSanctions" type="xsd:boolean"/>
	<part name="IncludeWatercrafts" type="xsd:boolean"/>
	<part name="IncludeSourceCounts" type="xsd:boolean"/>
	<part name="IncludeCriminalIndicators" type="xsd:boolean"/>
	<part name="LnBranded" type="xsd:boolean"/>
 <part name="IncludeVendorSourceB" type="xsd:boolean"/>
	<part name="BusinessReportFetchLevel" type="xsd:string"/>
	<part name="TopBusinessReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
</message>
*/
/*--INFO-- This service produces a full business report.*/
import TopBusiness_Services,iesp, autostandardi, Doxie, std;
export BusinessReportComprehensive() := macro

	#constant('NoDeepDive', true);
	rec_in 		:= iesp.TopBusinessReport.t_TopBusinessReportRequest;
	ds_in 		:= dataset([],rec_in) : stored('TopBusinessReportRequest',few);
	first_row := ds_in[1] : independent;

	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	// Set DPPA, GLBA, DRM, etc.
	iesp.ECL2ESP.SetInputUser (first_row.User);

	report_by 			:= global(first_row.ReportBy.BusinessIds);
	report_options 	:= global(first_row.Options);
	user_options 		:= global(first_row.User);

	#stored('DotID',report_by.DotID);
	#stored('EmpID',report_by.EmpID);
	#stored('POWID',report_by.POWID);
  #stored('SeleID',report_by.SeleID);
	#stored('ProxID',report_by.ProxID);
	#stored('OrgID',report_by.OrgID);
	#stored('UltID',report_by.UltID);

	string s_DotID  := '' : stored('DotID');
	string s_EmpID  := '' : stored('EmpID');
	string s_PowID  := '' : stored('PowID');
	string s_ProxID := '' : stored('ProxID');
	string s_SeleID := '' : stored('SeleID');
	string s_OrgID  := '' : stored('OrgID');
	string s_UltID  := '' : stored('UltID');

	#stored('IncludeAircrafts',report_options.IncludeAircrafts);
	#stored('IncludeAssociatedBusinesses',report_options.IncludeAssociatedBusinesses);
	#stored('IncludeBankruptcies',report_options.IncludeBankruptcies);
	#stored('IncludeBusinessRegistrations', report_options.IncludeBusinessRegistrations);
     #stored('IncludeBusinessInsight',report_options.IncludeBusinessInsight);
	#stored('IncludeCompanyVerification', report_options.IncludeCompanyVerification);
	#stored('IncludeConnectedBusinesses', report_options.IncludeConnectedBusinesses);
	#stored('IncludeContacts',report_options.IncludeContacts);
	#stored('IncludeFinances',report_options.IncludeFinances);
	#stored('IncludeIncorporation',report_options.IncludeIncorporation);
	#stored('IncludeIndustries',report_options.IncludeIndustries);
	#stored('IncludeInternetDomains',report_options.IncludeInternetDomains);
	#stored('IncludeIRS5500',report_options.IncludeIRS5500);
	#stored('IncludeProfessionalLicenses',report_options.IncludeProfessionalLicenses);
	#stored('IncludeLiensJudgments',report_options.IncludeLiensJudgments);
	#stored('IncludeMotorVehicles',report_options.IncludeMotorVehicles);
	#stored('IncludeOpsSites',report_options.IncludeOpsSites);
	#stored('IncludeNameVariations',report_options.IncludeNameVariations);
	#stored('IncludeParents',report_options.IncludeParents);
	#stored('IncludeProperties',report_options.IncludeProperties);
	#stored('IncludeUCCFilings',report_options.IncludeUCCFilings);
	#stored('IncludeUCCFilingsSecureds',report_options.IncludeUCCFilingsSecureds);
	#stored('IncludeRegisteredAgents',report_options.IncludeRegisteredAgents);
	#stored('IncludeSanctions',report_options.IncludeSanctions);
	#stored('IncludeWatercrafts',report_options.IncludeWatercrafts);
	#stored('IncludeSourceCounts',report_options.IncludeSourceCounts);
	#stored('IncludeDunBradStreet',report_options.IncludeDunBradStreet);
	#stored('IncludeExperianBusinessReports',report_options.IncludeExperianBusinessReports);
	#stored('IncludeCriminalIndicators',report_options.IncludeCriminalIndicators);
     #stored('IncludeBizToBizDelinquencyRiskIndicator', report_options.IncludeBizToBizDelinquencyRiskIndicator);
	#stored('LnBranded',user_options.LnBranded);
	#stored('IncludeVendorSourceB',report_options.IncludeVendorSourceB);	
	#stored('IncludeAssignmentsAndReleases',report_options.IncludeAssignmentsAndReleases);	
  #WEBSERVICE(FIELDS('ULTID',
	                    'ORGID',
											'SELEID',
											'PROXID',
											'POWID',
											'EMPID',
											'DOTID',
											'BusinessReportFetchLevel',
											'IncludeAssociatedBusinesses',
                                                          'IncludeBusinessInsight',
											'IncludeParents',
											'IncludeContacts',
											'IncludeFinances',
											'IncludeOpsSites',
											'IncludeIncorporation',
											'IncludeIndustries',
											'IncludeInternetDomains',
											'IncludeUCCFilings',
											'IncludeUCCFilingsSecureds',
											'IncludeLiensJudgments',
											'IncludeMotorVehicles',
											'IncludeAircrafts',
											'IncludeWatercrafts',
											'IncludeBankruptcies',
											'IncludeProperties',
											'IncludeSourceCounts',
											'IncludeProfessionalLicenses',
											'IncludeRegisteredAgents',
											'IncludeConnectedBusinesses',
											'IncludeNameVariations',
											'IncludeBusinessRegistrations',
											'IncludeCompanyVerification',
											'IncludeIRS5500',
											'IncludeSanctions',
											'IncludeDunBradStreet',
											'IncludeExperianBusinessReports',
											'IncludeCriminalIndicators',
                                                          'IncludeBizToBizDelinquencyRiskIndicator',
											'LnBranded',
											'IncludeVendorSourceB',
                      'IncludeAssignmentsAndReleases',
											'DataRestrictionMask',
											'DataPermissionMask',
											'DPPAPurpose',
											'GLBPurpose',
											'SSNMASK'									
											));

	boolean AssociateBus 					:= false :  stored('IncludeAssociatedBusinesses');
	boolean Parent		 						:= false :  stored('IncludeParents');
	boolean Con 									:= false :  stored('IncludeContacts');
	boolean Finance	 							:= false :  stored('IncludeFinances');
	boolean OpsSites 							:= false :  stored('IncludeOpsSites');
	boolean InCorp 								:= false : stored('IncludeIncorporation');
	boolean Indust 								:= false :  stored('IncludeIndustries');
	boolean URL 									:= false :  stored('IncludeInternetDomains');
	boolean UCCSect 							:= false :  stored('IncludeUCCFilings');
	boolean UCCSecureds 					:= false : stored('IncludeUCCFilingsSecureds');
	boolean Liens 								:= false :  stored('IncludeLiensJudgments');
	boolean MVR 									:= false : stored('IncludeMotorVehicles');
	boolean Aircraft 							:= false :  stored('IncludeAircrafts');
	boolean Wc 										:= false :  stored('IncludeWatercrafts');
	boolean Bk 										:= false :  stored('IncludeBankruptcies');
	boolean Prop 									:= false :  stored('IncludeProperties');
	boolean Source 								:= false : stored('IncludeSourceCounts');
	boolean License 							:= false : stored('IncludeProfessionalLicenses');
	boolean RA 										:= false  : stored('IncludeRegisteredAgents');
	boolean Connectedbusinesses 	:= false : stored('IncludeConnectedBusinesses');
	boolean nameVariations 				:= false : stored('IncludeNameVariations');
	boolean businessRegistrations := false : stored('IncludeBusinessRegistrations');
	boolean companyVerification 	:= false : stored('IncludeCompanyVerification');
	boolean IRSFiftyFive 					:= false : stored('IncludeIRS5500');
	boolean sanctions 						:= false : stored('IncludeSanctions');
	boolean DNBSect 							:= false : stored('IncludeDunBradStreet');
	boolean ExperianBusReport 		:= false : stored('IncludeExperianBusinessReports');
	boolean CriminalIndicators 		:= false : stored('IncludeCriminalIndicators');
      boolean BusinessInsight 		:= false : stored('IncludeBusinessInsight');     
     boolean IncludeBizToBizDelinquencyRI := false : stored('IncludeBizToBizDelinquencyRiskIndicator');
	boolean lnbranded 						:= false : stored('LnBranded');
	boolean includeVendorSourceB 						:= false : stored('IncludeVendorSourceB');
	boolean IncludeAssignmentsAndReleases 						:= false : stored('IncludeAssignmentsAndReleases');
	// set DEFAULT for query level report fetches to be at the SELEID = S level.
	string1 BusinessReportFetchLevel := 'S' : stored('BusinessReportFetchLevel');
	  
	TopBusiness_Services.BusinessReportComprehensive_Layouts init_options() := transform
	  self.ApplicationType 								:= AutoStandardI.GlobalModule().ApplicationType;
	  self.IncludeAssociatedBusinesses 		:= AssociateBus;
		self.IncludeParents 								:= Parent;
           self.IncludeBusinessInsight                        := BusinessInsight;
		self.IncludeContacts  							:=  Con;
		self.IncludeFinances   							:= Finance;
		self.IncludeOpsSites 								:= OpsSites;
		self.IncludeIncorporation 					:= InCorp;
		self.IncludeIndustries 							:= Indust;
		self.IncludeInternetDomains 				:= URL;
		self.IncludeUCCFilings 							:= UCCSect;
		self.IncludeUCCFilingsSecureds 			:= (UCCsect and UCCSecureds);
		self.IncludeLiensJudgments 					:= Liens;
		self.IncludeAircrafts 							:= Aircraft;
		self.IncludeMotorVehicles 					:= MVR;
		self.IncludeWatercrafts 						:= Wc;
		self.IncludeBankruptcies 						:= Bk;
		self.IncludeProperties 							:= Prop;
		self.IncludeRegisteredAgents 				:= RA;
		self.IncludeConnectedBusinesses 		:= ConnectedBusinesses;
		self.IncludeSourceCounts 						:= Source;
		self.IncludeProfessionalLicenses 		:= License;
		self.IncludeNameVariations 					:= namevariations;
		self.IncludeBusinessRegistrations 	:= businessRegistrations;
		self.IncludeIRS5500 								:= IRSFiftyFive;
		self.IncludeCompanyVerification 		:= companyVerification;
		self.IncludeSanctions 							:= sanctions;
		self.IncludeDunBradStreet 					:= DNBSect;
		self.IncludeExperianBusinessReports := ExperianBusReport;
		self.IncludeCriminalIndicators			:= CriminalIndicators;
           self.IncludeBizToBizDelinquencyRiskIndicator      :=  IncludeBizToBizDelinquencyRI;
		self.lnbranded 											:= lnbranded;
		self.IncludeVendorSourceB           := includeVendorSourceB;
		self.IncludeAssignmentsAndReleases  := IncludeAssignmentsAndReleases;
		self.internal_testing 							:= false ; //internal_testing;
		self.BusinessReportFetchLevel 			:= topbusiness_services.functions.fn_fetchLevel(trim(std.str.ToUpperCase(BusinessReportFetchLevel),left,right)[1]);    
		self := [];
	end;

	options := row(init_options()); // can uncomment later

	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	// Create dataset
	TopBusiness_Services.Layouts.rec_input_ids initialize() := transform
		 self.acctno := 'SINGLE';
		 self.DotID  := (unsigned6) s_dotid,
	   self.EmpID  := (unsigned6) s_empid,
		 self.PowID  := (unsigned6) s_powid,
		 self.ProxID := (unsigned6) s_proxid,
		 self.SeleID := (unsigned6) s_seleid,
		 self.OrgID  := (unsigned6) s_orgid,
		 self.UltID  := (unsigned6) s_ultid,
	end;

	ds := dataset([initialize()]);

	tempmod := module(AutoStandardI.DataRestrictionI.params)
		export boolean 		AllowAll 						:= false;
		export boolean 		AllowDPPA 					:= false;
		export boolean 		AllowGLB 						:= false;
		export string 		DataRestrictionMask := '' 		: stored('DataRestrictionMask');
		export unsigned1	DPPAPurpose 				:= 0 			: stored('DPPAPurpose');
		export unsigned1 	GLBPurpose 					:= 0 			: stored('GLBPurpose');
		export boolean 		ignoreFares 				:= false;
		export boolean 		ignoreFidelity 			:= false;
		export boolean 		includeMinors 			:= false;
	end;

 // Get report
	tmpresults := TopBusiness_Services.Guts.getReport(ds,options,tempmod);

  tmp2 := project(tmpresults, transform(iesp.TopBusinessReport.t_topBusinessReportRecord,
	                             self := left, self := []));

	iesp.topbusinessReport.t_TopBusinessReportResponse format() := transform
		temp_cnt 				:= count(tmp2);
		self._Header		:= iesp.ECL2ESP.GetHeaderRow(),
		self.Businesses := if (temp_cnt > 0, tmp2[1])
  end;

	results := dataset([format()]);
  
  	//Log to Deltabase
		// Deltabase_Logging_prep := project(results, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																										 // self.company_id := (Integer)CompanyID,
																										 // self.login_id := _LoginID,
																										 //self.product_id := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_BIP_Combined_Service,
																										 //self.function_name := FunctionName,
																										// self.esp_method := ESPMethod,
																										// self.interface_version := InterfaceVersion,
																										// self.delivery_method := DeliveryMethod,
																										 // self.date_added := (STRING8)Std.Date.Today(),
																										// self.death_master_purpose := DeathMasterPurpose,
																										// self.ssn_mask := SSN_Mask,
																										// self.dob_mask := DOB_Mask,
																										// self.dl_mask := (String)(Integer)DL_Mask,
																										// self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																										// self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																										// self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                     // self.glb := inmod.GLBAPurpose,
                                                     // self.dppa := inmod.DPPAPurpose,
																										 // self.data_restriction_mask := users.DataRestrictionMask,
																										 // self.data_permission_mask := users.DataPermissionMask,
																										 // self.industry := Industry_Search[1].Industry,
																										 // self.i_attributes_name := Attributes_Requested[1].AttributeGroup,
																										 // self.i_ssn := search.AuthorizedRep1.SSN,
                                                     // self.i_dob := Rep_1_DOB,
                                               
																									
                                                     // self.o_seleid := left.SmallBusinessAnalyticsResults.BusinessIds.SeleID,
                                                     // self := left,
																										 // self := [] ));
		// Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
		// #stored('Deltabase_Log', Deltabase_Logging);

		//Improved Scout Logging
		// IF(~DisableOutcomeTracking and ~TestData_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
		
	output(Results,named('Results'));

endmacro;