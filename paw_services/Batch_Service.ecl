// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
IMPORT paw_services, AutoStandardI, BatchServices, doxie, ut;

EXPORT Batch_Service(useCannedRecs = 'FALSE') := MACRO
 
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
