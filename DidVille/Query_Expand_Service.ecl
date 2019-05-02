/*--SOAP--
<message name="QueryExpansionService">
  <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
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
  <part name="Phone" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="CandidateLimit" type="xsd:unsignedInt"/>
  <part name="MaxNames" type="xsd:byte"/>
  <part name="MaxAddresses" type="xsd:byte"/>
  <part name="MaxRecordsPerCandidate" type="xsd:byte"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Raw" type="xsd:boolean"/> 
 </message>
*/
/*--INFO-- This service returns alternative query patterns for an incoming query. They are ranked in order of likeliness for each individual.
           The individuals are delineated using the DID field*/

export Query_Expand_Service := macro
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
doxie.MAC_Header_Field_Declare()

d := didville.Expanded_Query;

  #uniquename(new_rec)
  %new_rec% := record
  unsigned2 output_seq_no;
  d;
  end;
  #uniquename(trans)
  %new_rec% %trans%(d le,unsigned8 cnt) := transform
  self.output_seq_no := cnt;
  self := le;
  end;
  #uniquename(numbered)
  %numbered% := choosen(project(d,%trans%(left,counter)),MaxResults_val);
  outfile := choosen(%numbered%(output_seq_no>SkipRecords_val),MaxResultsThisTime_val);

output(outfile, named(doxie.strResultsName))

  endmacro;