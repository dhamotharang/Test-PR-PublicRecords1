Import Healthcare_Shared,Enclarity;
EXPORT Fn_do_Sanctions  := MODULE
	// Export appendSanctionsByLNPID(DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := function
		//Get group_keys from header and create layout_sanctions
		//return sanction
	// end;
	Export appendSanctions (dataset(Healthcare_Shared.Layouts.CombinedHeaderResults) inputRecs) := function
		//Process the Sanctions...
			sanctionRecs := RECORD 
				STRING acctno := '';
				unsigned6 InternalID := 0;
				unsigned6 LNPID := 0;
				unsigned6 LNFID := 0;
				string38  group_key := '';		
				string9  	filesource := '';
				string9   filecode := '';
				unsigned8 filecode_enum := 0;
				string20  lic_num := '';
				string1   lic_status := '';
				Healthcare_Shared.layouts_commonized.layout_all_sanction;
			end;
			// input := normalize(inputRecs, left.Sanctions,Transform(Healthcare_Shared.Layouts.layout_sanctions, self:=right));
			SancRecords1 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc1.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc1; self := left;));
			SancRecords2 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc2.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc2; self := left;));
			SancRecords3 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc3.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc3; self := left;));
			SancRecords4 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc4.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc4; self := left;));
			SancRecords5 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc5.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc5; self := left;));
			SancRecords6 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc6.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc6; self := left;));
			SancRecords7 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc7.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc7; self := left;));
			SancRecords8 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc8.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc8; self := left;));
			SancRecords9 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc9.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc9; self := left;));
			SancRecords10 := Project(inputRecs.RecordsRaw,transform(sanctionRecs,self.acctno:=if(left.sanc10.sanc_complaint<>'',left.acctno,skip);self.lic_num := left.lic1.lic_num; self.lic_status := left.lic1.lic_status;self := left.sanc10; self := left;));
			allSanctions := dedup(SancRecords1+SancRecords2+SancRecords3+SancRecords4+SancRecords5+SancRecords6+SancRecords7+SancRecords8+SancRecords9+SancRecords10,record,all);
			input := join(allSanctions,Enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).sanction_group_key.qa,
											keyed(left.group_key = right.group_key) and left.sanc_date = right.sanc1_date and right.record_type = 'C',
											Transform(Healthcare_Shared.Layouts.layout_sanctions, 
													SELF.acctno := left.acctno;
													self.internalid:=left.internalid;
													self.sources :=  Healthcare_Shared.Functions.loadFileSource(left.filesource,left.filecode);
													self.group_key:=left.group_key;
													self.sanc1_state:=left.sanc_state;
													self.sanc1_date:=Healthcare_Shared.Functions.cleanOnlyNumbers(left.sanc_date);
													self.sanc1_prof_type:=left.sanc_case;
													self.sanc1_code:=left.sanc_complaint;
													self.sanc1_lic_num:=left.lic_num;
													self.sanc1_rein_date:=Healthcare_Shared.Functions.cleanOnlyNumbers(left.sanc_rein_date);
													cleanCode := trim(left.sanc_complaint,left,right);
													lastCharacter := cleanCode[length(cleanCode)];
													isReinstate := if(lastCharacter='R',true,false);
													self.isReinstatement := isReinstate or left.sanc_rein_date <> '' or right.ln_derived_rein_date <> '';
													self.LicenseStatus := left.lic_Status;
													self.sanction_stat := left.sanc_st;
													self:=right;
													self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			rawdatalookup1 := join(input, Enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).sanc_codes_sanc_codes.qa,
											keyed(left.sanc1_code = right.sanc_code),
											transform(Healthcare_Shared.Layouts.layout_sanctions, 
																		self.sanc_desc := right.sanc_desc;
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			rawdatalookup2 := join(rawdatalookup1, Enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).sanc_prov_type_sanc_prov_type_code.qa,
											keyed(left.sanc1_prof_type = right.prov_type_code),
											transform(Healthcare_Shared.Layouts.layout_sanctions, 
																		self.prov_type_desc := if(left.sanc1_prof_type='MD','DOCTOR OF MEDICINE',right.prov_type_desc);
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			rawdatalookup3 := join(rawdatalookup2, Enclarity.LookupTables.dsSancLookup,
											left.sanc1_code = right.Code,
											transform(Healthcare_Shared.Layouts.layout_sanctions, 
																		self.SancCategory := right.Cat;
																		self.SancLegacyType := map(left.LicenseStatus='T' and left.sanc1_code = '112DS' => right.LegacyType,
																															 left.sanc1_code = '112DS' => 'HISTORICAL CONDITIONS',
																															 right.LegacyType);
																		self.FullDesc := right.desc;
																		self.SancLevel := if(RIGHT.level='STATE','',RIGHT.level);
																		self.StateOrFederal := if(RIGHT.level='STATE','STATE','FEDERAL');
																		self.SancLossOfLic := if((integer)left.ln_derived_rein_date>0,'FALSE',right.LossOfLicense);
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0)); 
			rawdatalookup4 := join(rawdatalookup3, Enclarity.LookupTables.dsBoardInfo,
											left.sanc1_state = right.State and left.prov_type_desc = right.ProviderType,
											transform(Healthcare_Shared.Layouts.layout_sanctions, 
																		self.RegulatingBoard := if(RIGHT.RegulatingBoard <> '',RIGHT.RegulatingBoard,left.RegulatingBoard);
																		self:=left;
																		self:=[]),left outer,
											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			grpDate := dedup(sort(rawdatalookup4,acctno,InternalID,group_key,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,InternalID,group_key,sanc1_state,sanc1_lic_num);
			sanctions_final := join(rawdatalookup4,grpDate, left.acctno=right.acctno and left.group_key=right.group_key and left.InternalID = right.InternalID and
																	left.sanc1_state=right.sanc1_state and left.sanc1_lic_num=right.sanc1_lic_num,
																	transform(Healthcare_Shared.Layouts.layout_sanctions, self.GroupSancDate:=right.sanc1_date;self:=left;));
			//Set Sancid
			finalSort := dedup(sort(group(sort(sanctions_final,acctno,InternalID,group_key,-GroupSancDate,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,InternalID),record),record);
			Healthcare_Shared.Layouts.layout_sanctions addSeq(Healthcare_Shared.Layouts.layout_sanctions inp,integer C) := transform
				self.GroupSortOrder := C;
				self := inp;
			end;
			setGrpSortOrder := project(finalSort,addSeq(left,counter));
			final:=ungroup(sort(setGrpSortOrder,acctno,InternalID,group_key,GroupSortOrder));

			Healthcare_Shared.Layouts.layout_child_sanctions doRollup(Healthcare_Shared.Layouts.layout_sanctions l, dataset(Healthcare_Shared.Layouts.layout_sanctions) r) := TRANSFORM
				SELF.acctno := l.acctno;
				self.group_key := l.group_key;
				self.InternalID := l.InternalID;
				self.childinfo := r;
			END;
			grpSanc := group(sort(final,acctno,InternalID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,InternalID,group_key);
			sanctions_rollup := rollup(grpSanc,group,doRollup(left,rows(left)));
			results := join(inputRecs,sanctions_rollup, left.acctno=right.acctno and left.InternalID = right.InternalID,
																			transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																								SancRecs := sort(right.childinfo,acctno,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date);
																								self.Sanctions := SancRecs;
																								self.LegacySanctions := Healthcare_Shared.Functions.buildLegacySanctionRecord(left,SancRecs);
																								self.hasStateRestrict := exists(SancRecs(stateorfederal='STATE'));
																								self.hasOIG := exists(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OIG'));
																								self.hasOPM := exists(SancRecs(stateorfederal='FEDERAL' and SancLevel = 'OPM'));
																								self.acctno := left.acctno; self.internalid := left.internalid; self.lnpid := left.lnpid; self.lnfid:=left.lnfid;
																								self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		// OUTPUT(inputRecs,named('inputRecs'));
		// OUTPUT(allSanctions,named('allSanctions'));
		// OUTPUT(input,named('input'));
		// OUTPUT(finalSort,named('finalSort'));
		// OUTPUT(final,named('final'));
		// OUTPUT(sanctions_rollup,named('sanctions_rollup'));
		return results;
	end;
	Export getLegacySanctionsInfo(DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := function
		//needs to put in legacy format using logic from old datasource_selectfile
		getSanctions:=NORMALIZE(allRows, LEFT.Sanctions, TRANSFORM(Healthcare_Shared.Layouts.layout_Sanctions, self.InternalID:=left.InternalID; self.group_key:=left.vendorid;SELF := RIGHT));
		Healthcare_Shared.Layouts.layout_child_sanctions doRollup(Healthcare_Shared.Layouts.layout_sanctions l, dataset(Healthcare_Shared.Layouts.layout_sanctions) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.group_key := l.group_key;
			self.InternalID := l.InternalID;
			self.childinfo := r;
		END;
		grpSanc := group(sort(getSanctions,acctno,InternalID,group_key,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date),acctno,InternalID,group_key);
		sanctions_rollup := rollup(grpSanc,group,doRollup(left,rows(left)));
		results := join(allRows,sanctions_rollup, left.acctno=right.acctno and left.InternalID = right.InternalID,
																			transform(Healthcare_Shared.Layouts.CombinedHeaderResults,
																								SancRecs := sort(right.childinfo,acctno,GroupSortOrder,sanc1_state,sanc1_lic_num,-sanc1_date);
																								self.LegacySanctions := Healthcare_Shared.Functions.buildLegacySanctionRecord(left,SancRecs);
																								self := left),left outer,keep(Healthcare_Shared.Constants.IDS_PER_DID), limit(0));
		return results;
	end;
	Export getSanctionInfo(DATASET(Healthcare_Shared.Layouts.CombinedHeaderResults) allRows) := function
		getSanctions:=sort(dedup(NORMALIZE(allRows, LEFT.Sanctions, TRANSFORM(Healthcare_Shared.Layouts.layout_sanctions, SELF := RIGHT)),record,hash,all),GroupSortOrder);
		return getSanctions;
	end;
End;