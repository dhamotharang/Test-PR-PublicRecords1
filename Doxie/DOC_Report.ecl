/*--SOAP--
<message name="Crim_Offender_SearchRequest">
  <part name="FirstName" type="xsd:string"/>
  <part name="LastName" type="xsd:string"/>
  <part name="MiddleName" type="xsd:string"/>
  <part name="DID" type="xsd:string" required="1"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DOCNumber" type="xsd:string" />
  <part name="DOCState" type="xsd:string" />
  <part name="OffenderKey" type="xsd:string" />
  <part name="SeisintAdlService" type="xsd:string"/> 
  <part name="isANeighbor" type="xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
  <part name="Raw" type="xsd:boolean"/> 
  <part name="SSNMask" type="xsd:string"/>
  <part name="DLMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/

import Corrections,doxie,ut,WSInput;

export DOC_Report := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#STORED('LookupType','CRIM');
#stored('ReportReq',true);
#stored('ReturnOffenses',true);
#stored('ReturnParoles',true);
#stored('ReturnPrisonTerms',true);
#stored('ReturnActivities',true);
#stored('SelectIndividually',true);
#stored('IncludeCriminalRecords',true);

WSInput.MAC_DOC_Report()	
doxie.MAC_Header_Field_Declare()
	
string25	doc_val := '' : stored('DOCNumber');
string60	ofk_val := '' : stored('OffenderKey');


Fetched := doxie.DOC_Search_Records;

/*------------[ Report Layout ]------------------*/

doxie.Layout_Parole into_parole(corrections.Layout_CrimPunishment L) := transform
	self := l;
end;

doxie.layout_PrisonTerm into_pterm(corrections.Layout_CrimPunishment L) := transform
	self := l;
end;

doxie.Layout_SubActivity into_acts(corrections.Layout_Activity L) := transform
	self.activity_date := L.event_date;
	self.activity_description := L.event_desc_1 + ' ' + L.event_desc_2;
end;

doxie.layout_sub_court_offense into_c_off(Corrections.layout_CourtOffenses L) := transform
	self := l;
end;

doxie.layout_docsearch into_report(Fetched L) := transform
	self.activities := project(L.activities,into_acts(LEFT));
	self.paroles := project(L.paroles, into_parole(LEFT));
	self.prisonterms := project(L.prisonterms,into_pterm(LEFT));
	self.court_offenses := project(l.court_offenses,into_c_off(LEFT));
	self := L;
end;

outf := project(fetched,into_report(LEFT));

map(raw_records => output(Fetched),
	output(outf,named('Results')));

endmacro;