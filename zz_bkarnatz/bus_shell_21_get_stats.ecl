#workunit('name','Bus Shell 2.1 Stats');

IMPORT ut, ashirey, Business_Risk_BIP, zz_bkarnatz, zz_Koubsky_SALT, SALT23;


inputFile := '~lweiner::tmp::business_shell_results_sbfe_enhancements_sprint1w20160406-113700_default.csv';  


layout := zz_bkarnatz.SBFE_SBA_BIID_Sprint1_Layout.input_lay;


ds_input := DATASET(inputFile, layout, CSV(HEADING(1), QUOTE('"')));

// OUTPUT(COUNT(ds_input), named('full_count'));


// Slim_Lay := RECORD
	// layout - input_echo - clean_input - input - verification - business_activity - business_characteristics - firmographic - organizational_structure - sos - bankruptcy - lien_and_judgment 
	// - asset_information - public_record - tradeline - inquiry - business_to_executive_link - business_to_person_link - input_characteristics - associates - data_build_dates - data_fetch_indicators - file_ind;
	// string30 acctno;
// END;

// Slim_Lay Lay_trans(layout le) := TRANSFORM
	// self.acctno := le.input_echo.acctno;
	// self.sbfe := le.sbfe;
	// self.errorcode := le.errorcode;
// END;

Sprint1NewAttLay := Record
	STRING3 SBFEVerBusFEIN;
	STRING3 SBFEOpenCount03M;
	STRING3 SBFEOpenCount84M;
	STRING3 SBFEOpenCountHist03M;
	STRING3 SBFEOpenCountHist06M;
	STRING3 SBFEOpenCountHist12M;
	STRING3 SBFEOpenCountHist24M;
	STRING3 SBFEOpenCountHist36M;
	STRING3 SBFEOpenCountHist60M;
	STRING3 SBFEOpenCountHist84M;
	STRING3 SBFEOpenLoanCount03M;
	STRING3 SBFEOpenLoanCount06M;
	STRING3 SBFEOpenLoanCount12M;
	STRING3 SBFEOpenLoanCount24M;
	STRING3 SBFEOpenLoanCount36M;
	STRING3 SBFEOpenLoanCount60M;
	STRING3 SBFEOpenLoanCount84M;
	STRING3 SBFEOpenLineCount03M;
	STRING3 SBFEOpenLineCount06M;
	STRING3 SBFEOpenLineCount12M;
	STRING3 SBFEOpenLineCount24M;
	STRING3 SBFEOpenLineCount36M;
	STRING3 SBFEOpenLineCount60M;
	STRING3 SBFEOpenLineCount84M;
	STRING3 SBFEOpenCardCount03M;
	STRING3 SBFEOpenCardCount06M;
	STRING3 SBFEOpenCardCount12M;
	STRING3 SBFEOpenCardCount24M;
	STRING3 SBFEOpenCardCount36M;
	STRING3 SBFEOpenCardCount60M;
	STRING3 SBFEOpenCardCount84M;
	STRING3 SBFEOpenLeaseCount03M;
	STRING3 SBFEOpenLeaseCount06M;
	STRING3 SBFEOpenLeaseCount12M;
	STRING3 SBFEOpenLeaseCount24M;
	STRING3 SBFEOpenLeaseCount36M;
	STRING3 SBFEOpenLeaseCount60M;
	STRING3 SBFEOpenLeaseCount84M;
	STRING3 SBFEOpenLetterCount03M;
	STRING3 SBFEOpenLetterCount06M;
	STRING3 SBFEOpenLetterCount12M;
	STRING3 SBFEOpenLetterCount24M;
	STRING3 SBFEOpenLetterCount36M;
	STRING3 SBFEOpenLetterCount60M;
	STRING3 SBFEOpenLetterCount84M;
	STRING3 SBFEOpenOELineCount03M;
	STRING3 SBFEOpenOELineCount06M;
	STRING3 SBFEOpenOELineCount12M;
	STRING3 SBFEOpenOELineCount24M;
	STRING3 SBFEOpenOELineCount36M;
	STRING3 SBFEOpenOELineCount60M;
	STRING3 SBFEOpenOELineCount84M;
	STRING3 SBFEOpenOtherCount03M;
	STRING3 SBFEOpenOtherCount06M;
	STRING3 SBFEOpenOtherCount12M;
	STRING3 SBFEOpenOtherCount24M;
	STRING3 SBFEOpenOtherCount36M;
	STRING3 SBFEOpenOtherCount60M;
	STRING3 SBFEOpenOtherCount84M;
	STRING8 SBFEAvgBalance03M;
	STRING8 SBFEAvgBalanceLoan03M;
	STRING8 SBFEAvgBalanceLine03M;
	STRING8 SBFEAvgBalanceCard03M;
	STRING8 SBFEAvgBalanceLease03M;
	STRING8 SBFEAvgBalanceLetter03M;
	STRING8 SBFEAvgBalanceOELine03M;
	STRING8 SBFEAvgBalanceOther03M;
	STRING3 SBFEBalanceCount03M;
	STRING3 SBFEBalanceLoanCount03M;
	STRING3 SBFEBalanceLineCount03M;
	STRING3 SBFEBalanceCardCount03M;
	STRING3 SBFEBalanceLeaseCount03M;
	STRING3 SBFEBalanceLetterCount03M;
	STRING3 SBFEBalanceOELineCount03M;
	STRING3 SBFEBalanceOtherCount03M;
	STRING3 SBFEBalanceClosedCount03M;
	STRING3 SBFEBalanceClosedCount06M;
	STRING3 SBFEBalanceClosedCount24M;
	STRING3 SBFEAvgUtil03M;
	STRING3 SBFEAvgUtilLine03M;
	STRING3 SBFEAvgUtilCard03M;
	STRING3 SBFEAvgUtilOELine03M;
	STRING3 SBFEHighDelq03M;
	STRING3 SBFEHighDelqLoan03M;
	STRING3 SBFEHighDelqLine03M;
	STRING3 SBFEHighDelqCard03M;
	STRING3 SBFEHighDelqLease03M;
	STRING3 SBFEHighDelqLetter03M;
	STRING3 SBFEHighDelqOELine03M;
	STRING3 SBFEHighDelqOther03M;
	STRING3 SBFEDelq1Count03M;
	STRING3 SBFEDelq31Count03M;
	STRING3 SBFEDelq31LoanCount03M;
	STRING3 SBFEDelq31LineCount03M;
	STRING3 SBFEDelq31CardCount03M;
	STRING3 SBFEDelq31LeaseCount03M;
	STRING3 SBFEDelq31LetterCount03M;
	STRING3 SBFEDelq31OELineCount03M;
	STRING3 SBFEDelq31OtherCount03M;
	STRING3 SBFEDelq61Count03M;
	STRING3 SBFEDelq61LoanCount03M;
	STRING3 SBFEDelq61LineCount03M;
	STRING3 SBFEDelq61CardCount03M;
	STRING3 SBFEDelq61LeaseCount03M;
	STRING3 SBFEDelq61LetterCount03M;
	STRING3 SBFEDelq61OELineCount03M;
	STRING3 SBFEDelq61OtherCount03M;
	STRING3 SBFEDelq91Count03M;
	STRING3 SBFEDelq91LoanCount03M;
	STRING3 SBFEDelq91LineCount03M;
	STRING3 SBFEDelq91CardCount03M;
	STRING3 SBFEDelq91LeaseCount03M;
	STRING3 SBFEDelq91LetterCount03M;
	STRING3 SBFEDelq91OELineCount03M;
	STRING3 SBFEDelq91OtherCount03M;
	STRING3 SBFEDelq121Count03M;
	STRING3 SBFEDelq121LoanCount03M;
	STRING3 SBFEDelq121LineCount03M;
	STRING3 SBFEDelq121CardCount03M;
	STRING3 SBFEDelq121LeaseCount03M;
	STRING3 SBFEDelq121LetterCount03M;
	STRING3 SBFEDelq121OELineCount03M;
	STRING3 SBFEDelq121OtherCount03M;
	STRING3 SBFEDelq1OccurCount03M;
	STRING3 SBFEDelq31OccurCount03M;
	STRING3 SBFEDelq31OccurLoanCount03M;
	STRING3 SBFEDelq31OccurLineCount03M;
	STRING3 SBFEDelq31OccurCardCount03M;
	STRING3 SBFEDelq31OccurLeaseCount03M;
	STRING3 SBFEDelq31OccurLetterCount03M;
	STRING3 SBFEDelq31OccurOELineCount03M;
	STRING3 SBFEDelq31OccurOtherCount03M;
	STRING3 SBFEDelq61OccurCount03M;
	STRING3 SBFEDelq61OccurLoanCount03M;
	STRING3 SBFEDelq61OccurLineCount03M;
	STRING3 SBFEDelq61OccurCardCount03M;
	STRING3 SBFEDelq61OccurLeaseCount03M;
	STRING3 SBFEDelq61OccurLetterCount03M;
	STRING3 SBFEDelq61OccurOELineCount03M;
	STRING3 SBFEDelq61OccurOtherCount03M;
	STRING3 SBFEDelq91OccurCount03M;
	STRING3 SBFEDelq91OccurLoanCount03M;
	STRING3 SBFEDelq91OccurLineCount03M;
	STRING3 SBFEDelq91OccurCardCount03M;
	STRING3 SBFEDelq91OccurLeaseCount03M;
	STRING3 SBFEDelq91OccurLetterCount03M;
	STRING3 SBFEDelq91OccurOELineCount03M;
	STRING3 SBFEDelq91OccurOtherCount03M;
	STRING3 SBFEDelq121OccurCount03M;
	STRING3 SBFEDelq121OccurLoanCount03M;
	STRING3 SBFEDelq121OccurLineCount03M;
	STRING3 SBFEDelq121OccurCardCount03M;
	STRING3 SBFEDelq121OccurLeaseCount03M;
	STRING3 SBFEDelq121OccurLetterCount03M;
	STRING3 SBFEDelq121OccurOELineCount03M;
	STRING3 SBFEDelq121OccurOtherCount03M;
 	String30 acctno;
  string200 errorcode;
END;

Sprint1NewAttLay Sprint1_Lay_trans(layout le) := TRANSFORM
	self.acctno := le.input_echo.acctno;
	self.SBFEVerBusFEIN := le.sbfe.sbfeverbusinputphonefein;
	self.SBFEOpenCount03M := le.sbfe.SBFEOpenCount03M;
	self.SBFEOpenCount84M := le.sbfe.SBFEOpenCount84M;
	self.SBFEOpenCountHist03M := le.sbfe.SBFEOpenCountHist03M;
	self.SBFEOpenCountHist06M := le.sbfe.SBFEOpenCountHist06M;
	self.SBFEOpenCountHist12M := le.sbfe.SBFEOpenCountHist12M;
	self.SBFEOpenCountHist24M := le.sbfe.SBFEOpenCountHist24M;
	self.SBFEOpenCountHist36M := le.sbfe.SBFEOpenCountHist36M;
	self.SBFEOpenCountHist60M := le.sbfe.SBFEOpenCountHist60M;
	self.SBFEOpenCountHist84M := le.sbfe.SBFEOpenCountHist84M;
	self.SBFEOpenLoanCount03M := le.sbfe.SBFEOpenLoanCount03M;
	self.SBFEOpenLoanCount06M := le.sbfe.SBFEOpenLoanCount06M;
	self.SBFEOpenLoanCount12M := le.sbfe.SBFEOpenLoanCount12M;
	self.SBFEOpenLoanCount24M := le.sbfe.SBFEOpenLoanCount24M;
	self.SBFEOpenLoanCount36M := le.sbfe.SBFEOpenLoanCount36M;
	self.SBFEOpenLoanCount60M := le.sbfe.SBFEOpenLoanCount60M;
	self.SBFEOpenLoanCount84M := le.sbfe.SBFEOpenLoanCount84M;
	self.SBFEOpenLineCount03M := le.sbfe.SBFEOpenLineCount03M;
	self.SBFEOpenLineCount06M := le.sbfe.SBFEOpenLineCount06M;
	self.SBFEOpenLineCount12M := le.sbfe.SBFEOpenLineCount12M;
	self.SBFEOpenLineCount24M := le.sbfe.SBFEOpenLineCount24M;
	self.SBFEOpenLineCount36M := le.sbfe.SBFEOpenLineCount36M;
	self.SBFEOpenLineCount60M := le.sbfe.SBFEOpenLineCount60M;
	self.SBFEOpenLineCount84M := le.sbfe.SBFEOpenLineCount84M;
	self.SBFEOpenCardCount03M := le.sbfe.SBFEOpenCardCount03M;
	self.SBFEOpenCardCount06M := le.sbfe.SBFEOpenCardCount06M;
	self.SBFEOpenCardCount12M := le.sbfe.SBFEOpenCardCount12M;
	self.SBFEOpenCardCount24M := le.sbfe.SBFEOpenCardCount24M;
	self.SBFEOpenCardCount36M := le.sbfe.SBFEOpenCardCount36M;
	self.SBFEOpenCardCount60M := le.sbfe.SBFEOpenCardCount60M;
	self.SBFEOpenCardCount84M := le.sbfe.SBFEOpenCardCount84M;
	self.SBFEOpenLeaseCount03M := le.sbfe.SBFEOpenLeaseCount03M;
	self.SBFEOpenLeaseCount06M := le.sbfe.SBFEOpenLeaseCount06M;
	self.SBFEOpenLeaseCount12M := le.sbfe.SBFEOpenLeaseCount12M;
	self.SBFEOpenLeaseCount24M := le.sbfe.SBFEOpenLeaseCount24M;
	self.SBFEOpenLeaseCount36M := le.sbfe.SBFEOpenLeaseCount36M;
	self.SBFEOpenLeaseCount60M := le.sbfe.SBFEOpenLeaseCount60M;
	self.SBFEOpenLeaseCount84M := le.sbfe.SBFEOpenLeaseCount84M;
	self.SBFEOpenLetterCount03M := le.sbfe.SBFEOpenLetterCount03M;
	self.SBFEOpenLetterCount06M := le.sbfe.SBFEOpenLetterCount06M;
	self.SBFEOpenLetterCount12M := le.sbfe.SBFEOpenLetterCount12M;
	self.SBFEOpenLetterCount24M := le.sbfe.SBFEOpenLetterCount24M;
	self.SBFEOpenLetterCount36M := le.sbfe.SBFEOpenLetterCount36M;
	self.SBFEOpenLetterCount60M := le.sbfe.SBFEOpenLetterCount60M;
	self.SBFEOpenLetterCount84M := le.sbfe.SBFEOpenLetterCount84M;
	self.SBFEOpenOELineCount03M := le.sbfe.SBFEOpenOELineCount03M;
	self.SBFEOpenOELineCount06M := le.sbfe.SBFEOpenOELineCount06M;
	self.SBFEOpenOELineCount12M := le.sbfe.SBFEOpenOELineCount12M;
	self.SBFEOpenOELineCount24M := le.sbfe.SBFEOpenOELineCount24M;
	self.SBFEOpenOELineCount36M := le.sbfe.SBFEOpenOELineCount36M;
	self.SBFEOpenOELineCount60M := le.sbfe.SBFEOpenOELineCount60M;
	self.SBFEOpenOELineCount84M := le.sbfe.SBFEOpenOELineCount84M;
	self.SBFEOpenOtherCount03M := le.sbfe.SBFEOpenOtherCount03M;
	self.SBFEOpenOtherCount06M := le.sbfe.SBFEOpenOtherCount06M;
	self.SBFEOpenOtherCount12M := le.sbfe.SBFEOpenOtherCount12M;
	self.SBFEOpenOtherCount24M := le.sbfe.SBFEOpenOtherCount24M;
	self.SBFEOpenOtherCount36M := le.sbfe.SBFEOpenOtherCount36M;
	self.SBFEOpenOtherCount60M := le.sbfe.SBFEOpenOtherCount60M;
	self.SBFEOpenOtherCount84M := le.sbfe.SBFEOpenOtherCount84M;
	self.SBFEAvgBalance03M := le.sbfe.SBFEAvgBalance03M;
	self.SBFEAvgBalanceLoan03M := le.sbfe.SBFEAvgBalanceLoan03M;
	self.SBFEAvgBalanceLine03M := le.sbfe.SBFEAvgBalanceLine03M;
	self.SBFEAvgBalanceCard03M := le.sbfe.SBFEAvgBalanceCard03M;
	self.SBFEAvgBalanceLease03M := le.sbfe.SBFEAvgBalanceLease03M;
	self.SBFEAvgBalanceLetter03M := le.sbfe.SBFEAvgBalanceLetter03M;
	self.SBFEAvgBalanceOELine03M := le.sbfe.SBFEAvgBalanceOELine03M;
	self.SBFEAvgBalanceOther03M := le.sbfe.SBFEAvgBalanceOther03M;
	self.SBFEBalanceCount03M := le.sbfe.SBFEBalanceCount03M;
	self.SBFEBalanceLoanCount03M := le.sbfe.SBFEBalanceLoanCount03M;
	self.SBFEBalanceLineCount03M := le.sbfe.SBFEBalanceLineCount03M;
	self.SBFEBalanceCardCount03M := le.sbfe.SBFEBalanceCardCount03M;
	self.SBFEBalanceLeaseCount03M := le.sbfe.SBFEBalanceLeaseCount03M;
	self.SBFEBalanceLetterCount03M := le.sbfe.SBFEBalanceLetterCount03M;
	self.SBFEBalanceOELineCount03M := le.sbfe.SBFEBalanceOELineCount03M;
	self.SBFEBalanceOtherCount03M := le.sbfe.SBFEBalanceOtherCount03M;
	self.SBFEBalanceClosedCount03M := le.sbfe.SBFEBalanceClosedCount03M;
	self.SBFEBalanceClosedCount06M := le.sbfe.SBFEBalanceClosedCount06M;
	self.SBFEBalanceClosedCount24M := le.sbfe.SBFEBalanceClosedCount24M;
	self.SBFEAvgUtil03M := le.sbfe.SBFEAvgUtil03M;
	self.SBFEAvgUtilLine03M := le.sbfe.SBFEAvgUtilLine03M;
	self.SBFEAvgUtilCard03M := le.sbfe.SBFEAvgUtilCard03M;
	self.SBFEAvgUtilOELine03M := le.sbfe.SBFEAvgUtilOELine03M;
	self.SBFEHighDelq03M := le.sbfe.SBFEHighDelq03M;
	self.SBFEHighDelqLoan03M := le.sbfe.SBFEHighDelqLoan03M;
	self.SBFEHighDelqLine03M := le.sbfe.SBFEHighDelqLine03M;
	self.SBFEHighDelqCard03M := le.sbfe.SBFEHighDelqCard03M;
	self.SBFEHighDelqLease03M := le.sbfe.SBFEHighDelqLease03M;
	self.SBFEHighDelqLetter03M := le.sbfe.SBFEHighDelqLetter03M;
	self.SBFEHighDelqOELine03M := le.sbfe.SBFEHighDelqOELine03M;
	self.SBFEHighDelqOther03M := le.sbfe.SBFEHighDelqOther03M;
	self.SBFEDelq1Count03M := le.sbfe.SBFEDelq1Count03M;
	self.SBFEDelq31Count03M := le.sbfe.SBFEDelq31Count03M;
	self.SBFEDelq31LoanCount03M := le.sbfe.SBFEDelq31LoanCount03M;
	self.SBFEDelq31LineCount03M := le.sbfe.SBFEDelq31LineCount03M;
	self.SBFEDelq31CardCount03M := le.sbfe.SBFEDelq31CardCount03M;
	self.SBFEDelq31LeaseCount03M := le.sbfe.SBFEDelq31LeaseCount03M;
	self.SBFEDelq31LetterCount03M := le.sbfe.SBFEDelq31LetterCount03M;
	self.SBFEDelq31OELineCount03M := le.sbfe.SBFEDelq31OELineCount03M;
	self.SBFEDelq31OtherCount03M := le.sbfe.SBFEDelq31OtherCount03M;
	self.SBFEDelq61Count03M := le.sbfe.SBFEDelq61Count03M;
	self.SBFEDelq61LoanCount03M := le.sbfe.SBFEDelq61LoanCount03M;
	self.SBFEDelq61LineCount03M := le.sbfe.SBFEDelq61LineCount03M;
	self.SBFEDelq61CardCount03M := le.sbfe.SBFEDelq61CardCount03M;
	self.SBFEDelq61LeaseCount03M := le.sbfe.SBFEDelq61LeaseCount03M;
	self.SBFEDelq61LetterCount03M := le.sbfe.SBFEDelq61LetterCount03M;
	self.SBFEDelq61OELineCount03M := le.sbfe.SBFEDelq61OELineCount03M;
	self.SBFEDelq61OtherCount03M := le.sbfe.SBFEDelq61OtherCount03M;
	self.SBFEDelq91Count03M := le.sbfe.SBFEDelq91Count03M;
	self.SBFEDelq91LoanCount03M := le.sbfe.SBFEDelq91LoanCount03M;
	self.SBFEDelq91LineCount03M := le.sbfe.SBFEDelq91LineCount03M;
	self.SBFEDelq91CardCount03M := le.sbfe.SBFEDelq91CardCount03M;
	self.SBFEDelq91LeaseCount03M := le.sbfe.SBFEDelq91LeaseCount03M;
	self.SBFEDelq91LetterCount03M := le.sbfe.SBFEDelq91LetterCount03M;
	self.SBFEDelq91OELineCount03M := le.sbfe.SBFEDelq91OELineCount03M;
	self.SBFEDelq91OtherCount03M := le.sbfe.SBFEDelq91OtherCount03M;
	self.SBFEDelq121Count03M := le.sbfe.SBFEDelq121Count03M;
	self.SBFEDelq121LoanCount03M := le.sbfe.SBFEDelq121LoanCount03M;
	self.SBFEDelq121LineCount03M := le.sbfe.SBFEDelq121LineCount03M;
	self.SBFEDelq121CardCount03M := le.sbfe.SBFEDelq121CardCount03M;
	self.SBFEDelq121LeaseCount03M := le.sbfe.SBFEDelq121LeaseCount03M;
	self.SBFEDelq121LetterCount03M := le.sbfe.SBFEDelq121LetterCount03M;
	self.SBFEDelq121OELineCount03M := le.sbfe.SBFEDelq121OELineCount03M;
	self.SBFEDelq121OtherCount03M := le.sbfe.SBFEDelq121OtherCount03M;
	self.SBFEDelq1OccurCount03M := le.sbfe.SBFEDelq1OccurCount03M;
	self.SBFEDelq31OccurCount03M := le.sbfe.SBFEDelq31OccurCount03M;
	self.SBFEDelq31OccurLoanCount03M := le.sbfe.SBFEDelq31OccurLoanCount03M;
	self.SBFEDelq31OccurLineCount03M := le.sbfe.SBFEDelq31OccurLineCount03M;
	self.SBFEDelq31OccurCardCount03M := le.sbfe.SBFEDelq31OccurCardCount03M;
	self.SBFEDelq31OccurLeaseCount03M := le.sbfe.SBFEDelq31OccurLeaseCount03M;
	self.SBFEDelq31OccurLetterCount03M := le.sbfe.SBFEDelq31OccurLetterCount03M;
	self.SBFEDelq31OccurOELineCount03M := le.sbfe.SBFEDelq31OccurOELineCount03M;
	self.SBFEDelq31OccurOtherCount03M := le.sbfe.SBFEDelq31OccurOtherCount03M;
	self.SBFEDelq61OccurCount03M := le.sbfe.SBFEDelq61OccurCount03M;
	self.SBFEDelq61OccurLoanCount03M := le.sbfe.SBFEDelq61OccurLoanCount03M;
	self.SBFEDelq61OccurLineCount03M := le.sbfe.SBFEDelq61OccurLineCount03M;
	self.SBFEDelq61OccurCardCount03M := le.sbfe.SBFEDelq61OccurCardCount03M;
	self.SBFEDelq61OccurLeaseCount03M := le.sbfe.SBFEDelq61OccurLeaseCount03M;
	self.SBFEDelq61OccurLetterCount03M := le.sbfe.SBFEDelq61OccurLetterCount03M;
	self.SBFEDelq61OccurOELineCount03M := le.sbfe.SBFEDelq61OccurOELineCount03M;
	self.SBFEDelq61OccurOtherCount03M := le.sbfe.SBFEDelq61OccurOtherCount03M;
	self.SBFEDelq91OccurCount03M := le.sbfe.SBFEDelq91OccurCount03M;
	self.SBFEDelq91OccurLoanCount03M := le.sbfe.SBFEDelq91OccurLoanCount03M;
	self.SBFEDelq91OccurLineCount03M := le.sbfe.SBFEDelq91OccurLineCount03M;
	self.SBFEDelq91OccurCardCount03M := le.sbfe.SBFEDelq91OccurCardCount03M;
	self.SBFEDelq91OccurLeaseCount03M := le.sbfe.SBFEDelq91OccurLeaseCount03M;
	self.SBFEDelq91OccurLetterCount03M := le.sbfe.SBFEDelq91OccurLetterCount03M;
	self.SBFEDelq91OccurOELineCount03M := le.sbfe.SBFEDelq91OccurOELineCount03M;
	self.SBFEDelq91OccurOtherCount03M := le.sbfe.SBFEDelq91OccurOtherCount03M;
	self.SBFEDelq121OccurCount03M := le.sbfe.SBFEDelq121OccurCount03M;
	self.SBFEDelq121OccurLoanCount03M := le.sbfe.SBFEDelq121OccurLoanCount03M;
	self.SBFEDelq121OccurLineCount03M := le.sbfe.SBFEDelq121OccurLineCount03M;
	self.SBFEDelq121OccurCardCount03M := le.sbfe.SBFEDelq121OccurCardCount03M;
	self.SBFEDelq121OccurLeaseCount03M := le.sbfe.SBFEDelq121OccurLeaseCount03M;
	self.SBFEDelq121OccurLetterCount03M := le.sbfe.SBFEDelq121OccurLetterCount03M;
	self.SBFEDelq121OccurOELineCount03M := le.sbfe.SBFEDelq121OccurOELineCount03M;
	self.SBFEDelq121OccurOtherCount03M := le.sbfe.SBFEDelq121OccurOtherCount03M;
	self.errorcode := le.errorcode;
END;


ds_slim_input := Project(ds_input, Sprint1_Lay_trans(left));

// OUTPUT(COUNT(ds_slim_input), named('slim_count'));
// OUTPUT(choosen(ds_slim_input, 25), named('slim'));

// ashirey.Flatten(ds_input, ds_flat);
ashirey.Flatten(ds_slim_input, ds_slim_flat);


// output(choosen(ds_flat, 25), named('full_output'));
// output(choosen(ds_slim_flat, 25), named('Slim_output'));

/*
string attribute := 'verification__proxidpowidtreecount';
// string attribute := 'verification__phonematchsourcecount';
// output(choosen(ds_flat(#expand(attribute) > '6'), 20), named(attribute + '_output'));
// output(count(ds_flat(#expand(attribute) > '6')), named(attribute + '_count'));

ds_flat2 := sort(ds_flat, -(integer) #expand(attribute));
output(choosen(ds_flat2, 5), named(attribute + '_output'));
// output(count(ds_flat2), named(attribute + '_count'));

// ds_badsource := ds_flat( #expand(attribute) not in zz_Koubsky.bus_shell_spr12_layout.sources);
// output(choosen(ds_badsource, 25), named(attribute + '_bad_output'));
// output(count(ds_badsource), named(attribute + '_bad_count'));
// output(count(ds_flat), named('total_count'));
*/

// zz_Koubsky_SALT.mac_profile(ds_slim_flat);



// zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'sbfe__sbfeaccountcount') +
// zz_bkarnatz.bus_shell_stats_macro_exclude_zero(ds_slim_flat, 'sbfe__sbfeaccountcount') +


// zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'sbfe__SBFEOpenCount06Month') +
// zz_bkarnatz.bus_shell_stats_macro_exclude_zero(ds_slim_flat, 'sbfe__SBFEOpenCount06Month')

// TestIncludeZero := zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'sbfe__sbfeaccountcount') + zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'sbfe__SBFEOpenCount06Month');
// TestExcludeZero := zz_bkarnatz.bus_shell_stats_macro_exclude_zero(ds_slim_flat, 'sbfe__sbfeaccountcount') + zz_bkarnatz.bus_shell_stats_macro_exclude_zero(ds_slim_flat, 'sbfe__SBFEOpenCount06Month');
// Test := zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'sbfe__sbfeaccountcount') + zz_bkarnatz.bus_shell_stats_macro_exclude_zero(ds_slim_flat, 'sbfe__SBFEOpenCount06Month');

// output(TestIncludeZero, named('includezero'));
// output(TestExcludeZero, named('excludezero'));
// output(Test, named('test'));



DATASET bus_shell_stats :=
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEVerBusFEIN') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCountHist84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLoanCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLineCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenCardCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLeaseCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenLetterCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOELineCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount12M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount36M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount60M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEOpenOtherCount84M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalance03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceLoan03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceLine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceCard03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceLease03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceLetter03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceOELine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgBalanceOther03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceClosedCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceClosedCount06M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEBalanceClosedCount24M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgUtil03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgUtilLine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgUtilCard03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEAvgUtilOELine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelq03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqLoan03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqLine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqCard03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqLease03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqLetter03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqOELine03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEHighDelqOther03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq1Count03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31Count03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31LoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31LineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31CardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31LeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31LetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61Count03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61LoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61LineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61CardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61LeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61LetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91Count03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91LoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91LineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91CardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91LeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91LetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121Count03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121LoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121LineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121CardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121LeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121LetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq1OccurCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq31OccurOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq61OccurOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq91OccurOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurLoanCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurLineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurCardCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurLeaseCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurLetterCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurOELineCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'SBFEDelq121OccurOtherCount03M') +
zz_bkarnatz.bus_shell_stats_macro(ds_slim_flat, 'errorcode')
;

OUTPUT(bus_shell_stats,, '~bkarnatz::out::businessshell_21_SBA_BIID_Sprint1_stats_' + thorlib.wuid(), THOR, expire(30));
// OUTPUT(bus_shell_stats, named('bus_shell_stats_test'));


