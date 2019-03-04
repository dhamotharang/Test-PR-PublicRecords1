IMPORT DIDville, batchshare;
EXPORT AppendDid_BatchService_Layouts := MODULE
  EXPORT layout_did_InbatchWithAcctno := RECORD
		string20 acctno;
		DidVille.Layout_Did_InBatch - [seq];	
		// seq field is only used internally in this roxie query by this call
		// didville.did_service_common_function so it can be removed from
		// the initial input and ending output structures where acctno field
		// basically replaces it.
	END;	
	EXPORT Layout_did_inBatchWithAcctnoBatchShare := RECORD(layout_did_InbatchWithAcctno)	
	  STRING20 orig_acctno := '';
    Batchshare.Layouts.ShareErrors;
	END;	
	EXPORT layout_did_outBatchAdlCatWAcctno := RECORD
		 string20 acctno;
	   didville.layout_did_outBatch - [seq]; 
	   string15 adl_Category := ''; // CDM ph1 R2		 		 
     Batchshare.Layouts.ShareErrors;
	END;		
  
   EXPORT layout_did_InbatchWithAcctnoWithDID := RECORD(layout_did_InbatchWithAcctno)
     Batchshare.Layouts.ShareDid;
	END;	
  
END;