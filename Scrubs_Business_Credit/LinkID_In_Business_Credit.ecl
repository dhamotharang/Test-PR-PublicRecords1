IMPORT	Scrubs_Business_Credit,	Business_Credit,	ut;
	in_Dataset			:=	Business_Credit.Files().LinkIDs;
	//	Need to flatten out the record for SALT Report
	Scrubs_Dataset	:=	PROJECT(in_Dataset,TRANSFORM(Scrubs_Business_Credit.LinkID_Layout_Business_Credit,SELF:=LEFT.Tradeline,SELF:=LEFT));
EXPORT	LinkID_In_Business_Credit	:=	Scrubs_Dataset;//(record_type='AB');
