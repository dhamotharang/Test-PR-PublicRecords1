import ut;

file_bookings				:=prep_bookings_with_DID_SSN;
file_charges 				:=prep_norm_charges_from_raw;
//Agency Delete Moved out to another attribute

basename:=cluster_name+'::base::Appriss_';		 
//prep files for Proc A 
ut.MAC_SF_BuildProcess(file_charges,basename+'charges_prepA',chargesA,3);
ut.MAC_SF_BuildProcess(file_bookings,basename+'bookings_prepA',bookingsA,3);
//ut.MAC_SF_BuildProcess(file_agency_delete,basename+'agency_delete_prepA',agency_deleteA,3);
//Prep files for Proc B
ProcB:=sequential(
	FileServices.StartSuperFileTransaction(),
output(file_charges,,basename+'charges_prepB'+thorlib.WUID()),
output(file_bookings,,basename+'bookings_prepB'+thorlib.WUID()),
//output(file_agency_delete,,basename+'agency_delete_prepB'+thorlib.WUID()),
FileServices.AddSuperFile(basename+'charges_prepB', basename +'charges_prepB'+ thorlib.WUID()),
FileServices.AddSuperFile(basename+'bookings_prepB', basename +'bookings_prepB'+ thorlib.WUID()),
//FileServices.AddSuperFile(basename+'agency_delete_prepB', basename +'agency_delete_prepB'+ thorlib.WUID()),
FileServices.FinishSuperFileTransaction()
);
/*
BUILDING /BUILT SUPERFILE LOGIC HERE ?? or EARLIER
*/
 

export proc_build_all_files := parallel(
                              chargesA,
                              bookingsA,
															//agency_deleteA,
															proc_build_agency_delete_file,
															ProcB
															//,cleanup  to be added later
															);