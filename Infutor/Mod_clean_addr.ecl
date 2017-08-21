export Mod_clean_addr := Module

export  StrIndex( string addr) := FUNCTION 
r1 :=  map(StringLib.StringFind(addr,'PO BOX',1)>0 => StringLib.StringFind(addr,'PO BOX',1) , 
           StringLib.StringFind(addr,' POB',1)>0 => StringLib.StringFind(addr,' POB',1),
           StringLib.StringFind(addr,'P O B',1)>0 => StringLib.StringFind(addr,'P O B',1),
		   0);
return r1; 
END;

export  StrIndexdir( string addr) := FUNCTION 
r1 :=  map(StringLib.StringFind(addr,' SW',1)>0 => StringLib.StringFind(addr,' SW',1),
		   StringLib.StringFind(addr,' NW',1)>0 => StringLib.StringFind(addr,' NW',1),
           StringLib.StringFind(addr,' SE',1)>0 => StringLib.StringFind(addr,' SE',1) , 
           StringLib.StringFind(addr,' NE',1)>0 => StringLib.StringFind(addr,' NE',1),
           		   0);
return r1; 
END;

export  StrcleanPOB( string addr) := FUNCTION 

r1 :=  map(StringLib.StringFind(addr,'PO BOX RD' ,1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX RD' ,1)-1]+' '+'RD', 
StringLib.StringFind(addr,'PO BOX DR' ,1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX DR' ,1)-1]+' '+'DR',
StringLib.StringFind(addr,'PO BOX ST',1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX ST' ,1)-1]+' '+'ST',
StringLib.StringFind(addr,'PO BOX LN' ,1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX LN' ,1)-1]+' '+'LN',
StringLib.StringFind(addr,'PO BOX AVE',1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX AVE' ,1)-1]+' '+'AVE',
StringLib.StringFind(addr,'PO BOX RT',1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX RT' ,1)-1]+' '+'RT',
StringLib.StringFind(addr,'PO BOX BLVD',1)>0 => addr[1..StringLib.StringFind(addr,'PO BOX BLVD' ,1)-1]+' '+'BLVD',
StringLib.StringFind(addr,'POB DR' ,1)>0 => addr[1..StringLib.StringFind(addr,'POB DR' ,1)-1]+' '+'DR',
StringLib.StringFind(addr,'POB RD' ,1)>0 => addr[1..StringLib.StringFind(addr,'POB RD' ,1)-1]+' '+'RD',
StringLib.StringFind(addr,'POB AVE',1)>0 => addr[1..StringLib.StringFind(addr,'POB AVE' ,1)-1]+' '+'AVE',
StringLib.StringFind(addr,'POB ST' ,1)>0 => addr[1..StringLib.StringFind(addr,'POB ST' ,1)-1]+' '+'ST',
StringLib.StringFind(addr,'POB LN',1)>0 => addr[1..StringLib.StringFind(addr,'POB LN' ,1)-1]+' '+'LN',
StringLib.StringFind(addr,'POB RT',1)>0 => addr[1..StringLib.StringFind(addr,'POB RT' ,1)-1]+' '+'RT',
StringLib.StringFind(addr,'POB BLVD',1)>0 => addr[1..StringLib.StringFind(addr,'POB BLVD' ,1)-1]+' '+'BLVD',
StringLib.StringFind(addr,'P O BOX CT',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX CT' ,1)-1]+' '+'CT',
StringLib.StringFind(addr,'P O BOX ST',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX ST' ,1)-1]+' '+'ST',
StringLib.StringFind(addr,'P O BOX RD',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX RD' ,1)-1]+' '+'RD',
StringLib.StringFind(addr,'P O BOX DR',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX DR' ,1)-1]+' '+'DR',
StringLib.StringFind(addr,'P O BOX LN',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX LN' ,1)-1]+' '+'LN',
StringLib.StringFind(addr,'P O BOX RT',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX RT' ,1)-1]+' '+'RT',
StringLib.StringFind(addr,'P O BOX AVE',1)>0 => addr[1..StringLib.StringFind(addr,'P O BOX AVE' ,1)-1]+' '+'AVE',
 addr); 

return r1; 
END;

export  blankjunk( string addr) := FUNCTION  

r1 := map( trim(addr,left,right) = 'PO BOX 0'   => '',
           trim(addr,left,right) = 'P O POB'    => '',
           trim(addr,left,right) = 'POB PO BOX' => '',
           trim(addr,left,right) = 'BOX PO BOX' => '',
           trim(addr,left,right) = 'XXX XX'     => '',
           trim(addr,left,right) = 'PO BOX'     => '',
           trim(addr,left,right) = 'X PO BOX'   => '',addr);
r2 := IF(REGEXFIND('NONE|REFUSED|NOSTREET|VERIFY|NONE GIVEN|ID RATHER NOT|NOWHERE|SSS|ANYWHERE',r1),'',r1);

return r2; 
END;

END;