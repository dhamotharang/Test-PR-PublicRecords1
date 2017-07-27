/*--SOAP--
<message name="headerFileSearchRequest">
  <part name="recid" type="xsd:unsignedInt"/>
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
  <part name="County" type="xsd:string"/>
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
  <part name="Household" type="xsd:boolean"/> 
  <part name="RID" type="xsd:string"/>
  <part name="IncludeAllDIDRecords" type="xsd:boolean"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
  <part name="NoLookupSearch" type="xsd:boolean"/>
  <part name="DoNotFillBlanks" type="xsd:boolean"/> 
  <part name="Raw" type="xsd:boolean"/> 
  <part name="DIDOnly" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service searches the header file.*/

export Comprehensive_Report_Service := MACRO

#option('workflow', 0);
unsigned4 StartTick := doxie_regression.TimeService.Ticks() : stored('StartTick');

unsigned4 rec_id := 0 : stored('recid');

ta := doxie_regression.CRS_all_records;

PrettyLayout := record, maxlength(1000000)	
	ta;
  unsigned4 Start_Time := 0;
  unsigned4 Elapsed_Time := 0;
  unsigned4 recid := 0;
end;

PrettyLayout addDebug(ta le) :=
TRANSFORM
	self.Start_time := StartTick;
	self.Elapsed_Time := doxie_regression.TimeService.Ticks() - StartTick;
	SELF.recid := rec_id;
	SELF := le;
END;

debug_res := project(ta, addDebug(LEFT));

output(debug_res);

ENDMACRO;