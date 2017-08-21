import ut,digssoff;

export Proc_Generate_Extract(STRING p_filedate) := FUNCTION
 
 #workunit('name','ReSOLT: IMAP and Promonitor Extract ');
  
  

  PromonitorExtract := SOFF_ReSOLT_Integration.Mapping_BaseMain_to_Promonitor; 
	
    // nam      := dataset('~thor400_88_staging::persist::IMAP::name_List',Layout_name_list,flat);  
	// dl       := dataset('~thor400_88_staging::persist::IMAP::DL_List',Layout_dls_list,flat);  
	// emp      := dataset('~thor400_88_staging::persist::imap::employer_list',Layout_employer_list,flat); 
	// dob      := dataset('~thor400_88_staging::persist::IMAP::dob_List',Layout_dob_list,flat); 
	// dod      := dataset('~thor400_88_staging::persist::IMAP::dod_List',Layout_dod_list,flat); 
	// phone    := dataset('~thor400_88_staging::persist::imap::phone_list',Layout_phone_list,flat); 
	// add      := dataset('~thor400_88_staging::persist::imap::address_list',Layout_address_list,flat); 
	// hra      := dataset('~thor400_88_staging::persist::IMAP::HRA_List',Layout_hra_list,flat); 
	// veh      := dataset('~thor400_88_staging::persist::imap::vehicle_list',SOFF_ReSOLT_Integration.Layout_vehicle_list,flat);
	// SORmain  := dataset('~thor400_88_staging::persist::imap::SOR_Main',SOFF_ReSOLT_Integration.Layout_SOR_offender_out,flat); 
	// SORadd   := dataset('~thor400_88_staging::persist::Imap::SOR_addresses',SOFF_ReSOLT_Integration.Layout_SOR_Address_out,flat); 
	// SOROff   := dataset('~thor400_88_staging::persist::IMAP::SOR_Offense',SOFF_ReSOLT_Integration.Layout_SOR_Offense_out,flat); 
	// SORveh   := dataset('~thor400_88_staging::persist::imap::SOR_Vehicles',SOFF_ReSOLT_Integration.Layout_SOR_Vehicle_out,flat);
	
	  dl     := SOFF_ReSOLT_Integration.Mapping_Extract_DL_list;
	  emp    := SOFF_ReSOLT_Integration.Mapping_Extract_Employer_list;
	  nam    := SOFF_ReSOLT_Integration.Mapping_Extract_Name_List;
	  dob    := SOFF_ReSOLT_Integration.Mapping_Extract_dob_List;
	  dod    := SOFF_ReSOLT_Integration.Mapping_Extract_dod_List;
	  HRA    := SOFF_ReSOLT_Integration.Mapping_Extract_HRA_List;
	  phone  := SOFF_ReSOLT_Integration.Mapping_extract_deduped_phoneList;
	  //phone  := SOFF_ReSOLT_Integration.Mapping_Extract_Phone_List;
	  add    := SOFF_ReSOLT_Integration.Mapping_Extract_Address_List;
	  veh    := SOFF_ReSOLT_Integration.Mapping_Extract_Vehicle_list;
	  SORMain:= SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Main;
	  SORAdd := SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Addresses;
	  SORVeh := SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Vehicles;
	  SOROff := SOFF_ReSOLT_Integration.Mapping_Extract_SOR_Offense;		 
	
	DS_SORFather := IF(nothor(FileServices.GetSuperFileSubCount(soff_resolt_integration.ReSOLT_SuperFile_List.IMAP_SOROffender_Extract)) <> 0, 
	                                   DATASET(soff_resolt_integration.ReSOLT_SuperFile_List.IMAP_SOROffender_Extract,
	                                           soff_resolt_integration.Layout_SOR_offender_out,CSV(SEPARATOR('|'), TERMINATOR('\n'))));
    DELFile := Table(DS_SORFather, {persistent_key},persistent_key);

  
	NameList    := output(nam,,
	                  ReSOLT_SuperFile_List.IMAP_Name_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	DLList      := output(dl,,
	                  ReSOLT_SuperFile_List.IMAP_DL_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	EmpList     := output(emp,,
	                  ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	DOBList     := output(dob,,
	                  ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	DODList     := output(dod,,
	                  ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	PhoneList   := output(phone,,
	                  ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	AddList     := output(add,,
	                  ReSOLT_SuperFile_List.IMAP_add_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	HRAList     := output(hra,,
	                  ReSOLT_SuperFile_List.IMAP_hra_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
    VehList     := output(veh,,
	                  ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);										
	SOROffender := output(SORMain,,
	                  ReSOLT_SuperFile_List.IMAP_SOROffender_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
	SORoffense  := output(SOROff,,
	                  ReSOLT_SuperFile_List.IMAP_SOROffense_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
    SORAddress  := output(SORAdd,,
	                  ReSOLT_SuperFile_List.IMAP_SORAddress_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);
    SORVehicle  := output(SORVeh,,
	                  ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);										
    PKDelList   := output(DELFile,,
	                  ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract+p_filedate,CSV(HEADING(SINGLE), SEPARATOR('|'), TERMINATOR('\n')),overwrite);																						          
    PMonList   := output(PromonitorExtract,,
	                  ReSOLT_SuperFile_List.IMAP_Promonitor_Extract+p_filedate,CSV(HEADING('EXTERNAL_ID|SSN|DOB_MONTH|DOB_DAY|DOB_YEAR|FIRST_NAME|MIDDLE_NAME|LAST_NAME|STREET_1|STREET_2|STREET_3|CITY|STATE|POSTAL_CODE|ACCOUNT_ID|USERNAME|OPERATION_TYPE|REFERENCE_ID|DL_NUM|DL_STATE|LINK_ID\n',SINGLE), 
										                                                             SEPARATOR('|'), TERMINATOR('\n')),overwrite);	
 
  Logical_file_name(STRING superfile) := IF(FileServices.GetSuperFileSubCount(superfile) <> 0,  
                                            FileServices.GetSuperFileSubName(superfile, 1),'' );
											
  delete_logical_file_func (STRING filename) := IF(filename <> '',  
                                                   FileServices.DeleteLogicalFile(filename));											  
																									
  Create_AllSuperFiles := Parallel  ( 
	                digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Delete),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Grandfather),
		       			  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_father),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract),
									  
					        digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Delete),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Grandfather),
					        digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_father),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract),
									  
	  	            digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Delete),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Grandfather),
					        digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_father),
                  digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract),
									  
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract),
									  
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract),
									  
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract),
									  
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract),
									  
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract),
									 
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_vehicle_lst_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_vehicle_lst_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_vehicle_lst_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_vehicle_lst_Extract),
										
  					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract),
										
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract),
									 
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract),
										
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract),
										
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract),
										
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Delete),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Grandfather),
					digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_father),
                    digssoff.SuperFile_Functions.Fun_createSuperfile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract));
																		 
	populate_delSuperfiles := Sequential (FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.NameList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Delete),        
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.DOBList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Delete),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.EMPList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Delete),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.DLList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Delete),
																												
				// FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.HRAList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Delete),        
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.DODList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Delete),	

				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.AddList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Delete),																												
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.PhoneList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Delete),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.VehList_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_Delete),
																																																								
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.SOROffender_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Delete),        
			
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.SOROffense_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Delete),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.SORVehicle_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_Delete),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.SORAddress_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Delete),				

				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.PKDelFile_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Delete),		
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_delete),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(Get_old_filenames_to_delete.Promonitor_del_file,
				                                                ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Delete));
																
populate_grndfather := sequential (FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Grandfather),
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Grandfather),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Grandfather),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Grandfather),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Grandfather),        
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Grandfather),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Grandfather),																												
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Grandfather),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_Grandfather),	
	      
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Grandfather),        
			
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Grandfather),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_Grandfather),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Grandfather),		
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Grandfather),			
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Grandfather),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_father),
				                                                ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Grandfather));
populate_father := sequential(FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract), 
				                                                ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_father),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_father),        
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_father),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_father),																												
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_father),																												

	            FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_father),        
			
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_father),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_father),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_father),		

				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_father),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile('~'+Logical_file_name(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract),
				                                                ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_father));																
																
Populate_extracts := Sequential (FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract+p_filedate, 
				                                                ReSOLT_SuperFile_List.IMAP_Name_lst_Extract),		
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_DL_lst_Extract),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract),        
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract),																													

				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_Add_lst_Extract),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract),	

                FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract),
 				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_SOROffender_Extract),        
			
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_SOROffense_Extract),	
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract),
																												
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_SORAddress_Extract),		

				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract),		
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract),
				digssoff.SuperFile_Functions.Fun_AddToSuperfile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract+p_filedate,
				                                                ReSOLT_SuperFile_List.IMAP_Promonitor_Extract));	
																
    
	string del_OldName_ext  := '':stored('Del_name_list');	
	string del_OldDOB_ext   := '':stored('Del_dob_list');	
	string del_OldDOD_ext   := '':stored('Del_dod_list');	
	string del_OldEMP_ext   := '':stored('Del_emp_list');	
	string del_OldHRA_ext   := '':stored('Del_HRA_list');																															
	string del_OldDL_ext    := '':stored('Del_DL_list');	
	string del_OldAdd_ext   := '':stored('Del_Add_list');	
	string del_OldPhone_ext := '':stored('Del_Phone_list');	
	string del_OldVeh_ext   := '':stored('Del_Veh_list');	
	
	string del_OldSOROffender_ext:= '':stored('Del_SOROffender');	
	string del_OldSOROffense_ext := '':stored('Del_SOROffense');	
	string del_OldSORAddress_ext := '':stored('Del_SORAddress');	
	string del_OldSORVehicle_ext := '':stored('Del_SORVehicle');	
	string del_OldPKDelList_ext  := '':stored('Del_PKDelList');	
	string del_OldProMonDelList_ext := '':stored('Del_ProMonList');	
	
	
	del_old_extracts := sequential(FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_delete),
				delete_logical_file_func(del_OldName_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_delete),
				delete_logical_file_func(del_OldDOB_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_delete),
				delete_logical_file_func(del_OldEMP_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_delete),
				delete_logical_file_func(del_OldDL_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_delete),
				delete_logical_file_func(del_OldHRA_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_delete),
				delete_logical_file_func(del_OldDOD_ext),
				
			    FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_delete),
				delete_logical_file_func(del_OldAdd_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_delete),
				delete_logical_file_func(del_OldPhone_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_delete),
				delete_logical_file_func(del_OldVeh_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_delete),
				delete_logical_file_func(del_OldSOROffender_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_delete),
				delete_logical_file_func(del_OldSOROffense_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_delete),
				delete_logical_file_func(del_OldSORAddress_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_delete),
				delete_logical_file_func(del_OldSORVehicle_ext),
								
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_delete),
				delete_logical_file_func(del_OldPKDelList_ext),
				
				FileServices.ClearSuperFile(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_delete),
				delete_logical_file_func(del_OldProMonDelList_ext));																
	
 																												
//Move delimited main superfiles
  
  SuperFile_Move := sequential(Create_AllSuperFiles,
			 
	                       PARALLEL (NameList,
									 DLList,
									 EMPList,
									 DOBList,
									 DODList,
									 VehList),
						   AddList,
						   PhoneList,
						   HRAList,
						   sequential(SOROffender,
							        SORoffense,
							        SORAddress,
							        SORVehicle,
									PKDelList,
									PMonList),
															 
                FileServices.StartSuperFileTransaction(),
				
				populate_delSuperfiles,																			
///--------------------------------------------------------------------------------------------------------------------------------------
				populate_grndfather,																													
///--------------------------------------------------------------------------------------------------------------------------------------
				populate_father,																													
///--------------------------------------------------------------------------------------------------------------------------------------
				Populate_extracts,	
																												
				FileServices.FinishSuperFileTransaction(),
///--------------------------------------------------------------------------------------------------------------------------------------				
				del_old_extracts,
				Function_Despray_Extracts(p_filedate));
 		 
  return SuperFile_Move;	
 end ;