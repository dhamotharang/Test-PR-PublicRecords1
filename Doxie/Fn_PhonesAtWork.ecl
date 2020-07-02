import AutoStandardI, doxie, business_header, ut, doxie_raw, contactcard, std;

export Fn_PhonesAtWork(
	dataset(doxie.layout_references) in_dids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
	unsigned4 recencyInDays = 365,
	unsigned2 minScore = 0) := 
FUNCTION

global_mod := AutoStandardI.GlobalModule();
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

outrec := contactcard.layouts.contact_phone_addr_rec;
con := contactcard.constants;
midrec := record
	outrec;
	unsigned6 bdid;
end;
	
	
//***** FIND EMPLOYERS
pawraw := doxie_raw.paw_raw(in_dids,dateVal,dppa_purpose,glb_purpose)((unsigned)score >= minScore);	

business_header.Layout_Employment_Out get_paw(pawraw ri) :=
TRANSFORM
	SELF := ri;
END;


paw := project(pawraw(
						recencyInDays = 0 or ut.DaysApart(dt_last_seen, (STRING8)Std.Date.Today()) <= recencyInDays),  
						get_paw(LEFT));
						
midrec form_paw_phones(paw le) :=
TRANSFORM

	SELF.contact.did := (unsigned6)le.did;
	SELF.bdid := (unsigned6)le.bdid;
	self.addr.dt_last_seen := (unsigned)le.dt_last_seen div 100;
	self.contact := le;
	SELF := [];
END;

pp := PROJECT(paw,form_paw_phones(LEFT));

//***** FIND EMPLOYERS ADDRESS 
outrec add_bus_phone(pp le, business_header.Key_BH_Best ri) :=
TRANSFORM
	self.addr.zip := (string5)ri.zip;
	self.addr.zip4 := (string4)ri.zip4;
	self.addr.city_name := ri.city;
	self.addr.st := ri.state;
	self.addr.suffix := ri.addr_suffix;
	
	self.addr.dt_last_seen := le.addr.dt_last_seen;
	self.addr.phone := (string)ri.phone;//
	self.addr := ri;
	SELF := le;
END;



wp := JOIN(pp, business_header.Key_BH_Best,
				   keyed(LEFT.bdid<>0 AND keyed(LEFT.bdid=RIGHT.bdid)),
				   add_bus_phone(LEFT,RIGHT),
					 keep(1), limit(0));

//***** USE EMPLOYERS ADDRESS AGAINST GONG
fgong := dedup(project(wp, transform(doxie.layout_AppendGongByAddr_input,
																						self.listing_name := '',
																						self.phone := '',
																						self := left.addr,
																						self := [])),
							  all);
											
wgong := doxie.fn_AppendGongByAddr(fgong,mod_access);


//***** ATTACH FOUND GONG TO BIZ DATA
outrec tra_pa(wp l, wgong r) := transform
	
	self.phone.phone := 				  r.phone;
	self.phone.timezone :=				r.timezone;
	self.phone.listing_name :=    r.listing_name;
	self.phone.ApartmentOffice := false;						//not allowed for now as it seems too far removed 
	self.phone.publish_code :=		if(r.phone = contactCard.constants.str_unlisted, con.str_publish_code_no, con.str_publish_code_yes);
	self := l;
end;

wp_gong   := join(dedup(sort(wp, contact.did, addr.prim_range, addr.prim_name, addr.zip,  -addr.dt_last_seen), contact.did, addr.prim_range, addr.prim_name, addr.zip),
									wgong,
									left.addr.prim_Range = right.prim_range and
									left.addr.prim_name = right.prim_name and
									left.addr.zip = right.zip and
									left.addr.sec_range = right.sec_range and
									 ((right.fname = '' and right.lname = '')	or //could be the building and looks like its listed to a business
										ut.NameMatch(left.contact.fname, left.contact.mname, left.contact.lname, right.fname, right.mname, right.lname) <= 2),//has a convincing name match
									tra_pa(left, right));
	
both := wp + wp_gong;	
	
// output(wp, named('wp'));	
// output(pawraw, named('pawraw'));		
// output(sort(pawraw, -score), named('pawraw_srt'));
// output(paw, named('paw'));		
// output(wgong, named('wgong'));	
// output(fgong, named('fgong'));		
// output(wp_gong, named('wp_gong'));								

return DEDUP(SORT(both(phone.phone<>''),phone.listing_name,phone.phone,RECORD),phone.listing_name,phone.phone, contact.did, contact.company_name);


END;