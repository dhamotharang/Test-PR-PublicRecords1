export MAC_Phone_Spray(sourceIP,sourceFile,filedate,recordsize='38') := macro
#workunit('name','Phone Suppress Spray')
#uniquename(spray_file)
#uniquename(clear_super)
#uniquename(move2father)
#uniquename(add_super)

%spray_file% := fileservices.sprayfixed(sourceIP,sourcefile,recordsize,'thor_dell400','~thor_data400::in::blackphonelist_'+filedate ,-1,,,true,true);
%move2father% := fileservices.AddSuperFile('~thor_data400::in::blackphonelist_Father','~thor_data400::in::blackphonelist',,true);
%clear_super% := fileservices.clearsuperfile('~thor_data400::in::blackphonelist');
%add_super% := fileservices.addsuperfile('~thor_data400::in::blackphonelist','~thor_data400::in::blackphonelist_'+filedate);
sequential(%spray_file%,%move2father%,%clear_super%,%add_super%,suppress.proc_build_keys);
endmacro;