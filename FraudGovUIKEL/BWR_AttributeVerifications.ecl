import FraudgovUIKEL;

// Run verifications on data to make sure no issues occur
dsEmp := FraudgovUIKEL.files.Employer;
ds := FraudgovUIKel.Q__show_Employers.Res0;
// Issue 1 - Repeat BusAcctUIDEcho values. Are there duplicate acctnos from the customer?
OUTPUT(SORT(TABLE(dsEmp, {acctno, cnt:=COUNT(GROUP)}, acctno), -cnt), NAMED('DupAcctNo'));

// Issue 3 - Date Ranges for BusAcctDtEmployerBeganEcho and BusAcctTaxLiabStartDtEcho - Range from 193209 to 198901 and one business in 20111111. Is this accurate
OUTPUT(SORT(TABLE(dsEmp, {datefirstemp, cnt:=COUNT(GROUP)}, datefirstemp), -datefirstemp), NAMED('BusAcctDtEmployerBeganEcho')); // BusAcctDtEmployerBeganEcho
OUTPUT(SORT(TABLE(dsEmp, {dateliabest, cnt:=COUNT(GROUP)}, dateliabest), -dateliabest), NAMED('BusAcctTaxLiabStartDtEcho')); // BusAcctDtEmployerBeganEcho

// Issue 4
OUTPUT(SORT(TABLE(dsEmp, {dateliabest, cnt:=COUNT(GROUP)}, dateliabest), -cnt), NAMED('BusAcctTaxLiabStartDtEchoHighCnts')); // BusAcctDtEmployerBeganEcho


// Sele Verifications
// These failed

xtSel_1a := TABLE(ds, {Bus_Acct_Sele_I_D_Append_, Bus_Oldest_Tax_Liab_Start_Dt_, cnt:=COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_, Bus_Oldest_Tax_Liab_Start_Dt_);
xtSel_1 := TABLE(xtSel_1a, {Bus_Acct_Sele_I_D_Append_, cntt := COUNT(GROUP)}, Bus_Acct_Sele_I_D_Append_);
OUTPUT(SORT(xtSel_1, -cntt), NAMED('selCheck_old_tax_liab_start_dt'));
OUTPUT(ds(Bus_Acct_Sele_I_D_Append_=2497983));
OUTPUT(ds(Bus_Acct_Sele_I_D_Append_=2763008334));