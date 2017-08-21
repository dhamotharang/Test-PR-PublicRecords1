import LN_Property,doxie, ut, LN_PropertyV2;
dd := LN_PropertyV2.file_search_building((unsigned)did > 0);
d := dedup(sort(distribute(dd, hash(did)), did, ln_fares_id, source_code, local),did, ln_fares_id,source_code, local);

export Key_Prp_DID := INDEX(d, 
{s_did := (unsigned)did, string1 source_code_2 := source_code[2]},
{ln_fares_id,source_code, lname, fname, prim_range, predir, prim_name, suffix, postdir, sec_range, st, p_city_name, zip, county, geo_blk}, 
ut.foreign_prod + 'thor_data400::key::ln_propertyV2::' + doxie.Version_SuperKey + '::search.did');