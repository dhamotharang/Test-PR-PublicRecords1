EXPORT compid__compid__layout_compid := RECORD
   string28 last_name;
   string20 first_name;
   string15 middle_name;
   string3 suffix;
   string6 dob;
   string9 ssn;
   string1 gender;
   string5 zip_code;
   string40 address_1;
   string11 address_2;
   string20 city;
   string2 state;
   string4 zip4;
   string1 dod_ind;
   string4 dod;
   string20 license_number;
   string10 license_type;
   string1 commercial_drivers_license_indicator;
   string15 license_restrictions;
   string2 license_state;
   string6 license_issue_date;
   string6 license_expiration_date;
   string2 original_state;
   string9 original_isn;
   string1 crlf;
  END;

EXPORT watchdog__layout_best := RECORD
   unsigned integer6 did;
   qstring10 phone;
   qstring9 ssn;
   integer4 dob;
   qstring5 title;
   qstring20 fname;
   qstring20 mname;
   qstring20 lname;
   qstring5 name_suffix;
   qstring10 prim_range;
   string2 predir;
   qstring28 prim_name;
   qstring4 suffix;
   string2 postdir;
   qstring10 unit_desig;
   qstring8 sec_range;
   qstring25 city_name;
   string2 st;
   qstring5 zip;
   qstring4 zip4;
   unsigned integer3 addr_dt_last_seen;
   qstring8 dod;
   qstring17 prpty_deed_id;
   qstring22 vehicle_vehnum;
   qstring22 bkrupt_crtcode_caseno;
   integer4 main_count;
   integer4 search_count;
   qstring15 dl_number;
   qstring12 bdid;
   integer4 run_date;
   integer4 total_records;
  END;

r:=RECORD
  unsigned integer6 did;
  integer8 did_score;
  compid__compid__layout_compid compid;
  watchdog__layout_best watchdog;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 score;
  string9 clean_ssn;
  string8 clean_dob;
  string10 ind;
  qstring1 eq_best_dob;
  qstring1 neq_best_dob;
  qstring1 ln_blank_dob;
  qstring1 cp_blank_dob;
  qstring1 eq_best_ssn;
  qstring1 neq_best_ssn;
  qstring1 ln_blank_ssn;
  qstring1 cp_blank_ssn;
  qstring1 eq_best_name;
  qstring1 neq_best_name;
  qstring1 ln_blank_name;
  qstring1 cp_blank_name;
  qstring1 eq_best_addr;
  qstring1 neq_best_addr;
  qstring1 ln_blank_addr;
  qstring1 cp_blank_addr;
  qstring1 eq_best_dl;
  qstring1 neq_best_dl;
  qstring1 ln_blank_dl;
  qstring1 cp_blank_dl;
 END;

sel:=['CA','NJ','NC','IN','MO','NY','FL','VA','TX','PA','IL','OH','MI','GA','WA','TN','MD','AL','NV','NE','ID','RI','SD','DE','MA','SC','KY','OR','UT','WV','WY','ND','MT','AZ','CT','KS','OK','MS','ME','DC','VT','AK','HI','WI','MN','LA','CO','IA','AR','NM','NH'];
f:=dataset('~thor_data400::out::alpharetta::compid_prep',r,flat)(trim(compid.original_isn)<>'');
d0:=project(f,transform({string11 cid,f},self.cid:=left.compid.original_isn+left.compid.original_state,self:=left));
d:=distribute(d0(did>0),hash(did))+d0(did=0);

unqsall:=dedup(sort(d(did>0),did,local),did,local);
output(count(unqsall),named('UNIQUE_ADLs'));

did_cid_uq:=table(d(did>0),{did,cid},did,cid,local);
LN_clpse:=table(did_cid_uq,{did,cnt:=count(group)},did,local)(cnt>1);
CP_clpse:=table(distribute(did_cid_uq,hash(cid)),{cid,cnt:=count(group)},cid,local)(cnt>1);

output(count(LN_clpse),named('INTERNAL_COLAPSED'));
output(count(CP_clpse),named('EXTERNAL_COLAPSED'));

rSTATS:=record
Total:=count(group)
,ADL:=sum(group,if(d.did>0,1,0))
,No_DID:=sum(group,if(d.did=0,1,0))

,Equals_Best_DOB:=sum(group,if(d.did>0 and d.EQ_BEST_DOB='Y',1,0))
,Not_Equals_Best_DOB:=sum(group,if(d.did>0 and d.nEQ_BEST_DOB='Y',1,0))
,LN_Blank_and_CP_not_Blank_DOB:=sum(group,if(d.did>0 and d.ln_Blank_dob='Y' and d.cp_Blank_dob='',1,0))
,CP_Blank_and_LN_not_Blank_DOB:=sum(group,if(d.did>0 and d.cp_Blank_dob='Y' and d.ln_Blank_dob='',1,0))
,Both_Blank_DOB:=sum(group,if(d.did>0 and d.cp_Blank_dob='Y' and d.ln_Blank_dob='Y',1,0))

,Equals_Best_SSN:=sum(group,if(d.did>0 and d.EQ_BEST_ssn='Y',1,0))
,Not_Equals_Best_SSN:=sum(group,if(d.did>0 and d.nEQ_BEST_ssn='Y',1,0))
,LN_Blank_and_CP_not_Blank_SSN:=sum(group,if(d.did>0 and d.ln_Blank_ssn='Y' and d.cp_Blank_ssn='',1,0))
,CP_Blank_and_LN_not_Blank_SSN:=sum(group,if(d.did>0 and d.cp_Blank_ssn='Y' and d.ln_Blank_ssn='',1,0))
,Both_Blank_SSN:=sum(group,if(d.did>0 and d.cp_Blank_ssn='Y' and d.ln_Blank_ssn='Y',1,0))

,Equals_Best_NAME:=sum(group,if(d.did>0 and d.EQ_BEST_name='Y',1,0))
,Not_Equals_Best_NAME:=sum(group,if(d.did>0 and d.nEQ_BEST_name='Y',1,0))
,LN_Blank_and_CP_not_Blank_NAME:=sum(group,if(d.did>0 and d.ln_Blank_name='Y' and d.cp_Blank_name='',1,0))
,CP_Blank_and_LN_not_Blank_NAME:=sum(group,if(d.did>0 and d.cp_Blank_name='Y' and d.ln_Blank_name='',1,0))
,Both_Blank_NAME:=sum(group,if(d.did>0 and d.cp_Blank_name='Y' and d.ln_Blank_name='Y',1,0))

,Equals_Best_ADDR:=sum(group,if(d.did>0 and d.EQ_BEST_addr='Y',1,0))
,Not_Equals_Best_ADDR:=sum(group,if(d.did>0 and d.nEQ_BEST_addr='Y',1,0))
,LN_Blank_and_CP_not_Blank_ADDR:=sum(group,if(d.did>0 and d.ln_Blank_addr='Y' and d.cp_Blank_addr='',1,0))
,CP_Blank_and_LN_not_Blank_ADDR:=sum(group,if(d.did>0 and d.cp_Blank_addr='Y' and d.ln_Blank_addr='',1,0))
,Both_Blank_ADDR:=sum(group,if(d.did>0 and d.cp_Blank_addr='Y' and d.ln_Blank_addr='Y',1,0))

,Equals_Best_DL:=sum(group,if(d.did>0 and d.EQ_BEST_dl='Y',1,0))
,Not_Equals_Best_DL:=sum(group,if(d.did>0 and d.nEQ_BEST_dl='Y',1,0))
,LN_Blank_and_CP_not_Blank_DL:=sum(group,if(d.did>0 and d.ln_Blank_dl='Y' and d.cp_Blank_dl='',1,0))
,CP_Blank_and_LN_not_Blank_DL:=sum(group,if(d.did>0 and d.cp_Blank_dl='Y' and d.ln_Blank_dl='',1,0))
,Both_Blank_DL:=sum(group,if(d.did>0 and d.cp_Blank_dl='Y' and d.ln_Blank_dl='Y',1,0))

,CORE			:=sum(group,if(d.did>0 and d.ind='CORE',1      ,0))
,CORE_pct		:=round((sum(group,if(d.did>0 and d.ind='CORE',1,0))/count(group,d.did>0)) * 100)
,DEAD			:=sum(group,if(d.did>0 and d.ind='DEAD',1,0))
,DEAD_pct		:=round((sum(group,if(d.did>0 and d.ind='DEAD',1,0))/count(group,d.did>0)) * 100)
,H_MERGE		:=sum(group,if(d.did>0 and d.ind='H_MERGE',1,0))
,H_MERGE_pct	:=round((sum(group,if(d.did>0 and d.ind='H_MERGE',1,0))/count(group,d.did>0)) * 100)
,INACTIVE		:=sum(group,if(d.did>0 and d.ind='INACTIVE',1,0))
,INACTIVE_pct	:=round((sum(group,if(d.did>0 and d.ind='INACTIVE',1,0))/count(group,d.did>0)) * 100)
,C_MERGE		:=sum(group,if(d.did>0 and d.ind='C_MERGE',1,0))
,C_MERGE_pct	:=round((sum(group,if(d.did>0 and d.ind='C_MERGE',1,0))/count(group,d.did>0)) * 100)
,AMBIG			:=sum(group,if(d.did>0 and d.ind='AMBIG',1,0))
,AMBIG_pct		:=round((sum(group,if(d.did>0 and d.ind='AMBIG',1,0))/count(group,d.did>0)) * 100)
,NO_SSN			:=sum(group,if(d.did>0 and d.ind='NO_SSN',1,0))
,NO_SSN_pct		:=round((sum(group,if(d.did>0 and d.ind='NO_SSN',1,0))/count(group,d.did>0)) * 100)
,NOISE			:=sum(group,if(d.did>0 and d.ind='NOISE',1,0))
,NOISE_pct		:=round((sum(group,if(d.did>0 and d.ind='NOISE',1,0))/count(group,d.did>0)) * 100)
end;
stats:=table(d,rSTATS,few);
output(stats);

// export Lift_stats := 'todo';