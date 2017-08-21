export UserActivity := module

Alpha_rec := record
 string Month;
 string Year;
 string CompanyID;
 string CompanyName;
 string	ActiveUsers;
end;

export Alpha_activity := dataset('~thor::user_activity_essbase_20120120',Alpha_rec,csv(separator('\t'),quote('"'),heading(1)));

Dayton_rec := record
 string sub_acct_id;
 string clndr_yr_month;
 string act_cnt;
end;

export Dayton_activity := dataset('~thor::poc::dayton_active_users',Dayton_rec,csv(separator(','),heading(1)));

end;
