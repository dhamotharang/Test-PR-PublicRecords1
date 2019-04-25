// EXPORT Test_profile_attributes2 := 'todo';
EXPORT Test_profile_attributes2 (ds, at_name, min_, Max_, flag = false) := FUNCTIONMACRO

lay := record
string defaults;
end;


	INTEGER full_count_p := COUNT(ds);
	
	ds_slim_p := ds( (STRING) #expand(at_name) NOT IN ['']);
	
	slim_count_p := COUNT(ds_slim_p);

	sorted_ds_p := SORT(ds_slim_p, (real)#expand(at_name));
	
	// real full_min := (real)Min_;
	// real Full_max := (real)Max_;
	// output(Max_, named('Max_'));

	neg_one := -1;
	zero := 0;
	// bubble := 0.000001;
	
	
// -1 and 0 bin	
	neg_one_count := count(ds_slim_p((real)#expand(at_name) = -1));
	pct_neg1 := neg_one_count/slim_count_p;
	//should add logic stating that if -1 bin make up the entire population of sample then the max for this bin should be attribute max...  PB VerifiedPhone
	
	
	zero_count := count(ds_slim_p((real)#expand(at_name) = 0));
	pct_zero := zero_count/slim_count_p;	
	//should add logic stating that if -1 & 0 bin make up the entire population of sample then the max for this bin should be attribute max...  PB LienJudgmentForeclosureCount

	left_count := slim_count_p - Sum(zero_count + neg_one_count);
	start_bin1 := Sum(zero_count + neg_one_count);
	fifth_count := left_count/5;
	
//code for grouping attributes that have no numeric values like states, dwelltypes ect///
#if(flag = true)
// how to handle ITA v3__InputPhoneStatus bins are -1 and 2 other letter values, due to sample letters are not populated but should have bins avaiable for them??

table_of_vals := table(sorted_ds_p,{#expand(at_name),
																				Total := count(group)},
																						#expand(at_name));

table_lay := record
	string bin_lower_limit;
	string bin_upper_limit;
	integer Bin_cnt_slm;
	real bin_pct_slm;
end;




ds_sort_table := sort(table_of_vals, #expand(at_name));

table_lay table_trans(ds_sort_table le, integer c) := transform
	self.bin_lower_limit := ds_sort_table[c].#expand(at_name);
	self.bin_upper_limit := ds_sort_table[c].#expand(at_name);
	self.Bin_cnt_slm := (integer)ds_sort_table[c].Total;
	self.bin_pct_slm := (real)(ds_sort_table[c].Total/slim_count_p)*100;
end;

ds_table := project(ds_sort_table, table_trans(left, counter));


table_lay table_trans2(ds_table le, integer c) := transform
	self.bin_lower_limit := ds_table[c].bin_lower_limit;
	self.bin_upper_limit := ds_table[c].bin_upper_limit;
	self.Bin_cnt_slm := (integer)ds_table[c].Bin_cnt_slm;
	self.bin_pct_slm := (real)ds_table[c].bin_pct_slm;
end;



slim_profile := record
	string name;
	integer count_total;
	string full_range;
	
	dataset(table_lay) tbl;	
	end;

slim_profile trans(ut.ds_oneRecord le, integer c) :=  TRANSFORM
		SELF.name := at_name;
		SELF.count_total := slim_count_p;
		self.full_range := Min_ + ' ' +'-' + ' ' + max_;  
			  	self.tbl := project(ds_table, table_trans2(left, counter));	
end;


dset_slim := project(ut.ds_oneRecord, trans(left, counter));



slim_profile_quick := record
	string name;
	integer count_total;
	string full_range;
		string bin_lower_limit;
		string bin_upper_limit;
	integer Bin_cnt_slm;
	real bin_pct_slm;

	end;

slim_profile_quick NewChildren(dset_slim le, integer c) := TRANSFORM
		SELF.name := le.name;
		SELF.count_total := le.count_total;
		self.full_range := le.full_range;  
		self.bin_lower_limit := le.tbl[c].bin_lower_limit ;
		self.bin_upper_limit := le.tbl[c].bin_upper_limit ;
		self.Bin_cnt_slm := le.tbl[c].Bin_cnt_slm ;
		self.bin_pct_slm := le.tbl[c].bin_pct_slm ;

END;



dset_slim_quick := NORMALIZE(dset_slim,count(left.tbl),NewChildren(left, counter));
	
	return dset_slim_quick;
/////////////////////////////////////////////////////////////////////////////////////////////

// slim_file := dedup(sorted_ds_p, at_name);

// slim_distinct := record
	// string name;
	// integer count_total;
	// string full_range;
		// string bin_lower_limit;
		// string bin_upper_limit;
	// integer Bin_cnt_slm;
	// real bin_pct_slm;
	// end;

// slim_distinct trans(slim_file le):= transform 
// self.name := at_name;
// self.count_total := slim_count_p;
// self.full_range	 := '0';
// self.bin_lower_limit	 := '0';
// self.bin_upper_limit	 := '0';
// self := [];
// end;


// dset_slim_quick := project(slim_file, trans(left));
	
	// return dset_slim_quick;


#end

#if(flag = false)


//Bin 1
//first 20% after -1 and 0 are bined
first_twenty := choosen(sorted_ds_p, (fifth_count), start_bin1);
// output(choosen(first_twenty, all), named('first_twenty'));
// output((fifth_count), named('fifth_count'));

 Bin1_max_pre := max(first_twenty, (real)first_twenty.#expand(at_name));
// output(Bin1_max_pre, named('Bin1_max_pre'));


	ds_test_1 := sorted_ds_p((real)#expand(at_name) > (real)0 and (real)#expand(at_name)<= (real)Bin1_max_pre);
// output(ds_test_1, named('ds_test_1'));
	
	
	ds_test_cnt := count(sorted_ds_p((real)#expand(at_name) = (real)Bin1_max_pre));
// output(ds_test_cnt, named('ds_test_cnt'));

ds_test_cnt_11 := count(ds_test_1);
// output(ds_test_cnt_11, named('ds_test_cnt_11'));

// ds_less := sorted_ds_p((real)#expand(at_name) < (real)Bin1_max_pre); //1-3
ds_less := sorted_ds_p((real)#expand(at_name) > (real)0 and (real)#expand(at_name) < (real)Bin1_max_pre);
// output(ds_less, named('ds_less'));

ds_full_less_cnt := count(ds_less);
// output(ds_full_less_cnt, named('ds_full_less_cnt'));

max_less := max(ds_less, (real)ds_less.#expand(at_name));
// output(max_less, named('max_less'));


ds_less_cnt := count(sorted_ds_p((real)#expand(at_name) = max_less));
// output(ds_less_cnt, named('ds_less_cnt'));


ds_full := if((real)Max_ = (real)Bin1_max_pre, sorted_ds_p((real)#expand(at_name) = (real)Bin1_max_pre), sorted_ds_p((real)#expand(at_name) not between (real)Min_ and (real)Bin1_max_pre)); //6-255 
ds_full_test := if((real)Max_ = (real)Bin1_max_pre, 'option1', 'option2'); //5-255 
// output(ds_full_test, named('ds_full_test'));


ds_greater := sorted_ds_p((real)#expand(at_name) = min(ds_full, (real)ds_full.#expand(at_name))); //count values equal to five
// output(ds_greater, named('ds_greater'));

ds_full_cnt := count(ds_full);
// output(ds_full_cnt, named('ds_full_cnt'));

ds_greater_cnt := count(ds_greater);
// output(ds_greater_cnt, named('ds_greater_cnt'));


ds_abs1 := abs(ds_full_less_cnt - fifth_count);
// output(ds_abs1, named('ds_abs1'));
					
ds_abs2 := abs(ds_test_cnt_11 - fifth_count);
// output(ds_abs2, named('ds_abs2'));

 max_test_1 := if((ds_abs1 <= ds_abs2) and ((real)zero < max_less) , max_less, Bin1_max_pre);
// output(max_test_1, named('max_test_1'));


max_1 := map((ds_full_cnt/slim_count_p) < 0.001 => Max_,
							((ds_full_less_cnt/left_count) < 0.001) => Bin1_max_pre, max_test_1);
		// output(max_1, named('max_1'));

	
	First_GRP := sorted_ds_p((real)#expand(at_name) > 0 and (real)#expand(at_name)<= max_1);	
	First_grp_cnt := if(left_count = 0, 0, count(First_GRP))  ;
		// output(First_grp_cnt, named('First_grp_cnt'));

	First_pct :=if(left_count = 0, 0,First_grp_cnt/slim_count_p);		
	// output(First_pct, named('First_pct'));

	

//Bin 2

		left_count2 := slim_count_p - Sum(zero_count + neg_one_count + First_grp_cnt );

	second_start := Sum(zero_count + neg_one_count + First_grp_cnt );
		
	Bin1_max	:= if(second_start = slim_count_p, (real)Max_, (real)max_1);
		// output(Bin1_max, named('Bin1_max'));

		second_count := if(left_count2/4 <= 1 , 1, left_count2/4  );

second_twenty := choosen(sorted_ds_p, (second_count), second_start);
// output(choosen(first_twenty, all), named('first_twenty'));

 Bin2_max_pre := max(second_twenty, (real)second_twenty.#expand(at_name));
// output(Bin1_max_pre, named('Bin1_max_pre'));


	ds_test_2 := sorted_ds_p((real)#expand(at_name) > (real)max_1 and (real)#expand(at_name)<= (real)Bin2_max_pre);
	ds_test_cnt2 := count(sorted_ds_p((real)#expand(at_name) = (real)Bin2_max_pre));

ds_test_cnt_12 := count(ds_test_2);

// ds_less2 := sorted_ds_p((real)#expand(at_name) < (real)Bin2_max_pre); //1-3
ds_less2 := sorted_ds_p((real)#expand(at_name) > (real)max_1 and (real)#expand(at_name) < (real)Bin2_max_pre);

ds_full_less_cnt2 := count(ds_less2);

max_less2 := max(ds_less2, (real)ds_less2.#expand(at_name));


ds_less_cnt2 := count(sorted_ds_p((real)#expand(at_name) = max_less2));


ds_full2 := if((real)Max_ = (real)Bin2_max_pre, sorted_ds_p((real)#expand(at_name) = (real)Bin2_max_pre), sorted_ds_p((real)#expand(at_name) not between (real)Min_ and (real)Bin2_max_pre)); //5-255 
// ds_full_test2 := if((real)Max_ = (real)Bin2_max_pre, 'option1', 'option2'); //5-255 


ds_greater2 := sorted_ds_p((real)#expand(at_name) = min(ds_full2, (real)ds_full2.#expand(at_name))); //count values equal to five

ds_full_cnt2 := count(ds_full2);
ds_greater_cnt2 := count(ds_greater2);


ds_abs2_1 := abs(ds_full_less_cnt2 - second_count);
// output(ds_abs1, named('ds_abs1'));
					
ds_abs2_2 := abs(ds_test_cnt_12 - second_count);
// output(ds_abs2, named('ds_abs2'));

 max_test_2 := if((ds_abs2_1 <= ds_abs2_2) and ((real)max_1 < max_less2) , max_less2, Bin2_max_pre);
// output(max_test_1, named('max_test_1'));


max_2 := map((ds_full_cnt2/slim_count_p) < 0.001 => Max_,
							((ds_full_less_cnt2/left_count) < 0.001) => Bin2_max_pre, max_test_2);
		// output(max_2, named('max_1'));
	
	
	second_GRP := sorted_ds_p((real)#expand(at_name) > (real)max_1 and (real)#expand(at_name)<= max_2);	
	// output(second_GRP, named('second_GRP'));

		second_grp_cnt := if(left_count2 = 0, 0 , (integer)count(second_GRP))  ;
	second_pct :=if(left_count2 = 0,0 ,second_grp_cnt/slim_count_p);
	
	
	//Bin 3



		left_count3 := slim_count_p - Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt);

	third_start := Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt);
	
	// Third_count := left_count3/3;	
	Third_count := if(left_count3/3 <= 1 , 1, left_count3/3  );
	
	Bin2_max := if(third_start = slim_count_p, (real)Max_, (real)max_2);
	// output(Bin2_max, named('Bin2_max'));
	
	third_twenty := choosen(sorted_ds_p, (Third_count), third_start);
	third_twenty_cnt := count(third_twenty);
	
	 Bin3_max_pre := max(third_twenty, (real)third_twenty.#expand(at_name));


	ds_test_3 := sorted_ds_p((real)#expand(at_name) > (real)max_2 and (real)#expand(at_name)<= (real)Bin3_max_pre);
	ds_test_cnt3 := count(sorted_ds_p((real)#expand(at_name) = (real)Bin3_max_pre));

ds_test_cnt_13 := count(ds_test_3);

// ds_less3 := sorted_ds_p((real)#expand(at_name) < (real)Bin3_max_pre); //1-3
ds_less3 := sorted_ds_p((real)#expand(at_name) > (real)max_2 and (real)#expand(at_name) < (real)Bin3_max_pre);
ds_full_less_cnt3 := count(ds_less3);

max_less3 := max(ds_less3, (real)ds_less3.#expand(at_name));


ds_less_cnt3 := count(sorted_ds_p((real)#expand(at_name) = max_less3));


ds_full3 := if((real)Max_ = (real)Bin3_max_pre, sorted_ds_p((real)#expand(at_name) = (real)Bin3_max_pre), sorted_ds_p((real)#expand(at_name) not between (real)Min_ and (real)Bin3_max_pre)); //5-255 
// ds_full_test2 := if((real)Max_ = (real)Bin2_max_pre, 'option1', 'option2'); //5-255 


ds_greater3 := sorted_ds_p((real)#expand(at_name) = min(ds_full3, (real)ds_full3.#expand(at_name))); //count values equal to five

ds_full_cnt3 := count(ds_full3);
ds_greater_cnt3 := count(ds_greater3);


ds_abs3_1 := abs(ds_full_less_cnt3 - second_count);
// output(ds_abs1, named('ds_abs1'));
					
ds_abs3_2 := abs(ds_test_cnt_13 - second_count);
// output(ds_abs2, named('ds_abs2'));

 max_test_3 := if((ds_abs3_1 <= ds_abs3_2) and ((real)max_2 < max_less3) , max_less3, Bin3_max_pre);
// output(max_test_1, named('max_test_1'));


max_3 := map((ds_full_cnt3/slim_count_p) < 0.001 => Max_,
							((ds_full_less_cnt3/left_count) < 0.001) => Bin3_max_pre, max_test_3);
		// output(max_2, named('max_1'));
	
	third_GRP := sorted_ds_p((real)#expand(at_name) > (real)max_2 and (real)#expand(at_name)<= max_3);	
	// output(third_GRP);
		third_grp_cnt := if(left_count3 = 0, 0 , (integer)count(third_GRP))  ;
	third_pct :=if(left_count3 = 0,0 ,third_grp_cnt/slim_count_p);
	
	
	
	
	
	//bin4
	
	left_count4 := slim_count_p - Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt + third_grp_cnt);

	fourth_start := Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt + third_grp_cnt);
	
	// Half_count := left_count4/2;
	Half_count := if(left_count4/2 <= 1 , 1, left_count4/2  );
	
	
	Bin3_max := if(fourth_start = slim_count_p, (real)Max_, (real)max_3);
	// output(Bin3_max, named('Bin3_max'));
	
	fourth_twenty := choosen(sorted_ds_p, (Half_count), fourth_start);
	
	fourth_twenty_cnt := count(fourth_twenty);
	// Bin4_max := (integer)max(fourth_twenty, #expand(at_name));
	Bin4_max_pre := max(fourth_twenty, (real)fourth_twenty.#expand(at_name));
	
	ds_test_4 := sorted_ds_p((real)#expand(at_name) > (real)max_3 and (real)#expand(at_name)<= (real)Bin4_max_pre);
	ds_test_cnt4 := count(sorted_ds_p((real)#expand(at_name) = (real)Bin4_max_pre));

ds_test_cnt_14 := count(ds_test_4);

// ds_less4 := sorted_ds_p((real)#expand(at_name) < (real)Bin4_max_pre); //1-3
ds_less4 := sorted_ds_p((real)#expand(at_name) > (real)max_3 and (real)#expand(at_name) < (real)Bin4_max_pre);
ds_full_less_cnt4 := count(ds_less4);

max_less4 := max(ds_less4, (real)ds_less4.#expand(at_name));


ds_less_cnt4 := count(sorted_ds_p((real)#expand(at_name) = max_less4));


ds_full4 := if((real)Max_ = (real)Bin4_max_pre, sorted_ds_p((real)#expand(at_name) = (real)Bin4_max_pre), sorted_ds_p((real)#expand(at_name) not between (real)Min_ and (real)Bin4_max_pre)); //5-255 
// ds_full_test2 := if((real)Max_ = (real)Bin2_max_pre, 'option1', 'option2'); //5-255 


ds_greater4 := sorted_ds_p((real)#expand(at_name) = min(ds_full4, (real)ds_full4.#expand(at_name))); //count values equal to five

ds_full_cnt4 := count(ds_full4);
ds_greater_cnt4 := count(ds_greater4);


ds_abs4_1 := abs(ds_full_less_cnt4 - second_count);
// output(ds_abs1, named('ds_abs1'));
					
ds_abs4_2 := abs(ds_test_cnt_14 - second_count);
// output(ds_abs2, named('ds_abs2'));

 max_test_4 := if((ds_abs4_1 <= ds_abs4_2) and ((real)max_3 < max_less4) , max_less4, Bin4_max_pre);
// output(max_test_1, named('max_test_1'));


max_4 := map((ds_full_cnt4/slim_count_p) < 0.001 => Max_,
							((ds_full_less_cnt4/left_count) < 0.001) => Bin4_max_pre, max_test_4);
		// output(max_2, named('max_1'));
	
	fourth_GRP := sorted_ds_p((real)#expand(at_name) > (real)max_3 and (real)#expand(at_name)<= max_4);	
	
// output(choosen(fourth_GRP, all), named('fourth_GRP'));
		fourth_grp_cnt := if(left_count4 = 0, 0 , (integer)count(fourth_GRP))  ;
	fourth_pct :=if(left_count4 = 0,0 ,fourth_grp_cnt/slim_count_p);
	
	
	
	
	//bin5
	
		
	left_count5 := slim_count_p - Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt + third_grp_cnt + fourth_grp_cnt);


		fifth_start := Sum(zero_count + neg_one_count + First_grp_cnt + second_grp_cnt + third_grp_cnt + fourth_grp_cnt);
		
			Bin4_max := if(fifth_start = slim_count_p, (real)Max_, (real)max_4);
	
	
	fifth_GRP := sorted_ds_p((real)#expand(at_name) > (real)max_4 and (real)#expand(at_name)<= Max_);	
		fifth_grp_cnt := if(left_count5 = 0, 0 , (integer)count(fifth_GRP))  ;
	fifth_pct :=if(left_count5 = 0,0 ,fifth_grp_cnt/slim_count_p);
	
	
	
	
	stats_layout := RECORD
		STRING name;
		integer slim_count_p;
		integer Fifth_count;
		string full_range;
		
		string neg_one_bin_lower_limit;
		string neg_one_bin_upper_limit;
		integer neg_one_count;
		decimal20_4 pct_neg1;		
		
		string zero_bin_lower_limit;
		string zero_bin_upper_limit;
		integer zero_count;
		decimal20_4 pct_zero;
		
		integer left_count;
		
		
		integer First_grp_cnt;
		decimal20_4 first_pct;
		string bin1_lower_limit;
		string bin1_upper_limit;
		
		integer left_count2;
		
	
		integer second_grp_cnt;
		decimal20_4 second_pct;
		string bin2_lower_limit;
		string bin2_upper_limit;
		
		integer left_count3;
		
		integer third_grp_cnt;
		decimal20_4 third_pct;
		string bin3_lower_limit;
		string bin3_upper_limit;
				
				
		integer left_count4;
		
		integer fourth_grp_cnt;
		decimal20_4 fourth_pct;
		string bin4_lower_limit;
		string bin4_upper_limit;		
		
				integer left_count5;
		
		integer fifth_grp_cnt;
		decimal20_4 fifth_pct;
		string bin5_lower_limit;
		string bin5_upper_limit;				
		
		integer full_group_cnt;
		real full_group_pct;
		integer count_fields;
	END;

	
stats_layout add_stats(ut.ds_oneRecord le) :=  TRANSFORM
		SELF.name := at_name;
		self.slim_count_p := slim_count_p;
		
    self.full_range := Min_ + ' ' +'-' + ' ' + max_;  
		
		self.neg_one_bin_lower_limit := if(neg_one_count = 0, '','-1');
		// self.neg_one_bin_lower_limit := 
		self.neg_one_bin_upper_limit := if(neg_one_count = 0, '','-1');
		// self.neg_one_bin_upper_limit := if((integer)neg_one_count = 0, '', if(neg_one_count = slim_count_p, (string)max_, '-1'));
		self.neg_one_count := neg_one_count;
		self.pct_neg1 := pct_neg1*100;
		
		self.zero_bin_lower_limit := if(zero_count = 0, '','0');
		self.zero_bin_upper_limit := if(zero_count = 0, '','0');
		// self.zero_bin_upper_limit := if(zero_count = 0, '',if((neg_one_count+zero_count) = slim_count_p, (string)max_, '0'));
		self.zero_count := zero_count;
		self.pct_zero := pct_zero*100;
		
		self.left_count := left_count;
		self.Fifth_count := Fifth_count;
		
		
		self.First_grp_cnt := First_grp_cnt;
		self.bin1_lower_limit := if(First_grp_cnt = 0, '', (string)zero );
		self.bin1_upper_limit := if(First_grp_cnt = 0, '',(string)Bin1_max);

		self.first_pct := first_pct*100;
	
		self.left_count2 := left_count2;
	
	
		self.second_grp_cnt := second_grp_cnt;
		self.bin2_lower_limit := if(second_grp_cnt = 0, '', (string)Bin1_max );
		self.bin2_upper_limit := if(second_grp_cnt = 0, '', (string)Bin2_max);
		self.second_pct := second_pct*100;
	
		
		self.left_count3 := left_count3;
	
		self.third_grp_cnt := third_grp_cnt;
		self.bin3_lower_limit := if(third_grp_cnt = 0, '', (string)Bin2_max );
		self.bin3_upper_limit := if(third_grp_cnt = 0, '', (string)Bin3_max);
		self.third_pct := third_pct*100;
		
				self.left_count4 := left_count4;
	
		self.fourth_grp_cnt := fourth_grp_cnt;
		self.bin4_lower_limit := if(fourth_grp_cnt = 0, '', (string)Bin3_max );
		self.bin4_upper_limit := if(fourth_grp_cnt = 0, '', (string)Bin4_max);
		self.fourth_pct := fourth_pct*100;
	
	
			self.left_count5 := left_count5;
	
		self.fifth_grp_cnt := fifth_grp_cnt;
		self.bin5_lower_limit := if(fifth_grp_cnt = 0, '', (string)Bin4_max );
		self.bin5_upper_limit := if(fifth_grp_cnt = 0, '', (string)max_);
		self.fifth_pct := fifth_pct*100;
		
		self.full_group_cnt := neg_one_count + zero_count + First_grp_cnt + second_grp_cnt + third_grp_cnt + fourth_grp_cnt + fifth_grp_cnt;
		self.full_group_pct := (pct_neg1 + pct_zero + first_pct + second_pct + third_pct + fourth_pct + fifth_pct)*100;
		self.count_fields := count(-1, 0, Bin1_max, Bin2_max, Bin3_max, Bin4_max, max_);
	END; 
		dset := project(ut.ds_oneRecord, add_stats(left));


slim_profile2 := record
	string name;
	integer count_total;
	string full_range;
		string bin_lower_limit;
		string bin_upper_limit;
	integer Bin_cnt_slm;
	real bin_pct_slm;
	end;

slim_profile2 trans2(dset le, integer c) :=  TRANSFORM
		SELF.name := le.name;
		SELF.count_total := le.slim_count_p;
		self.full_range := le.full_range;  
			self.bin_lower_limit :=  CHOOSE((integer)c, le.neg_one_bin_lower_limit, le.zero_bin_lower_limit, le.bin1_lower_limit, le.bin2_lower_limit, le.bin3_lower_limit, le.bin4_lower_limit, le.bin5_lower_limit);
			self.bin_upper_limit :=  CHOOSE((integer)c, le.neg_one_bin_upper_limit, le.zero_bin_upper_limit, le.bin1_upper_limit, le.bin2_upper_limit, le.bin3_upper_limit, le.bin4_upper_limit, le.bin5_upper_limit);
			self.bin_pct_slm :=  CHOOSE((integer)c, le.pct_neg1, le.pct_zero, le.first_pct, le.second_pct, le.third_pct, le.fourth_pct, le.fifth_pct);
			self.Bin_cnt_slm :=  CHOOSE((integer)c, le.neg_one_count, le.zero_count, le.first_grp_cnt, le.second_grp_cnt, le.third_grp_cnt, le.fourth_grp_cnt, le.fifth_grp_cnt);
		end;

dset_slim2 :=
            NORMALIZE(dset, left.count_fields, trans2(LEFT,COUNTER));


clean_profiled := dset_slim2(bin_lower_limit	<> '' and bin_upper_limit	<> '');

	return clean_profiled;
#end

		
endmacro;

