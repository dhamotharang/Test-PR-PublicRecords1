import lib_stringlib;

lForceProperSet := ['AND','BED','CAR','BUS','RAM','AM' ,'CAB',
					'VAN','DR' ,'NEW','TWO','ONE','ALL','AVE',
					'FOX','CARRERA2/4','TON','OR','GEO'
				   ];

sp(string s,integer1 n) := if(stringlib.stringfind(s,' ',n)=0,
							  length(s),
							  stringlib.stringfind(s,' ',n)
							 );

lword(string s,integer1 n) := if (n = 1, s[1..sp(s,1)],
                 s[sp(s,n-1)+1..sp(s,n)]);

hasv(string s) := length(trim(s, all)) <> 
				  length(trim(stringlib.stringfilterout(s, 'AEIOUaeiou'), all));

hasnumber(string s) := length(trim(s, all)) <> 
				  length(trim(stringlib.stringfilterout(s, '0123456789'), all));

more3(string s) := length(trim(s, all)) > 3;

isgo(string s) := (hasv(s) and more3(s) and (not hasnumber(s)))
				  or
				  lib_stringlib.stringlib.stringtouppercase(trim(s)) in lForceProperSet;

ccase(string s) := 
	if(isgo(s),
	   stringlib.stringtouppercase(s[1])+stringlib.StringToLowerCase(s[2..length(s)]),
	   if(stringlib.StringToUpperCase(s)='4RUNNER',
		  '4Runner',
		  stringlib.stringtouppercase(s)
		 )
	  );

lIn1  (string s) := lib_stringlib.stringlib.stringfindreplace(s,'/',' / ');
lIn2  (string s) := lib_stringlib.stringlib.stringfindreplace(s,'-',' - ');
lOut1 (string s) := lib_stringlib.stringlib.stringfindreplace(s,' / ','/');
lOut2 (string s) := lib_stringlib.stringlib.stringfindreplace(s,' - ','-');

lFixCase (string s) := 
	  ccase(lword(s,1)) 
	+ if(lword(s,2) <> '', ccase(lword(s,2)),'')
	+ if(lword(s,3) <> '', ccase(lword(s,3)),'')
	+ if(lword(s,4) <> '', ccase(lword(s,4)),'')
	+ if(lword(s,5) <> '', ccase(lword(s,5)),'')
	+ if(lword(s,6) <> '', ccase(lword(s,6)),'')
	+ if(lword(s,7) <> '', ccase(lword(s,7)),'')
	+ if(lword(s,8) <> '', ccase(lword(s,8)),'')
	+ if(lword(s,9) <> '', ccase(lword(s,9)),'')
	+ if(lword(s,10) <> '', ccase(lword(s,10)),'')
	+ if(lword(s,11) <> '', ccase(lword(s,11)),'')
	+ if(lword(s,12) <> '', ccase(lword(s,12)),'')
	+ if(lword(s,13) <> '', ccase(lword(s,13)),'')
	+ if(lword(s,14) <> '', ccase(lword(s,14)),'')
	+ if(lword(s,15) <> '', ccase(lword(s,15)),'')
    ;

export proper_case(String s) := lOut2(lOut1(lFixCase(lIn2(lIn1(s)))));