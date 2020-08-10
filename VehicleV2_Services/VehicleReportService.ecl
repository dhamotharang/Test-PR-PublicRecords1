/*--SOAP--
<message name="VehicleReportService">
  <part name="VehicleKey" type="xsd:string"/>
  <part name="IterationKey" type="xsd:string"/>
  <part name="SequenceKey" type="xsd:string"/>
  <part name="VIN" type="xsd:string"/>
  <part name = 'BDID' type = 'xsd:string'/>
  <part name = 'DID' type = 'xsd:string'/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="ApplicationType" type="xsd:string"/>
  <part name="DataSource" type = 'xsd:string' />
  <part name="IncludeNonRegulatedVehicleSources" type="xsd:boolean"/>
  <part name="MotorVehicleReport2Request" type="tns:XmlDataSet" cols="80" rows="10" />
  
</message>
*/
/*--INFO-- This service returns records for a specific vehicle.*/
//***********************
// Right now the only accepted DataSource values are Realtime (in house VINA file not the POLK gateway) and Local
//***********************
IMPORT iesp;

EXPORT VehicleReportService := MACRO
  
  ds_in := DATASET ([], iesp.motorvehicle.t_MotorVehicleReport2Request) : STORED ('MotorVehicleReport2Request', FEW);
  first_row := ds_in[1] : INDEPENDENT;
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  VehicleV2_Services.IParam.SetInputReportBy(first_row.ReportBy);
  VehicleV2_Services.IParam.SetInputReportOptions(first_row.Options);
  
  tempmod1 := VehicleV2_Services.IParam.getReportModule();
  
  vehs_report := VehicleV2_Services.VehicleReport(tempmod1);
  
  emptyDataset := DATASET([], VehicleV2_Services.Layout_Report);
  
  BOOLEAN returnIesp := COUNT(ds_in) > 0;
  
  nonIespOutput := IF (returnIesp, emptyDataset, vehs_report);

  recordsForIesp := IF (returnIesp, vehs_report, emptyDataset);
  
  iespResults := iesp.transform_vehiclesV2(recordsForIesp);
    
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(iespResults, iespOutput,
                iesp.motorvehicle.t_MotorVehicleReport2Response, MotorVehicleRecords, TRUE);
        
    
  /* THIS OUTPUT SEQUENCE SHOULD NEVER BE CHANGED. THE INTENT IS TO SUPPORT BOTH OUTPUT
      FORMATS - ESDL and non-ESDL */
  OUTPUT(iespOutput, NAMED('MotorVehicleReport2Response'));
  OUTPUT(nonIespOutput, NAMED('Results'));

ENDMACRO;
//VehicleV2_Services.VehicleReportService();
/*
<MotorVehicleReport2Request>
  <row>
    <User>
      <GLBPurpose>1</GLBPurpose>
      <DLPurpose>1</DLPurpose>
      <DataRestrictionMask>000000000000000000</DataRestrictionMask>
      <EndUser/>
    </User>
    <Options>
      <IncludeNonRegulatedVehicleSources>false</IncludeNonRegulatedVehicleSources>
    </Options>
    <ReportBy>
      <VIN>xxxxxxxxxx</VIN>
      <VehicleRecordId>xxxxx</VehicleRecordId>
      <IterationKey>xxxxx</IterationKey>
      <SequenceKey>xxxxx</SequenceKey>
      <BusinessId>000732017665</BusinessId>
      <UniqueId>xxxxx</UniqueId>
      <DataSource>ALL</DataSource>
    </ReportBy>
  </row>
</MotorVehicleReport2Request>
*/
