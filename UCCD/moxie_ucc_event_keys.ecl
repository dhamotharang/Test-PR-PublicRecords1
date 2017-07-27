import uccd,lib_keylib,lib_stringlib;

//#workunit('name','ucc event keys');


Layout_WithExpEvent_Filepos := record
	uccd.rec_withEXpEvent;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

 
h := uccd.File_WithExpEvent2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie_ucc_events2.';

//output(h);

MyFields := record
h.ucc_key;
h.event_key;
h.filing_date;
/*h.orig_filing_num;            // Seisint Business Identifier
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);
h.filing_type;
h.document_num;
h.orig_filing_date;*/
h.__filepos;
end;
  
t := table(h, MyFields);

//THE KEYS NOT NEEDED FOR MOXIE SERVED FROM ROXIE

/*BUILDINDEX( t, {orig_filing_num,file_state,filing_date,filing_type,document_num,orig_filing_date,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_events2.orig_filing_num.file_state.filing_date.filing_type.document_num.orig_filing_date.key', moxie);
BUILDINDEX( t, {document_num,file_state,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_events2.document_num.file_state.key', moxie);*/
k1 := BUILDINDEX( t, {ucc_key,event_key,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key.event_key_'+ uccd.version_development, moxie);

k2 := BUILDINDEX( t, {ucc_key,filing_date,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key.filing_date_'+ uccd.version_development, moxie);
			
unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(uccd.Layout_withEXpEvent) + max(h, __filepos): global;
headersize := if (sizeof(uccd.Layout_withEXpEvent)>215, sizeof(uccd.Layout_withEXpEvent), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},base_key_Name + 'fpos.data_'+ uccd.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);

export moxie_ucc_event_Keys
 :=
  parallel
	(
	 k1
	,k2
	,kFPos
	)
  ;

			
			