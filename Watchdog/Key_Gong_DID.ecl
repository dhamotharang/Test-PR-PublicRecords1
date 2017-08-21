IMPORT Data_Services;
d := watchdog.File_Gong_Doxie;

export Key_Gong_DID := INDEX(d, {did,unsigned8 fpos}, Data_Services.Data_location.Prefix('Watchdog_Best')+'thor_data400::key::gong.did');