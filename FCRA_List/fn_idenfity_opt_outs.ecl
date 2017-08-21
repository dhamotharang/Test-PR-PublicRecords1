import watchdog,ut,fcra_opt_out,fcra_list,std, riskwise;
export fn_idenfity_opt_outs(dataset(recordof(watchdog.Layout_Best)) indata) := function

// only consider a matching record a true hit if the following criteria are met
// otherwise act as the record didn't match at all
valid_hit(string1 opt_back_in, string1 permanent_flag, string8 date_yyyymmdd) := function
	today := (STRING8)Std.Date.Today();
	hit := opt_back_in='N' and
				 ( permanent_flag='Y' or (permanent_flag='N' and ut.DaysApart(today,date_yyyymmdd) < ut.DaysInNYears(5)) );
	return hit;				
end;


// search by did, and if a match found, flag it
didkey := join(indata, fcra_opt_out.key_did,
					left.did!=0 and 
					keyed(left.did = right.l_DID),
				  transform(FCRA_List.layout_optout.base,  
										self.opt_out_hit:= right.l_did<>0 and valid_hit(right.opt_back_in, right.permanent_flag, right.date_yyyymmdd);
										self.optout_date := (integer4)if(self.opt_out_hit, (STRING8)Std.Date.Today(), ''),
										self := left),
					left outer, atmost(riskwise.max_atmost), keep(1));
					
return didkey;

end;