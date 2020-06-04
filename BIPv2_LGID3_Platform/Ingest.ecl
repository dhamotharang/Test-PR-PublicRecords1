EXPORT Ingest := MODULE
  shared base := In_LGID3; // Change IN_LGID3 to change input to ingest process
  IMPORT SALT30;
export InputFile := base; // Nothing to ingest - so very simple process
END;
