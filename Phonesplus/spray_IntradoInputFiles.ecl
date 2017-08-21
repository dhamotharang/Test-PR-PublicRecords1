export spray_IntradoInputFiles(string filename) := 
function
												
a := fileservices.SprayVariable('edata12.br.seisint.com',
                        '/hds_2/phonesplus/sources/intrado/'+ Phonesplus.version + '/' + filename,
						,                  					
                        '',              					
						'\n', '~~~~'
						,              					    
                        'thor400_30',    					
                        '~thor_data400::in::intrado::' + filename[14..21] + '::'+filename,    
                        ,
                        ,
                        ,
                        true,             
                        true,             
                        false             
                   );   

b:= if(filename[23..25] = 'EXB',
		fileservices.AddSuperFile('~thor_data400::in::intrado_exb','~thor_data400::in::intrado::' + filename[14..21] + '::'+ filename,,false,false),
		fileservices.AddSuperFile('~thor_data400::in::intrado_exr','~thor_data400::in::intrado::' + filename[14..21] + '::'+ filename,,false,false)
		
		);


return sequential(a,b); 
end;
