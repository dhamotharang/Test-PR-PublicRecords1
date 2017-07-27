/*--SOAP--
<message name="NonRegisteredVehicles_BatchService">

	<!-- GLOBAL OPTIONS -->
	<part name="DPPAPurpose"            type="xsd:byte"/>
	<part name="GLBPurpose"             type="xsd:byte"/>
	<part name="DataRestrictionMask"    type="xsd:string"/>
	<part name="DataPermissionMask"     type="xsd:string"/>
  <part name="IncludeMinors"          type="xsd:boolean"/>
	<part name="RealTimePermissibleUse" type="xsd:string"/> 
	<part name="SSNMask" 			      		type="xsd:string"/>
	<part name="ApplicationType"        type="xsd:string"/>
	<part name="GetSSNBest"             type="xsd:boolean"/>

	<!-- USER OPTIONS -->
	<part name="SearchTimeInMonths" type="xsd:string"/> 
     <!-- SearchTimeInMonths values should only be 6, 12(default) or 24 -->
	<part name="IncludePplAtAddr"   type="xsd:boolean"/>
	<part name="SearchMVR"          type="xsd:string"/>
  <!-- NOTE: SearchMVR values/options are: 
       IF = In-house first, then if not found, try Real Time (default) 
       IR = Both In-house and Real Time
       IH = In-house only
       RT = Real Time only 
  -->

  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>

	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	

</message>
*/

EXPORT NonRegisteredVehicles_BatchService(useCannedRecs = 'false') := MACRO

	recs := BatchServices.NonRegisteredVehicles_BatchService_Records(useCannedRecs);
	
	returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');
	Royalty.RoyaltyVehicles.MAC_Append(recs, results, vin, registration_source, true);
	Royalty.RoyaltyVehicles.MAC_BatchSet(results, royalties,, returnDetailedRoyalties);	

	output(results, named('Results'));
	output(royalties,NAMED('RoyaltySet'));
	
ENDMACRO;

/* For testing on a roxie box:
1. Set global options as needed: 
   DPPAPurpose, GLBPurpose, DataRestrictionMask, RealTimePermissibleUse(if using gateway) 
   and SSNMask

2. Set User options as needed:
   SearchTimeInMonths - should only be 6, 12(default) or 24
	 IncludePplAtAddr - false(default) or true to include all people at an inout address regardless if the input data has name info on it
	 SearchMVR - IF = Search in-house MVR data first, then if not found, try Real Time (default) 
               IR = Search both In-house and Real Time MVR data
               IH = Search in-house only MVR data.
               RT = Search Real Time only MVR data.

3. Use something like this in the "batch_in" box/window:
<dataset>
 <row>
  <acctno>acctno1</acctno>
  <name_first></name_first> 
  <name_middle></name_middle> 
  <name_last></name_last> 
  <prim_range></prim_range> 
  <predir></predir>
  <prim_name></prim_name> 
  <addr_suffix></addr_suffix>
  <postdir></postdir>
	<unit_desig></unit_desig>
	<sec_range></sec_range>
  <p_city_name></p_city_name> 
  <st></st> 
  <z5></z5>
  <zip4></zip4>
  <ssn></ssn>
  <dob></dob>
 </row>
</dataset>

4. If searching Real Time MVR gateway, use this in the "gateways" box/window: 

   // For ******** ESP dev(?) & cert ********
   // !!! According to an email from Warren Young on 02/09/2011, 
   // the url & id/password below should now be used: ------v
   <dataset><row>
     <servicename>polk</servicename>
     <url>http://rw_score_dev:Password01@gatewaycertesp.sc.seisint.com:7726/WsGateway</url>
   </row></dataset>

   OR Per Roberto Perez on 02/15/12, this is used by Kettle for testing:
   <RealTimeMVRGateway>
    <servicename>polk</servicename>
    <url>http://webapp_roxie_test:web33436$@gatewaycertesp.sc.seisint.com:7726/WsGateway</url>
   </RealTimeMVRGateway>

  !!! NOTE: On the esp cert gatewaty box(url), the "polk" servicename not listed, but on the ESP gateway boxes, 
      it is equivalent to the "VehicleCheck" "Operation" name which is listed.

  // For ******** ESP prod ********
  Per Roberto Perez on 02/14/12 in prod, Kettle uses this for the existing 
    VehicleV2_Services.RealTime_Batch_Service & VehicleV2_Services.RealTime_Batch_Service_V2
  <RealTimeMVRGateway>
    <servicename>polk</servicename>
    <url>http://webapp_roxie:[PASSWORD_REDACTED]@gatewayprodesp.sc.seisint.com:7726/WsGateway?ver_=1.58</url>
  </RealTimeMVRGateway>

*/
