EXPORT Ingest := MODULE
  shared base := In_POWID; // Change IN_POWID to change input to ingest process
  IMPORT SALT32;
export InputFile := base; // Nothing to ingest - so very simple process
END;
