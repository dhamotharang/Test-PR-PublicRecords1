import _Control, FCRA;
onThor := _Control.Environment.OnThor;

k_assessor(boolean isFCRA = false)	:= LN_PropertyV2_Services.keys_2.assessor(isFCRA);

l_sid				:= LN_PropertyV2_Services.layouts.search_fid;
l_raw				:= LN_PropertyV2_Services.layouts.assess.raw_source;

max_raw			:= LN_PropertyV2_Services.consts.max_raw;

export dataset(l_raw) fn_get_assessments_raw_2(
  dataset(l_sid) in_sids,
	boolean isFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	LN_PropertyV2_Services.interfaces.Iinput_report in_mod
) := function

  flags := flagfile(file_id=FCRA.FILE_ID.ASSESSMENT); // prefilter in advance

	// join inputs to index to get raw data
	ds_raw0_roxie := join( // ..................................this join is costly (7)
		in_sids, k_assessor(isFCRA),
	  keyed(left.ln_fares_id = right.ln_fares_id)
		and ~((string)right.ln_fares_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA),
		transform(l_raw,self:=left,self:=right,self:=[]),
		atmost(max_raw)
	);
	
	ds_raw0_thor := join( // ..................................this join is costly (7)
		distribute(in_sids, hash64(ln_fares_id)), 
		distribute(pull(k_assessor(isFCRA)), hash64(ln_fares_id)),
	  left.ln_fares_id = right.ln_fares_id
		and ~((string)right.ln_fares_id in set(flags((unsigned6)did=left.search_did ),record_id) and isFCRA),
		transform(l_raw,self:=left,self:=right,self:=[]),
		atmost(left.ln_fares_id = right.ln_fares_id, max_raw),
		local
	);
	
	#IF(onThor)
    ds_raw0 := ds_raw0_thor;
  #ELSE
    ds_raw0 := ds_raw0_roxie;
  #END
  
  assess_over_roxie := join(flags, FCRA.key_override_property.assessment,
											keyed(left.flag_file_id = right.flag_file_id) and isFCRA,
											transform(l_raw,self.search_did := (unsigned6)left.did,self:=right,self:=[]));
                      
  assess_over_thor := join(distribute(flags, hash64(flag_file_id)), 
                      distribute(pull(FCRA.key_override_property.assessment), hash64(flag_file_id)),
											(left.flag_file_id = right.flag_file_id) and isFCRA,
											transform(l_raw,self.search_did := (unsigned6)left.did,self:=right,self:=[]), LOCAL);

  #IF(onThor)
    assess_over := assess_over_thor;
  #ELSE
    assess_over := assess_over_roxie;
  #END

	ds_raw1 := ds_raw0 + join(in_sids,assess_over,left.ln_fares_id= right.ln_fares_id,transform(l_raw,self:=right,self:=left));										
	
	results := if(isFCRA, ds_raw1, ds_raw0);
	
	// removed the addl fares join and the legal data join, we don't need that in the shell

	return results;
end;