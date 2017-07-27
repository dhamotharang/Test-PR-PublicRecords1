import versioncontrol, business_header;
export keynames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module
	
	export lDatasetTuplet		:= '@dataset@';
	export lKeyFieldsTuplet	:= '@fields@'	;

	shared lKeyTemplate		:= business_header.Bus_Thor(pUseProd) + 'key::@dataset@::@version@::@fields@';

	export fReturnkeyname(string pTemplatename, string pDataset, string pKeyFields) :=
  function
		// dataset replacement
		out1 := regexreplace(lDatasetTuplet		,pTemplatename	,pDataset);
		// fields replacement
		out2 := regexreplace(lKeyFieldsTuplet	,out1			,pKeyFields);

	return out2;
	end;
	
	export NewCASalesTaxBdid						:= fReturnkeyname(lKeyTemplate	,'salestax'							,'ca::bdid'		);
  export NewCASalesTaxLinkids     		:= fReturnkeyname(lKeyTemplate	,'salestax'							,'ca::linkids');
	export NewIASalesTaxBdid						:= fReturnkeyname(lKeyTemplate	,'salestax'							,'ia::bdid'		);
	export NewIASalesTaxLinkIDs					:= fReturnkeyname(lKeyTemplate	,'salestax'							,'ia::LinkIDs');
	export NewFDICBdid 									:= fReturnkeyname(lKeyTemplate	,'fdic'									,'bdid'				);
	export NewFDICLinkIDs								:= fReturnkeyname(lKeyTemplate	,'fdic'									,'LinkIDs'		);
	export NewFL_FBNBdid								:= fReturnkeyname(lKeyTemplate	,'fl_fbn'								,'bdid'				);
	export NewFL_FBNLinkIDs							:= fReturnkeyname(lKeyTemplate	,'fl_fbn'								,'LinkIDs'		);
	export NewFL_NonprofitBdid					:= fReturnkeyname(lKeyTemplate	,'fl_nonprofit'					,'bdid'				);
	export NewFL_NonprofitLinkIDs				:= fReturnkeyname(lKeyTemplate	,'fl_nonprofit'					,'LinkIDs'		);
	export NewEmployeeDirsBdid					:= fReturnkeyname(lKeyTemplate	,'employee_directories'	,'bdid'				);
	export NewEmployeeDirsLinkIDs				:= fReturnkeyname(lKeyTemplate	,'employee_directories'	,'LinkIDs'		);
	export NewIRS_NonprofitBdid					:= fReturnkeyname(lKeyTemplate	,'irsnonprofit'					,'bdid'				);
	export NewIRS_NonprofitLinkIDs			:= fReturnkeyname(lKeyTemplate	,'irsnonprofit'				  ,'LinkIDs'		);
	export NewMs_workers_CompBdid				:= fReturnkeyname(lKeyTemplate	,'ms_workers_comp'			,'bdid'				);
  export NewMs_workers_CompLinkids		:= fReturnkeyname(lKeyTemplate	,'ms_workers_comp'			,'LinkIDs'		);
	export NewOr_workers_CompBdid				:= fReturnkeyname(lKeyTemplate	,'or_workers_comp'			,'bdid'				);
	export NewOr_workers_CompLinkIDs		:= fReturnkeyname(lKeyTemplate	,'or_workers_comp'			,'linkids'		);
	export NewSec_broker_dealerBdid			:= fReturnkeyname(lKeyTemplate	,'sec_broker_dealer'		,'bdid'				);
	export NewSec_broker_dealerLinkIDs	:= fReturnkeyname(lKeyTemplate	,'sec_broker_dealer'		,'LinkIDs'		);

	shared lKeyRoot		:= Thor_cluster + 'key::';

	export CASalesTaxBdid					 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ca_sales_tax_bdid'			,pversion, newCASalesTaxBdid				);
	export CASalesTaxLinkids			 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ca_sales_tax_linkids'		,pversion, newCASalesTaxLinkids			);
	export IASalesTaxBdid					 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ia_sales_tax_bdid'			,pversion, newIASalesTaxBdid				);
	export IASalesTaxLinkIDs			 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ia_sales_tax_LinkIDs'		,pversion, newIASalesTaxLinkIDs			);
	export FDICBdid 							 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'govdata_fdic_bdid'			,pversion, newFDICBdid 							);
	export FDICLinkIDs 						 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'govdata_fdic_LinkIDs'		,pversion, newFDICLinkIDs 					);
	export FL_FBNBdid							 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'fl_fbn_bdid'						,pversion, newFL_FBNBdid						);
	export FL_FBNLinkIDs					 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'fl_fbn_LinkIDs'					,pversion, newFL_FBNLinkIDs					);
	export FL_NonprofitBdid				 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'fl_nonprofit_bdid'			,pversion, newFL_NonprofitBdid			);
	export FL_NonprofitLinkIDs		 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'fl_nonprofit_LinkIDs'		,pversion, newFL_NonprofitLinkIDs		);
	export EmployeeDirsBdid				 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'gov_phones_bdid'				,pversion, newEmployeeDirsBdid			);
	export EmployeeDirsLinkIDs		 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'gov_phones_LinkIDs'			,pversion, NewEmployeeDirsLinkIDs		);
	export IRS_NonprofitBdid			 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'irs_nonprofit_bdid'			,pversion, newIRS_NonprofitBdid			);
	export IRS_NonprofitLinkIDs		 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'irs_nonprofit_linkids'	,pversion, newIRS_NonprofitLinkIDs	);
	export Ms_workers_CompBdid		 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ms_workers_comp_BDID'		,pversion, newMs_workers_CompBdid		);
	export Ms_workers_CompLinkids  := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'ms_workers_comp_LinkIDs',pversion, NewMs_workers_CompLinkids);
	export Or_workers_CompBdid		 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'or_workers_comp_bdid'		,pversion, newOr_workers_CompBdid		);
	export Or_workers_CompLinkIDs	 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'or_workers_comp_linkids',pversion, newOr_workers_CompLinkIDs);
	export Sec_broker_dealerBdid	 := versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'sec_broker_dealer_bdid'	,pversion, newSec_broker_dealerBdid	);
	export Sec_broker_dealerLinkIDs:= versioncontrol.mBuildFilenameVersionsOld(lKeyRoot + 'sec_broker_dealer_LinkIDs'	,pversion, newSec_broker_dealerLinkIDs	);

	export dAll_filenames := 
			CASalesTaxBdid.dAll_filenames
		+ CASalesTaxLinkids.dAll_filenames			
		+ IASalesTaxBdid.dAll_filenames
		+ IASalesTaxLinkids.dAll_filenames
		+ FDICBdid.dAll_filenames
		+ FDICLinkIDs.dAll_filenames
		+ FL_FBNBdid.dAll_filenames
		+ FL_FBNLinkIDs.dAll_filenames
		+ FL_NonprofitBdid.dAll_filenames
		+ FL_NonprofitLinkIDs.dAll_filenames
		+ EmployeeDirsBdid.dAll_filenames
		+ EmployeeDirsLinkIDs.dAll_filenames
		+ IRS_NonprofitBdid.dAll_filenames
		+ IRS_NonprofitLinkIDs.dAll_filenames
		+ Ms_workers_CompBdid.dAll_filenames
		+ Ms_workers_CompLinkids.dAll_filenames
		+ Or_workers_CompBdid.dAll_filenames
		+ Or_workers_CompLinkIDs.dAll_filenames
		+ Sec_broker_dealerBdid.dAll_filenames
		+ Sec_broker_dealerLinkIDs.dAll_filenames
		;

end;