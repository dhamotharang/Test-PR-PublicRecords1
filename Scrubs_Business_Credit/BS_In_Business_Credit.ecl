IMPORT	Scrubs_Business_Credit,	Business_Credit,	ut;
	Scrubs_Dataset	:=	Business_Credit.Files(Scrubs_Business_Credit.Filenames.In_Filename).BS;
EXPORT	BS_In_Business_Credit	:=	Scrubs_Dataset;