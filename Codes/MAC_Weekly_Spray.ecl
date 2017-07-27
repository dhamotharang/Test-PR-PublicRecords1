export MAC_Weekly_Spray(sourceIP,sourceFile,filedate,recordsize='436') := macro
#workunit('name','CodesV3 spray')
#uniquename(spray_file)
#uniquename(clear_super)
#uniquename(add_super)
#uniquename(check_codes)
%spray_file% := fileservices.sprayfixed(sourceIP,sourcefile,recordsize,'thor_dell400','~thor_data400::in::codes_v3_'+filedate ,-1,,,true,true);
%clear_super% := fileservices.clearsuperfile('~thor_data400::base::codes_v3');
%add_super% := fileservices.addsuperfile('~thor_data400::base::codes_v3','~thor_data400::in::codes_v3_'+filedate);
%check_codes% := IF(EXISTS(codes.Check_Codes),
				lib_fileservices.fileservices.sendemail('mluber@seisint.com;VNiemela@seisint.com;CPlummer@seisint.com',
												'Check codes v3 updates', thorlib.WUID()),
				output('ECL codes match'));

sequential(%spray_file%,%clear_super%,%add_super%,
		 %check_codes%,output(codes.Check_Codes,NAMED('CheckCodes')),
		 codes.Proc_build_keys);
endmacro;