IMPORT BatchServices;

EXPORT layout_BkReport_Batch_in_plusCounter  := 
  RECORD
    BatchServices.layout_BkReport_Batch_in;
    UNSIGNED3 rec_count;
  END;   