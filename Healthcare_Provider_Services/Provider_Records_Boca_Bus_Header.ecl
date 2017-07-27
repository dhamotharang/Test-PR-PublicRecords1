import BatchServices,Business_Header;
EXPORT Provider_Records_Boca_Bus_Header := Module
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	Export get_boca_bus_header_base (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) input, dataset(mylayouts.autokeyInput) srcInput, UNSIGNED1 penalt):= function
			defaults := BatchServices.RollupBusiness_BatchService_Constants.Defaults;
			BusRollupArgs := MODULE(BatchServices.RollupBusiness_BatchService_Interfaces.Input)
				EXPORT DPPAPurpose := 0;
				EXPORT GLBPurpose := 8;
				EXPORT FuzzinessDial := defaults.FUZZINESSDIAL;
				EXPORT PenaltThreshold := defaults.PENALTTHRESHOLD;
				EXPORT MaxResultsPerRow := defaults.MAXRESULTSPERROW;
			 END;
			//Bus Deep Dive Logic
			convertedInput := project(input(comp_name <> ''),myTransforms.convertToBusinessRollup(left));
			busRecs := project(BatchServices.RollupBusiness_BatchService_Records(convertedInput,BusRollupArgs).Records,BatchServices.RollupBusiness_BatchService_Layouts.Final);
			getBDid := join(busRecs,Business_Header.Key_BH_SuperGroup_GroupID,left.groupid=right.group_id,transform(recordof(Business_Header.Key_BH_SuperGroup_GroupID),self:=right),keep(myConst.MAX_RECS_ON_JOIN), limit(0));
			baseRecs := join(busRecs, getBDid, left.groupid = right.group_id, transform(Healthcare_Provider_Services.Layouts.CombinedHeaderResults, 
																self.acctno := left.acctno;
																self.sources := dataset([{left.best_fein,Healthcare_Provider_Services.Constants.SRC_BOCA_BUS_HEADER}],Healthcare_Provider_Services.Layouts.layout_SrcID);
																self.HCID := (integer)left.best_fein;
																self.srcid := (integer)left.best_fein;
																self.src := Healthcare_Provider_Services.Constants.SRC_BOCA_BUS_HEADER;
																self.names := dataset([{1,0,left.best_company_name,'','','','','',''},
																											 {2,0,left.company_name_var1,'','','','','',''},
																											 {3,0,left.company_name_var2,'','','','','',''},
																											 {4,0,left.company_name_var3,'','','','','',''},
																											 {5,0,left.company_name_var4,'','','','','',''},
																											 {6,0,left.company_name_var5,'','','','','',''},
																											 {7,0,left.company_name_var6,'','','','','',''},
																											 {8,0,left.company_name_var7,'','','','','',''},
																											 {9,0,left.company_name_var8,'','','','','',''},
																											 {10,0,left.company_name_var9,'','','','','',''}],Healthcare_Provider_Services.Layouts.layout_nameinfo)(CompanyName<>'');
																self.Addresses := dataset([{1,0,'','','','','',0,'','',
																											left.best_prim_range,left.best_predir,left.best_prim_name,left.best_addr_suffix,left.best_postdir,
																											left.best_unit_desig,left.best_sec_range,left.best_city,left.best_city,left.best_state,left.best_zip,left.best_zip4,
																											left.best_dt_last_seen,left.best_dt_first_seen,'','','','',left.best_phone,''},
																											{2,0,'','','','','',0,'','',
																											left.prim_range_var1,left.predir_var1,left.prim_name_var1,left.addr_suffix_var1,left.postdir_var1,
																											left.unit_desig_var1,left.sec_range_var1,left.city_var1,left.city_var1,left.state_var1,left.zip_var1,left.zip4_var1,
																											left.dt_last_seen_var1,left.dt_first_seen_var1,'','','','',left.phone_var1,''},
																											{3,0,'','','','','',0,'','',
																											left.prim_range_var2,left.predir_var2,left.prim_name_var2,left.addr_suffix_var2,left.postdir_var2,
																											left.unit_desig_var2,left.sec_range_var2,left.city_var2,left.city_var2,left.state_var2,left.zip_var2,left.zip4_var2,
																											left.dt_last_seen_var2,left.dt_first_seen_var2,'','','','',left.phone_var2,''},
																											{4,0,'','','','','',0,'','',
																											left.prim_range_var3,left.predir_var3,left.prim_name_var3,left.addr_suffix_var3,left.postdir_var3,
																											left.unit_desig_var3,left.sec_range_var3,left.city_var3,left.city_var3,left.state_var3,left.zip_var3,left.zip4_var3,
																											left.dt_last_seen_var3,left.dt_first_seen_var3,'','','','',left.phone_var3,''},
																											{5,0,'','','','','',0,'','',
																											left.prim_range_var4,left.predir_var4,left.prim_name_var4,left.addr_suffix_var4,left.postdir_var4,
																											left.unit_desig_var4,left.sec_range_var4,left.city_var4,left.city_var4,left.state_var4,left.zip_var4,left.zip4_var4,
																											left.dt_last_seen_var4,left.dt_first_seen_var4,'','','','',left.phone_var4,''},
																											{6,0,'','','','','',0,'','',
																											left.prim_range_var5,left.predir_var5,left.prim_name_var5,left.addr_suffix_var5,left.postdir_var5,
																											left.unit_desig_var5,left.sec_range_var5,left.city_var5,left.city_var5,left.state_var5,left.zip_var5,left.zip4_var5,
																											left.dt_last_seen_var5,left.dt_first_seen_var5,'','','','',left.phone_var5,''},
																											{7,0,'','','','','',0,'','',
																											left.prim_range_var6,left.predir_var6,left.prim_name_var6,left.addr_suffix_var6,left.postdir_var6,
																											left.unit_desig_var6,left.sec_range_var6,left.city_var6,left.city_var6,left.state_var6,left.zip_var6,left.zip4_var6,
																											left.dt_last_seen_var6,left.dt_first_seen_var6,'','','','',left.phone_var6,''},
																											{8,0,'','','','','',0,'','',
																											left.prim_range_var7,left.predir_var7,left.prim_name_var7,left.addr_suffix_var7,left.postdir_var7,
																											left.unit_desig_var7,left.sec_range_var7,left.city_var7,left.city_var7,left.state_var7,left.zip_var7,left.zip4_var7,
																											left.dt_last_seen_var7,left.dt_first_seen_var7,'','','','',left.phone_var7,''},
																											{9,0,'','','','','',0,'','',
																											left.prim_range_var8,left.predir_var8,left.prim_name_var8,left.addr_suffix_var8,left.postdir_var8,
																											left.unit_desig_var8,left.sec_range_var8,left.city_var8,left.city_var8,left.state_var8,left.zip_var8,left.zip4_var8,
																											left.dt_last_seen_var8,left.dt_first_seen_var8,'','','','',left.phone_var8,''},
																											{10,0,'','','','','',0,'','',
																											left.prim_range_var9,left.predir_var9,left.prim_name_var9,left.addr_suffix_var9,left.postdir_var9,
																											left.unit_desig_var9,left.sec_range_var9,left.city_var9,left.city_var9,left.state_var9,left.zip_var9,left.zip4_var9,
																											left.dt_last_seen_var9,left.dt_first_seen_var9,'','','','',left.phone_var9,''}],Healthcare_Provider_Services.Layouts.layout_addressinfo)(prim_name<>'');
																self.bdids := dataset([{right.bdid}],Healthcare_Provider_Services.Layouts.layout_bdid)(bdid>0);
																self.feins := dataset([{left.best_fein},{left.fein_var1},
																											 {left.fein_var2},{left.fein_var3},
																											 {left.fein_var4},{left.fein_var5},
																											 {left.fein_var6},{left.fein_var7},
																											 {left.fein_var8},{left.fein_var9}],Healthcare_Provider_Services.Layouts.layout_fein)(fein<>'');
																self:=left; self:=[]),left outer);
			bocaBusHeader_final_sorted := sort(baseRecs, acctno, HCID, Src);
			bocaBusHeader_final_grouped := group(bocaBusHeader_final_sorted, acctno, HCID, Src);
			bocaBusHeader_rolled := rollup(bocaBusHeader_final_grouped, group, myTransforms.doBocaBusHeaderBaseRecordSrcIdRollup(left,rows(left)));			
			return bocaBusHeader_rolled;
	end;
end;
