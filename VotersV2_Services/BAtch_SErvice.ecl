/*--SOAP--
<message name="Batch_Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="MaxResults" type="xsd:unsignedInt"/> 
</message>
*/

import VotersV2_Services, Autokey_batch, BatchServices;

export Batch_Service := macro

	ds_batch_in := DATASET([]
												 ,Autokey_batch.Layouts.rec_inBatchMaster) : STORED('batch_in');

  //** FLAPSD AK, PAYLOAD 
	ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export UseAllLookUps := TRUE;
			export skip_set := ['B'];
	END;

	recs := VotersV2_Services.Batch_Service_Records(ds_batch_in, ak_config_data);
	OUTPUT(recs, NAMED('Results'));				 

	
ENDMACRO;
//VotersV2_Services.BAtch_SErvice();