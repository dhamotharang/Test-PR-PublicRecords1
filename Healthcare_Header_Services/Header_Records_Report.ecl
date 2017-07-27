Import Health_Facility_Services,BIPV2,BIPV2_Company_Names,HealthCareFacility,Healthcare_Header_Services;
EXPORT Header_Records_Report := module
	Export getHeaderReportRecords(dataset(Layouts.HeaderBusRequestLayoutPlus) ConvertedInputRaw) := Function
		SearchRpt := Project(ConvertedInputRaw,transform(Layouts.HeaderBusRequestLayout,self:=left));
		Health_Facility_Services.mac_xlinking_on_roxie_withinDistance_custom (SearchRpt, lnpid, comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,
															NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															RptHeaderResults,lnpid,false,false,Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE,Constants.HEADER_LOW_RECORD_LIMIT);	
		results:=project(RptHeaderResults,transform(Layouts.HeaderBusResponseLayout,self:=left;self:=[];));
		// output(SearchRpt,named('SearchRpt'));
		// output(RptHeaderResults,named('RptHeaderResults'));
		return results;
	end;
	Export getHeaderReportOrphanRecords(dataset(Layouts.HeaderBusRequestLayoutPlus) ConvertedInputRaw) := Function
		SearchOrphans := Project(ConvertedInputRaw,transform(Layouts.HeaderBusRequestLayout,self:=left));
		Health_Facility_Services.mac_xlinking_on_roxie_withinDistance_recs (SearchOrphans,lnpid,comp_name,
															PRIM_Name,PRIM_Range,SEC_RANGE,v_city_name,ST,ZIP,
															TAX_ID,TAX_ID,PHONE,PHONE,LIC_STATE,LIC_NBR,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,CLIANumber,
															MedicareNumber,MedicareNumber,NCPDPNumber,Taxonomy,BDID,SRC,SOURCE_RID,
															OrphanHeaderResults,lnpid,false,false,Constants.HEADER_BUS_SCORE_LIC_ONLY_THRESHOLD,Constants.HEADER_BUS_CLOSE_MATCH_SCORE);	
		results:=project(OrphanHeaderResults,transform(Layouts.HeaderBusResponseLayout,self.ambiguous := false;self:=left;self:=[];));
		// output(SearchOrphans,named('SearchOrphans'));
		// output(OrphanHeaderResults,named('OrphanHeaderResults'));
		return results;
	end;
	Export getHdrReportBIPKeys(dataset(Layouts.autokeyInput) ConvertedInputRaw,dataset(Layouts.common_runtime_config) cfg) := Function
		convertInput := project(ConvertedInputRaw,Transforms.createBusHeaderRequest(left,cfg));
		hdr_lnpids:= project(getHeaderReportRecords(convertInput),Transforms.xformBusHdrLNPids(left)); //Get header lnpids
		MyFormat := RECORD
			hdr_lnpids.ultid;
			hdr_lnpids.orgid;
			hdr_lnpids.seleid;
			hdr_lnpids.proxid;
			Freq := Count(Group);
		END;
		//Create a table of only valid BIP keys (ultid>0) and count the results to find the set that occurs most frequently
		myTableRecs := sort(TABLE(hdr_lnpids(ultid>0),MyFormat,ultid,orgid,seleid,proxid,Few),-freq);
		//Filter the original resultset to those records that match the most frequent key set and dedup.
		results := dedup(join(hdr_lnpids,myTableRecs(freq=myTableRecs[1].freq),
														left.ultid=right.ultid and left.orgid=right.orgid and left.seleid=right.seleid and left.proxid=right.proxid,
														transform(Layouts.searchKeyResults,
																			self.isBIPOrphan := left.UltID = left.orgid and left.UltID = left.seleid and left.UltID = left.proxid;
																			self:=left)),ultid,orgid,seleid,proxid,all);
		// Are there any non-Orphan records?
		NonOrphanFound := results(isBIPOrphan = false);
		// If we found a non orphan record we will use that if not, get raw data for Orphan Records
		LookupRecs := if(exists(NonOrphanFound),dataset([],Layouts.HeaderBusResponseLayout),getHeaderReportOrphanRecords(convertInput));
		//Get the BIP Records for this criteria
		BipLookup := dedup(sort(project(LookupRecs(address_classification <> 'M'),transform(Healthcare_Header_Services.Layouts.autokeyInput, 
										self.acctno:=(string)left.uniqueid;
										self.comp_name := left.cname;
										self.prim_range := left.prim_range;
										self.prim_name := left.prim_name;
										self.sec_range := left.sec_range;
										self.z5 := left.zip;
										self.p_city_name := left.p_city_name;
										self.st :=left.st;
										self.workphone:=left.phone;
										self.fein:=(string)left.FEIN;
										self := [];)),record),record);
		getBipLookupAddress := dedup(sort(BipLookup,prim_range,prim_name,sec_range,p_city_name,st,z5),prim_range,prim_name,sec_range,p_city_name,st,z5);
		rawRecsAddress := Healthcare_Header_Services.Datasource_Boca_Bus_Header.get_BIP_Records(getBipLookupAddress);
		BipBest := rawRecsAddress(isBestBIPResult=true);
		BipSlim := project(if(exists(BipBest),BipBest[1].bipkeys,rawRecsAddress[1].bipkeys),transform(BIPV2.IDlayouts.l_xlink_ids,
																						self.UltID := left.UltID;
																						self.OrgID := left.OrgID;
																						self.SELEID := left.SELEID;
																						self.ProxID := left.ProxID;
																						self := [];));
		finalresults := project(results,transform(Layouts.searchKeyResults,
																								self.OrphanAltUltID := BipSlim[1].ultid;
																								self.OrphanAltOrgID := BipSlim[1].orgid;
																								self.OrphanAltSeleID := BipSlim[1].seleid;
																								self.OrphanAltProxID := BipSlim[1].ProxID;
																								self:=left));
		// output(hdr_lnpids,named('hdr_lnpids'));
		// output(myTableRecs,named('myTableRecs'));
		// output(results,named('hdr_lnpids_Filtered'));
		// output(NonOrphanFound,named('NonOrphanFound'));
		// output(LookupRecs,named('LookupRecs'));
		// output(BipLookup,named('BipLookup'));
		// output(getBipLookupAddress,named('getBipLookupAddress'));
		// output(rawRecsAddress,named('rawRecsAddress'));
		// output(BipBest,named('BipBest'));
		// output(BipSlim,named('BipSlim'));
		// output(finalresults,named('finalresults'));
		return finalresults;
	end;
End;