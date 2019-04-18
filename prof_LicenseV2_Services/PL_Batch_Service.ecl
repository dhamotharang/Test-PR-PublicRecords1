
/*--SOAP--
<message name="PL_Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="MaxResults" type="xsd:unsignedInt"/> 
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
</message>
*/

export PL_Batch_Service(useCannedRecs = 'false') := MACRO

	unsigned2 penTh := 20 : STORED('PenaltThreshold');

  // 05/20/2010 - Moved almost all of the coding out this macro to a separate new
	// PL_Batch_Service_Records function attribute so the function can be called
	// from more than one batch service.
	// The first parm below is passing the input PenaltThreshold on to the new function.
	// The second parm below is passing on the input useCannedRecs boolean for testing.
	// The third parm below is set to false, which tells the new function you are NOT 
	// running the Medlic_PL_Combined_Batch_Service.


		ds_batch_in_raw := DATASET([], prof_LicenseV2_Services.Layout_MLPL_Combined_Input) : STORED('batch_in', FEW);
		Pre_result := prof_LicenseV2_Services.PL_Batch_Service_Records(penTh,useCannedRecs,false,ds_batch_in_raw);
		
		ut.mac_TrimFields(Pre_result, 'Pre_result', result);
		
		mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
		IF (exists(result), doxie.compliance.logSoldToTransaction(mod_access));

		OUTPUT(result, NAMED('RESULTS'));		
	
	
	
ENDMACRO;