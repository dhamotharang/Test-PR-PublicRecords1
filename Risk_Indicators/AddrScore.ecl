// expecting 2 5 byte zips, one input and one cleaned
import ut,address;

export AddrScore := module

export citystate_score(string city1, string state1, string city2, string state2, string1 cityzipflag) := function
	city_a := stringlib.stringtouppercase(trim(city1));
	city_b := stringlib.stringtouppercase(trim(city2));
	state_a := stringlib.stringtouppercase(trim(state1));
	state_b := stringlib.stringtouppercase(trim(state2));
		
	city_score := 100 - MAX(ut.StringSimilar100(city_a, city_b), ut.StringSimilar100(city_b, city_a));	

	score := map(city_a='' or state_a='' or city_b='' or state_b='' => 255,
							 city_score between 80 and 100 and state_a=state_b => 100,  
							 	// consider if the first city is actually a vanity city name if the city_score didn't already give this a 100
							 cityzipflag='0' and state_a=state_b => 100,  
							 0);
	return score;
end;
			
export zip_score(string zip1, string zip2) := function
	zip_a := trim(zip1);
	zip_b := trim(zip2);
	score := map(zip_a='' or zip_b='' => 255,
							 zip_a=zip_b => 100,
								0);
	return score;
end;

export primRange_score(string primRange1, string primRange2) := function
	primRange_a := trim(primRange1);
	primRange_b := trim(primRange2);
	score := map(primRange_a='' or primRange_b='' => 255,
							 primRange_a=primRange_b => 100,
								0);
	return score;
end;

// default the zip_score and citystate_score to 100 for the cases when we only want 
// to compare the street address and ignore the zip and city/state
export AddressScore(string prim_range1,string prim_name1,string sec_range1,
			  string prim_range2,string prim_name2,string sec_range2,
				integer zip_score=100, integer citystate_score=100, string street_addr1 = '', string street_addr2 = '') := function
				
	addr_clean1 := Risk_Indicators.MOD_AddressClean.street_address(street_addr1, prim_range1, '', prim_name1, '', '', '', sec_range1);
	addr_clean2 := Risk_Indicators.MOD_AddressClean.street_address(street_addr2, prim_range2, '', prim_name2, '', '', '', sec_range2);
	addr_score1 := (10 * MAX(ut.StringSimilar(addr_clean1, addr_clean2), ut.StringSimilar(addr_clean2, addr_clean1)));
	
	// need to override the address score with just the box score if it's a miskeyed box number (addr_score1 between 0 and 20)
	POBOX := 'PO BOX';
	both_po_boxes := trim(prim_name1[1..6])=POBOX and trim(prim_name2[1..6])=POBOX;
	box1 := trim(prim_name1[7..]);
	box2 := trim(prim_name2[7..]);
	box_score := (10 * MAX(ut.StringSimilar(box1, box2), ut.StringSimilar(box2, box1)));
	addr_score := if(both_po_boxes and addr_score1 between 0 and 20, box_score, addr_score1);
	
	score := MAP(prim_name1='' OR prim_name2='' => 255,	// if any input is blank then 255
			zip_score=255 and citystate_score=255 => 255,  // city state and zip missing, then 255
	    zip_score<>100 and citystate_score<>100 => 12,	// default to a 12 if zipcodes don't match, or citystate mismatch (so we can easily identify this situation)			
		  ut.StringSimilar(prim_name1,prim_name2)!=0 or ut.StringSimilar(prim_range1,prim_range2)!=0 => 
					 100 - addr_score,
	    ut.stringsimilar(sec_range1,sec_range2)=0 => 100,
	    ut.NNEQ(sec_range1,sec_range2) => 80,
	    sec_range1 != sec_range2 => 100 - addr_score,
	    255);

	return score;

end;



end;