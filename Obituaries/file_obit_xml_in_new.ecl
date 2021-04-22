Import obituaries;

EXPORT file_obit_xml_in_new	:= FUNCTION
// EXPORT file_obit_xml_in(string8 filedate)	:= FUNCTION
//sprayedfile	:= 'memorial_lexis_nexis_1_'+ filedate+'_xml';
//ds_obit_xml := dataset('~thor_data400::in::'+REGEXREPLACE('\\.xml$',sprayedfile,'_xml'), obituaries.layouts.obit_xml_in, xml('obituaries/obituary'));

// ds_obit_xml := dataset('~thor_data400::in::tributes_dmaster_raw', obituaries.layouts.obit_xml_in, xml('obituaries/obituary'));

ds_obit_xml := dataset('~thor_data400::in::tributes_dmaster_raw_history_new', obituaries.layouts_new.obit_xml_historical, xml('table/row'));


RETURN ds_obit_xml;

END;