#workunit('name', 'Infousa Create All Input Superfiles');

fileservices.createsuperfile('~thor_data400::in::ABIUS_COMBINED_DATA');
fileservices.createsuperfile('~thor_data400::in::infousa_idexec');
fileservices.createsuperfile('~thor_data400::in::infousa_deadco');
