/*--SOAP--
<message name="PAWBatch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="Return_Current_Only" type="xsd:boolean"/>
	
	<part name="Match_Name" type="xsd:boolean"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City" type="xsd:boolean"/>
	<part name="Match_State" type="xsd:boolean"/>
	<part name="Match_Zip" type="xsd:boolean"/>
	<part name="Match_SSN" type="xsd:boolean"/>
	<part name="Match_LinkID" type="xsd:boolean"/>
</message>
*/

IMPORT Autokey_batch, paw_services;

EXPORT Batch_Service(useCannedRecs = 'false') := MACRO
 
	BOOLEAN ReturnCurrentOnly := FALSE : STORED('Return_Current_Only');
  global_mod := AutoStandardI.GlobalModule();
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

	ds_batch_in := IF( NOT useCannedRecs, 
		                 BatchServices.file_inBatchMaster(), 
		                 BatchServices._Sample_inBatchMaster('BUSINESS') 
                    );	 

	pre_result := paw_services.Batch_Service_Records(ds_batch_in, mod_access, ReturnCurrentOnly);
	ut.mac_TrimFields(pre_result, 'pre_result', result);
		
	OUTPUT(result, NAMED('Result'));
		
ENDMACRO;