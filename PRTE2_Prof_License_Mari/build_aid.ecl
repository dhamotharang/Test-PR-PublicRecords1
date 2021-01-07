import doxie_files, doxie, ut, Data_Services, fcra,PRTE2_Prof_License_Mari, BIPV2,autokey,AutoKeyB2,AutoKeyI,fcra;

export build_aid := module 
#option ('multiplePersistInstances',false);

base_search     		:= files.base_search;

dsSearch 			:= project(base_search, {base_search} - [enh_did_src,link_ssn,link_fein,link_inc_date,cust_name,bug_num,link_dob,req]);

dsSearch_ext:=project(dsSearch,
Transform(Layouts.search_ext,
Self:=Left;
self := []; 
));

layouts.tempSlimRec_ext  	xformSearch(recordof(dsSearch_ext) L, integer cnt) := transform
self.cnt := cnt;
self.mari_rid							:= L.mari_rid;
self.create_dte						:= L.create_dte;                  
self.last_upd_dte  				:= L.last_upd_dte; 
self.stamp_dte  					:= L.stamp_dte;
self.date_vendor_first_reported		:= L.date_vendor_first_reported;
self.date_vendor_last_reported		:= L.date_vendor_last_reported;
self.date_first_seen			:= L.date_first_seen;
self.date_last_seen				:= L.date_last_seen;
self.did									:= L.did;
self.bdid									:= L.bdid;
self.std_prof_cd					:= L.std_prof_cd;
self.std_source_upd				:= L.std_source_upd;
self.type_cd							:= L.type_cd;
self.fname								:= L.fname;
self.mname								:= L.mname;
self.lname								:= L.lname;
self.name_suffix					:= L.name_suffix;
self.party_birth					:= L.birth_dte;
self.license_nbr					:= L.license_nbr;	
self.cln_license_nbr			:= L.cln_license_nbr;
self.off_license_nbr			:= L.off_license_nbr;
self.license_state				:= L.license_state;
self.cmc_slpk							:= L.cmc_slpk;		
self.pcmc_slpk						:= L.pcmc_slpk;
self.tax_type							:= 	choose(cnt,L.tax_type_1,L.tax_type_2,L.tax_type_1,L.tax_type_2);
self.ssn_taxid						:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2,L.ssn_taxid_1,L.ssn_taxid_2);

//Each company name should be associated to 2 addreasses(Bussines/Mailing)
self.company							:= 	choose(cnt,L.name_company,L.name_company,L.name_company_dba,L.name_company_dba);
self.party_phone 					:= 	choose(cnt,L.phn_mari_1,L.phn_mari_2,L.phn_mari_1,L.phn_mari_2);
self.addr_ind							:=  choose(cnt,L.addr_bus_ind,L.addr_mail_ind,L.addr_bus_ind,L.addr_mail_ind);

//self.prim_range 					:= 	choose(cnt,l.Bus_prim_range,l.Mail_prim_range);

self.prim_range 					:= 	choose(cnt,l.Bus_prim_range,l.Mail_prim_range,l.Bus_prim_range,l.Mail_prim_range);

self.predir								:=  choose(cnt,l.Bus_predir,l.Mail_predir,l.Bus_predir,l.Mail_predir);
self.prim_name 						:= 	choose(cnt,l.Bus_prim_name,l.Mail_prim_name,l.Bus_prim_name,l.Mail_prim_name);
self.addr_suffix					:=  choose(cnt,l.Bus_addr_suffix,l.Mail_addr_suffix,l.Bus_addr_suffix,l.Mail_addr_suffix);
self.postdir							:= 	choose(cnt,l.Bus_postdir,l.Mail_postdir,l.Bus_postdir,l.Mail_postdir);
self.unit_desig						:=	choose(cnt,l.Bus_unit_desig,l.Mail_unit_desig,l.Bus_unit_desig,l.Mail_unit_desig);
self.sec_range 						:=  choose(cnt,l.Bus_sec_range,l.Mail_sec_range,l.Bus_sec_range,l.Mail_sec_range);
self.p_city_name					:=	choose(cnt,l.Bus_p_city_name,l.Mail_p_city_name,l.Bus_p_city_name,l.Mail_p_city_name);
self.city_name						:= 	choose(cnt,l.Bus_v_city_name,l.Mail_v_city_name,l.Bus_v_city_name,l.Mail_v_city_name);
self.st 									:= 	choose(cnt,l.Bus_state,l.Mail_state,l.Bus_state,l.Mail_state);
self.zip5									:= 	choose(cnt,l.Bus_zip5,l.Mail_zip5,l.Bus_zip5,l.Mail_zip5);
self.zip4									:=  choose(cnt,l.Bus_zip4,l.Mail_zip4,l.Bus_zip4,l.Mail_zip4);
self.rawaid               :=  choose(cnt,l.Append_BusRawAID,l.Append_MailRawAID,l.Append_BusRawAID,l.Append_MailRawAID);
self.v_city_name          :=  choose(cnt,l.BUS_V_CITY_NAME,l.Mail_V_CITY_NAME,l.BUS_V_CITY_NAME,l.Mail_V_City_name);
self.cart                 :=  choose(cnt,l.BUS_cart,l.Mail_cart,l.BUS_cart,l.Mail_cart);
self.cr_sort_sz           :=  choose(cnt,l.BUS_cr_sort_sz,l.Mail_cr_sort_sz,l.BUS_cr_sort_sz,l.Mail_cr_sort_sz);
self.lot                  :=  choose(cnt,l.BUS_lot,l.Mail_lot,l.BUS_lot,l.Mail_lot);
self.lot_order            :=  choose(cnt,l.BUS_lot_order,l.Mail_lot_order,l.BUS_lot_order,l.Mail_lot_order);
self.dbpc                 :=  choose(cnt,l.BUS_dpbc,l.Mail_dpbc,l.BUS_dpbc,l.Mail_dpbc);
self.chk_digit            :=  choose(cnt,l.BUS_chk_digit,l.Mail_chk_digit,l.BUS_chk_digit,l.Mail_chk_digit);
self.rec_type             :=  choose(cnt,l.BUS_rec_type,l.Mail_rec_type,l.BUS_rec_type,l.Mail_rec_type);
self.county               :=  choose(cnt,l.BUS_county,l.Mail_county,l.BUS_county,l.Mail_county);
self.geo_lat              :=  choose(cnt,l.BUS_geo_lat,l.Mail_geo_lat,l.BUS_geo_lat,l.Mail_geo_lat);
self.geo_long             :=  choose(cnt,l.BUS_geo_long,l.Mail_geo_long,l.BUS_geo_long,l.Mail_geo_long);
self.msa                  :=  choose(cnt,l.BUS_msa,l.Mail_msa,l.BUS_msa,l.Mail_msa);
self.geo_blk              :=  choose(cnt,l.BUS_geo_blk,l.Mail_geo_blk,l.BUS_geo_blk,l.Mail_geo_blk);
self.geo_match            :=  choose(cnt,l.BUS_geo_match,l.Mail_geo_match,l.BUS_geo_match,l.Mail_geo_match);
self.err_stat             :=  choose(cnt,l.BUS_err_stat,l.Mail_err_stat,l.BUS_err_stat,l.Mail_err_stat);

self.brkr_license_nbr			:= L.brkr_license_nbr;
self.nmls_id							:= L.nmls_id;
self.foreign_nmls_id			:= L.foreign_nmls_id;
self.federal_regulator		:= L.federal_regulator;
self	:=L;
end;

NormNameAddr := dedup(sort(normalize(dsSearch_ext,4,xformSearch(LEFT,COUNTER)), cnt), EXCEPT cnt, all, local);

dsBusAddr := NormNameAddr(cnt = 1 or (cnt = 3 and company <> ''));
dsMailAddr := NormNameAddr((cnt = 2 or cnt = 4) and (prim_range + predir + prim_name + addr_suffix + postdir + unit_desig + sec_range + city_name + st + zip5 + party_phone +tax_type ) <> '');
comb_recs := project(dsBusAddr + dsMailAddr, transform(Layouts.tempSlimRec_ext, self := left)):persist('~prte::temp::proflic_mari::normalized_recs');

Export ak_dataset := dedup(comb_recs,record,all,local);


end;