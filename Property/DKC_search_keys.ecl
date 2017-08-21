import lib_fileservices;

#workunit('name','DKC Property Search Keys');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

DestinationIP := '172.16.68.91';
DestinationVolume := '/fares_15/';

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,DestinationIP,DestinationVolume+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

key1 := DKCKeys('~thor_data400::key::moxie.fares.st.nameasis.key','fares_search.st.nameasis.key');
key2 := DKCKeys('~thor_data400::key::moxie.fares.did.key','fares_search.did.key');
key3 := DKCKeys('~thor_data400::key::moxie.fares.bdid.key','fares_search.bdid.key');
key4 := DKCKeys('~thor_data400::key::moxie.fares.fid.key','fares_search.fid.key');
key5 := DKCKeys('~thor_data400::key::moxie.fares.cn.fid.key','fares_search.cn.fid.key');
key6 := DKCKeys('~thor_data400::key::moxie.fares.nameasis.key','fares_search.nameasis.key');
key7 := DKCKeys('~thor_data400::key::moxie.fares.st.cn.fid.key','fares_search.st.cn.fid.key');
key8 := DKCKeys('~thor_data400::key::moxie.fares.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fares_id.source_code.lfmname.key','fares_search.z5.street_name.predir.postdir.prim_range.suffix.lname.sec_range.fares_id.source_code.lfmname.key');
key9 := DKCKeys('~thor_data400::key::moxie.fares.lfmname.key','fares_search.lfmname.key');
key10 := DKCKeys('~thor_data400::key::moxie.fares.st.lfmname.key','fares_search.st.lfmname.key');
key11 := DKCKeys('~thor_data400::key::moxie.fares.z5.lfmname.key','fares_search.z5.lfmname.key');
key12 := DKCKeys('~thor_data400::key::moxie.fares.z5.prim_name.prim_range.lfmname.key','fares_search.z5.prim_name.prim_range.lfmname.key');
key13 := DKCKeys('~thor_data400::key::moxie.fares.st.city.nameasis.key','fares_search.st.city.nameasis.key');
key14 := DKCKeys('~thor_data400::key::moxie.fares.st.city.cn.fid.key','fares_search.st.city.cn.fid.key');
key15 := DKCKeys('~thor_data400::key::moxie.fares.st.city.lfmname.key','fares_search.st.city.lfmname.key');
key16 := DKCKeys('~thor_data400::key::moxie.fares_search.fpos.data.key','fares_search.fpos.data.key');
key17 := DKCKeys('~thor_dell400_2::key::moxie.fares.process_date.lfmname.key','fares_search.process_date.lfmname.key');

export DKC_search_keys := parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,
											 key10,key11,key12,key13,key14,key15,key16,key17);