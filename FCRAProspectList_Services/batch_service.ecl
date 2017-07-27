/////////////////////
// Roxie service summary:
//
// Batch service which hits the new fcra best DID key made up of only FCRA sources
// This key is built weekly and already incorporates into its logic the FCRA corrections/overrides
// The service then also goes against an opt out file that is updated daily to
// remove any particular DID rows that are in that key.
// it also does the standard DID/ SSN suppression for 'famous' people and SSN masking if so desired.
/////////////////////////////////

//
import batchShare, FCRAProspectList_Services;
EXPORT Batch_Service() :=
MACRO
	
	ds_batchIn := DATASET([],FCRAProspectList_Services.Layouts.Input) : STORED('Batch_In');		
  // Standardize input
  BatchShare.MAC_ProcessInput(ds_batchIn,ds_batchInProcessed);
  
  batchParams := FCRAProspectList_Services.iParam.getBatchParams();
  
	ds_batchResults := FCRAProspectList_Services.Batch_Records(ds_batchInProcessed,batchParams);
		
  BatchShare.MAC_RestoreAcctno(ds_batchInProcessed,ds_batchResults,results);
	
	OUTPUT(results,NAMED('Results'));

ENDMACRO;	
