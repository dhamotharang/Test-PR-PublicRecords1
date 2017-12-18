import data_services;

numrec := record
	layout_it1oit1i;
	string3	prodnum;
end;

numrec into_num(layout_it1oit1i L, string3 p) := transform
	self.prodnum := p;
	self := L;
end;

df := project(file_seed93, into_num(LEFT,'050'));
	 
export key_it1oit1i := index(df,{prodnum, social},
	{account_out,
	riskwiseid,
	bansmatchflag,
	banscasenum,
	bansprcode,
	bansdispcode,
	bansdatefiled,
	bansfirst,
	bansmiddle,
	banslast,
	banscnty,
	bansecoaflag,
	decsflag,
	decsdob,
	decszip,
	decszip2,
	decslast,
	decsfirst,
	decsdod,
	inputaddrcharflag,
	inputsocscharflag,
	socsstatusflag,
	correctsocs,
	phonestatusflag,
	phone,
	altareacode,
	splitdate,
	internalcode,
	phonestatusflag2,
	phone2,
	altareacode2,
	splitdate2,
	internalcode2,
	phonestatusflag3,
	phone3,
	altareacode3,
	splitdate3,
	internalcode3,
	addrstatusflag,
	addrcharflag,
	first_out,
	last_out,
	addr_out,
	city_out,
	state_out,
	zip_out,
	internalcode4,
	addrstatusflag2,
	addrcharflag2,
	first2,
	last2,
	addr2,
	city2,
	state2,
	zip2,
	internalcode5,
	addrstatusflag3,
	addrcharflag3,
	first3,
	last3,
	addr3,
	city3,
	state3,
	zip3,
	internalcode6,
	hownstatusflag,
	estincome,
	score,
	score2,
	score3
	}
	, data_services.data_location.prefix() + 'thor_Data400::key::seed::qa::it1oit1i');
