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
	Healthcare_Header_Services.Layouts.common_runtime_config buildConfig():=transform
	 self.glb_ok := ut.glb_ok (gm.GLBPurpose);
	 self.dppa_ok := ut.dppa_ok(gm.DPPAPurpose);
	 self.DRM := gm.DataRestrictionMask;
		self.IncludeSpecialties  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeLicenses  := Healthcare_Shared.Constants.CFG_False;
		self.IncludeResidencies  := Healthcare_Shared.Constants.CFG_False;
		//self:=[];Do not uncomment otherwise the default values will not get set.
	end;
	cfg := dataset([buildConfig()]);
	
	results := Healthcare_Ganga.Records.getAllRecords(ds_batch_in_stored,cfg);
	
	output(results, named('Results'));

ENDMACRO;