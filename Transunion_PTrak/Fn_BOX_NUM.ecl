import Address; 
export Fn_BOX_NUM := Module

export  StrIndexPob( string addr) := FUNCTION 
r1 :=  map(StringLib.StringFind(addr,'PO BOX',1)>0 => StringLib.StringFind(addr,'PO BOX',1)+6 , 
           StringLib.StringFind(addr,'POB ',1)>0 => StringLib.StringFind(addr,'POB ',1)+4,
           StringLib.StringFind(addr,'P O B',1)>0 => StringLib.StringFind(addr,'P O B',1)+5,
		   0);
return r1; 
END;

export  StrIndexRR( string addr) := FUNCTION 
r1 :=  map(StringLib.StringFind(addr,'RURAL ROUTE',1)>0 => StringLib.StringFind(addr,'RURAL ROUTE',1)+11 , 
           StringLib.StringFind(addr,'RR ',1)>0 => StringLib.StringFind(addr,'RR ',1)+3,
           0);
return r1; 
END;

export  StrIndexRRBOX( string addr) := FUNCTION 
r1 :=  map(StringLib.StringFind(addr,' BOX',1)>0 => StringLib.StringFind(addr,' BOX',1)+4 , 
           0);
return r1; 
END;

export  fn_missing_addr_clean( string addr1,string addr2,string city, string state, string zip) := FUNCTION

r1 :=  Address.CleanAddress182(addr1+' '+addr2, city+' '+state+' ' +zip); 
return r1; 
END;

END; 