import doxie, data_services;
t := record
 string6 sic_code;
 string1 franchise_char;
 string42 description;
end;

d := dataset('~thor_data400::in::abius::fran',t,flat);

export Key_ABIUS_FranCode := index(d,{sic_code,franchise_char},{d},data_services.data_location.prefix() + 'thor_data400::key::abius::'+doxie.Version_SuperKey + '::fran');