import infutor,_control,std;


export _config := MODULE


shared date_file_name := '~thor_data400::trackeraddress:dates';

//Get version values

EXPORT get_prior_cversion    := dataset(date_file_name,{STRING9 pversion,STRING9 cversion_dev},thor)[1].cversion_dev;
EXPORT get_pversion          := dataset(date_file_name,{STRING9 pversion,STRING9 cversion_dev},thor)[1].pversion; 
EXPORT get_cversion_dev      := dataset(date_file_name,{STRING9 pversion,STRING9 cversion_dev},thor)[1].cversion_dev;



shared OldFileDate := get_prior_cversion;

shared pversion := get_prior_cversion; 


EXPORT set_v_version(STRING9 cversion_dev) := sequential(                 
                                     output(dataset([{OldFileDate,cversion_dev}],{STRING9 pversion:='',STRING9 cversion_dev:=''}),,date_file_name+'_'+workunit),
                                     std.file.startsuperfiletransaction(),
                                     std.file.createsuperfile(date_file_name,,true),
                                     std.file.clearsuperfile(date_file_name,true),
                                     std.file.addsuperfile(date_file_name,date_file_name+'_'+workunit),
                                     std.file.finishsuperfiletransaction()
																		); 
																		
                                
																 
    
END;
