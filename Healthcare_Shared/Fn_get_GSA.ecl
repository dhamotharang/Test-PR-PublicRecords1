/*Import GSA_Services,GSA,IESP;
EXPORT Fn_get_GSA := MODULE
	Shared get_SanctionChild (Healthcare_Shared.Layouts.CombinedHeaderResults srcRec,recordof(GSA.Key_GSA_gsa_id) gsaRec):= function
		Healthcare_Shared.Layouts.layout_LegacySanctions setRequest():=transform
			self.acctno:=srcRec.acctno;
			self.ProviderID:=gsaRec.gsa_id;
			self.Src:=Healthcare_Shared.Constants.SRC_GSA_SANC;
			self.SANC_ID := gsaRec.gsa_id;
			self.SANC_SANCDTE_form := gsaRec.actiondate;
			self.SANC_BRDTYPE := 'FEDERAL';	
			self.SANC_SRC_DESC := 'OFFICE OF PERSONNEL MANAGEMENT';
			self.SANC_TYPE := 'EXCLUSION';
			self.SANC_TERMS := if(gsaRec.termdateindefinite = 'Y',trim(gsaRec.agencycomponent,right) + ' Permanent Termination',trim(gsaRec.agencycomponent,right) + ' Sanctioned until '+gsaRec.termdate[1..4]);
			self.SANC_REAS := gsaRec.CTCode;//Need decode
			// self.SANC_COND := trim(gsaRec.agencycomponent,right) + ' EXCLUSION ';
			// self.SANC_FAB;
			// self.SANC_UNAMB_IND;
			self.date_last_seen :=gsaRec.dt_last_seen;
			self.SANC_BUSNME :=if(gsaRec.classification = 'BUSINESS',gsaRec.Name,'');;
			self.Prov_Clean_title := gsaRec.title;
			self.Prov_Clean_fname := gsaRec.fname;
			self.Prov_Clean_mname := gsaRec.mname;
			self.Prov_Clean_lname := gsaRec.lname;
			self.Prov_Clean_name_suffix := gsaRec.name_suffix;
			self.ProvCo_Address_Clean_prim_range := gsaRec.prim_range;
			self.ProvCo_Address_Clean_predir := gsaRec.predir;
			self.ProvCo_Address_Clean_prim_name := gsaRec.prim_name;
			self.ProvCo_Address_Clean_addr_suffix := gsaRec.addr_suffix;
			self.ProvCo_Address_Clean_postdir := gsaRec.postdir;
			self.ProvCo_Address_Clean_unit_desig := gsaRec.unit_desig;
			self.ProvCo_Address_Clean_sec_range := gsaRec.sec_range;
			self.ProvCo_Address_Clean_p_city_name := gsaRec.p_city_name;
			self.ProvCo_Address_Clean_st := gsaRec.st;
			self.ProvCo_Address_Clean_zip := gsaRec.zip5;
			self.ProvCo_Address_Clean_geo_lat := gsaRec.geo_lat;
			self.ProvCo_Address_Clean_geo_long := gsaRec.geo_long;
			self.did := (string)gsaRec.did;
			self.bdid := (string)gsaRec.bdid;
			Self.sanc_grouptype :='FEDERAL';
			self.GroupSortOrder := 99;
			self:=[];
		end;
		SanctionsDs:=dataset([setRequest()]);
		return SanctionsDs;
	End;
	Shared Healthcare_Shared.Layouts.layout_nameinfo doSanctionNameRollup(recordof(GSA.Key_GSA_gsa_id) l,
																										integer c) := TRANSFORM
																				self.nameSeq := c+20; //Keep it high so other names potentially will be kept before this.
																				self.FullName := if(l.classification = 'BUSINESS','',l.Name);
																				self.FirstName := l.Fname;
																				self.MiddleName := l.Mname;
																				self.LastName := l.Lname;
																				self.Suffix  := l.name_Suffix;
																				self.Title := l.title;
																				self.CompanyName :=  if(l.classification = 'BUSINESS',l.Name,'');
	end;
	Shared get_GSA_Results (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) input):= function
		fmt := join(input,GSA.Key_GSA_gsa_id,keyed(left.LNPID=right.gsa_id),transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
									self.Src := if(right.agencyComponent in ['HHS', 'OIG'],skip,'G');//Get rid of HHS and OIG as they are already included in the data we have.
									self.dids := project(right,transform(Healthcare_Shared.Layouts.layout_did,self.did:= left.did));
									self.bdids := project(right,transform(Healthcare_Shared.Layouts.layout_bdid,self.bdid:= left.bdid));
									self.Names := project(right,doSanctionNameRollup(left,counter));
									self.Addresses := project(right,transform(Healthcare_Shared.Layouts.layout_addressinfo,
																				self.address1 := left.street1;
																				self.address2 := left.street2;
																				self.prim_range := left.prim_range;
																				self.predir := left.predir;
																				self.prim_name := left.prim_name;
																				self.addr_suffix := left.addr_suffix;
																				self.postdir := left.postdir;
																				self.unit_desig := left.unit_desig;
																				self.sec_range := left.sec_range;
																				self.p_city_name := left.p_city_name;
																				self.v_city_name := left.p_city_name;
																				self.st := left.St;
																				self.z5 := left.Zip5;
																				self.zip4 := left.Zip4;self:=[]));
									self.SRCID := right.gsa_id;
									self.LegacySanctions := get_SanctionChild(left,right);
									self.hasOPM := true;
									self:= left;));
		// output(input);
		// output(fmt);
		return Fmt;
	End;
	Shared Healthcare_Shared.Layouts.CombinedHeaderResults doSanctionRollup(Healthcare_Shared.Layouts.CombinedHeaderResults l,
																										DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := TRANSFORM
			self.dids := dedup(allrows.dids,record,all);
			self.bdids := dedup(allrows.bdids,record,all);
			self.Names := sort(dedup(sort(allrows.Names,FullName,FirstName,MiddleName,LastName,Suffix,Title,CompanyName,nameSeq),FullName,FirstName,MiddleName,LastName,Suffix,Title,CompanyName),nameSeq);
			self.Addresses := dedup(allrows.Addresses,record,all);
			self.LegacySanctions := allrows.LegacySanctions;
			self := l;
			self := [];
	end;
	Export get_GSA_by_autokeys (dataset(Healthcare_Shared.Layouts.autokeyInput) input, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg):= function
		fmtGSAInput := project(input,transform(GSA_Services.Layouts.gsa_rec_inBatchMaster,self.acctno:=if(cfg[1].ExcludeGSA,skip,left.acctno);self:=left));	
		gsaResults := GSA_Services.BatchService_Records(fmtGSAInput,cfg[1].penalty_threshold).ds_outRecs;
		removePenalty := gsaResults(_penalty<=cfg[1].penalty_threshold);
		filterMatches := join(input,removePenalty, left.acctno=right.acctno, 
													transform(recordof(removePenalty),
														hasBus := left.comp_name !='';
														keepBus := right.companyname !='';
														hasFirst := left.name_first !='';
														hasBoth := left.name_first !='' and left.name_middle != '';
														FNameFilter := [left.name_first[1]];
														MNameFilter := [left.name_middle[1],''];
														keepBoth := hasBoth and right.Name.First[1] in FNameFilter and right.Name.Middle[1] in MNameFilter;
														keepFirst := hasFirst and right.Name.First[1] in FNameFilter;
														keepit := (hasBoth and keepBoth) or (not hasBoth and hasFirst and KeepFirst) or (hasBus and keepBus);
														self.acctno:= if(keepit,left.acctno,skip);
														self:=right;),
													keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));		
		gsaRawfmt := dedup(project(filterMatches,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
												self.acctno :=left.acctno;
												self.record_penalty := left._penalty;
												self.isAutokeysResult := true;
												self.LNPID := left.gsa_id;)),record,all,hash);
		Final:=get_GSA_Results(gsaRawfmt);
		groupedRecs := group(Final, acctno, LNPID);
		rolledRecs := rollup(groupedRecs, group, doSanctionRollup(left,rows(left)));			
		// output(fmtGSAInput);
		// output(gsaResults);
		// output(filterMatches);
		// output(gsaRawfmt);
		// output(Final);
		return rolledRecs;
	End;
	Export get_GSA_by_KeyLNPID (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) input):= function
		gsaRawfmt := join(input,GSA.Key_GSA_LNPID(),keyed(left.LNPID=right.lnpid),transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
												self.acctno :=left.acctno;
												self.LNPID := right.gsa_id;),keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		return gsaRawfmt;
	End;
	Export get_GSA_by_LNPID (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) input):= function
		getKey := get_GSA_by_KeyLNPID(input);
		getResults := join(getKey,GSA.Key_GSA_gsa_id,keyed(left.LNPID=right.gsa_id),transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
									self.LegacySanctions := get_SanctionChild(left,right);
									self:= left;));
		//Roll multiples together and append
		groupedRecs := group(getResults, acctno, vendorid);
		rolledRecs := rollup(groupedRecs, group, doSanctionRollup(left,rows(left)));			
		appendResults := join(input,rolledRecs,left.acctno=right.acctno and left.lnpid=(integer)right.vendorid,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
											// sancs := sort(left.LegacySanctions+right.LegacySanctions,acctno,GroupSortOrder);
											sancs := left.LegacySanctions+right.LegacySanctions;
											self.hasOPM := true;
											self.LegacySanctions := sancs;
											self:=left;),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		// output(getKey);
		// output(getResults);
		// output(appendResults);
		return appendResults;
	End;
	Export getSanctionsReentry (dataset(Healthcare_Shared.Layouts.autokeyInput) input):= function
		gsaRawfmt := project(input,transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
												self.acctno :=left.acctno;
												self.LNPID := left.ProviderID;));
		Final:=get_GSA_Results(gsaRawfmt);
		return final;
	End;
end;*/