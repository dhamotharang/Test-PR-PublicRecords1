/*--SOAP--
<message name="Crim_Offender_SearchRequest">
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
  <part name="FilingJurisdiction"	type='xsd:string'/>	
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="isANeighbor" type="xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="Raw" type="xsd:boolean"/> 
  <part name="ScoreThreshold" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
  <part name="noDeepDive" type="xsd:boolean"/>
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/
import Corrections,doxie,ut,codes,address,WSInput;

export DOC_Search := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
WSInput.MAC_DOC_Search()	

#STORED('LookupType','CRIM');
#stored('SelectIndividually',true);
#stored('IncludeCriminalRecords',true);
#STORED('ScoreThreshold',20);


doxie.MAC_Header_Field_Declare()
	
string25	doc_val := '' : stored('DOCNumber');
string60	ofk_val := '' : stored('OffenderKey');

preFetched := doxie.DOC_Search_People_Records;

// filter by jurisdiction if provided (orig_state needs to be converted to 2-char state abbrev)
preFetched_jur := if(FilingJurisdiction_value <> '', 
										 preFetched(Address.Map_State_Name_To_Abbrev(StringLib.StringToUpperCase(orig_state)) = FilingJurisdiction_value),
										 preFetched);

addphone :=
RECORD
	preFetched_jur;
	STRING10 fake_phone := phone_value;
END;
Fetched := TABLE(preFetched_jur,addphone);

doxie.MAC_Header_Result_Rank(fname,mname,lname,
                             ssn,dob,did,
                             predir,prim_range,prim_name,addr_suffix,postdir,sec_range,
                             v_city_name,county_name,st,zip5,
                             fake_phone,true)

/*----------------[ Pretty Layout ]----------------------*/

prettylayout := record
	outf1.penalt;
	outf1.lname;		
	outf1.fname;	
	outf1.mname;
	outf1.name_suffix;
	outf1.ssn;
	outf1.dob;
	outf1.place_of_birth;
	outf1.prim_range;
	outf1.predir;
	outf1.prim_name;
	outf1.addr_suffix;
	outf1.postdir;
	outf1.unit_desig;
	outf1.sec_range;
	string30 city;
	outf1.st;
	outf1.zip5;
	outf1.zip4;
	outf1.county_name;
	outf1.did;
	outf1.score;
	outf1.process_date;
	string8  case_filing_date;
	outf1.offender_key;
	outf1.case_type;
	outf1.case_num;
	outf1.doc_num;
	outf1.dle_num;
	outf1.source_file;
	string25 State_of_Origin;
	outf1.County_of_Origin;	
	outf1.DataSource;
end;

prettylayout into_pretty(outf1 L) := transform
	self.state_of_origin := L.orig_state;
	self.case_filing_date := l.case_date;
	self.city := L.v_city_name;
	self := L;
end;

outf2 := project(outf1,into_pretty(LEFT));


							 
outfile := sort(outf2,penalt,lname,fname,offender_key);

doxie.MAC_Marshall_Results(outfile,outf);

/*------------------[ Output ]------------------------*/

MAP( raw_records => output(preFetched),
	output(outf, NAMED('Results'))); 
	
endmacro;