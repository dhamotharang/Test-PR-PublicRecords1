/*
Must start with a seleid that exists in the final header file. 
The optional unsigned6 lgid3_in=0 part need to double check!
*/

import STD,BIPV2,BIPV2_LGID3,BIPV2_Files,BIPV2_FindLinks,BizlinkFull,BIPV2_BlockLink;

EXPORT Hist_OneSele(unsigned6 seleid_in, string version_in='20160722',unsigned6 lgid3_in=0) := function //seleid_in=159730
shared  unifyRec:=RECORD
  integer2 thresholdVal;
	string20 version;
	string20 iternumber;
	integer2 conf;
	unsigned6 lgid31;
	unsigned6 lgid32;
	integer2 conf_prop;
	unsigned6 rcid1;
	unsigned6 rcid2;
	string34 left_sbfe_id;
	integer2 sbfe_id_score;
	string34 right_sbfe_id;
	integer2 lgid3ifhrchy_score;
	
	string9 left_active_duns_number; //1
	string9 right_active_duns_number;
	integer2 active_duns_number_score;
	
	string500 left_company_name; //2
	string500 right_company_name;
	integer2 company_name_score;
	
	string9 left_duns_number;//3
	string9 right_duns_number;
	integer2 duns_number_score;
	
	string40 left_duns_number_concept;
	string40 right_duns_number_concept;
	integer2 duns_number_concept_score;//4
	
	string9 left_company_fein;//5
	string9 right_company_fein;
	integer2 company_fein_score;
	
	string32 left_company_charter_number;//6
	string32 right_company_charter_number;
	integer2 company_charter_number_score;
	
	string30 left_cnp_number;//7
	string30 right_cnp_number;
	integer2 cnp_number_score;
	
	string2 left_company_inc_state;//8
	string2 right_company_inc_state;
	integer2 company_inc_state_score;
	
	string10 left_cnp_btype;//9
	string10 right_cnp_btype;
	integer2 cnp_btype_score;
	integer2 proxCntInLgid3;
END;

shared the_base:=RECORD
	 string20 version;
	 string20 iternumber;
	 unsigned6 lgid3_after;
	 unsigned6 lgid3_before;
	 unsigned6 seleid_before;
	 unsigned6 seleid_after;
	END;
	
//shared ds_new:=dataset('~thor_data400::bipv2_lgid3::salt_iter::20160830::it142_post',BIPV2.CommonBase.Layout,thor); //Dev test use it
//shared ds_new:=BIPV2.CommonBase.DS_BASE; //BIPV2.CommonBase.Layout
//shared ds_new1:=ds_new(seleid=seleid_in);

/*  shared	all_ids:=BizlinkFull.Process_Biz_Layouts.KeyseleidUp(seleid=seleid_in);
    shared	the_ultid:=(unsigned6)all_ids[1].ultid;
    shared	the_orgid:=(unsigned6)all_ids[1].orgid;
    shared	ds_new0:=BIPV2.Key_BH_Linking_Ids.key(ultid=the_ultid and orgid=the_orgid and seleid=seleid_in) + 	 
   						BIPV2.Key_BH_Linking_Ids.Key_hidden(ultid=the_ultid and orgid=the_orgid and seleid=seleid_in);	
*/
	 shared	ds_new0:=BIPV2_BlockLink.GetClusterOfOneSele(seleid_in);	
   shared ds_new1:=if(lgid3_in=0,ds_new0, ds_new0(lgid3=lgid3_in)); 


//only interested in leafnode or singleton sele
shared ds_new_proj0:=table(ds_new1(nodes_below=0 or nodes_total=0),{rcid,dotid,proxid,seleid,lgid3,company_name});

shared  tLGID:=project(ds_new_proj0, transform({unsigned6 lgid3}, self.lgid3:=left.lgid3));
shared  LGID0:=dedup(sort(tLGID,lgid3,skew(1.0)),lgid3); 
shared  LGID:=set(LGID0,lgid3);
 
//PayloadRcidLgid3Key: version,iternumber,lgid3_before, lgid3_after, seleid_before, seleid_after; iterNumber(init, 5,4,..,post)
//MatchSamplelgid31lgid32Key is the other key that comes from the same attribute file.	
//shared Key1:=BIPV2_LGID3_Index._ManageLgid3Indexes(
//        dataset([],BIPV2_Files.files_lgid3.Layout_LGID3),
//				dataset([],BIPV2.CommonBase.Layout),version_in).PayloadRcidLgid3Key(version=version_in);
//shared Key1:=BIPV2_FindLinks.Get_Key(version_in).PayloadRcidLgid3Key(version=version_in);
shared Key1:=BIPV2_FindLinks.Get_Key.PayloadRcidLgid3Key(version=version_in);

/* shared ProjKey1:=project(Key1,transform({string6 iternumber}, self.iternumber:=left.iternumber));
   shared ProjKey1_ded:=dedup(ProjKey1, iternumber, all);
   shared ProjKey1_set:=set(ProjKey1_ded, iternumber);				
   shared K1:=table(Key1,{iternumber});
   shared K2:=dedup(sort(K1,iternumber,skew(1.0)),iternumber);
   shared K3:=K2(iternumber not in ['init','post'] and STD.Str.StartsWith(iternumber,'P')=false and STD.Str.StartsWith(iternumber,'I')=false);
   shared K4:=project(K3,transform({integer iternumber}, self.iternumber:=(integer)left.iternumber));
   shared K5:=max(K4,iternumber);	
*/

shared Key1_ds :=dataset(BIPV2_Findlinks.DS_Version_IterNumber.superfile_lgid3, BIPV2_Findlinks.DS_Version_IterNumber.VersionIterNumLGID3_rec,flat);
shared ProjKey1:=project(Key1_ds(version=version_in),transform({string20 iternumber}, self.iternumber:=left.iternumber));
shared ProjKey1_set:=set(ProjKey1, iternumber);
shared K3:=ProjKey1(STD.Str.StartsWith(iternumber,'P')=false and STD.Str.StartsWith(iternumber,'I')=false);
shared K4:=project(K3,transform({integer iternumber}, self.iternumber:=(integer)left.iternumber));
shared K5:=max(K4,iternumber);	

//The following use the hardcoded iteration numbers:
	
shared 	iter15_n:=(string20)K5;
shared 	iter14_n:=(string20)(K5-1);
shared 	iter13_n:=(string20)(K5-2);//start of mj6
shared 	iter12_n:=(string20)(K5-3);
shared 	iter11_n:=(string20)(K5-4);//end of mj6
shared 	iter10_n:=(string20)(K5-5);
shared 	iter9_n:=(string20)(K5-6);

shared 	iter8_n:=(string20)(K5-7);
shared 	iter7_n:=(string20)(K5-8);
shared 	iter6_n:=(string20)(K5-9);
shared 	iter5_n:=(string20)(K5-10);
shared 	iter4_n:=(string20)(K5-11);
shared 	iter3_n:=(string20)(K5-12);
shared 	iter2_n:=(string20)(K5-13);
shared 	iter1_n:=(string20)(K5-14);
	
shared   A15:=	Key1(iterNumber=iter15_n and lgid3_after in LGID); //changed pairs
shared 	d15:=dataset(LGID,{unsigned6 lgid3_before});						 //make "set" LGID into "dataset" 
shared 	project15:=project(d15, transform(the_base, self.version:=version_in; //get the unchanged pairs
																	 self.iternumber:=iter15_n;
																	 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared 	lgid15_f:=A15 + project15; //put changed and unchanged pairs together; lgid15_f -- the final
shared 	set_15:=set(lgid15_f, lgid3_before);//This set will be used as the seed for A14 
	
	//-----------------------------------------------------14 below
shared 	A14:=Key1(iternumber=iter14_n and lgid3_after in set_15);
shared  	d14:=dataset(set_15,{unsigned6 lgid3_before});
shared  	project14:=project(d14, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter14_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid14_f:=A14 + project14;
shared  set_14:=set(lgid14_f, lgid3_before);

 //-----------------------------------------------------13 below
shared 	A13:=Key1(iternumber=iter13_n and lgid3_after in set_14);
shared  	d13:=dataset(set_14,{unsigned6 lgid3_before});
shared  	project13:=project(d13, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter13_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid13_f:=A13 + project13;
shared  set_13:=set(lgid13_f, lgid3_before);

 //-----------------------------------------------------12 below
shared 	A12:=Key1(iternumber=iter12_n and lgid3_after in set_13);
shared  	d12:=dataset(set_13,{unsigned6 lgid3_before});
shared  	project12:=project(d12, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter12_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
 lgid12_f:=A12 + project12;
 set_12:=set(lgid12_f, lgid3_before);

 //-----------------------------------------------------11 below
shared 	A11:=Key1(iternumber=iter11_n and lgid3_after in set_12);
shared  	d11:=dataset(set_12,{unsigned6 lgid3_before});
shared  	project11:=project(d11, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter11_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid11_f:=A11 + project11;
shared  set_11:=set(lgid11_f, lgid3_before);

 //-----------------------------------------------------10 below
shared 	A10:=Key1(iternumber=iter10_n and lgid3_after in set_11);
shared  	d10:=dataset(set_11,{unsigned6 lgid3_before});
shared  	project10:=project(d10, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter10_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid10_f:=A10 + project10;
shared  set_10:=set(lgid10_f, lgid3_before);
 
  //-----------------------------------------------------9 below
shared 	A9:=Key1(iternumber=iter9_n and lgid3_after in set_10);
shared  	d9:=dataset(set_10,{unsigned6 lgid3_before});
shared  	project9:=project(d9, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter9_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid9_f:=A9 + project9;
shared  set_9:=set(lgid9_f, lgid3_before);
 
 //-----------------------------------------------------8 below
shared 	A8:=Key1(iternumber=iter8_n and lgid3_after in set_9);
shared  	d8:=dataset(set_9,{unsigned6 lgid3_before});
shared  	project8:=project(d8, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter8_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid8_f:=A8 + project8;
shared  set_8:=set(lgid8_f, lgid3_before);
 
 //-----------------------------------------------------7 below
shared 	A7:=Key1(iternumber=iter7_n and lgid3_after in set_8);
shared  	d7:=dataset(set_8,{unsigned6 lgid3_before});
shared  	project7:=project(d7, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter7_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid7_f:=A7 + project7;
shared  set_7:=set(lgid7_f, lgid3_before);
 
  //-----------------------------------------------------6 below
shared 	A6:=Key1(iternumber=iter6_n and lgid3_after in set_7);
shared  	d6:=dataset(set_7,{unsigned6 lgid3_before});
shared  	project6:=project(d6, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter6_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid6_f:=A6 + project6;
shared  set_6:=set(lgid6_f, lgid3_before);
 
  //-----------------------------------------------------5 below
shared 	A5:=Key1(iternumber=iter5_n and lgid3_after in set_6);
shared  	d5:=dataset(set_6,{unsigned6 lgid3_before});
shared  	project5:=project(d5, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter5_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid5_f:=A5 + project5;
shared  set_5:=set(lgid5_f, lgid3_before);
 
  //-----------------------------------------------------4 below
shared 	A4:=Key1(iternumber=iter4_n and lgid3_after in set_5);
shared  	d4:=dataset(set_5,{unsigned6 lgid3_before});
shared  	project4:=project(d4, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter4_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid4_f:=A4 + project4;
shared  set_4:=set(lgid4_f, lgid3_before); 
 
  //-----------------------------------------------------3 below
shared 	A3:=Key1(iternumber=iter3_n and lgid3_after in set_4);
shared  	d3:=dataset(set_4,{unsigned6 lgid3_before});
shared  	project3:=project(d3, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter3_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid3_f:=A3 + project3;
shared  set_3:=set(lgid3_f, lgid3_before); 
 
 //-----------------------------------------------------2 below
shared 	A2:=Key1(iternumber=iter2_n and lgid3_after in set_3);
shared  	d2:=dataset(set_3,{unsigned6 lgid3_before});
shared  	project2:=project(d2, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter2_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid2_f:=A2 + project2;
shared  set_2:=set(lgid2_f, lgid3_before);
 
 //-----------------------------------------------------1 below
shared 	A1:=Key1(iternumber=iter1_n and lgid3_after in set_2);
shared 	d1:=dataset(set_2,{unsigned6 lgid3_before});
shared  	project1:=project(d1, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=iter1_n;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid1_f:=A1 + project1;
shared  set_1:=set(lgid1_f, lgid3_before);

 //-----------------------------------------------------init below
shared II0:='I'+version_in; 
shared 	A0:=Key1(iternumber =II0 and lgid3_after in set_1);
shared 	d0:=dataset(set_1,{unsigned6 lgid3_before});
shared  	project0:=project(d0, transform(the_base,self.version:=version_in; 
																	 self.iternumber:=II0;
	                                 self.lgid3_before:=left.lgid3_before;
																	 self.lgid3_after:=left.lgid3_before;self:=[]));
shared  lgid0_f:=A0 + project0;
shared  set_0:=set(lgid0_f, lgid3_before);

shared  lgid3Change00:=   lgid0_f + lgid1_f + lgid2_f + lgid3_f + lgid4_f + lgid5_f
							 + lgid6_f + lgid7_f + lgid8_f + lgid9_f + lgid10_f+ lgid11_f
							 + lgid12_f+ lgid13_f+ lgid14_f+ lgid15_f;
shared lgid3Change0 :=lgid3Change00(iternumber in ProjKey1_set); 
shared lgid3Change :=lgid3Change0 - lgid3Change0(iternumber=II0 and lgid3_before=lgid3_after);
//output(lgid3Change,named('lgid3Change'));

//shared Key2:=BIPV2_LGID3_Index._ManageLgid3Indexes(dataset([],BIPV2_Files.files_lgid3.Layout_LGID3),
//				dataset([],BIPV2.CommonBase.Layout),version_in).MatchSamplelgid31lgid32Key;//(version=version_in);
//shared Key2:=BIPV2_FindLinks.Get_Key.MatchSamplelgid31lgid32Key(version=version_in);
  shared Key2:=BIPV2_FindLinks.Get_Key.MatchSamplelgid31lgid32Key;

shared Join1:=join(lgid3Change, Key2, left.version=right.version and left.iternumber=right.iternumber and  //getting scores
								 left.lgid3_before=right.lgid31 and left.lgid3_after=right.lgid32 and right.version=version_in,
				transform(unifyRec,self:=left; self.lgid31:=left.lgid3_before; self.lgid32:=left.lgid3_after;
								  self.thresholdVal:=BIPV2_LGID3.Config.MatchThreshold;
									self:=if(left.version=right.version and left.iternumber=right.iternumber and
								 left.lgid3_before=right.lgid31 and left.lgid3_after=right.lgid32 and right.version=version_in,right);
								 self:=[]),left outer);
shared J0:=project(Join1(rcid1=0),transform(unifyRec,self:=left;self:=[]));

shared Join3:=join(Join1(rcid1>0),ds_new1, left.rcid1=right.rcid,transform(unifyRec, //
							self.left_active_duns_number :=right.active_duns_number;
							self.left_company_name :=right.company_name;
							self.left_duns_number :=right.duns_number; 
							self.left_duns_number_concept :='active_duns_number:duns_number';
							self.left_company_fein :=right.company_fein;
							self.left_company_charter_number :=right.company_charter_number;
							self.left_cnp_number :=right.cnp_number;	
							self.left_company_inc_state :=right.company_inc_state;							
							self.left_cnp_btype :=right.cnp_btype;
							self:=left;
							));

shared 	Join4:=join(Join3,ds_new1, left.rcid2=right.rcid,transform(unifyRec,
							self.right_active_duns_number :=right.active_duns_number;
							self.right_company_name :=right.company_name;
							self.right_duns_number :=right.duns_number; 
							self.right_duns_number_concept :='active_duns_number:duns_number';
							self.right_company_fein :=right.company_fein;
							self.right_company_charter_number :=right.company_charter_number;
							self.right_cnp_number :=right.cnp_number;	
							self.right_company_inc_state :=right.company_inc_state;							
							self.right_cnp_btype :=right.cnp_btype;
							self:=left;
							));	

//get useful info of the sele based on the evolution
//1 about simplified tree and record count in each proxid; record count in each dotid, record count in each lgid3
shared P_dot :=project(ds_new_proj0, transform({unsigned6 dotid}, self.dotid:=left.dotid));
shared P_prox:=project(ds_new_proj0, transform({unsigned6 proxid}, self.proxid:=left.proxid));
shared P_lgid:=project(ds_new_proj0, transform({unsigned6 lgid3}, self.lgid3:=left.lgid3));
shared recordsInDot:=table(P_dot, {dotid, integer CntRecordsInDot:=count(group)}, dotid);
shared recordsInProx:=table(P_prox, {proxid, integer CntRecordsInProx:=count(group)}, proxid);
shared recordsInLgid:=table(P_lgid, {lgid3, integer CntRecordsInLgid:=count(group)}, lgid3);

shared rcid_set1:=set(Join4,rcid1);
shared rcid_set2:=set(Join4,rcid2);
shared rcidSet :=rcid_set1 + rcid_set2;

shared ds_keep:= ds_new_proj0(rcid in rcidSet);
shared ds_keep_dot:= dedup(ds_keep, dotid,all);
shared ds_keep_dot_set:=set(ds_keep_dot,dotid);

shared ds_new_proj1:=dedup(ds_new_proj0,dotid,all);
shared tree_records:=ds_new_proj1(dotid not in ds_keep_dot_set) + ds_keep;

shared addrecordsInDot:=join(tree_records, recordsInDot, left.dotid=right.dotid, 
									transform({recordof(left), integer CntRecordsInDot}, self:=left; self.CntRecordsInDot:=right.CntRecordsInDot));
shared addrecordsInProx:=join(addrecordsInDot,recordsInProx, left.proxid=right.proxid,
									transform({recordof(left), integer CntRecordsInProx}, self:=left; self.CntRecordsInProx:=right.CntRecordsInProx));
shared addrecordsInLgid:=join(addrecordsInProx,recordsInLgid, left.lgid3=right.lgid3,
									transform({recordof(left), integer CntRecordsInLgid}, self:=left; self.CntRecordsInLgid:=right.CntRecordsInLgid));
shared FinalTree:=addrecordsInLgid;	
output(FinalTree, named('RawDataDedupedSingleSeleId'));		
output(count(ds_new_proj0),named('TotalRecordsInSele'));		

//2 during the collapse, each lgid3 contains how many proxid?			
shared JoinRet:= Join4 + J0;  			//use PayloadInitLgid3ProxKey {version,lgid3},proxid}

//We may need to consider to simplify the computation below. First project to get a smaller set and do the calc in the smaller set?????????????
shared smallRec:=RECORD
	string20 version;
	string20 iternumber;
	unsigned6 lgid31;
	unsigned6 lgid32;
	integer2 proxCntInLgid3;
END;
shared projJoinRet:=project(JoinRet, transform(smallRec, self:=left));

//shared Key3:=	BIPV2_LGID3_Index._ManageLgid3Indexes(dataset([],BIPV2_Files.files_lgid3.Layout_LGID3),
//				dataset([],BIPV2.CommonBase.Layout),version_in).PayloadInitLgid3ProxKey;
//shared Key3:=	BIPV2_FindLinks.Get_Key(version_in).PayloadInitLgid3ProxKey;
shared Key3:=	BIPV2_FindLinks.Get_Key.PayloadInitLgid3ProxKey(version=version_in);
//--0				
shared Key3_0:=Key3(version=version_in and lgid3 in set_0);

shared CountProxInLgid3_0:=table(Key3_0,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt0:=join(projJoinRet, CountProxInLgid3_0, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=II0,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=II0,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM0:=cnt0;					
shared sum0:=table(MM0, {lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);//?????????
//output(CountProxInLgid3_0, named('CountProxInLgid3_0'));
//output(cnt0, named('cnt0'));
//output(MM0, named('MM0'));
//output(sum0, named('sum0'));

//--1
shared Key3_1:=Key3(version=version_in and lgid3 in set_1);
shared CountProxInLgid3_1:=table(Key3_1,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt1:=join(projJoinRet, CountProxInLgid3_1, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter1_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter1_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM1:=join(cnt1,sum0, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum1:=table(MM1,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

 //--2
shared Key3_2:=Key3(version=version_in and lgid3 in set_2);
shared CountProxInLgid3_2:=table(Key3_2,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt2:=join(projJoinRet, CountProxInLgid3_2, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter2_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter2_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM2:=join(cnt2,sum1, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum2:=table(MM2,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

 //--3
shared Key3_3:=Key3(version=version_in and lgid3 in set_3);
shared CountProxInLgid3_3:=table(Key3_3,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt3:=join(projJoinRet, CountProxInLgid3_3, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter3_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter3_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM3:=join(cnt3,sum2, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum3:=table(MM3,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

 //--4
shared Key3_4:=Key3(version=version_in and lgid3 in set_4);
shared CountProxInLgid3_4:=table(Key3_4,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt4:=join(projJoinRet, CountProxInLgid3_4, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter4_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter4_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM4:=join(cnt4,sum3, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum4:=table(MM4,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

 //--5
shared Key3_5:=Key3(version=version_in and lgid3 in set_5);
shared CountProxInLgid3_5:=table(Key3_5,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt5:=join(projJoinRet, CountProxInLgid3_5, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter5_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter5_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM5:=join(cnt5,sum4, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum5:=table(MM5,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

 //--6
shared Key3_6:=Key3(version=version_in and lgid3 in set_6);
shared CountProxInLgid3_6:=table(Key3_6,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt6:=join(projJoinRet, CountProxInLgid3_6, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter6_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter6_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM6:=join(cnt6,sum5, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum6:=table(MM6,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);
 //--7
shared Key3_7:=Key3(version=version_in and lgid3 in set_7);
shared CountProxInLgid3_7:=table(Key3_7,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt7:=join(projJoinRet, CountProxInLgid3_7, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter7_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter7_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM7:=join(cnt7,sum6, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum7:=table(MM7,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);
 //--8
shared Key3_8:=Key3(version=version_in and lgid3 in set_8);
shared CountProxInLgid3_8:=table(Key3_8,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt8:=join(projJoinRet, CountProxInLgid3_8, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter8_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter8_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM8:=join(cnt8,sum7, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum8:=table(MM8,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);
 //--9
shared Key3_9:=Key3(version=version_in and lgid3 in set_9);
shared CountProxInLgid3_9:=table(Key3_9,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt9:=join(projJoinRet, CountProxInLgid3_9, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter9_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter9_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM9:=join(cnt9,sum8, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum9:=table(MM9,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);
 //--10
shared Key3_10:=Key3(version=version_in and lgid3 in set_10);
shared CountProxInLgid3_10:=table(Key3_10,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt10:=join(projJoinRet, CountProxInLgid3_10, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter10_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter10_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM10:=join(cnt10,sum9, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum10:=table(MM10,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);
 //--11
shared Key3_11:=Key3(version=version_in and lgid3 in set_11);
shared CountProxInLgid3_11:=table(Key3_11,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt11:=join(projJoinRet, CountProxInLgid3_11, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter11_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter11_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM11:=join(cnt11,sum10, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum11:=table(MM11,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

//--12
shared Key3_12:=Key3(version=version_in and lgid3 in set_12);
shared CountProxInLgid3_12:=table(Key3_12,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt12:=join(projJoinRet, CountProxInLgid3_12, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter12_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter12_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM12:=join(cnt12,sum11, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum12:=table(MM12,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

//--13
shared Key3_13:=Key3(version=version_in and lgid3 in set_13);
shared CountProxInLgid3_13:=table(Key3_13,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt13:=join(projJoinRet, CountProxInLgid3_13, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter13_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter13_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM13:=join(cnt13,sum12, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum13:=table(MM13,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

//--14
shared Key3_14:=Key3(version=version_in and lgid3 in set_14);
shared CountProxInLgid3_14:=table(Key3_14,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt14:=join(projJoinRet, CountProxInLgid3_14, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter14_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter14_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM14:=join(cnt14,sum13, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum14:=table(MM14,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

//--15
shared Key3_15:=Key3(version=version_in and lgid3 in set_15);
shared CountProxInLgid3_15:=table(Key3_15,{lgid3, integer proxCntInLgid3:=count(group)}, lgid3);

shared cnt15:=join(projJoinRet, CountProxInLgid3_15, left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter15_n,
	      transform(smallRec,
				  self.proxCntInLgid3:=if(left.lgid31=right.lgid3 and left.version=version_in and left.iternumber=iter15_n,right.proxCntInLgid3, left.proxCntInLgid3);
					self:=left)); //, left outer);
shared MM15:=join(cnt15,sum14, left.lgid31=right.lgid32, transform(smallRec, 
												self.proxCntInLgid3:=if(left.lgid31=right.lgid32, right.proxCntInLgid3,left.proxCntInLgid3);	
												self:=left), left outer);
shared sum15:=table(MM15,{lgid32, integer proxCntInLgid3:=sum(group,proxCntInLgid3)},lgid32);

shared MM:=MM0+MM1+MM2+MM3+MM4+MM5+MM6+MM7+MM8+MM9+MM10+MM11+MM12+MM13+MM14+MM15;

shared FinalRet:=join(JoinRet, MM, left.version=right.version and left.iternumber=right.iternumber and left.lgid31=right.lgid31 and left.lgid32=right.lgid32,
              transform(unifyRec, self:=right; self:=left));
output(FinalRet,named('MatchDetail')); 
output(FinalRet(conf>0),named('MatchDetailSimple'));
cntProxFinal:=table(FinalRet(iternumber=iter15_n),{lgid32,proxcntinlgid3});
output(cntProxFinal,named('cntProxFinal'));		
return FinalRet(conf>0);										
end	;							 