EXPORT Ingest := MODULE
  shared base := In_Address_Link; // Change IN_Address_Link to change input to ingest process
  IMPORT SALT27;
export InputFile := base; // Nothing to ingest - so very simple process
END;
