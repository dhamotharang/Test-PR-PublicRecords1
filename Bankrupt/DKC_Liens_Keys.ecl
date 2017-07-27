export DKC_Liens_Keys(volume) := macro

#workunit('name','DKC Liens Keys ');

#uniquename(key1)
#uniquename(key2)
#uniquename(key3)
#uniquename(key4)
#uniquename(key5)
#uniquename(key6)
#uniquename(key7)
#uniquename(key8)
#uniquename(key9)
#uniquename(key10)
#uniquename(key11)
#uniquename(key12)
#uniquename(key13)
#uniquename(key14)
#uniquename(key15)
#uniquename(key16)
#uniquename(key17)
#uniquename(key18)
#uniquename(key19)
#uniquename(key20)
#uniquename(key21)
#uniquename(DestinationIP)
// Delete the existing keys on thor ****************************************************************

//DestinationPath := '/thor_back5/fares/foreclosure/build';
%DestinationIP% := '192.168.0.39';

DKCKeys(string KeyFileName,string Destfilename)
 :=
  if(fileservices.FileExists(KeyFileName),
	 FileServices.DKC(KeyFileName,%DestinationIP%,'/'+volume+'/liens/'+Destfilename,,,,TRUE),
	 output(KeyFileName + ' does not exist')
	)
 ;

%key1% := DKCKeys('~thor_data400::key::moxie.liens.bdid.key','liens2.bdid.key');
%key2% := DKCKeys('~thor_data400::key::moxie.liens.casenumber.key','liens2.casenumber.key');
%key3% := DKCKeys('~thor_data400::key::moxie.liens.cn.key','liens2.cn.key');
%key4% := DKCKeys('~thor_data400::key::moxie.liens.court_st.casenumber.key','liens2.court_st.casenumber.key');
%key5% := DKCKeys('~thor_data400::key::moxie.liens.courtid.casenumber.book.page.key','liens2.courtid.casenumber.book.page.key');
%key6% := DKCKeys('~thor_data400::key::moxie.liens.did.key','liens2.did.key');
%key7% := DKCKeys('~thor_data400::key::moxie.liens.lfmname.key','liens2.lfmname.key');
%key8% := DKCKeys('~thor_data400::key::moxie.liens.nameasis.key','liens2.nameasis.key');
%key9% := DKCKeys('~thor_data400::key::moxie.liens.rmsid.key','liens2.rmsid.key');
%key10% := DKCKeys('~thor_data400::key::moxie.liens.ssn.key','liens2.ssn.key');
%key11% := DKCKeys('~thor_data400::key::moxie.liens.st.city.cn.key','liens2.st.city.cn.key');
%key12% := DKCKeys('~thor_data400::key::moxie.liens.st.city.lfmname.key','liens2.st.city.lfmname.key');
%key13% := DKCKeys('~thor_data400::key::moxie.liens.st.city.nameasis.key','liens2.st.city.nameasis.key');
%key14% := DKCKeys('~thor_data400::key::moxie.liens.st.cn.key','liens2.st.cn.key');
%key15% := DKCKeys('~thor_data400::key::moxie.liens.st.lfmname.key','liens2.st.lfmname.key');
%key16% := DKCKeys('~thor_data400::key::moxie.liens.st.nameasis.key','liens2.st.nameasis.key');
%key17% := DKCKeys('~thor_data400::key::moxie.liens.uploaddate.key','liens2.uploaddate.key');
%key18% := DKCKeys('~thor_data400::key::moxie.liens.z5.cn.key','liens2.z5.cn.key');
%key19% := DKCKeys('~thor_data400::key::moxie.liens.z5.prim_name.prim_range.lfmname.key','liens2.z5.prim_name.prim_range.lfmname.key');
%key20% := DKCKeys('~thor_data400::key::moxie.liens.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key','liens2.z5.prim_name.suffix.predir.postdir.prim_range.sec_range.key');
%key21% := DKCKeys('~thor_data400::key::moxie.liens.fpos.data.key','liens2.fpos.data.key');

sequential(%key1%,%key2%,%key3%,%key4%,%key5%,%key6%,%key7%,%key8%,%key9%,
			%key10%,%key11%,%key12%,%key13%,%key14%,%key15%,%key16%,%key17%,
			%key18%,%key19%,%key20%,%key21%);
endmacro;