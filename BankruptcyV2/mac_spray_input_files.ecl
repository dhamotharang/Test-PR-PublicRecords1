import bankruptcyv2, ut;

export Mac_spray_input_files(Mainfile,Searchfile,filedate,group_name = '') := macro

#uniquename(spray_main)
#uniquename(spray_search)
#uniquename(super_main)
#uniquename(super_search)
#uniquename(super_main_full)
#uniquename(super_search_full)
#uniquename(recordlengthMain)
#uniquename(recordlengthSearch)
#uniquename(sourceIP)

%recordlengthMain% :=1103;
%recordlengthSearch% :=1853;
%sourceIP% := _control.IPAddress.edata12;

%spray_main% := FileServices.SprayFixed(%sourceIP%,Mainfile, %recordlengthMain%,group_name,'~thor_data400::in::bankruptcyv3::'+filedate+'::main' ,-1,,,true,true);
%spray_search% := FileServices.SprayFixed(%sourceIP%,searchfile,%recordlengthSearch%,group_name,'~thor_data400::in::bankruptcyv3::'+filedate+'::search' ,-1,,,true,true);

%super_main% := sequential(FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::main'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::main','~thor_data400::in::bankruptcyv3::'+filedate+'::main'),
							FileServices.FinishSuperFileTransaction());

%super_search% := sequential(FileServices.StartSuperFileTransaction(),
                            fileservices.clearsuperfile('~thor_data400::in::bankruptcyv3::search'),
							fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::search','~thor_data400::in::bankruptcyv3::'+filedate+'::search'),
							FileServices.FinishSuperFileTransaction());

// created to rerun full file incase. 

%super_main_full%   := fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::main_full','~thor_data400::in::bankruptcyv3::'+filedate+'::main');
%super_search_full% :=	fileservices.addsuperfile('~thor_data400::in::bankruptcyv3::search_full','~thor_data400::in::bankruptcyv3::'+filedate+'::search');


sequential(parallel(%spray_main%,%spray_search%),parallel(%super_main%,%super_search%,%super_main_full%,%super_search_full%)) ;
	
endmacro;	

	