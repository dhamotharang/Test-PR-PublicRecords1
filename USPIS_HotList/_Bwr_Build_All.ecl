pversion 	:= '20100212'																											;		// modify to current date
directory := '/prod_data_build_13/eval_data/uspis_address_inspection_list/'	;

#workunit('name', USPIS_HotList._Dataset().Name + ' Build ' + pversion);
USPIS_HotList.Build_All(pversion, directory).all;
