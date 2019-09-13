import ut,ln_tu,Data_Services,dx_header;

r0 := record
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string5 old_title;
  string20 old_fname;
  string20 old_mname;
  string20 old_lname;
  string5 old_name_suffix;
  string3 name_score;
  string182 clean;
  ln_tu.Layout_In_Header_UID_SRC;
END;

lt_as_src   := dataset(Data_Services.Data_location.prefix('person_header')+'thor_data400::base::ln_tu',r0,flat);
hdr_lt_recs := header.file_transunion_did(src='LT');

r1 := record
 unsigned6 rid;
 recordof(lt_as_src);
end;

r1 t_j1(lt_as_src le, hdr_lt_recs ri) := transform
 self.rid := ri.rid;
 self     := le;
end;

j1 := join(lt_as_src,hdr_lt_recs,
           left.orig_perm_id       = right.vendor_id  and
		   left.orig_ssn           = right.ssn        and
		   left.fname = right.fname      and
		   left.mname = right.mname      and
		   left.lname = right.lname      and
		   left.clean[1..10]       = right.prim_range and
		   left.clean[13..40]      = right.prim_name  and
		   left.clean[57..64]      = right.sec_range  and
		   left.clean[117..121]    = right.zip,
		   t_j1(left,right)
		  );
		   
dx_header.layouts.i_rid_src t_project_to_rid_srcid(j1 le) := transform
 SELF.global_sid:=0;
 SELF.record_sid:=0;
 self := le;
end;

new_lt_rid_srcid := dedup(project(j1,t_project_to_rid_srcid(left)),record);

export file_transunion_rid_srcid := new_lt_rid_srcid : persist('persist::file_transunion_rid_srcid');