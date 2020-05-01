import BatchServices,Business_Header,ut,BIPV2,std,AutoStandardI;
EXPORT Datasource_Boca_Bus_Header := Module
	// Recode to hit BIP Header...
	Shared CurrentYYMM := ((STRING8)Std.Date.Today())[1..6];
	Export get_BIP_Records (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = dataset([],Layouts.common_runtime_config)) := function
		//Project input into Bip format
		mod_access:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);      
		recFmt := BIPV2.IDfunctions.rec_SearchInput;
		dsExact := project(input,transform(recFmt, 
										self.acctno:=left.acctno;
										self.company_name := left.comp_name;
										self.prim_range := left.prim_range;
										self.prim_name := left.prim_name;
										self.sec_range := left.sec_range;
										self.zip5 := left.z5;
										self.city := left.p_city_name;
										self.state :=left.st;
										self.phone10:=left.workphone;
										self.fein:=left.FEIN;
										self.results_limit:=Constants.BUS_NAME_BIP_MAX_RECS_THRESHOLD;
										self := [];));
		dsAddress := project(input,transform(recFmt, 
										self.acctno:=left.acctno;
										self.prim_range := left.prim_range;
										self.prim_name := left.prim_name;
										self.sec_range := left.sec_range;
										self.zip5 := left.z5;
										self.city := left.p_city_name;
										self.state :=left.st;
										self.phone10:=left.workphone;
										self.fein:=left.FEIN;
										self.results_limit:=Constants.BUS_NAME_BIP_MAX_RECS_THRESHOLD;
										self := [];));
		rawRecsExact := BIPV2.IdFunctions.fn_IndexedSearchForXLinkIDs(dsExact).SearchKeyData(mod_access);
		rawRecsAddress := BIPV2.IdFunctions.fn_IndexedSearchForXLinkIDs(dsAddress).SearchKeyData(mod_access);
		// Ok, so find those records at the same address that are likely the same company
		BipAddressInput := join(input,dedup(rawRecsExact(company_name<>''),acctno,all), left.acctno=right.acctno, transform(Layouts.autokeyInput, self.bipExactFound:=true, self:=left), left outer,keep(Constants.BUS_NAME_BIPMATCH_THRESHOLD), limit(0));
		BipRawAddressLimit := join(input,rawRecsAddress(company_name<>''), left.acctno=right.acctno, transform(recordof(rawRecsAddress), self := right),keep(Constants.BUS_NAME_BIPMATCH_THRESHOLD), limit(0));
		rawRecsAddressMatch := Join(BipRawAddressLimit,BipAddressInput, left.acctno=right.acctno, transform(recordof(rawRecsAddress), 
																								setThreshold := if(right.bipExactFound,Constants.BUS_NAME_BIPMATCH_ADDR_THRESHOLD,Constants.BUS_NAME_BIPMATCH_THRESHOLD);
																								RecordYYMM:=((STRING)left.dt_last_seen)[1..6];
																								RecordAge := ut.MonthsApart(CurrentYYMM,RecordYYMM);
																								keepRec := Functions.CompareBusinessNameConfidence(left.company_name,right.comp_name)> setThreshold and RecordAge < 24;
																								self.company_name := if(keepRec,left.company_name,skip);
																								self :=left),keep(Constants.BUS_NAME_BIPMATCH_THRESHOLD), limit(0));
		finalRecs := rawRecsExact(company_name<>'')+rawRecsAddressMatch(company_name<>'');
		baseRecs := join(finalRecs, input, left.acctno = right.acctno, transform(Layouts.CombinedHeaderResults, 
																	name1 := project(left,transform(Layouts.layout_nameinfo,
																																		self.nameSeq := 10;
																																		self.namePenalty := 100-Functions.CompareBusinessNameConfidence(left.company_name,right.comp_name);
																																		self.CompanyName := left.company_name;));
																	name2 := project(left,transform(Layouts.layout_nameinfo,
																																		self.nameSeq := 11;
																																		self.namePenalty := 100-Functions.CompareBusinessNameConfidence(left.cnp_name,right.comp_name);
																																		self.CompanyName := left.cnp_name;));
																	CombinedNames := 	name1+name2;																
																	Address1 := project(left,transform(Layouts.layout_addressinfo,
																													self.addrSeq := Constants.ADDR_SEQ_DEEPDIVE;
																													self.address1 := Functions.buildAddress(left.prim_range,left.predir,Functions.cleanWord(left.prim_name),left.addr_suffix,left.postdir,left.unit_desig,left.sec_range);
																													self.prim_range := left.prim_range;
																													self.predir := left.predir;
																													self.prim_name := if(left.prim_name = '',skip,STD.Str.FilterOut(left.prim_name,'[,/\\#:%\\(\\)*-]'));
																													self.addr_suffix := left.addr_suffix;
																													self.postdir := left.postdir;
																													self.unit_desig := left.unit_desig;
																													self.sec_range := left.sec_range;
																													self.p_city_name := left.p_city_name;
																													self.v_city_name := left.v_city_name;
																													self.st := left.st;
																													self.z5 := left.zip;
																													self.zip4 := left.zip4;
																													self.last_seen := (string)left.dt_last_seen;
																													self.first_seen := (string)left.dt_first_seen;
																													isPhone := left.phone_type = 'T';
																													isFax := left.phone_type not in ['T',''];
																													self.PhoneNumber := if (isPhone, left.company_phone, '');
																													self.FaxNumber := if (isFax, left.company_phone, '');
																													self.Phones := dataset([{if(isPhone,left.company_phone,''),if(isFax,left.company_phone,'')}],Layouts.layout_addressphone);
																													));
																	self.acctno := left.acctno;
																	self.sources := dataset([{left.proxid,Constants.SRC_BOCA_BUS_HEADER}],Layouts.layout_SrcID);
																	self.LNPID := (integer)left.proxid;
																	self.srcid := (integer)left.proxid;
																	self.src := Constants.SRC_BOCA_BUS_HEADER;
																	self.names := CombinedNames(CompanyName<>'');
																	self.Addresses := Address1;
																	self.bipkeys := project(left,transform(Layouts.layout_bipkeys,
																																	self.dotid:=0; self.empid:=0;
																																	self := left; self:=[]));
																	self.bdids := dataset([{left.company_bdid}],Layouts.layout_bdid)(bdid>0);
																	self.feins := dataset([{left.company_fein}],Layouts.layout_fein)(fein<>'');
																	Self.SrcRecRaw :=  project(left,transform(Layouts.layout_SrcRec,
																																	self.Src := constants.SRC_BOCA_BUS_HEADER;
																																	self.nameSeq := 10;
																																	self.namePenalty := 100-Functions.CompareBusinessNameConfidence(left.company_name,right.comp_name);
																																	self.CompanyName := left.company_name;
																																	self.addrSeq := Constants.ADDR_SEQ_DEEPDIVE;
																																	self.address1 := Functions.buildAddress(left.prim_range,left.predir,left.prim_name,left.addr_suffix,left.postdir,left.unit_desig,left.sec_range);
																																	self.prim_range := left.prim_range;
																																	self.predir := left.predir;
																																	self.prim_name := left.prim_name;
																																	self.addr_suffix := left.addr_suffix;
																																	self.postdir := left.postdir;
																																	self.unit_desig := left.unit_desig;
																																	self.sec_range := left.sec_range;
																																	self.p_city_name := left.p_city_name;
																																	self.v_city_name := left.v_city_name;
																																	self.st := left.st;
																																	self.z5 := left.zip;
																																	self.zip4 := left.zip4;
																																	self.last_seen := (string)left.dt_last_seen;
																																	self.first_seen := (string)left.dt_first_seen;
																																	isPhone := left.phone_type = 'T';
																																	isFax := left.phone_type not in ['T',''];
																																	self.PhoneNumber := if (isPhone, left.company_phone, '');
																																	self.FaxNumber := if (isFax, left.company_phone, '');
																																	self.Phones := dataset([{if(isPhone,left.company_phone,''),if(isFax,left.company_phone,'')}],Layouts.layout_addressphone);
																																	self.bdid := (integer)left.company_bdid;
																																	self.fein := left.company_fein;
																																	self := left;
																																	self:=[];));
																	self:=left; self:=[]),left outer,keep(Constants.MAX_SEARCH_RECS), limit(0));
		bestrec := RECORD
			string acctno;
			unsigned8 proxid;
		END;
		BestRecTable := table(sort(project(finalRecs,transform(bestrec, self:=left)),acctno,proxid),{acctno,proxid,Cnt:=COUNT(GROUP)},acctno,proxid,few);
		BestRecSort := sort(BestRecTable,acctno,-cnt);
		BestRecDedup := dedup(BestRecSort,acctno);
		markBestBase := join(baseRecs,BestRecDedup,left.acctno=right.acctno and left.lnpid=right.proxid, 
																			transform(Layouts.CombinedHeaderResults, self.isBestBIPResult:=true,self:=left),
																			keep(Constants.MAX_SEARCH_RECS), limit(0));
		marknotBestBestBase := join(baseRecs,markBestBase,left.acctno=right.acctno and left.lnpid=right.lnpid, 
																			transform(Layouts.CombinedHeaderResults, self.isBestBIPResult:=false,self:=left),
																			left only);
		bocaBusHeader_final_sorted := sort(markBestBase+marknotBestBestBase, acctno, LNPID, Src);
		// output(dsExact,named('dsExactbocaBusHeader'),extend);
		// output(rawRecsExact,named('rawRecsExactbocaBusHeader'),extend);
		// output(dsAddress,named('dsAddressbocaBusHeader'),extend);
		// output(rawRecsAddress,named('rawRecsAddressbocaBusHeader'),extend);
		// output(rawRecsAddressMatch,named('rawRecsAddressMatchbocaBusHeader'),extend);
		// output(finalRecs,named('finalRecsbocaBusHeader'),extend);
		// output(baseRecs,named('baseRecsbocaBusHeader'),extend);
		// output(BestRecTable,named('BestRecTablebocaBusHeader'),extend);
		// output(markBestBase,named('markBestBasebocaBusHeader'),extend);
		// output(marknotBestBestBase,named('marknotBestBestBasebocaBusHeader'),extend);
		//output(bocaBusHeader_final_sorted,named('bocaBusHeader_final_sorted'),extend);
		return bocaBusHeader_final_sorted;
	End;
	Export get_boca_bus_header_entity (dataset(Layouts.autokeyInput) input, dataset(Layouts.common_runtime_config) cfg = dataset([],Layouts.common_runtime_config)):= function
		// output(input,named('bocaBusHeader_input'));
		bocaBusHeader_final_sorted := get_BIP_Records(input,cfg);
		bocaBusHeader_final_grouped := group(bocaBusHeader_final_sorted, acctno, LNPID);
		bocaBusHeader_rolled := rollup(bocaBusHeader_final_grouped, group, Transforms.doBocaBusHeaderBaseRecordSrcIdRollup(left,rows(left)));			
		return bocaBusHeader_rolled;
	end;
end;
