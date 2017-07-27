
fn_createSF(STRING superfile) := IF(FileServices.SuperFileExists(superfile),output('SuperFile Exists: '+ superfile ),
                                                                 FileServices.CreateSuperFile(superfile)
											                              );
INSFile := '~appriss_images::in::all_appriss_images';
basename1:='~Appriss_images::base::matrix_images';		
basename2:='~Appriss_images::key::matrix_images';

export _create_superfile := sequential(
FileServices.StartSuperFileTransaction(),
fn_createSF(INSFile),
fn_createSF(basename1),
fn_createSF(basename1+'_building'),
fn_createSF(basename1+'_built'),
fn_createSF(basename1+'_delete'),
fn_createSF(basename1+'_father'),
fn_createSF(basename1+'_grandfather'),

fn_createSF(basename2+'_built'),
fn_createSF(basename2+'_delete'),
fn_createSF(basename2+'_father'),
fn_createSF(basename2+'_prod'),
fn_createSF(basename2+'_qa'),

fn_createSF(basename2+'_did_built'),
fn_createSF(basename2+'_did_delete'),
fn_createSF(basename2+'_did_father'),
fn_createSF(basename2+'_did_prod'),
fn_createSF(basename2+'_did_qa'),
FileServices.FinishSuperFileTransaction()

);