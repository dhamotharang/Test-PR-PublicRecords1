/*--SOAP--
<message name="Service_Address">
  <part name="Seq" type="xsd:unsignedInt"/>
  <part name="PrimRange" type="xsd:string"/>
  <part name="PrimName" type="xsd:string"/>
  <part name="UnitNumber" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Zip4" type="xsd:string"/>
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service returns person info based on Address.*/
/*--RESULT-- xslt.html */
IMPORT Address, AutoHeaderI, AutoStandardI, Doxie_Raw, WatchDog;

EXPORT Service_Address := MACRO
	UNSIGNED6 Seq_Value := 0 				: STORED('Seq');
	STRING10 	StreetNumber := ''    : STORED('PrimRange');
	STRING8 	UnitNumber := '' 			: STORED('UnitNumber');
	STRING30 	StreetName := ''      : STORED('PrimName');
	STRING25 	City := ''        		: STORED('City');
	STRING2 	State := ''        		: STORED('State');
	STRING6 	Zip := ''        			: STORED('Zip');
	STRING6 	Zip4 := ''        		: STORED('Zip4');
	UNSIGNED4 MaxRecordsToReturn   	:= 10 : stored('MaxRecordsToReturn');

	#STORED ('AllowAll',true);

	Result := CompID_Services.Search_Address.getResultForAddress (Seq_Value, StreetNumber, UnitNumber, StreetName,
																																City, State, Zip, Zip4, MaxRecordsToReturn);

	OUTPUT(Result, named('CompId_ADD'));
ENDMACRO;
