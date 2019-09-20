import BIPV2;
import BIPV2_Files;
import lib_thorlib;
import BIPV2_Build;
import dops;
import Tools;
import BIPV2_Suppression;

export ManualSuppression := module
	export inRec := record
		BIPV2.CommonBase.Layout.rcid;
	end;
	
	export inRec2 := record
		typeof(BIPV2.CommonBase.Layout.ProxID) inId;
	end;

	export slimRec := record
		unsigned6 rcid;
		string2 source;
		unsigned6 dotid;
		unsigned6 empid;
		unsigned6 powid;
		unsigned6 proxid;
		unsigned6 seleid;
		unsigned6 lgid3;
		unsigned6 orgid;
		unsigned6 ultid;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string120 company_name;
		string50 company_name_type_derived;
		string250 cnp_name;
		string30 cnp_number;
		string10 cnp_store_number;
		string10 prim_range_derived;
		string2 predir;
		string28 prim_name_derived;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 v_city_name;
		string2 st;
		string5 zip;
		string250 corp_legal_name;
		string250 dba_name;
		string9 active_duns_number;
		string9 active_enterprise_number;
		string9 hist_enterprise_number;
		string9 ebr_file_number;
		string30 active_domestic_corp_key;
		string30 foreign_corp_key;
		string30 unk_corp_key;
		string9 company_fein;
		string10 company_phone;
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
		string34 vl_id;
		string9 duns_number;
		unsigned6 contact_did;
		string9 contact_ssn;
		unsigned4 contact_dob;
		string60 contact_email;
		string30 contact_email_username;
		string30 contact_email_domain;
		string10 contact_phone;
	end;
	

	export viewSuppressionList() := function
		action1 := output(BIPV2_Files.files_suppressions().ds_suppressions, named('Internal_Linking_Suppressions'));
		action2 := output(pull(BIPV2_Files.files_suppressions().key_suppressions()), named('Append_Suppressions'));
		
		return parallel(action1,action2);
	end;
		
	export getHdrbyRcid(dataset(inRec) inDS) := function
		hdrRecs    := BIPV2.CommonBase.DS_STATIC;
		matchRidDS := join(hdrRecs,inDS,
                        left.rcid = right.rcid,
                        transform(BIPV2_Files.files_suppressions().Layout_Suppression,self := left, self := []),lookup);
		return matchRidDS;
	end;		
	
	export createLogicalFile(
	                          dataset(BIPV2_Files.files_suppressions().Layout_Suppression)     inRecs
	                         ,dataset(BIPV2_Files.files_suppressions().Layout_Suppression_Key) inKeyRecs
						,string version
					    ) := function
		newFileName := BIPV2_Files.files_suppressions().filename;
		newKeyName  := BIPV2_Files.files_suppressions().keyname(version);
		oldData     := BIPV2_Files.files_suppressions().ds_suppressions;
		oldKey      := project(pull(BIPV2_Files.files_suppressions().key_suppressions()), BIPV2_Files.files_suppressions().Layout_Suppression_Key);
		newData     := inRecs;
		newKey      := inKeyRecs;
		allData     := oldData + newData;
		allKey      := oldKey  + newKey;
		distData    := distribute(allData, hash32(rcid));
		sortedData  := sort(distData, rcid, -dt_added, local);
		dedupedData := dedup(sortedData, rcid, local);		
		dedupedKey  := dedup(allKey, rcid, all);		
		outputData  := output(dedupedData,,newFileName,named('Suppressed_Data'));
		buildKey    := build(BIPV2_Files.files_suppressions().key_suppressions(dedupedKey,newKeyName));
		
		action      := parallel(outputData, buildKey);
		return action;
	end;

	export createLogicalFileRemovedData(
	                                     dataset(BIPV2_Files.files_suppressions().Layout_Suppression)     inRecs
	                                    ,dataset(BIPV2_Files.files_suppressions().Layout_Suppression_Key) inKeyRecs
								 ,string version
								) := function
		newFileName := BIPV2_Files.files_suppressions().filename;
		newKeyName  := BIPV2_Files.files_suppressions().keyname(version);
		allData     := inRecs;
		allKeyData  := inKeyRecs;
		distData    := distribute(allData, hash32(rcid));
		sortedData  := sort(distData, rcid, -dt_added, local);
		dedupedData := dedup(sortedData, rcid, local);		
		dedupedKey  := dedup(allKeyData, rcid, all);;		
		outputData  := output(dedupedData,,newFileName,named('Suppressed_Data'));
		buildKey    := build(BIPV2_Files.files_suppressions().key_suppressions(dedupedKey,newKeyName));
		
		action      := parallel(outputData, buildKey);
		return action;
	end;
	
	export updateSuppressedSuperFile(string version) := function
			superfile   := BIPV2_Files.files_suppressions().sfFileName;
			superkey    := BIPV2_Files.files_suppressions().sfKeyName;
			logicalFile := BIPV2_Files.files_suppressions().filename;
			logicalKey  := BIPV2_Files.files_suppressions().keyname(version);
			
			promoteSuppression         := FileServices.PromoteSuperFileList([superfile], logicalFile, true);
			promoteSuppressionKey      := FileServices.PromoteSuperFileList([superkey],  logicalKey, true);
			buildEntitySupressionKey   := buildindex(BIPV2_Suppression.modSuppression.kSeleProx(version),width(1));
			promoteEntitySupressionKey := BIPV2_Suppression.CreateUpdateSuperFile.updateSuperFile(BIPV2_Suppression.FileNames.Keyseleprox,	
			                                                                       BIPV2_Suppression.FileNames.Keyseleproxfather, 
																	 BIPV2_Suppression.FileNames.KeyLogicalF(version));
			
			dopsupdate :=  dops.updateversion('BipV2SuppressionKeys',Version,BIPV2_Build.mod_email.emailList,,'N');
			
			return sequential(
			                    buildEntitySupressionKey
			                   ,parallel(promoteSuppression,promoteSuppressionKey,promoteEntitySupressionKey)
						    ,if(not Tools._Constants.IsDataland,evaluate(dopsupdate),output('Not a prod environment'))
						   );
	end;
	
	export addCandidates(dataset(inRec) inDs, string version) := function
		recsToSuppress   := getHdrbyRcid(inDs);
		addTrackingInfo  := project(recsToSuppress,
		                            transform(BIPV2_Files.files_suppressions().Layout_Suppression,
                                                self.userid     := lib_thorlib.thorlib.jobowner();
                                                self.dt_added   := (unsigned4)lib_thorlib.thorlib.wuid()[2..9];
								        self.suppressed := true;
								        self            := left));

          findAllMatchingRids := join(BIPV2.CommonBase.DS_STATIC, recsToSuppress,
							   left.fname = right.fname and
							   left.mname = right.mname and
							   left.lname = right.lname and
							   left.name_suffix = right.name_suffix and
							   left.cnp_name = right.cnp_name and
							   left.cnp_number = right.cnp_number and
							   left.cnp_store_number = right.cnp_store_number and
							   left.prim_range = right.prim_range and
							   left.predir = right.predir and
							   left.prim_name = right.prim_name and
							   left.addr_suffix = right.addr_suffix and
							   left.postdir = right.postdir and
							   left.unit_desig = right.unit_desig and
							   left.sec_range = right.sec_range and
							   left.v_city_name = right.v_city_name and
							   left.st = right.st and
							   left.zip = right.zip and
							   left.active_duns_number = right.active_duns_number and
							   left.active_enterprise_number = right.active_enterprise_number and
							   left.ebr_file_number = right.ebr_file_number and
							   left.active_domestic_corp_key = right.active_domestic_corp_key and
							   left.foreign_corp_key = right.foreign_corp_key and
							   left.unk_corp_key = right.unk_corp_key and
							   left.company_fein = right.company_fein and
							   left.company_phone = right.company_phone and
							   left.company_ticker = right.company_ticker and
							   left.company_ticker_exchange = right.company_ticker_exchange and
							   left.company_foreign_domestic = right.company_foreign_domestic and
							   left.company_url = right.company_url and
							   left.company_inc_state = right.company_inc_state and
							   left.company_charter_number = right.company_charter_number and
							   left.vl_id = right.vl_id and
							   left.duns_number = right.duns_number and
							   left.contact_ssn = right.contact_ssn and
							   left.contact_dob = right.contact_dob and					
							   left.company_name = right.company_name and
							   left.contact_dob = right.contact_dob and
							   left.contact_email = right.contact_email,
						        transform(BIPV2_Files.files_suppressions().Layout_Suppression_Key,
							             self := left,
									   self.userid     := lib_thorlib.thorlib.jobowner(),
                                                self.dt_added   := (unsigned4)lib_thorlib.thorlib.wuid()[2..9],
								        self.suppressed := true,
							            ), lookup);
											   
		a                := createLogicalFile(addTrackingInfo,findAllMatchingRids,version);
		b                := updateSuppressedSuperFile(version);
		
		c                := sequential(a, b);
		return c;
	end;
	
	export candidatesByProxID(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.proxid = right.inId,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export candidatesBySeleID(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.seleid = right.inId,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export candidatesByLGID3(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.lgid3 = right.inId,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export removeCandidates(dataset(inRec) inDs, string version) := function
		suppressedData   :=  BIPV2_Files.files_suppressions().ds_suppressions;
		suppressedKey    :=  BIPV2_Files.files_suppressions().key_suppressions();
		
		removeRecs       := join(suppressedData, inDs,
		                         left.rcid = right.rcid,
                                   transform(recordof(left),
						               self.suppressed := if(right.rcid > 0, false, true),
                                             self.userid     := if(right.rcid > 0, lib_thorlib.thorlib.jobowner(), left.userid),
                                             self.dt_added   := if(right.rcid > 0, (unsigned4)lib_thorlib.thorlib.wuid()[2..9], left.dt_added),
								     self            := left,
								    ), left outer, hash);
								    
		removeKeys       := join(suppressedKey, inDs,
		                         left.rcid = right.rcid,
                                   transform(BIPV2_Files.files_suppressions().Layout_Suppression_Key,
						               self.suppressed := if(right.rcid > 0, false, true),
                                             self.userid     := if(right.rcid > 0, lib_thorlib.thorlib.jobowner(), left.userid),
                                             self.dt_added   := if(right.rcid > 0, (unsigned4)lib_thorlib.thorlib.wuid()[2..9], left.dt_added),
								     self            := left,
								    ), left outer, hash);
											   
		a                := createLogicalFileRemovedData(removeRecs,removeKeys,version);
		b                := updateSuppressedSuperFile(version);
		
		c                := sequential(a, b);
		return c;
	end;
end;