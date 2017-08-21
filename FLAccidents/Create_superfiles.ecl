export Create_superfiles := sequential(


//payload
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::qa::payload',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::prod::payload',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::built::payload',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::delete::payload',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::father::payload',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster  + '::key::flcrash::autokey::Grandfather::payload',false),
//name
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::Name',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::Name',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::Name',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::Name',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::Name',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::Name',false),
//address
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::Address',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::Address',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::Address',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::Address',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::Address',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::Address',false),
//city
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::CityStName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::CityStName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::CityStName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::CityStName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::CityStName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::CityStName',false),
//street name
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::StName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::StName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::StName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::StName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::StName',false),
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::StName',false),
//zip
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::Zip',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::Zip',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::Zip',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::Zip',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::Zip',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::Zip',false),
//address2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::address2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::address2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::address2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::address2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::address2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::address2',false),
//citystname2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::citystname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::citystname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::citystname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::citystname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::citystname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::citystname2',false),
//phone2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::phone2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::phone2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::phone2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::phone2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::phone2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::phone2',false),
//stname2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::stname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::stname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::stname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::stname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::stname2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::stnameb2',false),
//ssn2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::ssn2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::ssn2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::ssn2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::ssn2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::ssn2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::ssn2',false),
//namewords2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::namewords2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::namewords2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::namewords2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::namewords2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::namewords2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::namewords2',false),
//business nameb *************
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::nameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::nameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::nameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::nameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::nameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::nameb',false),
//nameb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::nameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::nameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::nameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::nameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::nameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::nameb2',false),
//addressb
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::addressb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::addressb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::addressb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::addressb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::addressb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::addressb',false),
//addressb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::addressb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::addressb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::addressb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::addressb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::addressb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::addressb2',false),
//stnameb
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::stnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::stnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::stnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::stnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::stnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::stnameb',false),
//stnameb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::stnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::stnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::stnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::stnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::stnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::stnameb2',false),
//citystnameb
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::citystnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::citystnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::citystnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::citystnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::citystnameb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::citystnameb',false),
//citystnameb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::citystnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::citystnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::citystnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::citystnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::citystnameb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::citystnameb2',false),
//zipb
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::zipb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::zipb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::zipb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::zipb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::zipb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::zipb',false),
//zipb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::zipb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::zipb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::zipb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::zipb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::zipb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::zipb2',false),
//phoneb
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::phoneb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::phoneb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::phoneb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::phoneb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::phoneb',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::phoneb',false),
//phoneb2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::phoneb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::phoneb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::phoneb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::phoneb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::phoneb2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::phoneb2',false),
//FEIN
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::fein',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::fein',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::fein',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::fein',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::fein',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::fein',false),
//FEIN2
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::qa::fein2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::prod::fein2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::built::fein2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::delete::fein2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::father::fein2',false);
FileServices.CreateSuperFile(FLAccidents.Constants.cluster + '::key::flcrash::autokey::Grandfather::fein2',false)
);
