/*--SOAP--
<message name="NCPDP_Batch">
	<!-- COMPLIANCE SETTINGS -->
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
	<part name="NCPDPFullAccess"   		type="xsd:boolean"/>
</message>
*/

import iesp, AutoStandardI;

export NCPDP_Batch := MACRO
	batch_in_layout := Healthcare_Services.NCPDP_Layouts.autokeyInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	hasFullNCPDP := false :STORED('NCPDPFullAccess');

	unsigned1 DPPA_Purpose  := 0 : STORED('DPPAPurpose');
	unsigned1 GLB_Purpose := 8 : STORED('GLBPurpose');
	gm := AutoStandardI.GlobalModule();									
        Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.DRM := gm.DataRestrictionMask;
                self.glb_ok :=ut.glb_ok(gm.GLBPurpose);
		self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		self.hasFullNCPDP:=hasFullNCPDP;
		
	end;
	cfgData:=dataset([buildConfig()]);

	results := Healthcare_Services.NCPDP_Records().getRecordsBatch(ds_batch_in_stored,cfgdata);
	finalResults := project(results,Healthcare_Services.NCPDP_Transforms.fmtBatchResults(left,hasFullNCPDP));
	output(finalResults, named('Results'));
	EndMacro;