IMPORT VehicleV2_Services;

EXPORT rpc_for_polk_RTMVR( DATASET(VehicleV2_Services.Batch_Layout.RealTime_InLayout) batch_in,
                           UNSIGNED1 DPPA_Purpose,
													 UNSIGNED1 GLB_Purpose,
													 STRING realTimePermissableUse) :=	FUNCTION
/* 
<message name="RealTime_Batch_Service_V2">	
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte" default="1"/>
	<part name="GLBPurpose" type="xsd:byte" default="1"/> 
	<part name="RealTimePermissibleUse" type="xsd:string" default="LAWENFORCEMENT"/> 
	<part name="Operation" type="xsd:unsignedInt"/> 
	<part name="gateways" type="tns:XmlDataSet" cols="90" rows="6"/>
	
	// for Vin and Licplate Batch Services
	<part name="ReturnCurrent" type="xsd:boolean"/>
	<part name="Run_Deep_Dive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>

	// for best info function
	<part name="Appends" type="xsd:string"/>
  <part name="Verify" type="xsd:string"/>
  <part name="Fuzzies" type="xsd:string"/>
  <part name="Deduped" type="xsd:boolean"/>
  <part name="AppendThreshold" type="xsd:string"/>
  <part name="GLBData" type="xsd:boolean"/>
  <part name="PatriotProcess" type="xsd:boolean"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
	<part name="IncludeMinors" type="xsd:boolean"/>
	
	// for this service
	<part name="UseDate" type="xsd:boolean"/>
	<part name="SelectYears" type="xsd:boolean"/>
	<part name="NumberOfYears" type="xsd:unsignedInt"/>
	<part name="IncludeSSN" type="xsd:boolean"/>
	<part name="IncludeDOB" type="xsd:boolean"/>
	<part name="IncludeAddress" type="xsd:boolean"/>
	<part name="IncludePhone" type="xsd:boolean"/>
*/
		f_out := PIPE(batch_in
				, 'roxiepipe' +
				' -iw ' + SIZEOF(VehicleV2_Services.Batch_Layout.RealTime_InLayout) +
				' -vip' +
				' -t 10' +
				' -ow ' + SIZEOF(LuxuryAssetTax.Layouts.PolkOutLayout) +
				' -b 100' +
				' -mr 2' +
				' -h ' + ' roxiethor.sc.seisint.com:9856' + 
				' -r Results' +				
				' -q "<VehicleV2_Services.RealTime_Batch_Service_V2 format=\'raw\'>' +
				'<batch_in id=\'id\' format=\'raw\'></batch_in>' +
				'<DPPAPurpose>' + DPPA_Purpose + '</DPPAPurpose>' +
				'<GLBPurpose>' + GLB_Purpose + '</GLBPurpose>' +
				'<RealTimePermissibleUse>' + realTimePermissableUse + '</RealTimePermissibleUse>' +
				'<Operation></Operation>' +
				'<gateways>webapp_roxie_test:web33436$@10.176.68.164:7726/WsGateway?ver_=1.58</gateways>' +
				'<ReturnCurrent>TRUE</ReturnCurrent>' +
				'<Run_Deep_Dive></Run_Deep_Dive>' +
				'<PenaltThreshold></PenaltThreshold>' +
				'<Appends></Appends>' +
				'<Verify></Verify>' +
				'<Fuzzies></Fuzzies>' +
				'<Deduped></Deduped>' +
				'<AppendThreshold></AppendThreshold>' +
				'<GLBData></GLBData>' +
				'<PatriotProcess></PatriotProcess>' +
				'<DataRestrictionMask></DataRestrictionMask>' +
				'<IncludeMinors></IncludeMinors>' +
				'<UseDate></UseDate>' +
				'<SelectYears></SelectYears>' +
				'<NumberOfYears></NumberOfYears>' +
				'<IncludeSSN></IncludeSSN>' +
				'<IncludeDOB></IncludeDOB>' +
				'<IncludeAddress></IncludeAddress>' +
				'<IncludePhone></IncludePhone>' +
				'</VehicleV2_Services.RealTime_Batch_Service_V2>"'
				, LuxuryAssetTax.Layouts.PolkOutLayout);
		
		RETURN f_out;
	END;
