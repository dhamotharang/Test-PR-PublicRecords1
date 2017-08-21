IMPORT	PhoneMart;
	dBaseFile				:=	PhoneMart.Files.base;
	dBaseFileOut		:=	PROJECT(dBaseFile,TRANSFORM(Scrubs_PhoneMart.Layout_PhoneMart,SELF:=LEFT));
EXPORT	In_PhoneMart	:=	dBaseFileOut;