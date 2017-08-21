layout_src := record
header.layout_eq_src;
  unsigned6 uid;
  string2 src:= 'EQ';
  end;
  
file_eq := header.Rollup_Hist;

layout_src t_project(file_eq le):= transform
self.blank1:='';
self.name_change:='';
self.addr_change:='';
self.ssn_change:='';
self.former_name_change:='';
self.new_rec:='';
self:=le;
end;

p_file_eq := project(file_eq,t_project(left));

dist_file_eq := distribute(p_file_eq,hash(first_name,last_name,current_address,current_state,current_zip));
srt_file_eq := sort(dist_file_eq,record,local);
dedup_file_eq := dedup(srt_file_eq,record,local);

export EQFX_Hist_src := dedup_file_eq:persist('~thor_data400::persist::eqfx_hist_src');