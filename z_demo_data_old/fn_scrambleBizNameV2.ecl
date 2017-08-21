import ut;
//---------------  Useful FUNCTIONS -----
getName(String S):= FUNCTION
pat:='^([A-Za-z\\-]+)\\s([A-Za-z\\-]+\\s)?([A-Za-z\\-]+\\s)?';
firstword:=REGEXFIND(pat,s+' ',1);// need to add the blank at the end of string for pattern match to work!
secondword:=REGEXFIND(pat,s+' ',2);

noiseword:=['A','THE'];
return if(TRIM(firstword) in noiseword, secondword,firstword);
END;

soundex(String Str):=FUNCTION

return MetaPhoneLib.DMetaphone1(Str);
END;
//--------------------------------------------------------
//
export fn_scrambleBizNameV2(string str)  := FUNCTION
//Strip Input string of all punctuation 
punct:='[\\.,\\:]|THE\\s|\\sOF\\s|AND|\\s[A-z]\\s';
strUpperCase:=StringLib.StringToUpperCase(str);
s:=REGEXREPLACE(punct,strUpperCase,' ');
//
indic := datalib.companyclean(s)[1..40];
sec  := datalib.companyclean(s)[41..80];
furn  := datalib.companyclean(s)[81..120];
//-- Check if the above managed to get noise(furniture) words
pat:='^([A-Za-z\\-]+)\\s([A-Za-z\\-]+\\s)?([A-Za-z\\-]+\\s)?';
nametohash:=
if (TRIM(sec) <> '' and TRIM(furn) <> '',indic,
    getName(s)); 
   
//
// OUTPUT('HashedName='+nametohash+'; Sec/Furn='+sec+'/'+furn);  // Debug code
ix:= HASH(soundex(nametohash));
//output(IX);
ix1:=((INTEGER2)(STRING)IX[1..2] % 61) +1 ;
ix2:=((INTEGER2)(STRING)IX[3..4] % 21) +1 ;

suffix:=CHOOSE(ix2,'SON','ER','ARZI','ERO','ART','UR','IN',
        'ETTA','WALL','ALI','STON','ANA','AIMS','ONEN','MILLE','OST','OVA',
				'ARNI','MORE','OSHI','MAN','');

lastName := CHOOSE(ix1,
'VALEN',
'KORN',
'JEB',
'BLAIR',
'BENN',
'CORD',
'RAXELL',
'STUL',
'JON',
'RAMIR',
'HOLKIM',
'ZAM',
'WALD',
'DOM',
'JOHAN',
'BORD',
'COHN',
'CRIM',
'TELL',
'ZELL',
'DONN',
'ALEX',
'NORD',
'GOLD',
'PERS',
'WOOD',
'ROZ',
'JOS',
'UKAL',
'SAMUEL',
'PAUL',
'PETER',
'IVAN',
'TEMUR',
'YUL',
'ARD',
'CLINT',
'GREEN',
'HART',
'SARD',
'DES',
'CARR',
'GAGLE',
'BALE',
'LED',
'RED',
'TAR',
'GER',
'HILL',
'DAR',
'GARB',
'KIM',
'LOND',
'PAR',
'BERL',
'AMST',
'KIRK',
'KRIST',
'TED',
'POP',
'GOLD'
);

tailwords:=if((TRIM(SEC)+'/'+TRIM(FURN)) <> '/',
       TRIM(sec)+' '+TRIM(FURN),
	   REGEXFIND(pat,TRIM(s)+' ',2));

return if(str<>'',REGEXREPLACE(PUNCT,TRIM(lastName)+TRIM(suffix)+' '+
TRIM(tailwords),' '),'');
END;