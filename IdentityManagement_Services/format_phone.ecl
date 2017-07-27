/***
  ** Function to transform phone dataset from service into desired format.
 ***/
 
import Gong_services, iesp, Address, doxie;

out_rec := iesp.identitymanagementreport.t_IdmHistPhonesRecord;

export out_rec format_phone (dataset(Gong_Services.Layout_GongHistorySearchService) gong_phone, dataset(doxie.layout_pp_raw_common) phonesplus_phone):= function

	out_rec toGongOut(Gong_Services.Layout_GongHistorySearchService L) := transform
			self.UniqueID := (string)L.did;
			self.Phone10 := L.phone10;
			Self.Address := iesp.ECL2ESP.SetUniversalAddress (
                      L.prim_name, L.prim_range, L.predir, L.postdir,
                      L.suffix, L.unit_desig, L.sec_range, L.p_city_name,
                      L.st, L.z5, L.z4, '', ,
											Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
											'',
											Address.Addr2FromComponents(l.v_city_name, l.st, l.z5)
                      , , , false);
			self.DateFirstSeen := iesp.ECL2ESP.toDate((unsigned)L.dt_first_seen);
			self.DateLastSeen := iesp.ECL2ESP.toDate((unsigned)L.dt_last_seen);
			self.Source				:= 'G';
	end;
	
	projected_gongphones := project(sort(gong_phone, -dt_last_seen), toGongOut(left));
	
	out_rec toPhonesPlusOut(doxie.layout_pp_raw_common L) := transform
			self.UniqueID := (string)L.did;
			self.Phone10 := L.phone;
			Self.Address := iesp.ECL2ESP.SetUniversalAddress (
                      L.prim_name, L.prim_range, L.predir, L.postdir,
                      L.suffix, L.unit_desig, L.sec_range, L.city_name,
                      L.st, L.zip, L.zip4, '', ,
											Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range),
											'',
											Address.Addr2FromComponents(l.city_name, l.st, l.zip)
                      , , , false);
			self.DateFirstSeen := iesp.ECL2ESP.toDate((unsigned)L.dt_first_seen);
			self.DateLastSeen := iesp.ECL2ESP.toDate((unsigned)L.dt_last_seen);
			self.Source				:= 'P';
	end;
	
	projected_ppphones := project(sort(phonesplus_phone, -dt_last_seen), toPhonesPlusOut(left));
	
	projected_phones	 := projected_gongphones & projected_ppphones;
/*******
	// DEBUG
	OUTPUT(projected_phones, NAMED('projected_phones'));
*******/
	
	RETURN projected_phones;

end;