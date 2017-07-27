import ut, _control;

export proc_spray_sda_sdaa(string filedate) := function

//Spray SDA File and Compress.
spray_sda := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/data_build_4/sda_sdaa_acf/sda/sda_'+filedate+'.txt'
									,350
									,'thor400_92'
									,'~thor_data400::in::sda_'+filedate,-1,,,true,true,true);


//Add Newly Sprayed SDA file to Superfile.
add_sda := fileservices.addsuperfile('~thor_data400::in::sda','~thor_data400::in::sda_'+filedate);

//Spray SDAA File and Compress.
spray_sdaa := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/data_build_4/sda_sdaa_acf/sdaa/sdaa_'+filedate+'.txt'
									,350
									,'thor400_92'
									,'~thor_data400::in::sdaa_'+filedate,-1,,,true,true,true);

//Add Newly Sprayed SDAA file to Superfile.
add_sdaa := fileservices.addsuperfile('~thor_data400::in::sdaa','~thor_data400::in::sdaa_'+filedate);

do := sequential(parallel(spray_sda,spray_sdaa)
						,parallel(add_sda, add_sdaa));
						
return do;
end;