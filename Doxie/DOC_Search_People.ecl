﻿/*--SOAP--
<message name="Crim_Offender_People_SearchRequest" wuTimeout="240000">
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
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DOCNumber" type="xsd:string" />
  <part name="DOCState" type="xsd:string" />
  <part name="OffenderKey" type="xsd:string" />
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="isANeighbor" type = "xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="Raw" type="xsd:boolean"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/

export DOC_Search_People := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
WSInput.MAC_DOC_Search_People()	

#STORED('LookupType','CRIM');
#stored('SelectIndividually',true);
#stored('IncludeCriminalRecords',true);

F := doxie.DOC_Search_People_Records;

output(F,named('result_records'));

endmacro;