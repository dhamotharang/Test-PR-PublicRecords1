Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_Deact_GH.Main_current;

EXPORT DeactGHMain_In_PhonesInfo := Scrubs_Dataset;