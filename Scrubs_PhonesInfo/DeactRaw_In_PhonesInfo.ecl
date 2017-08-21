Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_Deact.Raw;

EXPORT DeactRaw_In_PhonesInfo := Scrubs_Dataset;