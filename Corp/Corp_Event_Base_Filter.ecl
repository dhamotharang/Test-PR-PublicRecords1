// This filter is used to remove data from the current Corp event base file
// during an update cycle.  Normally should be set to TRUE to include
// all data from the base file.

export Corp_Event_Base_Filter := file_corp_event_base.corp_state_origin not in ['AL', 'GA', 'KS', 'MI','RI','SD'];