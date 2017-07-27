import gong;

export Mac_History_Daily_Hhid(infile,hhid_field,outfile) := macro

#uniquename(hhid_history_key)
#uniquename(hhid_daily_key)
#uniquename(rmv_daily_key)
%hhid_history_key% := gong.key_history_hhid;
%hhid_daily_key% := gong.key_hhid_add;
%rmv_daily_key% := gong.key_remove;

#uniquename(get_history_by_hhid)
%hhid_history_key% %get_history_by_hhid%(%hhid_history_key% r) := transform
	self := r;
end;

#uniquename(gong_hhid_history)
%gong_hhid_history% := join(infile, %hhid_history_key%, keyed(left.hhid_field = right.s_hhid),
                           %get_history_by_hhid%(right), LIMIT (ut.limits .GONG_HISTORY_MAX, SKIP));

#uniquename(get_add_by_hhid)
%hhid_history_key% %get_add_by_hhid%(%hhid_daily_key%  r) := transform
     self.current_flag := true;
	self.business_flag := if(r.listing_type_bus='B',true,false);
     self.did := 0;
	self.bdid := 0;
	self.dt_first_seen := r.filedate[1..8];
	self.dt_last_seen := ut.GetDate;
	self.current_record_flag := 'Y';
	self.deletion_date := '';
	self.disc_cnt6 := 0;
	self.disc_cnt12 := 0;
	self.disc_cnt18 := 0;
	self := r;
	self := [];
end;

#uniquename(gong_hhid_add)
%gong_hhid_add% := join(infile, %hhid_daily_key%, keyed(left.hhid_field = right.s_hhid),
                        %get_add_by_hhid%(right), LIMIT (ut.limits .GONG_DAILY_MAX, SKIP));

#uniquename(do_remove_add)
%hhid_history_key% %do_remove_add%(%gong_hhid_history% l, %rmv_daily_key% r) := transform
	self.current_flag := if(r.l_phone10<>'' and l.current_flag=true,false,l.current_flag);
	self.current_record_flag := if(r.l_phone10<>'' and l.current_flag=true,'',l.current_record_flag);
	self.deletion_date := if(r.l_phone10<>'' and l.current_flag=true,ut.GetDate,l.deletion_date);
	self := l;
end;

outfile := join(%gong_hhid_history%, %rmv_daily_key%, keyed(left.phone10 = right.l_phone10),
                %do_remove_add%(left, right), left outer, keep(1)) + %gong_hhid_add%;
			
endmacro;