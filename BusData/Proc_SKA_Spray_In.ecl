import _control, lib_fileservices, std;
EXPORT Proc_SKA_Spray_In(string filedate) :=  module

sourceIP := _control.IPAddress.bctlpedata11;

month := IF(filedate[5] = '0', filedate[6], filedate[5..6]);
day := IF(filedate[7] = '0', filedate[8], filedate[7..8]);
year := filedate[1..4];
filedate_name := month + '-' + day + '-' + year;

groupname := std.system.Thorlib.group();

Mainfile_a := '/data/prod_data_build_10/production_data/business_headers/ska/data/' + filedate + '/om370133a_' + filedate_name + '_final_Final.txt' ;

spray_file_a := FileServices.SprayVariable(sourceIP, Mainfile_a, 1024, , , , groupname, '~thor_data400::in::' + filedate + '::ska_a', -1, , , true, , true);

super_file_a := sequential(
							FileServices.ClearSuperFile('~thor_data400::in::ska::ska_a'),
							FileServices.addSuperFile('~thor_data400::in::ska::ska_a','~thor_data400::in::'+filedate+'::ska_a')
				);
				
export spray_all_a := Sequential(spray_file_a,	super_file_a);			

sourceIP := _control.IPAddress.bctlpedata11;

month := IF(filedate[5] = '0', filedate[6], filedate[5..6]);
day := IF(filedate[7] = '0', filedate[8], filedate[7..8]);
year := filedate[1..4];
filedate_name := month + '-' + day + '-' + year;

groupname := std.system.Thorlib.group();

Mainfile_b := '/data/prod_data_build_10/production_data/business_headers/ska/data/' + filedate + '/om370133b_' + filedate_name + '_final_Final.txt' ;

spray_file_b := FileServices.SprayVariable(sourceIP, Mainfile_b, 512, , , , groupname, '~thor_data400::in::' + filedate + '::ska_b', -1, , , true, , true);

super_file_b := sequential(
							FileServices.ClearSuperFile('~thor_data400::in::ska::ska_b'),
							FileServices.addSuperFile('~thor_data400::in::ska::ska_b','~thor_data400::in::'+filedate+'::ska_b')
				);
				
export spray_all_b := Sequential(spray_file_b,	super_file_b);			


end;
