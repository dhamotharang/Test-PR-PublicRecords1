import Ln_property, ln_propertyv2, LN_Mortgage,property;

export V2_V1_Fares_Files(string filedate) := function
// Add  V2 Assessor file to V1 Assessor superfile. 

//inAssessorV2 := dataset('~thor_data400::in::ln_propertyv2::'+filedate+'::fares_assessor', property.Layout_Fares_Assessor, thor);

add_V2Asubfile_V1superfile := FileServices.AddSuperFile('~thor_data400::in::fares_2580','~thor_data400::in::ln_propertyv2::'+filedate+'::fares_assessor');

// Add  V2 Deeds file to V1 Deeds superfile. 

//inDeedsV2     := dataset('~thor_data400::in::ln_propertyv2::'+filedate+'::fares_deeds', Property.Layout_Fares_Deeds, thor); 

add_V2Dsubfile_V1superfile := FileServices.AddSuperFile('~thor_data400::in::fares_1080','~thor_data400::in::ln_propertyv2::'+filedate+'::fares_deeds');

// format V2 to V1 and Add V2 search file to V1 Search superfile 
insearchV2 := dataset('~thor_data400::in::ln_propertyv2::'+filedate+'::fares_search', LN_PropertyV2.Layout_Fares_Search_in, thor);

property.layout_Fares_Search	redefine_search(insearchV2 L) := transform

 self := L;
  
end;

Search_reformat := project(insearchV2, redefine_search(left));
outv1search     := output(Search_reformat,,'~thor_data400::in::fares_search_' + filedate, __compressed__, overwrite); 

add_V2toV1search_V1superfile := FileServices.AddSuperFile('~thor_data400::in::fares_search','~thor_data400::in::fares_search_' + filedate);

build_V2_V1 := sequential(add_V2Asubfile_V1superfile,add_V2Dsubfile_V1superfile,outv1search ,add_V2toV1search_V1superfile);  

return build_V2_V1;

end;
