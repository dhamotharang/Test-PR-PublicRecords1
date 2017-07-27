fn_createSF(STRING superfile) := IF(FileServices.SuperFileExists(superfile),output('SuperFile Exists: '+ superfile ),
                                                                 FileServices.CreateSuperFile(superfile)
											                              );

basename :='~thor_200::key::Appriss';
export _create_key_superfiles := sequential(
	FileServices.StartSuperFileTransaction(),
//
/*
thor_200::key::entiera::autokey::built::address    2009-08-07 18:30:55    
  thor_200::key::entiera::autokey::built::citystname    2009-08-07 18:30:56    
  thor_200::key::entiera::autokey::built::name    2009-08-07 18:30:55    
  thor_200::key::entiera::autokey::built::payload    2009-08-07 15:21:24    
  thor_200::key::entiera::autokey::built::ssn2    2009-08-07 18:30:54    
  thor_200::key::entiera::autokey::built::stname    2009-08-07 18:30:55    
  thor_200::key::entiera::autokey::built::zip 

superfile: thor_200::key::Appriss::autokey::built::Payload
*/
fn_createSF(basename+'::autokey::built::Payload'),
fn_createSF(basename+'::autokey::built::name'),
fn_createSF(basename+'::autokey::built::address'),
fn_createSF(basename+'::autokey::built::citystname'),
fn_createSF(basename+'::autokey::built::stname'),
fn_createSF(basename+'::autokey::built::ssn2'),
fn_createSF(basename+'::autokey::built::zip'),
fn_createSF(basename+'::autokey::built::phone2'),
fn_createSF(basename+'::built::did'),
fn_createSF(basename+'::built::bookings_id'),
fn_createSF(basename+'::built::charges_id'),
fn_createSF(basename+'::built::dl'),
fn_createSF(basename+'::built::fbi'),
fn_createSF(basename+'::built::state_id'),
fn_createSF(basename+'::built::gang'),
fn_createSF(basename+'::built::demographic'),
fn_createSF(basename+'::built::AgencyStateCd'),
fn_createSF(basename+'::built::ap_ssn'),
//
fn_createSF(basename+'::autokey::QA::Payload'),
fn_createSF(basename+'::autokey::QA::name'),
fn_createSF(basename+'::autokey::QA::address'),
fn_createSF(basename+'::autokey::QA::citystname'),
fn_createSF(basename+'::autokey::QA::stname'),
fn_createSF(basename+'::autokey::QA::ssn2'),
fn_createSF(basename+'::autokey::QA::zip'),
fn_createSF(basename+'::autokey::QA::phone2'),
fn_createSF(basename+'::QA::did'),
fn_createSF(basename+'::QA::bookings_id'),
fn_createSF(basename+'::QA::charges_id'),
fn_createSF(basename+'::QA::dl'),
fn_createSF(basename+'::QA::fbi'),
fn_createSF(basename+'::QA::state_id'),
fn_createSF(basename+'::QA::gang'),
fn_createSF(basename+'::QA::demographic'),
fn_createSF(basename+'::QA::AgencyStateCd'),
fn_createSF(basename+'::QA::ap_ssn'),
//
fn_createSF(basename+'::autokey::delete::Payload'),
fn_createSF(basename+'::autokey::delete::name'),
fn_createSF(basename+'::autokey::delete::address'),
fn_createSF(basename+'::autokey::delete::citystname'),
fn_createSF(basename+'::autokey::delete::stname'),
fn_createSF(basename+'::autokey::delete::ssn2'),
fn_createSF(basename+'::autokey::delete::zip'),
fn_createSF(basename+'::autokey::delete::phone2'),
fn_createSF(basename+'::delete::did'),
fn_createSF(basename+'::delete::bookings_id'),
fn_createSF(basename+'::delete::charges_id'),
fn_createSF(basename+'::delete::dl'),
fn_createSF(basename+'::delete::fbi'),
fn_createSF(basename+'::delete::state_id'),
fn_createSF(basename+'::delete::gang'),
fn_createSF(basename+'::delete::demographic'),
fn_createSF(basename+'::delete::AgencyStateCd'),
fn_createSF(basename+'::delete::ap_ssn'),

//
fn_createSF(basename+'::autokey::father::Payload'),
fn_createSF(basename+'::autokey::father::name'),
fn_createSF(basename+'::autokey::father::address'),
fn_createSF(basename+'::autokey::father::citystname'),
fn_createSF(basename+'::autokey::father::stname'),
fn_createSF(basename+'::autokey::father::ssn2'),
fn_createSF(basename+'::autokey::father::zip'),
fn_createSF(basename+'::autokey::father::phone2'),
fn_createSF(basename+'::father::did'),
fn_createSF(basename+'::father::bookings_id'),
fn_createSF(basename+'::father::charges_id'),
fn_createSF(basename+'::father::dl'),
fn_createSF(basename+'::father::fbi'),
fn_createSF(basename+'::father::state_id'),
fn_createSF(basename+'::father::gang'),
fn_createSF(basename+'::father::demographic'),
fn_createSF(basename+'::father::AgencyStateCd'),
fn_createSF(basename+'::father::ap_ssn'),
//
fn_createSF(basename+'::autokey::grandfather::Payload'),
fn_createSF(basename+'::autokey::grandfather::name'),
fn_createSF(basename+'::autokey::grandfather::address'),
fn_createSF(basename+'::autokey::grandfather::citystname'),
fn_createSF(basename+'::autokey::grandfather::stname'),
fn_createSF(basename+'::autokey::grandfather::ssn2'),
fn_createSF(basename+'::autokey::grandfather::zip'),
fn_createSF(basename+'::autokey::grandfather::phone2'),
fn_createSF(basename+'::grandfather::did'),
fn_createSF(basename+'::grandfather::bookings_id'),
fn_createSF(basename+'::grandfather::charges_id'),
fn_createSF(basename+'::grandfather::dl'),
fn_createSF(basename+'::grandfather::fbi'),
fn_createSF(basename+'::grandfather::state_id'),
fn_createSF(basename+'::grandfather::gang'),
fn_createSF(basename+'::grandfather::demographic'),
fn_createSF(basename+'::grandfather::AgencyStateCd'),
fn_createSF(basename+'::grandfather::ap_ssn'),
//


FileServices.FinishSuperFileTransaction()

);

