import Healthcare_Header_Services, doxie, ut, AutoStandardI;

export ING_provider_report_recordsbyDid(dataset(doxie.layout_references) dids, boolean Include_Sanc=false) := FUNCTION

	doxie.MAC_Header_Field_Declare();
	gm := AutoStandardI.GlobalModule();
	//Format prov into new format
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
		self.IncludeSanctions := Include_Sanc;
		self.DRM := gm.DataRestrictionMask;
		self.glb_ok :=  ut.glb_ok (gm.GLBPurpose);
		self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
		self.glb:= gm.GLBPurpose;
                self.dppa:= gm.DPPAPurpose; 
		// self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg:=dataset([buildConfig()]);
	rawData := Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(dids,cfg);
	fmtData := Healthcare_Header_Services.Records.fmtRecordsLegacyReport(rawData,cfg);
	sancCheck := if(Include_Sanc,fmtData,project(fmtData,transform(recordof(fmtData),self.sanction_data:=[],self:=left)));
	out_final := sancCheck;
return out_final;

END;	