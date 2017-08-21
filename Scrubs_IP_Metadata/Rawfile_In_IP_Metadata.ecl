Import IP_Metadata, Scrubs_IP_Metadata, ut;

	Scrubs_Dataset :=	IP_Metadata.File_IP_Metadata.Raw;
	
Export RawFile_In_IP_Metadata := Scrubs_Dataset;