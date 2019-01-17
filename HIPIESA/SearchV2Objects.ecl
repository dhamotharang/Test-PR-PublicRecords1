EXPORT SearchV2Objects := MODULE
IMPORT STD;

//
// Layouts
//
EXPORT Layouts := MODULE

EXPORT ProviderSearchLayout := RECORD
	INTEGER seq 							:= 0;
	STRING FacilityName 			:= '';
	STRING ProviderKey			 	:= '';
	STRING ProviderNPI	 			:= '';
	STRING ProviderFirstName	:= '';
	STRING ProviderLastName		:= '';

	STRING InputStreetAddress := '';
  STRING InputCity					:= '';	
  STRING InputState					:= '';	
  STRING InputZip						:= '';

  STRING PrimaryRange				:= '';	
  STRING PrimaryName				:= '';	
  STRING SecondaryRange			:= '';	
  STRING City								:= '';	
  STRING State							:= '';
	STRING Zip								:= '';
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;
 
EXPORT ProviderKeyLayout := RECORD
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;

EXPORT PrimaryRangeLayout := RECORD
  string10 primaryrange;
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
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;

EXPORT PrimaryNameLayout := RECORD
  string28 streetname;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;

EXPORT SecondaryRangeLayout := RECORD
  string8 secondaryrange;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;

EXPORT StateLayout := RECORD
  string2 state;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
END;

EXPORT CityStateLayout := RECORD
  string25 city;
  string2 state;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string5 zip5;
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
  string10 primaryrange;
  string2 predirectional;
  string28 primaryname;
  string4 addresssuffix;
  string2 postdirectional;
  string8 secondaryrange;
  string25 city;
  string2 state;
  string5 zip5;
  unsigned8 lnpid;
  unsigned8 lexid;
  integer8 providerimpactdollars;
  integer8 providerimpactclaims;
  integer8 addressimpactdollars;
  integer8 addressimpactclaims;
  integer8 lnpidimpactdollars;
  integer8 lnpidimpactclaims;
  unsigned4 providerscore;
  string100 specialty;
  unsigned8 chargeddollars;
  unsigned8 paiddollars;
  unsigned8 claims;
  string8 datefirstseen;
  string8 claimstartdate;
  string8 claimenddate;
  string5 countycode;
  string7 statecountycode;
  string50 addressline1;
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


EXPORT recordIdLayout := RECORD
	UNSIGNED8 recordId;
END;

//Used in HIPIESA.MainService
EXPORT SASearchInput:= RECORD
	STRING FacilityName{XPATH('facilityname')}:='';	
	STRING ProviderKey{XPATH('providerkey')}:='';
  STRING ProviderNPI{XPATH('providernpi')}:='';
  STRING ProviderFirstName{XPATH('providerfirstname')}:='';
  STRING ProviderLastName{XPATH('providerlastname')}:='';
	
  STRING StreetAddress{XPATH('streetaddress')}:='';
  STRING City{XPATH('city')}:='';
  STRING State{XPATH('state')}:='';
  STRING Zip{XPATH('zip')}:='';
END;


//Used in HIPIESA.MainService
EXPORT SASearchOutput := RECORD
  INTEGER seq{XPATH('seq')};
	PayloadLayout;		
	INTEGER ResponseTime {XPATH('_call_latency_ms')}; 
  INTEGER soapcallerrorcode {XPATH('soapcallerrorcode')};
  STRING soapcallerrordescription {XPATH('soapcallerrordescription')};
END;  

END;

//
// Indexes
//
EXPORT Indexes(string filenameSuffix) := MODULE
  EXPORT Suffix := filenameSuffix;

  EXPORT FacilityNameIndexFile := '~sa::key::facilityname::' + Suffix;
  SHARED FacilityNameDs := DATASET('', Layouts.FacilityNameLayout, THOR);
  EXPORT FacilityNameIndex := INDEX(FacilityNameDs, {(string120)companyname}, {FacilityNameDs}, FacilityNameIndexFile);

  EXPORT ProviderKeyIndexFile := '~sa::key::providerid::' + Suffix;
  SHARED ProviderKeyDs := DATASET('', Layouts.ProviderKeyLayout, THOR);
  EXPORT ProviderKeyIndex := INDEX(ProviderKeyDs, {(string50)providerkey}, {ProviderKeyDs}, ProviderKeyIndexFile);

  EXPORT ProviderNpiIndexFile := '~sa::key::npi::' + Suffix;
  SHARED ProviderNpiDs := DATASET('', Layouts.ProviderNpiLayout, THOR);
  EXPORT ProviderNpiIndex := INDEX(ProviderNpiDs, {(string10)providernpi}, {ProviderNpiDs}, ProviderNpiIndexFile);

  EXPORT ProviderFirstNameIndexFile := '~sa::key::firstname::' + Suffix;
  SHARED ProviderFirstNameDs := DATASET('', Layouts.ProviderFirstNameLayout, THOR);
  EXPORT ProviderFirstNameIndex := INDEX(ProviderFirstNameDs, {(string20)firstname}, {ProviderFirstNameDs}, ProviderFirstNameIndexFile);

  EXPORT ProviderLastNameIndexFile := '~sa::key::lastname::' + Suffix;
  SHARED ProviderLastNameDs := DATASET('', Layouts.ProviderLastNameLayout, THOR);
  EXPORT ProviderLastNameIndex := INDEX(ProviderLastNameDs, {(string20)lastname}, {ProviderLastNameDs}, ProviderLastNameIndexFile);


  EXPORT PrimaryRangeIndexFile := '~sa::key::primaryrange::' + Suffix;
  SHARED PrimaryRangeDs := DATASET('', Layouts.PrimaryRangeLayout, THOR);
  EXPORT PrimaryRangeIndex := INDEX(PrimaryRangeDs, {(string10)primaryrange}, {PrimaryRangeDs}, PrimaryRangeIndexFile);

  EXPORT PrimaryNameIndexFile := '~sa::key::primaryname::' + Suffix;
  SHARED PrimaryNameDs := DATASET('', Layouts.PrimaryNameLayout, THOR);
  EXPORT PrimaryNameIndex := INDEX(PrimaryNameDs, {(string28)streetname}, {PrimaryNameDs}, PrimaryNameIndexFile);

  EXPORT SecondaryRangeIndexFile := '~sa::key::secondaryrange::' + Suffix;
  SHARED SecondaryRangeDs := DATASET('', Layouts.SecondaryRangeLayout, THOR);
  EXPORT SecondaryRangeIndex := INDEX(SecondaryRangeDs, {(string8)secondaryrange}, {SecondaryRangeDs}, SecondaryRangeIndexFile);

  EXPORT StateIndexFile := '~sa::key::state::' + Suffix;
  SHARED StateDs := DATASET('', Layouts.StateLayout, THOR);
  EXPORT StateIndex := INDEX(StateDs, {(string2)state}, {StateDs}, StateIndexFile);

  EXPORT CityStateIndexFile := '~sa::key::citystate::' + Suffix;
  SHARED CityStateDs := DATASET('', Layouts.CityStateLayout, THOR);
  EXPORT CityStateIndex := INDEX(CityStateDs, {(string25)city, (string2)state}, {CityStateDs}, CityStateIndexFile);

  EXPORT PayloadIndexFile := '~sa::key::payload::' + Suffix;
  SHARED PayloadDs := DATASET('', Layouts.PayloadLayout, THOR);
  EXPORT PayloadIndex := INDEX(PayloadDs, {(unsigned8)recordid}, {PayloadDs}, PayloadIndexFile);
END;

//
// Functions
//

EXPORT StateRec := RECORD
 string name;
 string abbr;
END;

EXPORT StateDat := DATASET([
{'ALABAMA','AL'},
{'ALA','AL'},

{'ALASKA','AK'},

{'ARIZONA','AZ'},
{'ARIZ','AZ'},

{'ARKANSAS','AR'},
{'ARK','AR'},

{'CALIFORNIA','CA'},
{'CAL','CA'},
{'CALIF','CA'},

{'COLORADO','CO'},
{'COLO','CO'},

{'CONNECTICUT','CT'},
{'CONN','CT'},

{'DELAWARE','DE'},
{'DEL','DE'},

{'DISTRICT OF COLUMBIA','DC'},
{'D.C.','DC'},

{'FLORIDA','FL'},
{'FLA','FL'},

{'GEORGIA','GA'},
{'HAWAII','HI'},
{'IDAHO','ID'},

{'ILLINOIS','IL'},
{'ILL','IL'},

{'INDIANA','IN'},
{'IND','IN'},
{'INDY','IN'},

{'IOWA','IA'},

{'KANSAS','KS'},
{'KAN','KS'},

{'KENTUCKY','KY'},
{'LOUISIANA','LA'},
{'MAINE','ME'},
{'MARYLAND','MD'},

{'MASSACHUSETTS','MA'},
{'MASS','MA'},

{'MICHIGAN','MI'},
{'MICH','MI'},

{'MINNESOTA','MN'},
{'MINN','MN'},

{'MISSISSIPPI','MS'},
{'MISS','MS'},

{'MISSOURI','MO'},
{'MONTANA','MT'},

{'NEBRASKA','NE'},
{'NEB','NE'},

{'NEVADA','NV'},
{'NEV','NV'},

{'NEW HAMPSHIRE','NH'},
{'N.H.','NH'},

{'NEW JERSEY','NJ'},
{'N.J.','NJ'},

{'NEW MEXICO','NM'},
{'N.M.','NM'},

{'NEW YORK','NY'},
{'N.Y.','NY'},

{'NORTH CAROLINA','NC'},
{'N.C.','NC'},

{'NORTH DAKOTA','ND'},
{'N.D.','ND'},

{'OHIO','OH'},

{'OKLAHOMA','OK'},
{'OKLA','OK'},

{'OREGON','OR'},
{'ORE','OR'},

{'PENNSYLVANIA','PA'},
{'PENN','PA'},

{'RHODE ISLAND','RI'},
{'R.I.','RI'},

{'SOUTH CAROLINA','SC'},
{'S.C.','SC'},

{'SOUTH DAKOTA','SD'},
{'S.D.','SD'},

{'TENNESSEE','TN'},
{'TENN','TN'},

{'TEXAS','TX'},
{'TEX','TX'},

{'UTAH','UT'},
{'VERMONT','VT'},
{'VIRGINIA','VA'},

{'WASHINGTON','WA'},
{'WASH','WA'},

{'WEST VIRGINIA','WV'},
{'W.V.','WV'},

{'WISCONSIN','WI'},

{'WYOMING','WY'},
{'WYO','WY'}
], StateRec);

// CleanState
EXPORT CleanState(string inState) := FUNCTION
  stateAbbr := StateDat(abbr = inState);
  stateName := StateDat(name = inState);
	outState := MAP(
	  EXISTS(stateAbbr) => stateAbbr[1].abbr, 
	  EXISTS(stateName) => stateName[1].abbr, 
		''
	);
	RETURN outState;
END;	

// ConditionalJoin
EXPORT ConditionalJoin(UNSIGNED1 tableCount, SET OF DATASET(Layouts.recordIdLayout) tableSet, SET OF BOOLEAN switchSet) := FUNCTION
  emptyTable := DATASET([], Layouts.recordIdLayout);
  allRecords := CHOOSE(tableCount,
	  tableSet[1],
		tableSet[1] + tableSet[2],
		tableSet[1] + tableSet[2] + tableSet[3],
		tableSet[1] + tableSet[2] + tableSet[3] + tableSet[4],
		tableSet[1] + tableSet[2] + tableSet[3] + tableSet[4] + tableSet[5],
		tableSet[1] + tableSet[2] + tableSet[3] + tableSet[4] + tableSet[5] + tableSet[6],
		tableSet[1] + tableSet[2] + tableSet[3] + tableSet[4] + tableSet[5] + tableSet[6] + tableSet[7],
		emptyTable
	);	
	
	out0 := DEDUP(SORT(allRecords, RecordId), RecordId);
	out1 := IF(tableCount >= 1,
	  IF(switchSet[1] = TRUE,
		  JOIN(out0, tableSet[1], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out0
		),
		out0
	);
	out2 := IF(tableCount >= 2,
	  IF(switchSet[2] = TRUE,
		  JOIN(out1, tableSet[2], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out1
		),
		out1
	);
	out3 := IF(tableCount >= 3,
	  IF(switchSet[3] = TRUE,
		  JOIN(out2, tableSet[3], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out2
		),
		out2
	);
	out4 := IF(tableCount >= 4,
	  IF(switchSet[4] = TRUE,
		  JOIN(out3, tableSet[4], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out3
		),
		out3
	);
	out5 := IF(tableCount >= 5,
	  IF(switchSet[5] = TRUE,
		  JOIN(out4, tableSet[5], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out4
		),
		out4
	);
	out6 := IF(tableCount >= 6,
	  IF(switchSet[6] = TRUE,
		  JOIN(out5, tableSet[6], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out5
		),
		out5
	);
	out7 := IF(tableCount >= 7,
	  IF(switchSet[7] = TRUE,
		  JOIN(out6, tableSet[7], LEFT.RecordId = RIGHT.RecordId, TRANSFORM(Layouts.recordIdLayout, SELF := LEFT), LIMIT(0), KEEP(10000)),
			out6
		),
		out6
	);

  out := DEDUP(SORT(out7, RecordId), RecordId);
	
	RETURN out;
END;

END;