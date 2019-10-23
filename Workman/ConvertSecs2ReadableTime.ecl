EXPORT ConvertSecs2ReadableTime(

  real8 pSeconds
  
) := 
function

  days    := (unsigned)(pSeconds / 86400);
  hours   := (unsigned)((pSeconds % 86400) / 3600);
  minutes := (unsigned)((pSeconds % 3600) / 60);
  seconds := (real8)pSeconds % 60;


  // =if(INT(1/86400*A1) > 0, INT(1/86400*A1) & " day(s), " ,"") 
  // & if(INT(MOD(A1,86400)/3600) > 0 ,INT(MOD(A1,86400)/3600) & " hour(s), " ,"") 
  // & if(INT(MOD(A1,3600)/60) > 0 ,INT(MOD(A1,3600)/60) &" minutes, " ,"") 
  // & if(MOD(A1,60) > 0 ,MOD(A1,60) & " seconds"  ,"")

  daystring     := if(days    > 0, (string)days    + ' day'     + if(days    > 1 ,'s,',',')  ,'');
  hourstring    := if(hours   > 0, (string)hours   + ' hour'    + if(hours   > 1 ,'s,',',')  ,'');
  minutestring  := if(minutes > 0, (string)minutes + ' minute'  + if(minutes > 1 ,'s,',',')  ,'');
  secondstring  := if(seconds > 0, (string)seconds + ' second'  + if(seconds > 1 ,'s' ,'' )  ,'');

  constructtime := daystring + hourstring + minutestring + secondstring;

  return constructtime;
  
end;