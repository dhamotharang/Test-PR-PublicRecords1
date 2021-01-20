#workunit('name','Accutrend Contacts ' + busreg.BusReg_Build_Date);
import ut, did_add;

base := BusReg.File_BusReg_Base;

//Normailze into Contact layout
busreg.Layout_BusReg_Contact Norm(busreg.layout_busreg_temp L, integer num) := transform
 self.did := 0;
 self.name := choose(num,l.OFC1_NAME,l.OFC2_NAME,l.OFC3_NAME,l.OFC4_NAME,l.OFC5_NAME,l.OFC6_NAME,l.RA_NAME);
 self.title := choose(num,l.OFC1_TITLE,l.OFC2_TITLE,l.OFC3_TITLE,l.OFC4_TITLE,l.OFC5_TITLE,l.OFC6_TITLE,'RA');
 self.add := choose(num,l.OFC1_ADD,l.OFC2_ADD,l.OFC3_ADD,l.OFC4_ADD,l.OFC5_ADD,l.OFC6_ADD,l.RA_ADD);
 self.csz := choose(num,trim(l.OFC1_CITY)+' '+trim(l.OFC1_STATE)+' '+trim(l.OFC1_ZIP_ORIG),
						l.OFC2_CSZ,l.OFC3_CSZ,l.OFC4_CSZ,l.OFC5_CSZ,l.OFC6_CSZ,
						trim(l.RA_CITY)+' '+trim(l.RA_STATE)+' '+trim(l.RA_ZIP_ORIG));
 self.FEIN := choose(num,l.OFC1_FEIN,l.OFC2_FEIN,l.OFC3_FEIN,l.OFC4_FEIN,l.OFC5_FEIN,l.OFC6_FEIN,'');
 self.ssn := choose(num,l.OFC1_SSN,l.OFC2_SSN,l.OFC3_SSN,l.OFC4_SSN,l.OFC5_SSN,l.OFC6_SSN,'');
 self.phone := choose(num,l.ofc1_phone10,'','','','','',l.ra_phone10);
 self.name_first := choose(num,l.ofc1_name_first,l.ofc2_name_first,l.ofc3_name_first,
						l.ofc4_name_first,l.ofc5_name_first,l.ofc6_name_first,'');
 self.name_prefix := choose(num,l.ofc1_name_prefix,l.ofc2_name_prefix,l.ofc3_name_prefix,
						l.ofc4_name_prefix,l.ofc5_name_prefix,l.ofc6_name_prefix,'');
 self.name_middle := choose(num,l.ofc1_name_middle,l.ofc2_name_middle,l.ofc3_name_middle,
						l.ofc4_name_middle,l.ofc5_name_middle,l.ofc6_name_middle,'');
 self.name_last := choose(num,l.ofc1_name_last,l.ofc2_name_last,l.ofc3_name_last,
						l.ofc4_name_last,l.ofc5_name_last,l.ofc6_name_last,'');
 self.name_suffix := choose(num,l.ofc1_name_suffix,l.ofc2_name_suffix,l.ofc3_name_suffix,
						l.ofc4_name_suffix,l.ofc5_name_suffix,l.ofc6_name_suffix,'');
 self.name_score := choose(num,l.ofc1_name_score,l.ofc2_name_score,l.ofc3_name_score,
						l.ofc4_name_score,l.ofc5_name_score,l.ofc6_name_score,'');
 self.prim_range := choose(num,l.ofc1_prim_range,l.ofc2_prim_range,l.ofc3_prim_range,
								l.ofc4_prim_range,l.ofc5_prim_range,l.ofc6_prim_range,l.ra_prim_range);
 self.predir := choose(num,l.ofc1_predir,l.ofc2_predir,l.ofc3_predir,
								l.ofc4_predir,l.ofc5_predir,l.ofc6_predir,l.ra_predir);
 self.prim_name := choose(num,l.ofc1_prim_name,l.ofc2_prim_name,l.ofc3_prim_name,
								l.ofc4_prim_name,l.ofc5_prim_name,l.ofc6_prim_name,l.ra_prim_name);
 self.addr_suffix := choose(num,l.ofc1_addr_suffix,l.ofc2_addr_suffix,l.ofc3_addr_suffix,
								l.ofc4_addr_suffix,l.ofc5_addr_suffix,l.ofc6_addr_suffix,l.ra_addr_suffix);
 self.postdir := choose(num,l.ofc1_postdir,l.ofc2_postdir,l.ofc3_postdir,
								l.ofc4_postdir,l.ofc5_postdir,l.ofc6_postdir,l.ra_postdir);
 self.unit_desig := choose(num,l.ofc1_unit_desig,l.ofc2_unit_desig,l.ofc3_unit_desig,
								l.ofc4_unit_desig,l.ofc5_unit_desig,l.ofc6_unit_desig,l.ra_unit_desig);
 self.sec_range := choose(num,l.ofc1_sec_range,l.ofc2_sec_range,l.ofc3_sec_range,
								l.ofc4_sec_range,l.ofc5_sec_range,l.ofc6_sec_range,l.ra_sec_range);
 self.p_city_name := choose(num,l.ofc1_p_city_name,l.ofc2_p_city_name,l.ofc3_p_city_name,
								l.ofc4_p_city_name,l.ofc5_p_city_name,l.ofc6_p_city_name,l.ra_p_city_name);
 self.v_city_name := choose(num,l.ofc1_v_city_name,l.ofc2_v_city_name,l.ofc3_v_city_name,
								l.ofc4_v_city_name,l.ofc5_v_city_name,l.ofc6_v_city_name,l.ra_v_city_name);
 self.st := choose(num,l.ofc1_st,l.ofc2_st,l.ofc3_st,
								l.ofc4_st,l.ofc5_st,l.ofc6_st,l.ra_st);
 self.zip := choose(num,l.ofc1_zip,l.ofc2_zip,l.ofc3_zip,
								l.ofc4_zip,l.ofc5_zip,l.ofc6_zip,l.ra_zip);
 self.zip4 := choose(num,l.ofc1_zip4,l.ofc2_zip4,l.ofc3_zip4,
								l.ofc4_zip4,l.ofc5_zip4,l.ofc6_zip4,l.ra_zip);
 self.cart := choose(num,l.ofc1_cart,l.ofc2_cart,l.ofc3_cart,
								l.ofc4_cart,l.ofc5_cart,l.ofc6_cart,l.ra_cart);
 self.cr_sort_sz := choose(num,l.ofc1_cr_sort_sz,l.ofc2_cr_sort_sz,l.ofc3_cr_sort_sz,
								l.ofc4_cr_sort_sz,l.ofc5_cr_sort_sz,l.ofc6_cr_sort_sz,l.ra_cr_sort_sz);
 self.lot := choose(num,l.ofc1_lot,l.ofc2_lot,l.ofc3_lot,
								l.ofc4_lot,l.ofc5_lot,l.ofc6_lot,l.ra_lot);
 self.lot_order := choose(num,l.ofc1_lot_order,l.ofc2_lot_order,l.ofc3_lot_order,
								l.ofc4_lot_order,l.ofc5_lot_order,l.ofc6_lot_order,l.ra_lot_order);
 self.dpbc := choose(num,l.ofc1_dpbc,l.ofc2_dpbc,l.ofc3_dpbc,
								l.ofc4_dpbc,l.ofc5_dpbc,l.ofc6_dpbc,l.ra_dpbc);
 self.chk_digit := choose(num,l.ofc1_chk_digit,l.ofc2_chk_digit,l.ofc3_chk_digit,
								l.ofc4_chk_digit,l.ofc5_chk_digit,l.ofc6_chk_digit,l.ra_chk_digit);
 self.rec_type := choose(num,l.ofc1_record_type,l.ofc2_record_type,l.ofc3_record_type,
								l.ofc4_record_type,l.ofc5_record_type,l.ofc6_record_type,l.ra_record_type);
 self.ace_fips_st := choose(num,l.ofc1_ace_fips_st,l.ofc2_ace_fips_st,l.ofc3_ace_fips_st,
								l.ofc4_ace_fips_st,l.ofc5_ace_fips_st,l.ofc6_ace_fips_st,l.ra_ace_fips_st);
 self.fipscounty := choose(num,l.ofc1_fipscounty,l.ofc2_fipscounty,l.ofc3_fipscounty,
								l.ofc4_fipscounty,l.ofc5_fipscounty,l.ofc6_fipscounty,l.ra_fipscounty);
 self.geo_lat := choose(num,l.ofc1_geo_lat,l.ofc2_geo_lat,l.ofc3_geo_lat,
								l.ofc4_geo_lat,l.ofc5_geo_lat,l.ofc6_geo_lat,l.ra_geo_lat);
 self.geo_long := choose(num,l.ofc1_geo_long,l.ofc2_geo_long,l.ofc3_geo_long,
								l.ofc4_geo_long,l.ofc5_geo_long,l.ofc6_geo_long,l.ra_geo_long);
 self.msa := choose(num,l.ofc1_msa,l.ofc2_msa,l.ofc3_msa,
								l.ofc4_msa,l.ofc5_msa,l.ofc6_msa,l.ra_msa);
 self.geo_blk := choose(num,l.ofc1_geo_blk,l.ofc2_geo_blk,l.ofc3_geo_blk,
								l.ofc4_geo_blk,l.ofc5_geo_blk,l.ofc6_geo_blk,l.ra_geo_blk);
 self.geo_match := choose(num,l.ofc1_geo_match,l.ofc2_geo_match,l.ofc3_geo_match,
								l.ofc4_geo_match,l.ofc5_geo_match,l.ofc6_geo_match,l.ra_geo_match);
 self.err_stat := choose(num,l.ofc1_err_stat,l.ofc2_err_stat,l.ofc3_err_stat,
								l.ofc4_err_stat,l.ofc5_err_stat,l.ofc6_err_stat,l.ra_err_stat);
 self := l;
end;

all_contacts := normalize(base,7,norm(left,counter));

busreg.Layout_BusReg_Contact propagate(busreg.Layout_BusReg_Contact L, busreg.Layout_BusReg_Temp R) := transform
 self.prim_range := If(l.add='',r.mail_prim_range,l.prim_range);
 self.predir := If(l.add='',r.mail_predir,l.predir);
 self.prim_name := If(l.add='',r.mail_prim_name,l.prim_name);
 self.addr_suffix := If(l.add='',r.mail_addr_suffix,l.addr_suffix);
 self.postdir := If(l.add='',r.mail_postdir,l.postdir);
 self.unit_desig := If(l.add='',r.mail_unit_desig,l.unit_desig);
 self.sec_range := If(l.add='',r.mail_sec_range,l.sec_range);
 self.p_city_name := If(l.add='',r.mail_p_city_name,l.p_city_name);
 self.v_city_name := If(l.add='',r.mail_v_city_name,l.v_city_name);
 self.st := If(l.add='',r.mail_st,l.st);
 self.zip := If(l.add='',r.mail_zip,l.zip);
 self.zip4 := If(l.add='',r.mail_zip4,l.zip4);
 self.cart := If(l.add='',r.mail_cart,l.cart);
 self.cr_sort_sz := If(l.add='',r.mail_cr_sort_sz,l.cr_sort_sz);
 self.lot := If(l.add='',r.mail_lot,l.lot);
 self.lot_order := If(l.add='',r.mail_lot_order,l.lot_order);
 self.dpbc := If(l.add='',r.mail_dpbc,l.dpbc);
 self.chk_digit := If(l.add='',r.mail_chk_digit,l.chk_digit);
 self.rec_type := If(l.add='',r.mail_record_type,l.rec_type);
 self.ace_fips_st := If(l.add='',r.mail_ace_fips_st,l.ace_fips_st);
 self.fipscounty := If(l.add='',r.mail_fipscounty,l.fipscounty);
 self.geo_lat := If(l.add='',r.mail_geo_lat,l.geo_lat);
 self.geo_long := If(l.add='',r.mail_geo_long,l.geo_long);
 self.msa := If(l.add='',r.mail_msa,l.msa);
 self.geo_blk := If(l.add='',r.mail_geo_blk,l.geo_blk);
 self.geo_match := If(l.add='',r.mail_geo_match,l.geo_match);
 self.err_stat := If(l.add='',r.mail_err_stat,l.err_stat);
 self := l;
end;

d_base := distribute(base,hash(br_id));
d_contacts := distribute(all_contacts,hash(br_id));

//******** Create Contacts File *****************//
cnts := join(d_contacts(name_last!=''),d_base,left.br_id=right.br_id,propagate(left,right),left outer,local);

matchset := ['A','P','S'];

//DID file
DID_Add.MAC_Match_Flex(cnts,matchset,ssn,junk,name_first,name_middle,
	name_last,name_suffix,prim_range,prim_name,sec_range,zip,st,phone,
	did,busreg.Layout_BusReg_Contact,false,junk,
	75,busreg_out)

//Add old contacts
//old := busreg.File_BusReg_Contact;

//output(busreg_out,,'BASE::BusReg_Contact_'+BusReg.BusReg_Build_Date,overwrite);
ut.mac_sf_buildprocess(busreg_out,'~thor_data400::base::busreg_contact',do1,2);
export BWR_Contact_DID := do1;
