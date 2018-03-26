/* *********************************************************************************************
01/15/16 - I have now completely redesigned the spreadsheet - see attribute: UU__Dev_Notes
		PRTE2_LNProperty.BWR_Despray_Alpha_Base
		PRTE2_LNProperty.BWR_Despray_Boca_Base
		PRTE2_LNProperty.BWR_Spray_Alpha_Base
		PRTE2_LNProperty.Files
		PRTE2_LNProperty.Fn_Spray_Alpha_Spreadsheet
		PRTE2_LNProperty.Get_payload
		PRTE2_LNProperty.Layouts
		PRTE2_LNProperty.Layouts_V2
		PRTE2_LNProperty.Transform_Data
		PRTE2_LNProperty.Transforms
I noticed there are 55 records with blank “0” DIDs – those will not make it into the key.  
Eventually we’ll research what the DIDs are for these 55 people and get those corrected
 – I expect minor address mismatches caused this for these.

Also, as I noted after the data refresh from production a couple weeks ago:
•	almost all our records are Assessment, but there were about 256 Deed records that may not be 100% healthy, we’ll have to someday 
	review these.  But for 256 records it didn’t seem germane to the job at hand right now because working on those would be a completely 
	new secondary refresh process because Deeds are not in the production keys that we worked with for the Assessments.  
•	We have 1 record per property. Production has many records per property.  I selected the Assessments that had the most codes filled 
	to refresh our single record.  
•	In the future if this data begins to be used more, we can learn more about what makes records healthy and we may need to learn to have 
	multiple records per property as production does.


RESEARCH:
What should lookups be set to (Boca PRCT data has 3 for assessments and 5 for deeds.
Also found LN_PropertyV2.file_search_autokey has a "lookups" formula which for our purposes can be view with this:
		IMPORT ut;
		ft1								:= 'A';
		ft2								:= 'D';
		pt1								:= 'O';
		lookups1			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft1 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt1 )));
		lookups3			:= (unsigned4)(ut.bit_set(1, doxie.lookup_bit( ft2 )) | ut.bit_set(1, doxie.lookup_bit( 'PARTY_'+pt1 )));
		OUTPUT(lookups1,NAMED('AO'));		// = 19
		OUTPUT(lookups3,NAMED('DO'));		// = 21
		// NOTE: AP = 3 and DP = 5, but our source_code has OO and OP not OO and PO ??  Wonder if boca just did it wrong?
		// so 19 and 21 are probably the correct values but 3 and 5 worked when I did a test - so probably any non-zero works.


RESEARCH:  Studying the Boca base file with 3 million records... distribution of records across:
		first character = Asset or Deed
		second value = lookups value (0,3,5)
		third field = source_code two character code.
		A-0-  	28622
		A-0-CO	307
		A-0-CP	16
		A-0-OO	117334
		A-0-OP	3155
		A-0-SP	22392
		A-3-  	68518
		A-3-CO	8055
		A-3-CP	252
		A-3-OO	1104433
		A-3-OP	39205
		A-3-SP	145813
		D-0-  	16362
		D-0-BB	573
		D-0-BO	341
		D-0-BP	3586
		D-0-CO	115
		D-0-OO	291492
		D-0-OP	5507
		D-0-SP	72873
		D-0-SS	1778
		D-5-  	55288
		D-5-BB	13328
		D-5-BO	4478
		D-5-BP	114343
		D-5-CO	4053
		D-5-CS	86
		D-5-OO	570863
		D-5-OP	48512
		D-5-SP	220753
		D-5-SS	33762

********************************************************************************************* */