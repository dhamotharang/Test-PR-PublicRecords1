import ut;
 
 mi_mar_filter:=dataset('~thor_200::in::mar_div::mi::marriage', marriage_divorce_v2.Layout_Marriage_MI_In, flat,OPT);
 
 //reformat the data into something that can be mapped.
string State_Names := 
'ALABAMA'+'|'+
'ALASKA'+'|'+ 
'ARKANSAS'+'|'+ 
'AMERICAN SAMOA'+'|'+ 
'ARIZONA'+'|'+ 
'CALIFORNIA'+'|'+ 
'COLORADO'+'|'+ 
'CONNECTICUT'+'|'+ 
'DISTRICT OF COLUMBIA'+'|'+ 
'DELAWARE'+'|'+ 
'FLORIDA'+'|'+ 
'GEORGIA'+'|'+ 
'GUAM'+'|'+ 
'HAWAII'+'|'+ 
'IOWA'+'|'+ 
'IDAHO'+'|'+ 
'ILLINOIS'+'|'+ 
'INDIANA'+'|'+ 
'KANSAS'+'|'+ 
'KENTUCKY'+'|'+ 
'LOUISIANA'+'|'+ 
'MASSACHUSETTS'+'|'+ 
'MARYLAND'+'|'+ 
'MAINE'+'|'+ 
'MICHIGAN'+'|'+ 
'MINNESOTA'+'|'+ 
'MISSOURI'+'|'+ 
'MISSISSIPPI'+'|'+ 
'MONTANA'+'|'+ 
'NORTH CAROLINA'+'|'+ 
'NORTH DAKOTA'+'|'+ 
'NEBRASKA'+'|'+ 
'NEW HAMPSHIRE'+'|'+ 
'NEW JERSEY'+'|'+ 
'NEW MEXICO'+'|'+ 
'NEVADA'+'|'+ 
'NEW YORK'+'|'+ 
'OHIO'+'|'+ 
'OKLAHOMA'+'|'+ 
'OREGON'+'|'+ 
'PENNSYLVANIA'+'|'+ 
'PUERTO RICO'+'|'+ 
'RHODE ISLAND'+'|'+ 
'SOUTH CAROLINA'+'|'+ 
'SOUTH DAKOTA'+'|'+
'TENNESSEE'+'|'+ 
'TEXAS'+'|'+ 
'UTAH'+'|'+ 
'VIRGINIA'+'|'+ 
'VIRGIN ISLANDS'+'|'+ 
'VERMONT'+'|'+ 
'WASHINGTON'+'|'+ 
'WISCONSIN'+'|'+ 
'WEST VIRGINIA'+'|'+ 
'WYOMING';


new_MI_Layout1 := record
	string10 filing_dt1:='';
	string80 LMF_Name1:='';
	string2 Age1:='';
	string80 csz1:='';
	string80 LMF_Name2:='';
	string2 Age2:='';
	string80 csz2:='';
	string1  lf1:='';
end;


new_MI_Layout1 Clean_MI(marriage_divorce_v2.Layout_Marriage_MI_In l) := TRANSFORM
Name1 := trim(l.payload1);
tempName1 := regexreplace('^([[:alpha:]\'.-]+)[ ]+(.*?)[ ]+([[:digit:]]+)$',Name1,'$1 $2',nocase);
CityStateZip1 := trim(l.payload2);
tempstate1 := regexreplace('^(.*?)[ ]+('+ State_Names +')[ ]+(.*)$',CityStateZip1 ,'$1, $2 $3',nocase);
tempAge1:=  regexreplace('^([[:alpha:]\'.-]+)[ ]+(.*?)[ ]+([[:digit:]]+)$',Name1,'$3',nocase);

Name2 := trim(l.payload3);
tempName2 := regexreplace('^([[:alpha:]\'.-]+)[ ]+(.*?)[ ]+([[:digit:]]+)$',Name2,'$1 $2',nocase);
CityStateZip2 := trim(l.payload4);
tempstate2 := regexreplace('^(.*?)[ ]+('+ State_Names +')[ ]+(.*)$',CityStateZip2 ,'$1, $2 $3',nocase);
tempAge2:=  regexreplace('^([[:alpha:]\'.-]+)[ ]+(.*?)[ ]+([[:digit:]]+)$',Name2,'$3',nocase);
self.LMF_Name1 := tempName1;
self.Age1 := tempAge1;
self.csz1 := tempstate1;

self.LMF_Name2 := tempName2;
self.Age2 := tempAge2;
self.csz2 := tempstate2;

self := l;
end;
new_mi_ds:= project(mi_mar_filter, Clean_MI(LEFT));



export File_Marriage_MI_In := new_mi_ds( (trim(LMF_Name1)!='') or (trim(LMF_Name2)!='')); 