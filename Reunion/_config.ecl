import std;


export _config := MODULE


shared date_file_name := '~thor_data400::mylife:dates';

//Get version values

EXPORT get_sVersion          := dataset(date_file_name,{STRING9 sversion},thor)[1].sversion;


EXPORT set_v_version(STRING9 sversion) := sequential(  
                                     output(dataset([{sversion}],{STRING9 sversion:=''}),,date_file_name+'_'+workunit),
                                     std.file.startsuperfiletransaction(),
                                     std.file.createsuperfile(date_file_name,,true),
                                     std.file.clearsuperfile(date_file_name,true),
                                     std.file.addsuperfile(date_file_name,date_file_name+'_'+workunit),
                                     std.file.finishsuperfiletransaction()
																		 );
end;