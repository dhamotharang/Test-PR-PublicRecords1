/*--SOAP--
<message name="DeathV2_Services.TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />
	<part name="GLBPurpose" type="xsd:byte" />
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="IncludeBlankDOD" type="xsd:boolean"/>

 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Text Search.
*/
import death_master,Text_Search,ut,doxie;
export TextSearchService := MACRO

// boolean-specific parameters
STRING srchString := '' : STORED('Search');


// general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
unsigned8 MaxDocs := MaxResults_val;
boolean IncludeBlankDOD := false : stored('IncludeBlankDOD');

// boolean search
con := death_master.Constants('');
STRING stem		:= con.stem;
STRING srcType:= con.srcType_ssa;
STRING qual		:= con.qual;
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);
s := Text_Search.Text_Search_Module(info, srchString,false,,,MaxDocs);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

IF(~noErr, ut.outputMessage(errCode, errMsg));

sdid_key := Death_Master.Key_Boolean_SSA_ID;

wkeys := join(ans, sdid_key,
							keyed(left.docref.src = right.src) and
							keyed(left.docref.doc = right.doc),
							transform(deathv2_services.layouts.death_id, self := right),
							limit(ut.limits.default, skip));

sdids := dedup(wkeys, state_death_id, all);
rpen := 
// deathv2_services.fn_DedupSearch(
deathv2_services.raw.get_report.from_death_ids(sdids,ssn_mask_value);

rpen_sorted := sort(rpen(includeBlankDOD or (integer)dod8 > 0), -filedate, -dod8, dob8, record);

// paging
doxie.MAC_Marshall_Results_NoCount(rpen_sorted, paged_results,, outputCount);

// outputs
if(noErr, outputCount );
IF(noErr, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;
// TextSearchService();