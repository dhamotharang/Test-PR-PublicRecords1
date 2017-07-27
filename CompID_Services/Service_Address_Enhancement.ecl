/*
2009-04-13 Magesh Thulasi
*/
/*--SOAP--
<message name="Service_Address_Enhancement">
  <part name="Seq" type="xsd:unsignedInt"/>
  <part name="SSN" type="xsd:string"/>
  <part name="Name" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="NameSuffix" type="xsd:string"/>
  <part name="Addr1" type="xsd:string"/>
  <part name="Addr2" type="xsd:string"/>
  <part name="PrimRange" type="xsd:string"/>
  <part name="PrimName" type="xsd:string"/>
  <part name="SecRange" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="Gender" type="xsd:string"/>
  <part name="DLState" type="xsd:string"/>
  <part name="DLNumber" type="xsd:string"/>
  <part name="DateOfBirth" type="xsd:string"/>
  <part name="MinScore" type="xsd:unsignedInt"/>	
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- 
Address_Enhancement_Service
*/
/*--RESULT-- xslt.html */
import address, ut, header_slimsort, doxie, patriot, watchdog, header;

export Service_Address_Enhancement := MACRO

unsigned4 seq_value := 0 			 : stored('Seq');
string11 ssn_value := ''       : stored('ssn');
string8 dob_value := ''        : stored('DateOfBirth');
string120 addr1_val := ''      : stored('Addr1');
string120 addr2_val := ''      : stored('Addr2');
string30 fname_val := ''       : stored('FirstName');
string30 lname_val := ''       : stored('LastName');
string30 mname_val := ''       : stored('MiddleName');
string5 suffix_val := ''       : stored('NameSuffix');
string2 state_val := ''        : stored('State');
string25 city_val := ''        : stored('City');
string6 zip_value := ''        : stored('Zip');
string1  gender_val := ''      : stored('Gender');
STRING2	 DLState_val:= ''			 : stored('DLState');
STRING25 DLNumber_val := ''		 : stored('DLNumber');
string10 prange_value := ''    : stored('primrange');
string10 sec_range_value := '' : stored('secrange');
string30 pname_value := ''     : stored('primname');
string120 name_value := ''     : stored('Name');
unsigned  min_score := 75	     : stored('MinScore');
unsigned4 maxrecordstoreturn   := 0 : stored('MaxRecordsToReturn');

#STORED('AllowNickNames', true);
#STORED('AllowPhoneticMatch', true);
#STORED('AllowAll',true);

Result := CompID_Services.Search_TNT.getGenResult(seq_value, ssn_value,  dob_value,  addr1_val,  addr2_val,  fname_val,
																													lname_val, mname_val,  suffix_val,  state_val,  city_val,  zip_value,
																													gender_val, DLState_val,  DLNumber_val,  prange_value,  sec_range_value,
																													pname_value, name_value, min_score, maxrecordstoreturn, true); 


output(Result, named('CompId_Address_Enhancement'));

ENDMACRO;
