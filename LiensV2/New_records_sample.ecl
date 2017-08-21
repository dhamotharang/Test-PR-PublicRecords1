import LiensV2,ut;
export New_records_sample ( string filedate) := function

ds_main_qa := distribute(LiensV2.file_Hogan_main,hash(tmsid));

ds_main_father := distribute(dataset('~thor_data400::base::liens::main::Hogan_father',LiensV2.Layout_liens_main_module_for_hogan.layout_liens_main,flat),hash(tmsid));


jdiff_main := join ( ds_main_qa,ds_main_father,
           left.tmsid=right.tmsid,
					 transform(recordof(ds_main_qa),self := left),
					 left only,local);
					 
ds_party_qa := distribute(LiensV2.file_Hogan_party,hash(tmsid));

ds_party_father := distribute(dataset('~thor_data400::base::liens::party::Hogan_father',LiensV2.Layout_liens_party_SSN_for_hogan_BIPV2_with_LinkFlags,flat),hash(tmsid));


jdiff_party := join ( ds_party_qa,ds_party_father,
           left.tmsid=right.tmsid,
					 transform(recordof(ds_party_qa),self := left),
					 left only,local);


d01 := output(choosen(jdiff_main, 1000),named('hogan_main_sample_QA'));
d02 := output(choosen(jdiff_party(did <> '' and (unsigned6)did > 0), 1000), named('hogan_party_sample_QA'));
d03 := output(choosen(LiensV2.file_ILFDLN_main(process_date = max(LiensV2.file_ILFDLN_main,process_date)), 1000),named('ILFDLN_main_sample_QA'));
d04 := output(choosen(LiensV2.file_ILFDLN_party(date_vendor_last_reported = max(LiensV2.file_ILFDLN_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('ILFDLN_party_sample_QA'));
d05 := output(choosen(LiensV2.file_NYC_main(process_date = max(LiensV2.file_NYC_main,process_date)), 1000),named('NYC_main_sample_QA'));
d06 := output(choosen(LiensV2.file_NYC_party(date_vendor_last_reported = max(LiensV2.file_NYC_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('NYC_party_sample_QA'));
d07 := output(choosen(LiensV2.file_NYFDLN_main(process_date = max(LiensV2.file_NYFDLN_main,process_date)), 1000),named('NYFDLN_main_sample_QA'));
d08 := output(choosen(LiensV2.file_NYFDLN_party(date_vendor_last_reported = max(LiensV2.file_NYFDLN_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('NYFDLN_party_sample_QA'));
d09 := output(choosen(LiensV2.file_SA_main(process_date = max(LiensV2.file_SA_main,process_date)), 1000),named('SA_main_sample_QA'));
d10 := output(choosen(LiensV2.file_SA_party(date_vendor_last_reported = max(LiensV2.file_SA_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('SA_party_sample_QA'));
d11 := output(choosen(LiensV2.file_chicago_law_main(process_date = max(LiensV2.file_chicago_law_main,process_date)), 1000),named('chicago_law_main_sample_QA'));
d12 := output(choosen(LiensV2.file_chicago_law_party(date_vendor_last_reported = max(LiensV2.file_chicago_law_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('chicago_law_party_sample_QA'));
d13 := output(choosen(LiensV2.file_CA_federal_main(process_date = max(LiensV2.file_CA_federal_main,process_date)), 1000),named('CA_federal_main_sample_QA'));
d14 := output(choosen(LiensV2.file_CA_federal_party(date_vendor_last_reported = max(LiensV2.file_CA_federal_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 1000), named('CA_federal_party_sample_QA'));
/*d15 := output(choosen(LiensV2.file_Hogan_party(date_vendor_last_reported = max(LiensV2.file_Hogan_party,date_vendor_last_reported) and did <> '' and (unsigned6)did > 0), 100), named('hogan_party_nonblank_did_sample_QA'));
d16 := output(choosen(LiensV2.file_Hogan_party(date_vendor_last_reported = max(LiensV2.file_Hogan_party,date_vendor_last_reported) and bdid <> '' and (unsigned6)bdid > 0), 100), named('hogan_party_nonblank_bdid_sample_QA'));
d17 := output(choosen(LiensV2.file_Hogan_main(process_date = max(LiensV2.file_Hogan_main,process_date) and irs_serial_number <> ''), 100),named('hogan_main_nonblank_irs_sample_QA'));*/

fmain := LiensV2.file_Hogan_main(process_date =  filedate and irs_serial_number <> '' );

fmaindist := distribute(fmain,hash(tmsid,rmsid));

fparty := LiensV2.file_Hogan_party( date_vendor_last_reported =  filedate and did <> '' or bdid <> '' or tax_id <> '');

fpartydist := distribute(fparty,hash(tmsid,rmsid));

final := record
string8 process_date;
string50 tmsid;
string50 rmsid;
string irs_serial_number := '';
string9 tax_id := '';
string12 DID  := '';
string12 BDID := '';

end;

final mainpty(fmaindist le,fpartydist re) := transform
self.irs_serial_number := le.irs_serial_number;
self.tax_id := re.tax_id;
self.process_date := if ( le.process_date > re.date_vendor_last_reported ,le.process_date,re.date_vendor_last_reported);
self.did := if ( (unsigned)re.did <> 0,re.did,'');
self.bdid := if ( (unsigned)re.bdid <> 0,re.bdid,'');
self := re;
end;

dmainpty := sort(join(fmaindist,fpartydist,left.tmsid=right.tmsid and left.rmsid=right.rmsid,mainpty(left,right), right outer,local),tmsid,rmsid,local);


final ptyroll( dmainpty l,dmainpty r) := transform
self.did := if ( l.did <> '',l.did,r.did);
self.bdid := if ( l.bdid <> '',l.bdid,r.bdid);
self := l;
end;

newroll := rollup( dmainpty ,ptyroll(left,right),tmsid,rmsid,local);

d15 := output(choosen(dmainpty(tmsid <> '' and rmsid <> '' and irs_serial_number <> '' and (unsigned) did <> 0 ) ,500),named('Hogan_main_party_did_Sample'));
d16 := output(choosen(dmainpty(tmsid <> '' and rmsid <> '' and irs_serial_number <> '' and (unsigned) bdid <> 0 and tax_id <> '') ,500),named('Hogan_main_party_bdid_Sample'));
d17 := output(choosen(newroll(tmsid <> '' and rmsid <> '' and  bdid <> '' and  did <> '' and process_date = filedate) ,500),named('Hogan_main_party_did_bdid_Sample'));


return parallel(d01, d02, d03, d04, d05, d06, d07, d08, d09, d10, d11, d12, d13, d14,d15,d16,d17);
end;
	