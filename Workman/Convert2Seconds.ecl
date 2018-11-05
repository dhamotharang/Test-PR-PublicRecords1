/*
Convert2Seconds

convert thor time to seconds for easier excel
so, '23:1:36.318' to 82896.318 seconds
// 1 days 12:43:30.073

WorkMan.Convert2Seconds('1 days,14 hours,18 minutes,25 seconds');

*/
import std;

export Convert2Seconds(string time) :=
function

  //convert to seconds
  //days have 3 colons, so:  1:4:58:20.64
  //or                      1 days 4:58:20.64

//thregex := '^([[:digit:]]+)( days |:)(?=[[:digit:]]+[:][[:digit:]]+[:][[:digit:]]+[.]?[[:digit:]]*)';  
  
  getDays := if(regexfind('^([[:digit:]]+)( days |:)(?=[[:digit:]]+[:][[:digit:]]+[:][[:digit:]]+[.]?[[:digit:]]*)',time,nocase) ,regexfind   ('^([[:digit:]]+)( days |:)(?=[[:digit:]]+[:][[:digit:]]+[:][[:digit:]]+[.]?[[:digit:]]*)',time,1 ,nocase)  ,'0'  );
  getRest := if(regexfind('^([[:digit:]]+)( days |:)(?=[[:digit:]]+[:][[:digit:]]+[:][[:digit:]]+[.]?[[:digit:]]*)',time,nocase) ,regexreplace('^([[:digit:]]+)( days |:)(?=[[:digit:]]+[:][[:digit:]]+[:][[:digit:]]+[.]?[[:digit:]]*)',time,'',nocase)  ,time );
  
  numcolons := std.str.findcount(getRest,':');
  
  replacecolons := std.str.findreplace(getRest,':',',');
  reverseit     := std.str.reverse(replacecolons);

  seconds := std.str.reverse(STD.Str.Extract(reverseit ,1));
  minutes := if(numcolons >= 1  ,std.str.reverse(STD.Str.Extract(reverseit ,2))  ,'0');
  hours   := if(numcolons >= 2  ,std.str.reverse(STD.Str.Extract(reverseit ,3))  ,'0');
  days    := getDays;
  
  minutessec  := (real)minutes           * 60;
  hourssec    := (real)hours        * 60 * 60;
  daysssec    := (real)days    * 24 * 60 * 60;

//  return days + ':' + hours + ':' + minutes + ':' + seconds;
  totalsecs := (real)seconds + minutessec + hourssec + daysssec;

  theregex := '^(([[:digit:]]+)( day[s]?,))?(([[:digit:]]+)( hour[s]?,))?(([[:digit:]]+)( minute[s]?,))?(([[:digit:]]+)( second[s]?))?$';

  days2    := regexfind(theregex,time, 2,nocase);
  hours2   := regexfind(theregex,time, 5,nocase);
  minutes2 := regexfind(theregex,time, 8,nocase);
  seconds2 := regexfind(theregex,time,11,nocase);

  minutessec2  := (real)minutes2           * 60;
  hourssec2    := (real)hours2        * 60 * 60;
  daysssec2    := (real)days2    * 24 * 60 * 60;
  
  totalsecs2 := (real)seconds2 + minutessec2 + hourssec2 + daysssec2;

  
  return if(regexfind(theregex,time,nocase) ,totalsecs2 ,totalsecs);
  
end;
/*
output(fdoit(besttime));

=INT(1/86400*A4) & " day(s), "

=INT(1/86400*A4) & " day(s), " & INT(MOD(A4,86400)/3600) & " hour(s), " & INT(MOD(A4,3600)/60) &" minutes, " & MOD(A4,60) &" seconds"

=if(INT(1/86400*A4) > 0, INT(1/86400*A4) & " day(s), " ,"") 
& if(INT(MOD(A4,86400)/3600) > 0 ,INT(MOD(A4,86400)/3600) & " hour(s), " ,"")
& if(INT(MOD(A4,3600)/60) > 0 ,INT(MOD(A4,3600)/60) &" minutes, " ,"")
& if(MOD(A4,60) > 0 ,MOD(A4,60) & " seconds"  ,"")

excel formula to convert seconds to days, hours, minutes, seconds
=if(INT(1/86400*A1) > 0, INT(1/86400*A1) & " day(s), " ,"") & if(INT(MOD(A1,86400)/3600) > 0 ,INT(MOD(A1,86400)/3600) & " hour(s), " ,"") & if(INT(MOD(A1,3600)/60) > 0 ,INT(MOD(A1,3600)/60) &" minutes, " ,"") & if(MOD(A1,60) > 0 ,MOD(A1,60) & " seconds"  ,"")

*/