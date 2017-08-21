
import doxie;
import phonesplus;

filedate:='20081103';

s1:= fileservices.clearsuperfile('~thor_data400::base::headerkey_building');
s2:= fileservices.addsuperfile('~thor_data400::Base::HeaderKey_Building','~thor_data400::Base::Header_prod',,true);
s3:= phonesplus.proc_build_PersonHeaderLookupKey(filedate);

//output(doxie.Lookups);
//output(doxie.lookups_v2);

sequential(s1,s2,s3);


