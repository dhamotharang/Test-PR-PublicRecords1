/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
  <part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="IncludeNonDMVSources" type="xsd:boolean"/>
  <part name="DOBMask" type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- Drivers Text Search. */

EXPORT FocusSearchService := MACRO

IMPORT Text_Search, ut, doxie, DriversV2, standard, suppress, autostandardI, DriversV2_Services, WSInput;

//The following macro defines the field sequence on WsECL page of query.
WSInput.MAC_DriversV2_Services_FocusSearchService();

#CONSTANT('IncludeInsuranceDrivers', FALSE); //to disable Insurance DL data

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := DATASET([], Text_Search.Layout_ExternalKey) : STORED('FocusDocIDs',few);

// general-use parameters
UNSIGNED8 MaxResults_val := 2000 : STORED('MaxResults');
UNSIGNED8 MaxResultsThisTime_val := 2000 : STORED('MaxResultsThisTime');
UNSIGNED8 SkipRecords_val := 0 : STORED('SkipRecords');

// boolean search
STRING stem := '~thor_data400::base';
STRING srcType := 'dlv2';
STRING qual := 'prod';
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Focus_Search_Module (info, srchString,FALSE,,, MaxResults_val,,,in_keys);

ans := s.ExtKeyanswers;
errCode := s.error_code;
errMsg := s.error_msg;

BOOLEAN Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// Get ids and fetch raw records
best_ids := PROJECT (ans, TRANSFORM (DriversV2_Services.layouts.seq,
  SELF.dl_seq := (UNSIGNED6)LEFT.ExternalKey[1..15]));

rpen := DriversV2_Services.DLRaw.narrow_view.by_seq (best_ids);
  
post_dobmask := driversV2_services.fn_dob_mask_Addition(rpen);

Text_Search.MAC_Append_ExternalKey(post_dobmask, post_dobmask_ready, INTFORMAT(l.dl_seq,15,1));
rpen_sorted := SORT(post_dobmask_ready, -lic_issue_date, -expiration_date);

// Show first page (append sequence number to comply with the output from regular search)
doxie.MAC_Marshall_Results_NoCount (rpen_sorted, res_paged, , outputCount);

IF(~Err, outputCount);
IF(~Err, OUTPUT (res_paged, NAMED('Results')));

ENDMACRO;
//TextSearchService ();
