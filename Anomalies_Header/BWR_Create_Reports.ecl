Import Anomalies_Header;
Import Anomalies_Header.Files;
Import Anomalies_Header.Watchdog_Match_Report;
Import Anomalies_Header.Header_Percentages;
Import Anomalies_Header.Header_Counts;
Import Anomalies_Header.Layouts;
Import Anomalies_Header.Create_Reports;


// ============================ Watchdog_Merge ====================================

//Output(Files.Header, Named('Header_Raw_File')); 
//Output(Files.Watchdog, Named('Watchdog_Raw_File'));
//Output($.Watchdog_Match_Report.Watchdog_Match, Named('Matches_Header_NotRolled'));
//Output(Watchdog_Match_Report.ds_rollflagged_rec, Named('Matches_Header_Watchdog'));
//Output(Watchdog_Match_Report.st_counted_fname, Named('Counted_Fname_Matches'));
//Output(Watchdog_Match_Report.st_counted_lname, Named('Counted_Lname_Matches'));
//Output(Watchdog_Match_Report.st_counted_dob, Named('Counted_Dob_Matches'));
//Output(Watchdog_Match_Report.st_counted_ssn, Named('Counted_SSN_Matches'));
//Output(Watchdog_Match_Report.st_counted_address_match, Named('Counted_Address_Match'));
//Output(Watchdog_Match_Report.st_counted_collectivematch_all, Named('Counted_Collective_Match'));
//Still need to distribute for 21b records


//Output(Anomalies_Header.Watchdog_Match_Report.LeftRec);

// ============================ Percentage Report ==================================

// Output(Header_Percentages.s_fname_percentage, Named('Fname_Percentages'));
// Output(Header_Percentages.s_lname_percentage, Named('Lname_Percentages'));
// Output(Header_Percentages.s_dob_percentage, Named('Dob_Percenateges'));
// Output(Header_Percentages.s_ssn_percentage, Named('SSN_Percentages'));
// Output(Header_Percentages.s_addressMatch_percentage, Named('Address_Percentages'));
// Output(Header_Percentages.s_addressAllMatch_percentage, Named('AddressAll_Percentages'));


// =============================== Counts Report ====================================

// Output(Header_Counts.Sorted_c_fname,   Named('Firstnames_Accross_File')); // Most common fnames across all records 
// Output(Header_Counts.S_Crosstab_fname, Named('Firstnames_Accross_Lexids')); // Most common fnames across different Lexids 
// Output(Header_Counts.Sorted_c_lanme,   Named('Lastnames_Accross_File')); // Most common lnames across all records
// Output(Header_Counts.S_Crosstab_lname, Named('Lastnames_Accross_Lexids')); // Most common lnames across different Lexids
// Output(Header_Counts.Sorted_c_ssn,     Named('SSN_Accross_File')); // Most common ssn accross all records (non-blank)
// Output(Header_Counts.S_Crosstab_ssn,   Named('SSN_Accross_Lexid')); // Most common ssn accross different lexids (nin-blank)
//Output(Header_Counts.st_address_Rec,   Named('Count_Address_PerLExid')); // Most common address across different lexids 
// Output(Header_Counts.st_Crosstab_Dob, Named('Common_Dob_AccrossFile')); // Most common dob across all records
// Output(Header_Counts.dst_crosstab_DobLexid, Named('Dobs_Without_Blanks')); // Most common dob across different lexids (non-blanks)
//Output(Header_Counts.S_Crosstab_dobMMDD, Named('Dobs_Without_No_blanksMMDD')); // Most common dob with only month and day
//Output(Header_Counts.S_Sample_RecSlim, Named('Count_of_BlankDobs_PerSource')); // Count of blank dob across file
// Output(Header_Counts.S_Sample_RecSlim1, Named('Count_BlankDobs_With_MMDD1')); // Count of dob with blank day and month across file
// Output(Header_Counts.RecSlim_x, Named('Counted_Blank_DD'));

// Testing 
Create_Reports.full_count_reports;
