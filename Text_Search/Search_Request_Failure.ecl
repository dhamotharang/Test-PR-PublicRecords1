EXPORT Search_Request_Failure(FileName_Info info,
															KeywordingFunc func, 
															STRING srchRqst) :=
FUNCTION

s := Text_Search.Search_Request_Module(info, func, srchRqst);

RETURN IF(~EXISTS(s.RPN_Search_Request) AND srchRqst<>'', 10001, 0);
END;