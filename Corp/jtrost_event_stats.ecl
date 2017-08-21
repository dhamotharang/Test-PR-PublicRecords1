old_ := dataset('~thor_data400::in::corporate_direct::event_father',corp.Layout_Corporate_Direct_Event_In, flat)(corp_state_origin='MN');
new_ := corp.File_Corporate_Direct_Event_Update;

outrec1 := record
 old_.corp_state_origin;
 old_.corp_vendor;
 //old_.corp_process_date;
 count_                         := count(group);
 min_process_date               := min(group,old_.corp_process_date);
 max_process_date               := max(group,old_.corp_process_date);
 bad_event_filing_date_ct       := count(group,length(trim(old_.event_filing_date,left,right))!=length(trim(stringlib.stringfilter(old_.event_filing_date,'0123456789'),left,right)));
 has_corp_key                   := ave(group,if(trim(old_.corp_key)!='',1,0));
 has_corp_vendor                := ave(group,if(trim(old_.corp_vendor)!='',1,0));
 has_corp_sos_charter_nbr       := ave(group,if(trim(old_.corp_sos_charter_nbr)!='',1,0));
 has_event_filing_reference_nbr := ave(group,if(trim(old_.event_filing_reference_nbr)!='',1,0));
 has_event_filing_date          := ave(group,if(trim(old_.event_filing_date)!='',1,0));
 has_event_filing_cd            := ave(group,if(trim(old_.event_filing_cd)!='',1,0));
 has_event_filing_desc          := ave(group,if(trim(old_.event_filing_desc)!='',1,0));
 has_event_desc                 := ave(group,if(trim(old_.event_desc)!='',1,0));
end;

//old_stats := sort(table(old_,outrec1,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
//output(old_stats,all);

outrec2 := record
 new_.corp_state_origin;
 new_.corp_vendor;
 //new_.corp_process_date;
 count_                         := count(group);
 min_process_date               := min(group,new_.corp_process_date);
 max_process_date               := max(group,new_.corp_process_date);
 bad_event_filing_date_ct       := count(group,length(trim(new_.event_filing_date,left,right))!=length(trim(stringlib.stringfilter(new_.event_filing_date,'0123456789'),left,right)));
 has_corp_key                   := ave(group,if(trim(new_.corp_key)!='',1,0));
 has_corp_vendor                := ave(group,if(trim(new_.corp_vendor)!='',1,0));
 has_corp_sos_charter_nbr       := ave(group,if(trim(new_.corp_sos_charter_nbr)!='',1,0));
 has_event_filing_reference_nbr := ave(group,if(trim(new_.event_filing_reference_nbr)!='',1,0));
 has_event_filing_date          := ave(group,if(trim(new_.event_filing_date)!='',1,0));
 has_event_filing_cd            := ave(group,if(trim(new_.event_filing_cd)!='',1,0));
 has_event_filing_desc          := ave(group,if(trim(new_.event_filing_desc)!='',1,0));
 has_event_desc                 := ave(group,if(trim(new_.event_desc)!='',1,0));
end;

new_stats := sort(table(new_,outrec2,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
output(new_stats,all);
/*
stat_rec := record
 decimal2 counter_;
 string35 condition;
 string10 old_val;
 string10 new_val;
 real4    delta;
end;

stat_rec mapa(old_stats l, new_stats r) := transform
 self.counter_  := 1;
 self.condition := 'corp_state_origin + corp_vendor';
 self.old_val   := l.corp_state_origin+' - '+l.corp_vendor;
 self.new_val   := r.corp_state_origin+' - '+r.corp_vendor;
 self           := [];
end;

stat_rec mapb(old_stats l, new_stats r) := transform
 self.counter_  := 2;
 self.condition := 'count_';
 self.old_val   := (string10) l.count_;
 self.new_val   := (string10) r.count_;
 self           := [];
end;
		  
stat_rec mapc(old_stats l, new_stats r) := transform
 self.counter_  := 3;
 self.condition := 'min_process_date';
 self.old_val   := l.min_process_date;
 self.new_val   := r.min_process_date;
 self           := [];
end;

stat_rec mapd(old_stats l, new_stats r) := transform
 self.counter_  := 4;
 self.condition := 'max_process_date';
 self.old_val   := l.max_process_date;
 self.new_val   := r.max_process_date;
 self           := [];
end;

stat_rec mape(old_stats l, new_stats r) := transform
 self.counter_  := 5;
 self.condition := 'has_corp_key';
 self.old_val   := (string10)l.has_corp_key;
 self.new_val   := (string10)r.has_corp_key;
 self.delta     := l.has_corp_key - r.has_corp_key
end;
		  
stat_rec mapf(old_stats l, new_stats r) := transform
 self.counter_  := 6;
 self.condition := 'bad_corp_key_ct';
 self.old_val   := (string10)l.bad_corp_key_ct;
 self.new_val   := (string10)r.bad_corp_key_ct;
 self           := [];
end;
		 
stat_rec mapg(old_stats l, new_stats r) := transform
 self.counter_  := 7;
 self.condition := 'has_corp_vendor';
 self.old_val   := (string10)l.has_corp_vendor;
 self.new_val   := (string10)r.has_corp_vendor;
 self.delta     := l.has_corp_vendor - r.has_corp_vendor;
end;

stat_rec maph(old_stats l, new_stats r) := transform
 self.counter_  := 8;
 self.condition := 'has_corp_sos_charter_nbr';
 self.old_val   := (string10)l.has_corp_sos_charter_nbr;
 self.new_val   := (string10)r.has_corp_sos_charter_nbr;
 self.delta     := l.has_corp_sos_charter_nbr - r.has_corp_sos_charter_nbr;
end;

stat_rec mapi(old_stats l, new_stats r) := transform
 self.counter_  := 9;
 self.condition := 'has_event_filing_reference_nbr';
 self.old_val   := (string10)l.has_event_filing_reference_nbr;
 self.new_val   := (string10)r.has_event_filing_reference_nbr;
 self.delta     := l.has_event_filing_reference_nbr - r.has_event_filing_reference_nbr;
end;

stat_rec mapj(old_stats l, new_stats r) := transform
 self.counter_  := 10;
 self.condition := 'has_event_filing_date';
 self.old_val   := (string10)l.has_event_filing_date;
 self.new_val   := (string10)r.has_event_filing_date;
 self.delta     := l.has_event_filing_date - r.has_event_filing_date;
end;

stat_rec mapk(old_stats l, new_stats r) := transform
 self.counter_  := 11;
 self.condition := 'bad_event_filing_date_ct';
 self.old_val   := (string10)l.bad_event_filing_date_ct;
 self.new_val   := (string10)r.bad_event_filing_date_ct;
 self.delta     := [];
end;

stat_rec mapl(old_stats l, new_stats r) := transform
 self.counter_  := 12;
 self.condition := 'has_event_filing_cd';
 self.old_val   := (string10)l.has_event_filing_cd;
 self.new_val   := (string10)r.has_event_filing_cd;
 self.delta     := l.has_event_filing_cd - r.has_event_filing_cd;
end;

stat_rec mapm(old_stats l, new_stats r) := transform
 self.counter_  := 13;
 self.condition := 'has_event_filing_desc';
 self.old_val   := (string10)l.has_event_filing_desc;
 self.new_val   := (string10)r.has_event_filing_desc;
 self.delta     := l.has_event_filing_desc - r.has_event_filing_desc;
end;

stat_rec mapn(old_stats l, new_stats r) := transform
 self.counter_  := 14;
 self.condition := 'has_event_desc';
 self.old_val   := (string10)l.has_event_desc;
 self.new_val   := (string10)r.has_event_desc;
 self.delta     := l.has_event_desc - r.has_event_desc;
end;

a  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapa(left,right));
b  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapb(left,right));
c  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapc(left,right));
d  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapd(left,right));
e  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mape(left,right));
f  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapf(left,right));
g  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapg(left,right));
h  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,maph(left,right));
i  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapi(left,right));
j  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapj(left,right));
k  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapk(left,right));
l  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapl(left,right));
m  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapm(left,right));
n  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapn(left,right));

concat := sort(a+b+c+d+e+f+g+h+i+j+k+l+m+n,counter_);
output(concat,all);
*/            