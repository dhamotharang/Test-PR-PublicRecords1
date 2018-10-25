/*--SOAP--
<message name="SASearch">
	<!-- Search Criteria -->
	<part name="FacilityName"			 	type="xsd:string"/>
  <part name="ProviderKey"			 	type="xsd:string"/>
	<part name="ProviderNPI"	      type="xsd:string"/>
	<part name="ProviderFirstName"	type="xsd:string"/>
	<part name="ProviderLastName"	  type="xsd:string"/>
	<part name="StreetAddress"	    type="xsd:string"/>
	<part name="City"	    					type="xsd:string"/>
	<part name="State"	    				type="xsd:string"/>
	<part name="Zip"	    					type="xsd:string"/>
</message>
*/
/*--INFO-- */

EXPORT SearchV2(string GcId, string JobId) := FUNCTION
IMPORT STD;
IMPORT HealthcareFacility;
IMPORT Address;

string InputFacilityName 			:= ''	: STORED('FacilityName');	
string InputProviderKey 			:= ''	: STORED('ProviderKey');
string InputProviderNPI				:= '' : STORED('ProviderNPI');
string InputProviderFirstName	:= '' : STORED('ProviderFirstName');
string InputProviderLastName	:= '' : STORED('ProviderLastName');

string InputStreetAddress 		:= ''	: STORED('StreetAddress');
string InputCity 							:= ''	: STORED('City');
string InputState 						:= ''	: STORED('State');
string InputZip 							:= ''	: STORED('Zip');

Layouts := HIPIESA.SearchV2Objects.Layouts;
Indexes := HIPIESA.SearchV2Objects.Indexes(GcId + '::' + JobId);

FacilityNameIndex 			:= Indexes.FacilityNameIndex;
ProviderLastNameIndex 	:= Indexes.ProviderLastNameIndex;
ProviderFirstNameIndex 	:= Indexes.ProviderFirstNameIndex;
ProviderNpiIndex 				:= Indexes.ProviderNpiIndex;
ProviderKeyIndex 				:= Indexes.ProviderKeyIndex;

PrimaryRangeIndex 			:= Indexes.PrimaryRangeIndex;
PrimaryNameIndex 				:= Indexes.PrimaryNameIndex;
SecondaryRangeIndex 		:= Indexes.SecondaryRangeIndex;
StateIndex 				      := Indexes.StateIndex;
CityStateIndex 				  := Indexes.CityStateIndex;

PayloadIndex 						:= Indexes.PayloadIndex;

inputFacilityNameClean := HealthcareFacility.clean_facility_name(TRIM(InputFacilityName));
Layouts.ProviderSearchLayout tInput() := TRANSFORM
  SELF.seq   							:= 0;
	SELF.FacilityName 			:= inputFacilityNameClean;
  SELF.ProviderKey				:= STD.Str.ToUpperCase(TRIM(InputProviderKey));
  SELF.ProviderNPI   			:= STD.Str.ToUpperCase(TRIM(InputProviderNPI));
  SELF.ProviderFirstName 	:= STD.Str.ToUpperCase(TRIM(InputProviderFirstName));
  SELF.ProviderLastName  	:= STD.Str.ToUpperCase(TRIM(InputProviderLastName));

  SELF.InputStreetAddress := STD.Str.ToUpperCase(STD.Str.CleanSpaces(InputStreetAddress));
  SELF.InputCity  				:= STD.Str.ToUpperCase(STD.Str.CleanSpaces(InputCity));
  SELF.InputState  				:= STD.Str.ToUpperCase(STD.Str.CleanSpaces(InputState));
  SELF.InputZip  					:= TRIM(InputZip);
	
	InputCityStateZip       := STD.Str.CleanSpaces(SELF.InputCity + ' ' + SELF.InputState + ' ' + SELF.InputZip);
	IsAddressSearch					:= IF(InputCityStateZip <> '', TRUE, FALSE);
	
	EmptyAddress						:= DATASET([{'', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''}], Address.Layout_Clean182_fips)[1];
	CleanedAddress 	      	:= IF(IsAddressSearch, Address.CleanAddressFieldsFips(Address.CleanAddress182(SELF.InputStreetAddress, InputCityStateZip)).addressrecord, EmptyAddress);
	State 									:= TRIM(CleanedAddress.st);
	
	SELF.PrimaryRange     	:= IF(IsAddressSearch = TRUE, TRIM(CleanedAddress.prim_range), '');
  SELF.PrimaryName      	:= IF(IsAddressSearch = TRUE, TRIM(CleanedAddress.prim_name), '');
  SELF.SecondaryRange   	:= IF(IsAddressSearch = TRUE, TRIM(CleanedAddress.sec_range), '');
  SELF.City             	:= IF(IsAddressSearch = TRUE, TRIM(CleanedAddress.v_city_name), '');
  SELF.State            	:= IF(IsAddressSearch = TRUE, IF(State <> '', State, HIPIESA.SearchV2Objects.CleanState(SELF.InputState)), '');
	SELF.Zip                := IF(IsAddressSearch = TRUE, TRIM(CleanedAddress.zip), '');
END;
ProviderSearchDs := DATASET([tInput()]);

dsEmpty := DATASET([], Layouts.recordIdLayout);

//By FacilityName
dsByFacilityName:= JOIN(ProviderSearchDs(FacilityName <> ''), FacilityNameIndex,
	KEYED(LEFT.FacilityName = RIGHT.companyname[1..LENGTH(LEFT.FacilityName)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By ProviderLastName
dsByProviderLastName:= JOIN(ProviderSearchDs(ProviderLastName <> ''), ProviderLastNameIndex,
	KEYED(LEFT.ProviderLastName = RIGHT.lastname[1..LENGTH(LEFT.ProviderLastName)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));
	
//By ProviderFirstName
dsByProviderFirstName := JOIN(ProviderSearchDs(ProviderFirstName <> ''), ProviderFirstNameIndex,
	KEYED(LEFT.ProviderFirstName = RIGHT.firstname[1..LENGTH(LEFT.ProviderFirstName)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));
	
//By ProviderNpi
dsByProviderNpi := JOIN(ProviderSearchDs(ProviderNPI <> ''), ProviderNpiIndex,
	KEYED(LEFT.ProviderNpi = RIGHT.providernpi),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(1000));

//By ProviderKey
dsByProviderKey := JOIN(ProviderSearchDs(ProviderKey <> ''), ProviderKeyIndex,
	KEYED(LEFT.ProviderKey = RIGHT.providerkey[1..LENGTH(LEFT.ProviderKey)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(1000));
	

//By PrimaryRange
dsByPrimaryRange := JOIN(ProviderSearchDs(PrimaryRange <> ''), PrimaryRangeIndex,
	KEYED(LEFT.PrimaryRange = RIGHT.primaryrange[1..LENGTH(LEFT.PrimaryRange)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By PrimaryName
dsByPrimaryName := JOIN(ProviderSearchDs(PrimaryName <> ''), PrimaryNameIndex,
	KEYED(LEFT.PrimaryName = RIGHT.streetname[1..LENGTH(LEFT.PrimaryName)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By SecondaryRange
dsBySecondaryRange := JOIN(ProviderSearchDs(SecondaryRange <> ''), SecondaryRangeIndex,
	KEYED(LEFT.SecondaryRange = RIGHT.secondaryrange[1..LENGTH(LEFT.SecondaryRange)]),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By State
dsByState := JOIN(ProviderSearchDs(State <> ''), StateIndex,
	KEYED(LEFT.State = RIGHT.state),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(100000));

//By CityState
dsByCityState := JOIN(ProviderSearchDs(City <>'' AND State <> ''), CityStateIndex,
	KEYED(LEFT.City = RIGHT.city[1..LENGTH(LEFT.City)] AND LEFT.State = RIGHT.state),
	TRANSFORM(Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//Combine address search result sets
boolean hasPrimaryRange   := EXISTS(ProviderSearchDs(PrimaryRange <> ''));
boolean hasPrimaryName    := EXISTS(ProviderSearchDs(PrimaryName <> ''));
boolean hasSecondaryRange := EXISTS(ProviderSearchDs(SecondaryRange <> ''));
boolean hasState          := EXISTS(ProviderSearchDs(State <> ''));
boolean hasCityState      := EXISTS(ProviderSearchDs(City <> '' AND State <> ''));

unsigned4 countPrimaryRange    := IF(hasPrimaryRange = FALSE, 0, COUNT(dsByPrimaryRange));
unsigned4 countPrimaryName     := IF(hasPrimaryName = FALSE, 0, COUNT(dsByPrimaryName));
unsigned4 countSecondaryRange  := IF(hasSecondaryRange = FALSE, 0, COUNT(dsBySecondaryRange));
unsigned4 countState           := IF(hasState = FALSE, 0, COUNT(dsByState));
unsigned4 countCityState       := IF(hasCityState = FALSE, 0, COUNT(dsByCityState));

boolean usePrimaryRange 	:= IF(countPrimaryRange > 0, TRUE, FALSE);
boolean usePrimaryName 		:= IF(countPrimaryName > 0, TRUE, FALSE);
boolean useSecondaryRange := IF(countSecondaryRange > 0, TRUE, FALSE);
boolean useState 			    := IF(countState > 0, TRUE, FALSE);
boolean useCityState 			:= IF(countCityState > 0, TRUE, FALSE);

addressTables 	:= [dsByState, dsByCityState, dsByPrimaryRange, dsByPrimaryName, dsBySecondaryRange];
addressSwitches := [useState, useCityState, usePrimaryRange, usePrimaryName, useSecondaryRange];
dsByAddress := MAP(
	useState = FALSE => dsEmpty,
  HIPIESA.SearchV2Objects.ConditionalJoin(5, addressTables, addressSwitches)
);

boolean isAddressSearch		:= useState;

// Searching by FacilityName will "disable" searching by the provider name fields
boolean isFacilityNameSearch  := EXISTS(ProviderSearchDs(FacilityName <> ''));	
boolean isLastNameSearch 			:= ~isFacilityNameSearch AND 
                                 EXISTS(ProviderSearchDs(ProviderLastName <> ''));
boolean isFirstNameSearch 		:= ~isFacilityNameSearch AND 
                                 EXISTS(ProviderSearchDs(ProviderFirstName <> ''));
boolean isNpiSearch 					:= EXISTS(ProviderSearchDs(ProviderNpi <> ''));
boolean isKeySearch 					:= EXISTS(ProviderSearchDs(ProviderKey <> ''));

searchTables   := [dsByAddress, dsByFacilityName, dsByProviderLastName, dsByProviderFirstName, dsByProviderNpi, dsByProviderKey];
searchSwitches := [isAddressSearch, isFacilityNameSearch, isLastNameSearch, isFirstNameSearch, isNpiSearch, isKeySearch];
recordIds := HIPIESA.SearchV2Objects.ConditionalJoin(6, searchTables, searchSwitches);

resultDs := JOIN(recordIds, PayloadIndex,
	KEYED(LEFT.RecordId = RIGHT.RecordId),
	TRANSFORM(Layouts.PayloadLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(100));

RETURN OUTPUT(resultDs, NAMED('Results'));

END;