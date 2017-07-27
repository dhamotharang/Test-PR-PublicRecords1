dbfein := DNB.File_DNB_FEIN_In;

layout_slim := record
unsigned6 fein := if(Business_header.ValidFEIN((UNSIGNED4)dbfein.TAX_ID_NUMBER), (UNSIGNED4)dbfein.TAX_ID_NUMBER, 0);
end;

dbfein_slim := table(dbfein(TAX_ID_NUMBER<>''), layout_slim);

dbfein_slim_dedup := dedup(dbfein_slim, fein, all);

count(dbfein_slim_dedup)