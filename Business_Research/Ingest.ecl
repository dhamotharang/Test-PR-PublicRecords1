EXPORT Ingest := MODULE
  shared base := In_pDataset; // Change IN_pDataset to change input to ingest process
export InputFile := base; // Nothing to ingest - so very simple process
END;
