import data_services;

numrec := record
	layout_fa2onafi;
	string3	prodnum;	
end;

numrec into_num(layout_fa2onafi L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_Seed97, into_num(LEFT, '001')) +
		project(file_Seed99, into_num(LEFT, '002')) ;


export Key_fa2onafi := index (df,{prodnum, social},{	
	 account_out,
     riskwiseid,
     decsflag,
     socsvalflag,
     socllowissue,
     soclhighissue,
     soclstate,
     dob,
     dod,
     coaaddr,
     coacity,
     coastate,
     coazip,
     first,
     last,
     addr,
     city,
     state,
     zip,
     formerfirst,
     formerlast,
     internalcode,
     first2,
     last2,
     addr2,
     city2,
     state2,
     zip2,
     formerfirst2,
     formerlast2,
     internalcode2,
     first3,
     last3,
     addr3,
     city3,
     state3,
     zip3,
     formerfirst3,
     formerlast3,
     internalcode3,
     first4,
     last4,
     addr4,
     city4,
     state4,
     zip4,
     formerfirst4,
     formerlast4,
     internalcode4,
     first5,
     last5,
     addr5,
     city5,
     state5,
     zip5,
     formerfirst5,
     formerlast5,
     internalcode5,
     hphone }, data_services.data_location.prefix() +'thor_data400::key::seed::qa::fa2onafi');
