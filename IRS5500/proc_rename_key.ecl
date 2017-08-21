import versioncontrol;
export Proc_Rename_Key(

	 string		filedate
	,boolean	pShouldUpdateRoxie = true

) := function

all_superkeynames := DATASET([

	{'~thor_data400::key::irs5500_bdid_qa', '~thor_data400::key::irs5500::@version@::bdid'},
	{'~thor_data400::key::irs5500_linkids_qa', '~thor_data400::key::irs5500::@version@::linkids'}
	
], versioncontrol.Layout_Superkeynames.InputLayout);


rename_keys := versioncontrol.fLogicalKeyRenaming(all_superkeynames, false, filedate);

keynames				:= DATASET([

	{'~thor_data400::key::irs5500_bdid_qa'},
	{'~thor_data400::key::irs5500_linkids_qa'}
	
], versioncontrol.layout_names);



send_roxie_email := VersionControl.fSendRoxieEmail(	 
					 Email_Notificaton_Lists.Roxie
					,'IRSKeys'
					,keynames
					,filedate
					,pShouldUpdateRoxie
					,'N');

do1 := sequential(
	 rename_keys
	,send_roxie_email);

return do1;
end;

