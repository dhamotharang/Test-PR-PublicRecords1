import lib_fileservices,_control,lib_stringlib;

export SprayFiles := module

	export Create_Spray_Superfiles(string st)	:=	function
	
		// Creates an empty superfile; The false optional parameter indicates whether the sub-files 
    // must be sequentiallynumbered; The last optional parameter is missing and defaults to false
		// indicating that an error is posted if the superfile already exists.
		
		CreateSuper								:=	FileServices.CreateSuperFile(Filenames(st,).Input.Sprayed,false);
		
			//Checks the existence of the superfile; if the superfile doesn't exist it CreateSuper is called
			//(see above).
									
		CreateSuperfileIfNotExist := 	if(NOT FileServices.SuperFileExists(Filenames(st,).Input.Sprayed),CreateSuper);
		
		return CreateSuperfileIfNotExist;		
	end; //end Create_Spray_Superfiles

	export Spray_Raw_Data(string st,string filedate)	:=	function

		do_spray := if(count(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/SIM/LaborActions_MSHA/'+filedate[1..8]+'/','msha_'+st+'.txt')(size>0)) > 0
							,FileServices.SprayVariable(_control.IPAddress.bctlpedata11
							,'/data/hds_180/SIM/LaborActions_MSHA/'+filedate[1..8]+'/msha_'+st+'.txt'
							,
							,'|'
							,'\\n,\\r\\n'     
							,'[\'\']'
							,'thor400_44'
							,'~thor_data400::in::'+_Dataset().name+'::'+filedate+'::'+st
							,-1
							,
							,
							,true
							,false)
		);
		return do_spray;
	end; //end Spray_Raw_Data

	export Add_to_Superfiles(string st,string filedate)	:=	function

		addSuper									:=	if (count(FileServices.RemoteDirectory(_control.IPAddress.bctlpedata11,'/data/hds_180/SIM/LaborActions_MSHA/'+filedate[1..8]+'/','msha_'+st+'.txt')(size>0)) >0
																					 ,FileServices.AddSuperFile(Filenames(st,).Input.Sprayed
																					 ,cluster+'in::'+_Dataset().name+'::'+filedate+'::'+st)
																			);
		return addSuper;
	end;	//end Add_to_Superfiles
										 
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///// Spray all msha files sequentially 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	export fSprayFiles(string filedate)	:=	function

		all_msha_spray := sequential(
															 Create_Spray_Superfiles('accident')
															,Create_Spray_Superfiles('contractor')
															,Create_Spray_Superfiles('contractor_cy_employment')
															,Create_Spray_Superfiles('contractor_qt_employment')
															,Create_Spray_Superfiles('controller_hist')
															,Create_Spray_Superfiles('inspection')
															,Create_Spray_Superfiles('mine')
															,Create_Spray_Superfiles('operator_cy_employment')
															,Create_Spray_Superfiles('operator_hist')
															,Create_Spray_Superfiles('operator_qt_employment')
															,Create_Spray_Superfiles('violation')
														  ,Spray_Raw_Data('accident',filedate)
															,Spray_Raw_Data('contractor',filedate)
															,Spray_Raw_Data('contractor_cy_employment',filedate)
															,Spray_Raw_Data('contractor_qt_employment',filedate)
															,Spray_Raw_Data('controller_hist',filedate)																	
															,Spray_Raw_Data('inspection',filedate)
															,Spray_Raw_Data('mine',filedate)
															,Spray_Raw_Data('operator_cy_employment',filedate)
															,Spray_Raw_Data('operator_hist',filedate)
															,Spray_Raw_Data('operator_qt_employment',filedate)
															,Spray_Raw_Data('violation',filedate)																	
															,Add_To_Superfiles('accident',filedate)
															,Add_To_Superfiles('contractor',filedate)
															,Add_To_Superfiles('contractor_cy_employment',filedate)
															,Add_To_Superfiles('contractor_qt_employment',filedate)
															,Add_To_Superfiles('controller_hist',filedate)																	
															,Add_To_Superfiles('inspection',filedate)
															,Add_To_Superfiles('mine',filedate)
															,Add_To_Superfiles('operator_cy_employment',filedate)
															,Add_To_Superfiles('operator_hist',filedate)
															,Add_To_Superfiles('operator_qt_employment',filedate)
															,Add_To_Superfiles('violation',filedate)
															);
																
		return all_msha_spray;
	end; //end fSprayFiles

end;  //end SprayFiles
