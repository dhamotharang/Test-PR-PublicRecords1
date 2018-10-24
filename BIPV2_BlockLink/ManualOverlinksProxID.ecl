IMPORT BIPV2, BIPV2_Files,BizlinkFull;

EXPORT ManualOverlinksProxID := MODULE

	// Overlink file format, usually coming from MBSi
	EXPORT recLayout := RECORD
		INTEGER id ;
		BIPV2.CommonBase.Layout; //
		BOOLEAN good;
	END;
  Export rec_lgid3:=RECORD
		unsigned6 orgid;
	end;
	
	EXPORT reducedlayout := RECORD
		recLayout.id;
		//Modify based on recLayout://use Proxid (because it corresponds to the cluster to be split) and all the fields that appear in _SPC and are not "carry"
		recLayout.proxid;
		recLayout.cnp_name;//yes
		recLayout.cnp_number;//yes
		recLayout.cnp_btype;//yes
		recLayout.prim_range_derived;//yes
		recLayout.prim_name_derived;//yes
		recLayout.sec_range;//yes
		recLayout.v_city_name;//yes
		recLayout.st;//yes
		recLayout.zip;//yes
		recLayout.active_duns_number;//yes
		recLayout.hist_duns_number;//yes
		recLayout.active_enterprise_number;//yes
		recLayout.hist_enterprise_number; //yes
		recLayout.ebr_file_number;//yes
		recLayout.active_domestic_corp_key;//yes
		recLayout.hist_domestic_corp_key;//yes
		recLayout.foreign_corp_key; //yes
		recLayout.unk_corp_key;//yes
		recLayout.source; //this is a carry field but may help to identify something easily, so include it. It has no effect on filter or join
		recLayout.company_fein;//yes
		recLayout.company_phone;//yes
		recLayout.good;		
	END;

	EXPORT file_prefix := '~thor_data400::BIPV2_Blocklink::PROXID::overlink::';
	EXPORT file_lgid   := '~thor_data400::bipv2_blocklink::Reset_Lgid::Thelgid3s::';
	shared wuid := thorlib.wuid();
	EXPORT logicalFilename      := file_prefix + wuid;
	EXPORT logicalFilename_Lgid := file_lgid + wuid;
	
	SHARED superfile := file_prefix  + 'qa';
	SHARED superfile_father := file_prefix + 'father';
	SHARED superfile_grandfather := file_prefix + 'grandfather';
	
	SHARED superfile_lgid := file_lgid  + 'qa';
	SHARED superfile_father_lgid := file_lgid + 'father';
	SHARED superfile_grandfather_lgid := file_lgid + 'grandfather';
	

	/* -- File contains ManualOverLink records -- */
	EXPORT dataIn_file := dataset(superfile, recLayout, flat);
  EXPORT lgid_to_reset:=dataset(superfile_lgid, rec_lgid3,flat);
	
	/* -- UpdateOverlinkSuperFile -- */
	EXPORT updateOverlinkSuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile, 
																									 superfile_father,
																									 superfile_grandfather], inFile, true)
							);
		return action;
	END;

/* -- UpdateLgidSuperFile -- */
	EXPORT updateLgidSuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile_lgid, 
																									 superfile_father_lgid,
																									 superfile_grandfather_lgid], inFile, true)
							);
		return action;
	END;
	
	/* -- CreateLogicalFile -- */
	EXPORT createLogicalFile(dataset(reducedlayout) datasetOverlink) := FUNCTION	
		oldData := IF(nothor(FileServices.FileExists(superfile)), 
								dataset(superfile, recLayout, thor), 
								dataset([], recLayout));
		
		//output(oldData,all);
		
		maxId := IF(nothor(FileServices.FileExists(superfile)), max(oldData, id), 9999999);
output(maxId,named('maxId'));				
				
		overlinkDids := dedup(sort(datasetOverlink, proxid), proxid); //change depend on which part (POWID, PROXID, etc)
		
		overlinkDids AddId(overlinkDids group1, integer nextCount) := transform
			self.id := maxId + nextCount;
			self := group1;
		end;
		// increment ids by did only.
		overlinkWithIds := project(overlinkDids, AddId(left, counter));
output(overlinkWithIds,named('overlinkWithIds'));		
		// reassign new incremented ids.
		fullOverlink := join(datasetOverlink, overlinkWithIds, 
													left.proxid = right.proxid,
													transform(reducedlayout, self.id := right.id, self:= left));
output(fullOverlink,named('fullOverlink'));													
													
		newData	:= project(fullOverlink, transform(recLayout, self.rcid := left.id, self := left, self := []));
		AllData := oldData + newData;
						
		result := distribute(allData, id);
		output(sort(newData, id, good), named('NewData'));
		a := output(Result, ,logicalFilename, overwrite);
		RETURN a;
	END;
	
	/* -- CreateLogicalLgidFile -- */
	EXPORT createLogicalLgidFile(dataset(rec_lgid3) datasetLgid) := FUNCTION	
		oldData := IF(nothor(FileServices.FileExists(superfile_lgid)), 
								dataset(superfile_lgid, rec_lgid3, thor), 
								dataset([], rec_lgid3));
		
		output(oldData,named('oldData_lgid'));
		AllData := oldData + datasetLgid;
		output(AllData, named('AllData'));
		a := output(AllData, ,logicalFilename_Lgid, overwrite);
		RETURN a;
	END;
		
	/* -- It generates candidates for the BlockLink file -- */
	/* Depend on your need, you can develop functions that determine which fields should be used in the matching of the blocklink */
	/* I create two of them as examples: candidatesFein, candidatesCompSBFE*/
	EXPORT candidatesFein(unsigned6 in_proxid, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(proxid = in_proxid);
		ds := BIPV2_Blocklink.GetClusterOfOneProx(in_proxid);
		
		t1 := project(ds, transform(reducedlayout, self.id := gid;
																							 self.good := true;
																							//recLayout.cnp_name;				// ---use this
																							//recLayout.cnp_btype;			// ---use this
																							//recLayout.cnp_number;     //---use this
																							//recLayout.active_duns_number;//---use this
																							//recLayout.hist_duns_number;//---use this
																							//recLayout.active_enterprise_number;//---use this
																							//recLayout.hist_enterprise_number; //---use this
																							//recLayout.ebr_file_number;//---use this
																							//recLayout.active_domestic_corp_key;//---use this
																							//recLayout.hist_domestic_corp_key;//---use this
																							//recLayout.foreign_corp_key; //---use this
																							//recLayout.unk_corp_key;//---use this
																							//recLayout.company_fein;//---use this
																							self.prim_range_derived :='';
																							self.prim_name_derived :='';
																							self.sec_range :='';
																							self.v_city_name :='';
																							self.st :='';
																							self.zip :='';
																							self.company_phone :='';
																							self := left;
																							self := []));

		r1 := dedup(sort(t1, cnp_name, cnp_btype, cnp_number, active_duns_number, hist_duns_number, active_enterprise_number, hist_enterprise_number,
		                     ebr_file_number, active_domestic_corp_key, hist_domestic_corp_key, foreign_corp_key, unk_corp_key, company_fein),
												 cnp_name, cnp_btype, cnp_number, active_duns_number, hist_duns_number, active_enterprise_number, hist_enterprise_number,
		                     ebr_file_number, active_domestic_corp_key, hist_domestic_corp_key, foreign_corp_key, unk_corp_key, company_fein);
		
		result := r1;
		
		return result;
	END;

	/* -- It generates candidates for the BlockLink file -- */
	EXPORT candidatesCompAddr(unsigned6 in_proxid, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(proxid = in_proxid);
		ds := BIPV2_Blocklink.GetClusterOfOneProx(in_proxid);
		
		t1 := project(ds, transform(reducedlayout, 	self.id := gid; 
																								self.good := true;
																								//recLayout.cnp_name;	// ---use this
																								//recLayout.cnp_number;//---use this
																								//recLayout.cnp_btype;// ---use this
																								//recLayout.prim_range_derived;//---use this
																								//recLayout.prim_name_derived;//---use this
																								//recLayout.sec_range;//---use this
																								//recLayout.v_city_name;//---use this
																								//recLayout.st;//---use this
																								//recLayout.zip;//---use this
																								//recLayout.company_phone;//---use this
																								self.active_duns_number :='';
																								self.hist_duns_number :='';
																								self.active_enterprise_number :='';
																								self.hist_enterprise_number :='';
																								self.ebr_file_number :='';
																								self.active_domestic_corp_key :='';
																								self.hist_domestic_corp_key :='';
																								self.foreign_corp_key :='';
																								self.unk_corp_key :='';
																								self.company_fein :='';	 
																								self := left;
																								self := []));

		r1 := dedup(sort(t1, cnp_name, cnp_number, cnp_btype, prim_range_derived, prim_name_derived, sec_range, v_city_name,st,zip, company_phone), 
		                     cnp_name, cnp_number, cnp_btype, prim_range_derived, prim_name_derived, sec_range, v_city_name,st,zip, company_phone);
		
		result := r1;
		
		return result;
	END;
	
	/* -- It generates candidates for the BlockLink file -- */
	EXPORT candidatesCompAll(unsigned6 in_proxid, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(proxid = in_proxid);
		ds := BIPV2_Blocklink.GetClusterOfOneProx(in_proxid);
		t1 := project(ds, transform(reducedlayout, 	self.id := gid; 
																								self.good := true;
																								//recLayout.cnp_name;	// ---use this
																								//recLayout.cnp_number;//---use this
																								//recLayout.cnp_btype;// ---use this
																								//recLayout.prim_range_derived;//---use this
																								//recLayout.prim_name_derived;//---use this
																								//recLayout.sec_range;//---use this
																								//recLayout.v_city_name;//---use this
																								//recLayout.st;//---use this
																								//recLayout.zip;//---use this
																								//recLayout.company_phone;//---use this
																								//recLayout.active_duns_number :='';
																								//recLayout.hist_duns_number :='';
																								//recLayout.active_enterprise_number :='';
																								//recLayout.hist_enterprise_number :='';
																								//recLayout.ebr_file_number :='';
																								//recLayout.active_domestic_corp_key :='';
																								//recLayout.hist_domestic_corp_key :='';
																								//recLayout.foreign_corp_key :='';
																								//recLayout.unk_corp_key :='';
																								//recLayout.company_fein :='';	 
																								self := left;
																								self := []));

		r1 := dedup(sort(t1, cnp_name, cnp_number, cnp_btype, prim_range_derived, prim_name_derived, sec_range, v_city_name,st,zip, company_phone,
												 active_duns_number,hist_duns_number,active_enterprise_number,hist_enterprise_number,ebr_file_number,active_domestic_corp_key,
												 hist_domestic_corp_key,foreign_corp_key,unk_corp_key,company_fein), 
		                     cnp_name, cnp_number, cnp_btype, prim_range_derived, prim_name_derived, sec_range, v_city_name,st,zip, company_phone,
												 active_duns_number,hist_duns_number,active_enterprise_number,hist_enterprise_number,ebr_file_number,active_domestic_corp_key,
												 hist_domestic_corp_key,foreign_corp_key,unk_corp_key,company_fein);
		
		result := r1;
		
		return result;
	END;
	
	EXPORT candidates(unsigned6 in_proxid, integer gid = 1, string UseWhich = 'All') := FUNCTION

		with_Fein := candidatesFein(in_proxid);

		with_Addr := candidatesCompAddr(in_proxid);
		
		with_All := candidatesCompAll(in_proxid);
		
		result := if(UseWhich='All', with_All, if(UseWhich='Addr', with_Addr, with_Fein));
		
		return result;
	END;

	/* -- It adds candidates to the BlockLink file -- */
	EXPORT addCandidates(dataset(reducedlayout) datasetOverlink) := FUNCTION
	
		a := createLogicalFile(datasetOverlink);
		b := updateOverlinkSuperFile(logicalFilename);

		tt:= table(datasetOverlink,{proxid});
    ds_prox:=dedup(tt,proxid);
		proxid_in:=(unsigned6)ds_prox[1].proxid;
		all_ids:=GetClusterOfOneProx(proxid_in);
    the_org:=(unsigned6)all_ids[1].orgid;	
		ds_new_lgid:=dataset([{the_org}],rec_lgid3);
		
		a1:=createLogicalLgidFile(ds_new_lgid);
		b1:=updateLgidSuperFile(logicalFilename_Lgid);
			
		c := sequential(a,b,a1,b1);
		
		return c;
	END;

	/* -- It removes candidates from the BlockLink file -- ID=10000000 for example */
	EXPORT removeCandidates(integer gid) := FUNCTION
	
		ds := dataIn_file(id != gid);
		
		a := output(ds, ,logicalFilename, overwrite);
		
		b := updateOverlinkSuperFile(logicalFilename);
		
		c := sequential(a, b);

		return c;
	END;

	EXPORT removeLgidCandidate(unsigned6 proxid_in=0) := FUNCTION //if proxid_in=0 then remove all orgids, else just remove the orgid of this proxid_in
		
		all_ids:=GetClusterOfOneProx(proxid_in);
    the_org:=(unsigned6)all_ids[1].orgid;
		ds := if(the_org !=0, lgid_to_reset(orgid != the_org), dataset([], rec_lgid3));
		
		a := output(ds, ,logicalFilename_Lgid, overwrite);
		
		b := updateLgidSuperFile(logicalFilename_Lgid);
		
		c := sequential(a, b);

		return c;
	END;
END;