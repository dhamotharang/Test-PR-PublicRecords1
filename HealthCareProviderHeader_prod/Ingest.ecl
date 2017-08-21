EXPORT Ingest := MODULE
shared base := In_HealthProvider; // Change IN_HealthProvider to change input to ingest process
IMPORT SALT27;
export InputFile := base; // Nothing to ingest - so very simple process
END;
