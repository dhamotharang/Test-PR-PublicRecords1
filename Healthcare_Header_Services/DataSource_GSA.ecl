Import GSA_Services,GSA,IESP,STD;
EXPORT DataSource_GSA := MODULE
	Shared Layouts.layout_nameinfo doSanctionNameRollup(recordof(GSA.Key_GSA_gsa_id) l,
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
	Shared get_GSA_Results (dataset(Layouts.CombinedHeaderResults) input):= function
		fmt := join(input,GSA.Key_GSA_gsa_id,keyed(left.LNPID=right.gsa_id),transform(Layouts.CombinedHeaderResults,
									self.Src := if(STD.Str.find(right.agencyComponent, 'HHS') > 0 or STD.Str.find(right.agencyComponent, 'OIG') > 0,skip,'G');//Get rid of HHS and OIG as they are already included in the data we have.
									rightRecAsDS := dataset(right);
									self.dids := project(rightRecAsDS,transform(layouts.layout_did,self.did:= left.did));
									self.bdids := project(rightRecAsDS,transform(layouts.layout_bdid,self.bdid:= left.bdid));
									self.Names := project(rightRecAsDS,doSanctionNameRollup(left,counter));
									self.Addresses := project(rightRecAsDS,transform(Layouts.layout_addressinfo,
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
																				self.zip4 := left.Zip4;));
									Layouts.layout_LegacySanctions setRequest():=transform
													self.acctno:=left.acctno;
													self.ProviderID:=right.gsa_id;
													self.Src:=if(left.isAutokeysResult,Healthcare_Header_Services.Constants.SRC_GSA_SANC,Healthcare_Header_Services.Constants.SRC_HEADER);
													self.SANC_ID := right.gsa_id;
													self.SANC_SANCDTE_form := right.actiondate;
													self.SANC_BRDTYPE := 'FEDERAL';	
													self.SANC_SRC_DESC := 'OFFICE OF PERSONNEL MANAGEMENT';
													self.SANC_TYPE := 'EXCLUSION';
													self.SANC_TERMS := if(right.termdateindefinite = 'Y',trim(right.agencycomponent,right) + ' Permanent Termination',trim(right.agencycomponent,right) + ' Sanctioned until '+right.termdate[1..4]);
													self.SANC_REAS := right.CTCode;//Need decode
													// self.SANC_COND := trim(right.agencycomponent,right) + ' EXCLUSION ';
													// self.SANC_FAB;
													// self.SANC_UNAMB_IND;
													self.date_last_seen :=right.dt_last_seen;
													self.SANC_BUSNME :=if(right.classification = 'BUSINESS',right.Name,'');;
													self.Prov_Clean_title := right.title;
													self.Prov_Clean_fname := right.fname;
													self.Prov_Clean_mname := right.mname;
													self.Prov_Clean_lname := right.lname;
													self.Prov_Clean_name_suffix := right.name_suffix;
													self.ProvCo_Address_Clean_prim_range := right.prim_range;
													self.ProvCo_Address_Clean_predir := right.predir;
													self.ProvCo_Address_Clean_prim_name := right.prim_name;
													self.ProvCo_Address_Clean_addr_suffix := right.addr_suffix;
													self.ProvCo_Address_Clean_postdir := right.postdir;
													self.ProvCo_Address_Clean_unit_desig := right.unit_desig;
													self.ProvCo_Address_Clean_sec_range := right.sec_range;
													self.ProvCo_Address_Clean_p_city_name := right.p_city_name;
													self.ProvCo_Address_Clean_st := right.st;
													self.ProvCo_Address_Clean_zip := right.zip5;
													self.ProvCo_Address_Clean_geo_lat := right.geo_lat;
													self.ProvCo_Address_Clean_geo_long := right.geo_long;
													self.did := (string)right.did;
													self.bdid := (string)right.bdid;
													Self.sanc_grouptype :='FEDERAL';
													self.GroupSortOrder := 99;
													self:=[]
												end;
												SanctionsDs:=dataset([setRequest()]);
									self.SRCID := right.gsa_id;
									self.LegacySanctions := SanctionsDs;
									self.hasOPM := true;
									self:= left;),keep(Constants.IDS_PER_DID), limit(0));
		// output(input);
		// output(fmt);
		return Fmt;
	End;
	Shared Layouts.CombinedHeaderResults doSanctionRollup(Layouts.CombinedHeaderResults l,
																										DATASET(Layouts.CombinedHeaderResults) allRows) := TRANSFORM
			self.dids := dedup(allrows.dids,record,all);
			self.bdids := dedup(allrows.bdids,record,all);
			self.Names := sort(dedup(sort(allrows.Names,FullName,FirstName,MiddleName,LastName,Suffix,Title,CompanyName,nameSeq),FullName,FirstName,MiddleName,LastName,Suffix,Title,CompanyName),nameSeq);
			self.Addresses := dedup(allrows.Addresses,record,all);
			self.LegacySanctions := allrows.LegacySanctions;
			self := l;
			self := [];
	end;
	Export get_GSA_by_autokeys (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg):= function
		fmtGSAInput := project(input,transform(GSA_Services.Layouts.gsa_rec_inBatchMaster,self:=left));	
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
													keep(Constants.IDS_PER_DID), limit(0));
		gsaRawfmt := dedup(project(filterMatches,transform(Layouts.CombinedHeaderResults,
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
	Export get_GSA_by_LNPID (dataset(Layouts.CombinedHeaderResults) input):= function
		gsaRawfmt := join(input,GSA.Key_GSA_LNPID(),keyed(left.LNPID=right.lnpid),transform(Layouts.CombinedHeaderResults,
												self.acctno :=left.acctno;
												self.LNPID := right.gsa_id;
												self.vendorid := (string)left.lnpid;),keep(Constants.IDS_PER_DID), limit(0));
		raw:=get_GSA_Results(gsaRawfmt);
		//Roll multiples together and append
		groupedRecs := group(raw, acctno, vendorid);
		rolledRecs := rollup(groupedRecs, group, doSanctionRollup(left,rows(left)));			
		appendResults := join(input,rolledRecs,left.acctno=right.acctno and left.lnpid=(integer)right.vendorid,transform(Layouts.CombinedHeaderResults,
											// sancs := sort(left.LegacySanctions+right.LegacySanctions,acctno,GroupSortOrder);
											sancs := left.LegacySanctions+right.LegacySanctions;
											self.hasOPM := true;
											self.LegacySanctions := sancs;
											self:=left;),left outer,keep(Constants.IDS_PER_DID), limit(0));
		// output(gsaRawfmt);
		// output(raw);
		// output(rolledRecs);
		// output(appendResults);
		return appendResults;
	End;
	Export getSanctionsReentry (dataset(Layouts.autokeyInput) input):= function
		gsaRawfmt := project(input,transform(Layouts.CombinedHeaderResults,
												self.acctno :=left.acctno;
												self.LNPID := left.ProviderID;));
		Final:=get_GSA_Results(gsaRawfmt);
		return final;
	End;

end;