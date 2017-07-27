lBaseKeyName 	:= 'key::moxie.official_records_document.';

rMoxieFileForKeybuildLayout
 :=
  record
	official_records.Layout_In_Document;
	unsigned integer8 __filepos{virtual(fileposition)};
  end
 ;

lMoxieFileForKeybuild := dataset(Official_Records.Name_Moxie_Document_Dev,rMoxieFileForKeybuildLayout,flat);

rKey_Fields_Layout
 :=
  record
	lMoxieFileForKeybuild.official_record_key;
	lMoxieFileForKeybuild.fips_st;
	lMoxieFileForKeybuild.fips_county;
	lMoxieFileForKeybuild.book_num;
	lMoxieFileForKeybuild.page_num;
	string25  				doc_num	:= lMoxieFileForKeybuild.doc_instrument_or_clerk_filing_num;
	big_endian unsigned8	filepos	:= (big_endian integer8)lMoxieFileForKeybuild.__filepos;
end;

lDocument_Keys_Table    := table(lMoxieFileForKeybuild,rKey_Fields_Layout);

//build document keys
kOfficialKey            := buildindex(lDocument_Keys_Table(official_record_key<>''),
                           {official_record_key,filepos},
			               lBaseKeyName + 'official_record_key.key',moxie,overwrite);
kFipsStCountyDocNo      := buildindex(lDocument_Keys_Table(fips_st<>''),
                           {fips_st,fips_county,doc_num,filepos},
			               lBaseKeyName + 'fips_st.fips_county.doc_num.key',moxie,overwrite);
kFipsStCountyBookPageNo := buildindex(lDocument_Keys_Table(fips_st<>''),
                           {fips_st,fips_county,book_num,page_num,filepos},
			               lBaseKeyName + 'fips_st.fips_county.book_num.page_num.key',moxie,overwrite);
//end document keys

export Out_Moxie_Document_Keys
 :=
  parallel(
			 kOfficialKey 
			,kFipsStCountyDocNo
			,kFipsStCountyBookPageNo
		   )
 ;