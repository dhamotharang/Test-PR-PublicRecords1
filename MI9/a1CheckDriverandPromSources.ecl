
// ******* Run on NCLOP1
// select SOURCE_UID,SOURCE_FULL_NAME,CNTY_COUNTY_CD,STAT_STATE_CD,DINA_DINA_ID 
// from prom_sources;

// select COUNTY_CD, COUNTY_NAME
// from counties;

// select SCRE_ID, COURT_ID,PRSO_SOURCE_UID,RECORD_SUPPLIER_CD
// from source_cross_references;
//********


output(MI9.File_LN_Cross_Extract_Driver);

output(MI8.File_LN_Cross_prom_sources);

output(mi8.File_LN_Cross_Counties);

output(MI8.File_LN_Cross_Source_Cross_References);

output(mi7.File_references_tables(record_supplier_cd = 'SOFF'));

