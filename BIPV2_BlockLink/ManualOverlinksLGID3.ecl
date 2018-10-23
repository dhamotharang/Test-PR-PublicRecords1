IMPORT BIPV2, BIPV2_Files, BizlinkFull,BIPV2_BlockLink;

EXPORT ManualOverlinksLGID3 := MODULE

	// Overlink file format, usually coming from MBSi
	EXPORT recLayout := RECORD
		INTEGER id ;
		BIPV2_files.files_lgid3.Layout_LGID3; //
		BOOLEAN good;
	END;

  Export rec_sele:=RECORD
		unsigned6 orgid;
	end;
	
	EXPORT reducedlayout := RECORD
		recLayout.id;
		//Modify based on recLayout://use LGID3 (because it corresponds to the cluster to be split) and all the fields that appear in _SPC and are not "carry"
		recLayout.lgid3;
		recLayout.sbfe_id;
		recLayout.Lgid3IfHrchy;
		recLayout.company_name;	
		recLayout.cnp_number;		
		recLayout.active_duns_number;		
		recLayout.duns_number;		
		recLayout.company_fein;		
		recLayout.company_inc_state;		
		recLayout.company_charter_number;		
		recLayout.cnp_btype;
		recLayout.good;		
	END;

	EXPORT file_prefix := '~thor_data400::BIPV2_Blocklink::LGID3::overlink::';
	EXPORT file_sele   := '~thor_data400::bipv2_blocklink::Reset_SeleId::TheSeleIds::';
	shared wuid := thorlib.wuid();
	EXPORT logicalFilename := file_prefix + wuid;
	EXPORT logicalFilename_sele := file_sele + wuid;
	
	SHARED superfile := file_prefix  + 'qa';
	SHARED superfile_father := file_prefix + 'father';
	SHARED superfile_grandfather := file_prefix + 'grandfather';
	
	SHARED superfile_sele := file_sele  + 'qa';
	SHARED superfile_father_sele := file_sele + 'father';
	SHARED superfile_grandfather_sele := file_sele + 'grandfather';
	

	/* -- File contains ManualOverLink records -- */
	EXPORT dataIn_file := dataset(superfile, recLayout, flat);
  EXPORT Sele_to_reset:=dataset(superfile_sele, rec_sele,flat);
	
	/* -- UpdateOverlinkSuperFile -- */
	EXPORT updateOverlinkSuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile, 
																									 superfile_father,
																									 superfile_grandfather], inFile, true)
							);
		return action;
	END;

/* -- UpdateSeleSuperFile -- */
	EXPORT updateSeleSuperFile(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([superfile_sele, 
																									 superfile_father_sele,
																									 superfile_grandfather_sele], inFile, true)
							);
		return action;
	END;
	/* -- CreateLogicalFile -- */
	EXPORT createLogicalFile(dataset(reducedlayout) datasetOverlink) := FUNCTION	
		oldData := IF(nothor(FileServices.FileExists(superfile)), 
								dataset(superfile, recLayout, thor), 
								dataset([], recLayout));
		
		maxId := IF(nothor(FileServices.FileExists(superfile)), max(oldData, id), 9999999);
				
		overlinkDids := dedup(sort(datasetOverlink, lgid3), lgid3); //change depend on which part (POWID, PROXID, etc)
		
		overlinkDids AddId(overlinkDids group1, integer nextCount) := transform
			self.id := maxId + nextCount;
			self := group1;
		end;
		// increment ids by did only.
		overlinkWithIds := project(overlinkDids, AddId(left, counter));
		
		// reassign new incremented ids.
		fullOverlink := join(datasetOverlink, overlinkWithIds, 
													left.lgid3 = right.lgid3,
													transform(reducedlayout, self.id := right.id, self:= left));
													
													
		newData	:= project(fullOverlink, transform(recLayout, self.rcid := left.id, self := left, self := []));
		AllData := oldData + newData;
						
		result := distribute(allData, id);
		output(sort(newData, id, good), named('NewData'));
		a := output(Result, ,logicalFilename, overwrite);
		RETURN a;
	END;
		
		/* -- CreateLogicalSeleFile -- */
	EXPORT createLogicalSeleFile(dataset(rec_sele) datasetSeleid) := FUNCTION	
		oldData := IF(nothor(FileServices.FileExists(superfile_sele)), 
								dataset(superfile_sele, rec_sele, thor), 
								dataset([], rec_sele));
		
		output(oldData,named('oldData_seleid'));
		AllData := oldData + datasetSeleid;
		output(AllData, named('AllDataSeleid'));
		a := output(AllData, ,logicalFilename_sele, overwrite);
		RETURN a;
	END;
	
	/* -- It generates candidates for the BlockLink file -- */
	/* Depend on your need, you can develop functions that determine which fields should be used in the matching of the blocklink */
	/* I create two of them as examples: candidatesCompSbfeFein, candidatesCompDuns*/
	EXPORT candidatesCompSbfeFein(unsigned6 in_seleid, unsigned6 in_lgid3, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(lgid3 = in_lgid3);
		ds := BIPV2_BlockLink.GetClusterOfOneLgid3(in_seleid,in_lgid3);
		t1 := project(ds, transform(reducedlayout, self.id := gid;
																							 self.good := true;
																							//recLayout.company_name;//---use this
																							//recLayout.cnp_btype;	 // ---use this
																							//recLayout.company_fein; //---use this
																							//recLayout.sbfe_id; //---use this
																							//recLayout.cnp_number;//---use this
																							self.Lgid3IfHrchy :='';
																							self.active_duns_number :='';	
																							self.duns_number :='';
																							self.company_inc_state :='';
																							self.company_charter_number :='';
																							self := left;
																							self := []));

		r1 := dedup(sort(t1, company_name, cnp_btype,cnp_number,sbfe_id, company_fein),company_name, cnp_btype,cnp_number,sbfe_id, company_fein);
		
		result := r1;
		
		return result;
	END;

	/* -- It generates candidates for the BlockLink file -- */
	EXPORT candidatesCompDuns(unsigned6 in_seleid,unsigned6 in_lgid3, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(lgid3 = in_lgid3);
		ds := BIPV2_BlockLink.GetClusterOfOneLgid3(in_seleid,in_lgid3);
		t1 := project(ds, transform(reducedlayout, 	self.id := gid; 
																								self.good := true;
																								//recLayout.company_name;// ---use this
																								//recLayout.cnp_btype;	// ---use this
																								//recLayout.cnp_number;	// ---use this
																								//recLayout.active_duns_number; // ---use this
																								//recLayout.duns_number;				// ---use this
																								self.Lgid3IfHrchy :='';
																								self.company_fein :='';																								
																								self.company_charter_number :='';
																								self.company_inc_state :='';
																								self.sbfe_id :='';
																								self := left;
																								self := []));

		r1 := dedup(sort(t1, company_name, cnp_btype, cnp_number, active_duns_number, duns_number), company_name, cnp_btype, cnp_number, active_duns_number, duns_number);
		
		result := r1;
		
		return result;
	END;
	
	EXPORT candidatesCompAll(unsigned6 in_seleid, unsigned6 in_lgid3, integer gid = 1) := FUNCTION
	
		//ds := BIPV2.CommonBase.DS_BASE(lgid3 = in_lgid3);
		ds := BIPV2_BlockLink.GetClusterOfOneLgid3(in_seleid,in_lgid3);
		t1 := project(ds, transform(reducedlayout, 	self.id := gid; 
																								self.good := true;
																								//recLayout.company_name;// ---use this
																								//recLayout.cnp_btype;	// ---use this
																								//recLayout.cnp_number;	// ---use this
																								//recLayout.active_duns_number; // ---use this
																								//recLayout.duns_number;				// ---use this
																								//recLayout.Lgid3IfHrchy :='';
																								//recLayout.company_fein :='';																								
																								//recLayout.company_charter_number :='';
																								//recLayout.company_inc_state :='';
																								//recLayout.sbfe_id :='';
																								self := left;
																								self := []));

		r1 := dedup(sort(t1, company_name, cnp_btype, cnp_number, active_duns_number, duns_number,company_fein,sbfe_id,company_charter_number,company_inc_state),
												 company_name, cnp_btype, cnp_number, active_duns_number, duns_number,company_fein,sbfe_id,company_charter_number,company_inc_state);
		
		result := r1;
		
		return result;
	END;
	
	EXPORT candidates(unsigned6 in_seleid, unsigned6 in_lgid3, integer gid = 1, string UseWhich = 'All') := FUNCTION

		with_SBFE := candidatesCompSbfeFein(in_seleid,in_lgid3);

		with_Duns := candidatesCompDuns(in_seleid,in_lgid3);
		
		with_All  := candidatesCompAll(in_seleid,in_lgid3);
		
		result := if(UseWhich='All',with_All, if(UseWhich='CompDuns',with_Duns,with_SBFE));
		
		return result;
	END;

	/* -- It adds candidates to the BlockLink file -- */
	EXPORT addCandidates(dataset(reducedlayout) datasetOverlink, unsigned6 in_seleid) := FUNCTION
	
		a := createLogicalFile(datasetOverlink);
		b := updateOverlinkSuperFile(logicalFilename);
		
		all_ids:=BizlinkFull.Process_Biz_Layouts.KeyseleidUp(seleid=in_seleid);
		the_orgid:=(unsigned6)all_ids[1].orgid;
				
		ds_new_sele:=dataset([{the_orgid}],rec_sele);		
		a1:=createLogicalSeleFile(ds_new_sele);
		b1:=updateSeleSuperFile(logicalFilename_sele);
		
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

 EXPORT removeSeleCandidate(unsigned6 SeleIn=0) := FUNCTION //if SeleIn=0 then remove all seleids, else just remove the SeleIn
		
		all_ids:=BizlinkFull.Process_Biz_Layouts.KeyseleidUp(seleid=SeleIn);
		the_orgid:=(unsigned6)all_ids[1].orgid;
		ds := if(the_orgid !=0, sele_to_reset(orgid != the_orgid), dataset([], rec_sele));
		
		a := output(ds, ,logicalFilename_sele, overwrite);
		
		b := updateSeleSuperFile(logicalFilename_sele);
		
		c := sequential(a, b);

		return c;
	END;
	
END;