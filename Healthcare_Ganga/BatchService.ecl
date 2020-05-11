/*--SOAP--
<message name="BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 		
	<part name="DataRestrictionMask"  type="xsd:string"/>
	<part name="DataPermissionMask"   type="xsd:string"/>
 <part name="MaxResults" 										type="xsd:unsignedInt"/>
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
/*--INFO--
<pre>
This service will return a set of matching records.

</pre>
*/
import Healthcare_Ganga,Healthcare_Shared,Healthcare_Header_Services,AutoStandardI, ut;
EXPORT BatchService := MACRO
	batch_in_layout := Healthcare_Ganga.Layouts.IdentityInput;
	ds_batch_in_stored := DATASET([], batch_in_layout) : STORED('batch_in', FEW);
	gm := AutoStandardI.GlobalModule();	
	/*Glbpurpose value is set to true for CCPA based on discussion in the  CCPA metings*/
	#CONSTANT('GLBPurpose', 7);
	
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
	 self.GLB := 7;
	 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
	 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
	 self.DRM := gm.DataRestrictionMask;
	 self.DPM := gm.DataPermissionMask;
		self.IncludeSpecialties  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeLicenses  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeResidencies  := Healthcare_Shared.Constants.CFG_False;
		self.doDeepDive := Healthcare_Shared.Constants.CFG_True;
		//self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg := dataset([buildConfig()]);
	
	raw := Healthcare_Ganga.Records.getAllRecords(ds_batch_in_stored,cfg);
	results:= project(raw, transform(Healthcare_Ganga.Layouts.IdentityOutputBatch,
																																		self.WarningsCode1 := left.Warnings[1].Code;
																																		self.WarningsCode2 := left.Warnings[2].Code;
																																		self.WarningsCode3 := left.Warnings[3].Code;
																																		self.WarningsCode4 := left.Warnings[4].Code;
																																		self.WarningsCode5 := left.Warnings[5].Code;
																																		self.WarningsCode6 := left.Warnings[6].Code;
																																		self.WarningsCode7 := left.Warnings[7].Code;
																																		self.WarningsCode8 := left.Warnings[8].Code;
																																		self.WarningsCode9 := left.Warnings[9].Code;
																																		self.WarningsCode10 := left.Warnings[10].Code;
																																		self.WarningsSource1 := left.Warnings[1].Source;
																																		self.WarningsSource2 := left.Warnings[2].Source;
																																		self.WarningsSource3 := left.Warnings[3].Source;
																																		self.WarningsSource4 := left.Warnings[4].Source;
																																		self.WarningsSource5 := left.Warnings[5].Source;
																																		self.WarningsSource6 := left.Warnings[6].Source;
																																		self.WarningsSource7 := left.Warnings[7].Source;
																																		self.WarningsSource8 := left.Warnings[8].Source;
																																		self.WarningsSource9 := left.Warnings[9].Source;
																																		self.WarningsSource10 := left.Warnings[10].Source;
																																		self.Name1 := left.NameValues[1].Name;
																																		self.Name2 := left.NameValues[2].Name;
																																		self.Name3 := left.NameValues[3].Name;
																																		self.Name4 := left.NameValues[4].Name;
																																		self.Name5 := left.NameValues[5].Name;
																																		self.Name6 := left.NameValues[6].Name;
																																		self.Name7 := left.NameValues[7].Name;
																																		self.Name8 := left.NameValues[8].Name;
																																		self.Name9 := left.NameValues[9].Name;
																																		self.Name10 := left.NameValues[10].Name;
																																		self.Value1 := left.NameValues[1].Value;
																																		self.Value2 := left.NameValues[2].Value;
																																		self.Value3 := left.NameValues[3].Value;
																																		self.Value4 := left.NameValues[4].Value;
																																		self.Value5 := left.NameValues[5].Value;
																																		self.Value6 := left.NameValues[6].Value;
																																		self.Value7 := left.NameValues[7].Value;
																																		self.Value8 := left.NameValues[8].Value;
																																		self.Value9 := left.NameValues[9].Value;
																																		self.Value10 := left.NameValues[10].Value;
																																		self := left;));
	output(results, named('Results'));
ENDMACRO;