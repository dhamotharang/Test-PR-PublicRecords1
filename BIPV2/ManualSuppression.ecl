import BIPV2;
import BIPV2_Files;
import lib_thorlib;

export ManualSuppression := module
	export inRec := record
		BIPV2.CommonBase.Layout.rcid;
	end;
	
	export inRec2 := record
		BIPV2.CommonBase.Layout.ProxID;
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
	
	export Layout_Suppression := record
		BIPV2.CommonBase.Layout;
		string25  userid;
		unsigned4 dt_added;		
		boolean removed;
	end;
	
	export getHdrbyRcid(dataset(inRec) inDS) := function
		hdrRecs    := BIPV2.CommonBase.DS_STATIC;
		matchRidDS := join(hdrRecs,inDS,
                        left.rcid = right.rcid,
                        transform(Layout_Suppression,self := left, self := []),lookup);
		return matchRidDS;
	end;		
	
	export createLogicalFile(dataset(Layout_Suppression) inRecs) := function
		newFileName := BIPV2_Files.files_suppressions().filename;
		oldData     := dataset(BIPV2_Files.files_suppressions().sfFileName,Layout_Suppression,thor,opt);
		newData     := inRecs;
		allData     := oldData + newData;
		distData    := distribute(allData, hash32(rcid));
		sortedData  := sort(distData, rcid, -dt_added, local);
		dedupedData := dedup(sortedData, rcid, local);		
		a           := output(dedupedData,,newFileName,named('Suppressed_Data'));
		return a;
	end;

	export createLogicalFileRemovedData(dataset(Layout_Suppression) inRecs) := function
		newFileName := BIPV2_Files.files_suppressions().filename;
		allData     := inRecs;
		distData    := distribute(allData, hash32(rcid));
		sortedData  := sort(distData, rcid, -dt_added, local);
		dedupedData := dedup(sortedData, rcid, local);		
		a           := output(dedupedData,,newFileName,named('Suppressed_Data'));
		return a;
	end;
	
	export updateSuppressedSuperFile() := function
			superfile   := BIPV2_Files.files_suppressions().sfFileName;
			logicalFile := BIPV2_Files.files_suppressions().filename;
			action := FileServices.PromoteSuperFileList([superfile], logicalFile, true);
			return action;
	end;
	
	export addCandidates(dataset(inRec) inDs) := function
		recsToSuppress  := getHdrbyRcid(inDs);
		addTrackingInfo := project(recsToSuppress,
		                           transform(Layout_Suppression,
                                          self.userid   := lib_thorlib.thorlib.jobowner();
                                          self.dt_added := (unsigned4)lib_thorlib.thorlib.wuid()[2..9];
								                      self.removed  := false;
								                      self          := left));
								                      
		a                := createLogicalFile(addTrackingInfo);
		b                := updateSuppressedSuperFile();
		
		c                := sequential(a, b);
		return c;
	end;
	
	export candidatesByProxID(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.proxid = right.proxid,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export candidatesBySeleID(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.seleid = right.proxid,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export candidatesByLGID3(dataset(inRec2) inDs) := function
		hdr        := BIPV2.CommonBase.DS_STATIC;
		recs       := join(hdr,inDS,
                        left.lgid3 = right.proxid,
                        transform(slimRec,self := left), lookup);
		return recs;
	end;
	
	export removeCandidates(dataset(inRec) inDs) := function
		suppressedData   := dataset(BIPV2_Files.files_suppressions().sfFileName,Layout_Suppression,thor,opt);
		removeRecs       := join(suppressedData, inDs,
		                         left.rcid = right.rcid,
                              transform(recordof(left),
						                         self.removed  := if(right.rcid > 0, true, false),
                                        self.userid   := if(right.rcid > 0, lib_thorlib.thorlib.jobowner(), left.userid),
                                        self.dt_added := if(right.rcid > 0, (unsigned4)lib_thorlib.thorlib.wuid()[2..9], left.dt_added),
								                    self          := left,
								                    ), left outer, hash);
						
		a                := createLogicalFileRemovedData(removeRecs);
		b                := updateSuppressedSuperFile();
		
		c                := sequential(a, b);
		return c;
	end;
end;