import ut;

export Rename_logical_files :=
function

all_personheaderkeys := DATASET([
{'~thor_data400::key::flcrash::autokey::qa::address',		'~thor_data400::key::flcrash::20080414a::autokey::address'},
{'~thor_data400::key::flcrash::autokey::qa::citystname',	'~thor_data400::key::flcrash::20080414a::autokey::citystname'},
{'~thor_data400::key::flcrash::autokey::qa::name',			'~thor_data400::key::flcrash::20080414a::autokey::name'},
{'~thor_data400::key::flcrash::autokey::qa::payload',		'~thor_data400::key::flcrash::20080414a::autokey::payload'},
{'~thor_data400::key::flcrash::autokey::qa::stname',		'~thor_data400::key::flcrash::20080414a::autokey::stname'},
{'~thor_data400::key::flcrash::autokey::qa::zip',			'~thor_data400::key::flcrash::20080414a::autokey::zip'},
{'~thor_data400::key::flcrash_did_qa',	'~thor_data400::key::flcrash::20080414a::did'},
{'~thor_data400::key::flcrash0_qa',		'~thor_data400::key::flcrash::20080414a::flcrash0'},
{'~thor_data400::key::flcrash1_qa',		'~thor_data400::key::flcrash::20080414a::flcrash1'},
{'~thor_data400::key::flcrash2v_qa',	'~thor_data400::key::flcrash::20080414a::flcrash2v'},
{'~thor_data400::key::flcrash3v_qa',	'~thor_data400::key::flcrash::20080414a::flcrash3v'},
{'~thor_data400::key::flcrash4_qa',		'~thor_data400::key::flcrash::20080414a::flcrash4'},
{'~thor_data400::key::flcrash5_qa',		'~thor_data400::key::flcrash::20080414a::flcrash5'},
{'~thor_data400::key::flcrash6_qa',		'~thor_data400::key::flcrash::20080414a::flcrash6'},
{'~thor_data400::key::flcrash7_qa',		'~thor_data400::key::flcrash::20080414a::flcrash7'},
{'~thor_data400::key::flcrash8_qa',		'~thor_data400::key::flcrash::20080414a::flcrash8'}

], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_personheaderkeys, false);

return return_this;

end;

Rename_logical_files;