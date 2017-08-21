export string70 fn_genStreetName(string str):= FUNCTION

suffix:=['A','ES','OV','SON','ER','ARZI','ERO','ART','UR','IN',
        'ETTA','WALL','ALI','STON','ANA','AIMA','ONEN','ILLE','OST','OVA',
				'AY','US','WARE',' VAN HESS'];

street:= ['STREET','CIRCLE', 'AVENUE', 'BLVD','LANE','CT','HWY','RD'];

prefix:=[
   'ALEN'
  ,'ARN' 
  ,'ABRA' 
  ,'ACR' 
  ,'BAIN' 
  ,'CORD' 
  ,'RASELL' 
  ,'STAHL' 
  ,'JON' 
  ,'RAMIR' 
   ,'CHORZAIM' 
   ,'ZAM' 
   ,'ELWOOD' 
   ,'DOM' 
   ,'JOHAN' 
   ,'BORD' 
   ,'COHN' 
   ,'ALI' 
   ,'TELL' 
   ,'ZELL' 
   ,'DONN' 
   ,'ALEX' 
   ,'NORD' 
   ,'OKAZ' 
   ,'PERS' 
   ,'QIR' 
   ,'ROZ' 
   ,'JOS' 
   ,'ULAK' 
   ,'SAMUEL' 
   ,'PAUL' 
   ,'PETER' 
   ,'IVAN' 
   ,'TEMUR' 
   ,'YUL' 
   ,'AUG' 
   ,'CLINT' 
   ,'GREEN' 

   ,'HART' 
   ,'SARD' 
   ,'DES' 
   ,'CARR' 
   ,'GAGLE' 
   ,'BALE' 
   ,'LED' 
   ,'RED' 
   ,'TAR' 
   ,'GER' 

   ,'HILL' 
   ,'DAR' 
   ,'GARB' 
   ,'KIM' 
   ,'LOND' 
   ,'PAR' 
   ,'BERL' 
   ,'AMST' 
   ,'KIRK' 
   ,'KRIST' 
   ,'TED' 
   ,'POP' 
   ,'GOLD'
];
// we need to add more here.. to gen a     ?
street_pattern := '([0-9]+)\\s+([A-Za-z]+)\\s+([A-Za-z]+)';
nbr:=regexfind(street_pattern,str,1);
word1:=regexfind(street_pattern,str,2);
//output(suffix[3]);
hash_in  := (string12)hash(word1);
i1:=(integer2)hash_in[1..2]%60+ 1;
i2:=(integer2)hash_in[3..4]%23 + 1;
i3:=(integer1)hash_in[6..6]%7 + 1;
//output(hash_in);
//output(suffix[i2]);
return if(str[1..2] <> '  ', nbr+' '+prefix[i1]+suffix[i2]+' '+street[i3],'');

END;
