IMPORT Autokey_batch;

EXPORT Layout_VKeysWithInput := RECORD(Layout_Vehicle_Key)
  Autokey_batch.Layouts.rec_inBatchMaster;
  STRING4 year := '';
  STRING36 make := '';
  STRING36 model := '';
  STRING15 color := '';
END;
