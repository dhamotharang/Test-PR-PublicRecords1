import VersionControl,lib_stringlib,lib_fileservices,_control,Orbit3,STD,PromoteSupers;
export Build_all(string ver) := function

//-----------Spray input and delete files
#IF (IsFullUpdate = false)
spray_it := VersionControl.fSprayInputFiles(Spray(ver).Updates);
consolidate_them := TransunionCred.fn_consolidate_inputs.Updates;
#ELSE
spray_it := VersionControl.fSprayInputFiles(Spray(ver).Load);
consolidate_them := TransunionCred.fn_consolidate_inputs.Load;
#END

deletefilename := 'DPART1';

checkfileexists(string deletefilename)
 := if(count(FileServices.remotedirectory(_Control.IPAddress.bctlpedata11,'/data/hds_180/nb_temp/data/' + ver ,deletefilename,false)(size <>0 )) = 1,
	 true,
	 false
	);

fail_on_no_deletes := sequential(STD.System.Email.SendEmail(_control.MyInfo.EmailAddressNotify,'',''),
                                 output('no delete file spray')
                        );

spray_deletes := if(checkfileexists('DPART1'), VersionControl.fSprayInputFiles(Spray(ver).deletes),fail_on_no_deletes);

add_deletes   := if(FileServices.GetSuperFileSubCount(Superfile_List.deletes) = 0
												,output('no_delete_this_time')
,FileServices.AddSuperFile(Superfile_List.Deletes_father,Superfile_List.deletes,,true));

delete_deletes := if(FileServices.GetSuperFileSubCount(Superfile_List.deletes) = 0
												,output('no_delete_this_time')
,FileServices.ClearSuperFile(Superfile_List.deletes));

PromoteSupers.Mac_SF_BuildProcess(TransunionCred.Build_base(ver).all,Superfile_List.Base, TransunionCred,2,,true);

zDoPopulationStats := Strata(ver);

built := sequential(
					spray_it,
		      consolidate_them,
#IF (IsFullUpdate = false)
					spray_deletes,
					TransunionCred
					//Archive processed files in history
					,add_deletes
					,delete_deletes
					,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Superfile_List.updates_history_compressed,Superfile_List.updates_father,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates_father)
					,FileServices.AddSuperFile(Superfile_List.updates_father,Superfile_List.updates,,true)
					,FileServices.ClearSuperFile(Superfile_List.updates)
					,FileServices.FinishSuperFileTransaction()
#ELSE
					,TransunionCred
				    ,FileServices.StartSuperFileTransaction()
					,FileServices.AddSuperFile(Superfile_List.load_father,Superfile_List.load,,true)
					,FileServices.ClearSuperFile(Superfile_List.load)
					,FileServices.FinishSuperFileTransaction()
#END
					,zDoPopulationStats
					);

return built;

end;