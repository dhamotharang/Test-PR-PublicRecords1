EXPORT Ingest := MODULE
  shared base := In_HealthFacility; // Change IN_HealthFacility to change input to ingest process
  IMPORT SALT30;
export InputFile := base; // Nothing to ingest - so very simple process
END;
