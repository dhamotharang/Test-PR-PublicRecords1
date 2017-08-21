import doxie, versioncontrol;

all_superkeynames := DATASET([

	 {'~thor_data400::key::busreg_company_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg::@version@::company.bdid'},
	 {'~thor_data400::key::busreg_contact_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg::@version@::contact.bdid'}

], versioncontrol.Layout_Superkeynames.InputLayout);

versioncontrol.fLogicalKeyRenaming(all_superkeynames, false);

/*

Example of how to undo renaming

fileservices.clearsuperfile('~thor_data400::key::busreg_company_bdid_' + doxie.Version_SuperKey);
fileservices.clearsuperfile('~thor_data400::key::busreg_contact_bdid_' + doxie.Version_SuperKey);

fileservices.renamelogicalfile('~thor_data400::key::busreg::20050411::company.bdid', '~thor_data400::key::busreg_company_bdidw20050411-095123');
fileservices.renamelogicalfile('~thor_data400::key::busreg::20050411::contact.bdid', '~thor_data400::key::busreg_contact_bdidw20050411-095123');

fileservices.addsuperfile('~thor_data400::key::busreg_company_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg_company_bdidw20050411-095123');
fileservices.addsuperfile('~thor_data400::key::busreg_contact_bdid_' + doxie.Version_SuperKey, '~thor_data400::key::busreg_contact_bdidw20050411-095123');
*/

