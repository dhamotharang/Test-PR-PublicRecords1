
// example: mac_count_sample('dataset_attribute_name_as_a_string');

EXPORT mac_count_sample(macro_dataset,pivot_field='',sample_limit=1000) := MACRO

			output(count(#EXPAND(macro_dataset)),named(macro_dataset+'_count'));
			output(choosen(#EXPAND(macro_dataset),sample_limit),named(macro_dataset+'_sample'));

ENDMACRO;


