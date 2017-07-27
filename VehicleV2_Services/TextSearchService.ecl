/*--SOAP--
<message name="VehicleV2TextSearchService">
  <part name="Search" type="xsd:string" rows="7" cols="40" />

	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
  <part name="SSNMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt */
/*--INFO-- Text Search.
*/
export TextSearchService := MACRO

// disable return of criminal indicators
#constant ('includeCriminalIndicators', false);

// boolean-specific parameters
STRING srchString := '' : STORED('Search');

// b general-use parameters
STRING6 ssn_mask_value := 'NONE' : stored('SSNMask');
unsigned8 MaxResults_val := 2000 : stored('MaxResults');
unsigned8 MaxResultsThisTime_val := 2000 : stored('MaxResultsThisTime');
unsigned8 SkipRecords_val := 0 : stored('SkipRecords');
unsigned8 MaxDocs := MaxResults_val;


// boolean search
STRING stem		:= '~thor_data400::base';
STRING srcType:= 'VehicleV2';
STRING qual		:= 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);


s := Text_Search.Text_Search_Module(info, srchString,false,,,MaxDocs);

errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));

j := JOIN(s.answers,Vehiclev2.Key_Boolean_Map,keyed(LEFT.docref.src=RIGHT.src) AND keyed(LEFT.docref.doc=RIGHT.doc),
					transform(VehicleV2_Services.Layout_Vehicle_Key,self :=right),KEEP(1),limit(1000,skip));

dup_vehs := dedup(sort(j,vehicle_key,iteration_key,sequence_key),vehicle_key,iteration_key,sequence_key);
grp_vehs := group(dup_vehs,vehicle_key,iteration_key);

rpen :=VehicleV2_services.Vehicle_raw.get_vehicle_search(grp_vehs);

rpen_sorted := SORT(rpen,-iteration_key, record);

doxie.MAC_Marshall_Results_NoCount(rpen_sorted,res,,Outputcount);

// outputs
if(noErr, outputCount);
IF(noErr, OUTPUT(res, NAMED('Results')));

ENDMACRO;