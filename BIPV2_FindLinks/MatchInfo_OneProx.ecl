import BIPV2_ProxId,BIPV2_ProxID_mj6,salt30,BizlinkFull,BIPV2;
EXPORT MatchInfo_OneProx(unsigned6 proxid_in, string20 rcidstr = '0') := module
//shared string20 rcidstr := '12254024575';//  : stored('Basercid');
//shared string20 proxid_in := '4843500';//  : stored('BaseProxid');
shared all_ids:=BizlinkFull.Process_Biz_Layouts.KeyproxidUp(proxid=proxid_in);
shared the_ultid:=(unsigned6)all_ids[1].ultid;
shared the_orgid:=(unsigned6)all_ids[1].orgid;
shared the_seleid:=(unsigned6)all_ids[1].seleid;
shared base:=BIPV2.Key_BH_Linking_Ids.key(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in) + 	 
	BIPV2.Key_BH_Linking_Ids.Key_hidden(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in);
//shared base:=BIPV2.CommonBase.ds_built(proxid=proxid_in);

export unify_Rec:=RECORD
	boolean isMj6;
	integer2 thresholdVal;
	integer2 conf;
	integer2 conf_prop;
	unsigned6 rcid1;
	unsigned6 rcid2;
	integer2 attribute_conf;
	
	string30 left_cnp_number;
	string30 right_cnp_number;
	integer2 cnp_number_score;

	string2 left_st;
	string2 right_st;
	integer2 st_score;
	
	string10 left_prim_range;
	string10 right_prim_range;
	integer2 prim_range_score; //from rec_mj only
	
	string10 left_prim_range_derived;
	string10 right_prim_range_derived;
	integer2 prim_range_derived_score;//
	
	string9 left_hist_enterprise_number;
	string9 right_hist_enterprise_number;
	integer2 hist_enterprise_number_score;	
	
	string9 left_hist_duns_number;
	string9 right_hist_duns_number;
	integer2 hist_duns_number_score;	
	
	string30 left_unk_corp_key;
	string30 right_unk_corp_key;
	integer2 unk_corp_key_score;
	
	string9 left_ebr_file_number;
	string9 right_ebr_file_number;
	integer2 ebr_file_number_score;	
	
	string9 left_active_duns_number;
	string9 right_active_duns_number;
	integer2 active_duns_number_score;	
	
	string9 left_active_enterprise_number;
	string9 right_active_enterprise_number;
	integer2 active_enterprise_number_score;	
	
	string30 left_active_domestic_corp_key;
	string30 right_active_domestic_corp_key;
	integer2 active_domestic_corp_key_score;
	
	string30 left_hist_domestic_corp_key;
	string30 right_hist_domestic_corp_key;
	integer2 hist_domestic_corp_key_score;	
	
	string30 left_foreign_corp_key;
	string30 right_foreign_corp_key;
	integer2 foreign_corp_key_score;
	
	string9 left_company_fein;
	string9 right_company_fein;
	integer2 company_fein_score;
	
	string10 left_company_phone;
	string10 right_company_phone;
	integer2 company_phone_score;

	unsigned6 left_company_addr1;//prim_range_derived:prim_name_derived:sec_range
	unsigned6 right_company_addr1;//prim_range_derived:prim_name_derived:sec_range
	integer2 company_addr1_score;

	string500 left_cnp_name;
	string500 right_cnp_name;
	integer2 cnp_name_score;

	string left_prim_name_derived;
	string right_prim_name_derived;
	integer2 prim_name_derived_score;
	
	string8 left_sec_range;
	string8 right_sec_range;
	integer2 sec_range_score;
	
	string5 left_zip;
	string5 right_zip;
	integer2 zip_score;	
	
	unsigned6 left_company_csz; 
	unsigned6 right_company_csz; 
	integer2 company_csz_score;

	string25 left_v_city_name;
	string25 right_v_city_name;
	integer2 v_city_name_score;	

	string10 left_cnp_btype;
	string10 right_cnp_btype;
	integer2 cnp_btype_score;	
	
	string120 left_company_name;
	string120 right_company_name;
	
	unsigned6 left_company_address; 
	unsigned6 right_company_address; 
	integer2 company_address_score;
	
END;

shared BFile := BIPV2_PROXID.In_DOT_Base;
shared BIPV2_PROXID.match_candidates(BFile).layout_candidates into(BIPV2_PROXID.Keys(BFile).Candidates le) := transform
  self := le;
end;
shared odl := project(choosen(BIPV2_PROXID.Keys(BFile).Candidates(Proxid=proxid_in),10000),into(left));
shared k := BIPV2_PROXID.Keys(BFile).Specificities_Key;
shared BIPV2_PROXID.Layout_Specificities.R s_into(k le) := transform
  self := le;
end;
shared s := global(project(k,s_into(left))[1]);
shared odl_noprop := BIPV2_PROXID.Debug(BFile,s).RemoveProps(odl); // Remove propogated values

//mj part
shared Bfile_mj := BIPV2_ProxID_mj6.In_DOT_Base;
shared BIPV2_ProxID_mj6.match_candidates(Bfile_mj).layout_candidates into_mj(BIPV2_ProxID_mj6.Keys(Bfile_mj).Candidates le) := transform
  self := le;
end;
shared odl_mj := project(choosen(BIPV2_ProxID_mj6.Keys(Bfile_mj).Candidates(Proxid=proxid_in),10000),into_mj(left));
shared k_mj := BIPV2_ProxID_mj6.Keys(Bfile_mj).Specificities_Key;
shared BIPV2_ProxID_mj6.Layout_Specificities.R s_into_mj(k_mj le) := transform
  self := le;
end;
shared s_mj := global(project(k_mj,s_into_mj(left))[1]);
shared odl_mj_noprop := BIPV2_ProxID_mj6.Debug(Bfile_mj,s_mj).RemoveProps(odl_mj); // Remove propogated values

//normal part 
shared AnnotateClusterMatches_new(
			DATASET(BIPV2_ProxId.match_candidates(BFile).layout_candidates) in_data,
			salt30.UIDType BaseRecord,
			BIPV2_PROXID.Layout_Specificities.R s) := FUNCTION//Faster form when rcid known
				
	j1 := in_data(rcid = BaseRecord or BaseRecord=0);
  BIPV2_ProxId.match_candidates(BFile).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
	JJJ:=JOIN(in_data(rcid<>BaseRecord),j1,true, 
	     BIPV2_ProxId.debug(BFile,s).sample_match_join(PROJECT(LEFT,strim(LEFT)),RIGHT,),ALL);
	JJJ0:=JJJ(Conf>= BIPV2_ProxId.Config.MatchThreshold and rcid1>rcid2);	
	TTT:=table(JJJ0,{rcid1,rcid2});
	
	TTT1:=Join(TTT,base, left.rcid1=right.rcid, 
						transform({recordof(Left),unsigned6 dotid1}, self.dotid1:=right.dotid;self :=left));
	TTT2:=join(TTT1,base, left.rcid2=right.rcid, 
						transform({recordof(left), unsigned6 dotid2},self.dotid2:=right.dotid;self :=left));

	TTT3:=TTT2(dotid1 != dotid2);

	Final:=Join(JJJ0,TTT3, left.rcid1=right.rcid1 and left.rcid2=right.rcid2, transform({recordof(left)},self:=left));
  RETURN Final;
END;

//mj part
shared AnnotateClusterMatches_mj_New(DATASET(BIPV2_ProxId_mj6.match_candidates(BFile_mj).layout_candidates) in_data,
											SALT30.UIDType BaseRecord,
											BIPV2_PROXID_mj6.Layout_Specificities.R s_mj) := FUNCTION//Faster form when rcid known
							
  j1 := in_data(rcid = BaseRecord or BaseRecord=0);
  BIPV2_ProxId_mj6.match_candidates(BFile_mj).layout_candidates strim(j1 le) := TRANSFORM
    SELF := le;
  END;
	JJJ:=JOIN(in_data(rcid<>BaseRecord),j1,true, 
	     BIPV2_ProxId_mj6.debug(BFile_mj,s_mj).sample_match_join(PROJECT(LEFT,strim(LEFT)),RIGHT,),ALL);
	JJJ0:=JJJ(Conf>= BIPV2_ProxId_mj6.Config.MatchThreshold and rcid1>rcid2);	
	TTT:=table(JJJ0,{rcid1,rcid2});
	
	TTT1:=Join(TTT,base, left.rcid1=right.rcid, 
						transform({recordof(Left),unsigned6 dotid1}, self.dotid1:=right.dotid;self :=left));
	TTT2:=join(TTT1,base, left.rcid2=right.rcid, 
						transform({recordof(left), unsigned6 dotid2},self.dotid2:=right.dotid;self :=left));

	TTT3:=TTT2(dotid1 != dotid2);

	Final:=Join(JJJ0,TTT3, left.rcid1=right.rcid1 and left.rcid2=right.rcid2, transform({recordof(left)},self:=left));
  RETURN Final;
END;

shared mtchnp_new := AnnotateClusterMatches_new(odl_noprop,(unsigned)rcidstr,s);
shared mtch_new := AnnotateClusterMatches_new(odl,(unsigned)rcidstr,s);
shared all_mtch := mtchnp_new + mtch_new;
shared all_mtch_p:=project(all_mtch,transform(unify_Rec, 
																					self.isMj6 :=false;
																					self.thresholdVal :=BIPV2_ProxID.Config.MatchThreshold;
																					self.left_prim_range :='';
																					self.right_prim_range :='';
																					self.prim_range_score :=0;
																					self :=left));
export 	all_mtch_sort:=sort(all_mtch_p, -conf);

shared mtchnp_mj := AnnotateClusterMatches_mj_new(odl_mj_noprop,(unsigned)rcidstr,s_mj);
shared mtch_mj := AnnotateClusterMatches_mj_new(odl_mj,(unsigned)rcidstr,s_mj);
shared all_mtch_mj := mtchnp_mj + mtch_mj;
shared all_mtch_mj_p:=project(all_mtch_mj,transform(unify_Rec, 
																					self.isMj6 :=true;
																					self.thresholdVal :=BIPV2_ProxID_mj6.Config.MatchThreshold;
																					self.left_prim_range_derived :='';
																					self.right_prim_range_derived :='';
																					self.prim_range_derived_score :=0;
																					self.left_cnp_btype:='';
																					self.right_cnp_btype:='';
																					self.cnp_btype_score :=0;
																					self.left_company_name:='';
																					self.right_company_name:='';
																					self :=left));
export 	all_mtch_mj_sort:=sort(all_mtch_mj_p, -conf);
export all_prox_sort:= sort(all_mtch_mj_p + all_mtch_p, -conf, isMj6);
/* 																				
   output( choosen(sort(mtchnp_new,-Conf),1000),named('RecordMatches_new'));
   output( choosen(sort(mtch_new,-Conf),1000),named('RecordMatches_WithProps_new'));
   output( choosen(odl,10),named('ProxidValues'));
   output( choosen(odl_noprop,10),named('ProxidValues_NoProp'));
*/
//Todo: need to provide company_name, etc!!!!!!!!!!!!!!!!!!!!
shared R1:=Join(all_prox_sort, base, left.rcid1=right.rcid, transform({recordof(left)},
																			self.left_prim_range_derived:=right.prim_range_derived;
																			self.left_prim_range :=right.prim_range;
																			self.left_cnp_btype  :=right.cnp_btype;
																			self.left_company_name :=right.company_name;
																			self.left_prim_name_derived :=right.prim_name_derived;
																			self.left_cnp_name :=right.cnp_name;
																			self :=left));
shared R2:=join(R1,base, left.rcid2=right.rcid, transform({recordof(left)},
																			self.right_prim_range_derived:=right.prim_range_derived;
																			self.right_prim_range :=right.prim_range;
																			self.right_cnp_btype  :=right.cnp_btype;
																			self.right_company_name :=right.company_name;
																			self.right_prim_name_derived :=right.prim_name_derived;
																			self.right_cnp_name :=right.cnp_name;
																			self :=left));
export LinkDetail:=sort(R2,-conf,isMj6);																			
end;