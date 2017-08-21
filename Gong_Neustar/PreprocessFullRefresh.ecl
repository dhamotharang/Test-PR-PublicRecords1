import ut;

	r1 := record
		Layout_Neustar;
		unsigned8	seq;								// we want to recover the original seqence
		boolean is_res;
		boolean has_any_orig;
	end;
	
	r1 xform1(layout_Neustar le, unsigned8 c) := transform
		self.seq := c;
	 self.is_res := le.record_type='R';
	 self.has_any_orig := le.Original_Last_Name<>'' OR le.Original_First_Name<>'' OR le.Original_Middle_Name<>''
												OR le.Original_Suffix <>'' OR le.Original_Address<>'' OR le.Original_Last_Line<>'';
	 self := le;
	end;
	
processHouseholds(dataset(layout_Neustar) rawhh, dataset(layout_Neustar) nothh, string8 rundate) := FUNCTION
	//hh1 := DEDUP(rawhh,RECORD, EXCEPT unknownField, TransactionID, latitude, longitude, filename, ALL);

	// remove households that have a record id that is also not a household
	//hh2 := DEDUP(JOIN(DISTRIBUTE(rawhh,hash(record_id)), DISTRIBUTE(nothh,hash(record_id)), LEFT.RECORD_ID=RIGHT.RECORD_ID, LEFT ONLY, LOCAL),RECORD, EXCEPT unknownField,ALL);
hh2 := rawhh;
	hh3 := SORT(DISTRIBUTE(hh2, HASH(record_id)),
							record_id, last_name, suffix_name, first_name, middle_name,
							PRE_DIR,PRIMARY_STREET_NAME,PRIMARY_STREET_SUFFIX,POST_DIR,SECONDARY_RANGE,CITY,STATE,ZIP_CODE, LOCAL);
	
	// select the earliest add date
	hh4 := ROLLUP(hh3, TRANSFORM(recordof(hh2),
									self.add_date := Earlier(LEFT.add_date, RIGHT.add_date, rundate);
									self := LEFT;),
							record_id, last_name, suffix_name, first_name, middle_name,
							PRE_DIR,PRIMARY_STREET_NAME,PRIMARY_STREET_SUFFIX,POST_DIR,SECONDARY_RANGE,CITY,STATE,ZIP_CODE, LOCAL);

	hh5 := DISTRIBUTE(hh4(telephone<>''), hash(telephone));

	dnothh := DISTRIBUTE(nothh,hash(telephone));
	// match household to matching non-household and choose earlier add date
	j := JOIN(hh5, dnothh,
				LEFT.telephone=RIGHT.telephone AND
				UC(LEFT.PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.POST_DIR) = UC(RIGHT.POST_DIR) AND
				UC(LEFT.SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.STATE) = UC(RIGHT.STATE) AND
				UC(LEFT.ZIP_CODE) = UC(RIGHT.ZIP_CODE)
							,
							TRANSFORM(gong_neustar.Layout_Neustar,
									self.add_date := earlier(LEFT.add_date,RIGHT.add_date, rundate);
									self := LEFT;), INNER, LOCAL);
									
	j1d := SORT(DISTRIBUTE(j, HASH(record_id)),
							record_id, last_name, suffix_name, first_name, middle_name,
							PRIMARY_STREET_NUMBER,PRE_DIR,PRIMARY_STREET_NAME,PRIMARY_STREET_SUFFIX,POST_DIR,
							SECONDARY_RANGE,CITY,STATE,ZIP_CODE, LOCAL);
	j1 := ROLLUP(j1d, TRANSFORM(recordof(j1d),
									self.add_date := Earlier(LEFT.add_date, RIGHT.add_date, rundate);
									self := LEFT;),
							record_id, last_name, suffix_name, first_name, middle_name,
							PRIMARY_STREET_NUMBER,PRE_DIR,PRIMARY_STREET_NAME,PRIMARY_STREET_SUFFIX,POST_DIR,
							SECONDARY_RANGE,CITY,STATE,ZIP_CODE, LOCAL);

	// these are new households without a matching non-household residence
	j2 := JOIN(hh5, dnothh, 
				LEFT.telephone=RIGHT.telephone AND
				UC(LEFT.PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.POST_DIR) = UC(RIGHT.POST_DIR) AND
				UC(LEFT.SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.STATE) = UC(RIGHT.STATE) AND
				UC(LEFT.ZIP_CODE) = UC(RIGHT.ZIP_CODE),
							TRANSFORM(gong_neustar.Layout_Neustar,
									self := LEFT;), LEFT ONLY, LOCAL);
									
		return PROJECT(j1 + j2 + hh4(telephone=''), TRANSFORM(layout_Neustar,
									SELF.DATA_SOURCE := 'HH';			// create pseudo data source
									SELF := LEFT;));
END;

EXPORT PreprocessFullRefresh(dataset(layout_Neustar) fullRefresh,string rundate = ut.Now()) := function
//
// as of 25 Aug 2014, begin including all household records
//	
	
	// add a sequence number to recover original order
	ful1 := PROJECT(FullRefresh(action_code in ['A','I']), TRANSFORM(Layout_Neustar,
										self.unknownField := IntFormat(COUNTER, 10, 0);	// in order to return to original sequence
										self := LEFT;
								));
								
	//ful := DEDUP(ful1,RECORD, EXCEPT unknownField, TransactionID, latitude, longitude, filename, ALL);
	ful := DEDUP(ful1,RECORD, EXCEPT unknownField, TransactionID,UNLICENSED, latitude, longitude, LAT_LONG_MATCH_LEVEL,
								Original_Suffix,Original_First_Name,
								Original_Middle_Name, Original_Last_Name,
								Original_Address, Original_Last_Line,						
						filename,
						ALL);
								
	hh_candidates := ful(record_type='R', Listing_Type<>'P', Original_Last_Name='', Original_First_Name='', Original_Middle_Name='',
														Original_Suffix ='', Original_Address='', Original_Last_Line='');
														
	nothh := ful(record_type<>'R' OR Listing_Type='P' OR Original_Last_Name<>'' OR Original_First_Name<>'' OR Original_Middle_Name<>''
														OR Original_Suffix <>'' OR Original_Address<>'' OR Original_Last_Line<>'');
														
	hh := processHouseholds(hh_candidates, nothh(record_type='R',telephone<>''), rundate);
	
	adds := SORT(nothh + hh, (integer)UnknownField); 
	
	return adds;
											
	//return ProcessAdds(adds, rundate);
																						
end;

// Old version
/*
EXPORT PreprocessFullRefresh(dataset(layout_Neustar) fullRefresh,string rundate = ut.Now()) := function
	
	preAdds := project(FullRefresh(action_code in ['A','I']),
														xform1(left,COUNTER));
	
	adds := preAdds(
							record_type<>'R' OR Listing_Type='P' OR Original_Last_Name<>'' OR Original_First_Name<>'' OR Original_Middle_Name<>''
														OR Original_Suffix <>'' OR Original_Address<>'' OR Original_Last_Line<>'');



	p1 := sort(distribute(preAdds(telephone<>''),hash(telephone)),telephone,local);

	r1 xform2(p1 le, p1 ri) := transform
	 self.is_res := if(le.is_res=true,true,false);
	 self.has_any_orig := if(le.has_any_orig=true,le.has_any_orig,ri.has_any_orig);
	 self := le;
	end;

	p2 := rollup(p1,left.telephone=right.telephone,xform2(left,right),local);	
	p2a := p2(is_res and NOT has_any_orig);
	p3 := JOIN(p1,p2a,left.telephone=right.telephone,
								TRANSFORM(r1, self := LEFT), local);
			// added households
	hh := p3(record_type='R', Listing_Type<>'P', Original_Last_Name='', Original_First_Name='', Original_Middle_Name='',
														Original_Suffix ='', Original_Address='', Original_Last_Line='');
								
	processed := PROJECT(SORT(adds & hh, seq), layout_Neustar); 
												
	return PreprocessAdds(processed, rundate);
																						
end;
*/