import attus, address, gateway;

export getAttus(grouped DATASET(Layout_Output) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 dppa, unsigned1 glb) := function

attus_gateway_url := gateways(servicename = Gateway.Constants.ServiceName.Attus)[1].url;

attus.Layout_Attus_In prep_for_attus(indata le) := transform	
	self.user.GLBPurpose := 1;
	self.user.DLPurpose := 1;
	self.user.QueryID := (string)le.seq;
	self.searchby.queryitems := attus.BuildQueryItems(le);	
	self := [];
end;

attus_in := project(ungroup(indata( (fname!='' and lname!='') or
										employer_name!='' or
										country!='' ) ) , prep_for_attus(left));

atto := if(attus_gateway_url!='' and count(attus_in)>0, attus.Attus_Soapcall_Function(attus_in, gateways), dataset([], attus.Layout_Attus_out));

layout_output format_attus(atto le) := transform
	hit := le.listresults[1].totalhits>0 and le.errormessage='';
	self.seq := (unsigned)le.header.QueryID;
	SELF.watchlist_table := if(le.errormessage!='','XXX', if(hit, 'OFC', ''));
	SELF.watchlist_record_number := if(hit, le.listresults[1].resultentities[1].entityid, '');										  
	SELF.watchlist_address := if(hit, le.listresults[1].resultentities[1].entityaddresses[1].address.streetaddress1, '');									  
	SELF.watchlist_city := if(hit, le.listresults[1].resultentities[1].entityaddresses[1].address.city, '');
	SELF.watchlist_state := if(hit, le.listresults[1].resultentities[1].entityaddresses[1].address.state, '');
	SELF.watchlist_zip := if(hit, le.listresults[1].resultentities[1].entityaddresses[1].address.zip5, '');
	SELF.watchlist_fname := if(hit, le.listresults[1].resultentities[1].name.fname, '');
	SELF.watchlist_lname := if(hit, le.listresults[1].resultentities[1].name.lname, '');
	SELF.watchlist_entity_name := if(hit, if(le.listresults[1].resultentities[1].OtherName='', le.listresults[1].resultentities[1].name.fullname, le.listresults[1].resultentities[1].OtherName) , '');
	SELF.watchlist_contry := if(hit and le.listresults[1].BlockedCountryHits > 0, 'Y', ''); 
     SELF := [];
end;

attus_result := project(atto, format_attus(left));

layout_output addwatch(layout_output le, layout_output rt) := transform
	SELF.watchlist_table := rt.watchlist_table;
	SELF.watchlist_record_number := rt.watchlist_record_number;
	// hits on watchdog without the name returned populate the results with the searchby fields
	noname_hit := rt.watchlist_table='OFC' and rt.watchlist_fname='' and rt.watchlist_lname='' and rt.watchlist_entity_name=''; 
	SELF.watchlist_fname := if(noname_hit, le.fname, rt.watchlist_fname);
	SELF.watchlist_lname := if(noname_hit, le.lname, rt.watchlist_lname);
	SELF.watchlist_entity_name := if(noname_hit, le.employer_name, rt.watchlist_entity_name);
	SELF.watchlist_address := rt.watchlist_address;
	SELF.watchlist_city := rt.watchlist_city;
	SELF.watchlist_state := rt.watchlist_state;
	SELF.watchlist_zip := rt.watchlist_zip;
	SELF.watchlist_contry := if(rt.watchlist_contry='Y', le.country, '');// if blocked country hits, return the input country code rt.watchlist_contry;	
     SELF := le;
end;
									

watchlist_final := group(sort(join(indata, attus_result, left.seq = right.seq,
								addwatch(left, right), left outer),seq),seq);

return watchlist_final;

end;
