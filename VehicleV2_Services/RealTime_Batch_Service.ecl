/*--SOAP--
<message name="RealTime_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte" default="1"/>
  <part name="GLBPurpose" type="xsd:byte" default="1"/>
  <part name="RealTimePermissibleUse" type="xsd:string" default="LAWENFORCEMENT"/>
  <part name="Operation" type="xsd:unsignedInt"/>
  <part name="DataPermissionMask" type="xsd:string"/>
  <part name="gateways" type="tns:XmlDataSet" cols="90" rows="6"/>
  <part name="ReturnDetailedRoyalties" type="xsd:boolean"/>
</message>
*/
/*--INFO-- Real-Time Motor Vehicle Report via the Polk gateway<br>
<table border="1">
<tr><th>Operation:</th><td>0=Default</td><td>1=VIN</td><td>2=LicPlateAndState</td></tr>
</table>
*/
/*--USES-- ut.input_xslt */

EXPORT RealTime_Batch_Service() := MACRO

  UNSIGNED1 Operation := 0 : STORED('Operation');
  inputData := DATASET([],VehicleV2_Services.Batch_Layout.RealTime_InLayout) : STORED('batch_in',FEW);
  _recs := VehicleV2_Services.RealTime_Batch_Service_Records(inputData,Operation);
  recs := PROJECT(_recs, VehicleV2_Services.Batch_Layout.RealTime_OutLayout_V1); // Plate number only returned by V2 version.
  
  returnDetailedRoyalties := FALSE : STORED('ReturnDetailedRoyalties');
  Royalty.RoyaltyVehicles.MAC_Append(recs, results, vin);
  Royalty.RoyaltyVehicles.MAC_BatchSet(results, royalties,,returnDetailedRoyalties);

  OUTPUT(results,NAMED('results'));
  OUTPUT(royalties,NAMED('RoyaltySet'));

ENDMACRO;
//VehicleV2_Services.RealTime_Batch_Service();
/* Expected XML Format
<dataset>
  <row>
    <acctNo></acctNo>
    <name_full></name_full>
    <name_first></name_first>
    <name_middle></name_middle>
    <name_last></name_last>
    <name_suffix></name_suffix>
    <comp_name></comp_name>
    <addr1></addr1>
    <addr2></addr2>
    <p_city_name></p_city_name>
    <st></st>
    <z5></z5>
    <year></year>
    <make></make>
    <model></model>
    <vinIn></vinIn>
    <plate></plate>
    <plateState></plateState>
    <date></date>
  </row>
</dataset>
*/
