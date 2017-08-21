import property,lib_keylib,lib_fileservices,_control;

// Delete the existing keys on thor ****************************************************************

//DestinationPath := '/thor_back5/fares/foreclosure/build';
DestinationIP := 'edata12-bld.br.seisint.com';

DesprayFile(string FileName,string Destfilename)
 :=
  if(lib_fileservices.fileservices.FileExists(FileName),
	 lib_fileservices.FileServices.Despray(FileName,DestinationIP,'/thor_back5/local_data/demo/foreclosure/'+Destfilename,,,,TRUE),
	 output(FileName + ' does not exist')
	)
 ;

DKCKeys(string KeyFileName,string Destfilename)
 :=
  if(lib_fileservices.fileservices.FileExists(KeyFileName),
	 lib_fileservices.FileServices.DKC(KeyFileName,DestinationIP,'/thor_back5/local_data/demo/foreclosure/'+Destfilename,,,,TRUE),
	 output(KeyFileName + ' does not exist')
	)
 ;

baseFile := DesprayFile('~thor_data400::persist::file_foreclosure_building','foreclosure.d00');
key1 := DKCKeys('~thor_data400::key::moxie.foreclosure.big.key','foreclosure.z5.prim_name.predir.postdir.prim_range.addr_suffix.name_last.sec_range.key');
key2 := DKCKeys('~thor_data400::key::moxie.foreclosure.did.key','foreclosure.did.key');
key3 := DKCKeys('~thor_data400::key::moxie.foreclosure.fid.recording_date.key','foreclosure.fid.recording_date.key');
key4 := DKCKeys('~thor_data400::key::moxie.foreclosure.lfmname.key','foreclosure.lfmname.key');
key5 := DKCKeys('~thor_data400::key::moxie.foreclosure.nameasis.key','foreclosure.nameasis.key');
key6 := DKCKeys('~thor_data400::key::moxie.foreclosure.prim.cn.key','foreclosure.z5.prim_name.prim_range.cn.key');
key7 := DKCKeys('~thor_data400::key::moxie.foreclosure.prim.key','foreclosure.z5.prim_name.prim_range.lfmname.key');
key8 := DKCKeys('~thor_data400::key::moxie.foreclosure.prim.nameasis.key','foreclosure.z5.prim_name.prim_range.nameasis.key');
key9 := DKCKeys('~thor_data400::key::moxie.foreclosure.process_date.key','foreclosure.process_date.key');
key10 := DKCKeys('~thor_data400::key::moxie.foreclosure.ssn.key','foreclosure.ssn.key');
key11 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.city.cn.key','foreclosure.st.city.cn.key');
key12 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.city.lfmname.key','foreclosure.st.city.lfmname.key');
key13 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.city.nameasis.key','foreclosure.st.city.nameasis.key');
key14 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.cn.key','foreclosure.st.cn.key');
key15 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.lfmname.key','foreclosure.st.lfmname.key');
key16 := DKCKeys('~thor_data400::key::moxie.foreclosure.st.nameasis.key','foreclosure.st.nameasis.key');
key17 := DKCKeys('~thor_data400::key::moxie.foreclosure.zip.cn.key','foreclosure.z5.cn.key');
key18 := DKCKeys('~thor_data400::key::moxie.foreclosure.zip.lfmname.key','foreclosure.z5.lfmname.key');
key19 := DKCKeys('~thor_data400::key::moxie.foreclosure.zip.nameasis.key','foreclosure.z5.nameasis.key');

result := sequential(baseFile,property.Out_Moxie_Foreclosure_Keys,key1,key2,key3,key4,key5,key6,key7,key8,key9,
																					key10,key11,key12,key13,key14,key15,key16,key17,key18,key19);


export bwr_moxie_foreclosure := result;