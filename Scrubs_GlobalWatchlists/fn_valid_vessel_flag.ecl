EXPORT fn_valid_vessel_flag(string flag) := function
return if(trim(flag) in 
[
'CUBA',
'SIERRA LEONE',
'MONGOLIA',
'PANAMA',
'NONE IDENTIFIED',
'SEYCHELLES',
'IRAN',
'PALAU',
'MALTA',
'UNKNOWN',
'TANZANIA',
'LIBERIA',
'CAMBODIA',
'CYPRUS',
'SAINT KITTS AND NEVIS',
'DEMOCRATIC PEOPLE\'S REPUBLIC OF KOREA',
''
],
1,0);


end;