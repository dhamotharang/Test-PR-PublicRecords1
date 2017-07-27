IMPORT SALT33;
EXPORT Ingest(BOOLEAN incremental=FALSE
, DATASET(Layout_DOT) Delta = DATASET([],Layout_DOT)
, DATASET(Layout_DOT) dsBase = In_DOT // Change IN_DOT to change input to ingest process
) := MODULE
EXPORT InputFile := dsBase; // Nothing to ingest - so very simple process
END;
