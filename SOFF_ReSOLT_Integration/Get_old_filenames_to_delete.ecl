export Get_old_filenames_to_delete := module 


shared get_logical_file_name (string superfile) := IF(FileServices.SuperFileExists(superfile) and 
                                                      FileServices.GetSuperFileSubCount(superfile) <> 0,
                                                         '~'+FileServices.GetSuperFileSubName(superfile, 1),''
						                              );
																									
#stored ('Del_name_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract_Grandfather));
string GNameList_del_file := '':stored('Del_name_list');
export NameList_del_file  := GNameList_del_file;

#stored ('Del_dob_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract_Grandfather));
string GDOBList_del_file := '':stored('Del_dob_list');
export DOBList_del_file  := GDOBList_del_file;

#stored ('Del_emp_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract_Grandfather));
string GEMPList_del_file := '':stored('Del_emp_list');
export EMPList_del_file  := GEMPList_del_file;

#stored ('Del_DL_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract_Grandfather));
string GDLList_del_file := '':stored('Del_DL_list');
export DLList_del_file  := GDLList_del_file;

#stored ('Del_HRA_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract_Grandfather));
string GHRAList_del_file := '':stored('Del_HRA_list');
export HRAList_del_file  := GHRAList_del_file;

#stored ('Del_dod_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract_Grandfather));
string GDODList_del_file := '':stored('Del_dod_list');
export DODList_del_file  := GDODList_del_file;

#stored ('Del_Add_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_Add_lst_Extract_Grandfather));
string GAddList_del_file := '':stored('Del_Phone_list');
export AddList_del_file  := GAddList_del_file;

#stored ('Del_phone_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract_Grandfather));
string GPhoneList_del_file := '':stored('Del_Phone_list');
export PhoneList_del_file  := GPhoneList_del_file;

#stored ('Del_Veh_list',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract_Grandfather));
string GVehList_del_file := '':stored('Del_Veh_list');
export VehList_del_file  := GVehList_del_file;

#stored ('Del_SOROffender',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract_Grandfather));
string GSOROffender_del_file := '':stored('Del_SOffender');
export SOROffender_del_file  := GSOROffender_del_file;

#stored ('Del_SOROffense',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract_Grandfather));
string GSOROffense_del_file := '':stored('Del_SOROffense');
export SOROffense_del_file  := GSOROffense_del_file;

#stored ('Del_SORVehicle',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_SORVehicle_Extract_Grandfather));
string GSORVeh_del_file := '':stored('Del_SORVehicle');
export SORVehicle_del_file  := GSORVeh_del_file;

#stored ('Del_SORAddress',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract_Grandfather));
string GSORAddr_del_file := '':stored('Del_SORAddress');
export SORAddress_del_file  := GSORAddr_del_file;

#stored ('Del_PKDelList',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract_Grandfather));
string GPKDelFile_del_file := '':stored('Del_PKDelList');
export PKDelFile_del_file  := GPKDelFile_del_file;

#stored ('Del_ProMonList',get_logical_file_name(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract_Grandfather));
string GPromonitor_del_file := '':stored('Del_ProMonList');
export Promonitor_del_file  := GPromonitor_del_file;


end; 