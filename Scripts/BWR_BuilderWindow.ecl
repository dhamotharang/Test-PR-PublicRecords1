IMPORT $, Watchdog;

//#option('outputlimit', 2000);
//OUTPUT($.Stats.SortedTout0, NAMED('High_Fname_Counts'));
//OUTPUT($.Stats.SortedTout1, NAMED('High_LastName_Counts'));
//OUTPUT($.Stats.SortedT0, NAMED('Field_Population_Percentgae_Per_Src'));
//OUTPUT($.Stats.SSNPerLexid, NAMED('SSNs_Per_Lexid'));
//OUTPUT($.Stats.CountedFile, NAMED('Counted_Child_SSNPerLExid'));
//OUTPUT($.Stats.LexidPerSSN, NAMED('Lexids_Per_SSN'));
//OUTPUT($.Stats.CountedFile1, NAMED('Counted_Child_LexidPerSSN'));
//OUTPUT($.Stats.AddyPerLexid, NAMED('Address_Per_Lexid'));
//OUTPUT($.Stats.CountFile2, NAMED('Counted_Child_LexPerAddy'));
//OUTPUT($.Stats.LexPerAddy, NAMED('Lexid_Per_Address'));
//OUTPUT($.Stats.CountedFile5, NAMED('Counted_Child_AdddyPerLexid'));
//OUTPUT($.Stats.DobLexid, NAMED('Dobs_Per_Lexid'));
//OUTPUT($.Stats.Countfile3, NAMED('Counted_Child_Doblexid'));
//OUTPUT($.Stats.LexidPerDob, NAMED('Lexid_Per_Dob'));
//OUTPUT($.Stats.countfile4, NAMED('Counted_Child_LexidPerDob'));
//OUTPUT($.Merge, NAMED('Wathcdog_file'));

//OUTPUT(Watchdog.File_Best, Named('Watchdog_file'));
// infile := $.New_Persons.file;

// count(infile);

// ========================= Analystics Report ====================================
//OUTPUT(Watchdog.File_Best, Named('Watchdog_File'));
// Output($.Analytics_Report.Sorted_c_fname, Named('Firstnames_Accross_File'));
// Output($.Analytics_Report.S_Crosstab_fname, Named('Firstnames_Accross_Lexids'));
// Output($.Analytics_Report.Sorted_c_mname, Named('Middlenames_Accross_File'));
// Output($.Analytics_Report.S_Crosstab_mname, Named('Middlenames_Accross_Lexids'));
// Output($.Analytics_Report.Sorted_c_lanme, Named('Lastnames_Accross_File'));
// Output($.Analytics_Report.S_Crosstab_lname, Named('Lastnames_Accross_Lexids'));
// Output($.Analytics_Report.Sorted_c_ssn, Named('SSN_Accross_File'));
// Output($.Analytics_Report.S_Crosstab_ssn, Named('SSN_Accross_Lexid'));
//Output($.Analytics_Report.st_Addy_Rec, Named('Count_Address_PerLExid')); // ** Still not complete
// Output($.Analytics_Report.st_Crosstab_Dob, Named('HighCount_Dob'));
// Output($.Analytics_Report.S_Crosstab_dob, Named('Dobs_Without_No_Blanks'));
//Output($.Analytics_Report.S_Crosstab_dobMMDD, Named('Dobs_Without_No_blanksMMDD'));
// Output($.Analytics_Report.S_Sample_RecSlim, Named('Count_of_BlankDobs'));
//Output($.Analytics_Report.S_Sample_RecSlim1, Named('Count_BlankDobs_With_MMDD1'));
//Output($.Analytics_Report.CountedBlankDobs, Named('Counted_Blank_Dobs'));


// // ========================== Watchdog_Merge ====================================



//Output($.Watchdog_Match_Report.ds_rollflagged_rec, Named('matches_header_watchdog'));
//Output($.Watchdog_Match_Report.Watchdog_Match, Named('Not_Rolled'));
//Output($.Watchdog_Match_Report.st_counted_fname, Named('counted_fname'));
// Output($.Watchdog_Match_Report.st_counted_lname, Named('counted_lname'));
// Output($.Watchdog_Match_Report.st_counted_dob, Named('counted_dob'));
// Output($.Watchdog_Match_Report.st_counted_ssn, Named('counted_ssn'));
// Output($.Watchdog_Match_Report.st_counted_address_match, Named('counted_Address_Match'));
// Output($.Watchdog_Match_Report.st_counted_collectivematch_all, Named('Counted_collective_match'));
// Still need to distribute for 21b records



// ============================================ File Spray =============================================

// $.Spray_input_file.build_1;
// $.Spray_input_file.build_2;
// $.Spray_input_file.build_3;


kyedsizedhistory := $.History_Analysis.Keysizedhistory_report;
master_build := $.History_Analysis.Master_Build_Frequence_Report;
orbit_build := $.History_Analysis.Orbit_buildinstance;

Output(kyedsizedhistory, Named('Keyedsized_History_Report'));
Output(master_build, Named('Master_Build_Frequency_Report'));
Output(orbit_build, Named('Orbit_Build_Instance_Report'));


//$.History_Analysis.Master_Build_Frequence_Report(regexfind('EYS', package));