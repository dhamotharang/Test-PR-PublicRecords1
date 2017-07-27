import doxie;

export get_dids(
	STRING t, 
	set of STRING1 get_skip_set=[], 
	boolean workHard = true, 
	boolean nofail=true,
	boolean useAllLookups = false) := 
FUNCTION
	
mod := 
	autokey.mod_get_dids(
	t, 
	get_skip_set, 
	workHard, 
	nofail,
	useAllLookups);
	
rec := doxie.layout_references;
	
return if(mod.did_fail, 
				  fail(rec, mod.the_failure, doxie.ErrorCodes(mod.the_failure)),
					project(mod.result, rec));
	
END;


