input_lay := BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input;
export RT_Rollup(dataset(input_lay) in_ds, unsigned8 maxResults) := function
  flat_out := BatchServices.Layouts.RTPhones.rec_output_internal;
	
	input_lay rollrequest(input_lay l, input_lay r) := transform
		self.results := l.results & r.results;
		self := l;
	end;	


	input_lay sort_results(input_lay l) := transform
	// dedup exact matches other than the responsestatus and seq but make sure we keep the best response status, keep the A's
  		self.results := choosen(sort(dedup(sort(l.results,name,address,phone,-dt_last_seen,-dt_first_seen,did,responsestatus)
																		,except responsestatus, seq )
																,responsestatus,- (if(responsestatus='a', line_type,'')),-dt_last_seen,-dt_first_seen,record), maxResults);
	  	self.resultcount := count(self.results);
		  self := l;
	end;

	out_ds := rollup(sort(in_dS,acctno,requeststatus), left.acctno = right.acctno, rollrequest(left,right));
	sort_ds := project(out_ds,sort_results(left));
	return sort_ds;
END;
