Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_LIDB.Send;

EXPORT LIDBCurrent_In_PhonesInfo := Scrubs_Dataset;