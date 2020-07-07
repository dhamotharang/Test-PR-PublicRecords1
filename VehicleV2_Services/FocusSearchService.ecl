/*--SOAP--
<message name="VehicleV2FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
  <part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
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
EXPORT FocusSearchService := MACRO

// disable RETURN of criminal indicators
#CONSTANT ('includeCriminalIndicators', FALSE);

// boolean-specIFic parameters
STRING srchString := '' : STORED('FocusSearch');
in_keys := DATASET([], Text_Search.Layout_ExternalKey) : STORED('FocusDocIDs',few);

// b general-use parameters
STRING6 ssn_mask_value := 'NONE' : STORED('SSNMask');
UNSIGNED8 MaxResults_val := 2000 : STORED('MaxResults');
UNSIGNED8 MaxResultsThisTime_val := 2000 : STORED('MaxResultsThisTime');
UNSIGNED8 SkipRecords_val := 0 : STORED('SkipRecords');
UNSIGNED8 MaxDocs := MaxResults_val;


// boolean search
STRING stem := '~thor_data400::base';
STRING srcType:= 'VehicleV2';
STRING qual := 'test';
info := Text_Search.FileName_Info_Instance(stem, srcType, qual);


s := Text_Search.Focus_Search_Module(info, srchString,FALSE,,,MaxDocs,,,in_keys);

errCode := s.error_code;
errMsg := s.error_msg;

noErr := errCode = 0;

// Check for bad input
IF(~noErr, ut.outputMessage(errCode, errMsg));


vk := SIZEOF(VehicleV2_Services.Layout_Vehicle_Key.Vehicle_Key);
ik := SIZEOF(VehicleV2_Services.Layout_Vehicle_Key.Iteration_Key);
sk := SIZEOF(VehicleV2_Services.Layout_Vehicle_Key.Sequence_Key);

j := PROJECT(s.ExtKeyAnswers, TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key,
                               SELF.Vehicle_Key:=LEFT.ExternalKey[1..vk],
                               SELF.Iteration_Key:=LEFT.ExternalKey[vk+1..vk+ik],
                               SELF.Sequence_Key:=LEFT.ExternalKey[vk+ik+1..vk+ik+sk],
                               SELF:=[]));


dup_vehs := DEDUP(SORT(j,vehicle_key,iteration_key,sequence_key),vehicle_key,iteration_key,sequence_key);
grp_vehs := GROUP(dup_vehs,vehicle_key,iteration_key);

vehicle_mod := VehicleV2_services.IParam.getSearchModule();

rpen :=VehicleV2_services.raw.get_vehicle_search(vehicle_mod, grp_vehs);

Text_Search.MAC_Append_ExternalKey(rpen, rpen2, l.Vehicle_Key+l.Iteration_Key+l.Sequence_Key);

rpen_sorted := SORT(rpen2,-iteration_key, RECORD);

doxie.MAC_Marshall_Results_NoCount(rpen_sorted,res,,Outputcount);

// outputs
IF(noErr, outputCount);
IF(noErr, OUTPUT(res, NAMED('Results')));

ENDMACRO;
