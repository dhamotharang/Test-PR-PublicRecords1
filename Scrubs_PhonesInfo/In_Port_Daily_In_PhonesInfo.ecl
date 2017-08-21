Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_iConectiv.In_Port_Daily;

Export In_Port_Daily_In_PhonesInfo := Scrubs_Dataset;