/*--SOAP--
<message name="TextSearchService">
  <part name="Search"							type="xsd:string" rows="7" cols="40" />
	<part name="MaxResults"					type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime"	type="xsd:unsignedInt"/>
  <part name="SkipRecords"				type="xsd:unsignedInt"/>
	<part name="DPPAPurpose"				type="xsd:byte"/>
	<part name="IncludeNonDMVSources"			type="xsd:boolean"/>
	<part name="DOBMask"					type="xsd:string"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- Drivers Text Search. */

EXPORT TextSearchService := MACRO

import Text_Search, ut, doxie, DriversV2, standard, Suppress, driversv2_services, WSInput;

//The following macro defines the field sequence on WsECL page of query. 
WSInput.MAC_DriversV2_Services_TextSearchService();
									
#CONSTANT('IncludeInsuranceDrivers', FALSE); //to disable Insurance DL data

// boolean-specific parameters
string srchString := '' : STORED('Search');

// general-use parameters
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
string6 DOBMask := '' : stored('DOBMask');

// boolean search
string stem		:= '~thor_data400::base';
string srcType := 'dlv2';
string qual		:= 'test';
info := Text_Search.FileName_Info_Instance (stem, srcType, qual);

s := Text_Search.Text_Search_Module (info, srchString,false,,, MaxResults_val);

ans := s.answers;
errCode := s.error_code;
errMsg := s.error_msg;

boolean Err := errCode != 0;
IF (Err, ut.outputMessage (errCode, errMsg));

// Get ids and fetch raw records
best_ids := PROJECT (ans, transform (DriversV2_Services.layouts.seq, SELF.dl_seq := Left.docref.doc));

rpen := DriversV2_Services.DLRaw.narrow_view.by_seq (best_ids);

dmv := rpen(source_code not in driversv2.Constants.nonDMVsources);
non_dmv := rpen(source_code in driversv2.Constants.nonDMVsources);
rpen_sorted := sort(dmv, -lic_issue_date, -expiration_date) &
							 sort(non_dmv, -dt_last_seen, record);
							 

pre_dobmasking := dedup(rpen_sorted, except dl_seq);	

// common up  code together for the boolean services.
post_dobmask := driversv2_services.fn_dob_mask_Addition(pre_dobmasking);
				
// Show first page (append sequence number to comply with the output from regular search)
doxie.MAC_Marshall_Results_NoCount (post_dobmask, res_paged, , outputCount);

if(~Err, outputCount);
IF(~Err, OUTPUT (res_paged, NAMED('Results')));

ENDMACRO;
//TextSearchService ();