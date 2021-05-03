Import Ancestry_Data, lib_stringlib, std, _control;

pVersion := stringlib.getDateYYYYMMDD();

#workunit('name', 'Ancestry Data ');

Ancestry_Data.Process_data(pversion);