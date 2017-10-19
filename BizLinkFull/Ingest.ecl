IMPORT SALT33;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_BizHead) Delta = DATASET([],Layout_BizHead)
, DATASET(Layout_BizHead) dsBase = In_BizHead // Change IN_BizHead to change input to ingest process
) := MODULE
EXPORT InputFile := dsBase; // Nothing to ingest - so very simple process
END;

