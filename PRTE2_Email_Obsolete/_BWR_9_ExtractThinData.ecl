IMPORT PRTE2_Email,PRTE2,ut;
// Builder window code 
// Use this to export the data out to a CSV file


dsBase := PRTE2_Email.zz_Original_Base_Data_Extract.Original_Base_Data_Extracted;

OUTPUT(dsBase,, '~thor::ct_temp::lead_optimizer::email::alldata', CSV(HEADING(SINGLE), QUOTE('"'), SEPARATOR(',')), OVERWRITE);
