// ************************** CAREFUL **************************
//
// set version number (date of run) for proper input file handling.
//
//**************************************************************

import fieldstats,did_add,ut,census_data;

pre := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_Data400::in::Prof_Licenses_FATHER'),
	fileservices.addsuperfile('~thor_data400::in::Prof_Licenses_FATHER','~thor_data400::in::Prof_Licenses_IN',0,true),
	fileservices.clearsuperfile('~thor_data400::in::Prof_Licenses_IN'),
	fileservices.addsuperfile('~thor_data400::in::Prof_Licenses_IN','~thor_data400::in::prof_license_' + prof_license.version),
	fileservices.finishsuperfiletransaction()
	);

inf := prof_license.file_prof_license;

fieldstats.mac_stat_file(inf,stats,'prof_licenses',50,6,true,
		license_type,'string','F',
		license_number,'string','M',
		company_name,'string','M',
		expiration_date,'string','M',
		prim_Name,'string','M',
		lname,'string','M')


ver := prof_license.version;

infile := prof_license.file_prof_license;

matchset := ['A','D','P'];
outrec := record
		layout_prolic_in;
		string18  county_name := '';
		string12  did_string  := '';
		string3   did_score   := '';
		string9   ssn         := '';
		string12  bdid_string := '';
end;

//****** Add a temp field for carrying the DID
rec := record
	outrec;
	unsigned6 did;
	unsigned6 temp_did_score;
	unsigned6	bdid := 0;
end;

rec addtemp(infile l) := transform
	self.did := 0;
	self.temp_did_score := 0;
	self := l;
end;

inmac := project(infile, addtemp(left));

//****** Add the DIDs
did_Add.MAC_Match_Flex
	(inmac, matchset,
	 ssn, dob, fname, mname,lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st, phone,
	 DID,
	 rec,
	 true, temp_DID_Score,
	 75,
	 wdid)

//****** Add the SSN
	did_add.MAC_Add_SSN_By_DID(wdid, DID, ssn, wssn)


//****** Add the BDID
	business_header.mac_source_match(wssn,wbdid1,
								false,bdid,
								false,'PL',
								false,foo,
								company_name,
								prim_range,prim_name,sec_range,zip,
								true,phone,
								false,foo);

	wbdid2 := wbdid1(bdid != 0);
	wobdid := wbdid1(bdid = 0);
	myset := ['A','P'];

	business_header_Ss.mac_match_flex(wobdid,myset,
								company_name,
								prim_range,prim_name,zip,sec_range,st,
								phone,foo,
								bdid,
								rec,
								false, foo,
								wbdid3)

	wall := wbdid2 + wbdid3;


//****** Transfer from the temp field to the outgoing DID field
outrec tra(wall l) := transform
	self.did_string := if (l.did = 0, '', intformat(l.DID, 12, 1));
	self.did_score := intformat(l.temp_DID_score, 3, 1);
	self.bdid_string := if (L.bdid = 0, '', intformat(L.bdid,12,1));
	self := l;
end;

pre_outfile := project(wall, tra(left));

/*pre_outfile getCounty(pre_outfile L, census_data.File_Fips2County R) := transform
	self.county_name := R.county_name;
	self := L;
end;

outfile := join(pre_outfile,census_data.File_Fips2County,left.county = right.county_fips and
			left.ace_fips_St = right.state_code,getCounty(LEFT,RIGHT),
				left outer, lookup);
*/

census_data.MAC_Fips2County(pre_outfile,st,county,county_name,outfile)


ut.MAC_SF_BuildProcess(outfile,'~thor_data400::base::prof_licenses',do_out)


email := fileservices.sendemail('eneiberg@seisint.com; bbartels@seisint.com; cmaroney@seisint.com','Professional Licenses stats and results', 'completed ' + ut.GetDate + ' -- wuid: ' + thorlib.WUID());

export proc_build_base := sequential(pre,stats,do_out,email);
