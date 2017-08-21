// This filter is used to remove data from the current Corp contacts base file
// during an update cycle.  Normally should be set to TRUE to include
// all data from the base file.

export Corp_Cont_Base_Filter :=
		not(
				File_Corp_Cont_Base.corp_state_origin in	['AL']
		);
