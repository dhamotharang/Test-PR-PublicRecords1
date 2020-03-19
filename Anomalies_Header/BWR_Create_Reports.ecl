Import Anomalies_Header;
Import Anomalies_Header.Files;
Import Anomalies_Header.Watchdog_Match_Report;
Import Anomalies_Header.Header_Counts;


// // ========================== Watchdog_Merge ====================================

//Output(Files.Header, Named('Header_Raw_File')); // Tested and Passed
//Output(Files.Watchdog, Named('Watchdog_Raw_File')); // Tested and Passed
// Output($.Watchdog_Match_Report.Watchdog_Match, Named('Matches_Header_NotRolled'));
//Output(Watchdog_Match_Report.ds_rollflagged_rec, Named('Matches_Header_Watchdog'));
Output(Watchdog_Match_Report.st_counted_fname, Named('Counted_Fname_Matches'));
Output(Watchdog_Match_Report.st_counted_lname, Named('Counted_Lname_Matches'));
Output(Watchdog_Match_Report.st_counted_dob, Named('Counted_Dob_Matches'));
Output(Watchdog_Match_Report.st_counted_ssn, Named('Counted_SSN_Matches'));
Output(Watchdog_Match_Report.st_counted_address_match, Named('Counted_Address_Match'));
Output(Watchdog_Match_Report.st_counted_collectivematch_all, Named('Counted_Collective_Match'));
//Still need to distribute for 21b records

// ========================= Analystics Report ====================================

// Output($.Analytics_Report.Sorted_c_fname, Named('Firstnames_Accross_File')); // Most common fnames across all records 
// Output($.Analytics_Report.S_Crosstab_fname, Named('Firstnames_Accross_Lexids')); // Most common fnames across different Lexids 
// Output($.Analytics_Report.Sorted_c_lanme, Named('Lastnames_Accross_File')); // Most common lnames across all records
// Output($.Analytics_Report.S_Crosstab_lname, Named('Lastnames_Accross_Lexids')); // Most common lnames across different Lexids
// Output($.Analytics_Report.Sorted_c_ssn, Named('SSN_Accross_File')); // Most common ssn accross all records (non-blank)
// Output($.Analytics_Report.S_Crosstab_ssn, Named('SSN_Accross_Lexid')); // Most common ssn accross different lexids (nin-blank)
//Output($.Analytics_Report.st_Addy_Rec, Named('Count_Address_PerLExid')); // Most common address across different lexids 
//Output(Header_Counts.st_Crosstab_Dob, Named('Most_Common_Dob')); // Most common dob across all records
//Output(Analytics_Report.S_Crosstab_dob, Named('Dobs_Without_Blanks')); // Most common dob across different lexids (non-blanks)
// Output($.Analytics_Report.S_Crosstab_dobMMDD, Named('Dobs_Without_No_blanksMMDD')); // Most common dob with only month and day
// Output($.Analytics_Report.S_Sample_RecSlim, Named('Count_of_BlankDobsYYYYMMDD')); // Count of blank dob across file
// Output($.Analytics_Report.S_Sample_RecSlim1, Named('Count_BlankDobs_With_MMDD1')); // Count of dob with blank day and month across file
//Output($.Analytics_Report.CountedBlankDobs, Named('Counted_Blank_Dobs')); // Count of dob with blank day
//Output(Abnormalities_Analytics.Analytics_Report.RecSlim_x);


// testing dedup 

Output(Anomalies_Header.Header_Counts.RecSlim);
Output(Anomalies_Header.Header_Counts.S_Crosstab_dob);