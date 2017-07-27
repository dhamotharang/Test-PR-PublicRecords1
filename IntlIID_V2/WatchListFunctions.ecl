import GlobalWatchlists, iesp, Patriot, Risk_Indicators, WorldCheckServices;

export WatchListFunctions() := MODULE

export addWLMatches(dataset(iesp.iid_international.t_InstantIDInternationalRequest) indata,
										dataset(iesp.iid_international.t_InstantIDInternationalResponse) outdata) := FUNCTION

	boolean 	ofacOnly := false;
	unsigned1 ofacVersion := 3;
	boolean 	includeOfac := indata[1].options.includeOfac;
	boolean 	includeOtherWatchlists := indata[1].options.includeOtherWatchlists;
	real 			gWatchlistThreshold := if(indata[1].options.GlobalWatchlistThreshold = '', 0.89, (real)indata[1].options.GlobalWatchlistThreshold);
	

	// check dob radius
	dob_radius_use := if(indata[1].options.useDobFilter, indata[1].options.dobRadius, -1);

	// now get watchlist data
	// check below to do or not do watchlist search
	wlMatches := risk_indicators.getWatchLists2(group(project(indata, transform(risk_indicators.Layout_Output, 
																																							self.fname:=left.searchby.name.first, 
																																							self.mname:=left.searchby.name.middle,
																																							self.lname:=left.searchby.name.last, 
																																							self.country:=left.searchby.address.country, 
																																							self.dob:=intformat(left.searchby.dob.year,4,1)+intformat(left.searchby.dob.month,2,1)+intformat(left.searchby.dob.day,2,1),
																																							self.seq:=(unsigned)left.user.QueryId, 
																																							self:=[])),seq),
																						ofacOnly, false, ofacVersion, includeOfac, includeOtherWatchlists, gWatchlistThreshold, dob_radius_use, global(indata[1].Options.WatchList));
																																															
																																															
	iesp.iid_international.t_InstantIDInternationalResponse addWLMatches(outdata le, wlMatches ri) := transform
		self.result.watchlist.table := ri.watchlist_table;
		self.result.watchlist.recordnumber := ri.watchlist_record_number;
		self.result.watchlist.name.full := '';
		self.result.watchlist.name.first := stringlib.stringtouppercase(ri.watchlist_fname);
		self.result.watchlist.name.middle := '';
		self.result.watchlist.name.last := stringlib.stringtouppercase(ri.watchlist_lname);
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
		self.result.watchlist.entityname := stringlib.stringtouppercase(ri.watchlist_entity_name);
		
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