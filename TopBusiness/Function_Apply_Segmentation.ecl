import MDR;

export Function_Apply_Segmentation(dataset(Layout_Linking.Linked) indata) := function

	indicator_rec := record
		indata.bid;
		indata.source;
		indata.source_docid;
		boolean hasebr;
		boolean hasdca;
		boolean hasdnb;
		boolean haseda;
		boolean hasnonpropaddr;
		boolean hasnonselfrpt;
		boolean justonce;
		boolean hasinlast6months;
		boolean hasinlast12months;
		boolean hasinlast18months;
		boolean hasinlast24months;
		boolean hasinlast36months;
		boolean hascompanyname;
		boolean hasfulladdr;
		boolean hasdeadco;
		boolean hascorp;
	end;
	
	indicator_ds := project(indata,transform(
		indicator_rec,
			self.hasebr := MDR.sourceTools.SourceIsEBR(left.source),
			self.hasdca := MDR.sourceTools.SourceIsDCA(left.source),
			self.hasdnb := MDR.sourceTools.SourceIsDunn_Bradstreet(left.source),
			self.haseda := MDR.sourceTools.SourceIsGong(left.source),
			self.hasnonpropaddr := left.address_type != Constants.Address_Types.PROPERTY,
			self.hasnonselfrpt :=
				not MDR.sourceTools.SourceIsJigsaw(left.source) and
				not MDR.sourceTools.SourceIsSpoke(left.source) and
				not MDR.sourceTools.SourceIsZoom(left.source),
			self.justonce := left.date_last_seen = left.date_first_seen,
			self.hasinlast6months := left.date_last_seen > 20101199,
			self.hasinlast12months := left.date_last_seen > 20100599,
			self.hasinlast18months := left.date_last_seen > 20091199,
			self.hasinlast24months := left.date_last_seen > 20090599,
			self.hasinlast36months := left.date_last_seen > 20080599,
			self.hascompanyname := left.company_name != '',
			self.hasfulladdr := 
				left.zip != '' and left.state != '' and left.city_name != '' and
				left.prim_name != '' and (left.prim_name[1..7] = 'PO BOX ' or left.prim_range != ''),
			self.hascorp := MDR.sourceTools.SourceIsCorpV2(left.source) and left.source_party = 'CORP',
			self.hasdeadco := MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(left.source),
			self := left));
	
	indictor_table_bid_source_local := table(indicator_ds,
		{
			bid,source,
			unsigned distinct_source_docids := count(group),
			boolean hasebr := sum(group,if(hasebr,1,0)) > 0,
			boolean hasdca := sum(group,if(hasdca,1,0)) > 0,
			boolean hasdnb := sum(group,if(hasdnb,1,0)) > 0,
			boolean haseda := sum(group,if(haseda,1,0)) > 0,
			boolean hasnonpropaddr := sum(group,if(hasnonpropaddr,1,0)) > 0,
			boolean hasnonselfrpt := sum(group,if(hasnonselfrpt,1,0)) > 0,
			boolean justonce := sum(group,if(justonce,1,0)) > 0,
			boolean hasinlast6months := sum(group,if(hasinlast6months,1,0)) > 0,
			boolean hasinlast12months := sum(group,if(hasinlast12months,1,0)) > 0,
			boolean hasinlast18months := sum(group,if(hasinlast18months,1,0)) > 0,
			boolean hasinlast24months := sum(group,if(hasinlast24months,1,0)) > 0,
			boolean hasinlast36months := sum(group,if(hasinlast36months,1,0)) > 0,
			boolean hascompanyname := sum(group,if(hascompanyname,1,0)) > 0,
			boolean hasfulladdr := sum(group,if(hasfulladdr,1,0)) > 0,
			boolean hasdeadco := sum(group,if(hasdeadco,1,0)) > 0,
			boolean hascorp := sum(group,if(hascorp,1,0)) > 0
		},
		bid,source,local);
	
	indictor_table_bid_source := table(indictor_table_bid_source_local,
		{
			bid,source,
			unsigned distinct_source_docids := sum(group,distinct_source_docids),
			boolean hasebr := sum(group,if(hasebr,1,0)) > 0,
			boolean hasdca := sum(group,if(hasdca,1,0)) > 0,
			boolean hasdnb := sum(group,if(hasdnb,1,0)) > 0,
			boolean haseda := sum(group,if(haseda,1,0)) > 0,
			boolean hasnonpropaddr := sum(group,if(hasnonpropaddr,1,0)) > 0,
			boolean hasnonselfrpt := sum(group,if(hasnonselfrpt,1,0)) > 0,
			boolean justonce := sum(group,if(justonce,1,0)) > 0,
			boolean hasinlast6months := sum(group,if(hasinlast6months,1,0)) > 0,
			boolean hasinlast12months := sum(group,if(hasinlast12months,1,0)) > 0,
			boolean hasinlast18months := sum(group,if(hasinlast18months,1,0)) > 0,
			boolean hasinlast24months := sum(group,if(hasinlast24months,1,0)) > 0,
			boolean hasinlast36months := sum(group,if(hasinlast36months,1,0)) > 0,
			boolean hascompanyname := sum(group,if(hascompanyname,1,0)) > 0,
			boolean hasfulladdr := sum(group,if(hasfulladdr,1,0)) > 0,
			boolean hasdeadco := sum(group,if(hasdeadco,1,0)) > 0,
			boolean hascorp := sum(group,if(hascorp,1,0)) > 0
		},
		bid,source);
	
	indictor_table_bid_local := table(indictor_table_bid_source,
		{
			bid,
			unsigned distinct_sources := count(group),
			unsigned distinct_nonselfrpt_sources := sum(group,if(hasnonselfrpt,1,0)),
			unsigned distinct_source_docids := sum(group,distinct_source_docids),
			boolean hasebr := sum(group,if(hasebr,1,0)) > 0,
			boolean hasdca := sum(group,if(hasdca,1,0)) > 0,
			boolean hasdnb := sum(group,if(hasdnb,1,0)) > 0,
			boolean haseda := sum(group,if(haseda,1,0)) > 0,
			boolean hasnonpropaddr := sum(group,if(hasnonpropaddr,1,0)) > 0,
			boolean hasnonselfrpt := sum(group,if(hasnonselfrpt,1,0)) > 0,
			boolean justonce := sum(group,if(justonce,1,0)) > 0,
			boolean hasinlast6months := sum(group,if(hasinlast6months,1,0)) > 0,
			boolean hasinlast12months := sum(group,if(hasinlast12months,1,0)) > 0,
			boolean hasinlast18months := sum(group,if(hasinlast18months,1,0)) > 0,
			boolean hasinlast24months := sum(group,if(hasinlast24months,1,0)) > 0,
			boolean hasinlast36months := sum(group,if(hasinlast36months,1,0)) > 0,
			boolean hascompanyname := sum(group,if(hascompanyname,1,0)) > 0,
			boolean hasfulladdr := sum(group,if(hasfulladdr,1,0)) > 0,
			boolean hasdeadco := sum(group,if(hasdeadco,1,0)) > 0,
			boolean hascorp := sum(group,if(hascorp,1,0)) > 0
		},
		bid,local);
	
	indictor_table_bid := table(indictor_table_bid_local,
		{
			bid,
			unsigned distinct_sources := sum(group,distinct_sources),
			unsigned distinct_nonselfrpt_sources := sum(group,distinct_nonselfrpt_sources),
			unsigned distinct_source_docids := sum(group,distinct_source_docids),
			boolean hasebr := sum(group,if(hasebr,1,0)) > 0,
			boolean hasdca := sum(group,if(hasdca,1,0)) > 0,
			boolean hasdnb := sum(group,if(hasdnb,1,0)) > 0,
			boolean haseda := sum(group,if(haseda,1,0)) > 0,
			boolean hasnonpropaddr := sum(group,if(hasnonpropaddr,1,0)) > 0,
			boolean hasnonselfrpt := sum(group,if(hasnonselfrpt,1,0)) > 0,
			boolean justonce := sum(group,if(justonce,1,0)) > 0,
			boolean hasinlast6months := sum(group,if(hasinlast6months,1,0)) > 0,
			boolean hasinlast12months := sum(group,if(hasinlast12months,1,0)) > 0,
			boolean hasinlast18months := sum(group,if(hasinlast18months,1,0)) > 0,
			boolean hasinlast24months := sum(group,if(hasinlast24months,1,0)) > 0,
			boolean hasinlast36months := sum(group,if(hasinlast36months,1,0)) > 0,
			boolean hascompanyname := sum(group,if(hascompanyname,1,0)) > 0,
			boolean hasfulladdr := sum(group,if(hasfulladdr,1,0)) > 0,
			boolean hasdeadco := sum(group,if(hasdeadco,1,0)) > 0,
			boolean hascorp := sum(group,if(hascorp,1,0)) > 0
		},
		bid);

	// bid_segmented := project(indictor_table_bid,transform(
		// {indicator_table_bid.bid;unsigned1 segment_bid;},
		// self.bid := left.bid,
		// self.segment_bid := map(
			// left.distinct_nonselfrpt_sources = 0 =>
				// Constants.Segment_Types.SELF_REPORTED,
			// left.has_deadco =>
				// Constants.Segment_Types.DEAD,
			// left.distinct_nonselfrpt_sources > 1 and not left.hasinlast18months and left.hasfulladdr =>
				// Constants.Segment_Types.INACTIVE,
			// left.hasebr and left.hasdca and left.hasdnb =>
				// Constants.Segment_Types.TRIPLE_CORE,
			// (left.hasebr and left.hasdca) or
			// (left.hasebr and left.hasdnb) or
			// (left.hasdca and left.hasdnb) =>
				// Constants.Segment_Types.DOUBLE_CORE,
			// not left.hasnonpropaddr =>
				// Constants.Segment_Types.PROPERTYOWNER,
			// left.distinct_nonselfrpt_sources > 1 and left.hasinlast18months and left.hasfulladdr =>
				// Constants.Segment_Types.CORE,
			// left.distinct_nonselfrpt_sources = 1 and left.hasinlast18months and left.hasfulladdr =>
				// Constants.Segment_Types.EMERGING,
			// left.cnt = 1 and left.max_date_last_seen < 20100300 => Constants.Segment_Types.BOGUS,
			// Constants.Segment_Types.CORE),
		// self := left));
		
	bid_segmented := project(indictor_table_bid,transform(
		{indictor_table_bid.bid;unsigned1 segment_bid;},
		self.segment_bid := map(
			/* ANY NUMBER OF SOURCES, BUT ALL ARE SELF-REPORT */
			not left.hasnonselfrpt =>
				Constants.Segment_Types.UNTRUSTED,
			/* ANY NUMBER OF SOURCES, NOT ALL ARE SELF-REPORT, BUT MISSING EITHER NAME OR ADDRESS */
			not left.hascompanyname or not left.hasfulladdr =>
				Constants.Segment_Types.INCOMPLETE,
			/* HAS NAME AND ADDRESS, AND ALL THREE "TRIPLE-CORE" SOURCES */
			left.hasebr and left.hasdca and left.hasdnb => map(
				/* MORE THAN 36 MONTHS: HISTORICAL */
				not left.hasinlast36months => Constants.Segment_Types.HISTORICAL,
				/* MORE THAN 18 MONTHS: NONUPDATING */
				not left.hasinlast18months => Constants.Segment_Types.NONUPDATING,
				/* OTHERWISE STILL ACTIVE */
				Constants.Segment_Types.TRIPLE_CORE),
			/* HAS NAME AND ADDRESS, AND TWO OF THREE "TRIPLE-CORE" SOURCES */
			(left.hasebr and left.hasdca) or
			(left.hasebr and left.hasdnb) or
			(left.hasdca and left.hasdnb) => map(
				/* MORE THAN 36 MONTHS: HISTORICAL */
				not left.hasinlast36months => Constants.Segment_Types.HISTORICAL,
				/* MORE THAN 18 MONTHS: NONUPDATING */
				not left.hasinlast18months => Constants.Segment_Types.NONUPDATING,
				/* OTHERWISE STILL ACTIVE */
				Constants.Segment_Types.DOUBLE_CORE),
			/* HAS NAME AND ADDRESS, AND TWO OR MORE SOURCES */
			left.distinct_sources > 1 => map(
				/* MORE THAN 36 MONTHS: HISTORICAL */
				not left.hasinlast36months => Constants.Segment_Types.HISTORICAL,
				/* MORE THAN 18 MONTHS: NONUPDATING */
				not left.hasinlast18months => Constants.Segment_Types.NONUPDATING,
				/* OTHERWISE STILL ACTIVE */
				Constants.Segment_Types.DOUBLE_TRUSTED),
			/* HAS NAME AND ADDRESS, AND ONLY ONE SOURCE, WHICH IS TELCO/EDA */
			left.haseda => map(
				/* MORE THAN 24 MONTHS: HISTORICAL */
				not left.hasinlast24months => Constants.Segment_Types.HISTORICAL,
				/* MORE THAN 6 MONTHS: NONUPDATING */
				not left.hasinlast6months => Constants.Segment_Types.NONUPDATING,
				/* SEEN IT JUST ONCE? EMERGING */
				left.justonce => Constants.Segment_Types.EMERGING_EDA,
				/* OTHERWISE STILL ACTIVE */
				Constants.Segment_Types.ESTABLISHED_EDA),
			/* HAS NAME AND ADDRESS, AND ONLY ONE SOURCE, WHICH IS NON-TELCO/EDA BUT TRUSTED */
			map(
				/* MORE THAN 36 MONTHS: HISTORICAL */
				not left.hasinlast36months => Constants.Segment_Types.HISTORICAL,
				/* MORE THAN 18 MONTHS: NONUPDATING */
				not left.hasinlast18months => Constants.Segment_Types.NONUPDATING,
				/* SEEN IT JUST ONCE? EMERGING */
				left.justonce => Constants.Segment_Types.EMERGING_TRUSTED,
				/* OTHERWISE STILL ACTIVE */
				Constants.Segment_Types.ESTABLISHED_TRUSTED)),
		self := left));
	
	bidbridblids := table(table(indata,{bid,brid,blid},bid,brid,blid,local),{bid,brid,blid},bid,brid,blid);
	
	bidbridblidsplussegment := join(bidbridblids,bid_segmented,
		left.bid = right.bid);
	
	return join(
		distribute(indata,hash64(bid,brid,blid)),
		distribute(bidbridblidsplussegment,hash64(bid,brid,blid)),
		left.bid = right.bid and
		left.brid = right.brid and
		left.blid = right.blid,
		transform(Layout_Linking.Linked,
			self := right,
			self := left),
		local);

end;
