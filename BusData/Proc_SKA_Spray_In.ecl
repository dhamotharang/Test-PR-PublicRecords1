import _control,lib_fileservices;
EXPORT Proc_SKA_Spray_In(string filedate) :=  module

sourceIP := _control.IPAddress.bctlpedata11;

Mainfile_a := '/data/prod_data_build_10/production_data/business_headers/ska/data/'+filedate+'/ska_a.'+filedate+'.d00' ;

spray_file_a := FileServices.SprayFixed(sourceIP,Mainfile_a, 327,'thor400_44','~thor_data400::in::'+filedate+'::ska_a' ,-1,,,true,true);

super_file_a := sequential(
							FileServices.ClearSuperFile('~thor_data400::in::ska::ska_a'),
							FileServices.addSuperFile('~thor_data400::in::ska::ska_a','~thor_data400::in::'+filedate+'::ska_a')
				);
				
export spray_all_a := Sequential(spray_file_a,	super_file_a);			

sourceIP := _control.IPAddress.bctlpedata11;

Mainfile_b := '/data/prod_data_build_10/production_data/business_headers/ska/data/'+filedate+'/ska_b.'+filedate+'.d00' ;

spray_file_b := FileServices.SprayFixed(sourceIP,Mainfile_b, 261,'thor400_44','~thor_data400::in::'+filedate+'::ska_b' ,-1,,,true,true);

super_file_b := sequential(
							FileServices.ClearSuperFile('~thor_data400::in::ska::ska_b'),
							FileServices.addSuperFile('~thor_data400::in::ska::ska_b','~thor_data400::in::'+filedate+'::ska_b')
				);
				
export spray_all_b := Sequential(spray_file_b,	super_file_b);			


end;
