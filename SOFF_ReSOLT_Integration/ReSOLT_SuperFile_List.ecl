/*
**********************************************************************************
Created by    Comments
Vani 					This attribute has all the superfiles, input and out 
							
***********************************************************************************
*/	

export ReSOLT_SuperFile_List := MODULE
    SHARED varstring cluster_name := 'thor400_92';
	
    EXPORT SOFFReSOLT_Account   := '~'+cluster_name+'::in::soff_resolt::account_lookup';
	
	//Pkey List for IMAP
	EXPORT IMAP_PKey_Extract                := '~'+cluster_name+'::out::ReSOLT::IMAP_Delete_key_Extract_Delimited';
	
	EXPORT IMAP_Name_lst_Extract            := '~'+cluster_name+'::out::ReSOLT::IMAP_Name_List_Extract_Delimited';
	EXPORT IMAP_Name_lst_Extract_father     := '~'+cluster_name+'::out::ReSOLT::IMAP_Name_List_Extract_Delimited_father';
	EXPORT IMAP_Name_lst_Extract_Grandfather:= '~'+cluster_name+'::out::ReSOLT::IMAP_Name_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_Name_lst_Extract_Delete     := '~'+cluster_name+'::out::ReSOLT::IMAP_Name_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_DL_lst_Extract              := '~'+cluster_name+'::out::ReSOLT::IMAP_DL_List_Extract_Delimited';
	EXPORT IMAP_DL_lst_Extract_father       := '~'+cluster_name+'::out::ReSOLT::IMAP_DL_List_Extract_Delimited_father';
	EXPORT IMAP_DL_lst_Extract_Grandfather  := '~'+cluster_name+'::out::ReSOLT::IMAP_DL_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_DL_lst_Extract_Delete       := '~'+cluster_name+'::out::ReSOLT::IMAP_DL_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_DOB_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_DOB_List_Extract_Delimited';
	EXPORT IMAP_DOB_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_DOB_List_Extract_Delimited_father';
	EXPORT IMAP_DOB_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_DOB_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_DOB_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_DOB_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_DOD_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_DOD_List_Extract_Delimited';
	EXPORT IMAP_DOD_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_DOD_List_Extract_Delimited_father';
	EXPORT IMAP_DOD_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_DOD_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_DOD_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_DOD_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_HRA_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_HRA_List_Extract_Delimited';
	EXPORT IMAP_HRA_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_HRA_List_Extract_Delimited_father';
	EXPORT IMAP_HRA_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_HRA_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_HRA_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_HRA_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_EMP_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_EMP_List_Extract_Delimited';
	EXPORT IMAP_EMP_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_EMP_List_Extract_Delimited_father';
	EXPORT IMAP_EMP_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_EMP_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_EMP_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_EMP_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_ADD_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_ADD_List_Extract_Delimited';
	EXPORT IMAP_ADD_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_ADD_List_Extract_Delimited_father';
	EXPORT IMAP_ADD_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_ADD_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_ADD_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_ADD_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_Phone_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_Phone_List_Extract_Delimited';
	EXPORT IMAP_Phone_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_Phone_List_Extract_Delimited_father';
	EXPORT IMAP_Phone_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_Phone_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_Phone_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_Phone_List_Extract_Delimited_Delete';
	
	EXPORT IMAP_Vehicle_lst_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_Vehicle_List_Extract_Delimited';
	EXPORT IMAP_Vehicle_lst_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_Vehicle_List_Extract_Delimited_father';
	EXPORT IMAP_Vehicle_lst_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_Vehicle_List_Extract_Delimited_Grandfather';
	EXPORT IMAP_Vehicle_lst_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_Vehicle_List_Extract_Delimited_Delete';
	
    EXPORT IMAP_SOROffender_Extract_Delete     	:= '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffender_Extract_Delimited_Delete';
	EXPORT IMAP_SOROffender_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffender_Extract_Delimited_Grandfather';
	EXPORT IMAP_SOROffender_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffender_Extract_Delimited_father';
	EXPORT IMAP_SOROffender_Extract     			  := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffender_Extract_Delimited';
	
	EXPORT IMAP_SOROffense_Extract_Delete       := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffense_Extract_Delimited_Delete';
	EXPORT IMAP_SOROffense_Extract_Grandfather  := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffense_Extract_Delimited_Grandfather';
	EXPORT IMAP_SOROffense_Extract_father       := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffense_Extract_Delimited_father';
	EXPORT IMAP_SOROffense_Extract              := '~'+cluster_name+'::out::ReSOLT::IMAP_SOROffense_Extract_Delimited';
 
	EXPORT IMAP_SORAddress_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_SORAddress_Extract_Delimited_Delete';
	EXPORT IMAP_SORAddress_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_SORAddress_Extract_Delimited_Grandfather';
	EXPORT IMAP_SORAddress_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_SORAddress_Extract_Delimited_father';
	EXPORT IMAP_SORAddress_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_SORAddress_Extract_Delimited';
	
	EXPORT IMAP_SORvehicle_Extract_Delete      := '~'+cluster_name+'::out::ReSOLT::IMAP_SORvehicle_Extract_Delimited_Delete';
	EXPORT IMAP_SORvehicle_Extract_Grandfather := '~'+cluster_name+'::out::ReSOLT::IMAP_SORvehicle_Extract_Delimited_Grandfather';
	EXPORT IMAP_SORvehicle_Extract_father      := '~'+cluster_name+'::out::ReSOLT::IMAP_SORvehicle_Extract_Delimited_father';
	EXPORT IMAP_SORvehicle_Extract             := '~'+cluster_name+'::out::ReSOLT::IMAP_SORvehicle_Extract_Delimited';                        

    EXPORT IMAP_PKDelFile_Extract_Delete       := '~'+cluster_name+'::out::ReSOLT::IMAP_PKDelFile_Extract_Delimited_Delete'; 
	EXPORT IMAP_PKDelFile_Extract_Grandfather  := '~'+cluster_name+'::out::ReSOLT::IMAP_PKDelFile_Extract_Delimited_Grandfather'; 
	EXPORT IMAP_PKDelFile_Extract_father       := '~'+cluster_name+'::out::ReSOLT::IMAP_PKDelFile_Extract_Delimited_father'; 
	EXPORT IMAP_PKDelFile_Extract              := '~'+cluster_name+'::out::ReSOLT::IMAP_PKDelFile_Extract_Delimited'; 
	
	
	EXPORT IMAP_Promonitor_Extract_Delete       := '~'+cluster_name+'::out::ReSOLT::IMAP_Promonitor_Extract_Delimited_Delete'; 
	EXPORT IMAP_Promonitor_Extract_Grandfather  := '~'+cluster_name+'::out::ReSOLT::IMAP_Promonitor_Extract_Delimited_Grandfather'; 
	EXPORT IMAP_Promonitor_Extract_father       := '~'+cluster_name+'::out::ReSOLT::IMAP_Promonitor_Extract_Delimited_father'; 
	EXPORT IMAP_Promonitor_Extract              := '~'+cluster_name+'::out::ReSOLT::IMAP_Promonitor_Extract_Delimited'; 
END;


