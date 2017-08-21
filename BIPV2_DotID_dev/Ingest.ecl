EXPORT Ingest := MODULE
  shared base := In_DOT; // Change IN_DOT to change input to ingest process
  IMPORT SALT30;
export InputFile := base; // Nothing to ingest - so very simple process
END;
