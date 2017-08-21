rec := record
string clndr_yr_month;
string	sr_num;
string		X_ASSET_NUM_CI;
string		sr_type_cd;
string		sr_subtype_cd;
string		sr_stat_id;
string		sr_prio_cd;
string		sr_sub_stat_id;
string		x_client_type_cd;
string		Product_name;
string		sr_age_days;
string		sr_age_hours;
string		act_open_dt;
string		act_close_dt;
string		notify_dt;
string		doc_reqd_flg;
string		root_cause_cd;
string		sr_area;
end;


export ServiceRequests := dataset('~thor20_11::poc::fs_service_request_raw',rec,csv(separator(','),heading(1)));