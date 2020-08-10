/*--SOAP--
<message name="SicCode_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
		
	<part name="MaxResultsPerAcct"    type="xsd:unsignedInt"/>
	
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

EXPORT SicCode_BatchService := MACRO
	
	UNSIGNED1 Const_MaxResultsPerAcct := BatchServices.SicCode_BatchService_Constants.MAX_RESULTS_PER_ACCT;
	
	UNSIGNED1 MaxResultsPerAcct := Const_MaxResultsPerAcct : STORED('MaxResultsPerAcct');
	UNSIGNED1 MaxResultsPerAcct_Adjusted := MIN(MaxResultsPerAcct,Const_MaxResultsPerAcct);

  input_params := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(input_params);
	
	InputRec := BatchServices.SicCode_BatchService_Layouts.Input;
	
	DATASET(InputRec) DS_Batch_In := DATASET([],InputRec) : STORED('Batch_In');
	
	Results := BatchServices.SicCode_BatchService_Records(DS_Batch_In, mod_access, MaxResultsPerAcct_Adjusted);
	
	OUTPUT(Results,NAMED('Results'));

ENDMACRO;	
