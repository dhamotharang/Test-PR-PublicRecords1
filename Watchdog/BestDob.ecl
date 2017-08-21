import ut, header, did_add;

d_f := file_header_filtered(dob between 18500000 and (integer)ut.getdate);

_bestDOB	:=	fn_BestDOB(d_f);

export BestDob := _bestDOB : persist('persist::Watchdog_BestDob');