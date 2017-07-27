Import Data_Services, doxie, ut, data_services, header, lib_stringlib,lib_metaphone;

file_Phonetic_equivs_lname0 := Header.file_Phonetic_equivs_lname;

layout_slim := record 
  string6  ph_lname1;  //phonetic value of a given last name
  string6  ph_lname2; 
  string20 lname;       
  string10 _count ; 
end; 

layout_slim getPhoneticKey (file_Phonetic_equivs_lname0 L) := TRANSFORM
  name_clean := if(stringlib.stringfilterout(trim(l.name,left,right),'0123456789')='','',l.name); 
  SELF.ph_lname1 := metaphonelib.DMetaPhone1 (name_clean);
  self.ph_lname2  := metaphonelib.DMetaPhone2 (name_clean);
  self.lname := name_clean ; 
  SELF := L;
END;
ds_phonetics0 := PROJECT (file_Phonetic_equivs_lname0, getPhoneticKey (Left));

layout_out:= record 
  string6  ph_lname;  
  string20 lname;       
  string10 _count ; 
end; 

layout_out tnormalize(layout_slim L, integer cnt) := transform
self.ph_lname:= choose(cnt, L.ph_lname1, L.ph_lname2);
self.lname   := L.lname;
self._count  := L._count ; 
end; 
ds_phonetics := dedup(normalize(ds_phonetics0, 2, tnormalize(left, counter)),record,all);
ds_ph := group(sort(ds_phonetics(ph_lname != ''),ph_lname),ph_lname);
ds_ph_top_10 := topn(ds_ph, 10, -_count); 

export key_Phonetic_equivs_lname := index(ds_ph_top_10,{ph_lname}, {lname,_count}, 
           data_services.Data_location.Prefix('hdr_nonupdating') +  'thor_data400::key::hdr_phonetic_lname_top10_' + doxie.Version_SuperKey);
