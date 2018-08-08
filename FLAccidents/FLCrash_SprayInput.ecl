#workunit('name', 'FLAccident Spray Input')
//use to spray files to land. If the destination is prod, the 4th parameter of 
//the fileservices.sprayfixed function should be 'thor_data400'

// Fix the directory path and version number before running


/*
SprayFixed(const varstring sourceIP
          ,const varstring sourcePath
		  ,integer4 recordSize
		  ,const varstring destinationGroup
		  ,const varstring destinationLogicalName); 
*/


import	FLAccidents_ECrash,flaccidents,_control,VersionControl,ut;
		//move raw
export FLCrash_SprayInput( string		filedate,
	 boolean	pIsTesting	= false
	,string		pServer			= if ( _Control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12 ,  _control.IPAddress.bctlpedata11 )
	,string		pDir				= '/data/super_credit/flcrash/new_data/build'
	,string		pGroupName	= thorlib.group() 

) :=
function

 flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLAccidents',move_raw);


 flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash0',move_0);

    //move flcrash1_accident_char
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash1',move_1);

    //move flcrash2_vehicle    
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash2v',move_2);

    //move flcrash3_towed_trailer_veh  
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash3v',move_3);

    //move flcrash4_driver
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash4',move_4);

    //move flcrash5_passenger  
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash5',move_5);

    //move flcrash6_pedestrian
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash6',move_6);

    //move flcrash7_property
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::FLCrash7',move_7);

		//move flcrash8_carrier
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash8',move_8);
		
		//move flcrash9_witness
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrash9',move_9);

		//move flcrashs
		flaccidents.mac_flcrash_sprayinput('~thor_data400::in::flcrashs',move_10);




	lfile(string pkeyword) := '~thor_data400::in::flaccidents_' + pkeyword + filedate;
	sfile(string skeyword) := '~thor_data400::sprayed::' + skeyword;

	spry_raw:=DATASET([

		 {pServer,pDir,'Violation*.csv' 			,0 ,lfile('dot'				      ),[{sfile('flcrash0'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Event*.csv' 		,0 ,lfile('event'			      ),[{sfile('flcrash1'	    )}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Vehicle*.csv' 			,0 ,lfile('vehicle'				  ),[{sfile('flcrash2v'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Trailer*.csv' 			,0 ,lfile('trailer'				  ),[{sfile('flcrash3v'			)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Driver*.csv' 			  ,0 ,lfile('driver'					),[{sfile('flcrash4'				)}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Passenger*.csv' 			  ,0 ,lfile('passenger'				  ),[{sfile('flcrash5'			  )}],pGroupName,'','[0-9]{12}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'NonMotorist*.csv' 			  ,0 ,lfile('pedestrian'				  ),[{sfile('flcrash6'			  )}],pGroupName,'','[0-9]{8}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Property*.csv' 			    ,0 ,lfile('property'				    ),[{sfile('flcrash7'			    )}],pGroupName,'','[0-9]{8}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'MotorCarrier*.csv' 			  ,0 ,lfile('comveh'				    ),[{sfile('flcrash8'			    )}],pGroupName,'','[0-9]{8}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}
		,{pServer,pDir,'Witness*.csv' 			  ,0 ,lfile('witness'				    ),[{sfile('flcrash9'			    )}],pGroupName,'','[0-9]{8}','VARIABLE','',8192,'\\,','\\n,\\r\\n','"',false}

		
		 	], VersionControl.Layout_Sprays.Info);
			
   	
	
	Spray_all := VersionControl.fSprayInputFiles(spry_raw,pReplicate := false,pIsTesting := pIsTesting);
	add_super := fileServices.AddSuperFile(	'~thor_data400::sprayed::flcrash3v'
												                ,'~thor_data400::sprayed::flcrash2v',,true
												);
	
	return sequential(move_raw
											
											,move_0
											,move_1
											,move_2
											,move_3
											,move_4
											,move_5
											,move_6
											,move_7
											,move_8
											,move_9
											,move_10,FLAccidents.clear_super,Spray_all/*,add_super*/);
end; 