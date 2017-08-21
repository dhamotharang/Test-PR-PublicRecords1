IMPORT	Scrubs_Business_Credit,	Business_Credit,	ut;
	Scrubs_Dataset	:=	Business_Credit.Files(Scrubs_Business_Credit.Filenames.In_Filename).MA;
EXPORT	MA_In_Business_Credit	:=	Scrubs_Dataset;