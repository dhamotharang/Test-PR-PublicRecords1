Import Anomalies_Header;
Import Anomalies_Header.Files;
Import Anomalies_Header.Watchdog_Match_Report;
Import Anomalies_Header.Header_Percentages;
Import Anomalies_Header.Header_Counts;
Import Anomalies_Header.Layouts;

Export Create_Reports := Module

// ========================================= Count Reports ===================================================

// Partial Count Reports 
Export fname_across_file    := Output(Header_Counts.fnames_across_file,  Named('Firstnames_Accross_File')); // Most common fnames across all records 
Export lname_across_file    := Output(Header_Counts.lanmes_across_file,  Named('Lastnames_Accross_File')); // Most common lnames across all records
Export fname_across_lexids  := Output(Header_Counts.fnames_across_lexid, Named('Firstnames_Accross_Lexids')); // Most common fnames across different Lexids 
Export lname_across_lexids  := Output(Header_Counts.fnames_across_lexid, Named('Lastnames_Accross_Lexids')); // Most common lnames across different Lexids
Export ssn_across_file      := Output(Header_Counts.ssn_across_file,     Named('ssn_accross_file')); // Most common ssn accross all records (non-blank)
Export lexids_per_ssn       := Output(Header_Counts.lexids_per_ssn,      Named('lexid_per_ssn')); // Most common ssn accross different lexids (non-blank)
Export lexids_per_address   := Output(Header_Counts.lexids_per_address,  Named('Lexid_Per_Address')); // Most common address across different lexids 
Export dob_across_file      := Output(Header_Counts.dob_across_file,     Named('Dobs_Across_File')); // Most common dob across different lexids (non-blanks)
Export lexids_per_dob       := Output(Header_Counts.lexids_per_dob,      Named('Lexid_per_dob')); // Most common dob across all records
Export dobs_mmdd_only       := Output(Header_Counts.s_crosstab_MMDD,     Named('Dobs_Without_No_blanksMMDD')); // Most common dob with only month and day
Export blank_dobs_persource := Output(Header_Counts.s_crosstab_blankdob, Named('Count_of_BlankDobs_PerSource')); // Count of blank dob across file
//Export blank_dobs_mmdd      := Output(Header_Counts.s_sample_recslim1,   Named('Count_BlankDobs_With_MMDD1')); // Count of dob with blank day and month across file
Export blank_dobs_dd        := Output(Header_Counts.s_crosstab_dobdd,    Named('Counted_Blank_DD'));
Export normal_distribution  := Output(Header_Counts.normal_distribution, Named('Normal_Distribution_Dob')); // DOB normal distribution score (measure for normality across all non-zero 1 per lexid DOB) 

// Full Counts Reports
Export full_count_reports := Sequential(Parallel(fname_across_file, lname_across_file, fname_across_lexids,
                                    lname_across_lexids, ssn_across_file, lexids_per_ssn, lexids_per_address,
                                    dob_across_file ));
// ======================================== Percentage Reports ============================================

// Partial Percentages Reports 
Export fname_percentages := Output(Header_Percentages.s_fname_percentage, Named('fname_percentages'));
Export lname_percentages := Output(Header_Percentages.s_lname_percentage, Named('lname_percentages'));
Export dob_percenatges   := Output(Header_Percentages.s_dob_percentage, Named('dob_percenateges'));
Export ssn_percenatges   := Output(Header_Percentages.s_ssn_percentage, Named('ssn_percentages'));
Export addressmatch_percentages    := Output(Header_Percentages.s_addressMatch_percentage, Named('Address_Percentages'));
Export addressmatchall_percentages := Output(Header_Percentages.s_addressAllMatch_percentage, Named('AddressAll_Percentages'));

// Full Percentages Report 
Export full_percentage_reports := Sequential(Parallel(fname_percentages, lname_percentages, dob_percenatges,
                                                 ssn_percenatges,addressmatch_percentages , addressmatchall_percentages ));

End;