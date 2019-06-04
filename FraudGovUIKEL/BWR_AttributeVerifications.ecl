import FraudgovUIKEL;

// Run verifications on data to make sure no issues occur
dsEmp := FraudgovUIKEL.files.Employer;
// ds := FraudgovUIKel.Q__show_Employers.Res0;
// Issue 1 - Repeat BusAcctUIDEcho values. Are there duplicate acctnos from the customer?
OUTPUT(SORT(TABLE(dsEmp, {acctno, cnt:=COUNT(GROUP)}, acctno), -cnt), NAMED('DupAcctNo'));

// Issue 3 - Date Ranges for BusAcctDtEmployerBeganEcho and BusAcctTaxLiabStartDtEcho - Range from 193209 to 198901 and one business in 20111111. Is this accurate
OUTPUT(SORT(TABLE(dsEmp, {datefirstemp, cnt:=COUNT(GROUP)}, datefirstemp), -datefirstemp), NAMED('BusAcctDtEmployerBeganEcho')); // BusAcctDtEmployerBeganEcho
OUTPUT(SORT(TABLE(dsEmp, {dateliabest, cnt:=COUNT(GROUP)}, dateliabest), -dateliabest), NAMED('BusAcctTaxLiabStartDtEcho')); // BusAcctDtEmployerBeganEcho


