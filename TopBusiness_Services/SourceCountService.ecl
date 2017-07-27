/*--SOAP--
<message name="SourceCountService">
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
  <part name="IncludeBetterBusinessBureau" type="xsd:boolean"/>
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
	<part name="IncludeIRS990" type="xsd:boolean"/>
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
  <part name="IncludeSalesTax" type="xsd:boolean"/>
	<part name="IncludeWatercrafts" type="xsd:boolean"/>
  <part name="IncludeWorkersComp" type="xsd:boolean"/>
	<part name="LnBranded" type="xsd:boolean"/>
	<part name="SourceDocFetchLevel" type="xsd:string"/>  //values['S','D','C','W','P','O','U',''
	
	<part name="TopBusinessSourceCountRequest" type="tns:XmlDataSet" cols="80" rows="30"/>
	
</message>
*/
/*--INFO-- This service produces a full business report.*/
import iesp, autostandardi;
export SourceCountService() := macro
#constant('NoDeepDive', true);
#constant ('CaseNumber', '');

	rec_in := iesp.TopBusinessSourceCount.t_TopBusinessSourceCountRequest;
	ds_in := dataset([],rec_in) : stored('TopBusinessSourceCountRequest',few);
	first_row := ds_in[1] : independent;
	
	// Set some base options
	iesp.ECL2ESP.SetInputBaseRequest (first_row);
	
	// Set DPPA, GLBA, DRM, etc.
	iesp.ECL2ESP.SetInputUser (first_row.User);
	
	count_by := global(first_row.CountBy.BusinessIds);
	
	report_options := global(first_row.Options);
	user_options := global(first_row.User);

	#stored('DotID',count_by.DotID);
	#stored('EmpID',count_by.EmpID);
	#stored('POWID',count_by.POWID);
  #stored('SeleID',count_by.SeleID);
	#stored('ProxID',count_by.ProxID);
	#stored('OrgID',count_by.OrgID);
	#stored('UltID',count_by.UltID);
	
	string s_DotID  := '' : stored('DotID');
	string s_EmpID  := '' : stored('EmpID'); //in BIP2.0, these will always be 0	
	string s_PowID  := '' : stored('PowID');	 //in BIP2.0, these will always be 0
	string s_ProxID := '' : stored('ProxID');	
	string s_SeleID := '' : stored('SeleID');
	string s_OrgID  := '' : stored('OrgID');
	string s_UltID  := '' : stored('UltID');
	
  //#stored('SelectAll',report_options.SelectAll);
	#stored('IncludeAircrafts',report_options.IncludeAircrafts);
	#stored('IncludeAssociatedBusinesses',report_options.IncludeAssociatedBusinesses);
	#stored('IncludeBankruptcies',report_options.IncludeBankruptcies);
	#stored('IncludeBetterBusinessBureau',report_options.IncludeBetterBusinessBureau);
	#stored('IncludeBusinessRegistrations', report_options.IncludeBusinessRegistrations);
	#stored('IncludeCompanyVerification', report_options.IncludeCompanyVerification);
	#stored('IncludeConnectedBusinesses', report_options.IncludeConnectedBusinesses);
	#stored('IncludeContacts',report_options.IncludeContacts);
	#stored('IncludeDunBradStreet',report_options.IncludeDunBradStreet);
	#stored('IncludeExperianBusinessReports',report_options.IncludeExperianBusinessReports);
	#stored('IncludeFDIC',report_options.IncludeFDIC);
	#stored('IncludeFinances',report_options.IncludeFinances);	
	#stored('IncludeIncorporation',report_options.IncludeIncorporation);
	#stored('IncludeIndustries',report_options.IncludeIndustries);
	#stored('IncludeInternetDomains',report_options.IncludeInternetDomains);
	#stored('IncludeIRS5500',report_options.IncludeIRS5500);
	#stored('IncludeIRS990',report_options.IncludeIRS990);
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
	#stored('IncludeSalesTax',report_options.IncludeSalesTax);
	#stored('IncludeSanctions',report_options.IncludeSanctions);
	#stored('IncludeWatercrafts',report_options.IncludeWatercrafts);
	#stored('IncludeWorkersComp',report_options.IncludeWorkersComp);

	boolean IncAssociateBus := false :  stored('IncludeAssociatedBusinesses');	
	boolean IncParent := false :  stored('IncludeParents');	
	boolean IncCon := false :  stored('IncludeContacts');	
	boolean IncFinance := false :  stored('IncludeFinances');
	boolean IncOpsSites := false :  stored('IncludeOpsSites');
	boolean IncInCorp := false : stored('IncludeIncorporation');
	boolean IncIndust := false :  stored('IncludeIndustries');
	boolean IncURL := false :  stored('IncludeInternetDomains');
	boolean IncUCCSect := false :  stored('IncludeUCCFilings');
	boolean IncUCCSecureds := false : stored('IncludeUCCFilingsSecureds');
	boolean IncLiens := false :  stored('IncludeLiensJudgments');
	boolean IncMVR := false : stored('IncludeMotorVehicles');
	boolean IncAircraft := false :  stored('IncludeAircrafts');
	boolean IncWc := false :  stored('IncludeWatercrafts');
	boolean IncBk := false :  stored('IncludeBankruptcies');
	boolean IncProp := false :  stored('IncludeProperties');
	boolean IncLicense := false : stored('IncludeProfessionalLicenses');
	boolean IncRA := false  : stored('IncludeRegisteredAgents');
	boolean IncConnectedbusinesses := false : stored('IncludeConnectedBusinesses');
	boolean IncnameVariations := false : stored('IncludeNameVariations');
	boolean IncbusinessRegistrations := false : stored('IncludeBusinessRegistrations');
	boolean InccompanyVerification := false : stored('IncludeCompanyVerification');
	boolean IncIRSFiftyFive := false : stored('IncludeIRS5500');
	boolean IncDunAndBrad := false : stored('IncludeDunBradStreet');
	boolean IncEBR := false : stored('IncludeExperianBusinessReports');
	boolean IncIRSNinetyNine := false : stored('IncludeIRS990');
	boolean IncworkersComp := false : stored('IncludeWorkersComp');
	boolean IncBBB := false : stored('IncludeBetterBusinessBureau');
	boolean IncsalesTax := false : stored('IncludeSalesTax');
	boolean Incsanctions := false : stored('IncludeSanctions');
	boolean IncFDIC := false : stored('IncludeFDIC');
	
	TopBusiness_Services.SourceCount_Layouts.OptionsLayout init_options() := transform	  	 
	  self.app_type  := AutoStandardI.GlobalModule().ApplicationType;
		self.ssn_mask  := AutoStandardI.GlobalModule().ssnmask;
		self.fetch_level := topbusiness_services.functions.fn_fetchLevel(report_options.SourceDocFetchLevel);
	  self.IncludeAssociatedBusinesses := IncAssociateBus; 
		self.IncludeParents := IncParent; 
		self.IncludeContacts  :=  IncCon;
		self.IncludeFinances   := IncFinance; 
		self.IncludeOpsSites := IncOpsSites; 
		self.IncludeIncorporation := IncInCorp; 
		self.IncludeIndustries := IncIndust; 
		self.IncludeInternetDomains := IncURL; 
		self.IncludeUCCFilings := IncUCCSect; 
		self.IncludeUCCFilingsSecureds :=  (IncUCCsect and IncUCCSecureds); 
		self.IncludeLiensJudgments := IncLiens; 
		self.IncludeAircrafts := IncAircraft; 
		self.IncludeMotorVehicles := IncMVR; 
		self.IncludeWatercrafts := IncWc; 
		self.IncludeBankruptcies := IncBk;
		self.IncludeProperties := IncProp;	
		self.IncludeRegisteredAgents := IncRA; 
		self.IncludeConnectedBusinesses := IncConnectedBusinesses;
		self.IncludeProfessionalLicenses := IncLicense;
		self.IncludeNameVariations := Incnamevariations; 
		self.IncludeBusinessRegistrations := IncbusinessRegistrations;
		self.IncludeIRS5500 := IncIRSFiftyFive;
		self.IncludeCompanyVerification := InccompanyVerification;
		self.IncludeDunBradStreet := IncDunAndBrad;
		self.IncludeExperianBusinessReports := IncEBR;
		self.IncludeIRS990 := IncIRSNinetyNine;
		self.IncludeWorkersComp := IncworkersComp;
		self.IncludeBetterBusinessBureau := IncBBB;
		self.IncludeSalesTax := IncsalesTax;
		self.IncludeSanctions := Incsanctions;
		self.IncludeFDIC := IncFDIC;
		self := [];
	end;
	
	options := row(init_options()); 
	
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
	       
	// Get source counts
	results := TopBusiness_Services.SourceCount(ds,options,tempmod);

	output(results,named('Results'));
endmacro;