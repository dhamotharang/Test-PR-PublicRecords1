#option('outputLimit', 100);

f := dataset('~thor_data400::TMTEST::BBB_Base_Test_Original', BBB.Layout_BBB_Base, flat);

f1 := dataset('~thor_data400::TEMP::BBB_Clean_BDID', BBB.Layout_BBB_Base, flat);

f_dist := distribute(f(bdid = 0), hash(bbb_id));
f1_dist := distribute(f1(bdid <> 0), hash(bbb_id));

bbb_match := join(f1_dist,
                  f_dist,
			   left.bbb_id = right.bbb_id,
			   transform(BBB.Layout_BBB_Base, self := left),
			   local);
			   
bbb_match_sample := enth(bbb_match,10000);
			   
layout_bbb_match_best := record
BBB.Layout_BBB_Base;
string120 best_CompanyName := '';
string120 best_addr1 := '';
string30	best_city := '';
string2	best_state := '';
string5	best_zip :='';
string4	best_zip4 := '';
string10  best_phone := '';
string9   best_fein := '';
end;

// Append Best Information
bhb := Business_Header.File_Business_Header_Best;

os(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_bbb_match_best AppendBest(bbb_match_sample l, bhb r) := transform
self.best_CompanyName := r.company_name;

self.best_addr1 := 
			os(r.prim_range) + 
			os(r.predir) + 
			os(r.prim_name) +
			os(r.addr_suffix) +
			os(r.postdir) +
				if(ut.tails(r.prim_name, os(r.unit_desig) + os(r.sec_range)),
					'',
					os(r.unit_desig) + os(r.sec_range));
self.best_city := r.city;
self.best_state := r.state;
self.best_zip := if(r.zip = 0, '', intformat(r.zip, 5, 1));
self.best_zip4 := if(r.zip4 <> 0, intformat(r.zip4, 4, 1), '');

self.best_phone := if(r.phone <> 0, intformat(r.phone, 10, 1), '');
self.best_fein := if(r.fein <> 0, intformat(r.fein, 9, 1), '');
self := l;
end;

bbb_match_best_append := join(bbb_match_sample,
                              bhb,
					     left.bdid = right.bdid,
					     AppendBest(left, right),
					     left outer,
					     hash);
						
output(bbb_match_best_append,,'TMTEST::BBB_Base_Test_Sample_CSV',csv(
heading(
'bdid,bbb_id,company_name,address,country,phone,phone_type,report_date,http_link,member_title,' +
'member_since_date,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,p_city_name,' +
'v_city_name,st,zip,zip4,cart,cr_sort_sz,lot,lot_order,dbpc,chk_digit,rec_type,fips_state,fips_county,' +
'geo_lat,geo_long,msa,geo_blk,geo_match,err_stat,phone10,best_CompanyName,best_addr1,best_city,best_state,' +
'best_zip,best_zip4,best_phone,best_fein\n'),
separator(','),
quote('"'),
terminator('\n')),overwrite);

						
