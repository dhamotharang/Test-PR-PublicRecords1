Import Data_Services, doxie, ut, data_services, header, lib_metaphone, lib_stringlib;

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

export key_Phonetic_equivs_fname := index(ds_ph_top_10,{ph_fname}, {fname,_count}, 
                                data_services.Data_location.Prefix('hdr_nonupdating') +  'thor_data400::key::hdr_phonetic_fname_top10_' + doxie.Version_SuperKey);
