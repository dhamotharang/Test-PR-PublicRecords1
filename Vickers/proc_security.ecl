EXPORT proc_security(string filedate) := module



d_SecExchange := sort( distribute( Vickers.Files_raw.security, hash(exchange_code[1..5] )),exchange_code[1..5],local);

dCodeLookupExch := File_Code_Lookup(code_type = 'exchangeCode' and code <> '');
												 
//************Join lookup files with Infile													 

//FormType Join
												 
Layout_Insider_Security_In exchcodetype ( d_SecExchange l , dCodeLookupExch r ) := transform
								 
self.exchange_code_desc	:= r.code_desc;
self.exchange_code_alpha	:= r.code_alpha;
self.exchange_code_desc2	:= r.code_desc2;
self := l;
self := [];
end;

 
dJoin_1 := Join ( d_SecExchange , dCodeLookupExch,
                           left.exchange_code[1..5] = right.code,
													 exchcodetype(left,right),
													 left outer,lookup);
													 


d_SecType := sort( distribute( dJoin_1, hash(sec_type[1..5] )),sec_type[1..5],local);

dCodeLookupSectype := File_Code_Lookup(code_type = 'secType' and code <> '');
												 
//************Join lookup files with Infile													 

//SecType Join
												 
Layout_Insider_Security_In seccodetype ( d_SecType l , dCodeLookupSectype r ) := transform
								 
self.sec_type_desc	:= r.code_desc;
self.sec_type_alpha	:= r.code_alpha;
self := l;
self := [];
end;

 
dJoin_2 := Join ( d_SecType , dCodeLookupSectype,
                           left.sec_type[1..5] = right.code,
													 seccodetype(left,right),
													 left outer,lookup);



d_ForignCode := sort( distribute( dJoin_2, hash(foreign_code[1..5] )),foreign_code[1..5],local);

dCodeLookupFgntype := File_Code_Lookup(code_type = 'foreignCode' and code <> '');
												 
//************Join lookup files with Infile													 

//SecType Join
												 
Layout_Insider_Security_In fgncodetype ( d_ForignCode l , dCodeLookupFgntype r ) := transform
								 
self.foreign_code_desc		:= r.code_desc;
self.foreign_code_alpha	:= r.code_alpha;
self := l;
self := [];
end;

 
dJoin_3 := Join ( d_ForignCode , dCodeLookupFgntype,
                           left.foreign_code[1..5] = right.code,
													 fgncodetype(left,right),
													 left outer,lookup);
			
			
d_SICCode := sort( distribute( dJoin_3, hash(sic_code[1..5] )),sic_code[1..5],local);

dCodeLookupsictype := File_Code_Lookup(code_type = 'sicCode' and code <> '');
												 
//************Join lookup files with Infile													 

//SecType Join
												 
Layout_Insider_Security_In siccodetype ( d_SICCode l , dCodeLookupsictype r ) := transform
								 
self.sic_code_desc		:= r.code_desc;
self.sic_code_alpha	:= r.code_alpha;
self.sic_code_desc2	:= r.code_desc2;

self := l;
self := [];
end;

 
dJoin_4 := Join ( d_SICCode , dCodeLookupsictype,
                           left.sic_code[1..5] = right.code,
													 siccodetype(left,right),
													 left outer,lookup);
													 

d_ActiveCode := sort( distribute( dJoin_4, hash(active_code[1..5] )),active_code[1..5],local);

dCodeLookupactivetype := File_Code_Lookup(code_type = 'activeCode' and code <> '');
												 

Layout_Insider_Security_In actcodetype ( d_ActiveCode l , dCodeLookupactivetype r ) := transform
								 
self.active_code_desc		:= r.code_desc;
self.active_code_alpha	:= r.code_alpha;
self.active_code_desc2	:= r.code_desc2;

self := l;
self := [];
end;

 
dJoin_5 := Join ( d_ActiveCode , dCodeLookupactivetype,
                           left.active_code[1..5] = right.code,
													 actcodetype(left,right),
													 left outer,lookup);
													 
													 
build_insider_security := Sequential(fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::insider_security'),
                                     output(dJoin_5,,'~thor_data400::in::vickers::'+filedate+'::insider_security_in',overwrite)
												            );

transac_insider_security := sequential(fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::delete::insider_security','~thor_data400::in::vickers::sprayed::grandfather::insider_security',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::grandfather::insider_security'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::grandfather::insider_security','~thor_data400::in::vickers::sprayed::father::insider_security',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::father::insider_security'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::father::insider_security','~thor_data400::in::vickers::sprayed::insider_security',,true),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::insider_security'),
								fileservices.addsuperfile('~thor_data400::in::vickers::sprayed::insider_security','~thor_data400::in::vickers::'+filedate+'::insider_security_in'),
								fileservices.clearsuperfile('~thor_data400::in::vickers::sprayed::delete::insider_security',true)
								);

export dSecurityFinal := Sequential( build_insider_security, transac_insider_security);

end;
