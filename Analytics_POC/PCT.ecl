rec := record
string pct_id;
string	timesubmitted;
string		requestid;
string		stepid;
string		type_;
string		status;
string		bgrp;
string		opportunityid;
string		product;
string		mvalue;
end;

export PCT := dataset('~thor20_11::poc::fs_pct_req_raw',rec,csv(separator(','),heading(1)));