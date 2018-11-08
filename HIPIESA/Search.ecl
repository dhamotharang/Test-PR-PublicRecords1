/*--SOAP--
<message name="SASearch">
	<!-- Search Criteria -->
	<part name="FacilityName"			 	type="xsd:string"/>
  <part name="ProviderKey"			 	type="xsd:string"/>
	<part name="ProviderNPI"	      type="xsd:string"/>
	<part name="ProviderFirstName"	type="xsd:string"/>
	<part name="ProviderLastName"	  type="xsd:string"/>
</message>
*/
/*--INFO-- */

EXPORT Search(string pGcId, string pJobId) := FUNCTION

IMPORT HealthcareFacility;
IMPORT HIPIESa;
IMPORT STD;

searchParams := HIPIESa.Options.SearchParams(pGcID, pJobId);

string InputFacilityName 			:= ''	: STORED('FacilityName');	
string InputProviderKey 			:= ''	: STORED('ProviderKey');
string InputProviderNPI				:= '' : STORED('ProviderNPI');
string InputProviderFirstName	:= '' : STORED('ProviderFirstName');
string InputProviderLastName	:= '' : STORED('ProviderLastName');

FacilityNameIndex 			:= HIPIESa.Keys(searchParams).FacilityNameIndex;
ProviderLastNameIndex 	:= HIPIESa.Keys(searchParams).ProviderLastNameIndex;
ProviderFirstNameIndex 	:= HIPIESa.Keys(searchParams).ProviderFirstNameIndex;
ProviderNpiIndex 				:= HIPIESa.Keys(searchParams).ProviderNpiIndex;
ProviderKeyIndex 				:= HIPIESa.Keys(searchParams).ProviderKeyIndex;
PayloadIndex 						:= HIPIESa.Keys(searchParams).PayloadIndex;


inputFacilityNameClean := HealthcareFacility.clean_facility_name(InputFacilityName);

HIPIESa.Layouts.ProviderSearchLayout tInput() := TRANSFORM
  SELF.seq   := 0;
	SELF.FacilityName 			:= inputFacilityNameClean;
  SELF.ProviderKey				:= STD.Str.ToUpperCase(InputProviderKey);
  SELF.ProviderNPI   			:= STD.Str.ToUpperCase(InputProviderNPI);
  SELF.ProviderFirstName 	:= STD.Str.ToUpperCase(InputProviderFirstName);
  SELF.ProviderLastName  	:= STD.Str.ToUpperCase(InputProviderLastName);
END;

ProviderSearchDs := dataset([tInput()]);

//By FacilityName
dsByFacilityName:= JOIN(ProviderSearchDs(TRIM(FacilityName) <> ''), FacilityNameIndex,
	KEYED(LEFT.FacilityName = RIGHT.companyName[1..LENGTH(TRIM(LEFT.FacilityName))]),
	TRANSFORM(HIPIESa.Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By ProviderLastName
dsByProviderLastName:= JOIN(ProviderSearchDs(TRIM(ProviderLastName) <> ''), ProviderLastNameIndex,
	KEYED(LEFT.ProviderLastName = RIGHT.lastname[1..LENGTH(TRIM(LEFT.ProviderLastName))]),
	TRANSFORM(HIPIESa.Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));
	
//By ProviderFirstName
dsByProviderFirstName := JOIN(ProviderSearchDs(TRIM(ProviderFirstName) <> ''), ProviderFirstNameIndex,
	KEYED(LEFT.ProviderFirstName = RIGHT.Firstname[1..LENGTH(TRIM(LEFT.ProviderFirstName))]),
	TRANSFORM(HIPIESa.Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(10000));

//By ProviderNpi
dsByProviderNpi := JOIN(ProviderSearchDs(TRIM(ProviderNPI) <> ''), ProviderNpiIndex,
	//KEYED(LEFT.ProviderNpi = RIGHT.ProviderNpi[1..LENGTH(TRIM(LEFT.ProviderNpi))]),
	// JNB 2017-09-27: per Senthil, NPI search criteria should be an exact match since it is not variable length
	KEYED(LEFT.ProviderNpi = RIGHT.ProviderNpi),
	TRANSFORM(HIPIESa.Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(1000));

//By ProviderKey
dsByProviderKey := JOIN(ProviderSearchDs(TRIM(ProviderKey) <> ''), ProviderKeyIndex,
	KEYED(LEFT.ProviderKey = RIGHT.ProviderKey[1..LENGTH(TRIM(LEFT.ProviderKey))]),
	TRANSFORM(HIPIESa.Layouts.recordIdLayout,
		SELF	:= RIGHT),
	LIMIT(0), KEEP(1000));

dsEmpty := DATASET([],HIPIESa.Layouts.recordIdLayout);

// Searching by FacilityName will "disable" searching by the Provider Name fields
boolean isFacilityNameSearch := EXISTS( ProviderSearchDs(TRIM(FacilityName) <> '') );	
boolean isLastNameSearch := ~isFacilityNameSearch AND EXISTS( ProviderSearchDs(TRIM(ProviderLastName) <> '') );
boolean isFirstNameSearch := ~isFacilityNameSearch AND EXISTS( ProviderSearchDs(TRIM(ProviderFirstName) <> '') );
boolean isNpiSearch := EXISTS( ProviderSearchDs(TRIM(ProviderNpi) <> '') );
boolean isKeySearch := EXISTS( ProviderSearchDs(TRIM(ProviderKey) <> '') );

join4(ds1, ds2, ds3, ds4) := FUNCTIONMACRO
		j1 := JOIN(ds1, ds2, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		j2 := JOIN(ds3, ds4, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		result := JOIN(j1, j2, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		RETURN result;
ENDMACRO;

join3(ds1, ds2, ds3) := FUNCTIONMACRO
		j1 := JOIN(ds1, ds2, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		result := JOIN(ds3, j1, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		RETURN result;
ENDMACRO;					

join2(ds1, ds2) := FUNCTIONMACRO
		result := JOIN(ds1, ds2, LEFT.recordID = RIGHT.recordID, TRANSFORM(HIPIESa.Layouts.recordIdLayout, SELF := LEFT), LIMIT(1), KEEP(10000));
		RETURN result;
ENDMACRO;		

// JNB 2017-09-22: Maybe this enum approach ends up looking like overkill, but it could come in handy if we need to
//							figure out "what kind of search is this?" in multiple places
// JNB 2017-09-25: As we add more search fields, a bitwise mechanism might be easier to maintain
ProviderSearchTypeEnum := ENUM(UNSIGNED1,
				//no search criteria x1
				None,
				//single field searches x 5
				LastName, FirstName, Npi, Id,	FacilityName,
				//two field searches x 8
				LastName_FirstName, LastName_Npi, LastName_Id, FirstName_Npi, FirstName_Id, Npi_Id, FacilityName_Npi, FacilityName_Id,
				//three field searches x5
				LastName_FirstName_Npi, LastName_FirstName_Id, LastName_Npi_Id, FirstName_Npi_Id, FacilityName_Npi_Id,
				//four field searches x1
				LastName_FirstName_Npi_id
);

// not all combinations are represented here, since facility searches are only valid by FacilityName and/or FacilityName + NPI
	ProviderSearchTypeEnum searchType := MAP(
				isLastNameSearch AND isFirstNameSearch AND isNpiSearch AND isKeySearch	=> ProviderSearchTypeEnum.LastName_FirstName_Npi_id,
				
				isFirstNameSearch AND isNpiSearch AND isKeySearch 			=> ProviderSearchTypeEnum.FirstName_Npi_Id,
				isLastNameSearch AND isNpiSearch AND isKeySearch 				=> ProviderSearchTypeEnum.LastName_Npi_Id,
				isLastNameSearch AND isFirstNameSearch AND isKeySearch 	=> ProviderSearchTypeEnum.LastName_FirstName_Id,
				isLastNameSearch AND isFirstNameSearch AND isNpiSearch	=> ProviderSearchTypeEnum.LastName_FirstName_Npi,
				isFacilityNameSearch AND isNpiSearch AND isKeySearch		=> ProviderSearchTypeEnum.FacilityName_Npi_Id,
				
			  isNpiSearch AND isKeySearch 						=> ProviderSearchTypeEnum.Npi_Id,
				isFirstNameSearch AND isKeySearch 			=> ProviderSearchTypeEnum.FirstName_Id,
				isFirstNameSearch AND isNpiSearch 			=> ProviderSearchTypeEnum.FirstName_Npi,
				isLastNameSearch AND isKeySearch 				=> ProviderSearchTypeEnum.LastName_Id,
				isLastNameSearch AND isNpiSearch 				=> ProviderSearchTypeEnum.LastName_Npi,
				isLastNameSearch AND isFirstNameSearch	=> ProviderSearchTypeEnum.LastName_FirstName,
				isFacilityNameSearch AND isNpiSearch		=> ProviderSearchTypeEnum.FacilityName_Npi,
				isFacilityNameSearch AND isKeySearch		=> ProviderSearchTypeEnum.FacilityName_Id,
				
				isFacilityNameSearch	=> ProviderSearchTypeEnum.FacilityName,
				isKeySearch 					=> ProviderSearchTypeEnum.Id,
				isNpiSearch 					=> ProviderSearchTypeEnum.Npi,
			  isFirstNameSearch  		=> ProviderSearchTypeEnum.FirstName,
				isLastNameSearch 		 	=> ProviderSearchTypeEnum.LastName,
				ProviderSearchTypeEnum.None
			);

	combinedIndexDs := CASE( searchType,
						ProviderSearchTypeEnum.LastName_FirstName_Npi_id => join4( dsByProviderLastName, dsByProviderFirstName, dsByProviderNpi, dsByProviderKey),
						
						ProviderSearchTypeEnum.FirstName_Npi_Id 			=> join3( dsByProviderFirstName, dsByProviderNpi, dsByProviderKey),
						ProviderSearchTypeEnum.LastName_Npi_Id 				=> join3( dsByProviderLastName, dsByProviderNpi, dsByProviderKey),
						ProviderSearchTypeEnum.LastName_FirstName_Id 	=> join3( dsByProviderLastName, dsByProviderFirstName, dsByProviderKey),
						ProviderSearchTypeEnum.LastName_FirstName_Npi	=> join3( dsByProviderLastName, dsByProviderFirstName, dsByProviderNpi),
						ProviderSearchTypeEnum.FacilityName_Npi_Id		=> join3( dsByFacilityName, dsByProviderNpi, dsByProviderKey),

						ProviderSearchTypeEnum.Npi_Id 						=> join2( dsByProviderNpi, dsByProviderKey),
						ProviderSearchTypeEnum.FirstName_Id 			=> join2( dsByProviderFirstName, dsByProviderKey),
						ProviderSearchTypeEnum.FirstName_Npi 			=> join2( dsByProviderFirstName, dsByProviderNpi),
						ProviderSearchTypeEnum.LastName_Id 				=> join2( dsByProviderLastName, dsByProviderKey),
						ProviderSearchTypeEnum.LastName_Npi 			=> join2( dsByProviderLastName, dsByProviderNpi),
						ProviderSearchTypeEnum.LastName_FirstName	=> join2( dsByProviderLastName, dsByProviderFirstName),						
						ProviderSearchTypeEnum.FacilityName_Npi 	=> join2( dsByFacilityName, dsByProviderNpi),
						ProviderSearchTypeEnum.FacilityName_Id 		=> join2( dsByFacilityName, dsByProviderKey),
							
						ProviderSearchTypeEnum.FacilityName	=> dsByFacilityName,							
						ProviderSearchTypeEnum.Id 					=> dsByProviderKey,
						ProviderSearchTypeEnum.Npi 					=> dsByProviderNpi,
						ProviderSearchTypeEnum.FirstName		=> dsByProviderFirstName,
						ProviderSearchTypeEnum.LastName 		=> dsByProviderLastName,
							
						ProviderSearchTypeEnum.None => dsEmpty
						);
						
	distinctRecordIds := DEDUP(SORT(combinedIndexDs,recordID),recordID);

	resultDs := JOIN(distinctRecordIds, PayloadIndex,
		KEYED(LEFT.recordId = RIGHT.recordID),
		TRANSFORM(HIPIESa.Layouts.PayloadLayout,
			SELF	:= RIGHT),
		LIMIT(0), KEEP(100));

	resultDsDedup := DEDUP(SORT(resultDs,providerkey),providerkey);

	results := resultDsDedup;
	RETURN OUTPUT(results, NAMED('Results'));	

END;