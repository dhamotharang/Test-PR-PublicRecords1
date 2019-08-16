/*--SOAP--
<message name="SupplierRiskReport_Service" wuTimeout="300000">
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
	<part name="IncludeDiversityCert" type="xsd:boolean"/>
	<part name="IncludeRiskMetrics" type="xsd:boolean"/>
	<part name="IncludeLaborActWHD" type="xsd:boolean"/>
	<part name="IncludeNatDisReady" type="xsd:boolean"/>
	<part name="IncludeLNCA" type="xsd:boolean"/>
	<part name="IncludeOSHAIR" type="xsd:boolean"/>
	<part name="IncludeBusinessCreditRisk" type="xsd:boolean"/>
	<part name="IncludeBusinessFailureRiskLevel" type="xsd:boolean"/>
	<part name="IncludeCustomBCIR" type="xsd:boolean"/>
	<part name="IncludeSourceCounts" type="xsd:boolean"/>
	<part name="LnBranded" type="xsd:boolean"/>
	<part name="ReportFetchLevel" type="xsd:string"/>

	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>

	<part name="SupplierRiskReportRequest" type="tns:XmlDataSet" cols="80" rows="30"/>

</message>
*/
/*--INFO-- This service produces a full business report.*/
IMPORT iesp, autostandardi,risk_indicators, doxie;
EXPORT SupplierRiskReport_Service() := MACRO

	#constant('NoDeepDive', true);
	rec_in := iesp.SupplierRiskReport.t_SupplierRiskReportRequest;
	ds_in := dataset([],rec_in) : stored('SupplierRiskReportRequest',few);
	first_row := ds_in[1] : independent;

	s_gateway := dataset([],risk_indicators.Layout_Gateways_In) 	: stored('gateways');
	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);

	report_by := global(first_row.ReportBy.BusinessId);

	report_options := global(first_row.Options);
	user_options := global(first_row.User);

	#stored('DotID',report_by.DotID);
	#stored('EmpID',report_by.EmpID);
	#stored('POWID',report_by.POWID);
  #stored('SeleID',report_by.SeleID);
	#stored('ProxID',report_by.ProxID);
	#stored('OrgID',report_by.OrgID);
	#stored('UltID',report_by.UltID);

	string12 s_DotID  := '' : stored('DotID');
	string12 s_EmpID  := '' : stored('EmpID');
	string12 s_PowID  := '' : stored('PowID');
	string12 s_ProxID := '' : stored('ProxID');
	string12 s_SeleID := '' : stored('SeleID');
	string12 s_OrgID  := '' : stored('OrgID');
	string12 s_UltID  := '' : stored('UltID');

  //#stored('SelectAll',report_options.SelectAll);
	#stored('IncludeAircrafts',report_options.IncludeAircrafts);
	#stored('IncludeAssociatedBusinesses',report_options.IncludeAssociatedBusinesses);
	#stored('IncludeBankruptcies',report_options.IncludeBankruptcies);
	#stored('IncludeBusinessRegistrations', report_options.IncludeBusinessRegistrations);
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
	#stored('IncludeDiversityCert',report_options.IncludeDiversityCert);
	#stored('IncludeRiskMetrics',report_options.IncludeRiskMetrics);
	#stored('IncludeLaborActWHD',report_options.IncludeLaborActWHD);
	#stored('IncludeNatDisReady',report_options.IncludeNatDisReady);
	#stored('IncludeLNCA',report_options.IncludeLNCA);
	#stored('IncludeOSHAIR',report_options.IncludeOSHAIR);
	#stored('IncludeBusinessCreditRisk',report_options.IncludeBusinessCreditRisk);
	#stored('IncludeBusinessFailureRiskLevel',report_options.IncludeBusinessFailureRiskLevel);
	#stored('IncludeCustomBCIR',report_options.IncludeCustomBCIR);
	#stored('LnBranded',user_options.LnBranded);
  #stored('ReportFetchLevel','S'); //report_options.ReportFetchLevel);

	boolean AssociateBus := false :  stored('IncludeAssociatedBusinesses');
	boolean Parent := false :  stored('IncludeParents');
	boolean Con := false :  stored('IncludeContacts');
	boolean Finance := false :  stored('IncludeFinances');
	boolean OpsSites := false :  stored('IncludeOpsSites');
	boolean InCorp := false : stored('IncludeIncorporation');
	boolean Indust := false :  stored('IncludeIndustries');
	boolean URL := false :  stored('IncludeInternetDomains');
	boolean UCCSect := false :  stored('IncludeUCCFilings');
	boolean UCCSecureds := false : stored('IncludeUCCFilingsSecureds');
	boolean Liens := false :  stored('IncludeLiensJudgments');
	boolean MVR := false : stored('IncludeMotorVehicles');
	boolean Aircraft := false :  stored('IncludeAircrafts');
	boolean Wc := false :  stored('IncludeWatercrafts');
	boolean Bk := false :  stored('IncludeBankruptcies');
	boolean Prop := false :  stored('IncludeProperties');
	boolean Source := false : stored('IncludeSourceCounts');
	boolean License := false : stored('IncludeProfessionalLicenses');
	boolean RA := false  : stored('IncludeRegisteredAgents');
	boolean Connectedbusinesses := false : stored('IncludeConnectedBusinesses');
	boolean nameVariations := false : stored('IncludeNameVariations');
	boolean businessRegistrations := false : stored('IncludeBusinessRegistrations');
	boolean companyVerification := false : stored('IncludeCompanyVerification');
	boolean IRSFiftyFive := false : stored('IncludeIRS5500');
	boolean sanctions := false : stored('IncludeSanctions');
	boolean DNBSect := false : stored('IncludeDunBradStreet');
	boolean ExperianBusReport := false : stored('IncludeExperianBusinessReports');
	boolean DiversityCert := false : stored('IncludeDiversityCert');
	boolean RiskMetrics := false : stored('IncludeRiskMetrics');
	boolean LaborActWHD := false : stored('IncludeLaborActWHD');
	boolean NatDisReady := false : stored('IncludeNatDisReady');
	boolean LNCA := false : stored('IncludeLNCA');
	boolean OSHAIRx := false : stored('IncludeOSHAIR');
	boolean BusinessCreditRisk := false : stored('IncludeBusinessCreditRisk');
	boolean BusinessFailureRiskLevel := false : stored('IncludeBusinessFailureRiskLevel');
	boolean CustomBCIR := false : stored('IncludeCustomBCIR');
	boolean lnbranded := false : stored('LnBranded');
	// set DEFAULT for query level report fetches to be at the SELEID = S level.
	string1 ReportFetchLevel := 'S' : stored('ReportFetchLevel');
	//boolean SelectAll := false;// : stored('SelectAll');
  //boolean internal_testing := false : stored('InternalTesting');


	SupplierRisk_Services.SupplierRisk_Layouts.Report_options init_options() := transform
	  self.ApplicationType := AutoStandardI.GlobalModule().ApplicationType;
	  self.IncludeAssociatedBusinesses := AssociateBus;
		self.IncludeParents := Parent;
		self.IncludeContacts  :=  Con;
		self.IncludeFinances   := Finance;
		self.IncludeOpsSites := OpsSites;
		self.IncludeIncorporation := InCorp;
		self.IncludeIndustries := Indust;
		self.IncludeInternetDomains := URL;
		self.IncludeUCCFilings := UCCSect;
		self.IncludeUCCFilingsSecureds :=  (UCCsect and UCCSecureds);
		self.IncludeLiensJudgments := Liens;
		self.IncludeAircrafts := Aircraft;
		self.IncludeMotorVehicles := MVR;
		self.IncludeWatercrafts := Wc;
		self.IncludeBankruptcies := Bk;
		self.IncludeProperties := Prop;
		self.IncludeRegisteredAgents := RA;
		self.IncludeConnectedBusinesses := ConnectedBusinesses;
		self.IncludeSourceCounts := Source;
		self.IncludeProfessionalLicenses := License;
		self.IncludeNameVariations := namevariations;
		self.IncludeBusinessRegistrations := businessRegistrations;
		self.IncludeIRS5500 := IRSFiftyFive;
		self.IncludeCompanyVerification := companyVerification;
		self.IncludeSanctions := sanctions;
		self.IncludeDunBradStreet := DNBSect;
		self.IncludeExperianBusinessReports := ExperianBusReport;
		self.IncludeDiversityCert := DiversityCert;
		self.IncludeRiskMetrics := RiskMetrics;
		self.IncludeNatDisReady := NatDisReady;
		self.IncludeLaborActWHD := LaborActWHD;
		self.IncludeLNCA := LNCA;
		self.IncludeOSHAIR := OSHAIRx;
		self.IncludeBusinessCreditRisk := BusinessCreditRisk;
		self.IncludeBusinessFailureRiskLevel := BusinessFailureRiskLevel;
		self.IncludeCustomBCIR := CustomBCIR;
		self.lnbranded := lnbranded;
		self.internal_testing := false ; //internal_testing;
		self.ReportFetchLevel := topbusiness_services.functions.fn_fetchLevel(trim(stringlib.stringToUpperCase(ReportFetchLevel),left,right)[1]);
		self := [];
	end;

	options := row(init_options()); // can uncomment later

	// Create dataset
	SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids initialize() := TRANSFORM
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
		export boolean AllowAll := false;
		export boolean AllowDPPA := false;
		export boolean AllowGLB := false;
		export string DataRestrictionMask := '' : stored('DataRestrictionMask');
		export unsigned1 DPPAPurpose := 0 : stored('DPPAPurpose');
		export unsigned1 GLBPurpose := 0 : stored('GLBPurpose');
		export boolean ignoreFares := false;
		export boolean ignoreFidelity := false;
		export boolean includeMinors := false;
	end;

	// Get report
	tmpresults := SupplierRisk_Services.SupplierRisk_records(ds,options,tempmod);


	tmp := project(tmpresults, transform(iesp.SupplierRiskReport.t_SupplierRiskReportRecord,
	                             self := left, self := []));
	validRpt := IF(tmp[1].Bestsection.CompanyName !='',true,false);

	iesp.SupplierRiskReport.t_SupplierRiskReportResponse format() := transform
													self._Header         := iesp.ECL2ESP.GetHeaderRow(),
													// Only output report if best company name exists.
	                        self.Businesses := IF(validRpt,tmp[1]),
													self.RecordCount := IF(validRpt,1,0),
													self := []
  end;
	results := dataset([format()]);

	// dataset(iesp.gateway_inviewreport.t_InviewReportResponse) rpt.EquifaxBusinessReport
	efx_table := dataset(row(tmp[1].EQFXGatewaySection,iesp.gateway_inviewreport.t_InviewReportResponse));
	inv_royalties := Royalty.RoyaltyInview.GetOnlineRoyalties(efx_table,BusinessCreditRisk,BusinessFailureRiskLevel,CustomBCIR);

	royalties := dataset([], Royalty.Layouts.Royalty) +
		IF(BusinessCreditRisk or BusinessFailureRiskLevel or CustomBCIR, inv_royalties);

	output(Results,named('Results'));
	output(royalties, named('RoyaltySet'));

ENDMACRO;