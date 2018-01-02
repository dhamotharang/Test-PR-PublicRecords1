import header,doxie, data_services; 
df0 := header.file_lname_ngram; 

layout_slim := record
string3 ngram; 
string20  lname; 
string10 _count; 
end; 

layout_slim  reformat( df0 l) := transform 

self.lname:= l.name ; 
self := l ; 
end; 

df := project(df0, reformat(left)); 

export key_lname_ngram := index(df,{ngram}, {lname,_count}, 
                                  data_services.data_location.prefix() + 'thor_data400::key::hdr_lname_ngram_' + doxie.Version_SuperKey);
