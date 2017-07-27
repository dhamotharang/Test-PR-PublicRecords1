/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
	
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- TAXPRO Text Search. */

EXPORT FocusSearchService := MACRO

import Text_Search, ut, doxie, SANCTN;

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');

// boolean search
STRING stem		:= TAXPRO_Services.Constants.stem;
STRING srcType:= TAXPRO_Services.Constants.srcType;
STRING qual		:= TAXPRO_Services.Constants.qual;
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,false,,, MaxResults_val,,,in_keys);

ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// ids := JOIN (ans, TAXPRO.key_boolean_taxpro_map,
             // keyed (Left.docref.doc = Right.doc),
             // transform (TAXPRO_services.layouts.id, SELF := Right),
             // LIMIT (ut.limits.default, SKIP));
ids := PROJECT( ans, TRANSFORM( TAXPRO_services.layouts.id, self.tmsid := left.ExternalKey));

// fetch search records
rpen := TAXPRO_services.raw.search_view.by_id (ids);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.tmsid);

rpen_sorted := SORT (rpen2, -dt_last_seen, -dt_first_seen, tmsid);

doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT(res, NAMED('Results')));

ENDMACRO;
