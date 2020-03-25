Import Anomalies_Header;
Import Anomalies_Header.Files;
Import Anomalies_Header.Watchdog_Match_Report;
Import Anomalies_Header.Header_Percentages;
Import Anomalies_Header.Header_Counts;
Import Anomalies_Header.Layouts;

Export Create_Reports := Module

// ========================================= Count Reports ===================================================

// Partial Count Reports 
Export fname_across_file    := Output(Header_Counts.Sorted_c_fname, Named('Firstnames_Accross_File')); // Most common fnames across all records 
Export fname_across_lexids  := Output(Header_Counts.S_Crosstab_fname, Named('Firstnames_Accross_Lexids')); // Most common fnames across different Lexids 
Export lname_acorss_file    := Output(Header_Counts.Sorted_c_lanme, Named('Lastnames_Accross_File')); // Most common lnames across all records
Export lname_acorss_lexids  := Output(Header_Counts.S_Crosstab_lname, Named('Lastnames_Accross_Lexids')); // Most common lnames across different Lexids
Export ssn_across_file      := Output(Header_Counts.Sorted_c_ssn, Named('SSN_Accross_File')); // Most common ssn accross all records (non-blank)
Export ssn_accorss_lexids   := Output(Header_Counts.S_Crosstab_ssn, Named('SSN_Accross_Lexid')); // Most common ssn accross different lexids (non-blank)
Export address_across_lexids := Output(Header_Counts.st_address_Rec, Named('Count_Address_PerLExid')); // Most common address across different lexids 
Export dobs_across_file     := Output(Header_Counts.st_Crosstab_Dob, Named('Common_Dob_AccrossFile')); // Most common dob across all records
Export nonblank_dobs        := Output(Header_Counts.dst_crosstab_DobLexid, Named('Dobs_Without_Blanks')); // Most common dob across different lexids (non-blanks)
Export dobs_mmdd_only       := Output(Header_Counts.S_Crosstab_dobMMDD, Named('Dobs_Without_No_blanksMMDD')); // Most common dob with only month and day
Export blank_dobs_persource := Output(Header_Counts.S_Sample_RecSlim, Named('Count_of_BlankDobs_PerSource')); // Count of blank dob across file

// Full Counts Reports
Export full_count_reports := Sequential(Parallel(fname_across_file, fname_across_lexids, lname_acorss_file,
                                    lname_acorss_lexids, ssn_across_file, ssn_accorss_lexids,
                                    address_across_lexids, dobs_across_file, nonblank_dobs, dobs_mmdd_only, 
                                    blank_dobs_persource ));
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