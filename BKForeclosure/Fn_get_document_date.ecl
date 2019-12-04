IMPORT $, STD, ut;
//Get preceeding date in document_number to be added to document_year field
	fmtsin := ['%Y%m%d','%y%m%d'];
	fmtout:='%Y%m%d';

EXPORT Fn_get_document_date(string doc_nbr) := FUNCTION
	GetDate			:= IF(LENGTH(STD.Str.Filter(doc_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))>12 AND 
										REGEXFIND('^[0-9]',STD.Str.Filter(doc_nbr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')[1..2]),
										TRIM(doc_nbr)[1..8],'');
	TrimDate		:=	STD.Str.Filter(GetDate, '0123456789');
	StdDate			:=  STD.Date.ConvertDateFormatMultiple(TrimDate,fmtsin,fmtout);
	GetYear			:=	StdDate[1..4];
	DocYear		:= IF(GetYear = '' AND TrimDate[1..2] IN ['19','20'], TrimDate[1..4], GetYear);//Gets year even if month/day is missing
	
	RETURN	DocYear;
END;