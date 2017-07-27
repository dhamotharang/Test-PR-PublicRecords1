import doxie, doxie_crs, doxie_ln, Suppress, STD;

string26 alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
doxie_cbrs.mac_Selection_Declare()

export property_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

br := doxie_cbrs.best_records_bdids(bdids)(Include_Properties_val and 
							 ((ln_branded_value and bdid in set(bdids,bdid)) 
							  or (not ln_branded_value and bdid = doxie_cbrs.subject_BDID)
							  or use_SupergroupPropertyAddress_val));

//get the fares IDs by address
doxie.layout_propertySearch tra(br l) := transform
	self.zip := (string5)l.zip;
	self.suffix := l.addr_suffix;
	self.address_seq_no := 0;
	self := l;
end;

brt := dedup(project(br, tra(left)), all);

idsADDR := doxie_ln.get_PriorProperty_ids(brt);

//get the fares IDs by BDID
bdids_use := bdids(Include_Properties_val);
idsBDID := doxie_cbrs.getPropertyIDsByBDID(bdids_use);

//get all my IDs organized
IDrec := doxie_ln.layout_property_ids;


IDrec addrtra(idsADDR l) := transform
	self.bdid := 0;
  self.current := true;
	self := l;
end;

IDrec bdidtra(idsBDID l) := transform
	self.address_seq_no := 0;
	self.did := 0;
  self.current := true;
	self := l;
end;

ia := project(idsADDR, addrtra(left));
ib := project(idsBDID, bdidtra(left));
					 
id_dups := (ia + ib)(source_code[1] = 'O');
					 
ids := dedup(id_dups, fid, all);

//use mac to get deeds and assesors

dr := doxie_ln.deed_records (ids);
ar := doxie_ln.asses_records (ids);

both0 := doxie_ln.make_property_records(ar, dr, true);
both := if(doxie.DataRestriction.Fares,both0(ln_fares_id[1] <>'R'),both0);

//take a shot at reverse engineering the logic
owns := both(source_code='O');

grp := group(owns,
             STD.Str.Filter (property_address_citystatezip, alphabet),
             trim(property_full_street_address, all),
             trim(property_address_unit_number, all), all);
				 
srt := sort(grp,
				 name_owner_1[1..5], -doxie_ln.get_LNFirst(ln_fares_id));	  
				 
//dedup owned property records by property address, owner-seller-code				
ddpd := dedup(srt,
					name_owner_1[1..5]);
					
//mark the most recent at each address as current
srt2 := sort(ddpd, -compare_date);

outrec := doxie_cbrs.layout_property_records;

srt2 iter(srt2 l, srt2 r) := transform	
	self.current := if(l.ln_fares_id = '', true, false);
	self := r;
end;

itd := group(iterate(srt2, iter(left, right)));

//mark those that came from address (for split down the road)
outrec mrkema(itd l,IDrec r) := transform
	self.bdid := 0;
	self.byBDID := false;
	self.byAddress := r.fid <> '';
	self := l;
end;

mrkda := join(itd, dedup(sort(ia, fid, did, bdid, address_seq_no, source_code, current), fid), 
			        left.ln_fares_id = right.fid, mrkema(left, right), left outer);

//mark those that came from bdid
outrec mrkemb(mrkda l, IDrec r) := transform
	self.bdid := r.bdid;
	self.byBDID := r.bdid > 0;
	self.title_company_name := '';  //CKB - hack for now, for bugzilla 14975
	self := l;
end;

mrkdb := join(mrkda, dedup(sort(ib, fid, did, bdid, address_seq_no, source_code, current), fid, all), 
				      left.ln_fares_id = right.fid, mrkemb(left, right), left outer);

mrkdb_accountforfares := if(doxie.DataRestriction.Fares,mrkdb(ln_fares_id[1]<>'R'),mrkdb);

app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, application_type_value);

Suppress.MAC_Suppress(mrkdb_accountforfares,suppress_fares_id,App_type,'','',Suppress.Constants.DocTypes.FaresID,ln_fares_id);
Suppress.MAC_Suppress(suppress_fares_id,suppress_bdid,App_type,Suppress.Constants.LinkTypes.BDID,bdid);

return if(PropertyVersion in [0,1],sort(suppress_bdid, record));
END;