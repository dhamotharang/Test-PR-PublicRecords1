import doxie, ut;

all_superkeynames := DATASET([

	 {'~thor_data400::key::dca_root_sub_'			+doxie.Version_SuperKey,'~thor_data400::key::dca::@version@::root.sub'},
	 {'~thor_data400::key::dca_bdid_'				+doxie.Version_SuperKey,'~thor_data400::key::dca::@version@::bdid'},
	 {'~thor_data400::key::dca_hierarchy_root_sub_'	+doxie.Version_SuperKey,'~thor_data400::key::dca_hierarchy::@version@::root.sub'},
	 {'~thor_data400::key::dca_hierarchy_bdid_'		+doxie.Version_SuperKey,'~thor_data400::key::dca_hierarchy::@version@::bdid'}

], ut.Layout_Superkeynames.InputLayout);

ut.fLogicalKeyRenaming(all_superkeynames, false);