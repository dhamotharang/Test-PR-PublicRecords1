import ut;

export rename_keys(string new_date) :=
function

all_vehiclekeys := DATASET([
{'~thor_data400::key::vehiclev2::main_key_qa',             '~thor_data400::key::vehiclev2::'+new_date+'::main_key'},
{'~thor_data400::wc_vehicle::keynameindex_public_qa',      '~thor_data400::key::vehicle::'+new_date+'::keynameindex_public'},
{'~thor_data400::wc_vehicle::keymodelindex_public_qa',     '~thor_data400::key::vehicle::'+new_date+'::keymodelindex_public'},
{'~thor_data400::hole::wildcard_public',                   '~thor_data400::data::vehicle::'+new_date+'::wildcard_public'}, 
{'~thor_data400::key::vehiclev2::autokey::address_qa',     '~thor_data400::key::vehiclev2::'+new_date+'::autokey::address'},
{'~thor_data400::key::vehiclev2::autokey::addressb2_qa',   '~thor_data400::key::vehiclev2::'+new_date+'::autokey::addressb2'},
{'~thor_data400::key::vehiclev2::autokey::citystname_qa',  '~thor_data400::key::vehiclev2::'+new_date+'::autokey::citystname'},
{'~thor_data400::key::vehiclev2::autokey::citystnameb2_qa','~thor_data400::key::vehiclev2::'+new_date+'::autokey::citystnameb2'},
{'~thor_data400::key::vehiclev2::autokey::fein2_qa',       '~thor_data400::key::vehiclev2::'+new_date+'::autokey::fein2'}, 
{'~thor_data400::key::vehiclev2::autokey::name_qa',        '~thor_data400::key::vehiclev2::'+new_date+'::autokey::name'}, 
{'~thor_data400::key::vehiclev2::autokey::nameb2_qa',      '~thor_data400::key::vehiclev2::'+new_date+'::autokey::nameb2'}, 
{'~thor_data400::key::vehiclev2::autokey::namewords2_qa',  '~thor_data400::key::vehiclev2::'+new_date+'::autokey::namewords2'}, 
{'~thor_data400::key::vehiclev2::autokey::payload_qa',     '~thor_data400::key::vehiclev2::'+new_date+'::autokey::payload'}, 
{'~thor_data400::key::vehiclev2::autokey::ssn2_qa',        '~thor_data400::key::vehiclev2::'+new_date+'::autokey::ssn2'}, 
{'~thor_data400::key::vehiclev2::autokey::stname_qa',      '~thor_data400::key::vehiclev2::'+new_date+'::autokey::stname'}, 
{'~thor_data400::key::vehiclev2::autokey::stnameb2_qa',    '~thor_data400::key::vehiclev2::'+new_date+'::autokey::stnameb2'}, 
{'~thor_data400::key::vehiclev2::autokey::zip_qa',         '~thor_data400::key::vehiclev2::'+new_date+'::autokey::zip'}, 
{'~thor_data400::key::vehiclev2::autokey::zipb2_qa',       '~thor_data400::key::vehiclev2::'+new_date+'::autokey::zipb2'}, 
{'~thor_data400::key::vehiclev2::bdid_qa',                 '~thor_data400::key::vehiclev2::'+new_date+'::bdid'}, 
{'~thor_data400::key::vehiclev2::did_qa',                  '~thor_data400::key::vehiclev2::'+new_date+'::did'}, 
{'~thor_data400::key::vehiclev2::dl_number_qa',            '~thor_data400::key::vehiclev2::'+new_date+'::dl_number'}, 
{'~thor_data400::key::vehiclev2::lic_plate_qa',            '~thor_data400::key::vehiclev2::'+new_date+'::lic_plate'}, 
{'~thor_data400::key::vehiclev2::party_key_qa',            '~thor_data400::key::vehiclev2::'+new_date+'::party_key'}, 
{'~thor_data400::key::vehiclev2::title_number_qa',         '~thor_data400::key::vehiclev2::'+new_date+'::title_number'}, 
{'~thor_data400::key::vehiclev2::vin_qa',                  '~thor_data400::key::vehiclev2::'+new_date+'::vin'}, 
{'~thor_data400::key::vehiclev2::reverse_lic_plate_qa',    '~thor_data400::key::vehiclev2::'+new_date+'::reverse_lic_plate'}, 
{'~thor_data400::key::vehiclev2::bocashell_did_qa',        '~thor_data400::key::vehiclev2::'+new_date+'::bocashell_did'}, 
//boolean
{'~thor_data400::key::vehiclev2::qa::dictindx',            '~thor_data400::key::vehiclev2::'+new_date+'::dictindx'}, 
{'~thor_data400::key::vehiclev2::qa::docref.vehkey',       '~thor_data400::key::vehiclev2::'+new_date+'::docref.vehkey'}, 
{'~thor_data400::key::vehiclev2::qa::nidx',                '~thor_data400::key::vehiclev2::'+new_date+'::nidx'}, 
{'~thor_data400::key::vehiclev2::qa::xdstat2',             '~thor_data400::key::vehiclev2::'+new_date+'::xdstat2'}, 
{'~thor_data400::key::vehiclev2::qa::xseglist',            '~thor_data400::key::vehiclev2::'+new_date+'::xseglist'},
{'~thor_data400::key::vehiclev2::qa::dictindx2',           '~thor_data400::key::vehiclev2::'+new_date+'::dictindx2'}, 
{'~thor_data400::key::vehiclev2::qa::nidx3',               '~thor_data400::key::vehiclev2::'+new_date+'::nidx3'} 

], ut.Layout_Superkeynames.inputlayout);

return_this := ut.fLogicalKeyRenaming(all_vehiclekeys, false);

return return_this;

end;
