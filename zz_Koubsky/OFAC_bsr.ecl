#workunit('name','Testing ofac searching within Consumer InstantID');
// plugin_version := 3;
plugin_version := 2;
eyeball := 10;

r := record
	string sdn_number;
	string unparsed_name;
end;


a := dataset('~dvstemp::in::ofac::20160325::sdn.csv', r, csv(quote('"')) );

r2 := record
	string sdn_number;
	string afiller;
	string bfiller;
	string unparsed_name;
end;

b := dataset('~dvstemp::in::ofac::20160325::alt.csv', r2, csv(quote('"')) );
c := project(b, transform(r, self := left));
// output(a);
// output(b);
// output(c);

test_rec := record
	unsigned seq;
	string sdn_number;
	string unparsed_name;
end;

test_input := project(a + c, transform(test_rec, self.seq := counter, self := left));
// output(test_input, named('test_input'));

layout_soap := record
	STRING30 AccountNumber;
	string UnParsedFullName;
	STRING100 EmployerName;
	integer OFACversion;
	boolean IncludeOfac;
	boolean IncludeAdditionalWatchLists;
	real GlobalWatchlistThreshold;
END;

p_f := PROJECT (test_input, transform(layout_soap,
	self.AccountNumber := (string)left.seq ;
	self.UnParsedFullName := left.unparsed_name ;
	self.EmployerName := left.unparsed_name ;
	self.OFACversion := plugin_version ;
	self.GlobalWatchlistThreshold := if(plugin_version=3, 0.85, 0.84) ;
	self.includeofac := true ;
	self.includeadditionalwatchlists := false
	));
output(choosen(p_f, eyeball), named('CIID_Input'));

dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

roxieIP := 'http://roxiebatch.br.seisint.com:9856'; // roxiebatch
// roxieIP := riskwise.shortcuts.dev64b;
// roxieIP := riskwise.shortcuts.staging_neutral_roxieIP;

xlayout := RECORD
	(risk_indicators.Layout_InstandID_NuGen)
	unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'risk_indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(30), 
				onFail(myFail(LEFT)));
				
ox := RECORD
	STRING30 AccountNumber;
	string UnParsedFullName;
	STRING5   title := '';
	STRING20  fname;
	STRING20  mname;
	STRING20  lname;
	STRING5   suffix;
	STRING100 employer_name := '';
	unsigned8 time_ms;
	
//	field 61-59 watchlists
	STRING60  Watchlist_Table;
	STRING120 Watchlist_Program;
	STRING10  Watchlist_Record_Number;
	STRING20  Watchlist_fname;
	STRING20  Watchlist_lname;
	STRING65  Watchlist_address;
	STRING25  Watchlist_city;
	STRING2   Watchlist_state;
	STRING5   Watchlist_zip;
	STRING30  Watchlist_country;
	STRING200 Watchlist_Entity_Name;
	STRING60  Watchlist_Table_2;
	STRING120 Watchlist_Program_2;
	STRING10  Watchlist_Record_Number_2;
	STRING20  Watchlist_fname_2;
	STRING20  Watchlist_lname_2;
	STRING65  Watchlist_address_2;
	STRING25  Watchlist_city_2;
	STRING2   Watchlist_state_2;
	STRING5   Watchlist_zip_2;
	STRING30  Watchlist_country_2;
	STRING200 Watchlist_Entity_Name_2;
	STRING60  Watchlist_Table_3;
	STRING120 Watchlist_Program_3;
	STRING10  Watchlist_Record_Number_3;
	STRING20  Watchlist_fname_3;
	STRING20  Watchlist_lname_3;
	STRING65  Watchlist_address_3;
	STRING25  Watchlist_city_3;
	STRING2   Watchlist_state_3;
	STRING5   Watchlist_zip_3;
	STRING30  Watchlist_country_3;
	STRING200 Watchlist_Entity_Name_3;
	STRING60  Watchlist_Table_4;
	STRING120 Watchlist_Program_4;
	STRING10  Watchlist_Record_Number_4;
	STRING20  Watchlist_fname_4;
	STRING20  Watchlist_lname_4;
	STRING65  Watchlist_address_4;
	STRING25  Watchlist_city_4;
	STRING2   Watchlist_state_4;
	STRING5   Watchlist_zip_4;
	STRING30  Watchlist_country_4;
	STRING200 Watchlist_Entity_Name_4;
	STRING60  Watchlist_Table_5;
	STRING120 Watchlist_Program_5;
	STRING10  Watchlist_Record_Number_5;
	STRING20  Watchlist_fname_5;
	STRING20  Watchlist_lname_5;
	STRING65  Watchlist_address_5;
	STRING25  Watchlist_city_5;
	STRING2   Watchlist_state_5;
	STRING5   Watchlist_zip_5;
	STRING30  Watchlist_country_5;
	STRING200 Watchlist_Entity_Name_5;
	STRING60  Watchlist_Table_6;
	STRING120 Watchlist_Program_6;
	STRING10  Watchlist_Record_Number_6;
	STRING20  Watchlist_fname_6;
	STRING20  Watchlist_lname_6;
	STRING65  Watchlist_address_6;
	STRING25  Watchlist_city_6;
	STRING2   Watchlist_state_6;
	STRING5   Watchlist_zip_6;
	STRING30  Watchlist_country_6;
	STRING200 Watchlist_Entity_Name_6;
	STRING60  Watchlist_Table_7;
	STRING120 Watchlist_Program_7;
	STRING10  Watchlist_Record_Number_7;
	STRING20  Watchlist_fname_7;
	STRING20  Watchlist_lname_7;
	STRING65  Watchlist_address_7;
	STRING25  Watchlist_city_7;
	STRING2   Watchlist_state_7;
	STRING5   Watchlist_zip_7;
	STRING30  Watchlist_country_7;
	STRING200 Watchlist_Entity_Name_7;	
	STRING errorcode;
END;

ox normit(resu L, p_f R) := transform
	self.AccountNumber := r.accountnumber;
	self.UnParsedFullName := r.unparsedfullname;
		
	SELF.Watchlist_country := l.watchlists[1].watchlist_contry;
	SELF.Watchlist_Table_2 := l.watchlists[2].watchlist_table;
	SELF.Watchlist_program_2 :=l.watchlists[2].watchlist_program;
	SELF.Watchlist_Record_Number_2 := l.watchlists[2].watchlist_Record_Number;
	SELF.Watchlist_fname_2 := l.watchlists[2].watchlist_fname;
	SELF.Watchlist_lname_2 := l.watchlists[2].watchlist_lname;
	SELF.Watchlist_address_2 := l.watchlists[2].watchlist_address;
	SELF.Watchlist_city_2 := l.watchlists[2].watchlist_city;
	SELF.Watchlist_state_2 := l.watchlists[2].watchlist_state;
	SELF.Watchlist_zip_2 := l.watchlists[2].watchlist_zip;
	SELF.Watchlist_country_2 := l.watchlists[2].watchlist_contry;
	SELF.Watchlist_Entity_Name_2 := l.watchlists[2].watchlist_Entity_Name;
	SELF.Watchlist_Table_3 := l.watchlists[3].watchlist_table;
	SELF.Watchlist_program_3 :=l.watchlists[3].watchlist_program;
	SELF.Watchlist_Record_Number_3 := l.watchlists[3].watchlist_Record_Number;
	SELF.Watchlist_fname_3 := l.watchlists[3].watchlist_fname;
	SELF.Watchlist_lname_3 := l.watchlists[3].watchlist_lname;
	SELF.Watchlist_address_3 := l.watchlists[3].watchlist_address;
	SELF.Watchlist_city_3 := l.watchlists[3].watchlist_city;
	SELF.Watchlist_state_3 := l.watchlists[3].watchlist_state;
	SELF.Watchlist_zip_3 := l.watchlists[3].watchlist_zip;
	SELF.Watchlist_country_3 := l.watchlists[3].watchlist_contry;
	SELF.Watchlist_Entity_Name_3 := l.watchlists[3].watchlist_Entity_Name;
	SELF.Watchlist_Table_4 := l.watchlists[4].watchlist_table;
	SELF.Watchlist_program_4 :=l.watchlists[4].watchlist_program;
	SELF.Watchlist_Record_Number_4 := l.watchlists[4].watchlist_Record_Number;
	SELF.Watchlist_fname_4 := l.watchlists[4].watchlist_fname;
	SELF.Watchlist_lname_4 := l.watchlists[4].watchlist_lname;
	SELF.Watchlist_address_4 := l.watchlists[4].watchlist_address;
	SELF.Watchlist_city_4 := l.watchlists[4].watchlist_city;
	SELF.Watchlist_state_4 := l.watchlists[4].watchlist_state;
	SELF.Watchlist_zip_4 := l.watchlists[4].watchlist_zip;
	SELF.Watchlist_country_4 := l.watchlists[4].watchlist_contry;
	SELF.Watchlist_Entity_Name_4 := l.watchlists[4].watchlist_Entity_Name;
	SELF.Watchlist_Table_5 := l.watchlists[5].watchlist_table;
	SELF.Watchlist_program_5 :=l.watchlists[5].watchlist_program;
	SELF.Watchlist_Record_Number_5 := l.watchlists[5].watchlist_Record_Number;
	SELF.Watchlist_fname_5 := l.watchlists[5].watchlist_fname;
	SELF.Watchlist_lname_5 := l.watchlists[5].watchlist_lname;
	SELF.Watchlist_address_5 := l.watchlists[5].watchlist_address;
	SELF.Watchlist_city_5 := l.watchlists[5].watchlist_city;
	SELF.Watchlist_state_5 := l.watchlists[5].watchlist_state;
	SELF.Watchlist_zip_5 := l.watchlists[5].watchlist_zip;
	SELF.Watchlist_country_5 := l.watchlists[5].watchlist_contry;
	SELF.Watchlist_Entity_Name_5 := l.watchlists[5].watchlist_Entity_Name;
	SELF.Watchlist_Table_6 := l.watchlists[6].watchlist_table;
	SELF.Watchlist_program_6 :=l.watchlists[6].watchlist_program;
	SELF.Watchlist_Record_Number_6 := l.watchlists[6].watchlist_Record_Number;
	SELF.Watchlist_fname_6 := l.watchlists[6].watchlist_fname;
	SELF.Watchlist_lname_6 := l.watchlists[6].watchlist_lname;
	SELF.Watchlist_address_6 := l.watchlists[6].watchlist_address;
	SELF.Watchlist_city_6 := l.watchlists[6].watchlist_city;
	SELF.Watchlist_state_6 := l.watchlists[6].watchlist_state;
	SELF.Watchlist_zip_6 := l.watchlists[6].watchlist_zip;
	SELF.Watchlist_country_6 := l.watchlists[6].watchlist_contry;
	SELF.Watchlist_Entity_Name_6 := l.watchlists[6].watchlist_Entity_Name;
	SELF.Watchlist_Table_7 := l.watchlists[7].watchlist_table;
	SELF.Watchlist_program_7 :=l.watchlists[7].watchlist_program;
	SELF.Watchlist_Record_Number_7 := l.watchlists[7].watchlist_Record_Number;
	SELF.Watchlist_fname_7 := l.watchlists[7].watchlist_fname;
	SELF.Watchlist_lname_7 := l.watchlists[7].watchlist_lname;
	SELF.Watchlist_address_7 := l.watchlists[7].watchlist_address;
	SELF.Watchlist_city_7 := l.watchlists[7].watchlist_city;
	SELF.Watchlist_state_7 := l.watchlists[7].watchlist_state;
	SELF.Watchlist_zip_7 := l.watchlists[7].watchlist_zip;
	SELF.Watchlist_country_7 := l.watchlists[7].watchlist_contry;
	SELF.Watchlist_Entity_Name_7 := l.watchlists[7].watchlist_Entity_Name;
	self := L;

end;

j_f := JOIN(resu,p_f,LEFT.acctno=RIGHT.accountnumber,normit(LEFT,RIGHT));

output(choosen(j_f, eyeball), named('result_sample'));
output(choosen(j_f(errorcode<>''), eyeball),named('error_sample'));
output(j_f,,'~dvstemp::out::prod_ciid_out_watchlist_testing_' + thorlib.wuid(),CSV(heading(single), quote('"')));

