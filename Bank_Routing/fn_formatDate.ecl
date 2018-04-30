IMPORT ut,std;

EXPORT string8 fn_formatDate(string8 date) := FUNCTION
 today := (STRING8)Std.Date.Today();
 INTEGER1 yyyy := (INTEGER1)date[5..];

 RETURN case(length(ut.CleanSpacesAndUpper(date)),
  8	=> date[5..8]	+	date[1..4], // format mmddyyyy -> yyyymmdd
  6	=> if((INTEGER1)today[3..4]<yyyy,'19'+intformat(yyyy,2,1),'20'+intformat(yyyy,2,1)) + date[1..4], // format mmddyy -> yyyymmdd
  date);
END;
