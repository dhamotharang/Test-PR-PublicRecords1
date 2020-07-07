IMPORT PhonesInfo, Scrubs_PhonesInfo, ut;

	Scrubs_Dataset	:=	PhonesInfo.File_Source_Reference.Main;

EXPORT CarrierReferenceMain_In_PhonesInfo := Scrubs_Dataset;