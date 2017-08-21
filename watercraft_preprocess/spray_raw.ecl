import lib_fileservices,lib_stringlib,_Control;

export spray_raw(string qt,string infile,string st) := function
groupname := 'thor400_92';

 st_clean := StringLib.StringToLowerCase(st);
spray_data := fileservices.SprayVariable(_Control.IPAddress.bctlpedata11
                                        ,'/data/super_credit/watercraft/infolink/'+qt+'/'+infile
										,
										,''
										,'\n'
										,'~~~'
										,groupname
										,'~thor_data::in::watercraft_raw_'+st_clean+'_'+qt
										,
										,
										,
										,true
										,true
										,false
										);
										
check_file := if(count('~thor_data::in::watercraft_raw_'+st_clean) > 0,FileServices.ClearSuperfile('~thor_data::in::watercraft_raw_'+st_clean),output('Superfile_is_Empty'));


add_file := sequential(
              FileServices.StartSuperFileTransaction(),
							//check_file,
              FileServices.AddSuperfile('~thor_data::in::watercraft_raw_'+st_clean,'~thor_data::in::watercraft_raw_'+st_clean+'_'+qt),
							FileServices.FinishSuperfiletransaction());
							
							
return sequential(spray_data,add_file);
end;
