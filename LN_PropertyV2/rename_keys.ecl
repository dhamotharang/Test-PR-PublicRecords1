import ut;

export rename_keys(string new_date) :=
function

all_propertykeys := DATASET([
{'~thor_data400::key::ln_propertyv2::qa::deed.fid',             '~thor_data400::key::ln_propertyv2::'+new_date+'::deed.fid'},
{'~thor_data400::key::ln_propertyv2::qa::addllegal.fid',        '~thor_data400::key::ln_propertyv2::'+new_date+'::addllegal.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::assessor.fid',         '~thor_data400::key::ln_propertyv2::'+new_date+'::assessor.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::addlnames.fid',        '~thor_data400::key::ln_propertyv2::'+new_date+'::addlnames.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::addlfarestax.fid',     '~thor_data400::key::ln_propertyv2::'+new_date+'::addlfarestax.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::assessor.parcelnum',   '~thor_data400::key::ln_propertyv2::'+new_date+'::assessor.parcelnum'}, 
{'~thor_data400::key::ln_propertyv2::qa::deed.parcelnum',       '~thor_data400::key::ln_propertyv2::'+new_date+'::deed.parcelnum'}, 
{'~thor_data400::key::ln_propertyv2::qa::did.ownership',        '~thor_data400::key::ln_propertyv2::'+new_date+'::did.ownership'}, 
{'~thor_data400::key::ln_propertyv2::qa::search.bdid',          '~thor_data400::key::ln_propertyv2::'+new_date+'::search.bdid'}, 
{'~thor_data400::key::ln_propertyv2::qa::search.did',           '~thor_data400::key::ln_propertyv2::'+new_date+'::search.did'}, 
{'~thor_data400::key::ln_propertyv2::qa::search.fid',           '~thor_data400::key::ln_propertyv2::'+new_date+'::search.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::search.fid_county',    '~thor_data400::key::ln_propertyv2::'+new_date+'::search.fid_county'}, 
{'~thor_data400::key::ln_propertyv2::qa::addr_search.fid',      '~thor_data400::key::ln_propertyv2::'+new_date+'::addr_search.fid'}, 
{'~thor_data400::key::ln_propertyv2::qa::addlfaresdeed.fid',    '~thor_data400::key::ln_propertyv2::'+new_date+'::addlfaresdeed.fid'}, 
//autokey
{'~thor_data400::key::ln_propertyv2::autokey::address_qa',      '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::address'}, 
{'~thor_data400::key::ln_propertyv2::autokey::addressb2_qa',    '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::addressb2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::citystname_qa',   '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::citystname'}, 
{'~thor_data400::key::ln_propertyv2::autokey::citystnameb2_qa', '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::citystnameb2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::fein2_qa',        '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::fein2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::name_qa',         '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::name'}, 
{'~thor_data400::key::ln_propertyv2::autokey::nameb2_qa',       '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::nameb2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::namewords2_qa',   '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::namewords2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::payload_qa',      '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::payload'}, 
{'~thor_data400::key::ln_propertyv2::autokey::phone2_qa',       '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::phone2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::phoneb2_qa',      '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::phoneb2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::ssn2_qa',         '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::ssn2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::stname_qa',       '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::stname'}, 
{'~thor_data400::key::ln_propertyv2::autokey::stnameb2_qa',     '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::stnameb2'}, 
{'~thor_data400::key::ln_propertyv2::autokey::zip_qa',          '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::zip'}, 
{'~thor_data400::key::ln_propertyv2::autokey::zipb2_qa',        '~thor_data400::key::ln_propertyv2::'+new_date+'::autokey::zipb2'}, 
//boolean
{'~thor_data400::key::ln_propertyv2::assessment::qa::dictindx',     '~thor_data400::key::ln_propertyv2::assessment::'+new_date+'::dictindx'}, 
{'~thor_data400::key::ln_propertyv2::assessment::qa::doc.fares_id', '~thor_data400::key::ln_propertyv2::assessment::'+new_date+'::doc.fares_id'}, 
{'~thor_data400::key::ln_propertyv2::assessment::qa::xseglist',     '~thor_data400::key::ln_propertyv2::assessment::'+new_date+'::xseglist'}, 
{'~thor_data400::key::ln_propertyv2::deeds::qa::dictindx',          '~thor_data400::key::ln_propertyv2::deeds::'+new_date+'::dictindx'}, 
{'~thor_data400::key::ln_propertyv2::deeds::qa::doc.fares_id',      '~thor_data400::key::ln_propertyv2::deeds::'+new_date+'::doc.fares_id'}, 
{'~thor_data400::key::ln_propertyv2::deeds::qa::xseglist',          '~thor_data400::key::ln_propertyv2::deeds::'+new_date+'::xseglist'}, 
{'~thor_data400::key::ln_propertyv2::deeds::qa::nidx',              '~thor_data400::key::ln_propertyv2::deeds::'+new_date+'::nidx'}, 
{'~thor_data400::key::ln_propertyv2::assessment::qa::nidx',         '~thor_data400::key::ln_propertyv2::assessment::'+new_date+'::nidx'} 
], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_propertykeys, false);

return return_this;

end;
