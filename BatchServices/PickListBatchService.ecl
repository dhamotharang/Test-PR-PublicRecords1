/*--SOAP--
<message name="PickListBatchService">
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose"  type="xsd:byte" />
  <part name="batch_in"    type="tns:XmlDataSet" cols="70" rows="25"/>
  <part name="gateways"    type="tns:XmlDataSet" cols="110" rows="4"/>
</message>
*/
IMPORT BatchShare, Gateway;

// Testing PickList calls for batch services.

rec_batch_in := record
  BatchShare.Layouts.ShareAcct;
  BatchShare.Layouts.ShareDid;
  BatchShare.Layouts.ShareName;
  BatchShare.Layouts.ShareAddress;
  BatchShare.Layouts.SharePII;
end;

rec_batch_out := record (rec_batch_in)
  BatchShare.layouts.ShareErrors;
end;

EXPORT PickListBatchService (useCannedRecs = false) := FUNCTION
  isFCRA := true;
    
  ds_xml_in := DATASET([], rec_batch_in) : STORED('batch_in', FEW);

  BatchShare.MAC_SequenceInput(ds_xml_in, ds_in_seq);    
  BatchShare.MAC_CapitalizeInput(ds_in_seq, ds_in_cap);
  BatchShare.MAC_CleanAddresses(ds_in_cap, ds_batch_in);
    
  my_params := module(BatchShare.IParam.getBatchParamsV2())
    export dataset (Gateway.layouts.config) gateways := Gateway.Configuration.Get();
  END;

  //grab the dids
  BatchShare.MAC_AppendPicklistDID (ds_batch_in (did=0), ds_in_did, my_params, isFCRA);      
    
  ds_batch_res := project (ds_in_did, rec_batch_out) +
                  project (ds_batch_in (did!=0), rec_batch_out);

  //Restore original acctno  
  BatchShare.MAC_RestoreAcctno(ds_batch_in, ds_batch_res, ds_batch_out)    
      
  OUTPUT(ds_in_did, NAMED('ds_in_did'));        
  OUTPUT(ds_batch_out, NAMED('Results'));        
  return 0;
END;  
