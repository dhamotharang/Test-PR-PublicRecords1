import gong;

export mac_get_gong_by_phone(f_in, f_out, use_gong_flag) := macro
	
#uniquename(key_gong_history_phone)	
%key_gong_history_phone% := gong.Key_History_phone;

#uniquename(gong2Pretty)	
phonesplus_batch.layout_phonesplus_reverse_common %gong2Pretty%(f_in l, 
                                                                %key_gong_history_phone% r) := TRANSFORM
	self.seq := l.seq;
	self.acctno := l.acctno;
	SELF.did := r.did;
	SELF.src := 'PH';
	SELF.vendor_id := 'GH';
	SELF.fname := r.name_first;
	SELF.mname := r.name_middle;
	SELF.lname := r.name_last;
	SELF.name_suffix := r.name_suffix;
	SELF.city_name := r.p_city_name;
	SELF.zip := r.z5;
	SELF.zip4 := r.z4;
	SELF.phone := r.phone10;
	SELF.listed_phone := r.phone10;
	SELF.listed_name := r.listed_name;
	SELF.listing_type_bus := r.listing_type_bus;
	SELF.listing_type_gov := r.listing_type_gov;
	SELF.caption_text := r.caption_text;
	SELF.bdid := r.bdid;
	SELF.dt_first_seen := r.dt_first_seen;
	SELF.dt_last_seen := ut.GetDate;
	SELF.TNT := 'V';
	self.ConfidenceScore := 30;
	self.Activeflag := 'Y';
	SELF := r;
	SELF := [];
END;
  
f_out := if(~use_gong_flag, 
            dataset([],phonesplus_batch.layout_phonesplus_reverse_common),
            join(f_in, %key_gong_history_phone%,
                 keyed(left.phoneno[4..10] = right.p7) and 
							   keyed(left.phoneno[1..3] = right.p3) and
								 right.current_flag,
								 %gong2Pretty%(left, right), LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)));							
		
endmacro;