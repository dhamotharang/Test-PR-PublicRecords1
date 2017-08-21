export proc_build_all(string pversion) :=
function

	base		:= domains.Make_Whois_Base						: success(output('Base file created successfully'));
	keys		:= domains.Make_Keys(pversion) 					: success(output('Keys created successfully'));
	autokeys	:= Domains.proc_domains_autokeybuild(pversion)	: success(output('AutoKeys created successfully'));	
	out			:= domains.Make_Whois_Out						: success(output('Out file created successfully'));

	return sequential(base, keys, autokeys, out, out_population_stats.all);

end;