infoabi := infousa.File_ABIUS_Company_Base;
output('total infousa abi base records: ' + count(infoabi));

///////////////////////////////////////////////////////////////////////////////////////////
//  Count abi number population
///////////////////////////////////////////////////////////////////////////////////////////
abi_pop := infoabi(ABI_NUMBER <> '',ABI_NUMBER <> '000000000');
output('Abi population count(not blank or zero filled): ' + count(abi_pop));
output(enth(abi_pop,1000),
		named('Abi_population_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  Count Sub number population
///////////////////////////////////////////////////////////////////////////////////////////
Sub_pop := infoabi(SUBSIDIARY_PARENT_NUM <> '',SUBSIDIARY_PARENT_NUM <> '000000000');
output('Sub population count(not blank or zero filled): ' + count(Sub_pop));
output(enth(Sub_pop,1000),
		named('Sub_population_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  Count Ult number population
///////////////////////////////////////////////////////////////////////////////////////////
ult_pop := infoabi(ULTIMATE_PARENT_NUM <> '',ULTIMATE_PARENT_NUM <> '000000000');
output('Utl population count(not blank or zero filled): ' + count(ult_pop));
output(enth(ult_pop,1000),
		named('Utl_population_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  Count all three abi numbers population
///////////////////////////////////////////////////////////////////////////////////////////
abi_all_fields := infoabi(ABI_NUMBER <> '',ABI_NUMBER <> '000000000',
		ULTIMATE_PARENT_NUM <> '', ULTIMATE_PARENT_NUM <> '000000000',
		SUBSIDIARY_PARENT_NUM <> '', SUBSIDIARY_PARENT_NUM <> '000000000');
output('All_three_abi_fields_populated count(not blank or zero filled): ' + count(abi_all_fields));
output(enth(abi_all_fields,1000),
		named('All_three_abi_fields_populated_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  All Three Abi numbers indentical
///////////////////////////////////////////////////////////////////////////////////////////
abi_all_equal := abi_all_fields(ABI_NUMBER = ULTIMATE_PARENT_NUM, ABI_NUMBER = SUBSIDIARY_PARENT_NUM);
output('All_three_abi_fields_indentical: ' + count(abi_all_equal));
output(enth(abi_all_equal,1000),
		named('All_three_abi_fields_equal_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  abi number = subsidiary 
///////////////////////////////////////////////////////////////////////////////////////////
abi_sub_equal := abi_all_fields(ABI_NUMBER = SUBSIDIARY_PARENT_NUM, ABI_NUMBER <> ULTIMATE_PARENT_NUM);
output('ABI and Sub_indentical: ' + count(abi_sub_equal));
output(enth(abi_sub_equal,1000),
		named('ABI_and_Sub_equal_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  abi number = ultimate 
///////////////////////////////////////////////////////////////////////////////////////////
abi_ult_equal := abi_all_fields(ABI_NUMBER <> SUBSIDIARY_PARENT_NUM, ABI_NUMBER = ULTIMATE_PARENT_NUM);
output('ABI and Utl_indentical: ' + count(abi_ult_equal));
output(enth(abi_ult_equal,1000),
		named('ABI_and_Utl_equal_example_recs'),all);

///////////////////////////////////////////////////////////////////////////////////////////
//  Sub = ultimate 
///////////////////////////////////////////////////////////////////////////////////////////
sub_ult_equal := abi_all_fields(SUBSIDIARY_PARENT_NUM = ULTIMATE_PARENT_NUM, ABI_NUMBER <> SUBSIDIARY_PARENT_NUM);
output('Sub and Utl_indentical, abi <> either: ' + count(sub_ult_equal));
output(enth(sub_ult_equal,1000),
		named('Sub_and_Utl_equal_example_recs'),all);
