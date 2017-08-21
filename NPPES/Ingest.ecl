EXPORT Ingest := MODULE
  shared base := In_FileIN; // Change IN_FileIN to change input to ingest process
export InputFile := base; // Nothing to ingest - so very simple process
END;
