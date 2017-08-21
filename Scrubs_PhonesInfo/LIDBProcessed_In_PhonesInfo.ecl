Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_LIDB.Response_Processed;

EXPORT LIDBProcessed_In_PhonesInfo := Scrubs_Dataset;