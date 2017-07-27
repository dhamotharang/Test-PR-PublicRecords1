import ut;
basename:=cluster_name+'::base::Appriss_';
		
//file_agency_delete 	:=prep_agency_deletes_from_raw;
ut.MAC_SF_BuildProcess(prep_agency_deletes_from_raw,basename+'agency_delete_prepA',agency_deleteA,3)

export proc_build_agency_delete_file :=if(
fn_exist_agencyDeletes(),
sequential(agency_deleteA,
          output(prep_agency_deletes_from_raw,,basename+'agency_delete_prepB'+thorlib.WUID()),
						FileServices.StartSuperFileTransaction(),
					   FileServices.AddSuperFile(basename+'agency_delete_prepB', basename +'agency_delete_prepB'+ thorlib.WUID()),
					  FileServices.FinishSuperFileTransaction()
					),
output('No Agency Delete Files Exist')

);