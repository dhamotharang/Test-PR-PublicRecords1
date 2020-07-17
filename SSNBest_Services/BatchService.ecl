/*--SOAP--	 
<message name="BatchService">
<part name="DataRestrictionMask"  type="xsd:string"/>
<part name="ApplicationType"      type="xsd:string"/>
<part name="IndustryClass"        type="xsd:string"/>
<part name="IncludeMinors"        type="xsd:boolean"/>
<part name="DPPAPurpose"          type="xsd:byte"/>
<part name="GLBPurpose"           type="xsd:byte"/>
<part name="SSNMask"              type="xsd:string"/>
<part name="DIDScoreThreshold"    type="xsd:byte"/>
<part name="IsGlbRequired"        type="xsd:boolean"/>
<part name="Display_HRI"          type="xsd:boolean"/>
<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
IMPORT SSNBest_Services,ut,BatchShare,AutoStandardI,WSInput;
EXPORT BatchService() := FUNCTION
  batch_params := SSNBest_Services.IParams.getBatchParams();
  ds_batch_in := DATASET( [], SSNBest_Services.Layouts.Batch_in) : STORED('batch_in', FEW);
 
  WSInput.MAC_SSN_Best_Batch_Service();
 	
  processed_input := BatchShare.MAC_Process_Validate(ds_batch_in);
  ds_batch_out    := SSNBest_Services.Records(processed_input, batch_params);	
 
  IF(batch_params.IsGlbRequired AND NOT batch_params.isValidGLB(batch_params.check_RNA_),
    FAIL('An error occurred while running SSNBest_Services.BatchService: invalid GLB purpose.'));
 
  RETURN OUTPUT(ds_batch_out,NAMED('Results'));
END;