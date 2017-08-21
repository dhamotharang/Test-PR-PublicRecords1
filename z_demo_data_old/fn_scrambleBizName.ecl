/* THIS FUNCTION HAS A NEW VERSION--
we are pointing to new function just in case we miss attributes where this is called .. JAYANT
*/

export fn_scrambleBizName(string s)  := FUNCTION
return fn_scrambleBizNameV2(s);
END;

/*
import ut;
getName(String S):= FUNCTION
pat:='^([A-Za-z]+)\\s([A-Za-z]+\\s)?([A-Za-z]+\\s)?';
firstword:=REGEXFIND(pat,s+' ',1);// need to add the blank at the end of string for pattern match to work!
secondword:=REGEXFIND(pat,s+' ',2);
noiseword:=['A','THE'];
return if(TRIM(firstword) in noiseword, secondword,firstword);
END;

export fn_scrambleBizName(string s)  := FUNCTION
indic := datalib.companyclean(s)[1..40];
sec  := datalib.companyclean(s)[41..80];
furn  := datalib.companyclean(s)[81..120];
//-- Check if the above managed to get noise(furniture) words
pat:='^([A-Za-z]+)\\s([A-Za-z]+\\s)?([A-Za-z]+\\s)?';
nametohash:=
if (TRIM(sec) <> '' and TRIM(furn) <> '',indic,
    getName(s)); 
   
//
ix:= HASH(nametohash);
//output(IX);
ix1:=((INTEGER2)(STRING)IX[1..2] % 61) +1 ;
ix2:=((INTEGER2)(STRING)IX[3..4] % 21) +1;

suffix:=CHOOSE(ix2,'SON','ER','ARZI','ERO','ART','UR','IN',
        'ETTA','WALLAH','ALI','STON','ANA','AIMA','ONEN','ILLE','OST','OVA',
				'ARNI','EZZI','OSHI','MAN','');

lastName := CHOOSE(ix1,
'VALEN',
'KORN',
'MCJOHN',
'BLAIR',
'MCBAIN',
'CORD',
'RAXELL',
'STUL',
'JON',
'RAMIR',
'HOLKIM',
'ZAM',
'ELWOOD',
'DOM',
'JOHAN',
'BORD',
'COHN',
'ALI',
'TELL',
'ZELL',
'DONN',
'ALEX',
'NORD',
'OKAZ',
'PERS',
'QIR',
'ROZ',
'JOS',
'ULAK',
'SAMUEL',
'PAUL',
'PETER',
'IVAN',
'TEMUR',
'YUL',
'AUG',
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


return TRIM(lastName)+TRIM(suffix)+' '+
IF(TRIM(sec) <> '', TRIM(sec),
REGEXFIND(pat,s+' ',2))+' '+ TRIM(furn);
END;
*/