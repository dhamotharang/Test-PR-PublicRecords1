import doxie,ut;

//***** Searches by phone or address
gon := Fedex_Services.mod_Searches.GongSearch;
pho := Fedex_Services.mod_Searches.PhonesPlusSearch;
bus := Fedex_Services.mod_Searches.BusinessSearch;
hea := Fedex_Services.mod_Searches.HeaderSearch;			//this includes the gong search
can := Fedex_Services.mod_Searches.Canada;
fed := Fedex_Services.mod_Searches.FedexNoHit;
empty := dataset([],layouts.out);

//***** Get everything in the same format and filter out some junk
f_gon := if(Fedex_Services.Inputs.CustomerDataOnly,empty,Fedex_Services.mod_Formatting.GongFormat(gon));
f_pho := if(Fedex_Services.Inputs.CustomerDataOnly,empty,Fedex_Services.mod_Formatting.PhonesPlusFormat(pho));
f_bus := if(Fedex_Services.Inputs.CustomerDataOnly,empty,Fedex_Services.mod_Formatting.BusinessFormat(bus));
f_hea := if(Fedex_Services.Inputs.CustomerDataOnly,empty,Fedex_Services.mod_Formatting.HeaderFormat(hea));
f_can := if(Fedex_Services.Inputs.CustomerDataOnly,empty,Fedex_Services.mod_Formatting.CanadaFormat(can));
f_fed := Fedex_Services.mod_Formatting.FedexNoHitFormat(fed);

CustomerDataMaxRecords_Limit:=
									map(Fedex_Services.Inputs.CustomerDataMaxRecords>0 and Fedex_Services.Inputs.CustomerDataMaxRecords>Fedex_Services.Contants.max_FedexSourcedResultsAdminMax => Fedex_Services.Contants.max_FedexSourcedResultsAdminMax,
											Fedex_Services.Inputs.CustomerDataMaxRecords>0 => Fedex_Services.Inputs.CustomerDataMaxRecords,
											Fedex_Services.Contants.max_FedexSourcedResultsAdmin);
//***** A function for sorting a deduping and calling Fedex_Services.fn_CheckAddrType
outrec := Fedex_Services.Layouts.out;
// outrec_penalty := Fedex_Services.Layouts.out_penalty;
outrec doRollup(outRec l, DATASET(outRec) allRows) := TRANSFORM
	//If the record has a name field take it, 
	//  	if no value, see if any row has a name and take the first one you have.
	//The logic assumes that we are returning a consolidated record and they will be editing all fields
	//cleaning up or removing things that are not needed in the name and company name fields.
	SELF.fname := if(l.fname <> '', l.fname, allRows(fname <> '')[1].fname);
	SELF.mname := if(l.mname <> '', l.mname, allRows(mname <> '')[1].mname);
	SELF.lname := if(l.lname <> '', l.lname, allRows(lname <> '')[1].lname);
	SELF.company_name := if(l.company_name <> '', l.company_name, allRows(company_name <> '')[1].company_name);
	self := l;
END;

outrec fn_SortDedupCustomerData(dataset(outrec) ds_forsort) := function
	ds_sorted 	:= group(sort(ds_forsort, record_id),record_id);	
	ds_rollup 	:= rollup(ds_sorted, group, doRollup(left, rows(left)));
	ds_choosen_matched := ds_rollup(penalt = 0);
	ds_choosen_filtered := if (Fedex_Services.Contants.PreferStrictMatch and exists(ds_choosen_matched), ds_choosen_matched, ds_rollup);
	ds_return 	:= sort(Fedex_Services.fn_CheckAddrType(ds_choosen_filtered), 
											penalt, -dt_last_seen, record);
	return ds_return;
end;
outrec fn_SortDedup(dataset(outrec) ds_forsort) := function
	ds_sorted 			:= sort(ds_forsort, if(isFedexRecord, 0, 1), penalt, -dt_last_seen, record);	
	ds_choosen 	:= 
		choosen(
			choosen(ds_sorted(isFedexRecord), if(Fedex_Services.Inputs.CustomerDataOnly,CustomerDataMaxRecords_Limit,Fedex_Services.Contants.max_FedexSourcedResults)) &  
			choosen(ds_sorted(~isFedexRecord), Fedex_Services.Contants.max_results),										
			Fedex_Services.Contants.max_results
		);
	
	// if we found exact matches, keep only those records
	ds_choosen_matched := ds_choosen(penalt = 0);
	ds_choosen_filtered := if (Fedex_Services.Contants.PreferStrictMatch and exists(ds_choosen_matched), ds_choosen_matched, ds_choosen);
	ds_return 	:= sort(Fedex_Services.fn_CheckAddrType(ds_choosen_filtered), 
											if(isFedexRecord, 0, 1), penalt, -dt_last_seen, record);
	return ds_return;
end;

outrec applyPenalty(outrec l) := transform
	self.penalt := doxie.Fn_Tra_Penalty_Phone(l.phone) +
								 doxie.FN_Tra_Penalty_Addr(l.predir,l.prim_range,l.prim_name,l.addr_suffix,
									 											   l.postdir,l.sec_range,l.v_city_name,l.st,l.zip5) +									
								 if(trim(Fedex_Services.Inputs.lname,all)=l.lname[1..length(trim(Fedex_Services.Inputs.lname,all))] or
										trim(Fedex_Services.Inputs.lname,all)=l.company_name[1..length(trim(Fedex_Services.Inputs.lname,all))],
										0,
										MIN(doxie.FN_Tra_Penalty_Name(l.fname,'',l.lname),
											  ut.companysimilar(l.company_name,Fedex_Services.Inputs.lname,true)));
	self := l;
end;

//***** Results by phone - Get ready for output - Rollup, add info, sort, choosen
dophone 				:= Fedex_Services.Inputs.valid_phone;
byphone 					:= f_fed +
										 map(
											Fedex_Services.Inputs.IsCanadaSearch => f_can,
											exists(f_gon) => f_gon, 
											exists(f_pho) => f_pho, 
											f_bus
										 );			//if no current EDA match, use phones+, otherwise business 
byphone_rolled 		:= Fedex_Services.fn_Rollup(byphone);
//byphone_checked		:= Fedex_Services.fn_CheckIfAptBuilding(byphone_rolled);
byphone_penalized	:= project(byphone_rolled, applyPenalty(left));
byphone_results		:= if(Fedex_Services.Inputs.CustomerDataOnly,choosen(fn_SortDedupCustomerData(project(byphone, applyPenalty(left))),CustomerDataMaxRecords_Limit),fn_SortDedup(byphone_penalized));			


//***** Results by address - Get ready for output - Rollup, add info, sort, choosen
doaddr 					:= Fedex_Services.Inputs.valid_addr;
byaddr 					:= f_fed +
									 map(
											Fedex_Services.Inputs.IsCanadaSearch => f_can,
											f_pho + f_bus + f_hea  //no gong since it is included in hea
									 );
byaddr_rolled 	 := Fedex_Services.fn_Rollup(byaddr);
//byaddr_checked	 := Fedex_Services.fn_CheckIfAptBuilding(byaddr_rolled);
byaddr_lname	 	 := if(exists(byaddr_rolled(exact_lname_match)), byaddr_rolled(leading_lname_match), byaddr_rolled);
byaddr_penalized := project(byaddr_lname, applyPenalty(left));
byaddr_results   := if(Fedex_Services.Inputs.CustomerDataOnly,choosen(fn_SortDedupCustomerData(project(byaddr, applyPenalty(left))),CustomerDataMaxRecords_Limit),fn_SortDedup(byaddr_penalized));

//***** Multi-state return for case when an ambiguous phone is used
domulti 					:= dophone and 
										 not doaddr and 
										 not Fedex_Services.Inputs.valid_state and
										 count(byphone_rolled(dophone)) > Fedex_Services.Contants.max_results and
										 count(dedup(byphone_rolled(dophone), st, all)) > 1;
multi_results 		:= if(Fedex_Services.Inputs.CustomerDataOnly,byphone,Fedex_Services.fn_BuildMulti(byphone_rolled));


//***** Pick and return my result set
export mod_AddressPreFill := 
MODULE

	export isMultiStateReturn := domulti;

	export Records := 
		map(
			domulti		=> multi_results,
			dophone		=> byphone_results, 
			doaddr		=> byaddr_results,
			fail(outrec, 301, doxie.ErrorCodes(301))
		);

/* fn_bogusphone work that may or may not be needed later

	export Records := 
		map(
			domulti		=> multi_results,
			dophone		=> byphone_results, 
			doaddr		=> byaddr_results,
			Fedex_Services.Inputs.valid_phone_len and not Fedex_Services.Inputs.valid_npanxx
								=> fail(outrec, 320, doxie.ErrorCodes(320)),
			fail(outrec, 301, doxie.ErrorCodes(301))
		);
	
*/

	
END;


//** DEBUG
// output(gon,named('gon'));
// output(f_gon,named('f_gon'));
// output(pho,named('pho'));
// output(f_pho,named('f_pho'));
// output(bus,named('bus'));
// output(f_bus,named('f_bus'));
// output(hea,named('hea'));
// output(f_hea,named('f_hea'));
// output(can,named('can'));
// output(f_can,named('f_can'));
// output(fed,named('fed'));
// output(f_fed,named('f_fed'));

// output(byphone, named('byphone'));
// output(byphone_rolled, named('byphone_rolled'));
// output(byphone_penalized, named('byphone_penalized'));
// output(byphone_sorted, named('byphone_sorted'));

// output(byaddr, named('byaddr'));
// output(byaddr_rolled, named('byaddr_rolled'));
// output(byaddr_penalized, named('byaddr_penalized'));
// output(byaddr_sorted, named('byaddr_sorted'));

// output(dophone, named('dophone'));
// output(not doaddr, named('notdoaddr'));
// output(not Fedex_Services.Inputs.valid_state, named('notFedex_ServicesInputsvalid_state'));
// output(count(byphone_rolled) > Fedex_Services.Contants.max_results, named('countbig'));
// output(count(dedup(byphone_rolled, st, all)) > 1, named('manystates'));
// output(domulti, named('domulti'));
// output(byphone_rolled, named('byphone_rolled'));
// output(multi_results, named('multi_results'));
