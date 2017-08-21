export commonFn := 
MODULE

export VARSTRING duration_str(String dur) := FUNCTION
durpattern:='([0-9]+)(.)';//'33m' or '15y'
duration_unit := REGEXFIND(durpattern,TRIM(dur,LEFT,RIGHT),2);
units:=REGEXFIND(durpattern,TRIM(dur,LEFT,RIGHT),1);
dur_unit_expanded:= CASE(TRIM(StringLib.StringToLowerCase(duration_unit),left,right),
 'd' => 'DAYS',
 'm' => 'MONTHS',
 'y' => 'YEARS',
 '');
 return TRIM(units,left,right)+' '+TRIM(dur_unit_expanded,left,right);
END;

export VARSTRING sentence_descr(string stc) := FUNCTION
stcpattern:='(.*)-(.*)$';//'39y-LIFE' or '15y-25y'
from:=REGEXFIND(stcpattern,stc,1);
to:=REGEXFIND(stcpattern,stc,2);
from_str:=IF(from <>'LIFE', duration_str(from),from);
to_str:=  IF(to <>'LIFE', duration_str(to),to);
descr:=from_str+' TO '+to_str;
return IF(from_str <> '' and to_str <> '',descr,stc);

END;

export VARSTRING DateToStandard(String d) := FUNCTION
// Returns date in mm/dd/yyyy format to CCCCMMDD format
datepattern := '^(.*)/(.*)/(.*)$';
yy:=(STRING4)(REGEXFIND(datepattern,d,3));
mm:=(INTEGER)REGEXFIND(datepattern,d,1);
mmstr:=IF(mm<10,'0'+(String1)mm,(string2)(mm));
dd:=(INTEGER)REGEXFIND(datepattern,d,2);
ddstr:=IF(dd<10,'0'+(String1)dd,(string2)(dd));
s:=yy+mmstr+ddstr;
return IF(TRIM(s,left,right) <>'0000',s,'');
END;



END;
									