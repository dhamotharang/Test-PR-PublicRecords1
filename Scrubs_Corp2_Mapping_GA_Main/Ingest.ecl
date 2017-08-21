EXPORT Ingest := MODULE
  shared base := In_in_file; // Change IN_in_file to change input to ingest process
  IMPORT SALT34;
export InputFile := base; // Nothing to ingest - so very simple process
END;
