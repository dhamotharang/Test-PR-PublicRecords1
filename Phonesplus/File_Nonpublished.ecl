//Non-published records in current gong
import Gong, gong_v2;
temp_np_layout := record
	string10    prim_range:= '';
	string28    prim_name:= '';
	string8     sec_range:= '';
	string2     st:= '';
	string5     z5:= '';
	string20    name_last:= '';
	string1     publish_code;
end;
//Non-published records in current gong
gong_nonpublished 			:= project(Gong.File_History(publish_code = 'N' and current_record_flag = 'Y'),	
							   transform(temp_np_layout, self:= left)); 
							   
//Non-published current, but deleted due to vendor implementing new Non-published policy
gong_nonpublished_del 		:= project(Gong_v2.File_GongMaster(publish_code = 'N' and vendor + '_' + deletion_date[..8] in Phonesplus.Codes.nonpub_active_deleted),	
							   transform(temp_np_layout, self:= left)); 

nonpublished_d 	  := distribute(gong_nonpublished + gong_nonpublished_del, hash(name_last, prim_range, prim_name, sec_range, z5));
nonpublished_s 	  := sort(nonpublished_d,name_last, prim_range, prim_name, sec_range, z5, local); 
nonpublished_dedp := dedup(nonpublished_s,name_last, prim_range, prim_name, sec_range, z5, local); 

export File_Nonpublished :=   nonpublished_dedp : persist('~thor400_30::persist::file_nonpublished');