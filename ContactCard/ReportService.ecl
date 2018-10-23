/*--SOAP--
<message name="ContactCard.ReportService">

	<part name="PhonesPerPerson" type="xsd:byte"/> 
	<part name="AddressesPerPerson" type="xsd:byte"/> 
	<part name="IncludeNonSubjectPhonelessAddresses" type="xsd:boolean"/>
	<part name="IncludePhonesPlus" type="xsd:boolean"/>
	<part name="IncludePhonesPlusForRNA" type="xsd:boolean"/>
	<part name="IncludePhonesFeedback" type="xsd:boolean"/>
	
	<part name="TargetRadius" 			type="xsd:string"/>
  <part name="MaxDaysBefore" 			type="xsd:integer"/>
  <part name="MaxDaysAfter" 			type="xsd:integer"/>

	<part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="County" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="StateCityZip" type="xsd:string"/>
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
	<part name="ApplicationType" type="xsd:string"/>

  <part name="MaxRelatives" type="xsd:unsignedInt"/>
  <part name="RelativeDepth" type="xsd:byte"/> 
	
  <part name="KeepOldSsns" type="xsd:boolean"/>
  <part name="UsingKeepSsns" type="xsd:boolean"/>	
	
  <part name="RecordByDate" type="xsd:string"/>
	<part name="ProbationOverride" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>


</message>
*/
/*--INFO--*/


export ReportService := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#constant('IsCRS', true);

con := ContactCard.constants;
doxie.MAC_Header_Field_Declare()
#stored('DialContactPrecision',con.default_DialContactPrecision);
#stored('MaxRelatives',con.max_relatives);
#stored('RelativeDepth',con.default_RelativeDepth);
#stored('DataRestrictionMask','0000000000');
#constant('useOnlyBestDID',true);
#stored('NeighborsPerAddress',con.Neighbors_Per_Address);

//in OSS: this option allows to avoid 
// "Error: INTERNAL: Attempt to read spill file '~spill::B6151' before it is written..."
#option ('allowThroughSpill', false);

output(contactcard.ReportRecords(doxie.get_dids()), named('Results'));

ENDMACRO;