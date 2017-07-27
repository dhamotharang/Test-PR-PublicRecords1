import header,doxie ; 
df0 := header.file_fname_ngram; 

layout_slim := record
string3 ngram; 
string20  fname; 
string10 _count; 
end; 

layout_slim  reformat( df0 l) := transform 

self.fname:= l.name ; 
self := l ; 
end; 

df := project(df0, reformat(left)); 

export key_fname_ngram := index(df,{ngram}, {fname,_count}, 
                                  '~thor_data400::key::hdr_fname_ngram_' + doxie.Version_SuperKey);
