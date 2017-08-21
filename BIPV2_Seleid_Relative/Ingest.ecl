EXPORT Ingest := MODULE
  shared base := In_Base; // Change IN_Base to change input to ingest process
  IMPORT SALT31;
export InputFile := base; // Nothing to ingest - so very simple process
END;
