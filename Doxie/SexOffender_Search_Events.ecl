/*--SOAP--
<message name="SexOffender_Search_Events" wuTimeout="240000">
 <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="OtherCity1" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="OtherState1" type="xsd:string"/>
  <part name="OtherState2" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Raw" type="xsd:boolean"/>
  <part name="SeisintAdlService" type="xsd:string"/>
  <part name="isANeighbor" type="xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="SeisintPrimaryKey" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service pulls from the Sex Offenders Offenses file.*/

export SexOffender_Search_Events := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#STORED('LookupType','SEX');

WSInput.MAC_SexOffender_Search_Events();

persons := doxie.sexoffender_search_people_records (, FALSE);
events := doxie.sexoffender_search_events_records (persons, , FALSE);

out_recs := dedup(events);

output(out_recs, named('Results'));

endmacro;