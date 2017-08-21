import header,mdr,watchdog,ut;
 
export Best_NewMovers_Delta(string filedate) := function

prev_id := distribute(Watchdog.fn_NewMovers_dt(Watchdog.File_Previous_NewMovers_In),hash(did)) ;
curr_id := distribute(Watchdog.fn_NewMovers_dt(Watchdog.File_NewMovers_In),hash(did)) ;

Layout_NewMovers_temp := record 
string8     process_date ; 
unsigned6	did ;
string60	click_id ;
string60	click_hhid ;
string10	phone ;
string9	    ssn ;
integer4 	dob ;
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
unsigned3 	curr_dt_first_seen ;
unsigned3 	curr_dt_last_seen ;
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
unsigned3	prev_dt_first_seen;
unsigned3	prev_dt_last_seen ;
integer     addrs_check ;  
end; 

Layout_NewMovers_temp findDelta(curr_id l, prev_id r) := transform
  
   addr_check := if(l.addr_id = r.addr_id ,0,1) ;
   self.process_date := filedate ; 
   self.click_id   := if(addr_check = 0,'',l.click_id);
   self.click_hhid := if(addr_check = 0,'',l.click_hhid);
   self.did        := if(addr_check = 0,0,l.did);
   self.phone      := if(addr_check = 0,'',l.phone);
   self.ssn        := if(addr_check = 0,'',l.ssn);
   self.dob        := if(addr_check = 0,0,l.dob);
   self.title      := if(addr_check = 0,'',l.title);
   self.fname      := if(addr_check = 0,'',l.fname);
   self.mname      := if(addr_check = 0,'',l.mname);
   self.lname      := if(addr_check = 0,'',l.lname);
   self.name_suffix:= if(addr_check = 0,'',l.name_suffix);
   
   self.curr_prim_range := if(addr_check = 0,'',l.prim_range);
   self.curr_predir := if(addr_check = 0,'',l.predir);
   self.curr_prim_name := if(addr_check = 0,'',l.prim_name);
   self.curr_suffix := if(addr_check = 0,'',l.suffix);
   self.curr_postdir := if(addr_check = 0,'',l.postdir);
   self.curr_unit_desig := if(addr_check = 0,'',l.unit_desig);
   self.curr_sec_range := if(addr_check = 0,'',l.sec_range);
   self.curr_city_name := if(addr_check = 0,'',l.city_name);
   self.curr_st := if(addr_check = 0,'',l.st);
   self.curr_zip := if(addr_check = 0,'',l.zip);
   self.curr_zip4 := if(addr_check = 0,'',l.zip4);
   self.curr_dt_first_seen := if(addr_check = 0,0,l.dt_first_seen) ;
   self.curr_dt_last_seen  := if(addr_check = 0,0,l.dt_last_seen) ;
   self.prev_prim_range := if(addr_check = 0,'',r.prim_range);
   self.prev_predir := if(addr_check = 0,'',r.predir);
   self.prev_prim_name := if(addr_check = 0,'',r.prim_name);
   self.prev_suffix := if(addr_check = 0,'',r.suffix);
   self.prev_postdir := if(addr_check = 0,'',r.postdir);
   self.prev_unit_desig := if(addr_check = 0,'',r.unit_desig);
   self.prev_sec_range := if(addr_check = 0,'',r.sec_range);
   self.prev_city_name := if(addr_check = 0,'',r.city_name);
   self.prev_st := if(addr_check = 0,'',r.st);
   self.prev_zip := if(addr_check = 0,'',r.zip);
   self.prev_zip4 := if(addr_check = 0,'',r.zip4);
   self.prev_dt_first_seen := if(addr_check = 0,0,r.dt_first_seen) ;
   self.prev_dt_last_seen  := if(addr_check = 0,0,r.dt_last_seen) ;
   self.addrs_check    := if(addr_check = 0,0,1) ;
    
end;

deltas := join(curr_id,prev_id,left.did=right.did,findDelta(left,right),local);
addr_ch := deltas(addrs_check  = 1); 
addr_chf := addr_ch(trim(curr_prim_name[1..6],left,right) not in  ['POB   ','POBOX ','PO BOX','P O BOX']);

Watchdog.Layout_NewMovers  reformat( addr_chf  l) := transform 

self.did        := intformat(l.did,12,1); 
self.dist_moved := (string)ut.zip_Dist(l.prev_zip,l.curr_zip);
self.dob         := (string) l.dob ; 
self.curr_dt_first_seen :=  (string) l.curr_dt_first_seen ; 
self.curr_dt_last_seen := (string) l.curr_dt_last_seen;
self.prev_dt_first_seen  := (string) l.prev_dt_first_seen ;
self.prev_dt_last_seen := (string) l.prev_dt_last_seen; 
self := l ; 
end; 

newmovers := project(addr_chf , reformat(left)); 

NM_addr_corrf := newmovers(~(trim(curr_prim_range,left,right) = trim(prev_prim_range,left,right) and trim(dist_moved,left,right) = '0'));

return NM_addr_corrf ; 

end; 
