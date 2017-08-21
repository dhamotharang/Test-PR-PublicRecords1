EXPORT Ingest := MODULE
  shared base := In_files().input.used; // Change IN_files().input.used to change input to ingest process
export InputFile := base; // Nothing to ingest - so very simple process
END;
