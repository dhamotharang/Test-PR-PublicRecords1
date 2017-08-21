import ut;
//---------------  Useful FUNCTIONS -----
soundex(String Str):=FUNCTION
return MetaPhoneLib.DMetaphone1(Str);
END;
//--------------------------------------------------------
//
export fn_scrambleLastName(string str)  := FUNCTION
//Strip Input string of all punctuation 
punct:='[\\.,\\:]';
strUpperCase:=StringLib.StringToUpperCase(str);
s:=REGEXREPLACE(punct,strUpperCase,' ');

   
//
// OUTPUT('HashedName='+nametohash+'; Sec/Furn='+sec+'/'+furn);  // Debug code
ix:= HASH(soundex(s));
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

/*
tailwords:=if((TRIM(SEC)+'/'+TRIM(FURN)) <> '/',
       TRIM(sec)+' '+TRIM(FURN),
	   REGEXFIND(pat,TRIM(s)+' ',2));
	   */

return if(str<>'',TRIM(lastName)+TRIM(suffix),'');
END;