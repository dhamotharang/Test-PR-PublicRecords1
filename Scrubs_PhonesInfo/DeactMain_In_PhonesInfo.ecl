Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_Deact.Main_current;

EXPORT DeactMain_In_PhonesInfo := Scrubs_Dataset;