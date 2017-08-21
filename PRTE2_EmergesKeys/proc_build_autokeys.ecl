import AutoKeyB2; 
export proc_build_autokeys:=
Module
export ccw_autokeys (string filedate) := function

Layouts.Autokey_layout_w_extra_city_field get_addrs(files.CCW_SearchFile l,unsigned1 C):=transform
	self.prim_range  := if(C=1,l.prim_range,l.mail_prim_range);
  self.predir      := if(C=1,l.predir,l.mail_predir);
  self.prim_name   := if(C=1,l.prim_name,l.mail_prim_name);
	self.suffix      := if(C=1,l.suffix,l.mail_addr_suffix);
	self.postdir     := if(C=1,l.postdir,l.mail_postdir);
	self.unit_desig  := if(C=1,l.unit_desig,l.mail_unit_desig);
  self.sec_range   := if(C=1,l.sec_range,l.mail_sec_range);
  self.p_city_name := if(C=1,l.p_city_name,l.mail_p_city_name);
  self.city_name   := if(C=1,l.city_name,l.mail_v_city_name);
	self.st          := if(C=1,l.st,l.mail_st);
	self.zip         := if(C=1,l.zip,l.mail_ace_zip);
	self.zip4        := if(C=1,l.zip4,l.mail_zip4);
	self.county      := if(C=1,l.county,l.mail_fipscounty);
	self.best_ssn    := if(C=1,l.best_ssn,'');
	self.did_out6         := (unsigned6)l.did_out;
	self:=l;
end;

norm_file_addrs := normalize(files.CCW_SearchFile,if(left.mail_prim_name='',1,2),
                              get_addrs(left,counter));

dedup_file_addrs := dedup(sort(norm_file_addrs,did_out6,record),record);

Layouts.Autokey_layout get_cities(dedup_file_addrs l,unsigned1 C):=transform
  self.city_name := if(C=1,l.p_city_name,l.city_name);
	self.best_ssn  := if(C=1,l.best_ssn,'');
	self:= l;
end;

norm_file_cities := normalize(dedup_file_addrs,if(left.p_city_name=left.city_name or 
                                                  left.city_name='',1,2),
                              get_cities(left,counter));

dedup_file_cities := dedup(sort(norm_file_cities,did_out6,record),record); 

Layouts.Autokey_layout state_xform(dedup_file_cities l,unsigned1 C):=transform
	self.prim_range  := if(C=1,l.prim_range,'');
  self.predir      := if(C=1,l.predir,'');
  self.prim_name   := if(C=1,l.prim_name,'');
	self.suffix      := if(C=1,l.suffix,'');
	self.postdir     := if(C=1,l.postdir,'');
	self.unit_desig  := if(C=1,l.unit_desig,'');
  self.sec_range   := if(C=1,l.sec_range,'');
  self.city_name   := if(C=1,l.city_name,'');
	self.st          := if(C=1,l.st,l.source_state);
	self.zip         := if(C=1,l.zip,'');
	self.zip4        := if(C=1,l.zip4,'');
	self.county      := if(C=1,l.county,'');
	self.best_ssn   := if(C=1,l.best_ssn,'');
	self:= l;
end;

norm_file_states := normalize(dedup_file_cities,if(left.res_state=left.source_state or
                                                   left.source_state='',1,2),
                              state_xform(left,counter));

dedup_file_states := dedup(sort(norm_file_states,did_out6,record),record);

b := Project(dedup_file_states, Transform( recordof(dedup_file_states) and not source_code, Self := Left));

 AutokeyB2.MAC_Build (b,
            fname,mname,lname, 
						best_ssn,
						zero,
						zero,
						prim_name,prim_range,st,city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did_out6, 
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						Constants.ak_keyname,
					  Constants.ak_logical(filedate),
						bld_auto_keys,false,
						Constants.ak_skipset,
						true,
					  constants.ak_typestr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,, Constants.ak_skipset)	 
retval :=sequential(bld_auto_keys,mymove); 
Return retval;		
end;

export hunters_autokeys (string filedate) := function

Layouts.Autokey_layout_w_extra_city_field_hunting get_addrs(files.hunters_Searchfile l,unsigned1 C):=transform
	self.prim_range  := if(C=1,l.prim_range,l.mail_prim_range);
  self.predir      := if(C=1,l.predir,l.mail_predir);
  self.prim_name   := if(C=1,l.prim_name,l.mail_prim_name);
	self.suffix      := if(C=1,l.suffix,l.mail_addr_suffix);
	self.postdir     := if(C=1,l.postdir,l.mail_postdir);
	self.unit_desig  := if(C=1,l.unit_desig,l.mail_unit_desig);
  self.sec_range   := if(C=1,l.sec_range,l.mail_sec_range);
  self.p_city_name := if(C=1,l.p_city_name,l.mail_p_city_name);
  self.city_name   := if(C=1,l.city_name,l.mail_v_city_name);
	self.st          := if(C=1,l.st,l.mail_st);
	self.zip         := if(C=1,l.zip,l.mail_ace_zip);
	self.zip4        := if(C=1,l.zip4,l.mail_zip4);
	self.county      := if(C=1,l.county,l.mail_fipscounty);
	self.best_ssn    := if(C=1,l.best_ssn,'');
	self.did         := (unsigned6)l.did_out;
	self:=l;
end;

norm_file_addrs := normalize(files.hunters_Searchfile,if(left.mail_prim_name='',1,2),
                              get_addrs(left,counter));

dedup_file_addrs := dedup(sort(norm_file_addrs,did,record),record);

Layouts.hunt_fish_out get_cities(dedup_file_addrs l,unsigned1 C):=transform
  self.city_name := if(C=1,l.p_city_name,l.city_name);
	self.best_ssn  := if(C=1,l.best_ssn,'');
	self:= l;
end;

norm_file_cities := normalize(dedup_file_addrs,if(left.p_city_name=left.city_name or 
                                                  left.city_name='',1,2),
                              get_cities(left,counter));

dedup_file_cities := dedup(sort(norm_file_cities,did,record),record); 

Layouts.hunt_fish_out state_xform(dedup_file_cities l,unsigned1 C):=transform
	self.prim_range  := if(C=1,l.prim_range,'');
  self.predir      := if(C=1,l.predir,'');
  self.prim_name   := if(C=1,l.prim_name,'');
	self.suffix      := if(C=1,l.suffix,'');
	self.postdir     := if(C=1,l.postdir,'');
	self.unit_desig  := if(C=1,l.unit_desig,'');
  self.sec_range   := if(C=1,l.sec_range,'');
  self.city_name   := if(C=1,l.city_name,'');
	self.st          := if(C=1,l.st,l.source_state);
	self.zip         := if(C=1,l.zip,'');
	self.zip4        := if(C=1,l.zip4,'');
	self.county      := if(C=1,l.county,'');
	self.best_ssn   := if(C=1,l.best_ssn,'');
	self:= l;
end;

norm_file_states := normalize(dedup_file_cities,if(left.homestate=left.source_state or
                                                   left.source_state='',1,2),
                              state_xform(left,counter));

dedup_file_states := dedup(sort(norm_file_states,did,record),record); 

AutokeyB2.MAC_Build (dedup_file_states,
            fname,mname,lname, 
						best_ssn,
						zero,
						zero,
						prim_name,prim_range,st,city_name,zip,sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,
						did,
						blank,
						zero,
						zero,
						blank,blank,blank,blank,blank,blank,
						zero,
						Constants.ak_keyname_hunting,
           	Constants.ak_logical_hunting(filedate),
						bld_auto_keys,false,
						Constants.ak_skip_set_hunting,
						true,
						constants.ak_typeStr,
						true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname_hunting, mymove,, Constants.ak_skip_set_hunting)	 
retval :=sequential(bld_auto_keys,mymove); 

Return retval;	

end;

end;