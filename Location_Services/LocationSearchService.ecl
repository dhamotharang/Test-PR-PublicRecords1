/*--SOAP--
<message name="LocationSearchService">
  <part name="apn"  type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>  
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>  
	<part name="IncludeHRI" type="xsd:boolean"/>
  <part name="MaxHriPer" type="xsd:unsignedInt"/> 
  <part name="ProbationOverride" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service searches the Header for address variations and dedups/rolls up the results according 
           Location rules. Eventually, this will search Business Header data too.
					 <p>The search can be done by either address or by 'apn'; If both provided address is ignored.
					 */

export LocationSearchService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);

doxie.MAC_Header_Field_Declare();

STRING45 apn := '' : STORED('apn');

ta1 := IF (apn = '', 
           Location_Services.Location_presentation,
           Location_Services.Location_apn_presentation (apn));

doxie.MAC_Marshall_Results(ta1,ta2);

output(ta2, NAMED('Results'));

ENDMACRO;