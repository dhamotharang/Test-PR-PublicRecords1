import ut;
EXPORT key_Property_Ownership := MODULE

idx := dataset([],Layout_Property_Ownership.rec);
EXPORT key := INDEX(idx,{did},{idx},ut.foreign_prod_boca + 'thor_data400::key::ln_propertyv2::qa::did.ownership_v4'); 
EXPORT flat := pull(key);

end;