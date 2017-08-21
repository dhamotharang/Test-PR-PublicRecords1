IMPORT	scrubs_bk_withdrawnstatus,	BankruptcyV3,	Data_Services;
	Scrubs_Dataset	:=	BankruptcyV3.File_BankruptcyV3_WithdrawnStatus().wsBase;
EXPORT	In_bk_withdrawnstatus	:=	Scrubs_Dataset;