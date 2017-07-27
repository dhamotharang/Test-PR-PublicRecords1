import bankruptcyv2, AutokeyB2_batch, ut, autokey_batch, autokey;

export Fetch_SSNLast4Name_Batch ( 
	grouped dataset(Autokey_batch.Layouts.rec_DID_InBatch) ds_in, 
	string t,
	boolean workHard = false,
	boolean nofail = true, 
	boolean isTestHarness = false) := function
	
	/* currently, this autokey is only built for bankruptcy */
	k := BankruptcyV2.key_bankruptcy_ssn4name(t);

	key_lname_type := TYPEOF(autokey.Layout_SSN_redacted.lname);
	key_fname_type := TYPEOF(autokey.Layout_SSN_redacted.fname);	
	
	JoinCondition() := macro
		left.lname_value 	!= '' and
		left.ssn_value		!= '' and
		(right.s6 != '' and right.s7 != '' and right.s8 != '' and right.s9 != '') and

		keyed(left.ssn_value[length(trim(left.ssn_value))-3] = right.s6) and
		keyed(left.ssn_value[length(trim(left.ssn_value))-2] = right.s7) and
		keyed(left.ssn_value[length(trim(left.ssn_value))-1] = right.s8) and
		keyed(left.ssn_value[length(trim(left.ssn_value))] = right.s9) and
		
		/* name matching logic same as in Autokey_batch.Fetch_Name_Batch - to be consistent */
		KEYED(RIGHT.dph_lname = metaphonelib.DMetaPhone1(LEFT.lname_value)[1..6]) AND
		KEYED(RIGHT.lname[1..LENGTH( TRIM((key_lname_type)LEFT.lname_value))] = TRIM((key_lname_type)LEFT.lname_value) OR					
				(LEFT.phonetics AND workHard)) AND
		KEYED(Autokey_batch.Functions.pfe( RIGHT.pfname, LEFT.fname_value ) OR 
				(LENGTH(TRIM(LEFT.fname_value)) < 2) AND workHard) AND
		KEYED(RIGHT.fname[1..LENGTH( TRIM((key_fname_type)LEFT.fname_value))] = TRIM((key_fname_type)LEFT.fname_value) OR 
				(LEFT.nicknames AND LENGTH(TRIM(LEFT.fname_value)) >= 2)) AND
		KEYED(LEFT.mname_value = '' OR 
				workHard OR (STRING1)LEFT.mname_value[1] = RIGHT.minit )
				
	endmacro;
	
	Autokey_batch.Macros.MAC_Match_For_DIDs(ds_in, k, JoinCondition(), SSN4NAME_MATCH, ds_results)

	/* project for testharness output */
	ds_testout := project(ungroup(ds_results), Autokey_batch.Layouts.rec_DID_OutBatch); 

	// ***** For test harness only. OUTPUT() all of the input data along with matching DIDs and matchCodes.	
	IF(isTestHarness, OUTPUT(Autokey_batch.Functions.Display_Matched_Input_And_Output(ds_in, ds_testout), 
	                          NAMED('Combined_Layout_Results_Autokey_Fetch_SSNLast4Name_Batch'), OVERWRITE) );
	
	RETURN ds_results;
end;