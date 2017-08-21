import gong_v2,yellowpages,gong,phonesplus,cellphone,mdr,ut,risk_indicators, metadata;

other_codes := [
'  ','AE','AP','CN','GU','PR'
];

states_to_include := [
'AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL',
'GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE',
'NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI',
'SC','SD','TN','TX','UT','VA','VI','VT','WA','WI',
'WV','WY'
]+other_codes;

pplus := phonesplus.file_phonesplus_base;
gong_ := gong_v2.file_gongmaster(current_record_flag = 'Y');

r1 := record
 pplus.vendor;
 pplus.state;
 pplus.src;
 pplus.homephone;
 pplus.confidencescore;
 string   vendor_desc;
 string   src_desc                 :='';
 string   above_threshold          :='';
 string   vendor_srcdesc           :='';
 string   vendor_srcdesc_thresh    :='';
 string   state_thresh             :='';
 string   vendor_thresh            :='';
 string10 cellphone2               :='';
 string   phonetype_thresh         :='';
 string   phonetype_vendor_srcdesc :='';
end;

r1 t0(pplus le) := transform
 self.vendor_desc     := Phonesplus.Codes.vendor_name(le.vendor);
 self.cellphone2 := le.cellphone;
 self            := le;
end;
 
p0 := project(pplus,t0(left));

yellowpages.NPA_PhoneType(p0,cellphone2,phonetype,p0_out);

recordof(p0_out) t1(p0_out le) := transform

 self.phonetype                := if(le.phonetype<>'',le.phonetype,'??');
 
 self.state                    := if(le.state in states_to_include,le.state,'??');
 
 self.above_threshold          := if(le.confidencescore>=11,'TRUE','FALSE');
 self.src_desc                 := if(le.vendor='HD',stringlib.stringtouppercase(mdr.sourcetools.translatesource(le.src)),'');
 self.vendor_srcdesc           := le.vendor_desc+if(self.src_desc<>'',' - '+self.src_desc,'');
 self.vendor_srcdesc_thresh    := if(self.above_threshold='TRUE',self.vendor_srcdesc+' ABOVE',self.vendor_srcdesc+' BELOW');
 self.state_thresh             := if(self.above_threshold='TRUE',self.state         +' ABOVE',self.state         +' BELOW');
 self.vendor_thresh            := if(self.above_threshold='TRUE',le.vendor_desc     +' ABOVE',le.vendor_desc     +' BELOW');
 self.phonetype_thresh         := if(self.above_threshold='TRUE',self.phonetype     +' ABOVE',self.phonetype        +' BELOW');
 self.phonetype_vendor_srcdesc := self.phonetype+' - '+self.vendor_srcdesc;
 self                          := le;
end;

p1 := project(p0_out,t1(left));

//r2 := record
// string10 phone;
//end;

//r2 t2(p1 le, integer c) := transform
// self.phone := choose(c,le.homephone,le.cellphone2);
// self       := le;
//end;

//p2 := normalize(p1,2,t2(left,counter))(phone<>'');

r2 := record
 gong_.st;
 gong_.phone10;
 gong_.did;
 gong_.hhid;
end;

r2 t2(gong_ le) := transform
 self.st := if(le.st in states_to_include,le.st,'??');
 self    := le;
end;

p2 := project(gong_,t2(left));

ut.mac_field_count(p1,p1.vendor_desc,             'PPlus_by_Vendor',                 true, true, output1,true);
ut.mac_field_count(p1,p1.vendor_thresh,           'PPlus_by_Vendor_Threshold',       false,true, output2,true);
ut.mac_field_count(p1,p1.vendor_srcdesc,          'PPlus_by_Vendor_Source',          false,true, output3,true);
ut.mac_field_count(p1,p1.vendor_srcdesc_thresh,   'PPlus_by_Vendor_Source_Threshold',false,true, output4,true);
ut.mac_field_count(p1,p1.state,                   'PPlus_by_StateOrigin',            false,true, output5,true);
ut.mac_field_count(p1,p1.state_thresh,            'PPlus_by_StateOrigin_Threshold',  false,true, output6,true);
ut.mac_field_count(p1,p1.above_threshold,         'PPlus_Above_Threshold',           true, true, output7,true);
ut.mac_field_count(p1,p1.phonetype,               'PPlus_by_PhoneType',              true, true, output8,true);
ut.mac_field_count(p1,p1.phonetype_thresh,        'PPlus_by_PhoneType_Threshold',    true, true, output9,true);
ut.mac_field_count(p1,p1.phonetype_vendor_srcdesc,'PPlus_by_PhoneType_Vendor_Source',false,true,output10,true);

ut.mac_field_count(p2,p2.st,                      'Gong_By_StateOrigin',             false,true,output11,true);

pplus_other_stats := parallel(
ut.fn_AddStat(count(p1), 'Build Stats PPlus: Records'),
//ut.fn_AddStat(count(p1(homephone<>'')), 'Build Stats PPlus: Recs With HomePhone'),
ut.fn_AddStat(count(p1(cellphone2<>'')), 'Build Stats PPlus: Records With CellPhone'),
//ut.fn_AddStat(count(dedup(p1(homephone<>''),homephone,all)), 'Build Stats PPlus: Unique HomePhone\'s'),
//ut.fn_AddStat(count(dedup(p1(cellphone2<>''),cellphone2,all)), 'Build Stats PPlus: Unique CellPhone\'s'),
//ut.fn_AddStat(count(dedup(p2,phone,all)), 'Build Stats PPlus: Unique Phone\'s'),
ut.fn_AddStat(count(dedup(p1(cellphone2<>''),cellphone2,all)), 'Build Stats PPlus: Unique Phone\'s'),
ut.fn_AddStat(count(pplus(did>0)), 'Build Stats PPlus: Recs With ADL'),
ut.fn_AddStat(count(dedup(pplus(did>0),did,all)), 'Build Stats PPlus: Unique ADL\'s')
);

gong_other_stats := parallel(
ut.fn_AddStat(count(p2), 'Build Stats Gong: Records'),
ut.fn_AddStat(count(p2(phone10<>'')), 'Build Stats Gong: Recs With Phone'),
ut.fn_AddStat(count(dedup(p2(phone10<>''),phone10,all)), 'Build Stats Gong: Unique Phone\'s'),
ut.fn_AddStat(count(p2(did>0)), 'Build Stats Gong: Recs With ADL'),
ut.fn_AddStat(count(dedup(p2(did>0),did,all)), 'Build Stats Gong: Unique ADL\'s'),
ut.fn_AddStat(count(p2(hhid>0)), 'Build Stats Gong: Recs With HHID'),
ut.fn_AddStat(count(dedup(p2(hhid>0),hhid,all)), 'Build Stats Gong: Unique HHID\'s')
);

general_stats := parallel(
ut.fn_AddStat((unsigned4)ut.GetDate, 'Build Stats: Stats AsOf Date')
);

// ------ Stats used by Data Insight
summary_stats := metadata.Phone_Stats;

//------- Stats used by the dashboard
dashboard_stats := Phonesplus.fnPhones_Dashboard();	

export proc_build_stats := parallel(output1,output2,output3,output4,output5,output6,output7,output8,output9,output10,output11,pplus_other_stats,gong_other_stats,general_stats, summary_stats, dashboard_stats);