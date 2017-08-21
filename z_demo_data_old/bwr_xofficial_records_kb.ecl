import official_records,demo_data_scrambler;

#workunit('name','Official Records keybuilds and superfile tx')

wuid := '20090317c';
// set official_records.version_development;
filedate:= wuid;

s1:= fileservices.clearsuperfile('~thor_200::base::official_records_document');
s2:= output(demo_data_scrambler.scramble_official_documents,,'~thor::base::demo_data_file_official_documents'+wuid+'_scrambled',overwrite);
s3:= fileservices.addsuperfile('~thor_200::base::official_records_document','~thor::base::demo_data_file_official_documents'+wuid+'_scrambled');

s4:= fileservices.clearsuperfile('~thor_200::base::official_records_party');
s5:= output(demo_data_scrambler.scramble_official_party,,'~thor::base::demo_data_file_official_party'+wuid+'_scrambled',overwrite);
s6:= fileservices.addsuperfile('~thor_200::base::official_records_party','~thor::base::demo_data_file_official_party'+wuid+'_scrambled');

out_keys := 	official_records.Out_Keys;
auto_keys :=  	official_records.Proc_Build_Autokey;


sequential(s1,s2,s3,s4,s5,s6,out_keys,auto_keys);





