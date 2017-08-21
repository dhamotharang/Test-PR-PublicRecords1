rec := record
string vc_id;
string	clndr_yr_month;
string		train_id;
string		Type_;
string		Numattendees;
string		product;
string		opportunityintegrationid;
end;


export Training := dataset('~thor20_11::poc::fs_training_raw',rec,csv(separator(','),heading(1)));