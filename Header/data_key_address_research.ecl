//this key is to get the dt_first_seen and dt_last_seen of an apartment build
//also check the apartment type.

import header, doxie, address, ut;

apt_recs := header.ApartmentBuildings(apt_cnt > 1);
da_recs := header.did_addresses;
da_sr_recs := da_recs(sec_range != '');

addr_dt_rec := record
	da_recs.prim_range;
	da_recs.prim_name;
	da_recs.zip;
	da_recs.predir;
	da_recs.suffix;
	da_recs.first_seen;
	da_recs.last_seen;
end;

da_slim := table(da_sr_recs, addr_dt_rec);

addr_dt_rec get_addr_dts(da_slim  le, da_slim  ri) := transform
  self.first_seen := if ( ri.first_seen <> 0 and ri.first_seen < le.first_seen, ri.first_seen, le.first_seen);
  self.last_seen := if ( ri.last_seen <> 0 and ri.last_seen > le.last_seen, ri.last_seen, le.last_seen );
  self := le;
  end;

addr_dts := rollup(da_slim ,left.prim_range=right.prim_range and
  	  			        left.prim_name=right.prim_name and
				        left.zip=right.zip and
				        left.predir=right.predir and
				        left.suffix=right.suffix,
				        get_addr_dts(left,right));

out_rec := record					   
	addr_dt_rec;
	string3 addr_type,
	string2 stusab;
	string3 county;
	string6 tract;
	string1 blkgrp;
end;

out_rec get_apt_dts(apt_recs l, addr_dts r) := transform
     //check small, medium and large apt bld
     self.addr_type := map(l.apt_cnt < 10 => 'SML',
	                      l.apt_cnt < 100 => 'MDM',
					  'LGR');  
	self := l;
	self := r;
	self := [];
end;
					   
apt_dts := join(apt_recs, addr_dts, 
                left.prim_range=right.prim_range and
  	  	      left.prim_name=right.prim_name and
			 left.zip=right.zip and
			 left.predir=right.predir and
			 left.suffix=right.suffix, 
			 get_apt_dts(left, right), left outer, local);

apt_dts_vld := apt_dts((unsigned)zip<>0);

out_exp_rec := record
	out_rec,
	string addr_line1,
	string addr_line2,
end;

out_exp_rec expand_them(apt_dts_vld l) := transform
    self.addr_line1 := address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
								             l.suffix, '', '', '');
    self.addr_line2 := address.Addr2FromComponents('','',l.zip);
    self := l;
end;

apt_dts_ready := project(apt_dts_vld, expand_them(left));

address.mac_address_clean(apt_dts_ready,
          	           addr_line1, 
			           addr_line2,
			           true,
			           apt_dts_cleaned);

out_rec parse_them(apt_dts_cleaned l) := transform
    self.stusab := if(l.clean[115..116]='',ziplib.ZipToState2(l.clean[117..121]),l.clean[115..116]);
    self.county := l.clean[143..145];
    self.tract := l.clean[171..176];
    self.blkgrp := l.clean[177];
    self := l;
end;

apt_dts_parsed := project(apt_dts_cleaned, parse_them(left));

export data_key_address_research := apt_dts_parsed;
//export key_header_address_research := index(apt_dts_parsed, {zip, addr_type}, {apt_dts_parsed}, 
//							  ut.Data_Location.Person_header+'thor_data400::key::address_research_' + doxie.Version_SuperKey);
