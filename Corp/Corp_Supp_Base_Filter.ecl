// This filter is used to remove data from the current Corp supplemental base file
// during an update cycle.  Normally should be set to TRUE to include
// all data from the base file.

export Corp_Supp_Base_Filter :=
		not(
				file_corp_supp_base.corp_state_origin in	['AL']
		);      

