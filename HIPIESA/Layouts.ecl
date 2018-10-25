EXPORT Layouts := MODULE

EXPORT ProviderSearchLayout := RECORD
		INTEGER seq 							:= 0;
		STRING FacilityName 			:='';
		STRING ProviderKey			 	:= '';
		STRING ProviderNPI	 			:= '';
		STRING ProviderFirstName	:= '';
		STRING ProviderLastName		:= '';
	END;
	
EXPORT FacilityNameLayout := RECORD
  string120 companyname;
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string10 providernpi;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
 END;

EXPORT ProviderLastNameLayout := RECORD
  string20 lastname;
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string10 providernpi;
  string20 firstname;
  string20 middlename;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
 END;
 
 EXPORT ProviderFirstNameLayout := RECORD
  string20 firstname;
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string10 providernpi;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
 END;

EXPORT ProviderNpiLayout := RECORD
  string10 providernpi;
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
 END;
 
EXPORT  ProviderKeyLayout := RECORD
  string50 providerkey;
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string10 providernpi;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
 END;

EXPORT PayloadLayout := RECORD
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string10 providernpi;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
  string50 specialty;
  unsigned8 chargeddollars;
  unsigned8 paiddollars;
  unsigned8 claims;
  string8 datefirstseen;
  string8 claimstartdate;
  string8 claimenddate;
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  string5 countycode;
  string7 statecountycode;
  string50 addressline1;
  string75 addressline;
  string10 latitude;
  string10 longitude;
  string25 addresskey;
  string50 networkkey;
  string50 legalbusinessname;
  string50 doingbusinessas;
  string businessaddress;
  unsigned1 ininputfile;
  string8 incorporationdate;
  boolean legalentityisactive;
  boolean legalentityisdefunct;
  unsigned8 __internal_fpos__;
END;

/*
EXPORT PayloadLayout := RECORD
  unsigned8 recordid;
  string20 preferredfirstname;
  string20 phoneticlastname;
  string50 providerkey;
  string10 providernpi;
  string20 firstname;
  string20 middlename;
  string20 lastname;
  string5 suffixname;
  string50 facilityname;
  unsigned8 lnpid;
  unsigned8 lexid;
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  string5 countycode;
  string7 statecountycode;
  string50 addressline1;
  string75 addressline;
  string10 latitude;
  string10 longitude;
  string25 addresskey;
  string50 networkkey;
  string50 specialty;
  unsigned8 chargeddollars;
  unsigned8 paiddollars;
  unsigned4 claims;
  unsigned4 ininputfile;
  string8 datefirstseen;
  string8 incorporationdate;
  string8 claimstartdate;
  string8 claimenddate;
  string10 legalentityisactive;
  string10 legalentityisdefunct;
  unsigned8 __internal_fpos__;
 END;
*/

EXPORT recordIdLayout := RECORD
	UNSIGNED8 recordId;
END;

	//Used in HIPIESa.MainService
  EXPORT SASearchInput:= RECORD
		STRING FacilityName{XPATH('facilityname')}:='';
    STRING ProviderFirstName{XPATH('providerfirstname')}:='';
		STRING ProviderKey{XPATH('providerkey')}:='';
    STRING ProviderLastName{XPATH('providerlastname')}:='';
    STRING ProviderNPI{XPATH('providernpi')}:='';
  END;


	//Used in HIPIESa.MainService
  EXPORT SASearchOutput := RECORD
    INTEGER seq{XPATH('seq')};
		PayloadLayout;		
		INTEGER ResponseTime {XPATH('_call_latency_ms')}; 
    INTEGER soapcallerrorcode {XPATH('soapcallerrorcode')};
    STRING soapcallerrordescription {XPATH('soapcallerrordescription')};
  END;  
/*
	//Used in HIPIESa.MainService
  EXPORT SASearchOutput := RECORD
    INTEGER seq{XPATH('seq')};
		STRING recordid {XPATH('recordid')};
		STRING preferredfirstname {XPATH('preferredfirstname')};
		STRING phoneticlastname {XPATH('phoneticlastname')};
		STRING providerkey {XPATH('providerkey')};
		STRING providernpi {XPATH('providernpi')};
		STRING firstname {XPATH('firstname')};
		STRING middlename {XPATH('middlename')};
		STRING lastname {XPATH('lastname')};
		STRING suffixname {XPATH('suffixname')};
		STRING facilityname {XPATH('facilityname')};
		STRING lnpid {XPATH('lnpid')};
		STRING lexid {XPATH('lexid')};
		STRING primaryrange {XPATH('primaryrange')};
		STRING predirectional {XPATH('predirectional')};
		STRING primaryname {XPATH('primaryname')};
		STRING addresssuffix {XPATH('addresssuffix')};
		STRING postdirectional {XPATH('postdirectional')};
		STRING secondaryrange {XPATH('secondaryrange')};
		STRING city {XPATH('city')};
		STRING state {XPATH('state')};
		STRING zip5 {XPATH('zip5')};
		STRING countycode {XPATH('countycode')};
		STRING statecountycode {XPATH('statecountycode')};
		STRING addressline1 {XPATH('addressline1')};
		STRING addressline {XPATH('addressline')};
		STRING latitude {XPATH('latitude')};
		STRING longitude {XPATH('longitude')};
		STRING addresskey {XPATH('addresskey')};
		STRING networkkey {XPATH('networkkey')};
		STRING specialty {XPATH('specialty')};
		STRING chargeddollars {XPATH('chargeddollars')};
		STRING paiddollars {XPATH('paiddollars')};
		STRING claims {XPATH('claims')};
		STRING ininputfile {XPATH('ininputfile')};
		STRING datefirstseen {XPATH('datefirstseen')};
		STRING incorporationdate {XPATH('incorporationdate')};
		STRING claimstartdate {XPATH('claimstartdate')};
		STRING claimenddate {XPATH('claimenddate')};
		STRING legalentityisactive {XPATH('legalentityisactive')};
		STRING legalentityisdefunct {XPATH('legalentityisdefunct')};
		STRING __internal_fpos__ {XPATH('__internal_fpos__')};
		INTEGER ResponseTime {XPATH('_call_latency_ms')}; 
    INTEGER soapcallerrorcode {XPATH('soapcallerrorcode')};
    STRING soapcallerrordescription {XPATH('soapcallerrordescription')};
  END;  
*/
END;