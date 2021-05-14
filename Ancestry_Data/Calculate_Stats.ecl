
Import Watchdog, Data_Services, Infutor_NARC, Address, MDR, Infutor, Gong_Neustar;
Import Ancestry_Data;

Export Calculate_Stats( string pVersion ) := Module 

// Fiters
Shared tucs := mdr.sourceTools.src_TUCS_Ptrack;
Shared tracker := mdr.sourceTools.src_InfutorTRK;

//layouts
Shared matching_wd_layout := Ancestry_Data.Layouts.matching_wd_layout;
Shared comparing_layout := Ancestry_Data.Layouts.layout_watchdogvsbest;
Shared layout_infutor_best := Ancestry_Data.Layouts.layout_infutor_best;
Shared best_file_output := Ancestry_Data.Layouts.best_file_output;


// inputs 
Shared infutor_best := Ancestry_Data.Files.infutor_best(fname<>'' or lname<>'');
Shared watchdog := Ancestry_Data.files.watchdog_best;
Shared knowx := Ancestry_Data.Files.infutor_best_knowx;


// Watchdog dataset 
Shared watchdogDS := project(watchdog, transform(comparing_layout,
							self.LexID := left.did;
							self.first := left.fname;
							self.middle := left.mname;
							self.last := left.lname;
							self.suffix := left.name_suffix;
                            self.line1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir );
                            self.line2 := stringlib.stringcleanspaces(IF(left.sec_range='','',left.unit_desig+' '+left.sec_range ));
							self.city := left.city_name;
							self.state := left.st;
							self.lexid_class := left.adl_ind;
							self := left;
								));
// infutor best dataset
Shared bestfileDS := project(infutor_best, transform(comparing_layout,
							self.LexID := left.did;
							self.first := left.fname;
							self.middle := left.mname;
							self.last := left.lname;
							self.suffix := left.name_suffix;
                            self.line1 := stringlib.stringcleanspaces(left.prim_range + ' ' + left.predir + ' ' + left.prim_name + ' ' + left.suffix + ' ' + left.postdir );
                            self.line2 := stringlib.stringcleanspaces(IF(left.sec_range='','',left.unit_desig+' '+left.sec_range ));
							self.city := left.city_name;
							self.state := left.st;
							self.lexid_class := '';
							self := left;
								));


// stats records per source
tsrc_core := table(knowx, {src, source := mdr.sourceTools.TranslateSource(src), record_count := count(group)}, src, few);

sorted_table := sort(tsrc_core, -record_count );

Export total_persource := output(sorted_table, named('knowxcount_persource'));


// LexID classifications count in best file
join_watchdog := join( 
	distribute(watchdogDS, LexID ), // left watchdog
	distribute(bestfileDS, LexID ), // Right infutor best 
	left.LexID = right.LexID,
	transform(
		comparing_layout,
	    self.lexid_class := left.lexid_class;
		self := right;
	), right outer, local 
);

lexid_table := table(join_watchdog, {join_watchdog.lexid_class, record_count := count(group)}, lexid_class, few);

sorted_table := sort(lexid_table, -record_count );

Export lexid_stats := output(sorted_table, named('lexidclass_counts'));


// comparing watchdog and infutor best
matching_wd_layout MatchThem( bestfileDS Le, watchdogDS Ri ) := Transform

    self.LexID       := Le.LexID;

    self.first_match := map(Le.first = '' => 'B', Le.first = Ri.first => 'T', 'F');

	self.middle_match := map(Le.middle = '' => 'B',  Le.middle = Ri.middle => 'T', 'F');

    self.last_match := map(Le.last = '' => 'B', Le.last = Ri.last => 'T', 'F');
	
	self.suffix_match := map(Le.suffix = '' => 'B', Le.suffix = Ri.suffix => 'T', 'F');

    self.line1_match  := map(Le.line1 = ''  => 'B', Le.line1 = ri.line1 => 'T', 'F');

    self.line2_match := map(Le.line2 = '' => 'B', Le.line2 = Ri.line2 => 'T', 'F' );
    
	self.city_match := map(Le.city = '' => 'B', Le.city = Ri.city => 'T', 'F' );

	self.state_match := map(Le.state = '' => 'B', Le.state = Ri.state => 'T', 'F');

	self.zip_match := map(Le.zip = '' => 'B', Le.zip = Ri.zip => 'T', 'F' );

	self.dob_match   := map(Le.dob = 0  => 'B', Le.dob = Ri.dob => 'T', 'F');

    self.phone_match   := map(Le.phone = '' => 'B', Le.phone = Ri.phone => 'T', 'F'); 
End;

j_watchdog_match := join(bestfileDS, watchdogDS , Left.LexID = Right.LexID, MatchThem(Left, Right), Local );

sort_watchdog_match  := sort(j_watchdog_match, Lexid, first_match, middle_match, last_match,suffix_match
										 ,line1_match, line2_match, city_match,state_match, zip_match, local );

watchdog_match := dedup(sort_watchdog_match, Lexid, first_match, middle_match, last_match,suffix_match
										 ,line1_match, line2_match, city_match,state_match, zip_match, local, All ); 
// Exports comparingson of header file agaisnt watchdog unrolled

matching_wd_layout FormFlagged( watchdog_match Le, watchdog_match Ri ) := Transform
    Self := Le;
    Self := Ri;
End;

flaggedRec := rollup(watchdog_match, 
                            Left.Lexid = Right.Lexid,
                            FormFlagged(Left, Right));

// watchdog_match_stats
totalRec := count(bestfileDS);
// first names 
matchingFirst := count(flaggedRec(first_match = 'T'));
unpopulatedFirst := count(flaggedRec(first_match = 'B'));
firstmatchPerc := ((matchingFirst / totalRec ) * 100);
firstblankPerc := ((unpopulatedFirst / totalRec ) * 100);
// middle names
matchingMiddle := count(flaggedRec(middle_match = 'T'));
unpopulatedMiddle := count(flaggedRec(middle_match = 'B'));
middlematchPerc :=  ((matchingMiddle / totalRec ) * 100);
middleblankPerc :=  ((unpopulatedMiddle / totalRec ) * 100);
// last names 
matchingLast := count(flaggedRec(last_match = 'T'));
unpopulatedLast := count(flaggedRec(last_match = 'B'));
lastmatchPerc :=  ((matchingLast / totalRec ) * 100);
lastblankPerc :=  ((unpopulatedLast / totalRec ) * 100);
// suffix
matchingSuffix := count(flaggedRec(suffix_match = 'T'));
unpopulatedSuffix := count(flaggedRec(suffix_match = 'B'));
suffixmatchPerc := ((matchingSuffix / totalRec ) * 100);
suffixblankPerc := ((unpopulatedSuffix / totalRec ) * 100);
// line1
matchingLine1 := count(flaggedRec(line1_match = 'T'));
unpopulatedLine1 := count(flaggedRec(line1_match = 'B'));
line1matchPerc :=  ((matchingLine1 / totalRec ) * 100);
line1blankPerc :=  ((unpopulatedLine1 / totalRec ) * 100);
// line2
matchingLine2 := count(flaggedRec(line2_match = 'T'));
unpopulatedLine2 := count(flaggedRec(line2_match = 'B'));
line2matchPerc :=  ((matchingLine2 / totalRec ) * 100);
line2blankPerc :=  ((unpopulatedLine2 / totalRec ) * 100);
// city 
matchingCity := count(flaggedRec(city_match = 'T'));
unpopulatedCity := count(flaggedRec(city_match = 'B'));
citymatchPerc :=  ((matchingCity / totalRec ) * 100);
cityblankPerc :=  ((unpopulatedCity / totalRec ) * 100);
// state
matchingState := count(flaggedRec(state_match = 'T'));
unpopulatedState := count(flaggedRec(state_match = 'B'));
statematchPerc :=  ((matchingState / totalRec ) * 100);
stateblankPerc :=  ((unpopulatedState / totalRec ) * 100);
// zip 
matchingZip := count(flaggedRec(zip_match = 'T'));
unpopulatedZip := count(flaggedRec(zip_match = 'B'));
zipmatchPerc :=  ((matchingZip / totalRec ) * 100);
zipblankPerc :=  ((unpopulatedZip / totalRec ) * 100);
// dob
matchingDob := count(flaggedRec(dob_match = 'T'));
unpopulatedDob := count(flaggedRec(dob_match = 'B'));
dobmatchPerc :=  ((matchingDob / totalRec ) * 100);
dobblankPerc :=  ((unpopulatedDob / totalRec ) * 100);
// phone
matchingPhone := count(flaggedRec(phone_match = 'T'));
unpopulatedPhone := count(flaggedRec(phone_match = 'B'));
phonematchPerc :=  ((matchingPhone / totalRec ) * 100);
phoneblankPerc :=  ((unpopulatedPhone / totalRec ) * 100);

Export matching_stats := output(dataset([
						   {'First Name', firstmatchPerc, firstblankPerc},
						   {'Middle Name', middlematchPerc, middleblankPerc},
						   {'Last Name', lastmatchPerc, lastblankPerc},
						   {'Suffix', suffixmatchPerc, suffixblankPerc},
						   {'Addres1', line1matchPerc, line1blankPerc},
						   {'Address2', line2matchPerc, line2blankPerc},
						   {'City', citymatchPerc, cityblankPerc},
						   {'State', statematchPerc, stateblankPerc},
						   {'Zip', zipmatchPerc, zipblankPerc},
						   {'Date of Birth', dobmatchPerc, dobblankPerc},
						   {'Phone Number', phonematchPerc, phoneblankPerc}],
						   {string data_type, decimal5_2 match_percentage, decimal5_2 blank_percentage}), named('matchingwd_stats'));



// inputs directily from source to get accurate stats 
Shared narctotalrecs := count(Ancestry_Data.Files.input_ds_narc);
Shared knowxtotalrecs := count(Ancestry_Data.Files.infutor_best_knowx(src not in [tucs, tracker]));
Shared tucstotalrecs := count(Ancestry_Data.Files.infutor_best_knowx(src in [tucs]));
Shared trackertotalrecs := count(Ancestry_Data.Files.infutor_best_knowx(src in [tracker]));


// aka_file stats
akatotalrecs := count(Ancestry_Data.Aka_File(pversion).outputDS);

akacntnarc := count(Ancestry_Data.Aka_File(pversion).narcdata);
akacntknowx := count(Ancestry_Data.Aka_File(pversion).adding_knowx);
akacnttucs := count(Ancestry_Data.Aka_File(pversion).adding_tucsonly);
akacnttracker := count(Ancestry_Data.Aka_File(pversion).adding_trackeronly);

totalakainputs := ( akacntnarc + akacntknowx + akacnttucs + akacnttracker );

akapercoutput := ((akatotalrecs / totalakainputs ) * 100);
akapercnarc := ((akacntnarc / narctotalrecs ) * 100);
akapercknowx := ((akacntknowx / knowxtotalrecs ) * 100);
akaperctucs := ((akacnttucs / tucstotalrecs ) * 100);
akaperctracker := ((akacnttracker / trackertotalrecs ) * 100);

Export akatotals_stats := output(dataset([
				{'Output Dataset', akatotalrecs, akapercoutput, 'Total of records in the output compared to inputs'},
				{'Narc', akacntnarc, akapercnarc, 'The total of records from Narc'},
				{'Knowx', akacntknowx, akapercknowx, 'The total of records from knowx'},
                {'Tucs', akacnttucs, akaperctucs, 'The total of records from Tucs'},
                {'Tracker', akacnttracker, akaperctracker, 'The total of records from Tracker'}],
                {string source, integer record_count, decimal5_2 percentage, string description}), named('aka_stats'));


// hist_address_file stats 
addresstotalrecs := count(Ancestry_Data.Hist_Addresses_File(pversion).outputDS);

addresscntnarc := count(Ancestry_Data.Hist_Addresses_File(pversion).narcdata);
addresscntknowx := count(Ancestry_Data.Hist_Addresses_File(pversion).adding_knowx);
addresscnttucs := count(Ancestry_Data.Hist_Addresses_File(pversion).adding_tucsonly);
addresscnttracker := count(Ancestry_Data.Hist_Addresses_File(pversion).adding_trackeronly);

totalhistinputs := ( addresscntnarc + addresscntknowx + addresscnttucs + addresscnttracker );

addresspercoutput := ((addresstotalrecs / totalhistinputs ) * 100);
addresspercnarc := ((addresscntnarc / narctotalrecs ) * 100);
addresspercknowx := ((addresscntknowx / knowxtotalrecs ) * 100);
addressperctucs := ((addresscnttucs / tucstotalrecs ) * 100);
addressperctracker := ((addresscnttracker / trackertotalrecs ) * 100);

Export histaddresstotals_stats := output(dataset([
				{'Output Dataset', addresstotalrecs, addresspercoutput, 'Total of records in the output compared to input'},
                {'Narc', addresscntnarc, addresspercnarc, 'The total of records from Narc'},
				{'Knowx', addresscntknowx, addresspercknowx, 'The total of records from knowx'},
                {'Tucs', addresscnttucs, addressperctucs, 'The total of records from Tucs'},
                {'Tracker', addresscnttracker, addressperctracker, 'The total of records from Tracker'}],
                {string source, integer record_count, decimal5_2 percentage, string description}), named('hist_address_stats'));  

Export Calculate_AllStats := parallel(total_persource, lexid_stats, matching_stats, akatotals_stats, histaddresstotals_stats );

End;