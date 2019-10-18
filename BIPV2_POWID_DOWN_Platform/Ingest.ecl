EXPORT Ingest := MODULE
  shared base := In_POWID_Down; // Change IN_POWID_Down to change input to ingest process
  IMPORT SALT27;
export InputFile := base; // Nothing to ingest - so very simple process
END;
