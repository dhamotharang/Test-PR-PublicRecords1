import std;

EXPORT ConvertSecs2ThorTime(

  real8 pSeconds
  
) := 
function

  secsstring    := (string)pSeconds;
  dotindex      := std.str.find(secsstring,'.',1);
  fractionsecs  := (real8)('0' + if(dotindex != 0 ,secsstring[dotindex..] ,''));

  days    := (unsigned)(pSeconds / 86400);
  hours   := (unsigned)((pSeconds % 86400) / 3600);
  minutes := (unsigned)((pSeconds % 3600) / 60);
  seconds := (pSeconds % (real8)60.0) + fractionsecs; //do this because modulus division does not preserve fractions.


  // =if(INT(1/86400*A1) > 0, INT(1/86400*A1) & " day(s), " ,"") 
  // & if(INT(MOD(A1,86400)/3600) > 0 ,INT(MOD(A1,86400)/3600) & " hour(s), " ,"") 
  // & if(INT(MOD(A1,3600)/60) > 0 ,INT(MOD(A1,3600)/60) &" minutes, " ,"") 
  // & if(MOD(A1,60) > 0 ,MOD(A1,60) & " seconds"  ,"")

  daystring     := if(days    > 0                                          ,(string)days    + ' days '                       ,''   );
  hourstring    := if(hours   > 0                               or days > 0,(string)hours   + ':'                       ,''   );
  minutestring  := if(minutes > 0                  or hours > 0 or days > 0,(string)minutes + ':'                       ,''   );
  secondstring  := if(seconds > 0.0 or minutes > 0 or hours > 0 or days > 0,trim(realformat(seconds,5,2 ),left,right )  ,'0.0');

  constructtime := daystring + hourstring + minutestring + secondstring;

  return constructtime;
  
end;