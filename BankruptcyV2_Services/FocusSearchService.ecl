/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
  <part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
  
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="ReturnHashes" type="xsd:boolean"/>
  <part name="srch_hashvals" type="tns:XmlDataSet" cols="70" rows="3"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--INFO-- Bankruptcy Text Search.
*/
// Code cribbed from LiensTextSearchService 1 Aug 2007.
IMPORT alerts,text_search,BankruptcyV2,ut,doxie;
EXPORT FocusSearchService := MACRO

 //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_BankruptcyV2_Services_FocusSearchService();
    
#CONSTANT('isTextSearchService',TRUE);

// boolean-specific parameters
STRING srchString := '' : STORED('FocusSearch');

in_BRkeys := DATASET([], Text_Search.Layout_ExternalKey) : STORED('FocusDocIDs',few);

// general-use parameters
STRING6 ssn_mask_value := 'NONE' : STORED('SSNMask');
UNSIGNED8 MaxResults_val := 2000 : STORED('MaxResults');
UNSIGNED8 MaxResultsThisTime_val := 2000 : STORED('MaxResultsThisTime');
UNSIGNED8 SkipRecords_val := 0 : STORED('SkipRecords');
BOOLEAN isAlert := FALSE : STORED('ReturnHashes');

// boolean search
TSConsts := BankruptcyV2.Constants('').text_search;

// Define alert info
AlertInfo := Text_Search.Alert_Info.SetAlertParams(TSConsts.dateSegName,TSConsts.alertSWDays,'',isAlert);

info := Text_Search.FileName_Info_Instance(TSConsts.stem, TSConsts.srcType, TSConsts.qual);

//Flist := project(in_BRkeys, TRANSFORM(Text_Search.Layout_ExternalKey, SELF.ExternalKey := LEFT.TMSID));
Flist := in_BRkeys;

s := Text_Search.Focus_Search_Module(info, srchString,FALSE,,, MaxResults_val, TRUE,,Flist,AlertInfo);
ans := s.ExtKeyAnswers;
errCode := s.error_code;
errMsg := s.error_msg;
noErr := errCode = 0;
IF(~noErr, ut.outputMessage(errCode, errMsg));


// DEBUG - fake boolean search ('MARIA and VERGARA and SUN VALLEY and CA')
// ans := dataset([{ {16707,87}, 8.594649, 1, [{0,0,0,0}] }], text_search.Layout_DocHits);
// noErr := true;

// lookup tmsids using docRefs
wkeys := PROJECT(ans, TRANSFORM(BankruptcyV2_Services.layout_TMSID_ext,
  SELF.isdeepdive := FALSE;
  SELF.TMSID := LEFT.ExternalKey;
  ));

tmsids := DEDUP(wkeys, tmsid, ALL);

// generate the report
rpen := BankruptcyV2_Services.bankruptcy_raw().boolean_source_view(in_tmsids := tmsids, in_ssn_mask := ssn_mask_value);

rpen_sorted := SORT(rpen,-date_filed,case_number,
                    IF(debtors[1].names[1].cname <> '', debtors[1].names[1].cname, debtors[1].names[1].lname), RECORD);


Alerts.mac_ProcessAlerts(rpen_sorted,bankruptcyv2_services.alert,final_res);

orec := RECORD
  RECORDOF(final_res);
  Text_Search.Layout_ExternalKey;
END;
orec addExt ( final_res l) := TRANSFORM
  SELF := l;
  SELF.ExternalKey := l.TMSID;
END;
final_res2 := PROJECT(final_res, addext(LEFT));

// paging
doxie.MAC_Marshall_Results_NoCount(final_res2, paged_results,, outputCount);

// output count & results, and we're done
IF(noErr, outputCount);
IF(noErr, OUTPUT( paged_results, NAMED('Results') ));

ENDMACRO;
