/*

Written to fix these fields that had alpha characters as the last character
it was a botched conversion in abinitio from ebcdic string to ascii string, when it should have been
ebcdic decimal to ascii decimal.

5000  -- ACCT_BAL_TOTAL
5600  -- SALES_ACTUAL
5610  -- PROFIT_RANGE_ACTUAL
5610  -- NET_WORTH_ACTUAL
2015  -- orig_account_balance_regular_tradelines 
2015  -- orig_account_balance_new 
2015  -- orig_account_balance_combined

*/
export fFix_amount_codes(string pInputAmount) :=
function
	integer original_length := length(pInputAmount);
	
	boolean isgood := regexfind('^[-]?[[:digit:]]+$', trim(pInputAmount,left,right));

	string1 lastchar	:= trim(pInputAmount,left,right)[length(trim(pInputAmount,left,right))];
	string restofString := trim(pInputAmount,left,right)[1..length(trim(pInputAmount,left,right)) - 1];
	
	string1 lastdigit(string1 plastchar) :=
		map(
		plastchar in ['{','}'] => '0',
		plastchar in ['A','J'] => '1',
		plastchar in ['B','K'] => '2',
		plastchar in ['C','L'] => '3',
		plastchar in ['D','M'] => '4',
		plastchar in ['E','N'] => '5',
		plastchar in ['F','O'] => '6',
		plastchar in ['G','P'] => '7',
		plastchar in ['H','Q'] => '8',
		plastchar in ['I','R'] => '9', '0');

	boolean isnegative(string1 plastchar) :=
		if(plastchar in ['{','A','B','C','D','E','F','G','H','I'], false, true);
		
	string fixed_string := restofString + lastdigit(lastchar);
	
	integer8 fixed_amount := if(isnegative(lastchar), (integer8)fixed_string * -1, (integer8)fixed_string);

	return if(isgood, intformat((integer)pInputAmount,original_length,1), intformat(fixed_amount,original_length,1));

end;