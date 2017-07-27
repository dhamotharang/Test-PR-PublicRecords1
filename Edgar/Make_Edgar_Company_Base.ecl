import ut, Address, business_header, business_header_ss, did_add;

// Add temporary unique id to records
layout_edgar_temp := record
unsigned6 uid := 0;
Edgar.Layout_Edgar_Company;
end;

layout_edgar_temp InitEdgar(Edgar.Layout_Edgar_Company_In L) := transform
self := L;
end;

edgar_init := project(Edgar.File_Edgar_Company_In, InitEdgar(left));

ut.MAC_Sequence_Records(edgar_init, uid, edgar_seq)

// Normalize business and mail addresses prior to cleaning process

layout_edgar_norm := record
unsigned6       uid;
unsigned1       ntyp;  // 1 = business, 2 = mail
string120       addr1;
string120       addr2;
string40        orig_phone;
Address.Layout_Address_Clean_Components;
end;


layout_edgar_norm NormEdgar(layout_edgar_temp L, unsigned1 ctr) := transform
self.ntyp := ctr;
self.addr1 := choose(ctr, trim(L.busstreet1) + ' ' + L.busstreet2,
                          trim(L.mailstreet1) + ' ' + L.mailstreet2);
self.addr2 := choose(ctr, Address.Addr2FromComponents(L.buscity, L.busstate, L.buszip[1..5]),
                          Address.Addr2FromComponents(L.mailcity, L.mailstate, L.mailzip[1..5]));
self.orig_phone := choose(ctr, L.busphone, L.mailphone);
self := L;
end;

edgar_norm_init := normalize(edgar_seq, 2, NormEdgar(left, counter));
edgar_norm := edgar_norm_init(addr1 <> '' or addr2 <> '' or orig_phone <> '');

// Clean the addresses
Address.MAC_Address_Clean_Components(edgar_norm, addr1, addr2, true, edgar_norm_addr)

// Append clean phone number
Address.MAC_CleanPhone_Append(edgar_norm_addr, orig_phone, phone10, edgar_norm_phone)

// Denormalize, append clean phone and address information
layout_edgar_temp DenormEdgar(layout_edgar_temp L, edgar_norm_phone R) := transform
self.bus_prim_range := if(R.ntyp = 1, R.prim_range, L.bus_prim_range);
self.bus_predir := if(R.ntyp = 1, R.predir, L.bus_predir);
self.bus_prim_name := if(R.ntyp = 1, R.prim_name, L.bus_prim_name);
self.bus_addr_suffix := if(R.ntyp = 1, R.addr_suffix, L.bus_addr_suffix);
self.bus_postdir := if(R.ntyp = 1, R.postdir, L.bus_postdir);
self.bus_unit_desig := if(R.ntyp = 1, R.unit_desig, L.bus_unit_desig);
self.bus_sec_range := if(R.ntyp = 1, R.sec_range, L.bus_sec_range);
self.bus_p_city_name := if(R.ntyp = 1, R.p_city_name, L.bus_p_city_name);
self.bus_v_city_name := if(R.ntyp = 1, R.v_city_name, L.bus_v_city_name);
self.bus_st := if(R.ntyp = 1, R.st, L.bus_st);
self.bus_zip := if(R.ntyp = 1, R.zip5, L.bus_zip);
self.bus_zip4 := if(R.ntyp = 1, R.zip4, L.bus_zip4);
self.bus_cart := if(R.ntyp = 1, R.cart, L.bus_cart);
self.bus_cr_sort_sz := if(R.ntyp = 1, R.cr_sort_sz, L.bus_cr_sort_sz);
self.bus_lot := if(R.ntyp = 1, R.lot, L.bus_lot);
self.bus_lot_order := if(R.ntyp = 1, R.lot_order, L.bus_lot_order);
self.bus_dbpc := if(R.ntyp = 1, R.dbpc, L.bus_dbpc);
self.bus_chk_digit := if(R.ntyp = 1, R.chk_digit, L.bus_chk_digit);
self.bus_rec_type := if(R.ntyp = 1, R.rec_type, L.bus_rec_type);
self.bus_county := if(R.ntyp = 1, R.county, L.bus_county);
self.bus_geo_lat := if(R.ntyp = 1, R.geo_lat, L.bus_geo_lat);
self.bus_geo_long := if(R.ntyp = 1, R.geo_long, L.bus_geo_long);
self.bus_msa := if(R.ntyp = 1, R.msa, L.bus_msa);
self.bus_geo_blk := if(R.ntyp = 1, R.geo_blk, L.bus_geo_blk);
self.bus_geo_match := if(R.ntyp = 1, R.geo_match, L.bus_geo_match);
self.bus_err_stat := if(R.ntyp = 1, R.err_stat, L.bus_err_stat);
self.bus_phone10 := if(R.ntyp = 1, R.phone10, L.bus_phone10);
self.mail_prim_range := if(R.ntyp = 2, R.prim_range, L.mail_prim_range);
self.mail_predir := if(R.ntyp = 2, R.predir, L.mail_predir);
self.mail_prim_name := if(R.ntyp = 2, R.prim_name, L.mail_prim_name);
self.mail_addr_suffix := if(R.ntyp = 2, R.addr_suffix, L.mail_addr_suffix);
self.mail_postdir := if(R.ntyp = 2, R.postdir, L.mail_postdir);
self.mail_unit_desig := if(R.ntyp = 2, R.unit_desig, L.mail_unit_desig);
self.mail_sec_range := if(R.ntyp = 2, R.sec_range, L.mail_sec_range);
self.mail_p_city_name := if(R.ntyp = 2, R.p_city_name, L.mail_p_city_name);
self.mail_v_city_name := if(R.ntyp = 2, R.v_city_name, L.mail_v_city_name);
self.mail_st := if(R.ntyp = 2, R.st, L.mail_st);
self.mail_zip := if(R.ntyp = 2, R.zip5, L.mail_zip);
self.mail_zip4 := if(R.ntyp = 2, R.zip4, L.mail_zip4);
self.mail_cart := if(R.ntyp = 2, R.cart, L.mail_cart);
self.mail_cr_sort_sz := if(R.ntyp = 2, R.cr_sort_sz, L.mail_cr_sort_sz);
self.mail_lot := if(R.ntyp = 2, R.lot, L.mail_lot);
self.mail_lot_order := if(R.ntyp = 2, R.lot_order, L.mail_lot_order);
self.mail_dbpc := if(R.ntyp = 2, R.dbpc, L.mail_dbpc);
self.mail_chk_digit := if(R.ntyp = 2, R.chk_digit, L.mail_chk_digit);
self.mail_rec_type := if(R.ntyp = 2, R.rec_type, L.mail_rec_type);
self.mail_county := if(R.ntyp = 2, R.county, L.mail_county);
self.mail_geo_lat := if(R.ntyp = 2, R.geo_lat, L.mail_geo_lat);
self.mail_geo_long := if(R.ntyp = 2, R.geo_long, L.mail_geo_long);
self.mail_msa := if(R.ntyp = 2, R.msa, L.mail_msa);
self.mail_geo_blk := if(R.ntyp = 2, R.geo_blk, L.mail_geo_blk);
self.mail_geo_match := if(R.ntyp = 2, R.geo_match, L.mail_geo_match);
self.mail_err_stat := if(R.ntyp = 2, R.err_stat, L.mail_err_stat);
self.mail_phone10 := if(R.ntyp = 2, R.phone10, L.mail_phone10);
self := L;
end;

edgar_denorm := denormalize(edgar_seq,
                            edgar_norm_phone,
                            left.uid = right.uid,
                            DenormEdgar(left, right));

Edgar.Layout_Edgar_Company FormatBase(layout_edgar_temp L) := transform
self := L;
end;

edgar_company_base := project(edgar_denorm, FormatBase(left));

myset := ['A','P'];

business_header.MAC_Source_Match(edgar_company_base,outf1,
						false,bdid,
						false,'E',
						false,foo,
						companyname,
						bus_prim_range,bus_prim_name,
						bus_sec_range,bus_zip,
						true,bus_phone10,
						false,bus_fein)

o2 := outf1(bdid = 0);

business_header_ss.mac_match_flex(o2, myset,
				companyname,bus_prim_range,bus_prim_name,bus_zip,bus_sec_range,bus_st,
				bus_phone10,bus_fein,bdid,edgar.layout_edgar_company,false,foo,outf2)
				
o3 := outf2 + outf1(bdid != 0);

//output(o3,,'BASE::Edgar_Company_' + Edgar.Version_Edgar_Company, overwrite);
ut.MAC_SF_BuildProcess(o3,'~thor_data400::base::edgar_company',do1,2);

export make_edgar_company_base := do1;
