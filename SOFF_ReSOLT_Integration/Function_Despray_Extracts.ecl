IMPORT address, lib_fileservices, _control;

EXPORT Function_Despray_Extracts(string pdate) := FUNCTION

    lTargetDirectory  :=    '/hds_3/imap/';
    lTargetIP                           :=    _control.IPAddress.edata12;

    // MACDespray(pSuperFileName) :=  macro

                        // if(lib_FileServices.FileServices.GetSuperFileSubCount(pSuperFileName) <> 0,

                               // lib_FileServices.FileServices.Despray(pSuperFileName,
   							   // lTargetIP,
                               // lTargetDirectory + regexfind('[^:]+$',trim(pSuperFileName),0) + '.csv',
                               // ,
                               // ,
                               // ,
                               // true),
                               // output('SuperFile "' + pSuperFileName + '" appears to be empty.  No despray')
                           // );

    // endmacro;
		
    fDespray(string pSuperFileName) := function

        return if(lib_FileServices.FileServices.GetSuperFileSubCount(pSuperFileName) <> 0,

                  lib_FileServices.FileServices.Despray(pSuperFileName,
                                                        lTargetIP,
                                                        lTargetDirectory + stringlib.stringfindreplace(stringlib.stringfindreplace(regexfind('[^:]+$',trim(pSuperFileName),0),'IMAP_Promonitor_Extract_Delimited','REP_iMap_Promonitor_'),'IMAP','iMap') + pdate+'.csv',
                                                        ,,,  // Timeout, ESP, MaxConnections
                                                        true
                                                        ),


                  output('SuperFile "' + pSuperFileName + '" appears to be empty.  No despray')

                 );
    end;

     return sequential(parallel(fDespray(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_ADD_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract),

                               fDespray(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract) ),

																output('Files desprayed.') 
                     );

    // MACDespray(ReSOLT_SuperFile_List.IMAP_Name_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_DL_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_ADD_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_SOROffender_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_SOROffense_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_SORAddress_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract);
    // MACDespray(ReSOLT_SuperFile_List.IMAP_Promonitor_Extract);
    // return      output('Files desprayed.');

    end ;


//-----------------------

// Destination_IP := _control.IPAddress.edata12;
// Name_extract := ReSOLT_SuperFile_List.IMAP_Name_lst_Extract;
// DL_extract   := ReSOLT_SuperFile_List.IMAP_DL_lst_Extract;
// DOB_extract  := ReSOLT_SuperFile_List.IMAP_DOB_lst_Extract;
// DOD_extract  := ReSOLT_SuperFile_List.IMAP_DOD_lst_Extract;
// HRA_extract  := ReSOLT_SuperFile_List.IMAP_HRA_lst_Extract;
// emp_extract  := ReSOLT_SuperFile_List.IMAP_EMP_lst_Extract;
// add_extract  := ReSOLT_SuperFile_List.IMAP_ADD_lst_Extract;
// phone_extract:= ReSOLT_SuperFile_List.IMAP_Phone_lst_Extract;
// vehicle_extract  := ReSOLT_SuperFile_List.IMAP_Vehicle_lst_Extract;
// SOROfndr_extract := ReSOLT_SuperFile_List.IMAP_SOROffender_Extract;
// SOROff_extract   := ReSOLT_SuperFile_List.IMAP_SOROffense_Extract;
// SORAdd_extract   := ReSOLT_SuperFile_List.IMAP_SORAddress_Extract;
// SORVeh_extract   := ReSOLT_SuperFile_List.IMAP_SORvehicle_Extract;
// DelFile_extract  := ReSOLT_SuperFile_List.IMAP_PKDelFile_Extract;
// Promonitor_extract := ReSOLT_SuperFile_List.IMAP_Promonitor_Extract;


// Despray_Name_Extract :=FileServices.DeSpray
   // (Name_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+Name_extract[stringlib.stringfind(Name_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_DL_Extract :=FileServices.DeSpray
   // (DL_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+DL_extract[stringlib.stringfind(DL_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_DOB_Extract :=FileServices.DeSpray
   // (DOB_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+DOB_extract[stringlib.stringfind(DOB_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_DOD_Extract :=FileServices.DeSpray
   // (DOD_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+DOD_extract[stringlib.stringfind(DOD_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_HRA_Extract :=FileServices.DeSpray
   // (HRA_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+HRA_extract[stringlib.stringfind(HRA_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_EMP_Extract :=FileServices.DeSpray
   // (EMP_extract,//logicalname
    // Destination_IP,//desination IP
    // TRemoteLoc+EMP_extract[stringlib.stringfind(EMP_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );
	
// Despray_ADD_Extract :=FileServices.DeSpray
   // (Add_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+Add_extract[stringlib.stringfind(Add_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_Phone_Extract :=FileServices.DeSpray
   // (Phone_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+Phone_extract[stringlib.stringfind(Phone_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_Vehicle_Extract :=FileServices.DeSpray
   // (Vehicle_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+Vehicle_extract[stringlib.stringfind(Vehicle_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_SOROfndr_Extract :=FileServices.DeSpray
   // (SOROfndr_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+SOROfndr_extract[stringlib.stringfind(SOROfndr_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_SOROff_Extract :=FileServices.DeSpray
   // (SOROff_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+SOROff_extract[stringlib.stringfind(SOROff_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_SORAdd_Extract :=FileServices.DeSpray
   // (SORAdd_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+SORAdd_extract[stringlib.stringfind(SORAdd_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_SORVeh_Extract :=FileServices.DeSpray
   // (SORVeh_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+SORveh_extract[stringlib.stringfind(SORveh_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );		

// Despray_Del_Extract :=FileServices.DeSpray
   // (DelFile_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+DelFile_extract[stringlib.stringfind(DelFile_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
	
// Despray_Promonitor_Extract :=FileServices.DeSpray
   // (Promonitor_extract,//logicalname
    // Destination_IP,//desination IP
	// TRemoteLoc+Promonitor_extract[stringlib.stringfind(Promonitor_extract,'::',3)+2..]+'.csv', //destinationpath
	// -1,// timeout
	// ,//espserver IP Port
	// 1,//Max connections
	// true// OVERWRITE
	// );	
// despray_all:= sequential
               // (parallel( 	Despray_Name_Extract,//good
							// Despray_DL_Extract,//good
							// Despray_DOB_Extract,//good
							// Despray_DOD_Extract,//good
						    // Despray_SOROfndr_Extract, 
							// Despray_SOROff_Extract,
							// Despray_SORAdd_Extract,
							// Despray_SORVeh_Extract,
							// Despray_HRA_Extract,  //good
							// Despray_EMP_Extract,//good
							// Despray_ADD_Extract,//good
							// Despray_Phone_Extract,//good
							// Despray_Vehicle_Extract,//good
							//Despray_Promonitor_Extract,
							// Despray_Del_Extract),
							 // output('files desprayed')
							 // );

// do_it := despray_all;

//return do_it;

//end;