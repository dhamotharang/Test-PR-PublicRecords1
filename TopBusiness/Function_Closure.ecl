// This is the function for performing a single closure of beid matches.
inner_single_closure_function(dataset(Layout_Linking.Match) in_links) := function

	low_beids := dedup(sort(distribute(in_links,hash64(beid_high)),beid_high,beid_low,local),beid_high,local);

	join1 := join(distribute(in_links,hash64(beid_low)),low_beids,
		left.beid_low = right.beid_high,
		transform(Layout_Linking.Match,
			self.beid_high := left.beid_high,
			self.beid_low := if(right.beid_low = 0,left.beid_low,right.beid_low),
			self.matchcode := 0),
		left outer,
		local);

	join2 := join(distribute(in_links,hash64(beid_high)),low_beids,
		left.beid_high = right.beid_high,
		transform(Layout_Linking.Match,
			self.beid_high := left.beid_low,
			self.beid_low := right.beid_low,
			self.matchcode := 0),
		local);

	return dedup(dedup(join1 + join2,beid_high,beid_low,all,local),beid_high,beid_low,all);
	
end;

// This is the function for performing transitive closure of beid matches.
export Function_Closure(dataset(Layout_Linking.Match) in_links, unsigned1 in_iterations) := function

	// First, reverse links as necessary.
	links_corrected := project(in_links,
		transform(Layout_Linking.Match,
			self.beid_low := min(left.beid_low,left.beid_high),
			self.beid_high := max(left.beid_low,left.beid_high),
			self.matchcode := 0));
	
	links_deduped := dedup(dedup(links_corrected,beid_high,beid_low,all,local),beid_high,beid_low,all);
	
	closure_1 := inner_single_closure_function(links_deduped);
	closure_2 := inner_single_closure_function(closure_1);
	closure_3 := inner_single_closure_function(closure_2);
	closure_4 := inner_single_closure_function(closure_3);
	closure_5 := inner_single_closure_function(closure_4);
	closure_6 := inner_single_closure_function(closure_5);
	closure_7 := inner_single_closure_function(closure_6);
	closure_8 := inner_single_closure_function(closure_7);
	closure_9 := inner_single_closure_function(closure_8);
	closure_10 := inner_single_closure_function(closure_9);
	closure_11 := inner_single_closure_function(closure_10);
	closure_12 := inner_single_closure_function(closure_11);
	closure_13 := inner_single_closure_function(closure_12);
	closure_14 := inner_single_closure_function(closure_13);
	closure_15 := inner_single_closure_function(closure_14);
	closure_16 := inner_single_closure_function(closure_15);
	closure_17 := inner_single_closure_function(closure_16);
	closure_18 := inner_single_closure_function(closure_17);
	closure_19 := inner_single_closure_function(closure_18);
	closure_20 := inner_single_closure_function(closure_19);
	
	last_one := case(in_iterations,
		1 => closure_1,
		2 => closure_2,
		3 => closure_3,
		4 => closure_4,
		5 => closure_5,
		6 => closure_6,
		7 => closure_7,
		8 => closure_8,
		9 => closure_9,
		10 => closure_10,
		11 => closure_11,
		12 => closure_12,
		13 => closure_13,
		14 => closure_14,
		15 => closure_15,
		16 => closure_16,
		17 => closure_17,
		18 => closure_18,
		19 => closure_19,
		      closure_20);
	
	penultimate_one := case(in_iterations,
		1 => links_deduped,
		2 => closure_1,
		3 => closure_2,
		4 => closure_3,
		5 => closure_4,
		6 => closure_5,
		7 => closure_6,
		8 => closure_7,
		9 => closure_8,
		10 => closure_9,
		11 => closure_10,
		12 => closure_11,
		13 => closure_12,
		14 => closure_13,
		15 => closure_14,
		16 => closure_15,
		17 => closure_16,
		18 => closure_17,
		19 => closure_18,
		      closure_19);
	
	check_join := join(penultimate_one,last_one,
		left.beid_high = right.beid_high and
		left.beid_low = right.beid_low,
		transform(left),
		left only);
	
	// output(count(check_join));
	
	return dedup(sort(dedup(sort(last_one,beid_high,beid_low,local),beid_high,local),beid_high,beid_low),beid_high);

end;
