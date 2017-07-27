import doxie, ut;
#workunit ('name', 'Rename All Infousa Keys, email roxie');

all_superkeynames := DATASET([

	{'~thor_data400::key::abius_company_bdid_qa', 	'~thor_data400::key::abius::@version@::company::bdid'},
	{'~thor_data400::key::abius_company_abi_qa', 	'~thor_data400::key::abius::@version@::company::abi'}

], ut.Layout_Superkeynames.InputLayout);


rename_keys := ut.fLogicalKeyRenaming(all_superkeynames, false);

ut.Layout_Names tgetname(ut.Layout_Superkeynames.InputLayout l) :=
transform
	self.name := l.superkeyname;
end;

all_filenames := project(all_superkeynames, tgetname(left));

email_body 	:= ut.fPrepareRoxieEmailBody(all_filenames);

send_roxie_email := fileservices.sendemail(	 'roxiedeployment@seisint.com;vniemela@seisint.com;lbentley@seisint.com'
											,'Infousa ABI Build Succeeded - 20060413'
											,email_body);

sequential(
	 rename_keys
	,send_roxie_email
);