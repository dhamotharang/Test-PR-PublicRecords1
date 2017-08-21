bhb := Business_Header.File_Business_Header_Best;

// Non-blank, Non-PO Box, Non-Rural Route addresses
bhb_filtered := bhb(prim_name <> '', zip <> 0,
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']);

// Exclude businesses with date older than 18 months or with a D&B record
bh := Business_Header.File_Business_Header;

layout_bdid_date := record
bh.bdid;
bh.dt_last_seen;
end;

bh_dates := table(bh(source <> 'D', dt_last_seen >= 20050101, dt_last_seen <= 20060701, zip <> 0, prim_name <> '',
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']), layout_bdid_date);
				
bh_dates_dedup := dedup(bh_dates, bdid, all);


// Exclude businesses with a D&B record
layout_bdid_list := record
unsigned6 bdid;
end;

bhb_filtered_nondnb := join(bhb_filtered,
                            bh_dates_dedup,
					   left.bdid = right.bdid,
					   transform(Business_Header.Layout_BH_Best, self := left),
					   hash);
				
bhb_bdid_list := project(bhb_filtered_nondnb,
                         transform(layout_bdid_list, self := left));

bc := Business_Header.File_Business_Contacts;

// choose businesses with contacts with owner/officer titles
// and recent dates last seen
layout_bc_title := record
bc.bdid;
bc.did;
bc.fname;
bc.mname;
bc.lname;
bc.name_suffix;
bc.company_title;
unsigned1 title_rank := ut.TitleRank(bc.company_title);
end;

bc_titles := table(bc(from_hdr = 'N', bdid <> 0, did <> 0, dt_last_seen >= 20050101, dt_last_seen <= 20060701,
                      company_title <> '', ut.TitleRank(company_title) <= 5),
                   layout_bc_title);
			    
// include contacts from only companies with non-blank addresses
bc_titles_filtered := join(bc_titles,
                           bhb_bdid_list,
					  left.bdid = right.bdid,
					  transform(layout_bc_title, self := left),
					  hash);

// choose contact with higest ranking title			    
bc_titles_dist := distribute(bc_titles_filtered, hash(bdid));
bc_titles_sort := sort(bc_titles_dist, bdid, title_rank, local);
bc_titles_dedup := dedup(bc_titles_sort, bdid, local);

// select 50,000 sample companies
bc_titles_sample := enth(bc_titles_dedup, 50000);

layout_sample := record
  string12  bdid;
  string12  did;
  string120 company_name := '';
  string120 addr1 := '';
  string30  city := '';
  string2	  state := '';
  string5	  zip :='';
  string4	  zip4 := '';
  string10  phone := '';
  string20  fname := '';
  string20  mname := '';
  string20  lname := '';
  string5   name_suffix := '';
  string30  company_title := '';
end;

ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_sample FormatSample(Business_Header.Layout_BH_Best l, layout_bc_title r) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.did := intformat(r.did, 12, 1);
self.company_name := l.company_name;

self.addr1 := 
			ops(l.prim_range) + 
			ops(l.predir) + 
			ops(l.prim_name) +
			ops(l.addr_suffix) +
			ops(l.postdir) +
				if(ut.tails(l.prim_name, ops(l.unit_desig) + ops(l.sec_range)),
					'',
					ops(l.unit_desig) + ops(l.sec_range));
self.city := l.city;
self.state := l.state;
self.zip := if(l.zip = 0, '', intformat(l.zip, 5, 1));
self.zip4 := if(l.zip4 <> 0, intformat(l.zip4, 4, 1), '');

self.phone := if(l.phone <> 0, intformat(l.phone, 10, 1), '');
self.fname := r.fname;
self.mname := r.mname;
self.lname := r.lname;
self.name_suffix := r.name_suffix;
self.company_title := r.company_title;
end;

bh_sample := join(bhb_filtered_nonDNB,
                  bc_titles_sample,
			   left.bdid = right.bdid,
			   FormatSample(left, right),
			   hash);

bh_sample_sorted := sort(bh_sample, bdid) : persist('TMTEST::DNB_Test_Sample');
output(choosen(bh_sample_sorted, 500), all);

layout_sample_out := record
  string120 company_name := '';
  string120 addr1 := '';
  string30  city := '';
  string2	  state := '';
  string5	  zip :='';
  string4	  zip4 := '';
  string10  phone := '';
  string20  fname := '';
  string20  mname := '';
  string20  lname := '';
  string5   name_suffix := '';
  string30  company_title := '';
end;

bh_sample_out := project(bh_sample_sorted,
                         transform(layout_sample_out, self := left));
					
// Output in CSV format
output(bh_sample_out,,'OUT::DNB_Test_Sample_CSV',csv(
heading(
'company_name,addr1,city,state,zip,zip4,phone,fname,mname,lname,name_suffix,company_title\n',single),
separator(','),
terminator('\n'),
quote('"')),overwrite);

