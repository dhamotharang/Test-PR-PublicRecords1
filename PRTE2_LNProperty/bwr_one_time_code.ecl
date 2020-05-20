
EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
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

MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::ownership_did');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::ownership.did');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::ownership_addr');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::addr.full_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::did.ownership_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::addllegal.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::addlnames.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::addr_search.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::assessor.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::deed.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::search.did');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::search.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::search.fid_county');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::addr.full_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::fcra::@version@::did.ownership_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::addressb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::address_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::citystnameb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::citystname_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::fein2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::nameb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::namewords2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::name_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::payload_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::phone2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::phoneb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::ssn2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::stnameb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::stname_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::zipb2_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::autokey::zip_@version@');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addlfaresdeed.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addlfarestax.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addllegal.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addlnames.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addr_search.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::assessor.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::assessor.parcelnum');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::deed.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::deed.parcelnum');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::deed.zip_loanamt');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::search.bdid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::search.did');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::search.fid');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::search.fid_county');

MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::search.linkids');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addr.full_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::addr.full_v4_no_fares');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::deed::zip_avg_sales_price');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::did.ownership_v4');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::did.ownership_v4_no_fares');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::ownership.did');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::ownership_addr');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::ownership_did');
MakeSuperKeys ('~prte::key::ln_propertyv2::@version@::tax_summary');


MakeSuperFiles ('~PRTE::BASE::ln_propertyv2::deed@version@');

MakeSuperFiles ('~PRTE::BASE::ln_propertyv2::search@version@');

MakeSuperFiles ('~PRTE::BASE::ln_propertyv2::tax@version@');

FileServices.CreateSuperFile ('~PRTE::IN::ln_propertyv2::deed');

FileServices.CreateSuperFile ('~PRTE::IN::ln_propertyv2::search');

FileServices.CreateSuperFile ('~PRTE::IN::ln_propertyv2::tax');


RETURN 'SUCCESS';

End;

End;