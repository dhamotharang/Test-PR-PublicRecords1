Import Data_Services, doxie, ut, header,lib_stringlib, lib_metaphone;

df := Header.file_Phonetic_equivs_fname;

layout_slim := record 
  string6  ph_fname1;  //phonetic value of a given last name
  string6  ph_fname2; 
  string20 fname;       
  string10 _count ; 
end; 

layout_slim getPhoneticKey (df L) := TRANSFORM
  name_clean := if(stringlib.stringfilterout(trim(l.name,left,right),'0123456789')='','',l.name); 
  SELF.ph_fname1 := metaphonelib.DMetaPhone1 (name_clean);
  SELF.ph_fname2 := metaphonelib.DMetaPhone2 (name_clean);
  self.fname := name_clean ; 
  SELF := L;
END;
ds_phonetics0 := PROJECT (df, getPhoneticKey (Left));

layout_out:= record 
  string6  ph_fname;  
  string20 fname;       
  string10 _count ; 
end; 

layout_out tnormalize(layout_slim L, integer cnt) := transform
self.ph_fname:= choose(cnt, L.ph_fname1, L.ph_fname2);
self.fname   := L.fname;
self._count  := L._count ; 
end; 
ds_phonetics := dedup(normalize(ds_phonetics0, 2, tnormalize(left, counter)),record,all);
ds_ph := group(sort(ds_phonetics(ph_fname != ''),ph_fname),ph_fname);
ds_ph_top_10 := topn(ds_ph, 10, -_count); 

export key_Phonetic_equivs_fname_fcra := index(ds_ph_top_10,{ph_fname}, {fname,_count}, 
                                  ut.foreign_prod+'thor_data400::key::phonetic_fname_top10_fcra_' + doxie.Version_SuperKey);
