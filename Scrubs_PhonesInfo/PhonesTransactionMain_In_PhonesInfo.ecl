﻿IMPORT PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset	:=	PhonesInfo.File_Phones_Transaction.Main;

EXPORT PhonesTransactionMain_In_PhonesInfo := Scrubs_Dataset;