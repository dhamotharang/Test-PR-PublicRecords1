// default ip is QA roxie, if you want to run instantid against a different roxie, pass this function the IP of that roxie.

export InstantID_SoapCall(dataset(Layout_InstID_SoapCall) indataset, string roxieIP='http://certstagingvip.hpcc.risk.regn.net:9876')  := function

dist_dataset := DISTRIBUTE(indataset, RANDOM());

xlayout := RECORD
	risk_indicators.Layout_InstandID_NuGen;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) :=
TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF.AcctNo := le.AccountNumber;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, roxieIP,
				'risk_indicators.InstantID', {dist_dataset}, 
				DATASET(xlayout),
				PARALLEL(2), onFail(myFail(LEFT)));
				
ylayout := record
	risk_indicators.Layout_InstantID_NuGen_Denorm;
	string errorcode;
end;

ylayout normit(resu L) := transform
	self.hri_1 := if (count(l.ri) >= 1, L.ri[1].hri, '');
	self.hri_desc_1 := if (count(l.ri) >= 1, L.ri[1].desc, '');
	self.hri_2 := if (count(l.ri) >= 2, L.ri[2].hri, '');
	self.hri_desc_2 := if (count(l.ri) >= 2, L.ri[2].desc, '');
	self.hri_3 := if (count(l.ri) >= 3, L.ri[3].hri, '');
	self.hri_desc_3 := if (count(l.ri) >= 3, L.ri[3].desc, '');
	self.hri_4 := if (count(l.ri) >= 4, L.ri[4].hri, '');
	self.hri_desc_4 := if (count(l.ri) >= 4, L.ri[4].desc, '');
	self.hri_5 := if (count(l.ri) >= 5, L.ri[5].hri, '');
	self.hri_desc_5 := if (count(l.ri) >= 5, L.ri[5].desc, '');
	self.hri_6 := if (count(l.ri) >= 6, L.ri[6].hri, '');
	self.hri_desc_6 := if (count(l.ri) >= 6, L.ri[6].desc, '');
	self.fua_1 := if (count(l.fua) >= 1, L.fua[1].hri, '');
	self.fua_desc_1 := if (count(l.fua) >= 1, L.fua[1].desc, '');
	self.fua_2 := if (count(l.fua) >= 2, L.fua[2].hri, '');
	self.fua_desc_2 := if (count(l.fua) >= 2, L.fua[2].desc, '');
	self.fua_3 := if (count(l.fua) >= 3, L.fua[3].hri, '');
	self.fua_desc_3 := if (count(l.fua) >= 3, L.fua[3].desc, '');
	self.fua_4 := if (count(l.fua) >= 4, L.fua[4].hri, '');
	self.fua_desc_4 := if (count(l.fua) >= 4, L.fua[4].desc, '');
	self.additional_fname_1 := if (count(L.additional_lname) >= 1, l.additional_lname[1].fname1,'');
	self.additional_lname_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].lname1, '');
	self.additional_lname_date_last_1 := if (count(l.additional_lname) >= 1, L.additional_lname[1].date_last, '');
	self.additional_fname_2 := if (count(L.additional_lname) >= 2, l.additional_lname[2].fname1,'');
	self.additional_lname_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].lname1, '');
	self.additional_lname_date_last_2 := if (count(l.additional_lname) >= 2, L.additional_lname[2].date_last, '');
	self.additional_fname_3 := if (count(L.additional_lname) >= 3, l.additional_lname[3].fname1,'');
	self.additional_lname_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].lname1, '');
	self.additional_lname_date_last_3 := if (count(l.additional_lname) >= 3, L.additional_lname[3].date_last, '');
	self.chron_address_1 := if (count(L.chronology) >= 1, L.chronology[1].address, '');
	self.chron_city_1 := if (count(L.chronology) >= 1, L.chronology[1].city, '');
	self.chron_st_1 := if (count(L.chronology) >= 1, L.chronology[1].st, '');
	self.chron_zip_1 := if (count(L.chronology) >= 1, L.chronology[1].zip, '');
	self.chron_phone_1 := if (count(L.chronology) >= 1, L.chronology[1].phone, '');
	self.chron_address_2 := if (count(L.chronology) >= 2, L.chronology[2].address, '');
	self.chron_city_2 := if (count(L.chronology) >= 2, L.chronology[2].city, '');
	self.chron_st_2 := if (count(L.chronology) >= 2, L.chronology[2].st, '');
	self.chron_zip_2 := if (count(L.chronology) >= 2, L.chronology[2].zip, '');
	self.chron_phone_2 := if (count(L.chronology) >= 2, L.chronology[2].phone, '');
	self.chron_address_3 := if (count(L.chronology) >= 3, L.chronology[3].address, '');
	self.chron_city_3 := if (count(L.chronology) >= 3, L.chronology[3].city, '');
	self.chron_st_3 := if (count(L.chronology) >= 3, L.chronology[3].st, '');
	self.chron_zip_3 := if (count(L.chronology) >= 3, L.chronology[3].zip, '');
	self.chron_phone_3 := if (count(L.chronology) >= 3, L.chronology[3].phone, '');
	self.did := intformat(L.did,12,1);
	self.transaction_id := intformat(L.transaction_id, 12, 1);
	self.nas_summary := (string)L.nas_summary;
	self.nap_summary := (string)L.nap_summary;
	self.CVI := (String)L.cvi;
	self.additional_score1 := (string)L.additional_score1;
	self.additional_score2 := (string)L.additional_score2;
	self.seq := intformat(L.seq,12,1);
	self.age := if (l.age = '***', '', L.age);
	
	self.fd_score1 := l.models[1].scores[1].i;  // 0-999
	self.fd_score2 := l.models[1].scores[2].i;  // 10-50
	self.fd_score3 := l.models[1].scores[3].i;  // 10-90
	self.fd_Reason1 := l.models[1].scores[1].reason_codes[1].reason_code;
	self.fd_Desc1 := l.models[1].scores[1].reason_codes[1].Reason_Description;
	self.fd_Reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.fd_Desc2 := l.models[1].scores[1].reason_codes[2].Reason_Description;
	self.fd_Reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.fd_Desc3 := l.models[1].scores[1].reason_codes[3].Reason_Description;
	self.fd_Reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	self.fd_Desc4 := l.models[1].scores[1].reason_codes[4].Reason_Description;
		
	self := L;
	
end;

normalizedresults := project(resu, normit(left));

return normalizedresults;

end;
