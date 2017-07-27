import ut, did_add, header_slimsort, didville,watchdog,doxie,header,compID;

EXPORT compid__layout_compid := RECORD
   string28 last_name;
   string20 first_name;
   string15 middle_name;
   string3 suffix;
   string6 dob;
   string9 ssn;
   string1 gender;
   string5 zip_code;
   string40 address_1;
   string11 address_2;
   string20 city;
   string2 state;
   string4 zip4;
   string1 dod_ind;
   string4 dod;
   string20 license_number;
   string10 license_type;
   string1 commercial_drivers_license_indicator;
   string15 license_restrictions;
   string2 license_state;
   string6 license_issue_date;
   string6 license_expiration_date;
   string2 original_state;
   string9 original_isn;
   string1 crlf;
  END;

r:=RECORD
  unsigned integer6 did;
  integer8 did_score;
  compid__layout_compid compid_in;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 score;
  string9 clean_ssn;
  string8 clean_dod;
  string8 clean_dob;
  string20 clean_dl;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string10 ind;
 END;


h:=distribute(header.File_Headers,hash(did));
// ds_in:=dataset('~thor_data400::persist::compid::did_out_repro',r,flat);
ds_in:=dataset('~thor_data400::persist::compid::out0_repro2',r,flat);

clean_did_rec:=record
	unsigned6 did:=0,
	integer did_score:=0,

	recordof(ds_in.compid_in) compid;
	recordof(watchdog.File_Best) watchdog;

	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		zip5;
	string4		zip4;
	string4		cart;
	string1		cr_sort_sz;
	string4		lot;
	string1		lot_order;
	string2		dpbc;
	string1		chk_digit;
	string2		rec_type;
	string2		ace_fips_st;
	string3		county;
	string10	geo_lat;
	string11	geo_long;
	string4		msa;
	string7		geo_blk;
	string1		geo_match;
	string4		err_stat;

	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		suffix;
	string3		score;

	string9		clean_ssn;
	string8		clean_dob;
	STRING10	ind := '';
	qstring1	eq_best_dob:='';
	qstring1	neq_best_dob:='';
	qstring1	ln_blank_dob:='';
	qstring1	cp_blank_dob:='';

	qstring1	eq_best_ssn:='';
	qstring1	neq_best_ssn:='';
	qstring1	ln_blank_ssn:='';
	qstring1	cp_blank_ssn:='';

	qstring1	eq_best_name:='';
	qstring1	neq_best_name:='';
	qstring1	ln_blank_name:='';
	qstring1	cp_blank_name:='';

	qstring1	eq_best_addr:='';
	qstring1	neq_best_addr:='';
	qstring1	ln_blank_addr:='';
	qstring1	cp_blank_addr:='';

	qstring1	eq_best_dl:='';
	qstring1	neq_best_dl:='';
	qstring1	ln_blank_dl:='';
	qstring1	cp_blank_dl:='';

end;

did_out:=project(ds_in,transform({clean_did_rec}
									,self.compid:=left.compid_in
									,self:=left
									));

//append watchdog
with_wdog := join(distribute(did_out(did>0),hash(did)),distribute(compID.file_compid_best,hash(did))
					,left.did=right.did
					,transform({did_out},self.watchdog:=right,self:=left)
					,local
					 ) + did_out(did=0);

//populate compare flags
clean_did_rec tr1(with_wdog l) := TRANSFORM

	ln_name				:=trim(	l.watchdog.lname
								+l.watchdog.fname
								+l.watchdog.name_suffix);
	cp_name				:=trim(	l.lname
								+l.fname
								+l.suffix);

	self.eq_best_name	:=if(cp_name=ln_name and ln_name<>'','Y','');
	self.neq_best_name	:=if(cp_name<>ln_name and ln_name<>'' and cp_name<>'','Y','');
	self.ln_blank_name	:=if(ln_name='','Y','');
	self.cp_blank_name	:=if(cp_name='','Y','');

	self.eq_best_dob	:=if((integer)l.clean_dob=l.watchdog.dob and l.watchdog.dob<>0,'Y','');
	self.neq_best_dob	:=if((integer)l.clean_dob<>l.watchdog.dob and l.watchdog.dob>0 and l.clean_dob<>'','Y','');
	self.ln_blank_dob	:=if(l.watchdog.dob=0,'Y','');
	self.cp_blank_dob	:=if(l.clean_dob='','Y','');

	self.eq_best_ssn	:=if(l.clean_ssn=l.watchdog.ssn	and l.watchdog.ssn<>'','Y','');
	self.neq_best_ssn	:=if(l.clean_ssn<>l.watchdog.ssn and l.watchdog.ssn<>'' and l.clean_ssn<>'','Y','');
	self.ln_blank_ssn	:=if(l.watchdog.ssn='','Y','');
	self.cp_blank_ssn	:=if(l.clean_ssn='','Y','');

	self.eq_best_dl		:=if(l.compid.license_number=l.watchdog.DL_number	and l.watchdog.DL_number<>'','Y','');
	self.neq_best_dl	:=if(l.compid.license_number<>l.watchdog.DL_number and l.watchdog.DL_number<>'' and l.compid.license_number<>'','Y','');
	self.ln_blank_dl	:=if(l.watchdog.DL_number='','Y','');
	self.cp_blank_dl	:=if(l.compid.license_number='','Y','');

	cp_addr			:=trim(l.prim_range+
						l.prim_name+
						l.sec_range+
						l.zip5);
	ln_addr			:=trim(l.watchdog.prim_range+
						l.watchdog.prim_name+
						l.watchdog.sec_range+
						l.watchdog.zip);

	self.eq_best_addr	:=if(cp_addr=ln_addr and ln_addr<>'','Y','');
	self.neq_best_addr	:=if(cp_addr<>ln_addr and ln_addr<>'' and cp_addr<>'','Y','');
	self.ln_blank_addr	:=if(ln_addr='','Y','');
	self.cp_blank_addr	:=if(cp_addr='','Y','');

	self := l;
END;

field_compare := project(with_wdog,tr1(LEFT));

//appent segment indicator
segmented_h := distribute(Header.fn_ADLSegmentation(h).core_check,hash(did));
seg_ind := JOIN(distribute(field_compare(did>0),hash(did)),segmented_h
					,	left.did=right.did
					and	right.ind<>''
					,transform({field_compare}
								,self.ind:=right.ind
								,self:=left)
					,left outer
					,keep(1)
					,LOCAL) + field_compare(did=0)
					 :persist('~thor400_84::persist::jbello_compid_seg_ind')
					;

export Prep_for_stats := output(seg_ind,,'~thor_data400::out::alpharetta::compid_prep',__compressed__,overwrite);
