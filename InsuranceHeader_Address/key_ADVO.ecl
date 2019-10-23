import ut;
EXPORT key_ADVO := MODULE

shared idx := dataset([],Layout_ADVO.rec);
EXPORT key := INDEX(idx,{zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range},{idx},ut.foreign_prod_boca + 'thor_data400::key::advo::qa::addr_search1_history'); 
EXPORT flat := pull(key);

end;