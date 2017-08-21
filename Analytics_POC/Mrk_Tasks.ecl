rec := record
 string	sub_acct_id;
 string activity_id;
 string 	account_id;
 string 	account_integration_id;
 string 	parent_account_id;
 string		type_;
 string 	start_time;
 string 	end_time;
 string 	account_name;
 string 	company_name;
 string 	industry;
end;


export Mrk_Tasks := dataset('~thor20_11::poc::fs_tasks_raw',rec,csv(separator('\t'),heading(1)));