import Business_Header;

#workunit('name', 'Corporate Date Stats');

f := Corp.File_Corp_Out;

layout_corp_slim := record
	f.dt_first_seen;
	f.dt_last_seen;
	f.corp_process_date;
	f.corp_address1_effective_date;
	f.corp_address2_effective_date;
	f.corp_filing_date;
	f.corp_status_date;
	f.corp_inc_date;
	f.corp_forgn_date;
	f.corp_ra_effective_date;
end;

fslim := table(f, layout_corp_slim);

// --------------------------------
// -- Date First Seen stats
// --------------------------------
layout_dt_first_stat := record
	fslim.dt_first_seen;
	integer4 total:= count(group);
end;

dt_first_stat := table(fslim, layout_dt_first_stat, dt_first_seen, few);

output(dt_first_stat(dt_first_seen > '20050215'));

// --------------------------------
// -- Date Last Seen stats
// --------------------------------
layout_dt_last_stat := record
	fslim.dt_last_seen;
	integer4 total:= count(group);
end;

dt_last_stat := table(fslim, layout_dt_last_stat, dt_last_seen, few);

output(dt_last_stat(dt_last_seen > '20050215'));

// --------------------------------
// -- Process Date stats
// --------------------------------
layout_process_date_stat := record
	fslim.corp_process_date;
	integer4 total:= count(group);
end;

process_date_stat := table(fslim, layout_process_date_stat, corp_process_date, few);

output(process_date_stat(corp_process_date > '20050215'));

// --------------------------------
// -- Address1 Effective Date stats
// --------------------------------
layout_addr1_effective_stat := record
	fslim.corp_address1_effective_date;
	integer4 total:= count(group);
end;

addr1_effective_stat := table(fslim, layout_addr1_effective_stat, corp_address1_effective_date, few);

output(addr1_effective_stat(corp_address1_effective_date > '20050215'));

// --------------------------------
// -- Address2 Effective Date stats
// --------------------------------
layout_addr2_effective_stat := record
	fslim.corp_address2_effective_date;
	integer4 total:= count(group);
end;

addr2_effective_stat := table(fslim, layout_addr2_effective_stat, corp_address2_effective_date, few);

output(addr2_effective_stat(corp_address2_effective_date > '20050215'));

// --------------------------------
// -- Filing Date stats
// --------------------------------
layout_filing_date_stat := record
	fslim.corp_filing_date;
	integer4 total:= count(group);
end;

filing_date_stat := table(fslim, layout_filing_date_stat, corp_filing_date, few);

output(filing_date_stat(corp_filing_date > '20050215'));

// --------------------------------
// -- Status Date stats
// --------------------------------
layout_status_date_stat := record
	fslim.corp_status_date;
	integer4 total:= count(group);
end;

status_date_stat := table(fslim, layout_status_date_stat, corp_status_date, few);

output(status_date_stat(corp_status_date > '20050215'));

// --------------------------------
// -- Inc Date stats
// --------------------------------
layout_inc_date_stat := record
	fslim.corp_inc_date;
	integer4 total:= count(group);
end;

inc_date_stat := table(fslim, layout_inc_date_stat, corp_inc_date, few);

output(inc_date_stat(corp_inc_date > '20050215'));

// --------------------------------
// -- Foreign Date stats
// --------------------------------
layout_forgn_date_stat := record
	fslim.corp_forgn_date;
	integer4 total:= count(group);
end;

forgn_date_stat := table(fslim, layout_forgn_date_stat, corp_forgn_date, few);

output(forgn_date_stat(corp_forgn_date > '20050215'));

// --------------------------------
// -- RA Effective Date stats
// --------------------------------
layout_ra_effective_date_stat := record
	fslim.corp_ra_effective_date;
	integer4 total:= count(group);
end;

ra_effective_date_stat := table(fslim, layout_ra_effective_date_stat, corp_ra_effective_date, few);

output(ra_effective_date_stat(corp_ra_effective_date > '20050215'));



//totals := dt_first_stat + dt_last_stat + process_date_stat + addr1_effective_stat + 
//OUTPUT(wither_out,,'temp::wither_test', OVERWRITE);
