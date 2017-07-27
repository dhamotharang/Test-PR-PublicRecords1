//counts ran against the 20071010 build reveal about 9.8M records, or 14.5 unique "names" that meet this condition
//bug 27203 - the thought is that these junk search records are affecting the autokeys
import ut; 
remove_bad_srch_recs := LN_PropertyV2.File_Search_did(~((length(trim(cname))<4	and	cname<>'')	or
																												(trim(prim_range)=''	and	trim(prim_name)=''	and	trim(v_city_name)=''	and	trim(st)=''	and	trim(zip)='')
																											 )	and
																											 ln_fares_id	not	in	LN_PropertyV2.Suppress_LNFaresID
																											);

	LN_PropertyV2.Layout_DID_Out-nid removeField(remove_bad_srch_recs l):= transform
		self := l;
	end;
	
	remove_nid := project(remove_bad_srch_recs, removeField(left));

ut.mac_suppress_by_phonetype(remove_nid,phone_number,st,search_phone_suppressed,true,did);

export	file_search_building_Bip	:=	search_phone_suppressed : persist('~thor_data400::persist::ln_propertyv2::file_search_building_bip');
