import Corp2;

//*********************************************************************************
//*** Macro to spray the (TXBUS) Texas Franchise tax file to thor and added it 
//*** super file. The file is used to mark the current standing status information
//*** for the TX corp records.
//*** USAGE :-
//*** Corp2.Mac_Corp2_Txbus_Spray
//*** (
//***	'edata12.br.seisint.com',   //Edata12
//***	'/data_build_1/Corp2/',     //File Path
//***	'20070607',                 //File date
//***	'TX_20070607_FTACT.txt',    //File name
//***	'thor_dataland_linux'       //Group name
//*** )
//**********************************************************************************
export Mac_Corp2_Txbus_Spray(source_IP,source_path,filedate,file_name,group_name) := 
macro
#uniquename(spray_main)
#uniquename(super_main)
#uniquename(raw_delete)
#uniquename(deleteIfExist)
#uniquename(doCleanup)
#uniquename(recSize)
#uniquename(CreateSuperfiles)
#uniquename(CreateSuperIfNotExist)
#uniquename(do_super)


#workunit('name','Corp2 Txbus Spray ' + filedate);

//TEXAS Franchise tax file record length
%recSize% := 217;

%CreateSuperfiles% := sequential(FileServices.CreateSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile',false),
								 FileServices.CreateSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Delete',false),
  							     FileServices.CreateSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Old',false)																	
								);
%CreateSuperIfNotExist% := if (~FileServices.SuperFileExists(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile'),%CreateSuperfiles%); 
			

%doCleanup% := sequential(FileServices.RemoveSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Old',
                                                        Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'),
						   FileServices.RemoveSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Delete',
														Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'),
						   FileServices.RemoveSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile',
														Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'),
						   FileServices.DeleteLogicalFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'));

%deleteIfExist% := if(FileServices.FileExists(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'),
					  %doCleanup%);

%spray_main% := FileServices.SprayFixed(Source_IP,source_path + file_name,%recSize%,group_name,Corp2.Cluster.Cluster_In +'in::Corp2::txbus_ftact::'+ filedate +'::vendor',-1,,,true,true);

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Delete',
				                          Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Old',, true),
				FileServices.ClearSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Old'),
				FileServices.AddSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Old', 
				                          Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile',, true),
				FileServices.ClearSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile'),
				FileServices.AddSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Superfile', 
				                          Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::'+filedate+'::vendor'), 
				FileServices.FinishSuperFileTransaction(),
				FileServices.ClearSuperFile(Corp2.Cluster.Cluster_In + 'in::Corp2::txbus_ftact::Delete',true));


%do_super%  := sequential(output('do super ...'),%CreateSuperIfNotExist%, %deleteIfExist%, %spray_main%, %super_main%);

sequential(%do_super%);

endmacro;