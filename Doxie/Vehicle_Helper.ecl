/*--SOAP--
<message name="VehicleHelperRequest">
 <part name="SSN" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="RelativeFirstName1" type="xsd:string"/>
  <part name="RelativeFirstName2" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="OtherLastName1" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="CompanyName" type="xsd:string"/>
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
  <part name="DriversLicense" type="xsd:string"/>
  <part name="VIN" type="xsd:string"/>
  <part name="Tag" type="xsd:string"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="Raw" type="xsd:boolean"/>
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="IsANeighbor" type="xsd:boolean"/>
  <part name="VID" type="xsd:string"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service searches the vehicle file.*/

export Vehicle_Helper := MACRO
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
doxie.MAC_Header_Field_Declare()
qstring25 vid_value := '' : STORED('VID');

MAP( ~dppa_ok 			=> 	FAIL(2, doxie.ErrorCodes(2)),
						output(TOPN(doxie.Vehicle_Search_Local,MaxResultsThisTime_val,seq_no,history_name,history)))

ENDMACRO;