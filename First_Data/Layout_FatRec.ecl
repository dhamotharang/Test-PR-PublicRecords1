import infutor;

export Layout_FatRec := record
 infutor.Layout_DID;

 integer2  did_ct                 := 0;
 
 data10    addr_id;
 unsigned6 hhid                   := 0;
 
 string5   census_age             :='';
 string9   census_income          :='';
 
 string20  mktg_fname             :='';
 string20  mktg_mname             :='';
 string20  mktg_lname             :='';
 string5   mktg_name_suffix       :='';
 integer4  mktg_dob               := 0;
 string8   mktg_dod               :='';
 integer4  mktg_total_records     := 0;
 unsigned3 mktg_addr_dt_last_seen := 0;
 
 string1   mktg_attempt           :='';
 
 string1   current_addr_ind       :='';
 unsigned3 hdr_dt_first_seen      := 0;
 unsigned3 hdr_dt_last_seen       := 0;
end;