import scrubs;
EXPORT fn_CourtOffensesV3Check(string off_lev, string vendor) := function

return if(vendor in ['5W','3N','3O','4D','3J','3Y','3K','3L','2K','2L','90',
'64','55','B7','A3','B8','73','1J','AT','63','1B','42','43','A4','D4','93',
'NC','1R','2H','2V','1L','2O','1N','2Z','1M','2W','1A','1E','1I','91','89',
'1S','1T','1U','1V','1X','1W','1Z','2A','2B','2C','2F','2D','2E','OR','2Q',
'2X','2U','2Y','3R','98','77','78','AP','79','80','47','97','WA','A7'],1,Scrubs.fn_valid_codesv3(trim(off_lev,left,right),trim(vendor,left,right),'COURT_OFF_LEV','COURT_OFFENSES'));

end;