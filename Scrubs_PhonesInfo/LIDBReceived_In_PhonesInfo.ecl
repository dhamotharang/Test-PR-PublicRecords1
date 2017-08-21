Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_LIDB.Response_Received;

EXPORT LIDBReceived_In_PhonesInfo := Scrubs_Dataset;