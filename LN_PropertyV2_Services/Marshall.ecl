// Property is a behemoth.  The data files are very large, and there's
// a LOT of fields that need to be decoded before being output.  We hope
// to see a performance improvement by running "marshalling" logic early
// in the processing rather than right at the end, which means we'll run
// fewer records through the remaining code.


// The marshalling code is called from LN_PropertyV2_Services.fn_get_report
// but is only active when two things are added to the service macro...
//
// #CONSTANT('usePropMarshall', true);
// LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw,cooked);
//
// The former should be set before generating the records, and the latter
// should be called in place of doxie.MAC_Marshall_Results immediately
// prior to the OUTPUT of the results.


import doxie, LN_PropertyV2, ut;

l_raw_d		:= layouts.deeds.raw_source;
l_raw_a		:= layouts.assess.raw_source;
l_parties	:= layouts.parties.rolled;

l_core := record
	layouts.search_fid;
	layouts.pen;
	string8 sortby_date := '';
	string1 fid_type;
end;

export Marshall := module

	// constant indicating early marshalling was skipped
	export DELAYED_COUNT := -1;

	// check whether "early marshalling" has been enabled for this service
	export boolean useMarshall := false : stored('usePropMarshall');

	export page(dataset(l_raw_d) raw_d, dataset(l_raw_a) raw_a, dataset(l_parties) parties, boolean skipPenaltyFilter=false, boolean forceDelay=false, unsigned maxResults = input.MaxResults_val, unsigned maxResultsThisTime = input.MaxResultsThisTime_val) := module
		
		// check whether we should delay marshalling based on having a small result set
		// (which can reduce overhead when there would be no benefit to marshalling early)
		shared delayMarshall := forceDelay or ( count(raw_d)+count(raw_a) <= maxResultsThisTime );
		
		// Assemble core fields, which are needed to generate the final sort
		shared coreCommon := macro
			self.ln_fares_id	:= L.ln_fares_id;
			self.fid_type			:= R.fid_type;
			county_pen				:= min(doxie.FN_Tra_Penalty_County(L.county_name), R.county_pen);
			self.penalt				:= R.penalt + county_pen;
			self.cPenalt			:= if(input.cname = '', 0, min(R.parties, if(exists(orig_names), min(orig_names,ut.stringsimilar100(orig_name,input.cname)), 100))),
		endmacro;
		l_core toCore_d(l_raw_d L, l_parties R) := transform
			self.sortby_date := Raw.deed_recency(L);
			coreCommon();
		end;
		shared core_d := join(
			raw_d, parties,
			left.ln_fares_id = right.ln_fares_id,
			toCore_d(left,right),
			left outer
		);
		l_core toCore_a(l_raw_a L, l_parties R) := transform
			self.sortby_date := Raw.assess_recency(L);
			coreCommon();
		end;
		shared core_a := join(
			raw_a, parties,
			left.ln_fares_id = right.ln_fares_id,
			toCore_a(left,right),
			left outer
		);
		shared cores := core_d+core_a;
		// output(core_d, named('core_d')); // DEBUG
		// output(core_a, named('core_a')); // DEBUG
		// output(cores, named('cores')); // DEBUG
		
		
		// Sort cores consistent with final results, and eliminate high-penalty records
		shared pared := Raw.final_sort( dedup(cores(penalt<=input.pThresh or skipPenaltyFilter), ln_fares_id,all),,input.groupByFidTypeOnly);
		// output(pared, named('pared')); // DEBUG
		
		
		// Marshall the records
		l_rec := record(l_core)
			unsigned2 output_seq_no;
		end;  
		l_rec tr(pared L, unsigned8 cnt) := transform
			self.output_seq_no := cnt;
			self := L;
		end;

  	shared numbered := choosen(project(pared,tr(left,counter)),maxResults);
		shared paged := choosen(numbered(output_seq_no>input.SkipRecords_val),maxResultsThisTime);
		// output(numbered, named('numbered')); // DEBUG
		// output(paged, named('paged')); // DEBUG
		// NOTE: This block is comparable to doxie.MAC_Marshall_Results(pared, shared paged);

		
		// Convert marshalled cores back into raw deed & assess layouts
		shared deeds_paged := join(
			paged, raw_d,
			left.ln_fares_id=right.ln_fares_id,
			transform(l_raw_d, self:=right)
		);
		shared assess_paged := join(
			paged, raw_a,
			left.ln_fares_id=right.ln_fares_id,
			transform(l_raw_a, self:=right)
		);
		// output(deeds_paged, named('deeds_paged')); // DEBUG
		// output(assess_paged, named('assess_paged')); // DEBUG
		
		
		// output(useMarshall, named('useMarshall')); // DEBUG
		// output(delayMarshall, named('delayMarshall')); // DEBUG
		// output(raw_d, named('raw_d')); // DEBUG
		// output(raw_a, named('raw_a')); // DEBUG
		
		// results
		export deeds			:= if(useMarshall and not delayMarshall, deeds_paged, raw_d);
		export assess			:= if(useMarshall and not delayMarshall, assess_paged, raw_a);
		export numRecs		:= if(useMarshall and not delayMarshall, count(numbered), DELAYED_COUNT);
		export numDeeds		:= if(useMarshall and not delayMarshall, count(numbered( fid_type='D' )), DELAYED_COUNT);
		export numAssess	:= if(useMarshall and not delayMarshall, count(numbered( fid_type='A' )), DELAYED_COUNT);
	
	end; // page
	
	// This is used in place of doxie.MAC_Marshall_Results by services that take
	// advantage of property-specific marshalling.  Since the marshalling itself
	// has already taken place, it only needs to adjust output_seq_no and add it
	// to the output records.
	export MAC_Marshall_Results(infile,outfile) := macro
		
		#uniquename(isDelayed)
		%isDelayed% := (infile[1].num_recs = LN_PropertyV2_Services.Marshall.DELAYED_COUNT);
		
		// transform for adding count
		#uniquename(new_rec)
		#uniquename(trans)
		%new_rec% := record(infile),
			unsigned2 output_seq_no;
		end;  
		%new_rec% %trans%(infile le,unsigned8 cnt) := transform
			self.output_seq_no := cnt;
			self := le;
		end;
		
		// traditional marshalling
		#uniquename(numbered_delayed)
		#uniquename(out_delayed)
		%numbered_delayed% := choosen(project(infile,%trans%(left,counter)),LN_PropertyV2_Services.input.MaxResults_val);
		%out_delayed% := choosen(%numbered_delayed%(output_seq_no>LN_PropertyV2_Services.input.SkipRecords_val),LN_PropertyV2_Services.input.MaxResultsThisTime_val);
		
		// early marshalling
		#uniquename(count_early)
		#uniquename(count_early_deeds)
		#uniquename(count_early_assess)
		#uniquename(out_early)
		%count_early% := infile[1].num_recs;
		%count_early_deeds% := infile[1].num_deeds;
		%count_early_assess% := infile[1].num_assess;
		%out_early% := project(infile,%trans%(left,counter+SkipRecords_val));
		
		// counts
		#uniquename(l_cnts)
		#uniquename(cnts)
		%l_cnts% := record
			integer2 recordsavailable {xpath('RecordsAvailable')};
			integer2 recordsdeeds {xpath('RecordsDeeds')};
			integer2 recordsassessments {xpath('RecordsAssessments')};
		end;
		
		recordsavailable := if(%isDelayed%, count( %numbered_delayed% ), %count_early%);
		recordsdeeds := if(%isDelayed%, count( %numbered_delayed%(fid_type='D') ), %count_early_deeds%);
		recordsassessments := if(%isDelayed%, count( %numbered_delayed%(fid_type='A') ), %count_early_assess%);
												
		%cnts% := dataset([{recordsavailable,recordsdeeds,recordsassessments}],%l_cnts%);
				
		// report the counts
		if(LN_PropertyV2_Services.Marshall.useMarshall,
			output(%cnts%, named('RecordsAvailable')),
			fail('Please set #CONSTANT(\'usePropMarshall\', true);')
		);
		
		// and we're outta here
		outfile := if( %isDelayed%, %out_delayed%, %out_early% );
	
	endmacro;

end;
