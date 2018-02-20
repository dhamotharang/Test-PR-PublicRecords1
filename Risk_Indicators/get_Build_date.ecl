import ut, _Control, did_add, std;

// if for some reason the environment variable isn't there (like when you're not running this function on a roxie which has package files, use today's date)
EXPORT get_Build_Date(string variable_name) := function
	today := (STRING8)Std.Date.Today();
	env_variable := thorlib.getenv(variable_name,today)[1..8];
	
	return env_variable;
	
/*
	// this is too slow to make this many soapcalls to simply get a few build dates.  if we are on dev roxie or thor, simply use today's date

	valid_roxie := trim(thorlib.getenv('Environment','')) in ['QA', 'Prod'];
	roxie := if(isfcra, _Control.RoxieEnv.prod_batch_fcra, _Control.RoxieEnv.prod_batch_neutral);	
	// check first if soapcall is even needed.  don't need to make a soapcall if you are running on a valid roxie
	soapcall_result := if(~valid_roxie, did_add.get_EnvVariable(variable_name, roxie), '');
	env_variable_soap := if(soapcall_result in ['','Default'], today, soapcall_result)[1..8];
	
	return if(valid_roxie, env_variable, env_variable_soap);
*/
end;