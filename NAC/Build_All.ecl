import ut, VersionControl,lib_stringlib,lib_fileservices,_control,did_add,_validate, address, NID, header, PromoteSupers;

export Build_All(string version,string ip,string rootDir) := function

move_temp_in:=	sequential(
							FileServices.StartSuperFileTransaction()
							,FileServices.AddSuperFile('~nac::in::consortium','~nac::in::al::temp',,true)
							,FileServices.AddSuperFile('~nac::in::consortium','~nac::in::fl::temp',,true)
							,FileServices.AddSuperFile('~nac::in::consortium','~nac::in::ga::temp',,true)
							,FileServices.AddSuperFile('~nac::in::consortium','~nac::in::la::temp',,true)
							,FileServices.AddSuperFile('~nac::in::consortium','~nac::in::ms::temp',,true)
							,FileServices.ClearSuperFile('~nac::in::al::temp')
							,FileServices.ClearSuperFile('~nac::in::fl::temp')
							,FileServices.ClearSuperFile('~nac::in::ga::temp')
							,FileServices.ClearSuperFile('~nac::in::la::temp')
							,FileServices.ClearSuperFile('~nac::in::ms::temp')
							,FileServices.FinishSuperFileTransaction()
							);

ProdVer:=did_add.get_EnvVariable('header_build_version')[1..8];
flag:=dataset(Superfile_List().Flag,{string8 Prod_Ver},flat,opt);

NewHeader := if(nothor(fileservices.fileExists(Superfile_List().Flag)),ProdVer <> flag[1].Prod_Ver,true);
PromoteSupers.MAC_SF_BuildProcess(Build_base(version),Superfile_List().Base, BuildBase ,3 ,,true,pVersion:=version);

NewVer:=dataset([{ProdVer}],{string8 Prod_Ver});
PromoteSupers.Mac_SF_BuildProcess(NewVer,Superfile_List().Flag, PostIt ,2,,true,pVersion:=version);

BP:=NAC.Files().Load_in
		(Case_State_Abbreviation=''
		or Case_Benefit_Type=''
		or Case_Benefit_Month=''
		or Case_Identifier=''
		or Case_Last_Name=''
		or Case_First_Name=''
		or Client_Identifier=''
		or Client_Last_Name=''
		or Client_First_Name=''
		);

ByPassedRecords
		:=if(count(BP)>0
					,sequential(
							output(BP,,'~nac::out::bypassed_records_'+version,compressed)
							,FileServices.AddSuperFile('~nac::out::bypassed_records_history','~nac::out::bypassed_records_'+version)
							));

Build_NAC:=if(NewHeader
								,sequential(
											output('New Header in Prod.  Full File Will ADL',named('NewHeader_true'))
											,BuildBase, PostIt)
								,sequential(
											output('No New Header in Prod.  Only New Data Will ADL',named('NewHeader_false'))
											,BuildBase)
								);

clear_consortium := sequential(
							 FileServices.StartSuperFileTransaction()
							,FileServices.AddSuperFile('~nac::in::consortium_history','~nac::in::consortium',,true)
							,FileServices.ClearSuperFile('~nac::in::consortium')
							,FileServices.FinishSuperFileTransaction()
							);

buildIt := sequential(
									Move_temp_in
									,ByPassedRecords
									,Build_NAC
									,NAC.Mod_despray(version,ip,rootDir).Odespray
									,clear_consortium
									);

return buildIt;

end;