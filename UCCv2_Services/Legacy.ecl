// Get UCC data by tmsid records, and restructure in legacy format

import uccd, doxie_crs, UCCv2, suppress, Address, Census_data, doxie;

export Legacy := module

// constants
shared max_raw_filings := 500;
shared max_raw_parties := 500;
shared max_collateral_recs := 15;

// layouts
export layout_levelRec := { unsigned1 level; UCCv2_services.layout_tmsid };
shared layout_legacy := doxie_crs.layout_UCC_Records;
shared layout_collateral := { string60 collateral_type_desc := '' }; // UCCD.Layout_Collateral_ChildDS
export layout_raw := record
	// ---- These were from UCCD.Key_BDID ----
  unsigned integer6 bdid;
  string50 ucc_key;
  unsigned integer6 did;
  string20 debtor_event_key;
  string20 debtor_fname;
  string20 debtor_mname;
  string20 debtor_lname;
  string5 debtor_name_suffix;
  string60 debtor_status_desc;
  string60 debtor_name;
  string10 debtor_prim_range;
  string2 debtor_predir;
  string28 debtor_prim_name;
  string4 debtor_addr_suffix;
  string2 debtor_postdir;
  string10 debtor_unit_desig;
  string8 debtor_sec_range;
  string25 debtor_city_name;
  string18 debtor_county_name;
  string2 debtor_st;
  string5 debtor_zip;
  string4 debtor_zip4;
  string20 secured_event_key;
  string60 secured_status_desc;
  string60 secured_name;
  string10 secured_prim_range;
  string2 secured_predir;
  string28 secured_prim_name;
  string4 secured_addr_suffix;
  string2 secured_postdir;
  string10 secured_unit_desig;
  string8 secured_sec_range;
  string25 secured_city_name;
  string18 secured_county_name;
  string2 secured_st;
  string5 secured_zip;
  string4 secured_zip4;
	DATASET(layout_collateral) collateral_children {maxcount (max_collateral_recs)};
  string2 filing_state;
  string4 filing_count;
  string4 document_count;
  string3 debtor_count;
  string3 secured_count;
  string8 ucc_exp_date;
  string60 ucc_filing_type_desc;
  string20 event_key;
  string8 orig_filing_date;
  string32 orig_filing_num;
  string8 filing_date;
  string32 event_document_num;
  string60 filing_type_desc;
end;
shared layout_rawLevels := record
	unsigned1 level;
	layout_raw;
end;
shared layout_super := record
	layout_legacy.penalt;
	layout_rawLevels;
end;

shared fn_getUCC_legacy_super(
  dataset(layout_levelRec) in_levels,
	string in_ssn_mask_type,
	string32	appType	=	Suppress.Constants.ApplicationTypes.Default
) := function
	// Suppress by tmsid
	Suppress.MAC_Suppress(in_levels,in_levels_suppress,appType,,,Suppress.Constants.DocTypes.UCC_TMSID,tmsid);
		
	// keys and layouts
	k_main	:= UCCV2.Key_Rmsid_Main(false);
	k_party	:= UCCV2.Key_Rmsid_Party(false);
	l_out		:= layout_super;

	
	// ======================================================================= Filing data

	// transform filing to output-style fields
	l_fRaw := record
		k_main.tmsid;
		k_main.rmsid;
		l_out.ucc_key;
			
		DATASET(layout_collateral) collateral_children {maxcount (max_collateral_recs)};
		
		l_out.filing_state;
		l_out.orig_filing_date;
		l_out.filing_date;
		l_out.event_document_num;
		l_out.filing_type_desc;
		
		l_out.filing_count;
		l_out.document_count;
		
		l_out.level;								// raw only
		l_out.debtor_event_key;			// raw only
		l_out.debtor_status_desc;		// raw only
		l_out.secured_event_key;		// raw only
		l_out.secured_status_desc;	// raw only
		l_out.ucc_exp_date;					// raw only
		l_out.ucc_filing_type_desc;	// raw only
		l_out.event_key;						// raw only
		l_out.orig_filing_num;			// raw only
	end;
	l_fRaw toFiling(in_levels_suppress L, k_main R) := transform
	  self.tmsid			:= R.tmsid;
	  self.rmsid			:= R.rmsid;
	  self.ucc_key		:= R.orig_filing_number;
		
		self.collateral_children := IF(
			R.collateral_desc<>'',
			dataset( [{R.collateral_desc}], layout_collateral ),
			dataset( [], layout_collateral )
		);
		
		self.filing_state				:= r.filing_jurisdiction;
		self.orig_filing_date		:= r.orig_filing_date;
		self.filing_date				:= r.filing_date;
		self.event_document_num	:= r.filing_number;
		self.filing_type_desc		:= r.filing_type;
		
		self.level								:= L.level;
		self.debtor_event_key			:= R.orig_filing_number;
		self.debtor_status_desc		:= R.status_type;
		self.secured_event_key		:= R.orig_filing_number;
		self.secured_status_desc	:= R.status_type;
		self.ucc_exp_date					:= R.expiration_date;
		self.ucc_filing_type_desc	:= R.orig_filing_type;
		self.event_key						:= R.orig_filing_number;
		self.orig_filing_num			:= R.orig_filing_number;
		
		// we'll fill these in later
		self.filing_count		:= '';
		self.document_count	:= '';
	end;

	// retrieve filings from key
	filing_raw := join(
		in_levels_suppress, k_main,
	  keyed(left.tmsid = right.tmsid),
		toFiling(left,right),
		limit(max_raw_filings,skip)
	);
	
	// rollup collateral
	filing_raw toRollup(filing_raw l, filing_raw r) := transform
		self.collateral_children := choosen(L.collateral_children & R.collateral_children, max_collateral_recs);
		self := L;
	end;
	filing_rolled := rollup(
		sort(filing_raw, tmsid, rmsid, record),
		toRollup(left, right),
		tmsid, rmsid
	);
	
	// generate counts
	l_fCnt := record
		string50 tmsid := filing_rolled.tmsid;
		string4 filing_count		:= (string) count(group); // STUB - this is apparently wrong.  see did=2121691822
		string4 document_count	:= (string) count(group); // # of rmsids per tmsid
	end;
	filing_c := table(filing_rolled, l_fCnt, tmsid);

	// and merge them back into the filing recs
	filing_counted := join(
		filing_rolled, filing_c,
		left.tmsid = right.tmsid,
		transform(l_fRaw, self:=right, self:= left)
	);
	

	// ======================================================================= Party data
	
	// retrieve from key and add county_name
	l_pCounty := { k_party; string18 county_name; };
	party_raw := choosen(join(
		in_levels_suppress, k_party,
	  keyed(left.tmsid = right.tmsid),
		transform(l_pCounty, self.county_name:='', self:=right),
		limit(10000,skip)
	)(party_type='D' or party_type='S'),max_raw_parties);
	Census_Data.MAC_Fips2County_Keyed(party_raw, st, county, county_name, party_county);
	
	// transform output-style fields
	l_pRaw := record
		k_party.tmsid;
		k_party.party_type;
		
		l_out.penalt;
		l_out.did;
		l_out.bdid;
		
		l_out.debtor_fname;
		l_out.debtor_mname;
		l_out.debtor_lname;
		l_out.debtor_name_suffix;
		
		l_out.debtor_name;
		l_out.debtor_prim_range;
		l_out.debtor_predir;
		l_out.debtor_prim_name;
		l_out.debtor_addr_suffix;
		l_out.debtor_postdir;
		l_out.debtor_unit_desig;
		l_out.debtor_sec_range;
		l_out.debtor_city_name;
		l_out.debtor_county_name;
		l_out.debtor_st;
		l_out.debtor_zip;
		l_out.debtor_zip4;
		
		l_out.secured_name;
		l_out.secured_prim_range;
		l_out.secured_predir;
		l_out.secured_prim_name;
		l_out.secured_addr_suffix;
		l_out.secured_postdir;
		l_out.secured_unit_desig;
		l_out.secured_sec_range;
		l_out.secured_city_name;
		l_out.secured_county_name;
		l_out.secured_st;
		l_out.secured_zip;
		l_out.secured_zip4;
		
		l_out.debtor_count;
		l_out.secured_count;
	end;
	l_pRaw toParty(party_county R) := transform
		self.tmsid			:= R.tmsid;
		self.party_type	:= R.party_type;
		
		self.penalt :=
				 doxie.FN_Tra_Penalty_CName( R.company_name ) +
			   doxie.FN_Tra_Penalty_BDID( (string)R.bdid ) +
			   doxie.FN_Tra_Penalty_DID( (string)R.did ) +
			   doxie.FN_Tra_Penalty_SSN(R.ssn) +
				 doxie.FN_Tra_Penalty_FEIN(R.fein) +
			   doxie.FN_Tra_Penalty_Name(R.fname, R.mname, R.lname);
				 
		isDebtor	:= (R.party_type='D');
		isSecured	:= (R.party_type='S');
		
		self.did									:= if(isDebtor, R.did,					0);
		self.bdid									:= if(isDebtor, R.bdid,					0);
		self.debtor_fname					:= if(isDebtor, R.fname,				'');
		self.debtor_mname					:= if(isDebtor, R.mname,				'');
		self.debtor_lname					:= if(isDebtor, R.lname,				'');
		self.debtor_name_suffix		:= if(isDebtor, R.name_suffix,	'');
		self.debtor_name					:= if(isDebtor, R.orig_name,		'');
		self.debtor_prim_range		:= if(isDebtor, R.prim_range,		'');
		self.debtor_predir				:= if(isDebtor, R.predir,				'');
		self.debtor_prim_name			:= if(isDebtor, R.prim_name,		'');
		self.debtor_addr_suffix		:= if(isDebtor, R.suffix,				'');
		self.debtor_postdir				:= if(isDebtor, R.postdir,			'');
		self.debtor_unit_desig		:= if(isDebtor, R.unit_desig,		'');
		self.debtor_sec_range			:= if(isDebtor, R.sec_range,		'');
		self.debtor_city_name			:= if(isDebtor, R.p_city_name,	'');
		self.debtor_county_name		:= if(isDebtor, R.county_name,	'');
		self.debtor_st						:= if(isDebtor, R.st,						'');
		self.debtor_zip						:= if(isDebtor, R.zip5,					'');
		self.debtor_zip4					:= if(isDebtor, R.zip4,					'');
		
		self.secured_name					:= if(isSecured, R.orig_name,		'');
		self.secured_prim_range		:= if(isSecured, R.prim_range,	'');
		self.secured_predir				:= if(isSecured, R.predir,			'');
		self.secured_prim_name		:= if(isSecured, R.prim_name,		'');
		self.secured_addr_suffix	:= if(isSecured, R.suffix,			'');
		self.secured_postdir			:= if(isSecured, R.postdir,			'');
		self.secured_unit_desig		:= if(isSecured, R.unit_desig,	'');
		self.secured_sec_range		:= if(isSecured, R.sec_range,		'');
		self.secured_city_name		:= if(isSecured, R.p_city_name,	'');
		self.secured_county_name	:= if(isSecured, R.county_name,	'');
		self.secured_st						:= if(isSecured, R.st,					'');
		self.secured_zip					:= if(isSecured, R.zip5,				'');
		self.secured_zip4					:= if(isSecured, R.zip4,				'');
		
		// we'll fill these in later
		self.debtor_count					:= '';
		self.secured_count				:= '';
	end;
	party_out := project(party_county, toParty(left));
	
	// dedup
	party_dedup := dedup(sort(party_out,record), record);

	// populate party counts
	l_pCnt := record
		string50 tmsid := party_dedup.tmsid;
		string3 cnt	:= (string) count(group);
	end;
	party_cd := table(party_dedup(party_type='D'), l_pCnt, tmsid);
	party_cs := table(party_dedup(party_type='S'), l_pCnt, tmsid);
	
	// and join them back together
	party_tmp := join(
		party_dedup, party_cd, // debtor
		left.tmsid = right.tmsid,
		transform(l_pRaw, self.debtor_count:=right.cnt, self:=left)
	);
	party_counted := join(
		party_tmp, party_cs, // secured
		left.tmsid = right.tmsid,
		transform(l_pRaw, self.secured_count:=right.cnt, self:=left)
	);

	// reduce to one debtor and one secured (preferring low penalties)
	party_reduced := dedup(
		sort(party_counted, tmsid, party_type, penalt, record),
		tmsid, party_type
	);
	

	// ======================================================================= Assimilate Filing & Party Data

	// add debtor
	filing_with_d := join(
		filing_counted, party_reduced,
		left.tmsid=right.tmsid and right.party_type='D'
	);
	
	// add secured & convert to final format
	l_out addSecured(filing_with_d L, party_reduced R) := transform
		self.secured_name					:= R.secured_name;
		self.secured_prim_range		:= R.secured_prim_range;
		self.secured_predir				:= R.secured_predir;
		self.secured_prim_name		:= R.secured_prim_name;
		self.secured_addr_suffix	:= R.secured_addr_suffix;
		self.secured_postdir			:= R.secured_postdir;
		self.secured_unit_desig		:= R.secured_unit_desig;
		self.secured_sec_range		:= R.secured_sec_range;
		self.secured_city_name		:= R.secured_city_name;
		self.secured_county_name	:= R.secured_county_name;
		self.secured_st						:= R.secured_st;
		self.secured_zip					:= R.secured_zip;
		self.secured_zip4					:= R.secured_zip4;
		self := L;
	end;
	filing_with_sd := join(
		filing_with_d, party_reduced,
		left.tmsid=right.tmsid and right.party_type='S',
		addSecured(left,right)
	);
	
	// final sort
	ucc_legacy := sort(filing_with_sd, orig_filing_date, filing_date, record);
	// NOTE: Looking at the old system, I see it's sorting by orig_filing_date,
	// but doesn't have a secondary sort by filing_date.  That doesn't make much
	// sense to me.  I'm adding it anyway.


	// output(filing_raw,			named('filing_raw'));				// DEBUG
	// output(filing_c,				named('filing_c'));					// DEBUG
	// output(filing_counted,	named('filing_counted'));		// DEBUG
	// output(party_raw, 			named('party_raw'));				// DEBUG
	// output(party_county,		named('party_county'));			// DEBUG
	// output(party_out, 			named('party_out'));				// DEBUG
	// output(party_dedup, 		named('party_dedup'));			// DEBUG
	// output(party_cd,				named('party_cd'));					// DEBUG
	// output(party_cs,				named('party_cs'));					// DEBUG
	// output(party_counted, 	named('party_counted'));		// DEBUG
	// output(party_reduced, 	named('party_reduced'));		// DEBUG
	// output(filing_with_d, 	named('filing_with_s'));		// DEBUG
	// output(filing_with_sd,	named('filing_with_sd'));		// DEBUG
	// output(ucc_legacy,			named('ucc_legacy'));				// DEBUG

	return(ucc_legacy);

end; // fn_getUCC_legacy_super

export fn_getUCC_legacy_raw(
  dataset(UCCv2_services.layout_tmsid) in_tmsids,
	string in_ssn_mask_type
) := function

	// create a fake level (which we'll strip later anyway)
	in_levels := project( in_tmsids, transform(layout_levelRec, self.level:=0, self:=left) );
	
	super := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);
	
	raw := project( super, layout_raw );
	
	return(raw);

end; // fn_getUCC_legacy_raw

export fn_getUCC_legacy_rawLevels(
  dataset(layout_levelRec) in_levels,
	string in_ssn_mask_type
) := function

	super := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);
	
	raw := project( super, layout_rawLevels );
	
	return(raw);

end; // fn_getUCC_legacy_rawLevels

export fn_getUCC_legacy(
  dataset(UCCv2_services.layout_tmsid) in_tmsids,
	string in_ssn_mask_type
) := function

	// create a fake level (which we'll strip later anyway)
	in_levels := project( in_tmsids, transform(layout_levelRec, self.level:=0, self:=left) );
	
	// retrieve results (a bit wider than necessary)
	raw := fn_getUCC_legacy_super(in_levels, in_ssn_mask_type);

	// narrow to output format
	outrecs := project( raw, layout_legacy );

	// final sort
	ucc_legacy := sort(outrecs, orig_filing_date, filing_date, record);
	// NOTE: Looking at the old system, I see it's sorting by orig_filing_date,
	// but doesn't have a secondary sort by filing_date.  That doesn't make much
	// sense to me.  I'm adding it anyway.
	
	return(ucc_legacy);

end; // fn_getUCC_legacy

end; // Legacy
