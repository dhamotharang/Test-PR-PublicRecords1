IMPORT AddrBest;
EXPORT layout := MODULE
  
  EXPORT request := RECORD
    string applicationtype;
    string datapermissionmask;
    string datarestrictionmask;
    string dppapurpose;
    string glbpurpose;
    dataset(AddrBest.Layout_BestAddr.Batch_in) batch_in;
  END;

  EXPORT response := AddrBest.Layout_BestAddr.batch_out_final;

END;
