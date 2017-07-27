
import uccd,lib_keylib,lib_stringlib;

Layout_WithExpFilingSummary_Filepos := record
	uccd.rec_withEXpFilingSummary;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

 
h := uccd.File_WithExpSummary2_Base_Dev;

base_key_Name := '~thor_data400::key::moxie_ucc_summary2.';

//output(h);

MyFields := record
h.ucc_key;
/*h.orig_filing_num;            // Seisint Business Identifier
string2 file_state := lib_stringlib.stringlib.stringtouppercase(h.file_state);*/
h.__filepos;
end;
  
t := table(h, MyFields);

//THE KEYS NOT NEEDED FOR MOXIE SERVED FROM ROXIE

/*BUILDINDEX( t, {orig_filing_num,file_state,(big_endian unsigned8 )__filepos},
			'key.moxie_ucc_summary2.orig_filing_num.file_state.key', moxie);*/
k1 := BUILDINDEX( t, {ucc_key,(big_endian unsigned8 )__filepos},
			base_key_Name + 'ucc_key_'+ uccd.version_development, moxie);
			

unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
  if (filepos<headersize, rawsize+filepos, filepos);

rawsize := sizeof(uccd.Layout_withEXpFilingSummary) + max(h, __filepos): global;
headersize := if (sizeof(uccd.Layout_withEXpFilingSummary)>215, sizeof(uccd.Layout_withEXpFilingSummary), error('too bad')) : global;

dfile := INDEX(h,{f:= moxietransform(__filepos, rawsize, headersize)},{h},base_key_Name + 'fpos.data_'+ uccd.version_development);
kFPos				:= BUILDINDEX(dfile,moxie);

export moxie_ucc_summary_Keys
 :=
  parallel
	(
	 k1
	,kFPos
	)
  ;
			