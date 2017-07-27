import property,lib_keylib,lib_fileservices,ut;

ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.big.key',key1);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.did.key',key2);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.fid.recording_date.key',key3);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.lfmname.key',key4);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.nameasis.key',key5);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.cn.key',key6);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.key',key7);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.prim.nameasis.key',key8);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.process_date.key',key9);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.ssn.key',key10);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.cn.key',key11);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.lfmname.key',key12);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.city.nameasis.key',key13);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.cn.key',key14);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.lfmname.key',key15);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.st.nameasis.key',key16);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.cn.key',key17);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.lfmname.key',key18);
ut.Mac_Delete_File('~thor_data400::key::moxie.foreclosure.zip.nameasis.key',key19);

parallel(key1,key2,key3,key4,key5,key6,key7,key8,key9,key10,key11,
		  key12,key13,key14,key15,key16,key17,key18,key19);