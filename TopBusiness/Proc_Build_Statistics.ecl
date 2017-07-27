import MDR;

export Proc_Build_Statistics(
	dataset(Layout_Linking.Linked) records
) := function

	countrecords := count(records);
	
	bids := dedup(records,bid,all);
	
	countbids := count(bids);
	
	bidsegments := project(table(bids,{segment_bid,unsigned cnt := count(group)},segment_bid),
		transform({string20 segment_desc;unsigned cnt;},
		self.segment_desc := map(
			left.segment_bid = Constants.Segment_Types.UNTRUSTED => 'UNTRUSTED',
			left.segment_bid = Constants.Segment_Types.INCOMPLETE => 'INCOMPLETE',
			left.segment_bid = Constants.Segment_Types.EMERGING_EDA => 'EMERGING_EDA',
			left.segment_bid = Constants.Segment_Types.EMERGING_TRUSTED => 'EMERGING_TRUSTED',
			left.segment_bid = Constants.Segment_Types.HISTORICAL => 'HISTORICAL',
			left.segment_bid = Constants.Segment_Types.DOUBLE_TRUSTED => 'DOUBLE_TRUSTED',
			left.segment_bid = Constants.Segment_Types.ESTABLISHED_EDA => 'ESTABLISHED_EDA',
			left.segment_bid = Constants.Segment_Types.ESTABLISHED_TRUSTED => 'ESTABLISHED_TRUSTED',
			left.segment_bid = Constants.Segment_Types.TRIPLE_CORE => 'TRIPLE_CORE',
			left.segment_bid = Constants.Segment_Types.DOUBLE_CORE => 'DOUBLE_CORE',
			                   (string20)left.segment_bid),
		self.cnt := left.cnt));
	
	tempsummaryrec := record
		string30 measurement;
		unsigned cnt;
	end;
	
	summary :=
		row({'Total header records',countrecords},tempsummaryrec) +
		row({'Total unique entities',countbids},tempsummaryrec) +
		project(bidsegments,transform(tempsummaryrec,
			self.measurement := 'Total unique ' + left.segment_desc + ' entities',
			self.cnt := left.cnt));
	
	bidindicators_1 := table(records,
		{
			bid,
			unsigned1 segment_bid := max(group,segment_bid),
			boolean has_phone := sum(group,if(phone != '',1,0)) > 0,
			boolean has_fein := sum(group,if(fein != '',1,0)) > 0,
			boolean has_address := sum(group,if(zip != '' and prim_name != '',1,0)) > 0,
			boolean has_url := sum(group,if(url != '',1,0)) > 0,
			boolean has_corp_filing := sum(group,if(MDR.sourceTools.SourceIsCorpV2(source),1,0)) > 0
		},
		bid,local);
	
	bidindicators := table(bidindicators_1,
		{
			bid,
			unsigned1 segment_bid := max(group,segment_bid),
			boolean has_phone := sum(group,if(has_phone,1,0)) > 0,
			boolean has_fein := sum(group,if(has_fein,1,0)) > 0,
			boolean has_address := sum(group,if(has_address,1,0)) > 0,
			boolean has_url := sum(group,if(has_url,1,0)) > 0,
			boolean has_corp_filing := sum(group,if(has_corp_filing,1,0)) > 0
		},
		bid);
	
	indicatorsummary := table(bidindicators,
		{
			segment_bid,
			unsigned cnt_has_phone := sum(group,if(has_phone,1,0)),
			unsigned cnt_has_fein := sum(group,if(has_fein,1,0)),
			unsigned cnt_has_address := sum(group,if(has_address,1,0)),
			unsigned cnt_has_url := sum(group,if(has_url,1,0)),
			unsigned cnt_has_corp_filing := sum(group,if(has_corp_filing,1,0))
		},
		segment_bid);

	tempaddrs := dedup(dedup(records(zip != '' and prim_name != ''),zip,prim_name,prim_range,sec_range,bid,all,local),zip,prim_name,prim_range,sec_range,bid,all);
	tempphones := dedup(dedup(records(phone != ''),phone,bid,all,local),phone,bid,all);
	tempfeins := dedup(dedup(records(fein != ''),fein,bid,all,local),fein,bid,all);
	tempurls := dedup(dedup(records(url != ''),url,bid,all,local),url,bid,all);

	tempuniqaddrs := dedup(dedup(tempaddrs,zip,prim_name,prim_range,sec_range,all,local),zip,prim_name,prim_range,sec_range,all);
	tempuniqphones := dedup(dedup(tempphones,phone,all,local),phone,all);
	tempuniqfeins := dedup(dedup(tempfeins,fein,all,local),fein,all);
	tempuniqurls := dedup(dedup(tempurls,url,all,local),url,all);

	tempout := dataset([
		{'Unique cores per address',(real)count(tempaddrs)/(real)count(tempuniqaddrs)},
		{'Unique cores per phone',  (real)count(tempphones)/(real)count(tempuniqphones)},
		{'Unique cores per fein',   (real)count(tempfeins)/(real)count(tempuniqfeins)},
		{'Unique cores per URL',    (real)count(tempurls)/(real)count(tempuniqurls)}],{string desc,real value});
	
	return parallel(
		output(summary,named('SummaryStatistics')),
		output(indicatorsummary,named('IndicatorSummary')),
		output(tempout,named('CoverageRatios')));

end;
