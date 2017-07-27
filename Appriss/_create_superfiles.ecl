fn_createSF(STRING superfile) := IF(FileServices.SuperFileExists(superfile),output('SuperFile Exists: '+ superfile ),
                                                                 FileServices.CreateSuperFile(superfile)
											                              );

basename:=cluster_name+'::base::Appriss_';		 

export _create_superfiles := sequential(
	FileServices.StartSuperFileTransaction(),
fn_createSF(basename+'bookings_prepA'),
fn_createSF(basename+'bookings_prepA_father'),
fn_createSF(basename+'bookings_prepA_grandfather'),
fn_createSF(basename+'bookings_prepA_delete'),
fn_createSF(basename+'bookings_prepA_building'),
fn_createSF(basename+'bookings_prepA_built'),
//
fn_createSF(basename+'charges_prepA'),
fn_createSF(basename+'charges_prepA_father'),
fn_createSF(basename+'charges_prepA_grandfather'),
fn_createSF(basename+'charges_prepA_delete'),
fn_createSF(basename+'charges_prepA_building'),
fn_createSF(basename+'charges_prepA_built'),
//
fn_createSF(basename+'agency_delete_prepA'),
fn_createSF(basename+'agency_delete_prepA_father'),
fn_createSF(basename+'agency_delete_prepA_grandfather'),
fn_createSF(basename+'agency_delete_prepA_delete'),
fn_createSF(basename+'agency_delete_prepA_building'),
fn_createSF(basename+'agency_delete_prepA_built'),
//
fn_createSF(basename+'bookings_prepB'),
fn_createSF(basename+'bookings_prepB_father'),
fn_createSF(basename+'bookings_prepB_grandfather'),
fn_createSF(basename+'bookings_prepB_delete'),
fn_createSF(basename+'bookings_prepB_building'),
fn_createSF(basename+'bookings_prepB_built'),
//
fn_createSF(basename+'charges_prepB'),
fn_createSF(basename+'charges_prepB_father'),
fn_createSF(basename+'charges_prepB_grandfather'),
fn_createSF(basename+'charges_prepB_delete'),
fn_createSF(basename+'charges_prepB_building'),
fn_createSF(basename+'charges_prepB_built'),
//
fn_createSF(basename+'agency_delete_prepB'),
fn_createSF(basename+'agency_delete_prepB_father'),
fn_createSF(basename+'agency_delete_prepB_grandfather'),
fn_createSF(basename+'agency_delete_prepB_delete'),
fn_createSF(basename+'agency_delete_prepB_building'),
fn_createSF(basename+'agency_delete_prepB_built'),


FileServices.FinishSuperFileTransaction()

);