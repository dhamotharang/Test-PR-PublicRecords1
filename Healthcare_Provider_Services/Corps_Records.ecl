import iesp,doxie,doxie_cbrs,dca,PersonReports;
export Corps_Records (dataset(doxie.layout_references) dsDids, dataset(doxie.layout_ref_bdid) dsBdids) := module
	shared getCorpRec(dataset(doxie_cbrs.layout_references) dsBdids) := function
			baseCorp:= DCA.Key_DCA_BDID(bdid=dsBdids[1].bdid);
			exec1 := if(baseCorp[1].name_1<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec1_fname, left.exec1_mname, left.exec1_lname, left.exec1_name_suffix, left.exec1_title, if(left.name_1<>'',left.name_1,left.exec1_fname+' '+left.exec1_mname+' '+left.exec1_lname+' '+left.exec1_name_suffix));
																								 self.Title:=left.title_1;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec2 := if(baseCorp[1].name_2<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec2_fname, left.exec2_mname, left.exec2_lname, left.exec2_name_suffix, left.exec2_title, if(left.name_2<>'',left.name_2,left.exec2_fname+' '+left.exec2_mname+' '+left.exec2_lname+' '+left.exec2_name_suffix));
																								 self.Title:=left.title_2;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec3 := if(baseCorp[1].name_3<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec3_fname, left.exec3_mname, left.exec3_lname, left.exec3_name_suffix, left.exec3_title, if(left.name_3<>'',left.name_3,left.exec3_fname+' '+left.exec3_mname+' '+left.exec3_lname+' '+left.exec3_name_suffix));
																								 self.Title:=left.title_3;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec4 := if(baseCorp[1].name_4<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec4_fname, left.exec4_mname, left.exec4_lname, left.exec4_name_suffix, left.exec4_title, if(left.name_4<>'',left.name_4,left.exec4_fname+' '+left.exec4_mname+' '+left.exec4_lname+' '+left.exec4_name_suffix));
																								 self.Title:=left.title_4;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec5 := if(baseCorp[1].name_5<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec5_fname, left.exec5_mname, left.exec5_lname, left.exec5_name_suffix, left.exec5_title, if(left.name_5<>'',left.name_5,left.exec5_fname+' '+left.exec5_mname+' '+left.exec5_lname+' '+left.exec5_name_suffix));
																								 self.Title:=left.title_5;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec6 := if(baseCorp[1].name_6<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec6_fname, left.exec6_mname, left.exec6_lname, left.exec6_name_suffix, left.exec6_title, if(left.name_6<>'',left.name_6,left.exec6_fname+' '+left.exec6_mname+' '+left.exec6_lname+' '+left.exec6_name_suffix));
																								 self.Title:=left.title_6;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec7 := if(baseCorp[1].name_7<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec7_fname, left.exec7_mname, left.exec7_lname, left.exec7_name_suffix, left.exec7_title, if(left.name_7<>'',left.name_7,left.exec7_fname+' '+left.exec7_mname+' '+left.exec7_lname+' '+left.exec7_name_suffix));
																								 self.Title:=left.title_7;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec8 := if(baseCorp[1].name_8<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec8_fname, left.exec8_mname, left.exec8_lname, left.exec8_name_suffix, left.exec8_title, if(left.name_8<>'',left.name_8,left.exec8_fname+' '+left.exec8_mname+' '+left.exec8_lname+' '+left.exec8_name_suffix));
																								 self.Title:=left.title_8;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec9 := if(baseCorp[1].name_9<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec9_fname, left.exec9_mname, left.exec9_lname, left.exec9_name_suffix, left.exec9_title, if(left.name_9<>'',left.name_9,left.exec9_fname+' '+left.exec9_mname+' '+left.exec9_lname+' '+left.exec9_name_suffix));
																								 self.Title:=left.title_9;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			exec10 := if(baseCorp[1].name_10<>'',project(baseCorp[1], transform(iesp.bpsreport.t_BpsCorpAffiliation, 
																								 self.BusinessId:=(string)left.bdid;
																								 self.CompanyName:=if(left.parent_name<>'',left.parent_name,left.name);
																								 self.Name := iesp.ECL2ESP.SetName(left.exec10_fname, left.exec10_mname, left.exec10_lname, left.exec10_name_suffix, left.exec10_title, if(left.name_10<>'',left.name_10,left.exec10_fname+' '+left.exec10_mname+' '+left.exec10_lname+' '+left.exec10_name_suffix));
																								 self.Title:=left.title_10;
																								 self.Address := iesp.ECL2ESP.SetAddress(left.prim_name, left.prim_range, left.predir, left.postdir, 
																																												 left.addr_suffix, left.unit_desig, left.sec_range, left.v_city_name,
																																												 left.st, left.z5, left.zip4, '', '', left.street, '', '');
																								 self.Phones:=dataset([{left.phone}],iesp.share.t_StringArrayItem);
																								 self := [])));
			
			corpCombined := exec1+exec2+exec3+exec4+exec5+exec6+exec7+exec8+exec9+exec10;
			corpStatus:=sort(doxie_cbrs.business_registration_records(dsBdids)(status_decode<>''),-file_date_decode,filing_num,status)[1];
			corpCombinedWithStatus := project(corpCombined(BusinessId<>''), transform(iesp.bpsreport.t_BpsCorpAffiliation, self.Status:=corpStatus.status,self.StatusDescription:=corpStatus.status_Decode,self.FilingDate:=iesp.ECL2ESP.toDatestring8(corpStatus.file_date_decode),self.RecordDate:=iesp.ECL2ESP.toDatestring8(corpStatus.record_date),self:=left));
			corpNumb:=doxie_cbrs.Corporation_Filings_records_v2(dsBdids).report_view()[1];
			corpCombinedWithCorpNum := project(corpCombinedWithStatus, transform(iesp.bpsreport.t_BpsCorpAffiliation, self.State:=corpNumb.corp_state_origin,self.CorporationNumber:=corpNumb.corp_orig_sos_charter_nbr,self:=left));
			return corpCombinedWithCorpNum;
	end;
	dsCorporateAffiliationsRaw := choosen(PersonReports.CorpAffiliation_records(dsDids),iesp.Constants.BR.MaxCorpAffiliations);
	export dsCorporateAffiliations := project(dsCorporateAffiliationsRaw, transform(iesp.bpsreport.t_BpsCorpAffiliation, self:=if(trim(left.RecordType,all) <> '' or trim(left.CompanyName,all) <> '' or trim(left.StatusDescription,all) <> '',left)));
	dsBusinessCorporateRecordsRaw := if(exists(dsBdids(bdid>0)),choosen(getCorpRec(Project(dsBdids,doxie_cbrs.layout_references)),iesp.Constants.BR.MaxCorpAffiliations));
	export dsBusinessCorporateRecords := project(dsBusinessCorporateRecordsRaw,transform(iesp.bpsreport.t_BpsCorpAffiliation, self:=if(trim(left.CompanyName,all) <> '' or trim(left.Title,all) <> '' or trim(left.BusinessId,all) <> '',left)));
end;
