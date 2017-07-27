//counts ran against the 20071010 build reveal about 9.8M records, or 14.5 unique "names" that meet this condition
//bug 27203 - the thought is that these junk search records are affecting the autokeys
import ut; 
remove_bad_srch_recs := LN_PropertyV2.File_Search_did(~((length(trim(cname))<4	and	cname<>'')	or
																												(trim(prim_range)=''	and	trim(prim_name)=''	and	trim(v_city_name)=''	and	trim(st)=''	and	trim(zip)='')
																											 )	and
																											 ln_fares_id	not	in	LN_PropertyV2.Suppress_LNFaresID
																											);

// Bring to orig layout so that the queries need not be recompiled
LN_PropertyV2.layout_search_building bring_to_orig_layout(remove_bad_srch_recs l)	:=
transform
	self	:=	l;
end;

file_search_building0	:=	project(remove_bad_srch_recs,bring_to_orig_layout(left));

ut.mac_suppress_by_phonetype(file_search_building0,phone_number,st,search_phone_suppressed,true,did);

append_puid  := ln_propertyV2.fn_append_puid(search_phone_suppressed);

export	file_search_building	:=	append_puid : persist('~thor_data400::persist::ln_propertyv2::search_phone_suppression','thor400_92');

// export	file_search_building	:=	search_phone_suppressed : persist('~thor_data400::persist::ln_propertyv2::search_phone_suppression','thor400_92');







