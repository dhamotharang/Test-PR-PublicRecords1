import STD;

//------------------------------------------------------------------------------------------------------------
// Sample TMX layouts.base data from wwtm::in::log_wYYYMMDD-HHMMSS file.
//------------------------------------------------------------------------------------------------------------
current_date := STD.Date.CurrentDate(true);
filedate := (STRING4)STD.Date.Year(current_date) + (STRING2)STD.Date.Month(current_date);
r := INQL_TMX.layouts.base_for_log;
d := dataset('~wwtm::in::log_w20181205-064520', r, thor); 

ds_sample_tmx_base := CHOOSEN(d, 10);

output(ds_sample_tmx_base,,'~wwtm::in::log_kje', overwrite);