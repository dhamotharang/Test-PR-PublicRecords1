﻿/*--SOAP--
<message name="VIN_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="ReturnCurrent" type="xsd:boolean"/>
  <part name="Run_Deep_Dive" type="xsd:boolean"/>
  <part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="FullNameMatch" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
  <part name="BIPFetchLevel" type="xsd:string"/>
</message>
*/

IMPORT VehicleV2_Services, BIPV2;

EXPORT Vin_Batch_Service() := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
  data_in := DATASET([], VehicleV2_Services.Batch_Layout.Vin_BatchIn) : STORED('batch_in', FEW);
  
  STRING1 sBIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID : STORED('BIPFetchLevel');
    
  mod := MODULE(VehicleV2_Services.IParam.RTBatch_V2_params)
    EXPORT BOOLEAN ReturnCurrent := FALSE :STORED('ReturnCurrent');
    EXPORT BOOLEAN FullNameMatch := FALSE : STORED('FullNameMatch');
    EXPORT BOOLEAN Is_UseDate := FALSE;
    EXPORT BOOLEAN penalize_by_party := FALSE;
    EXPORT STRING1 BIPFetchLevel := STD.Str.touppercase(sBIPFetchLevel);
  END;
  
  res := VehicleV2_Services.Vin_Batch_Service_records(data_in, mod);

  ut.mac_TrimFields(res, 'res', result);
  
  OUTPUT(result, NAMED('Results'), ALL);
  
ENDMACRO;
