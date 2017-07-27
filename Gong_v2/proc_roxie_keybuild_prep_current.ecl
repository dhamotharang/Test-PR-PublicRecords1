import Gong_v2,header_services;

// infile := dedup(sort(distribute(Gong_v2.File_GongMaster,hash(phone10,filedate,name_last,name_first))
															// ,phone10,filedate,name_last,name_first,local)
															// ,phone10,filedate,name_last,name_first,local)(current_record_flag = 'Y'); 

//infile := Gong_v2.File_GongMaster(current_record_flag = 'Y');
infile := dataset('~thor_200::base::20081013::lss_master',Gong_v2.layout_gongMaster,thor); 

gong_v2.Layout_bscurrent_raw slim(infile L ) := transform
self.listed_name := if(L.company_name<>'', L.company_name,  trim(l.name_first) + ' ' +
	                                                       trim(l.name_middle) + ' ' +
											     trim(l.name_last));

self.predir 		:= if(L.predir      = '',L.appnd_predir     ,L.predir);
self.prim_name 		:= if(L.prim_name   = '',L.appnd_prim_name  ,L.prim_name);
self.suffix  		:= if(L.suffix      = '',L.appnd_suffix     ,L.suffix);
self.postdir 		:= if(L.postdir     = '',L.appnd_postdir    ,L.postdir);
self.p_city_name	:= if(L.p_city_name = '',L.appnd_p_city_name,L.p_city_name);
self.sec_range  	:= if(L.sec_range   = '',L.appnd_sec_range  ,L.sec_range);

self.book_neighborhood_code := '';
self.v_predir := '';
self.v_prim_name :='';
self.v_suffix := '';
self.v_postdir :='';
self.see_also_text := L.special_listing_txt;
self := L;
end;

p_infile := project(infile,slim(left));

Gong_v2.mac_apply_legal(p_infile,outlegal);
currRecords:= outlegal: persist(Gong_v2.thor_cluster+'persist::gongv2::current_mac_apply_legal')
;

export proc_roxie_keybuild_prep_current := currRecords; // Active Gong records