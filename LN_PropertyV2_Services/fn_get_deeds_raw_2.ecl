import _Control, fcra;
onThor := _Control.Environment.OnThor;

k_deed(boolean isFCRA=false)	:= LN_PropertyV2_Services.keys_2.deed(isFCRA);
k_fares	:= LN_PropertyV2_Services.keys_2.addl_fares_d;

l_sid		:= LN_PropertyV2_Services.layouts.search_fid;
l_raw		:= LN_PropertyV2_Services.layouts.deeds.raw_source;

max_raw	:= LN_PropertyV2_Services.consts.max_raw;

export dataset(l_raw) fn_get_deeds_raw_2(
  dataset(l_sid) in_sids,
	boolean isFCRA = false,
	dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	LN_PropertyV2_Services.interfaces.Iinput_report in_mod
) := function

  flags := flagfile (file_id=FCRA.FILE_ID.DEED); // prefilter in advance

	// join inputs to index to get raw data
	ds_raw0_roxie := 
		join( // this join is costly (3)
			in_sids, k_deed(isFCRA),
			keyed(left.ln_fares_id = right.ln_fares_id)
			and ~((string)right.ln_fares_id in set( flags( (unsigned6)did=left.search_did), record_id) and isFCRA),
			transform(l_raw,self:=left,self:=right,self:=[]),
			atmost(max_raw)
		);

	ds_raw0_thor := 
		join( 
			distribute(in_sids, hash64(ln_fares_id)),
			distribute(pull(k_deed(isFCRA)), hash64(ln_fares_id)),
			left.ln_fares_id = right.ln_fares_id
			and ~((string)right.ln_fares_id in set( flags( (unsigned6)did=left.search_did), record_id) and isFCRA),
			transform(l_raw,self:=left,self:=right,self:=[]),
			atmost(left.ln_fares_id = right.ln_fares_id, max_raw),
			local
		);
    
	#IF(onThor)
    ds_raw0 := ds_raw0_thor;
  #ELSE
    ds_raw0 := ds_raw0_roxie;
  #END
  
	deed_over_roxie := join(flags, FCRA.key_override_property.deed,
										keyed(left.flag_file_id = right.flag_file_id),
											transform(l_raw,self.search_did := (unsigned6)left.did,self:=right,self:=[]));

	deed_over_thor := join(distribute(flags, hash64(flag_file_id)), 
                    distribute(pull(FCRA.key_override_property.deed), hash64(flag_file_id)),
										(left.flag_file_id = right.flag_file_id),
											transform(l_raw,self.search_did := (unsigned6)left.did,self:=right,self:=[]), LOCAL);

  #IF(onThor)
     deed_over := deed_over_thor;
  #ELSE
     deed_over := deed_over_roxie;
  #END
    
  ds_raw1 := ds_raw0 + join(in_sids, deed_over,left.ln_fares_id = right.ln_fares_id 
												and left.search_did = right.search_did,  
												transform(l_raw,self:=right),keep(1),limit(0));
	
	// removed the extra searching for addl_fares data (LN_PropertyV2_Services.keys_2.addl_fares_d), that info isn't used in the shell
	
	// ds_raw2 := if(isFCRA, ds_raw1, ds_raw0);
	
	ds_raw1_nonFCRA :=
		join(  // this join is costly (4)
			ds_raw0, k_fares,
			keyed(left.ln_fares_id = right.ln_fares_id),
			transform(l_raw, self.ln_fares_id := left.ln_fares_id, self := right, self := left),
			atmost(max_raw),
			left outer

		);
	
	// ds_raw2 := if( isFCRA, ds_raw1, ds_raw1_nonFCRA );
	ds_raw2 := map( isFCRA => ds_raw1,
									onThor => ds_raw0,
									ds_raw1_nonFCRA );
	
	results := project(ds_raw2, transform(l_raw,self.sortby_date := LN_PropertyV2_Services.Raw_2(in_mod.lookupVal, in_mod.partyType, in_mod.faresID).deed_recency_raw(left); self:=left));

	return results;
end;