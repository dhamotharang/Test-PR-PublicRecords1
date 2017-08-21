import Gong_v2,header_services;

// infile := dedup(sort(distribute(Gong_v2.File_GongMaster,hash(phone10,filedate,name_last,name_first))
															// ,phone10,filedate,name_last,name_first,local)
															// ,phone10,filedate,name_last,name_first,local)(current_record_flag = 'Y'); 

infile := distribute(Gong_v2.File_GongMaster,random())(current_record_flag = 'Y');
//infile := dataset('~thor_200::base::20081103test::lss_master',Gong_v2.layout_gongMaster,thor)(current_record_flag = 'Y'); 

gong_v2.Layout_bscurrent_raw slim(infile le ) := transform
self.listed_name := if(le.company_name<>'',le.company_name,stringlib.stringcleanspaces(le.name_first+' '+le.name_middle+' '+le.name_last));

self.prim_range  := if(le.prim_range  = '',le.appnd_prim_range ,le.prim_range);
self.predir 	 := if(le.predir      = '',le.appnd_predir     ,le.predir);
self.prim_name 	 := if(le.prim_name   = '',le.appnd_prim_name  ,le.prim_name);
self.suffix  	 := if(le.suffix      = '',le.appnd_suffix     ,le.suffix);
self.postdir 	 := if(le.postdir     = '',le.appnd_postdir    ,le.postdir);
self.p_city_name := if(le.p_city_name = '',le.appnd_p_city_name,le.p_city_name);
self.sec_range   := if(le.sec_range   = '',le.appnd_sec_range  ,le.sec_range);
self.st 	     := if(le.st          = '',le.appnd_st         ,le.st);
self.z5 	     := if(le.z5          = '',le.appnd_z5         ,le.z5);

self.book_neighborhood_code := '';
self.v_predir := '';
self.v_prim_name :='';
self.v_suffix := '';
self.v_postdir :='';
self.see_also_text := le.special_listing_txt;
self := le;
end;

p_infile := project(infile,slim(left));

Gong_v2.mac_apply_legal(p_infile,outlegal);
currRecords:= outlegal: persist(Gong_v2.thor_cluster+'persist::gongv2::current_mac_apply_legal')
;

export proc_roxie_keybuild_prep_current := currRecords; // Active Gong records