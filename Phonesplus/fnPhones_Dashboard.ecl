import yellowpages, cellphone, risk_indicators, phonesplus_v2, ut, gong_Neustar;

export fnPhones_Dashboard(string curr_date = ut.GetDate) := function

pplus := distribute(Phonesplus_v2.Fn_Transform_to_Old_Layout(Phonesplus_v2.File_Phonesplus_Base), hash(cellphone));
royalty := distribute(Phonesplus_v2.Fn_Transform_to_Old_Layout(Phonesplus_v2.File_Royalty_Base), hash(cellphone)) (confidencescore > 10);

gongb := Gong_neustar.File_GongBase;

pplus_abv := pplus(confidencescore > 10);

np_pplus := pplus_abv(publishcode in ['N', 'NP']);

PPLSforPTYPES := table(pplus_abv, {string10 phone := cellphone, confidencescore, publishcode, vendor, src});

yellowpages.NPA_PhoneType(PPLSforPTYPES, phone, phonetype, outfile)

flagPTYPES := join(distribute(outfile, hash(phone)), 
				   distribute(np_pplus, hash(cellphone)), 
				   right.cellphone = left.phone, 
						transform(recordof(outfile), self.publishcode := '',self := left),
						left only,
						local);
						
tbPTYPES :=	table(dedup(flagPTYPES, phone, all), {phonetype, publishcode, count_ := count(group)}, phonetype, publishcode, few);

tbVendorPTYPES :=	table(dedup(flagPTYPES, phone, vendor, src, all), {phonetype, publishcode, vendor, src, count_ := count(group)}, phonetype, publishcode, vendor, src, few);

totNP :=	table(dedup(np_pplus, cellphone), {string25 phonetype := 'NON PUB TOTAL', publishcode, count_ := count(group)}, 'NON PUB TOTAL', publishcode, few);

Phonetypes := tbPTYPES;

/////
olay := record string vendor, string src, string phonetype, string publishcode end;

flagPTYPESALL := join(outfile, np_pplus, right.cellphone = left.phone, 
						transform(olay, 
						self.publishcode := if(left.phone = right.cellphone, 'N', 'P'),
						self := left),
						left outer, keep(1));

// comprehensive := table(flagPTYPESALL,{vendor, src, phonetype, publishcode, count_ := count(group)},vendor, src, phonetype, publishcode, few);

///////////// NEW vendor and unique phone counts code for pplus v2

vendors :=
	table(pplus_abv + royalty , {
	  vendor_ids := 
		regexreplace(' ',
		trim(phonesplus_v2.Translation_Codes.fGet_other_sources_from_bitmap((unsigned)Country) + 
		if(phonesplus_v2.Translation_Codes.fGet_other_hdr_sources_from_bitmap((unsigned)Country) <> '' or 
		phonesplus_v2.Translation_Codes.fGet_eq_sources_from_bitmap((unsigned)Country) <> '', ' HD',''), left, right), '\\|'),
	  cellphone});
	   
normed := normalize(vendors, length(stringlib.stringfilter(left.vendor_ids, '|')) + 1, transform({recordof(vendors)},
						vnd := '|' + left.vendor_ids + '|';
						self.vendor_ids := vnd[stringlib.stringfind(vnd, '|', counter)+1..stringlib.stringfind(vnd, '|', counter+1)-1];
						self := left));

dedNormed := dedup(normed, vendor_ids, cellphone, all);

tbnormed := table(dedNormed, {vendor_ids, cnt := count(group)}, vendor_ids, few);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

fDiscConn := function

	td := curr_date;

	ytd := (unsigned)td[1..4];
	mtd := (unsigned)td[5..6];
	dtd := (unsigned)td[7..8];

	new_mtd := map(mtd - 1 >= 1 => mtd - 1, 
								 mtd = 1 => 12,
								 1);
	new_dtd := map(new_mtd = 2 and dtd > 28 => 28,
								 new_mtd in [4,6,9,11] and dtd > 30 => 30,  dtd);
	new_ytd := map(new_mtd = 12 or mtd = 1 => ytd - 1, ytd);

prev_date := (string)new_ytd + intformat(new_mtd, 2, 1) + intformat(new_dtd, 2, 1);

PrevFile := Gong_neustar.File_History_Full_Prepped_for_FCRA_Keys(dt_first_seen <= prev_date and (dt_last_seen = '' or dt_last_seen >= prev_date));
CurrFile := Gong_neustar.File_History_Full_Prepped_for_FCRA_Keys(dt_first_seen <= curr_date and (dt_last_seen = '' or dt_last_seen >= curr_date));

dPrevFile := table(dedup(PrevFile, phone10, all, hash), {phone10, source := 'P'});
dCurrFile := table(dedup(CurrFile, phone10, all, hash), {phone10, source := 'C'});

jn := join(dPrevFile, dCurrFile, left.phone10 = right.phone10, 
																		transform(recordof(dPrevFile), 
																							self.source := map(left.source = 'P' and right.source = 'C' => 'S', 
																																	left.source = 'P'  and right.source = '' => 'P', 'C'),
																							self := left), full outer);

return parallel(
output('Connect Disconnect Compare: ' + prev_date + '-' + curr_date);
// output('Total Records in Previous');
// output(count(PrevFile));
// output('Total Records in Current');
// output(count(CurrFile));
// output('Total Unique Phones in Previous');
// output(count(dPrevFile));
// output('Total Unique Phones in Current');
// output(count(dCurrFile));
// output('Total Phones Previous and Current');
// output(count(jn));
output('Phones in Current and Previous - No Change');
output(count(jn(source = 'S')),named('n_nochange'));
output('Phones in Previous Only - Disconnect');
output(count(jn(source = 'P')),named('n_disconnected'));
output('Phones in Current Only - Connect');
output(count(jn(source = 'C')),named('n_connected'))
// output('Join Error Count - Expect 0');
// output(count(jn(source = '')))
);
end;
						
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////																						
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

run_stats :=
parallel(
output('Phone Dashboard Stats - In Order By Correlating Spreadsheet', named('__'));

output('Phones Plus Phone Types Above Threshold - Unique Phones', named('p1'));
output(sort(Phonetypes, phonetype), all, named('phonetypes_and_nonpubs_abv'));

output('Gong/Phones Plus Comparison Chart', named('p2'));
output(count(dedup(gongb, phoneno, all)), named('count_all_gong_unique_phones'));
output(count(dedup(pplus_abv, cellphone, all)), named('count_pplus_phones_abv'));
output(count(dedup(np_pplus, cellphone, all)), named('count_pplus_phones_npub_abv'));
output(count(dedup(gongb(publish_code in ['N','NP']), prim_range, predir, prim_name, suffix, postdir, unit_desig, sec_range, p_city_name, v_city_name, st, z5, all)), named('count_all_gong_nonpubs'));
output(count(dedup(pplus, cellphone, all)), named('count_all_pplus_phones'));
output(count(dedup(sort(pplus_abv, cellphone, -did, local), cellphone, local)(did > 0)), named('Unique_Phones_With_ADL'));

output('Phones Plus Vendors Above Threshold (All Phone Types, Deduped by Phone and Vendor)', named('p3'));
output(sort(tbnormed, vendor_ids), all, named('Vendor_And_Unique_Phones_Above_Threshold_Cnts'));

output('EDA History Connects and Disconnects', named('p4'));
fDiscConn;

output('Total Records Contributing to Phones Plus by Vendor', named('Email_Only_'));
output(sort(table(normed, {vendor_ids, cnt := count(group)}, vendor_ids, few),vendor_ids), all)
);

return run_stats;
end;