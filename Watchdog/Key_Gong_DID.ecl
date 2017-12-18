import data_services;

d := watchdog.File_Gong_Doxie;

export Key_Gong_DID := INDEX(d, {did,unsigned8 fpos}, data_services.data_location.prefix() + 'thor_data400::key::gong.did');