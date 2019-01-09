IMPORT STD,DMA,promoteSupers;
/* DF-23628 VC
Leads Enhancement for Death of Insured extract for Insurance team. Contact Charles Beam
1) This function return an extract with the latest phonenumber for a DID. 
2) This list is matched against Do not call list and only the numbers not on this list will be delivered.
*/
EXPORT Fn_Extract_LeadsEnhancementforDeathofInsured(string pExtractVersion) := function

slim_phone_extract_rec := record
			unsigned6	did;
			boolean		in_flag;
			unsigned8	confidencescore;
			string10	cellphone;
			data16		cellphoneidkey;
			unsigned3	datefirstseen;
			unsigned3	datelastseen;
			string2		vendor;
			string2		src;
			string10	prim_range;
			string2		predir;
			string28	prim_name;
			string4		addr_suffix;
			string2		postdir;
			string10	unit_desig;
			string8		sec_range;
			string25	v_city_name;
			string2		state;
			string5		zip5;
			string4		zip4;
			string4		err_stat;
			string5		title;
			string20	fname;
			string20	mname;
			string20	lname;
			string5		name_suffix;
			string25	append_phone_type;
end;

phonesplus_ds		:= phonesplus_v2.key_phonesplus_did(did_type = 'CORE' and
																								l_did > 0  and
																								cellphone <> '' and
																								current_rec = true);

slim_phone_ds   := project(phonesplus_ds, slim_phone_extract_rec);

phone_ds_dist  	:= distribute(slim_phone_ds,hash32(did));
phone_ds_sort  	:= sort(phone_ds_dist, did, cellphone, -datelastseen, -datefirstseen, local);
phone_ds_dedup 	:= dedup(phone_ds_sort, did, cellphone, local);

l_did_grp       := group(phone_ds_dedup, did, local);
date_ds         := topn(l_did_grp, 1, -datelastseen, -datefirstseen, record);


final_phone_ds := join(phone_ds_dedup, date_ds,
															left.did = right.did and
															left.datefirstseen = right.datefirstseen and
															left.datelastseen = right.datelastseen,
															transform(left), local);


dnc_file_name 		:= dma.key_dnc_phone; // '~foreign::10.173.44.105::thor_data400::key::dnc::qa::phone';

good_phone_ds     := join(distribute(FINAL_PHONE_DS, hash32(cellphone)),
										    	distribute(dnc_file_name, hash32(phonenumber)),
										                 left.cellphone = right.phonenumber,
										                 transform(left), left only, local);
																		 
PromoteSupers.MAC_SF_BuildProcess(good_phone_ds ,'~thor::base::activeinsights::best_phonesplusv2',Phone_extract,3,,true, pExtractVersion);
										
return sequential(Phone_extract);
end;


																				 
