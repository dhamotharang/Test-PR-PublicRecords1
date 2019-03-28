/*--SOAP--
<message name="DLSearchRequest">
  <part name="DriversLicense" type="xsd:string"/>
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
  <part name="Race" type="xsd:string"/>
  <part name="Gender" type="xsd:string"/>
  <part name="DID" type="xsd:string"/>
  <part name="Household" type="xsd:boolean"/> 
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="NeighborData" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="IsANeighbor" type="xsd:boolean"/>
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="Randomize" type="xsd:boolean"/>
  <part name="LnBranded" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service pulls from the DL file.*/
  
export dl_search := MACRO
#CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
#STORED('ScoreThreshold',10);

boolean random_value := false : STORED('Randomize');
doxie.MAC_Header_Field_Declare()

preFetched := doxie.dl_Search_Records;

addphone :=
RECORD
	preFetched;
	STRING10 fake_phone := phone_value;
END;
Fetched := TABLE(preFetched,addphone);

doxie.MAC_Header_Result_Rank(fname,mname,lname,
                             ssn,dob,did,
                             predir,prim_range,prim_name,suffix,postdir,sec_range,
                             p_city_name,county_name,st,zip5,
                             fake_phone,(~random_value AND dl_value=''))
							 
outfile := sort(outf1,penalt,history,lname,fname,dl_number);

doxie.MAC_Marshall_Results(outfile,outf);

MAP( ~dppa_ok 			=> 	FAIL(2, doxie.ErrorCodes(2)),
						output(outf, NAMED('results')))


ENDMACRO;