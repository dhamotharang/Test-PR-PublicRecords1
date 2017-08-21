import demo_data_scrambler;
import property;

// clean fields are all scrambled, standalone search is moxie, will need to review all orig fields when displayed in app.

#workunit('name','Foreclosure keybuilds and superfile tx')

wuid := '20090410';
filedate:= wuid;

s1 := fileservices.clearsuperfile('~thor_data400::base::foreclosure');
s2 := output(demo_data_scrambler.scramble_foreclosure1,,'~thor::base::demo_data_file_foreclosure'+wuid+'_scrambled',overwrite);
s3 := fileservices.addsuperfile('~thor_data400::base::foreclosure','~thor::base::demo_data_file_foreclosure'+wuid+'_scrambled');

s4:= Property.proc_build_forclosure_key(filedate);


sequential(s1,s2,s3,s4);
