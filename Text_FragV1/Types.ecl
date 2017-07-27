EXPORT Types := MODULE
	EXPORT SourceItem := ENUM(UNSIGNED1, Header, Property, FBN, SOS);
	EXPORT SourceList := SET OF SourceItem;
	
	EXPORT StateCode	:= STRING2;
	EXPORT StateList	:= SET OF StateCode;
	
	EXPORT FileType		:= ENUM(UNSIGNED1, AnswerDocX);
END;