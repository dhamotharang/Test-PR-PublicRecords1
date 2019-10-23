IMPORT InsuranceHeader_Address;

EXPORT ADDRESS_GROUP_IDCompareService_V1(unsigned8 in_address_group_id1, unsigned8 in_address_group_id2) := FUNCTION
UNSIGNED8 ADDRESS_GROUP_IDone := in_address_group_id1;
UNSIGNED8 ADDRESS_GROUP_IDtwo := in_address_group_id2;
BFile := InsuranceHeader_Address.In_Address_Link;
odl := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).Candidates(ADDRESS_GROUP_ID=ADDRESS_GROUP_IDone),100000),InsuranceHeader_Address.match_candidates(BFile).layout_candidates);
odr := PROJECT(CHOOSEN(InsuranceHeader_Address.Keys(BFile).Candidates(ADDRESS_GROUP_ID=ADDRESS_GROUP_IDTwo),100000),InsuranceHeader_Address.match_candidates(BFile).layout_candidates);
k := InsuranceHeader_Address.Keys(BFile).Specificities_Key;
s := GLOBAL(PROJECT(k,InsuranceHeader_Address.Layout_Specificities.R)[1]);
odlv := InsuranceHeader_Address.Debug(BFile,s).RolledEntities(odl);
odrv := InsuranceHeader_Address.Debug(BFile,s).RolledEntities(odr);

mtch0 := InsuranceHeader_Address.Debug(BFile,s).AnnotateMatchesFromData(odl+odr,DATASET([{0,0,0,0,ADDRESS_GROUP_IDone,ADDRESS_GROUP_IDtwo,0,0}],InsuranceHeader_Address.match_candidates(BFile).layout_matches));
mtch := SORT(mtch0,-Conf)[..100];
score := project(mtch, InsuranceHeader_Address.layout_attribute_score);

RETURN SORT(mtch,-Conf)[1];
END;
