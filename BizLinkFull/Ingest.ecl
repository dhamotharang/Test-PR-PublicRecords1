EXPORT Ingest := MODULE
  shared base := In_BizHead; // Change IN_BizHead to change input to ingest process
  IMPORT SALT28;
export InputFile := base; // Nothing to ingest - so very simple process
END;

