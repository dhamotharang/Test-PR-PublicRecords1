import address;
EXPORT fn_valid_caddress (string s, string src):= function

  tokn := '|';
	prim_range     := s[1..StringLib.StringFind(s, tokn, 1) -1] ;
	predir         := s[StringLib.StringFind(s, tokn, 1)+1..StringLib.StringFind(s, tokn, 2) -1] ;  
	prim_name      := s[StringLib.StringFind(s, tokn, 2)+1..StringLib.StringFind(s, tokn, 3) -1] ;
	addr_suffix    := s[StringLib.StringFind(s, tokn, 3)+1..StringLib.StringFind(s, tokn, 4) -1] ;
	postdir        := s[StringLib.StringFind(s, tokn, 4)+1..StringLib.StringFind(s, tokn, 5) -1] ;
	unit_desig     := s[StringLib.StringFind(s, tokn, 5)+1..StringLib.StringFind(s, tokn, 6) -1] ;
	sec_range      := s[StringLib.StringFind(s, tokn, 6)+1..StringLib.StringFind(s, tokn, 7) -1] ;
	city_name    := s[StringLib.StringFind(s, tokn, 7)+1..StringLib.StringFind(s, tokn, 8) -1] ;
	st             := s[StringLib.StringFind(s, tokn, 8)+1..StringLib.StringFind(s, tokn, 9) -1] ;
	zip5           := s[StringLib.StringFind(s, tokn, 9)+1..StringLib.StringFind(s, tokn, 10) -1] ;
	zip4           := s[StringLib.StringFind(s, tokn, 10)+1..length(s)];

is_clean := length(trim(s))>3 and
						(address.AddressQuality(prim_range,prim_name,addr_suffix,sec_range,city_name,zip5, zip4)=0 or
						zip4 <> '' or
						zip5 <> '');
						
return is_clean;
 end;