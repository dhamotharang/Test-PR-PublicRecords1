IMPORT PhonesInfo, Scrubs_PhonesInfo, ut;

Scrubs_Dataset	:=	PhonesInfo.File_iConectiv_PortData_Validate_In;

EXPORT PortData_ValidateIn_In_PhonesInfo := Scrubs_Dataset;