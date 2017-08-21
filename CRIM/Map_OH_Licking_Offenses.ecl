import Crim_Common;

d 		:= Crim.File_OH_Licking_New(Defendant<>'Defendant')+crim.Map_OH_Licking_Combined;

Crim_Common.Layout_In_Court_Offenses tOHCrim(d input) := Transform

string8     fSlashedMDYtoCYMD(string pDateIn) 
:=    intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.process_date 				:= Crim_Common.Version_In_Arrest_Offenses;
self.offender_key 				:= '2J'+fSlashedMDYtoCYMD(input.casefiled)+hash(trim(input.defendant,left,right));
self.vendor 					:= '2J';
self.state_origin 				:= 'OH';
self.source_file 				:= 'OH LICKING CRIM CT';
self.off_comp 					:= trim(input.Charge_Number,left,right);
self.off_delete_flag 			:= '';
self.off_date 					:= if(fSlashedMDYtoCYMD(input.offensedate)<>'00000000',
									fSlashedMDYtoCYMD(input.offensedate),
									'');
self.arr_date 					:= '';
self.num_of_counts 				:= trim(input.charge_counts,left,right);
self.le_agency_cd 				:= '';
self.le_agency_desc 			:= '';
self.le_agency_case_number 		:= '';
self.traffic_ticket_number 		:= '';
self.traffic_dl_no 				:= '';
self.traffic_dl_st 				:= '';
self.arr_off_code 				:= '';
self.arr_off_desc_1 			:= if(trim(input.Charge_AMD_Charge,left,right)<>'' and trim(input.charge_actioncode,left,right)<>'',
									regexreplace(regexreplace('\\(|'+'\\)|'+'\\\\',trim(input.charge_actioncode,left,right),''),
									regexreplace('\\(|'+'\\)|'+'\\\\|'+'-',trim(input.charge_offensedescription,left,right),''),''),
									if(trim(input.Charge_AMD_Charge,left,right)<>'' and trim(input.charge_actioncode,left,right)='',
									trim(input.charge_offensedescription,left,right),
									''));
self.arr_off_desc_2 			:= '';
self.arr_off_type_cd 			:= '';
self.arr_off_type_desc 			:= '';
self.arr_off_lev 				:= trim(if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felony 1st|'+'FELONY 1ST',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F1',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felony 2nd|'+'FELONY 2ND',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F2',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felony 3rd|'+'FELONY 3RD',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F3',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felony 4th|'+'FELONY 4TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F4',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felony 5th|'+'FELONY 5TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F5',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdemeanor 1st|'+'MISDEMEANOR 1ST',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M1',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdemeanor 2nd|'+'MISDEMEANOR 2ND',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M2',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdemeanor 3rd|'+'MISDEMEANOR 3RD',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M3',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdemeanor 4th|'+'MISDEMEANOR 4TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M4',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdemeanor 5th|'+'MISDEMEANOR 5TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M5',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Felon|'+'FELON',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F',
									if(trim(input.Charge_AMD_Charge,left,right)<>''and
									regexfind('Misdem|'+'MISDEM',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M',
									'')))))))))))), all);
self.arr_statute 				:= '';
self.arr_statute_desc 			:= '';
self.arr_disp_date 				:= '';
self.arr_disp_code 				:= '';
self.arr_disp_desc_1 			:= '';
self.arr_disp_desc_2 			:= '';
self.pros_refer_cd 				:= '';
self.pros_refer 				:= '';
self.pros_assgn_cd 				:= '';
self.pros_assgn 				:= trim(input.prosecutor,left,right);
self.pros_chg_rej 				:= '';
self.pros_off_code 				:= '';
self.pros_off_desc_1 			:= '';
self.pros_off_desc_2 			:= '';
self.pros_off_type_cd 			:= '';
self.pros_off_type_desc 		:= '';
self.pros_off_lev 				:= '';
self.pros_act_filed 			:= '';
self.court_case_number 			:= trim(input.casenumber,left,right);
self.court_cd 					:= '';
self.court_desc 				:= '';
self.court_appeal_flag 			:= '';
self.court_final_plea 			:= if(trim(input.Charge_AMD_Charge,left,right)<>'',
									trim(input.charge_pleacode,left,right),
									'');
self.court_off_code 			:= '';
self.court_off_desc_1 			:= stringlib.stringfindreplace(regexreplace('( [A-Z])$' , regexreplace('([0-9][0-9][0-9][0-9].*)' ,if(trim(input.Charge_AMD_Charge,left,right)<>'',
									if(regexfind('-',input.Charge_AMD_Charge,0)<>'',
									input.Charge_AMD_Charge[1..stringlib.stringfind(input.Charge_AMD_Charge,'-', 1)-1],
									regexreplace(' [A-Z]$|'+' [A-Z][A-Z]$|'+'\\(|'+'\\)|'+'[0-9]+|'+'[0-9].+[0-9]+|'+'\\.',input.charge_offensedescription,'')),
									if(regexfind('-',input.charge_offensedescription,0)<>'',
									input.charge_offensedescription[1..stringlib.stringfind(input.charge_offensedescription,'-', 1)-1],
									regexreplace(' [A-Z]$|'+' [A-Z][A-Z]$|'+'\\(|'+'\\)|'+'[0-9]+|'+'[0-9].+[0-9]+|'+'\\.',input.charge_offensedescription,''))), ''), ''), 'B &', 'B & E');
self.court_off_desc_2			:= '';
self.court_off_type_cd 			:= '';
self.court_off_type_desc 		:= '';
self.court_off_lev 				:= if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felony 1st|'+'FELONY 1ST',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F1',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felony 2nd|'+'FELONY 2ND',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F2',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felony 3rd|'+'FELONY 3RD',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F3',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felony 4th|'+'FELONY 4TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F4',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felony 5th|'+'FELONY 5TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F5',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdemeanor 1st|'+'MISDEMEANOR 1ST',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M1',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdemeanor 2nd|'+'MISDEMEANOR 2ND',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M2',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdemeanor 3rd|'+'MISDEMEANOR 3RD',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M3',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdemeanor 4th|'+'MISDEMEANOR 4TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M4',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdemeanor 5th|'+'MISDEMEANOR 5TH',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M5',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Felon|'+'FELON',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'F',
									if(trim(input.Charge_AMD_Charge,left,right)=''and
									regexfind('Misdem|'+'MISDEM',trim(input.charge_degreeofoffense,left,right),0)<>'',
									'M',
									''))))))))))));								
self.court_statute 				:= trim(if(trim(input.Charge_AMD_Charge,left,right)='',
									regexreplace('\\(\\(',regexreplace('&|'+'-|'+'\\\\|'+'\\($',trim(input.Charge_ActionCode,left,right),''),'\\('),
									''), all);
self.court_additional_statutes 	:= '';
self.court_statute_desc 		:= '';
self.court_disp_date 			:= if(fSlashedMDYtoCYMD(input.dispositiondate)<>'00000000' 
									and fSlashedMDYtoCYMD(input.dispositiondate)[1..2] between '19' and '20',
									fSlashedMDYtoCYMD(input.dispositiondate),
									'');
self.court_disp_code 			:= '';
self.court_disp_desc_1	 		:= if(regexfind('UNDISPOSED',trim(input.dispositioncde,left,right),0)='',
									trim(input.dispositioncde,left,right),
									'');
self.court_disp_desc_2 			:= '';
self.sent_date 					:= '';
self.sent_jail 					:= '';
self.sent_susp_time 			:= '';
self.sent_court_cost 			:= '';
self.sent_court_fine 			:= '';
self.sent_susp_court_fine 		:= '';
self.sent_probation 			:= '';
self.sent_addl_prov_code 		:= '';
self.sent_addl_prov_desc_1 		:= '';
self.sent_addl_prov_desc_2 		:= '';
self.sent_consec 				:= '';
self.sent_agency_rec_cust_ori 	:= '';
self.sent_agency_rec_cust 		:= '';
self.appeal_date 				:= '';
self.appeal_off_disp 			:= '';
self.appeal_final_decision 		:= '';

end;

pOHCrim := project(d,tOHCrim(left))(/*offender_key = '2J200210074192333298' and */off_date + court_off_lev + court_off_desc_1 + court_off_lev <> '');

Crim_Common.Layout_In_Court_Offenses  rollupXform(Crim_Common.Layout_In_Court_Offenses  l, Crim_Common.Layout_In_Court_Offenses  r) := transform
		self.off_comp := if(r.off_comp > l.off_comp, r.off_comp, l.off_comp);
		self.num_of_counts  := if(r.num_of_counts > l.num_of_counts, r.num_of_counts, l.num_of_counts);
		self.court_statute  := if(r.court_statute > l.court_statute, r.court_statute, l.court_statute);
		self.court_disp_date  := if(r.court_disp_date > l.court_disp_date, r.court_disp_date, l.court_disp_date);
		self.court_disp_desc_1  := if(r.court_disp_date > l.court_disp_date, r.court_disp_desc_1, l.court_disp_desc_1);
		self.court_off_lev  := if(r.court_off_lev > l.court_off_lev, r.court_off_lev, l.court_off_lev);
		// self.Date_Vendor_First_Reported := if(l.Date_Vendor_First_Reported > r.Date_Vendor_First_Reported, r.Date_Vendor_First_Reported, l.Date_Vendor_First_Reported);
		// self.Date_Vendor_Last_Reported  := if(l.Date_Vendor_Last_Reported  < r.Date_Vendor_Last_Reported,  r.Date_Vendor_Last_Reported, l.Date_Vendor_Last_Reported);
		self := l;
end;

mapping_offense := rollup(sort(pOHCrim, offender_key, court_off_desc_1, court_disp_date),rollupXform(LEFT,RIGHT),RECORD,
                                except court_off_lev, EXCEPT off_comp, except num_of_counts, except court_statute, except court_disp_date, except court_disp_desc_1);


fOHOffend:= dedup(sort(distribute(mapping_offense,hash(offender_key)),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,source_file,local),
									offender_key,off_comp,court_statute,court_statute_desc,court_off_code,court_off_desc_1,local,left):
									PERSIST('~thor_dell400::persist::Crim_OH_Licking_Offenses_Clean');

export map_OH_Licking_Offenses	:= fOHOffend;
