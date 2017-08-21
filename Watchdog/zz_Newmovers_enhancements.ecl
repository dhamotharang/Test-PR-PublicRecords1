import ut, watchdog,dma,doxie; 
reformat_date(string mystring) := function 

//want to right pad, adding 8 zeros
mystringreverse := stringlib.stringreverse(mystring);

mystringformatreverse := intformat((unsigned8)mystringreverse, 8,1);

mystringformat := stringlib.stringreverse(mystringformatreverse);

mystringout := mystringformat[1..4] + '-' + mystringformat[5..6] + '-' + mystringformat[7..8] ; 
return mystringout ;
end;

d_base := dataset('~thor_data400::base::newmovers',Watchdog.Layout_NewMovers,flat); 

temp_rec := record 
string10  process_date ; 
string12	did ;
string36	click_id ;
string38	click_hh_id ;
string10	phone ;
string5	    title ;
string20	fname ;
string20	mname ;
string20	lname ;
string5	    name_suffix ;
string10	curr_prim_range ;
string2	    curr_predir ;
string28	curr_prim_name ;
string4	    curr_suffix ;
string2	    curr_postdir;
string10	curr_unit_desig ;
string8	    curr_sec_range ;
string25	curr_city_name ;
string2	    curr_st ;
string5	    curr_zip ;
string4	    curr_zip4 ;
string10	curr_dt_first_seen ;
string10 	curr_dt_last_seen ;
string10	prev_prim_range ;
string2	    prev_predir ;
string28	prev_prim_name ;
string4	    prev_suffix ;
string2	    prev_postdir;
string10	prev_unit_desig ;
string8	    prev_sec_range ;
string25	prev_city_name ;
string2	    prev_st ;
string5	    prev_zip ;
string4	    prev_zip4 ;
string10	    prev_dt_first_seen;
string10	    prev_dt_last_seen ; 
string30    dist_moved ;
string2     crlf := '\r\n' ;
end; 
temp_rec reformat(d_base l) := transform 
self.click_id  := trim(l.click_id ,left,right); 
self.click_hh_id  := trim(l.click_hhid ,left,right); 
self.curr_dt_first_seen :=reformat_date (l.curr_dt_first_seen);
self.curr_dt_last_seen  :=reformat_date(l.curr_dt_last_seen);
self.prev_dt_first_seen :=reformat_date(l.prev_dt_first_seen);
self.prev_dt_last_seen :=reformat_date(l.prev_dt_last_seen); 
self.process_date := l.process_date[1..4] + '-' + l.process_date[5..6] + '-' + l.process_date[7..8] ;
self := l ;
end; 

reform_dt := project(d_base, reformat(left));

//Supress Do not call 

reform_dt  doJoin(reform_dt l, dma.key_DNC_Phone r) := TRANSFORM

self.phone := if(L.phone = R.phonenumber , '',L.phone); 
SELF := l;

END;

d_supp_phone:=JOIN(reform_dt, dma.key_DNC_Phone,keyed(LEFT.phone = RIGHT.phonenumber),
				   doJoin(LEFT,right),LEFT outer) ; 
				   
// Supress do not mail 


file_suppd := dedup(dma.file_suppressionMPS,prim_name,prim_range,st,p_city_name,zip,sec_range,lname,fname,all) ;

d_supp_phone  doJoin1(d_supp_phone l, file_suppd r) := TRANSFORM

boolean is_true_c := if(l.curr_prim_name = ut.StripOrdinal(r.prim_name) AND
					   l.curr_prim_range = TRIM(ut.CleanPrimRange(r.prim_range),LEFT) AND 
					   l.curr_st = r.st AND
					   doxie.Make_CityCode(l.curr_city_name) = doxie.Make_CityCode(r.p_city_name) AND 
					   l.curr_zip = r.zip AND 
					   l.curr_sec_range = r.sec_range AND 
					   l.lname = r.lname AND
					   l.fname = r.fname, true,false) ; 
					   
					   

self.curr_prim_range := if(is_true_c, '',L.curr_prim_range); 
self.curr_predir     := if(is_true_c, '',L.curr_predir);
self.curr_prim_name  := if(is_true_c, '',L.curr_prim_name); 
self.curr_suffix  :=  if(is_true_c, '',L.curr_suffix); 
self.curr_postdir := if(is_true_c, '',L.curr_postdir); 
self.curr_unit_desig :=  if(is_true_c, '',L.curr_unit_desig); 
self.curr_sec_range :=  if(is_true_c, '',L.curr_sec_range); 
self.curr_city_name := if(is_true_c, '',L.curr_city_name ); 
self.curr_st :=   if(is_true_c, '',L.curr_st); 
self.curr_zip :=  if(is_true_c, '',L.curr_zip); 
self.curr_zip4 := if(is_true_c, '',L.curr_zip4);


SELF := l;
END;

d_supp_addr := JOIN(d_supp_phone, file_suppd, 
                       left.curr_prim_name = ut.StripOrdinal(right.prim_name)  AND
					   left.curr_prim_range = TRIM(ut.CleanPrimRange(right.prim_range),LEFT)  AND 
					   left.curr_st = right.st  AND
					   doxie.Make_CityCode(left.curr_city_name) = doxie.Make_CityCode(right.p_city_name) AND 
					   left.curr_zip = right.zip   AND 
					   left.curr_sec_range = right.sec_range AND 
					   left.lname = right.lname AND
					   left.fname = right.fname ,
					   doJoin1(LEFT,right) ,left outer) ; 


d_supp_addr  doJoin2(d_supp_addr l, file_suppd r) := TRANSFORM

boolean is_true_p := if( l.prev_prim_name = ut.StripOrdinal(r.prim_name)  AND
					   l.prev_prim_range =TRIM(ut.CleanPrimRange(r.prim_range),LEFT) AND 
					   l.prev_st = r.st AND
					   doxie.Make_CityCode(l.prev_city_name) = doxie.Make_CityCode(r.p_city_name) AND 
					   l.prev_zip = r.zip AND 
					   l.prev_sec_range = r.sec_range AND 
					   l.lname = r.lname AND
					   l.fname = r.fname, true,false) ; 
					   
self.prev_prim_range := if(is_true_p, '',L.prev_prim_range);
self.prev_predir  := if(is_true_p, '',L.prev_predir);
self.prev_prim_name  := if(is_true_p, '',L.prev_prim_name);
self.prev_suffix := if(is_true_p, '',L.prev_suffix) ;
self.prev_postdir := if(is_true_p, '',L.prev_postdir);
self.prev_unit_desig := if(is_true_p, '',L.prev_unit_desig) ;
self.prev_sec_range  := if(is_true_p, '',L.prev_sec_range);
self.prev_city_name  := if(is_true_p, '',L.prev_city_name);
self.prev_st  := if(is_true_p, '',L.prev_st);
self.prev_zip := if(is_true_p, '',L.prev_zip ) ;
self.prev_zip4  := if(is_true_p, '',L.prev_zip4);

self := l; 
end; 
				   

d_out := 	 JOIN(d_supp_addr, file_suppd, 
                       left.prev_prim_name = ut.StripOrdinal(right.prim_name) AND
					   left.prev_prim_range = TRIM(ut.CleanPrimRange(right.prim_range),LEFT)  AND 
					   left.prev_st = right.st  AND
					   doxie.Make_CityCode(left.prev_city_name) = doxie.Make_CityCode(right.p_city_name) AND 
					   left.prev_zip = right.zip   AND 
					   left.prev_sec_range = right.sec_range AND 
					   left.lname = right.lname AND
					   left.fname = right.fname ,
					   doJoin2(LEFT,right) ,left outer) ; 
// Supress phone

ut.mac_suppress_by_phonetype(d_out,phone,curr_st,d_out_phone_suppressed,false);

export Newmovers_enhancements := d_out_phone_suppressed;  

