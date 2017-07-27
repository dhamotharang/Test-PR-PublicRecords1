/*--SOAP--
<message name="PersonByCompany_BatchService">
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/> 
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="FuzzinessDial"        type="xsd:byte"/>
	<part name="ZipRadius"            type="xsd:byte"/>
	<part name="EmailThreshold"       type="xsd:byte"/>
	<part name="MaxResultsPerRow"     type="xsd:byte"/>
		
	<part name="batch_in"             type="tns:XmlDataSet" cols="70" rows="25"/>	
</message>
*/
import AutoStandardI;
EXPORT PersonByCompany_BatchService() := MACRO

	InputRec := BatchServices.PersonByCompany_BatchService_Layouts.Input;
	
	DATASET(InputRec) DS_Batch_In := DATASET([],InputRec) : STORED('Batch_In');
	
	defaults := BatchServices.PersonByCompany_BatchService_Constants.Defaults;
	
	args := MODULE(BatchServices.PersonByCompany_BatchService_Interfaces.Input)
		EXPORT DPPAPurpose := defaults.DPPAPURPOSE : STORED('DPPAPurpose');
		EXPORT GLBPurpose := defaults.GLBPURPOSE : STORED('GLBPurpose');
		EXPORT FuzzinessDial := defaults.FUZZINESSDIAL : STORED('FuzzinessDial');
		EXPORT ZipRadius := defaults.ZIPRADIUS : STORED('ZipRadius');
		UNSIGNED temp_EmailThreshold := defaults.EMAILTHRESHOLD : STORED('EmailThreshold');
		EXPORT EmailThreshold := (real)temp_EmailThreshold / 100.0;
		EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW : STORED('MaxResultsPerRow');
		Export String32 applicationType := 	AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	END;
	
	Results := BatchServices.PersonByCompany_BatchService_Records(DS_Batch_In, args).Records;
	
	OUTPUT(Results,NAMED('Results'));

ENDMACRO;
	
