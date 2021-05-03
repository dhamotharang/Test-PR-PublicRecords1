import LN_PropertyV2,ut; 

EXPORT CleanSearch(boolean isFast, boolean deltaonly = false) := FUNCTION

d1	:=	if (deltaonly, LN_PropertyV2_Fast.Files.basedelta.search_prp, LN_PropertyV2_Fast.Files.base.search_prp);
d0  :=  LN_PropertyV2.File_Search_did;

search		:= if (isFast,d1,d0);
keyPrefix := if (isFast, 'property_fast', 'ln_propertyv2'); //not versioned

remove_bad_srch_recs := search(~((length(trim(cname))<4	and	cname<>'')	or
																												(trim(prim_range)=''	and	trim(prim_name)=''	and	trim(v_city_name)=''	and	trim(st)=''	and	trim(zip)='')
																											 )	and
																											 ln_fares_id	not	in	LN_PropertyV2.Suppress_LNFaresID
																											);
rLayoutDid_Out  := record
	LN_PropertyV2.Layout_Did_Out;
	unsigned8 persistent_record_id := 0;
end;

dsSearch_building	:=	project(remove_bad_srch_recs,TRANSFORM(rLayoutDid_Out,SELF := LEFT));
search_building_append  := ln_propertyV2.fn_append_puid(dsSearch_building);
file_search_building0 := project(search_building_append,TRANSFORM(LN_PropertyV2.layout_search_building,SELF := LEFT));

ut.mac_suppress_by_phonetype(file_search_building0,phone_number,st,search_phone_suppressed,true,did);

file_search_building	:=	search_phone_suppressed;//: persist('~thor_data400::persist::'+keyPrefix+'::search_phone_suppression_');
//file_search_building	:=	search_phone_suppressed;

return file_search_building;

END;