import BIPV2,BIPV2_Proxid,BIPV2_Proxid_mj6,BizlinkFull; 

EXPORT Hist_OneProx(unsigned6 proxid_in, string version_in) := function
  rec1:=Record
       string20 version;
       string6 iternumber;
       unsigned6 proxid_before;
       unsigned6 proxid_after;
      end;
	//K_prox:=BIPV2_Proxid._TraceBackKeys.PayloadProxChangeKey(version=version_in);
	//K_prox:=BIPV2_FindLinks.Get_Key(version_in).PayloadProxChangeKey;
	K_prox:=BIPV2_FindLinks.Get_Key.PayloadProxChangeKey(version=version_in);
	
	//K_proxMj6:=BIPV2_Proxid._TraceBackKeys.PayloadProxMj6ChangeKey(version=version_in);
	//K_proxMj6:=BIPV2_FindLinks.Get_Key(version_in).PayloadProxMj6ChangeKey;
	K_proxMj6:=BIPV2_FindLinks.Get_Key.PayloadProxMj6ChangeKey(version=version_in);
	
	VersionIter_Ds:=dataset(BIPV2_Findlinks.DS_Version_IterNumber.superfile, BIPV2_Findlinks.DS_Version_IterNumber.VersionIterNumber_rec,flat);
  prox_max_iter:=  (integer)max(VersionIter_Ds(version=version_in),iternumber);
		
  //I decide to hard code the iteration number, otherwise the coding will be very very complex.
  
/* 	K1:=table(K_prox,{iternumber});
   	K11:=dedup(sort(K1,iternumber,skew(1.0)),iternumber);
   	K111:=project(K11,transform({integer iternumber}, self.iternumber:=(integer)left.iternumber));
   	
   	K2:=table(K_proxMj6,{iternumber});
   	K22:=dedup(sort(K2,iternumber,skew(1.0)),iternumber);
   	K222:=project(K22,transform({integer iternumber}, self.iternumber:=(integer)left.iternumber));
   	
   	prox_max_iter:=(integer)max(K111,iternumber);
   	proxMj6_max_iter:=(integer)max(K222,iternumber);
*/
	//The following use the hardcoded iteration numbers:
	
	iter7_n:=(string)prox_max_iter;
	iter6_n:=(string)(prox_max_iter-1);
	iter5_n:=(string)(prox_max_iter-2);//start of mj6
	iter4_n:=(string)(prox_max_iter-3);
	iter3_n:=(string)(prox_max_iter-4);//end of mj6
	iter2_n:=(string)(prox_max_iter-5);
	iter1_n:=(string)(prox_max_iter-6);
	
	prox7:=K_prox(iternumber=iter7_n and proxid_after=proxid_in);
	project7:=project(prox7, transform(rec1, self.version:=left.version;
																					 self.iternumber:=left.iternumber;
																					 self.proxid_before:=left.proxid_after;
																					 self.proxid_after:=left.proxid_after));
	project7_ded:=dedup(project7,version,iternumber,proxid_before,proxid_after,all);
	prox7_f:=prox7 + project7_ded; //so that (proxid_in, proxid_in) can be included; prox7_f -- the final
	set_70:=set(prox7_f, proxid_before);
	set_7:=if(count(set_70)=0, [proxid_in], set_70);
//---finish 7 above

	prox6:=K_prox(iternumber=iter6_n and proxid_after in set_7);
 	d6:=dataset(set_7,{unsigned6 proxid_before});
 	project6:=project(d6, transform(rec1,self.version:=version_in; self.iternumber:=iter6_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
 prox6_f:=prox6 + project6;
 set_60:=set(prox6_f, proxid_before);
 set_6:=if(count(set_60)=0, [proxid_in], set_60);
//---finish 6 above; MJ6 below:

	prox5:=K_proxMj6(iternumber=iter5_n and proxid_after in set_6);
	d5:=dataset(set_6,{unsigned6 proxid_before});
 	project5:=project(d5, transform(rec1,self.version:=version_in; self.iternumber:=iter5_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
	prox5_f:=prox5 + project5;
	set_50:=set(prox5_f, proxid_before);
	set_5:=if(count(set_50)=0, [proxid_in], set_50);
//---finish 5 above
	prox4:=K_proxMj6(iternumber=iter4_n and proxid_after in set_5);
	d4:=dataset(set_5,{unsigned6 proxid_before});
 	project4:=project(d4, transform(rec1,self.version:=version_in; self.iternumber:=iter4_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
	prox4_f:=prox4 + project4;
	set_40:=set(prox4_f, proxid_before);
	set_4:=if(count(set_40)=0, [proxid_in], set_40);
//---finish 4 above
	prox3:=K_proxMj6(iternumber=iter3_n and proxid_after in set_4);
	d3:=dataset(set_4,{unsigned6 proxid_before});
 	project3:=project(d3, transform(rec1,self.version:=version_in; self.iternumber:=iter3_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
	prox3_f:=prox3 + project3;
	set_30:=set(prox3_f, proxid_before);
	set_3:=if(count(set_30)=0, [proxid_in], set_30);
//---finish 3 above; MJ6 end
	prox2:=K_prox(iternumber=iter2_n and proxid_after in set_3);
 	d2:=dataset(set_3,{unsigned6 proxid_before});
 	project2:=project(d2, transform(rec1,self.version:=version_in; self.iternumber:=iter2_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
 prox2_f:=prox2 + project2;
 set_20:=set(prox2_f, proxid_before);
 set_2:=if(count(set_20)=0, [proxid_in], set_20);
//---finish 2 above	
	prox1:=K_prox(iternumber=iter1_n and proxid_after in set_2);
 	d1:=dataset(set_2,{unsigned6 proxid_before});
 	project1:=project(d1, transform(rec1,self.version:=version_in; self.iternumber:=iter1_n;
	                                 self.proxid_before:=left.proxid_before;
																	 self.proxid_after:=left.proxid_before));
 prox1_f:=prox1 + project1;
 //set_1:=set(prox1_f, proxid_before);

proxChange:= prox7_f+prox6_f+prox5_f+prox4_f+prox3_f+prox2_f+prox1_f;
//----------------------------------------------------------------------
unifyRec:=RECORD
	boolean isMj6;
	integer2 thresholdVal;
	string20 version;
	string6 iternumber;
	integer2 conf;
	unsigned6 proxid_before;
	unsigned6 proxid_after;
	integer2 conf_prop;
	unsigned6 rcid1;
	unsigned6 rcid2;
	integer2 attribute_conf;
	string500 left_cnp_name;
	string500 right_cnp_name;
	integer2 cnp_name_score;

	string30 left_cnp_number;
	string30 right_cnp_number;
	integer2 cnp_number_score;

	string10 left_prim_range;
	string10 right_prim_range;
	integer2 prim_range_score; //from rec_mj only

	string left_prim_name_derived;
	string right_prim_name_derived;
	integer2 prim_name_derived_score;

	string2 left_st;
	string2 right_st;
	integer2 st_score;

	string5 left_zip;
	string5 right_zip;
	integer2 zip_score;

	string9 left_ebr_file_number;
	string9 right_ebr_file_number;
	integer2 ebr_file_number_score;

	string9 left_hist_duns_number;
	string9 right_hist_duns_number;
	integer2 hist_duns_number_score;

	string30 left_hist_domestic_corp_key;
	string30 right_hist_domestic_corp_key;
	integer2 hist_domestic_corp_key_score;

	string30 left_foreign_corp_key;
	string30 right_foreign_corp_key;
	integer2 foreign_corp_key_score;

	string30 left_unk_corp_key;
	string30 right_unk_corp_key;
	integer2 unk_corp_key_score;

	string10 left_company_phone;
	string10 right_company_phone;
	integer2 company_phone_score;

	string9 left_active_duns_number;
	string9 right_active_duns_number;
	integer2 active_duns_number_score;

	string30 left_active_domestic_corp_key;
	string30 right_active_domestic_corp_key;
	integer2 active_domestic_corp_key_score;

	string9 left_company_fein;
	string9 right_company_fein;
	integer2 company_fein_score;

	string9 left_active_enterprise_number;
	string9 right_active_enterprise_number;
	integer2 active_enterprise_number_score;

	string8 left_sec_range;
	string8 right_sec_range;
	integer2 sec_range_score;

	string25 left_v_city_name;
	string25 right_v_city_name;
	integer2 v_city_name_score;

	string9 left_hist_enterprise_number;
	string9 right_hist_enterprise_number;
	integer2 hist_enterprise_number_score;

	string20 left_company_csz; //v_city_name:st:zip
	string20 right_company_csz; //v_city_name:st:zip
	integer2 company_csz_score;

	string50 left_company_addr1;//prim_range_derived:prim_name_derived:sec_range
	string50 right_company_addr1;//prim_range_derived:prim_name_derived:sec_range
	integer2 company_addr1_score;

	string30 left_company_address; //company_addr1:company_csz
	string30 right_company_address; //company_addr1:company_csz
	integer2 company_address_score;

	string10 left_prim_range_derived;
	string10 right_prim_range_derived;
	integer2 prim_range_derived_score;//from rec_m only

	string10 left_cnp_btype;
	string10 right_cnp_btype;
	integer2 cnp_btype_score;//-----from rec_m only

	string120 left_company_name;//----from rec_m only
	string120 right_company_name;//----from rec_m only
END;
	
	//KP:=BIPV2_Proxid._TraceBackKeys.PayloadProxMatchScoreKey;//(version=version_in);
	KP:=BIPV2_FindLinks.Get_Key.PayloadProxMatchScoreKey;
	//KP:=BIPV2_FindLinks.Get_Key.PayloadProxMatchScoreKey(version=version_in);
	
	//KMJ6:=BIPV2_Proxid._TraceBackKeys.PayloadProxMj6MatchScoreKey;//(version=version_in);
	KMJ6:=BIPV2_FindLinks.Get_Key.PayloadProxMj6MatchScoreKey;
	//KMJ6:=BIPV2_FindLinks.Get_Key.PayloadProxMj6MatchScoreKey(version=version_in);
	
	Join1:=join(proxChange(iternumber not in [iter3_n,iter4_n,iter5_n]), KP, left.version=right.version and left.iternumber=right.iternumber and
	                     left.proxid_before=right.proxid1 and left.proxid_after=right.proxid2 and right.version=version_in,
							transform(unifyRec,self:=left;self.isMj6:=false; self.thresholdVal:=BIPV2_ProxID.Config.MatchThreshold;
							          self:=if(left.version=right.version and left.iternumber=right.iternumber and
	                     left.proxid_before=right.proxid1 and left.proxid_after=right.proxid2 and right.version=version_in,right);
											 self:=[]),left outer);
	Join2:=join(proxChange(iternumber in [iter3_n,iter4_n,iter5_n]), KMJ6, left.version=right.version and left.iternumber=right.iternumber and
	                     left.proxid_before=right.proxid1 and left.proxid_after=right.proxid2 and right.version=version_in,
							transform(unifyRec,self:=left;self.isMj6:=true;self.thresholdVal:=BIPV2_ProxID_mj6.Config.MatchThreshold;
							         self:=if(left.version=right.version and left.iternumber=right.iternumber and
	                     left.proxid_before=right.proxid1 and left.proxid_after=right.proxid2 and right.version=version_in,right);
											 self:=[]),left outer);
	J:=Join1 + Join2;
	//base:=BIPV2.CommonBase.ds_base(proxid=proxid_in);
	recrec:=RECORD
  unsigned6 rcid;
  string2 source;
  string9 ingest_status;
  unsigned6 dotid;
  unsigned6 empid;
  unsigned6 powid;
  unsigned6 proxid;
  unsigned6 seleid;
  unsigned6 lgid3;
  unsigned6 orgid;
  unsigned6 ultid;
  unsigned6 vanity_owner_did;
  unsigned8 cnt_rcid_per_dotid;
  unsigned8 cnt_dot_per_proxid;
  unsigned8 cnt_prox_per_lgid3;
  unsigned8 cnt_prox_per_powid;
  unsigned8 cnt_dot_per_empid;
  boolean has_lgid;
  boolean is_sele_level;
  boolean is_org_level;
  boolean is_ult_level;
  unsigned6 parent_proxid;
  unsigned6 sele_proxid;
  unsigned6 org_proxid;
  unsigned6 ultimate_proxid;
  unsigned2 levels_from_top;
  unsigned3 nodes_below;
  unsigned3 nodes_total;
  string1 sele_gold;
  string1 ult_seg;
  string1 org_seg;
  string1 sele_seg;
  string1 prox_seg;
  string1 pow_seg;
  string1 ult_prob;
  string1 org_prob;
  string1 sele_prob;
  string1 prox_prob;
  string1 pow_prob;
  string1 iscontact;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string1 iscorp;
  string120 company_name;
  string50 company_name_type_raw;
  string50 company_name_type_derived;
  string1 cnp_hasnumber;
  string250 cnp_name;
  string30 cnp_number;
  string10 cnp_store_number;
  string10 cnp_btype;
  string1 cnp_component_code;
  string20 cnp_lowv;
  boolean cnp_translated;
  integer4 cnp_classid;
  unsigned8 company_rawaid;
  unsigned8 company_aceaid;
  string10 prim_range;
  string10 prim_range_derived;
  string2 predir;
  string28 prim_name;
  string28 prim_name_derived;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string2 fips_state;
  string3 fips_county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string250 corp_legal_name;
  string250 dba_name;
  string9 active_duns_number;
  string9 hist_duns_number;
  string9 deleted_key;
  string9 deleted_fein;
  string9 active_enterprise_number;
  string9 hist_enterprise_number;
  string9 ebr_file_number;
  string30 active_domestic_corp_key;
  string30 hist_domestic_corp_key;
  string30 foreign_corp_key;
  string30 unk_corp_key;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  unsigned6 company_bdid;
  string50 company_address_type_raw;
  string9 company_fein;
  string1 best_fein_indicator;
  string10 company_phone;
  string1 phone_type;
  string60 company_org_structure_raw;
  unsigned4 company_incorporation_date;
  string8 company_sic_code1;
  string8 company_sic_code2;
  string8 company_sic_code3;
  string8 company_sic_code4;
  string8 company_sic_code5;
  string6 company_naics_code1;
  string6 company_naics_code2;
  string6 company_naics_code3;
  string6 company_naics_code4;
  string6 company_naics_code5;
  string6 company_ticker;
  string6 company_ticker_exchange;
  string1 company_foreign_domestic;
  string80 company_url;
  string2 company_inc_state;
  string32 company_charter_number;
  unsigned4 company_filing_date;
  unsigned4 company_status_date;
  unsigned4 company_foreign_date;
  unsigned4 event_filing_date;
  string50 company_name_status_raw;
  string50 company_status_raw;
  unsigned4 dt_first_seen_company_name;
  unsigned4 dt_last_seen_company_name;
  unsigned4 dt_first_seen_company_address;
  unsigned4 dt_last_seen_company_address;
  string34 vl_id;
  boolean current;
  unsigned8 source_record_id;
  unsigned2 phone_score;
  string9 duns_number;
  string100 source_docid;
  unsigned4 dt_first_seen_contact;
  unsigned4 dt_last_seen_contact;
  unsigned6 contact_did;
  string50 contact_type_raw;
  string50 contact_job_title_raw;
  string9 contact_ssn;
  unsigned4 contact_dob;
  string30 contact_status_raw;
  string60 contact_email;
  string30 contact_email_username;
  string30 contact_email_domain;
  string10 contact_phone;
  string1 from_hdr;
  string35 company_department;
  string50 company_address_type_derived;
  string60 company_org_structure_derived;
  string50 company_name_status_derived;
  string50 company_status_derived;
  string1 proxid_status_private;
  string1 powid_status_private;
  string1 seleid_status_private;
  string1 orgid_status_private;
  string1 ultid_status_private;
  string1 proxid_status_public;
  string1 powid_status_public;
  string1 seleid_status_public;
  string1 orgid_status_public;
  string1 ultid_status_public;
  string50 contact_type_derived;
  string50 contact_job_title_derived;
  string30 contact_status_derived;
  string1 address_type_derived;
  boolean is_vanity_name_derived;
 END;


/* 	base1:=dataset('~bipv2_proxid::base::20160722_286::data', recrec,thor);
   	base:=base1(proxid=proxid_in);
*/
	
 	all_ids:=BizlinkFull.Process_Biz_Layouts.KeyproxidUp(proxid=proxid_in);
     the_ultid:=(unsigned6)all_ids[1].ultid;
		 the_orgid:=(unsigned6)all_ids[1].orgid;
		 the_seleid:=(unsigned6)all_ids[1].seleid;
     base:=BIPV2.Key_BH_Linking_Ids.key(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in) + 	 
					BIPV2.Key_BH_Linking_Ids.Key_hidden(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in);

	 
	J0:=project(J(rcid1=0),transform(unifyRec,self:=left;self:=[]));
	
	Join3:=join(J(rcid1>0),base, left.rcid1=right.rcid,transform(unifyRec, 
							self.left_cnp_name :=right.cnp_name;
							self.left_cnp_number :=right.cnp_number;
							self.left_prim_range :=right.prim_range; //from rec_mj only
							self.left_prim_name_derived :=right.prim_name_derived;
							self.left_st :=right.st;
							self.left_zip :=right.zip;
							self.left_ebr_file_number :=right.ebr_file_number;
							self.left_hist_duns_number :=right.hist_duns_number;
							self.left_hist_domestic_corp_key :=right.hist_domestic_corp_key;
							self.left_foreign_corp_key :=right.foreign_corp_key;
							self.left_unk_corp_key :=right.unk_corp_key;
							self.left_company_phone :=right.company_phone;
							self.left_active_duns_number :=right.active_duns_number;
							self.left_active_domestic_corp_key :=right.active_domestic_corp_key;
							self.left_company_fein :=right.company_fein;
							self.left_active_enterprise_number :=right.active_enterprise_number;
							self.left_sec_range :=right.sec_range;
							self.left_v_city_name :=right.v_city_name;
							self.left_hist_enterprise_number :=right.hist_enterprise_number;
							self.left_company_csz :='v_city_name:st:zip';
							self.left_company_addr1 :='prim_range_derived:prim_name_derived:sec_range';
							self.left_company_address :='company_addr1:company_csz';
							self.left_prim_range_derived :=right.prim_range_derived;
							self.left_cnp_btype :=right.cnp_btype;
							self.left_company_name :=right.company_name;
							self:=left;
							));
	Join4:=join(Join3,base, left.rcid2=right.rcid,transform(unifyRec, 
							self.right_cnp_name :=right.cnp_name;
							self.right_cnp_number :=right.cnp_number;
							self.right_prim_range :=right.prim_range; //from rec_mj only
							self.right_prim_name_derived :=right.prim_name_derived;
							self.right_st :=right.st;
							self.right_zip :=right.zip;
							self.right_ebr_file_number :=right.ebr_file_number;
							self.right_hist_duns_number :=right.hist_duns_number;
							self.right_hist_domestic_corp_key :=right.hist_domestic_corp_key;
							self.right_foreign_corp_key :=right.foreign_corp_key;
							self.right_unk_corp_key :=right.unk_corp_key;
							self.right_company_phone :=right.company_phone;
							self.right_active_duns_number :=right.active_duns_number;
							self.right_active_domestic_corp_key :=right.active_domestic_corp_key;
							self.right_company_fein :=right.company_fein;
							self.right_active_enterprise_number :=right.active_enterprise_number;
							self.right_sec_range :=right.sec_range;
							self.right_v_city_name :=right.v_city_name;
							self.right_hist_enterprise_number :=right.hist_enterprise_number;
							self.right_company_csz :='v_city_name:st:zip';
							self.right_company_addr1 :='prim_range_derived:prim_name_derived:sec_range';
							self.right_company_address :='company_addr1:company_csz';
							self.right_prim_range_derived :=right.prim_range_derived;
							self.right_cnp_btype :=right.cnp_btype;
							self.right_company_name :=right.company_name;
							self:=left;
							));						
	
	baseProj:=project(base,transform({unsigned6 dotid}, self.dotid:=left.dotid));
	recordsInDot:=table(baseProj, {dotid, integer CntRecordsInDot:=count(group)}, dotid);
	
	
	
 rcid_set1:=set(Join4,rcid1);
 rcid_set2:=set(Join4,rcid2);
 rcidSet :=rcid_set1 + rcid_set2;
 
 ds_new_proj0:=table(base,{rcid,dotid,proxid,seleid,lgid3,company_name});
 ds_keep:= ds_new_proj0(rcid in rcidSet);
 
 ds_dot_remove:= dedup(ds_keep,dotid,all);
 set_dot_remove:=set(ds_dot_remove, dotid);
 
 
 ds_new_proj1:=dedup(ds_new_proj0,dotid,all);
 tree_records:=ds_new_proj1(dotid not in set_dot_remove) + ds_keep;
 
 addrecordsInDot:=join(tree_records, recordsInDot, left.dotid=right.dotid, 
									transform({recordof(left), integer CntRecordsInDot}, self:=left; self.CntRecordsInDot:=right.CntRecordsInDot));
 FinalTree:=addrecordsInDot;
 output(FinalTree, named('RawDataDedupedSingleProxId'));
 output(count(base), named('TotalRecordsInProx'));
	
FinalLinking:=Join4 + J0;
	
output(FinalLinking, named('FinalLinking'));
output(FinalLinking(conf>0), named('FinalLinkingSimple'));
	return FinalLinking(conf>0);
end;