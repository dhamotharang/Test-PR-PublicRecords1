import _Control, did_add, std, risk_indicators;

// if for some reason the environment variable isn't there (like when you're not running this function on a roxie which has package files, use today's date)
EXPORT get_Build_Date(string variable_name) := function
	// when running on Vault thor, we want to use the build dates on production roxie when comparing results to production roxie
	sDefault := 'Default';
	fetched_date := if(_control.Environment.OnVault, did_add.get_EnvVariable(variable_name, 'http://fcrabatch.sc.seisint.com:9876'), sDefault);
	todays_date := (STRING8)Std.Date.Today();
	today := if(fetched_date in ['',sDefault], todays_date, fetched_date);
	
	env_variable := thorlib.getenv(variable_name,today)[1..8];
	
	return env_variable;
	
end;