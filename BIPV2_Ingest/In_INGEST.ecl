import BIPV2_Files, MDR;
EXPORT In_Ingest := BIPV2_Files.files_ingest.DS_BUILDING;
// EXPORT In_Ingest := BIPV2_Files.files_ingest.DS_BUILDING(source NOT IN [MDR.sourceTools.src_MO_Corporations,MDR.sourceTools.src_MS_Corporations]);