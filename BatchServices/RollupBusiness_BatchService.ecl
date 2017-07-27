/*--SOAP--
<message name="RollupBusiness_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	
	<part name="FuzzinessDial"        type="xsd:byte"/>
	
	<part name="PenaltThreshold"      type="xsd:byte"/>
	<part name="MaxResultsPerRow"     type="xsd:byte"/>
		
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/

EXPORT RollupBusiness_BatchService() := MACRO

	defaults := BatchServices.RollupBusiness_BatchService_Constants.Defaults;
	
	InputRec := BatchServices.RollupBusiness_BatchService_Layouts.Input;
	
	DATASET(InputRec) DS_Batch_In := DATASET([],InputRec) : STORED('Batch_In');
	
	args := MODULE(BatchServices.RollupBusiness_BatchService_Interfaces.Input)
		EXPORT DPPAPurpose := defaults.DPPAPURPOSE : STORED('DPPAPurpose');
		EXPORT GLBPurpose := defaults.GLBPURPOSE : STORED('GLBPurpose');
		EXPORT FuzzinessDial := defaults.FUZZINESSDIAL : STORED('FuzzinessDial');
		EXPORT PenaltThreshold := defaults.PENALTTHRESHOLD : STORED('PenaltThreshold');
		EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW : STORED('MaxResultsPerRow');
	END;
	
	Results := BatchServices.RollupBusiness_BatchService_Records(DS_Batch_In, args).Records;
	
	OUTPUT(Results,NAMED('Results'));

ENDMACRO;	
