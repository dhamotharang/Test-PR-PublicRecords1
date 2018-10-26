// Modified on 09 Jan 2018 21:09:42 GMT by HIPIE (version 1.8.0) on machine ORLBROWNJ003-WXL
  IMPORT Std.Str;
 
EXPORT Utils:=MODULE
 
	EXPORT stripuserurl(STRING url):=FUNCTION
		start:=Str.Find(url,'//',1);
		finish:=Str.Find(url,'@',1);
		logurl:=IF(start=0 and finish=0,url, IF(finish=0,url,url[1..(start+1)] + url[(finish+1)..]));
		RETURN logurl;
	END;
 
 	EXPORT Sleep(INTEGER n) := PIPE('sleep ' + n,{STRING hack}); 
END;
