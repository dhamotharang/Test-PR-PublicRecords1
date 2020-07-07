﻿/*--SOAP--
<message name="Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="Return_Current_Only" type="xsd:boolean"/>
  <part name="Run_Deep_Dive" type="xsd:boolean"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="IncludeNonRegulatedWatercraftSources" type="xsd:boolean"/>
  <part name="BIPFetchLevel" type="xsd:string"/>
</message>
*/

IMPORT Autokey_batch, BatchServices, BatchShare, BIPV2;

EXPORT Batch_Service(useCannedRecs = FALSE) := MACRO
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  // Alias
  AutoKeyBatchInput := WatercraftV2_Services.Layouts.batch_in;
  
  STRING1 sBIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
  
  batch_params := BatchShare.IParam.getBatchParams();
  wk_batch_params := MODULE(PROJECT(batch_params, WatercraftV2_Services.Interfaces.batch_params, opt))
    EXPORT BOOLEAN include_non_regulated_sources := FALSE : STORED('IncludeNonRegulatedWatercraftSources');
    EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(sBIPFetchLevel);
  END;

  ds_xml_in_raw := DATASET([], AutoKeyBatchInput) : STORED('batch_in', FEW);
  canned_in := PROJECT(WatercraftV2_Services.BatchCannedInput, AutoKeyBatchInput);
  ds_xml_in := IF( useCannedRecs, canned_in, ds_xml_in_raw);

  // run input through some standard procedures
  BatchShare.MAC_SequenceInput(ds_xml_in, ds_sequenced);
  BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);

  ds_batch_out := WatercraftV2_Services.BatchRecords(wk_batch_params, ds_batch_in, FALSE);
  
  // Restore original acctno and format to output layout.
  BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_out, ds_batch_ready);
  ds_batch_final_pre := PROJECT(ds_batch_ready, WatercraftV2_Services.Transforms.xform_toFinalBatch(LEFT));
  
  //Actual project to the final batch out
  ds_batch_final := PROJECT(ds_batch_final_pre, WatercraftV2_Services.Layouts.batch_out);
  
  results := SORT(ds_batch_final, acctno, penalt);

  OUTPUT(results, NAMED('RESULTS'), ALL);
ENDMACRO;
