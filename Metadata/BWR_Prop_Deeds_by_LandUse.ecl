// Prop Deeds by LandUse W20081203-165939 W20081204-085230
// 137 = mobile home
// 138 = manufactured home

output(table(Property.File_Fares_Deeds,{universal_luse_code,count(group)},universal_luse_code),all);
output(table(LN_PropertyV2.File_Deed,{assessment_match_land_use_code,count(group)},assessment_match_land_use_code),all);