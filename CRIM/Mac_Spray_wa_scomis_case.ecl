export Mac_Spray_wa_scomis_case(source_machine,sourcefile_with_path,filedate,recordsize) := 
macro



#uniquename(file_case)
#uniquename(add_date)
#uniquename(spray_it)
#uniquename(build_it)
#uniquename(filepath)
// spray the file
//(sourceIP,sourcefile,filedate,recordsize,ftype,jobname,gname,filename,fullname,fsep) 

%filepath% := '~thor_data400::in::crim_court::'+filedate+'::wa_scomis_case';


%spray_it% := FileServices.SprayFixed(_Control.IPAddress.edata12,
			sourcefile_with_path,
			recordsize,
			'thor_200',
			%filepath%,-1,,,true,true);


// append the file date
%file_case% := dataset('~thor_data400::in::crim_court::'+filedate+'::wa_scomis_case',
							CRIM.Layout_WA_Scomis.layout_case,thor);

// write this file somewhere
%build_it% := output(%file_case%,,'~thor_data400::in::crim_court::wa_scomis_case_'+filedate,overwrite);

// superfile shuffle
sequential
(
					
%spray_it%,
%build_it%,
Fileservices.AddSuperFile('~thor_data400::in::crim_court::wa_scomis_case_superfile',
							'~thor_data400::in::crim_court::wa_scomis_case_'+filedate)
)

endmacro;