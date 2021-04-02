IMPORT PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset	:=	PhonesInfo.File_Phones_Type.Main;

EXPORT PhonesTypeMain_In_PhonesInfo := Scrubs_Dataset;