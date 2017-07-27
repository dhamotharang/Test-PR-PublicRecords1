import doxie;
export get_bdids(STRING t, set of STRING1 get_skip_set=[],boolean isBareAddr, boolean workHard = true,boolean nofail=true) := 
FUNCTION

mod := 
	autokeyb.mod_get_bdids(
	t, 
	get_skip_set, 
	isBareAddr,
	workHard, 
	nofail);
	
rec := doxie.Layout_ref_bdid;
	
return if(mod.did_fail, 
				  fail(rec, mod.the_failure, doxie.ErrorCodes(mod.the_failure)),
					project(mod.result, rec));


END;


