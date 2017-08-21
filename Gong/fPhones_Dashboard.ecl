import Phonesplus,Gong_v2,yellowpages,cellphone,risk_indicators,mdr,lib_stringlib,ut;

export fPhones_Dashboard(string filedate) := function

#workunit('name','Phones Dashboard Stats: ' + filedate)

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

pplus :=  dataset('~thor_data400::out::phonesplus_did_' + filedate, Phonesplus.layoutCommonOut, thor);

gong_ :=  dataset('~thor_200::base::'+filedate+'::lss_master',Gong_v2.layout_gongMaster,thor)(current_record_flag = 'Y');

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
 self.vendor_desc     := case(le.vendor,
                              '01' => 'CELL - KROLL',
					          '02' => 'CELL - TRAFFIX',
					          '05' => 'CELL - NEXTONES',
					          'HD' => 'HEADER',
					          'IN' => 'INTRADO',
					          'GH' => 'GONG HISTORY',
					          'PC' => 'PCONSUMER',
					          'WP' => 'WHITE PAGES',
					          'IF' => 'INFUTOR',
					          'EX' => 'EXPERIAN WP',
					          '??');
					 
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

p1 := distribute(project(p0_out,t1(left)),hash(cellphone2));
p1_uniques := dedup(sort(p1(cellphone2 <> ''),cellphone2,-confidencescore,local), cellphone2,local);

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

// p1_vuniques := dedup(sort(p1(cellphone2 <> ''),cellphone2,vendor,-vendor_thresh), vendor,cellphone2);
// ut.mac_field_count(p1_uniques,p1_uniques.vendor_desc,             'PPlus_by_Vendor_Unique',                 true, true, output1a,true);
// ut.mac_field_count(p1_uniques,p1_uniques.vendor_thresh,           'PPlus_by_Vendor_Threshold_Unique',       false,true, output2a,true);
ut.mac_field_count(p1,p1.vendor_desc,             'PPlus_by_Vendor',                 true, true, output1,true);
ut.mac_field_count(p1,p1.vendor_thresh,           'PPlus_by_Vendor_Threshold',       false,true, output2,true);

// p1_vuniques := dedup(sort(p1(cellphone2 <> ''),cellphone2,vendor_srcdesc,-vendor_srcdesc_thresh), vendor_srcdesc,cellphone2);
ut.mac_field_count(p1,p1.vendor_srcdesc,          'PPlus_by_Vendor_Source',          false,true, output3,true);
ut.mac_field_count(p1,p1.vendor_srcdesc_thresh,   'PPlus_by_Vendor_Source_Threshold_Unique',false,true, output4,true);

ut.mac_field_count(p1,p1.state,                   'PPlus_by_StateOrigin',            false,true, output5,true);
ut.mac_field_count(p1,p1.state_thresh,            'PPlus_by_StateOrigin_Threshold_Unique',  false,true, output6,true);

ut.mac_field_count(p1_uniques,p1_uniques.above_threshold,         'PPlus_Above_Threshold_Unique',           true, true, output7,true);
// ut.mac_field_count(p1_uniques,p1_uniques.above_threshold,         'PPlus_Above_Threshold',           true, true, output7a,true);

ut.mac_field_count(p1_uniques,p1_uniques.phonetype,               'PPlus_by_PhoneType',              true, true, output8,true);
ut.mac_field_count(p1_uniques,p1_uniques.phonetype_thresh,        'PPlus_by_PhoneType_Threshold',    true, true, output9,true);

ut.mac_field_count(p1,p1_uniques.phonetype_vendor_srcdesc,'PPlus_by_PhoneType_Vendor_Source_Unique',false,true,output10,true);

ut.mac_field_count(p2,p2.st,                      'Gong_By_StateOrigin',             false,true,output11,true);
p2_up := dedup(p2(phone10 <> ''), phone10,st, all);
ut.mac_field_count(p2_up,p2_up.st,                      'Gong_By_StateOrigin_unique',             false,true,output11a,true);

pplus_other_stats := parallel(
ut.fn_AddStat(0, 'Build Stats: ' + workunit),
ut.fn_AddStat(count(p1), 'Build Stats PPlus: Records'),
//ut.fn_AddStat(count(p1(homephone<>'')), 'Build Stats PPlus: Recs With HomePhone'),
ut.fn_AddStat(count(p1(cellphone2<>'')), 'Build Stats PPlus: Records With CellPhone'),
//ut.fn_AddStat(count(dedup(p1(homephone<>''),homephone,all)), 'Build Stats PPlus: Unique HomePhone\'s'),
ut.fn_AddStat(count(dedup(p1(cellphone2<>''),cellphone2,all)), 'Build Stats PPlus: Unique CellPhone\'s'),
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
ut.fn_AddStat((unsigned4)filedate, 'Build Stats: Stats AsOf Date')
);

todo := 
		sequential(
		parallel(output1,output2,output3,output4,output5,output6,output7,output8,output9,output10,output11,pplus_other_stats,gong_other_stats,general_stats)
		,notify('dashboard2','dashboard2'))
		;

return todo;
end;