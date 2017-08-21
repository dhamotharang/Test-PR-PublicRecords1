export DKC_Official_Records(string volume) := 
function

#workunit('name','DKC Official Records')

DestinationIP := '10.173.12.240';

DKCKeys(string KeyFileName,string Destfilename)
 :=
  if(fileservices.FileExists(KeyFileName),
	 FileServices.DKC(KeyFileName,DestinationIP,'/'+volume+'/'+Destfilename,,,,TRUE),
	 output(KeyFileName + ' does not exist')
	)
 ;

key1 := DKCKeys('~thor_200::key::moxie.official_records_party.official_record_key.sequence_number.key','official_records_party.official_record_key.sequence_number.key');
key2 := DKCKeys('~thor_200::key::moxie.official_records_party.official_record_key.master_party_type_cd.sequence_number.key','official_records_party.official_record_key.master_party_type_cd.sequence_number.key');
key3 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.lfmname.key','official_records_party.st.county.lfmname.key');
key4 := DKCKeys('~thor_200::key::moxie.official_records_party.st.lfmname.key','official_records_party.st.lfmname.key');
key5 := DKCKeys('~thor_200::key::moxie.official_records_party.lfmname.key','official_records_party.lfmname.key');
key6 := DKCKeys('~thor_200::key::moxie.official_records_party.st.doc_num.date.key','official_records_party.st.doc_num.date.key');
key7 := DKCKeys('~thor_200::key::moxie.official_records_party.doc_num.date.key','official_records_party.doc_num.date.key');
key8 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.date.lfmname.key','official_records_party.st.county.date.lfmname.key');
key9 := DKCKeys('~thor_200::key::moxie.official_records_party.st.date.lfmname.key','official_records_party.st.date.lfmname.key');
key10 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.date.nameasis.key','official_records_party.st.county.date.nameasis.key');
key11 := DKCKeys('~thor_200::key::moxie.official_records_party.st.date.nameasis.key','official_records_party.st.date.nameasis.key');
key12 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.nameasis.key','official_records_party.st.county.nameasis.key');
key13 := DKCKeys('~thor_200::key::moxie.official_records_party.st.nameasis.key','official_records_party.st.nameasis.key');
key14 := DKCKeys('~thor_200::key::moxie.official_records_party.nameasis.key','official_records_party.nameasis.key');
key15 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.doc_num.date.key','official_records_party.st.county.doc_num.date.key');
key16 := DKCKeys('~thor_200::key::moxie.official_records_party.st.county.process_date.lfmname.key','official_records_party.st.county.process_date.lfmname.key');
key17 := DKCKeys('~thor_200::key::moxie.official_records_document.official_record_key.key','official_records_document.official_record_key.key');
key18 := DKCKeys('~thor_200::key::moxie.official_records_document.fips_st.fips_county.doc_num.key','official_records_document.fips_st.fips_county.doc_num.key');
key19 := DKCKeys('~thor_200::key::moxie.official_records_document.fips_st.fips_county.book_num.page_num.key','official_records_document.fips_st.fips_county.book_num.page_num.key');

return parallel(sequential(key1,key2,key3,key4,key5,key6,key7,key8,key9,
			key10,key11),sequential(key12,key13,key14,key15,key16,key17,
			key18,key19));

end;