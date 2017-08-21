Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_TCPA.Daily_Raw_Wireline_to_Wireless;

Export Daily_Raw_Wireline_to_Wireless_In_PhonesInfo := Scrubs_Dataset;