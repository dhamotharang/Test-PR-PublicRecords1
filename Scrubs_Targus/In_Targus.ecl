IMPORT	Targus, ut;
	dBaseFile				:=	Targus.File_Consumer_Base_Unfiltered;
	dBaseFileOut		:=	PROJECT(dBaseFile,TRANSFORM(Scrubs_Targus.Layout_Targus,SELF:=LEFT));
EXPORT	In_Targus	:=	dBaseFileOut;