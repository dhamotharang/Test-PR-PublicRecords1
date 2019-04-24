import GlobalWatchlists, iesp, Patriot, Risk_Indicators, WorldCheckServices;

export WatchListFunctions() := MODULE

EXPORT layout_options := RECORD
	BOOLEAN IncludeOFAC;
	BOOLEAN IncludeOtherWatchLists;
	BOOLEAN UseDOBFilter;
	INTEGER DOBRadius;
	STRING  GlobalWatchlistThreshold;
	DATASET(iesp.share.t_StringArrayItem) WatchList;
END;

EXPORT getWatchlists(layout_options options,DATASET(risk_indicators.Layout_Output) watchList) := FUNCTION
	BOOLEAN   ofacOnly := FALSE;
	UNSIGNED1 ofacVersion := 3;
	BOOLEAN   includeOfac := options.includeOfac;
	BOOLEAN   includeOtherWatchlists := options.includeOtherWatchlists;
	REAL      gWatchlistThreshold := IF(options.GlobalWatchlistThreshold='',0.89,(REAL)options.GlobalWatchlistThreshold);
	INTEGER2  dob_radius_use := IF(options.useDobFilter,options.dobRadius,-1);

	wlMatches := risk_indicators.getWatchLists2(
		GROUP(watchList,seq),ofacOnly,FALSE,ofacVersion,includeOfac,
		includeOtherWatchlists,gWatchlistThreshold,dob_radius_use,GLOBAL(Options.WatchList));

	RETURN wlMatches;
END;

export addWLMatches(dataset(iesp.iid_international.t_InstantIDInternationalRequest_Unicode) indata,
										dataset(iesp.iid_international.t_InstantIDInternationalResponse_Unicode) outdata) := FUNCTION

	options := project(indata[1].Options,transform(layout_options,self:=left));
	wlMatches := getWatchLists(options,project(indata,
		transform(risk_indicators.Layout_Output, 
			self.fname:=(string)left.searchby.name.first, 
			self.mname:=(string)left.searchby.name.middle,
			self.lname:=(string)left.searchby.name.last, 
			self.country:=left.searchby.address.country, 
			self.dob:=intformat(left.searchby.dob.year,4,1)+intformat(left.searchby.dob.month,2,1)+intformat(left.searchby.dob.day,2,1),
			self.seq:=(unsigned)left.user.QueryId, 
			self:=[])));																																												
																																						
	iesp.iid_international.t_InstantIDInternationalResponse_Unicode addWLMatches(outdata le, wlMatches ri) := transform
		self.result.watchlist.table := ri.watchlist_table;
		self.result.watchlist.recordnumber := ri.watchlist_record_number;
		self.result.watchlist.name.full := '';
		self.result.watchlist.name.first := stringlib.stringtouppercase((string)ri.watchlist_fname);
		self.result.watchlist.name.middle := '';
		self.result.watchlist.name.last := stringlib.stringtouppercase((string)ri.watchlist_lname);
		self.result.watchlist.name.suffix := '';
		self.result.watchlist.name.prefix := '';
		self.result.watchlist.address.streetname := '';
		self.result.watchlist.address.streetnumber := '';
		self.result.watchlist.address.streetpredirection := '';
		self.result.watchlist.address.streetpostdirection := '';
		self.result.watchlist.address.streetsuffix := '';
		self.result.watchlist.address.unitdesignation := '';
		self.result.watchlist.address.unitnumber := '';
		self.result.watchlist.address.streetaddress1 := stringlib.stringtouppercase(ri.watchlist_address);
		self.result.watchlist.address.streetaddress2 := '';
		self.result.watchlist.address.state := stringlib.stringtouppercase(ri.watchlist_state);
		self.result.watchlist.address.city := stringlib.stringtouppercase(ri.watchlist_city);
		self.result.watchlist.address.zip5 := ri.watchlist_zip[1..5];
		self.result.watchlist.address.zip4 := ri.watchlist_zip[6..9];
		self.result.watchlist.address.county := '';
		self.result.watchlist.address.postalcode := '';
		self.result.watchlist.address.statecityzip := '';
		self.result.watchlist.country := stringlib.stringtouppercase(ri.watchlist_contry);
		self.result.watchlist.entityname := stringlib.stringtouppercase((string)ri.watchlist_entity_name);
		
		ofac := DATASET([{'I32',getRCdesc('I32')}],iesp.share.t_RiskIndicator);
		wl := DATASET([{'IWL',getRCdesc('IWL')}],iesp.share.t_RiskIndicator);
		self.result.riskindicators := map(Risk_Indicators.rcSet.isCode32(ri.watchlist_table, ri.watchlist_record_number) => ofac+choosen(le.result.riskindicators, iesp.Constants.MaxCountHRI - 1),
																			Risk_Indicators.rcSet.isCodeWL(ri.watchlist_table, ri.watchlist_record_number) => wl+choosen(le.result.riskindicators, iesp.Constants.MaxCountHRI - 1),
																			le.result.riskindicators);
		self := le;
	end;

	wWLData := join(outdata, wlMatches, (unsigned)left._header.queryid=right.seq, addWLMatches(left,right), left outer);

	return wWLData;         
end;

END;