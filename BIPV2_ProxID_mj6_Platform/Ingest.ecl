EXPORT Ingest := MODULE
  shared base := In_DOT_Base; // Change IN_DOT_Base to change input to ingest process
  IMPORT SALT30;
export InputFile := base; // Nothing to ingest - so very simple process
END;
