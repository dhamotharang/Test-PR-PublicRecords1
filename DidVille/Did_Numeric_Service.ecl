/*--SOAP--
<message name="Did_Numeric_Service">
  <part name="SSN4" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="Yob" type="xsd:integer" required="1"/>
  <part name="Zip" type="xsd:string"  required="1"/>
  <part name="FirstInitial" type="xsd:integer"/>
  <part name="LastInitial" type="xsd:integer"/>
  <part name="prim_range" type="xsd:string"/>
	<part name="AppendThreshold" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="AllowMultipleResults" type="xsd:boolean"/>
	<part name="MaxResults" type="xsd:unsignedInt"/>
</message>
*/

export Did_Numeric_Service() := 
MACRO

output(Didville.did_numeric_records,NAMED(doxie.strResultsName));

ENDMACRO;