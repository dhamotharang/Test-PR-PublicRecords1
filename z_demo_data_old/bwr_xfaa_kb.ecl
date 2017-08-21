import demo_data_scrambler;
import faa;

#workunit('name','FAA keybuilds and superfile tx')

wuid := '20090602';
filedate:= wuid;
// also check faa.version_aircraft

s1 :=fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_reg');
s1a:=fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_reg_building');
//s1b:=fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_reg_built');
s2 :=output(demo_data_scrambler.scramble_faa_aircraft_registration,,'~thor::base::demo_data_file_faa_aircraft_registration_'+wuid+'_scrambled',overwrite);
s3 :=fileservices.addsuperfile('~thor_data400::base::faa_aircraft_reg','~thor::base::demo_data_file_faa_aircraft_registration_'+wuid+'_scrambled');
 
s4:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen');
s4a:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen_building');
s4b:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen_built');
s5:=output(demo_data_scrambler.scramble_faa_airmen_data,,'~thor::base::demo_data_file_faa_airmen_data_'+wuid+'_scrambled',overwrite);
s6:=fileservices.addsuperfile('~thor_data400::base::faa_airmen','~thor::base::demo_data_file_faa_airmen_data_'+wuid+'_scrambled');

s7:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen_certs');
s7a:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen_certs_building');
s7b:=fileservices.clearsuperfile('~thor_data400::base::faa_airmen_certs_built');
s8:=output(demo_data_scrambler.scramble_faa_airmen_certificate,,'~thor::base::demo_data_file_faa_airmen_certificate_'+wuid+'_scrambled',overwrite);
s9:=fileservices.addsuperfile('~thor_data400::base::faa_airmen_certs','~thor::base::demo_data_file_faa_airmen_certificate_'+wuid+'_scrambled');

s10 := fileservices.clearsuperfile('~thor_data400::base::faa_engine_info_in');
s10a := fileservices.clearsuperfile('~thor_data400::base::faa_engine_info_building');
//s10b := fileservices.clearsuperfile('~thor_data400::base::faa_engine_info_built');
//s11:= output(dataset([],faa.layout_engine_info),,'~thor::base::demo_data_file_faa_engine_info_null',overwrite);
// use copy from production full file below
s12 := fileservices.addsuperfile('~thor_data400::base::faa_engine_info_in','~thor_data400::in::faa_aircraft_engine_ref_20081014');

s13 := fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_info_in');
s13a := fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_info_building');
//s13b := fileservices.clearsuperfile('~thor_data400::base::faa_aircraft_info_built');
//s14:= output(dataset([],faa.layout_aircraft_info),,'~thor::base::demo_data_file_faa_aircraft_info_null',overwrite);
// use copy from production full file below
s15 := fileservices.addsuperfile('~thor_data400::base::faa_aircraft_info_in','~thor_data400::in::faa_aircraft_ref_20081014');

bk := faa.proc_build_keys(filedate);

sequential(s1,s1a,s2,s3,s4,s4a,s4b,s5,s6,s7,s7a,s7b,s8,s9,s10,s10a,s12,s13,s13a,s15,bk);
