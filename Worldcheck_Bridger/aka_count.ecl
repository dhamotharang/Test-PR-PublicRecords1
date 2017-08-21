map_akas_altspell := WorldCheck_Bridger.Mapping_AKAs_and_AltSpell(worldcheck_bridger.File_WorldCheck_Premium_In);//(id = '60101'));
map_low_qual_akas  := WorldCheck_Bridger.Mapping_Low_Quality_AKAs(worldcheck_bridger.File_WorldCheck_Premium_In);
map_native_char     := WorldCheck_Bridger.Mapping_Native_Character;
                
//Concat AKAs and Alt Spelling with Low Quality AKAs
concat_AKAs     := map_akas_altspell + map_low_qual_akas + map_native_char;

rec := record
concat_AKAs.id;
count_ := count(group);
end;

EXPORT aka_count := table(concat_AKAs,
                       rec,
                       concat_AKAs.id);
