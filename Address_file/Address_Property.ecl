import ln_propertyv2, address;

rFaresID := record
  string12 ln_fares_id;
end;

rSearch_slim1 := record
  rFaresID;
  //Address_file.Layout_Clean_Address;
  address.Layout_Clean182;
  unsigned3 dt_last_seen;
end;

rCodes := record
  string1 assr_homestead;
  string1 assr_tax1;
  string1 assr_tax2;
  string1 assr_tax3;
  string1 assr_tax4;
  string4 assr_sluc;
  string1 assr_timeshare;
  string1 assr_owner_occupied;
  string3 deed_property_use;
  string4 deed_sluc;
  string1 deed_timeshare;
end;

rProperty_Codes := record
  rFaresID;
  //Address_file.Layout_Clean_Address;
  address.Layout_Clean182;
  rCodes;
  unsigned3 dt_last_seen;
end;

rProperty_Codes_slim := record
  //Address_file.Layout_Clean_Address;
  address.Layout_Clean182;
  rCodes;
  unsigned3 dt_last_seen;
end;

search_in    := ln_propertyv2.File_Search_DID;
search_clean := search_in(err_stat[1]='S',source_code[2]='P');

rSearch_slim1 tSlim1(search_clean l) := transform
 self.addr_suffix := l.suffix;
 self := l;
end;

search_clean_slim1 := project(search_clean,tSlim1(left));

assr := search_clean_slim1(ln_fares_id[2] ='A');
deed := search_clean_slim1(ln_fares_id[2] in ['D','M']);

assr_dist  := distribute(assr,hash(ln_fares_id));
assr_sort  := sort      (assr_dist,ln_fares_id,local);
assr_dedup := dedup     (assr_sort,ln_fares_id,local);

deed_dist  := distribute(deed,hash(ln_fares_id));
deed_sort  := sort      (deed_dist,ln_fares_id,local);
deed_dedup := dedup     (deed_sort,ln_fares_id,local);

assr_base_dist := distribute(ln_propertyv2.File_Assessment,hash(ln_fares_id))(new_record_type_code[1] not in ['L','O']);
assr_base_sort := sort      (assr_base_dist                  ,ln_fares_id,local);

deed_base_dist := distribute(ln_propertyv2.File_Deed,hash(ln_fares_id));
deed_base_sort := sort      (deed_base_dist,ln_fares_id,local);

rProperty_Codes tGetAssrCodes(assr_base_sort l, assr_dedup r) := transform
 self.assr_homestead      := if(trim(l.homestead_homeowner_exemption) in ['H','Y'],'Y','');
 self.assr_tax1           := trim(l.tax_exemption1_code);
 self.assr_tax2           := trim(l.tax_exemption2_code);
 self.assr_tax3           := trim(l.tax_exemption3_code);
 self.assr_tax4           := trim(l.tax_exemption4_code);
 self.assr_sluc           := trim(l.standardized_land_use_code);
 self.assr_timeshare      := trim(l.timeshare_code);
 self.assr_owner_occupied := if(trim(l.owner_occupied) in ['B','Y'],'Y','');
 self                     := r;
 self                     := [];
end;

d1 := join(assr_base_sort,assr_dedup,
           left.ln_fares_id=right.ln_fares_id,
		   tGetAssrCodes(left,right),local,keep(1)
		  );// : persist('~thor_dell400_2::persist::assessment_address_type_characteristics','thor_dell400_2');

rProperty_Codes tGetDeedCodes(deed_base_sort l, deed_dedup r) := transform
 self.deed_property_use := trim(l.property_use_code);
 self.deed_sluc         := trim(l.assessment_match_land_use_code);
 self.deed_timeshare    := trim(l.timeshare_flag);
 self                   := r;
 self                   := [];
end;

d2 := join(deed_base_sort,deed_dedup,
           left.ln_fares_id=right.ln_fares_id,
		   tGetDeedCodes(left,right),local,keep(1)
		  );// : persist('~thor_dell400_2::persist::deed_address_type_characteristics','thor_dell400_2');

d3 := d1+d2;

rProperty_Codes_slim tDropFaresID(d3 l) := transform
 self := l;
end;

d4       := project   (d3,tDropFaresID(left));

d4_dist  := distribute(d4,hash(prim_range,predir,prim_name,postdir,sec_range,zip,assr_homestead,assr_tax1,assr_tax2,assr_tax3,assr_tax4,assr_sluc,assr_timeshare,assr_owner_occupied,deed_property_use,deed_sluc,deed_timeshare));
d4_sort  := sort      (d4_dist,prim_range,predir,prim_name,postdir,sec_range,zip,assr_homestead,assr_tax1,assr_tax2,assr_tax3,assr_tax4,assr_sluc,assr_timeshare,assr_owner_occupied,deed_property_use,deed_sluc,deed_timeshare,-dt_last_seen,local);
d4_dedup := dedup     (d4_sort,prim_range,predir,prim_name,postdir,sec_range,zip,assr_homestead,assr_tax1,assr_tax2,assr_tax3,assr_tax4,assr_sluc,assr_timeshare,assr_owner_occupied,deed_property_use,deed_sluc,deed_timeshare,local);

rFlags := record
 string1 residential_flag;
 string1 business_flag;
 string1 government_flag;
end;

rRollup := record
 //Address_file.Layout_Clean_Address;
 address.Layout_Clean182;
 rCodes;
 rFlags;
end;

rRollup_slim := record
 //Address_file.Layout_Clean_Address;
 address.Layout_Clean182;
 rFlags;
end;

res_sluc := ['8001','8007'];
bus_sluc := ['8002','8003','8005','8008','8010','9100','9112','9202','9203','9204','9205','9206','9216'];
gov_sluc := ['8006','9200','9201','9207','9208','9210','9211','9212','9213','9214','9215','9217','9218','9219','9308'];
res_tax  := ['B'];
bus_tax  := ['C','N','R','Q'];
gov_tax  := ['G'];

rRollup tRollupInitialize(d4_dedup l) := transform

 string1 v_res_flag := if(
                          l.assr_owner_occupied<>''
                       or l.assr_homestead<>''
					   or l.assr_sluc[1]='1'
					   or l.deed_sluc[1]='1'
					   or l.assr_sluc in res_sluc
					   or l.deed_sluc in res_sluc
					   or l.assr_timeshare<>''
					   or l.deed_timeshare<>''
					   or l.deed_property_use in ['10','11','21','22','2ND','APT','MFD','RES','SFR']
					   or l.assr_tax1 in res_tax
					   or l.assr_tax2 in res_tax
					   or l.assr_tax3 in res_tax
					   or l.assr_tax4 in res_tax
					   ,'Y','');
 string1 v_bus_flag := if(
                          l.assr_sluc[1] in ['2','3','4','5','6']
                       or l.deed_sluc[1] in ['2','3','4','5','6']
					   or l.assr_sluc in bus_sluc
					   or l.deed_sluc in bus_sluc
					   or l.deed_property_use in ['20','23','24','25','26','27','28','29','50','51','52','C&I','COM','IND']
					   or l.assr_tax1 in bus_tax
					   or l.assr_tax2 in bus_tax
					   or l.assr_tax3 in bus_tax
					   or l.assr_tax4 in bus_tax
                       ,'Y','');
 string1 v_gov_flag := if(
                          l.assr_sluc in gov_sluc
                       or l.deed_sluc in gov_sluc
                       or l.assr_tax1 in gov_tax
					   or l.assr_tax2 in gov_tax
					   or l.assr_tax3 in gov_tax
					   or l.assr_tax4 in gov_tax
					   or l.deed_property_use='GOV'
                       ,'Y','');
						 
 self.residential_flag := v_res_flag;
 self.business_flag    := v_bus_flag;
 self.government_flag  := v_gov_flag;
 self := l;
end;

d5 := project(d4_dedup,tRollupInitialize(left));

rRollup tRollup(d5 l, d5 r) := transform
 self.residential_flag := if(l.residential_flag='Y','Y',r.residential_flag);
 self.business_flag    := if(l.business_flag   ='Y','Y',r.business_flag);
 self.government_flag  := if(l.government_flag ='Y','Y',r.government_flag);
 self                  := l;
end;

d6 := rollup(d5,
             (left.prim_range = right.prim_range and
			  left.prim_name  = right.prim_name and
			  left.sec_range  = right.sec_range and
			  left.zip        = right.zip),
			 tRollup(left,right)
			);

rRollup_slim tRollup_slim(d6 l) := transform
 self := l;
end;

d7 := project(d6,tRollup_slim(left));

stat_rec := record
 integer just_res            := count(group,trim(d7.residential_flag)!='' and trim(d7.business_flag) ='' and trim(d7.government_flag) ='');
 integer just_bus            := count(group,trim(d7.residential_flag) ='' and trim(d7.business_flag)!='' and trim(d7.government_flag) ='');
 integer just_gov            := count(group,trim(d7.residential_flag) ='' and trim(d7.business_flag) ='' and trim(d7.government_flag)!='');
 integer just_res_and_bus    := count(group,trim(d7.residential_flag)!='' and trim(d7.business_flag)!='' and trim(d7.government_flag) ='');
 integer just_res_and_gov    := count(group,trim(d7.residential_flag)!='' and trim(d7.business_flag) ='' and trim(d7.government_flag)!='');
 integer just_bus_and_gov    := count(group,trim(d7.residential_flag) ='' and trim(d7.business_flag)!='' and trim(d7.government_flag)!='');
 integer res_and_bus_and_gov := count(group,trim(d7.residential_flag)!='' and trim(d7.business_flag)!='' and trim(d7.government_flag)!='');
 count_                      := count(group);
end;

dPropertyStats := table(d7,stat_rec,few);
output(dPropertyStats,named('Property_Characteristic_Stats'));

address_file.Layout_address_file tMaptoAddresslayout(d7 l) := transform

 string1 bus_flag := if(l.business_flag   ='Y','B','_');
 string1 res_flag := if(l.residential_flag='Y','I','_');
 string1 gov_flag := if(l.government_flag ='Y','G','_');
 
 self.address_id   := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_property := bus_flag+res_flag+gov_flag;
 self.county       := l.county[3..5];
 self              := l;
 self              := [];
end;

export Address_Property := project(d7,tMaptoAddresslayout(left));// : persist('~thor_data400::persist::address_property','thor_dell400_2');