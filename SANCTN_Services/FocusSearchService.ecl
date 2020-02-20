/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="ApplicationType" type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- SANCTN Text Search. */

EXPORT FocusSearchService := MACRO

import doxie, Text_Search, SANCTN_Services, ut;

// boolean-specific parameters
string srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);
										 
// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');


// boolean search
STRING stem		:= SANCTN_Services.Constants.stem;
STRING srcType:= SANCTN_Services.Constants.srcType;
STRING qual		:= SANCTN_Services.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys);

ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// ids := JOIN (ans, SANCTN.Key_SANCTN_Map,
             // keyed (Left.docref.doc = Right.doc),
             // transform (SANCTN_services.layouts.id, SELF := Right),
             // LIMIT (ut.limits.default, SKIP));
ids := PROJECT( ans, TRANSFORM( SANCTN_services.layouts.id,
                                self.BATCH_NUMBER := left.ExternalKey[1..8],
																self.INCIDENT_NUMBER := left.ExternalKey[9..16] ) );
                                
mod_access_raw := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
mod_access := MODULE(PROJECT(mod_access_raw,doxie.IDataAccess))
                     EXPORT STRING ssn_mask := '';
                END;
                                                
// fetch search records
rpen := SANCTN_services.raw.search_view.by_id (ids,mod_access);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.BATCH_NUMBER+l.INCIDENT_NUMBER);

rpen_sorted := SORT (rpen2, -incident_date_clean);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, paged_results, , outputCount);
		
if(~Err, outputCount);
IF(~Err, OUTPUT(paged_results, NAMED('Results')));

ENDMACRO;
