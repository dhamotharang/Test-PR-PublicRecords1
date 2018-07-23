//This function appends picklist dids to bankruptcy batch_in and projects them back to the original layout.
IMPORT BatchServices, BatchShare;
EXPORT fn_append_picklist(DATASET(BatchServices.layout_BankruptcyV3_Batch_in) ds_batch_in,
	BatchShare.IParam.BatchParams batch_params, BOOLEAN isFCRA) := FUNCTION

  //The batch_in record is missing the addr and err_search fields expected by the macro.
  picklist_rec := RECORD
    BatchServices.layout_BankruptcyV3_Batch_in;
    BatchShare.Layouts.ShareAddress;
    BatchShare.Layouts.ShareErrors;
  END;

	//Call the picklist macro on any inquiries with no value for DID (lexID)
  BatchShare.MAC_AppendPicklistDID(PROJECT(ds_batch_in((unsigned6)did = 0), picklist_rec),
    ds_batch_in_picklist, batch_params, isFCRA);

	//Add the original inquiries with lexIDs to the ones found with picklist.
  ds_batch_in_appended_plist := JOIN(ds_batch_in,
    ds_batch_in_picklist((unsigned6)did > 0), LEFT.acctno = RIGHT.acctno, TRANSFORM(BatchServices.layout_BankruptcyV3_Batch_in,
    SELF.did := if((unsigned6)RIGHT.did > 0, RIGHT.did, LEFT.did), SELF := LEFT), LEFT OUTER);

	RETURN ds_batch_in_appended_plist;
END;