/*--SOAP--
<message name="ReportService">

  <part name="DID" 					type="xsd:string"/>
  <part name="StateDeathID" type="xsd:string"/>
	<part name="SSNMask" 			type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:byte" />
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="IncludeBlankDOD" type="xsd:boolean"/>
    
</message>
*/
/*--INFO-- This service returns one death record by ID or all for one DID*/


export ReportService() := macro
boolean IncludeBlankDOD := false :stored('IncludeBlankDOD');
output(deathv2_services.ReportRecords(IncludeBlankDOD or (integer)dod8 > 0), named('Results'));

endmacro;
 // ReportService();




