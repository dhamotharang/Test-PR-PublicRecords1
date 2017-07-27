//counts ran against the 20071010 build reveal about 9.8M records, or 14.5 unique "names" that meet this condition
//bug 27203 - the thought is that these junk search records are affecting the autokeys
import ut,LN_PropertyV2; 
layout := {
						{
							LN_PropertyV2.Layout_DID_Out and not {unsigned8 nid, integer2 xadl2_weight, string2 Addr_ind, string1 Best_addr_ind, unsigned6 addr_tx_id, string1 best_addr_tx_id, unsigned8 Location_id, string1 best_locid}
						}
																								or {unsigned8 nid, integer2 xadl2_weight, string2 Addr_ind, string1 Best_addr_ind, unsigned6 addr_tx_id, string1 best_addr_tx_id, unsigned8 Location_id, string1 best_locid}
					};

export file_search_building_Bip(dataset(layout) search, boolean isFast)	:= FUNCTION

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

remove_bad_srch_recs := search(~((length(trim(cname))<4	and	cname<>'')	or
																												(trim(prim_range)=''	and	trim(prim_name)=''	and	trim(v_city_name)=''	and	trim(st)=''	and	trim(zip)='')
																											 )	and
																											 ln_fares_id	not	in	LN_PropertyV2.Suppress_LNFaresID
																											);

LN_PropertyV2.Layout_DID_Out-nid removeField(remove_bad_srch_recs l):= transform
		self := l;
end;
	
remove_nid := project(remove_bad_srch_recs, removeField(left));

ut.mac_suppress_by_phonetype(remove_nid,phone_number,st,search_phone_suppressed,true,did);

dFile_search_building_Bip	:=	search_phone_suppressed;// : persist('~thor_data400::persist::'+keyPrefix+'::file_search_building_bip');

return dFile_search_building_Bip;

END;