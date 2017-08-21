import vehiclev2;
 
 
#workunit('name','Vehicle V2 keybuilds and superfile tx')

wuid := '20090708';
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_data400::base::vehiclev2::main');
s2:= output(demo_data_scrambler.scramble_vehiclev2_main,,'~thor::base::demo_data_file_vehiclev2_main'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_data400::base::vehiclev2::main','~thor::base::demo_data_file_vehiclev2_main'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_data400::base::vehiclev2::party');
s5:= output(demo_data_scrambler.scramble_vehiclev2_party,,'~thor::base::demo_data_file_vehiclev2_party'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_data400::base::vehiclev2::party','~thor::base::demo_data_file_vehiclev2_party'+wuid+'_scrambled');


proc_Build_Keys				:= VehicleV2.Proc_build_vehicle_key(filedate);
Proc_build_boolean_keys    	:= VehicleV2.Proc_Build_Boolean_Keys(filedate);

sequential(s1,s2,s3,s4,s5,s6,proc_build_keys,proc_build_boolean_keys);
