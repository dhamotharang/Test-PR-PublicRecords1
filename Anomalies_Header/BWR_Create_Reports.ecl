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
//Output(Watchdog_Match_Report.Watchdog_Match, Named('Matches_Header_NotRolled'));
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

// Create_Reports.fname_across_file;
// Create_Reports.lname_across_file;
// Create_Reports.fname_across_lexids;
// Create_Reports.lname_across_lexids;
// Create_Reports.ssn_across_file;
// Create_Reports.lexids_per_ssn;
//Create_Reports.address_across_lexids;
// Create_Reports.dobs_across_file;




// Create_Reports.nonblank_dobs;
// Create_Reports.dobs_mmdd_only;
// Create_Reports.blank_dobs_persource;
// Create_Reports.blank_dobs_mmdd;
// Create_Reports.blank_dobs_dd;
// Create_Reports.normal_distribution;



//Create_Reports.lexids_per_ssn;

//Create_Reports.full_count_reports;

Create_Reports.full_count_reports;


