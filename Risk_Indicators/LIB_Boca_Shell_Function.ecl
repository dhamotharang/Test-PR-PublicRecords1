/*--LIBRARY--*/
import Gateway, Risk_Indicators;

EXPORT LIB_Boca_Shell_Function (
	GROUPED DATASET (Risk_Indicators.Layout_output) iid,
	DATASET (Gateway.Layouts.Config) gateways,
	Risk_Indicators.BS_LIBIN args
	) := MODULE
	
	dppa := args.bs_dppa;
	glb := args.bs_glb;
	isUtility := args.bs_isUtility;
	isLN := args.bs_isLN;
	includeRelativeInfo := args.bs_includeRelativeInfo;
	includeDLInfo := args.bs_includeDLInfo;
	includeVehInfo := args.bs_includeVehInfo;
	includeDerogInfo := args.bs_includeDerogInfo;
	BSversion := args.bs_BSversion;
	doScore := args.bs_doScore;
	nugen := args.bs_nugen;
	filter_out_fares := args.bs_filter_out_fares;
	DataRestriction := args.bs_DataRestriction;
	BSOptions := args.bs_BSOptions;
	DataPermission := args.bs_DataPermission;
	LexIdSourceOptout := args.bs_LexIdSourceOptout;
	TransactionID := args.bs_TransactionID; 
	BatchUID := args.bs_BatchUID; 
	GlobalCompanyID := args.bs_GlobalCompanyID;

  ids_wide := boca_shell_FCRA_Neutral_Function (iid, dppa, glb,  
                                                isUtility, isLN, includeRelativeInfo, false, BSversion, 
																								nugen := nugen, DataRestriction:=DataRestriction, BSOptions:=BSOptions);
 	
  p := dedup(group(sort(project(ids_wide(~isrelat), transform (Layout_Boca_Shell, self := LEFT)), seq), seq), seq);

  dppa_ok := dppa > 0 and dppa < 8;
  per_prop := getAllBocaShellData (iid, ids_wide, p,
                                   FALSE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo, BSversion,
																	 false, doScore, filter_out_fares,
																	 DataRestriction, BSOptions, glb, gateways, 
																	 DataPermission,
																	LexIdSourceOptout := LexIdSourceOptout, 
																	TransactionID := TransactionID, 
																	BatchUID := BatchUID, 
																	GlobalCompanyID := GlobalCompanyID);

	export results := per_prop;
END;
