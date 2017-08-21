import lib_fileservices;

//#workunit('name','Despray DKC DNB');

//edata10=10.150.13.201
//edata12=10.150.12.240
//edata13=192.168.0.71
//edata14=172.16.68.91

export Despray_DKC_DNB(string pDestinationIP, string pDestinationVolume) :=
function

DKCKeys(string SourceKeyName,string DestKeyName)
 :=
  if(lib_fileservices.fileservices.FileExists(SourceKeyName),
	 lib_fileservices.FileServices.DKC(SourceKeyName,pDestinationIP,pDestinationVolume+DestKeyName,,,,TRUE),
	 output(SourceKeyName + ' does not exist')
	)
;

companies_d00 := fileservices.despray('~thor_data400::out::dnb_companies',pDestinationIP,pDestinationVolume + 'dnb_companies.d00',,,,true);
contacts_d00 := fileservices.despray('~thor_data400::out::dnb_contacts',pDestinationIP,pDestinationVolume + 'dnb_contacts.d00',,,,true);
key1 := DKCKeys('~thor_data400::key::moxie.dnb_companies.bdid.key','dnb_companies.bdid.key');
key2 := DKCKeys('~thor_data400::key::moxie.dnb_companies.cn.key','dnb_companies.cn.key');
key3 := DKCKeys('~thor_data400::key::moxie.dnb_companies.duns_number.key','dnb_companies.duns_number.key');
key4 := DKCKeys('~thor_data400::key::moxie.dnb_companies.nameasis.key','dnb_companies.nameasis.key');
key5 := DKCKeys('~thor_data400::key::moxie.dnb_companies.pcn.key','dnb_companies.pcn.key');
key6 := DKCKeys('~thor_data400::key::moxie.dnb_companies.phoneno.key','dnb_companies.phoneno.key');
key7 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.city.cn.key','dnb_companies.st.city.cn.key');
key8 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.city.nameasis.key','dnb_companies.st.city.nameasis.key');
key9 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.city.pcn.key','dnb_companies.st.city.pcn.key');
key10 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.cn.key','dnb_companies.st.cn.key');
key11 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.nameasis.key','dnb_companies.st.nameasis.key');
key12 := DKCKeys('~thor_data400::key::moxie.dnb_companies.st.pcn.key','dnb_companies.st.pcn.key');
key13 := DKCKeys('~thor_data400::key::moxie.dnb_companies.trade_style.key','dnb_companies.trade_style.key');
key14 := DKCKeys('~thor_data400::key::moxie.dnb_companies.z5.cn.key','dnb_companies.z5.cn.key');
key15 := DKCKeys('~thor_data400::key::moxie.dnb_companies.z5.nameasis.key','dnb_companies.z5.nameasis.key');
key16 := DKCKeys('~thor_data400::key::moxie.dnb_companies.z5.pcn.key','dnb_companies.z5.pcn.key');
key17 := DKCKeys('~thor_data400::key::moxie.dnb_companies.z5.prim_name.prim_range.key','dnb_companies.z5.prim_name.prim_range.key');
key18 := DKCKeys('~thor_data400::key::moxie.dnb_companies.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key','dnb_companies.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key');
key19 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.bdid.key','dnb_contacts.bdid.key');
key20 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.cn.key','dnb_contacts.cn.key');
key21 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.did.key','dnb_contacts.did.key');
key22 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.dph_lname.fname.mname.lname.key','dnb_contacts.dph_lname.fname.mname.lname.key');
key23 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.duns_number.key','dnb_contacts.duns_number.key');
key24 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.lfmname.key','dnb_contacts.lfmname.key');
key25 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.nameasis.key','dnb_contacts.nameasis.key');
key26 := DKCKeys('~thor_data400::key::moxie.dnb_contacts.pcn.key','dnb_contacts.pcn.key');

return parallel(companies_d00,contacts_d00,key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,key12,key13,
							key14,key15,key16,key17,key18,key19,key20,key21,key22,key23,key24,key25,key26);

end;