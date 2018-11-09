EXPORT Wheel := MODULE
IMPORT SALT37;
SHARED ExactMatchLimit := 3;
 
EXPORT KeyName_city_clean := BizLinkFull.Filename_keys.Wheel_city_clean; /*HACK07Wheel_city_clean*/
SpecMod := BizLinkFull.specificities(BizLinkFull.File_BizHead);
SHARED city_cleanDS := TABLE(SpecMod.city_clean_values_persisted, {SALT37.Str30Type prefix := SpecMod.city_clean_values_persisted.city_clean;	REAL8 specificity := SpecMod.city_clean_values_persisted.field_specificity;});
 
EXPORT Key_city_clean := INDEX(city_cleanDS,{prefix},{city_cleanDS},KeyName_city_clean);
EXPORT Fetch_city_clean_Regular(SALT37.StrType s, UNSIGNED n, UNSIGNED t) := TABLE(TOPN(Key_city_clean(prefix[1..length(s)] = s AND specificity<=t), n, specificity), {SALT37.StrType word_list := prefix, REAL8 specificity := specificity});
 
EXPORT KeyNameQuick_city_clean := BizLinkFull.Filename_keys.Wheel_Quick_city_clean; /*HACK07Wheel_Quick_city_clean*/
Quick_city_cleanDS := DEDUP(SORT(DISTRIBUTE(city_cleanDS,HASH(prefix[1..ExactMatchLimit])), prefix[1..ExactMatchLimit], specificity,LOCAL),prefix[1..ExactMatchLimit], KEEP 100,LOCAL);
 
EXPORT KeyQuick_city_clean := INDEX(Quick_city_cleanDS,{prefix},{Quick_city_cleanDS},KeyNameQuick_city_clean);
EXPORT FetchQuick_city_clean_Regular(SALT37.StrType s, UNSIGNED n, UNSIGNED t) := TABLE(TOPN(Key_city_clean(prefix[1..length(s)] = s AND specificity<=t), n, specificity), {SALT37.StrType word_list := prefix, REAL8 specificity := specificity});
EXPORT Fetch_city_clean(SALT37.StrType s, UNSIGNED n, UNSIGNED t) := FUNCTION
	result0 := IF(length(s)>ExactMatchLimit,Fetch_city_clean_Regular(s,n,t),FetchQuick_city_clean_Regular(s,n,t) );
	result := result0;
	RETURN result;
END;
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(Key_city_clean, OVERWRITE),BUILDINDEX(KeyQuick_city_clean, OVERWRITE));
END;
