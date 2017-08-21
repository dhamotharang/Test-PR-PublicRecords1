Import PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset				:=	PhonesInfo.File_Metadata.PortedMetadata_Main;

Export BaseFile_In_PhonesInfo := Scrubs_Dataset;