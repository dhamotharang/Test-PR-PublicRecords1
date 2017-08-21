string scr_AlphaNum(string x, Integer pos) := FUNCTION
// THis assumes that case numbers will have the form as follows
// The first number will be assumed to be some kind of date id
// the second number will be scrambled  preserving the alpha markings
patrn:= '([0-9]*)([A-Za-z\\-\\s]*)([0-9]*)(.*)';
c1:=REGEXFIND(patrn,x ,1);
c2:=REGEXFIND(patrn,x ,2);
c3:=REGEXFIND(patrn,x ,3);
c4:=REGEXFIND(patrn,x ,4);
//
c1r:=if(c1<>'' and pos= 1,(string)hash(c1)[1..6],c1);
c3r:=if(c3<>'' and pos= 2,(string)hash(c3)[1..6],c3);
return IF(c2 <> '',TRIM(c1r)+TRIM(c2)+TRIM(c3r)+TRIM(c4),(string)hash(x)[1..7]);

END;


string1 scramLetter(string1 Y) := FUNCTION
string alphabet:='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ123';
ix:=StringLib.StringFind(alphabet,Y,1);
newix:=(ix*56781 % 35)+1;


RETURN if ((newix= 0 or newix > 35) , 'X',alphabet[newix..newix]);

END;

string6 scr_plate(string x):= FUNCTION

c1:=scramLetter(x[1..1]);
c2:=scramLetter(x[2..2]);
c3:=scramLetter(x[3..3]);
c4:=scramLetter(x[4..4]);
c5:=scramLetter(x[5..5]);
c6:=scramLetter(x[6..6]);
return TRIM(c6+c3+c4+c1+C2+c5);
END;

export string fn_scramblePII(string what, string s):= FUNCTION
num1:='989898989898989898';
len:=LENGTH(s)-3;
alphaset:=['A','B','C','D','E','F','G',
           'H','I','J','K','L','M','N',
		   'O','P','Q','R','S','T','U',
		   'V','x','Y','Z'];


return case(StringLib.StringToUpperCase(what),
  'DL'=> if(s<>'',s[1]+'98'+intformat(((integer)s[2..LENGTH(s)]*13737 % ((integer)power(10,len))),len,1),''),
  //xxx-xx-xxxx
  'SSN'=> if(trim(s) not in ['','0'],'773'+intformat(((integer)s[4..9]*567991 % 1000000),6,1),''),
  'DID'=> if((integer) s<>0, '9999'+intformat((integer)s[1..8]*197663%((integer)power(10,8)),8,1),''),
  'DOB'=> if((integer) s>19000000 ,s[1..4]+intformat((integer)s[5..6]*29%12+1,2,1)+intformat((integer)s[7..8]*29%27+1,2,1),''),
  'PHONE'=>if(trim(s) not in ['','0'],intformat((integer)s*19878 % 10000000000,10,1),''),
  'NUMBER'=>if(trim(s) not in ['','0'] ,intformat((integer)s*1874943%((integer)power(10,length(s))),length(s),1),''),
  'CHARS' =>if(s<>'',TRIM('xxx'+TRIM(s[4..LENGTH(s)-1])+'P'),''),
  'VIN'=>MAP(
              s=''=>'',
			  length(TRIM(s))<17 => s[1..3]+(string)hash(s)[1..6],// OLD_not valid VIN,first digits rep country of origin
			  s[1..11]+(string)hash(s[12..17])[1..6] // std format VIN
			  
              ),
  'PLATE'=>if(s<> '',scr_plate(s[1..6]),''),
  'SCR_SECOND'=>if(s<> '',scr_AlphaNum(s,2),''),
  'SCR_FIRST'=>if(s<> '',scr_AlphaNum(s,1),''),
  'ZIP5'=> if((integer)s <>0, intformat((integer)s*198771%100000,5,1),''),
   'bad scramblepii call');
   

END;


//export fn_scrambler_pii := 'todo';