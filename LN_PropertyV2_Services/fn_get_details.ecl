l_deed		:= layouts.deeds.result.rolled_tmp;
l_assess	:= layouts.assess.result.rolled_tmp;
l_parties	:= layouts.parties.rolled;
l_detail	:= layouts.details.result;
l_out			:= layouts.details.rolled;

export dataset(l_out) fn_get_details(
  dataset(l_deed)			in_deeds,
  dataset(l_assess)		in_assess,
  dataset(l_parties)	in_parties
) := function
	
	l_out fromDeed(l_deed L) := transform
		self.details := join(
			L.deeds, in_parties,
			left.ln_fares_id=right.ln_fares_id and left.search_did = right.search_did,
			transform(
				l_detail,
				prop := right.parties(party_type='P')[1];
				self.geo_lat	:= prop.geo_lat;
				self.geo_long	:= prop.geo_long;
				self := left;
				self := [];
			),
			left outer
		);
		self := L;
	end;
	
	l_out fromAssess(l_assess L) := transform
		self.details := join(
			L.assessments, in_parties,
			left.ln_fares_id=right.ln_fares_id and left.search_did = right.search_did,
			transform(
				l_detail,
				prop := right.parties(party_type='P')[1];
				self.geo_lat	:= prop.geo_lat;
				self.geo_long	:= prop.geo_long;
				self := left;
				self := [];
			),
			left outer
		);
		self := L;
	end;
	
	results_d := project(in_deeds,	fromDeed(left));
	results_a := project(in_assess,	fromAssess(left));
	
	results := results_d + results_a;
// output(in_parties,named('in_parties'));	
// output(results,named('out_details'));	
	return results;

end;