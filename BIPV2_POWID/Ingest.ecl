IMPORT SALT33;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_POWID) Delta = DATASET([],Layout_POWID)
, DATASET(Layout_POWID) dsBase = In_POWID // Change IN_POWID to change input to ingest process
) := MODULE
EXPORT InputFile := dsBase; // Nothing to ingest - so very simple process
END;
