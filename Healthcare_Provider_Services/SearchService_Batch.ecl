/*--SOAP--
<message name="SearchService_Batch">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="NCPDPFullAccess"   		type="xsd:boolean"/>
	<part name="includeSanctions"     type="xsd:boolean"/> 		
	<part name="doDeepDive"				    type="xsd:boolean"/> 		
	<part name="IncludeBoardCertifiedSpecialty" type="xsd:boolean"/> 		
	<part name="DataRestrictionMask"   type="xsd:string"/>
	<part name="DataPermissionMask"    type="xsd:string"/>
	<part name="CustomerAcctNbr"	    type="xsd:string"/>
  <part name="MaxResults" 					type="xsd:unsignedInt"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of matching records.

</pre>
*/

import Healthcare_Header_Services,ut;
EXPORT SearchService_Batch := MACRO
	batch_in_layout_fmt := Healthcare_Header_Services.Layouts.autokeyInput;
	//Suppress some fields statelicense1verification and statelicense1stateverification are important as there is a license field that is really the same value internally.
	batch_in_layout := Healthcare_Header_Services.Layouts.autokeyInput_base_validations-[workphone,dl,dlstate,vin,Plate,PlateState,searchType,max_results,score,
																												date,sic_code,filing_number,apn,fips_code,score_bdid,statelicense1verification,statelicense1stateverification];
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	boolean req_Sanctions := false : STORED('includeSanctions');
	boolean req_DeepDive := false : STORED('doDeepDive');
	string req_CustomerAcctNbr := '' : STORED('CustomerAcctNbr');
	boolean req_ABMS := false : STORED('IncludeBoardCertifiedSpecialty');
	hasFullNCPDP := false :STORED('NCPDPFullAccess');
	unsigned2 MaxResults := 1 :	stored ('MaxResults');	
	unsigned2 PenaltThreshold := 10 :	stored ('PenaltThreshold');	
	gm := AutoStandardI.GlobalModule();
	
	fmtInput := project(ds_batch_in_stored, transform(batch_in_layout_fmt,
																							self.max_results := (string)MaxResults;
																							self := left;));//project autokeyInput_base into autokeyInput layout set isBatchService
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.CustomerID := req_CustomerAcctNbr;	
		self.penalty_threshold := PenaltThreshold;
		self.MaxResults := MaxResults;
		self.DRM := gm.DataRestrictionMask;
		self.DPM := gm.DataPermissionMask;
		self.hasFullNCPDP := hasFullNCPDP;
		self.glb_ok := ut.glb_ok (gm.GLBPurpose);
		self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		self.glb     := gm.GLBPurpose;
		self.dppa    := gm.DPPAPurpose;
		self.isBatchService := True;
		self.doDeepDive := req_DeepDive;
		self.IncludeAlsoFound := req_DeepDive;
		self.includeCustomerData := true;
		self.IncludeSanctions := req_Sanctions;
		self.IncludeABMSBoardCertifiedSpecialty := req_ABMS;
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfgData:=dataset([buildConfig()]);

	results := Healthcare_Header_Services.Records.getRecordsRawDoxie(fmtInput,cfgData);
	//Limit Results
	
	fmtResults_pre := project(results,Healthcare_Provider_Services.Transforms.processSearchServiceBatch(left));
	ut.mac_TrimFields(fmtResults_pre, 'fmtResults_pre', fmtResults);
	output(fmtResults, named('Results'));
ENDMACRO;
