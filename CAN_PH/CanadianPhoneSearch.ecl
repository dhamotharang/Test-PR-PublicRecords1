/*--SOAP--
<message name="CanadianPhoneSearch">
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="PhoneticMatch" type="xsd:boolean"/>
	
	<separator />
	<part name="CompanyName" type="xsd:string"/>

  <separator />
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string" description=" Province name abbreviated: 2-char" />
  <part name="PostalCode" type="xsd:string" description=" 6-char postal code" />
  <part name="StateCityZip"  type="xsd:string" description=" city name, province code, postal code" /> 
  <part name="Phone" type="xsd:string"/>

  <separator />
  <part name="MaxResults" type="xsd:unsignedInt" default="2000" />
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt" default="0" />	
  <part name="ScoreThreshold" type="xsd:unsignedInt" default="10" />
</message>
*/

/*--INFO-- This service searches canadian phones */


EXPORT CanadianPhoneSearch := MACRO

#stored('PenaltThreshold',20);

#constant ('AddressOrigin', Address.Components.Country.CA);  // set Canada address mode
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
f_ready := CAN_PH.CanadianPhoneSearch_records;

unsigned8	MaxResults_val					:= 2000		: stored('MaxResults');
unsigned8	MaxResultsThisTime_val	:= 2000		: stored('MaxResultsThisTime');
unsigned8	SkipRecords_val					:= 0			: stored('SkipRecords');

doxie.MAC_Marshall_Results(f_ready, f_out);
IF(EXISTS(f_out), doxie.compliance.logSoldToTransaction(mod_access));
OUTPUT (f_out, NAMED ('Results'));

ENDMACRO;
