//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.
import promotesupers;

EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
	RETURN 'SUCCESS';
END;

SHARED MakeSuperFiles(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION

MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash0');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash1');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash2v');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash3v');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash4');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash5');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash6');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash7');
MakeSuperKeys ('~prte::key::ecrash::@version@::ecrash8');

MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_byagencyid');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_bycollisiontype');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_bydow');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_byhod');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_byinter');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::analytics_bymoy');

MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::addressb2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::address');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::citystnameb2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::citystname');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::nameb2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::namewords2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::name');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::payload');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::stnameb2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::stname');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::zipb2');
MakeSuperKeys ('~prte::key::ecrashv2::autokey::@version@::zip');

MakeSuperKeys ('~prte::key::ecrashv2::@version@::accnbrv1');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::accnbr');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::agencyid_sentdate');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::bdid');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::deltadate');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::did');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::dlnbr');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::dol');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::lastname_state');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::linkids');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::partialaccnbr');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::photoid');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::prefname_state');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::reportid');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::reportlinkid');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::standlocation');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::supplemental');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::tagnbr');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::vin7');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::vin');
MakeSuperKeys ('~prte::key::ecrashv2::@version@::agency');


// MakeSuperFiles ('~PRTE::BASE::ecrashv2@version@');
// MakeSuperFiles ('~PRTE::BASE::ecrashv2@version@');
// MakeSuperFiles ('~PRTE::BASE::ecrashv2@version@');
// MakeSuperFiles ('~PRTE::BASE::ecrashv2@version@');

promotesupers.mac_create_superfiles('~prte::base::ecrashv2');
promotesupers.mac_create_superfiles('~prte::base::ecrash0');
promotesupers.mac_create_superfiles('~prte::base::ecrash1');
promotesupers.mac_create_superfiles('~prte::base::ecrash2');
promotesupers.mac_create_superfiles('~prte::base::ecrash3');
promotesupers.mac_create_superfiles('~prte::base::ecrash4');
promotesupers.mac_create_superfiles('~prte::base::ecrash5');
promotesupers.mac_create_superfiles('~prte::base::ecrash6');
promotesupers.mac_create_superfiles('~prte::base::ecrash7');
promotesupers.mac_create_superfiles('~prte::base::ecrash8');
promotesupers.mac_create_superfiles('~prte::base::ecrash9');

FileServices.CreateSuperFile ('~PRTE::IN::ecrashv2');

RETURN 'SUCCESS';

End;

End;