EXPORT fn_date_reformat(STRING InDate):=FUNCTION
  UNSIGNED1 _mm:=(UNSIGNED1) InDate[1..StringLib.StringFind(InDate,'/',1)-1];
  UNSIGNED1 _dd:=(UNSIGNED1)InDate[StringLib.StringFind(InDate,'/',1)+1..StringLib.StringFind(InDate,'/',2)-1];
  UNSIGNED2 _yyyy:=(UNSIGNED2)InDate[StringLib.StringFind(InDate,'/',2)+1..];
  RETURN IF(_yyyy>0,(QSTRING4)_yyyy,'')+if(_mm>0,INTFORMAT(_mm,2,1),'')+IF(_dd>0,INTFORMAT(_dd,2,1),'');
END;
