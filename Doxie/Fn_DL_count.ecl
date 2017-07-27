import doxie_ln,doxie_raw;

export Fn_DL_count(
	unsigned6 DID_value,
	unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
	boolean ln_branded_value = false,
	boolean probation_override_value = false) := 
FUNCTION

	dids := dataset([{did_value}],doxie.layout_references);
	
	r := doxie_raw.DL_Raw(
		dids,
		dateVal,
		dppa_purpose,
		glb_purpose,
		ln_branded_value);
	
	return count(r);

END;