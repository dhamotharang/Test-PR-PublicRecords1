import dnb, codes, business_header, doxie, ut;;
doxie_cbrs.mac_Selection_Declare()

export DNB_records(dataset(doxie_cbrs.layout_references) in_bdids, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

//**** keep the group bdids but the target info for comparison
outrec := record
	unsigned1 level := 0;
	doxie_cbrs.Layout_BH_Best_String;
end;

temprecs := fn_best_records(project(in_bdids,transform(doxie_cbrs.layout_supergroup,self.group_id := 0,self := left)),false);

bes := project(temprecs,outrec);

ut.MAC_Slim_Back(bes, doxie_cbrs.layout_best_records_prs, wla)

//indicators
wcur := doxie_cbrs.mark_ABCurrent(wla,in_bdids);
doxie_cbrs.mac_hasBBB(wcur, wbbb, in_bdids)

bdids0 := wbbb(Include_DunBradstreetRecords_val);
bestinfo := choosen(doxie_cbrs.fn_best_information(in_bdids,false),1);
			
bdids0 carry(bdids0 l, bdids0 r) := transform
	self.bdid := r.bdid;
	self := if(exists(bestinfo),project(bestinfo[1],transform(recordof(bdids0),self.bdid:=(unsigned)left.bdid,self:=left)),if(l.bdid = 0,r,l));
end;

bdids := iterate(bdids0, carry(left, right));

//***** get the dnb stuff
dnk := 
record
	dnb.key_DNB_BDID;
	doxie_cbrs.layout_best_records_prs.Company_name;
	doxie_cbrs.layout_best_records_prs.zip;
	doxie_cbrs.layout_best_records_prs.prim_range;
	doxie_cbrs.layout_best_records_prs.prim_name;
END;

dnk keepr(bdids l, dnb.key_DNB_BDID r) := transform
	self := r;
	self := l;
end;
dnos := join(bdids, dnb.key_DNB_BDID, keyed(left.bdid = right.bd) and mod_access.use_DNB(), keepr(left,right));

k := dnb.key_DNB_DunsNum;

layout_dnb :=
RECORD
	DNB.Layout_DNB_Base -[global_sid, record_sid]; //RR-15382 Suppressing CCPA fields in Doxie_cbrs.Business_Report_Service_Raw output
	// unsigned1 zipMatch;
	// unsigned1 addrMatch;
	// unsigned1 coMatch; 
END;

layout_dnb keepk(dnos l, k r) := transform
	// SELF.zipMatch := (unsigned)(l.zip=r.zip);
	// SELF.addrMatch := (UNSIGNED)(l.prim_range=stringlib.stringtouppercase(r.prim_range)) + (UNSIGNED)(l.prim_name=stringlib.stringtouppercase(r.prim_name));
	// SELF.coMatch := ut.CompanySimilar100(l.company_name, stringlib.stringtouppercase(r.business_name));
	self := r;
end;

//**** pick the best ONE

alldnb := join(dedup(dnos, all), k, keyed(left.duns_number = right.duns) and mod_access.use_DNB(), keepk(left, right));
srtdnb := sort(alldnb, if(bdid in set(in_bdids,bdid),0,1),
											 // coMatch,
											 // -zipMatch,
											 // -addrMatch, 
											 -date_last_seen,
											 record);
ddpdnb :=  dedup(srtdnb,true); //should leave only ONE record for royalty purposes


//**** decodes

with_decodes := record
	recordof(ddpdnb);
	string15	structure_type_decoded;
	string30	type_of_establishment_decoded;
	string5	owns_rents_decoded;
end;

with_decodes into_out(ddpdnb L) := transform
	self.structure_type_decoded := codes.keyCodes('DNB_COMPANIES','structure_type',,l.structure_type);
	self.type_of_establishment_decoded := codes.keyCodes('DNB_COMPANIES','type_of_establishment',,L.type_of_establishment);
	self.owns_rents_decoded := codes.keyCodes('DNB_COMPANIES','owns_rents',,L.owns_rents);
	self := L;
end;

return project(ddpdnb, into_out(LEFT));
END;
