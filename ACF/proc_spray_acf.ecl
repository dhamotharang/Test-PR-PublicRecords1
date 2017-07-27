import ut, _control;

export proc_spray_acf(string filedate) := function

//Spray ACF File and Compress.
spray_acf := FileServices.SprayFixed(_control.IPAddress.edata10
									,'/data_build_4/sda_sdaa_acf/acf/acf_'+filedate+'.txt'
									,350
									,'thor400_92'
									,'~thor_data400::in::acf_'+filedate,-1,,,true,true,true);


//Add Newly Sprayed file to Superfile.
add_acf := fileservices.addsuperfile('~thor_data400::in::acf','~thor_data400::in::acf_'+filedate);
								
do := sequential(spray_acf,add_acf);
return do;
end;