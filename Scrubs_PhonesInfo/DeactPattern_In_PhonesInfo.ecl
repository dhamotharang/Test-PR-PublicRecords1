Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_Pattern.DeactPatterns;

EXPORT DeactPattern_In_PhonesInfo := Scrubs_Dataset;