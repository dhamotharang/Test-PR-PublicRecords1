// This module contains code involved in counting the number of times the source
// report results reference various data types: Name, SSN, DOB, FEIN, Address, Phone

import doxie_cbrs, ut, iesp, MDR, dx_header;

export Occurrence := module

	// =-=-=-=-=-=-=-=-=-=-=-= Constants =-=-=-=-=-=-=-=-=-=-=-=

	// valid src codes
	//
	// NOTE: If you add new entries to src_code, you must increment max_sources to match it!
	//       Also, versioned sources must be added to versioned_sources (appears below src_code).
	//
	shared set_prop_a		:= [ MDR.sourceTools.src_LnPropV2_Fares_Asrs, MDR.sourceTools.src_LnPropV2_Lexis_Asrs ];
	shared set_prop_d		:= [ MDR.sourceTools.src_LnPropV2_Fares_Deeds, MDR.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs, MDR.sourceTools.src_Fares_Deeds_from_Asrs ];
	export l_src				:= { string13 code; set of string2 ridSrc; string50 desc; };
	export max_sources	:= 65; // 51 people/combined sources + 14 Business only sources
  // src_code contents information:
	// 1. The "code" values below (i.e. first entry in each "row") are an abbreviated
	//    version of the child dataset names in the layout of the dataset coming out of:
	//    a. Doxie.HeaderSource_Service (i.e. Doxie_Raw.Layout_crs_raw) for people and
	//       combined people/business sources.
	//    OR
	//    b. doxie_cbrs.Business_Report_Source_Service (i.e. doxie_cbrs.layout_source)
	//       for business only sources.
	// 2. The "ridSrc" values below (i.e. second entry in each "row") are the appropriate
	//    two character source code(s) or set of source codes.
	// 3. The "description" values below (i.e. third entry in each "row") were derived from
	//    emails sent by various ESP staff members showing source descriptions used within ESP.
	shared src_code			:= module
		export atf					:= row({'ATF',						MDR.sourceTools.set_Atf,										'Federal Firearms and Explosive Licenses'},	l_src);
		export bk						:= row({'BK',							MDR.sourceTools.set_Bk,											'Bankruptcy Records'},											l_src);
		export bkv2					:= row({'BK_V2',					MDR.sourceTools.set_Bk,											'Bankruptcy Records'},											l_src);
		export lien					:= row({'LIEN',						MDR.sourceTools.set_Liens,									'Liens and Judgments'},											l_src);
		export lienv2				:= row({'LIEN_V2',				MDR.sourceTools.set_Liens,									'Liens and Judgments'},											l_src);
		export dl						:= row({'DL',							MDR.sourceTools.set_DL,											'Driver Licenses'},													l_src);
		export dl2					:= row({'DL_V2',					MDR.sourceTools.set_DL,											'Driver Licenses'},													l_src);
		export death				:= row({'DEATH',					MDR.sourceTools.set_Death,									'Deceased'}, 																l_src);
		export proflic			:= row({'PROFLIC',				MDR.sourceTools.set_Professional_License,		'Professional Licenses'},										l_src);
		export sanc					:= row({'SANC',						MDR.sourceTools.set_Ingenix_Sanctions,			'Sanctions'},																l_src);
		export prov					:= row({'PROV',						[],																					'Medical Providers'},												l_src);
		export email				:= row({'EMAIL',					[],																					'Email Addresses'}, 												l_src);
		export emailv2			:= row({'EMAIL_V2',				[],																					'Email Addresses'}, 												l_src);
		export veh					:= row({'VEH',						MDR.sourceTools.set_Vehicles,								'Motor Vehicle Registrations'},							l_src);
		export vehv2				:= row({'VEH_V2',					MDR.sourceTools.set_Vehicles,								'Motor Vehicle Registrations'},							l_src);
		export eq						:= row({'EQ',							MDR.sourceTools.set_Equifax,								'Person Locator 1'}, 												l_src);
		export en						:= row({'EN',							MDR.sourceTools.set_Experian_Credit_Header,	'Person Locator 5'}, 												l_src);
		export dea					:= row({'DEA',						MDR.sourceTools.set_Dea,										'DEA Controlled Substances Registrations'}, l_src);
		export deav2				:= row({'DEA_V2',					MDR.sourceTools.set_Dea,										'DEA Controlled Substances Registrations'}, l_src);
		export airc					:= row({'AIRC',						MDR.sourceTools.set_Aircrafts,							'FAA Aircraft Registrations'},							l_src);
		export pilot				:= row({'PILOT',					MDR.sourceTools.set_Airmen,									'FAA Pilot Licenses'},											l_src);
		export pilotcert		:= row({'PILOTCERT',			MDR.sourceTools.set_Airmen,									'FAA Pilot Certifications'},								l_src);
		export watercraft		:= row({'WATERCRAFT',			MDR.sourceTools.set_WC,											'Watercraft Registrations'}, 								l_src);
		export ucc					:= row({'UCC',						MDR.sourceTools.set_UCCS,										'UCC Lien Filings'},												l_src);
		export uccv2				:= row({'UCC_V2',					MDR.sourceTools.set_UCCS,										'UCC Lien Filings'},												l_src);
		export corpAffil		:= row({'CORPAFFIL',			MDR.sourceTools.set_CorpV2,									'Corporate Affiliations'},									l_src);
		export ccw					:= row({'CCW',						MDR.sourceTools.set_EMerge_CCW,							'Weapon Permits'},													l_src);
		export voter				:= row({'VOTER',					MDR.sourceTools.set_Voters_v2,							'Voter Registrations'},											l_src);
		export voterv2			:= row({'VOTER_V2',				MDR.sourceTools.set_Voters_v2,							'Voter Registrations'},											l_src);
		export hunt					:= row({'HUNT',						MDR.sourceTools.set_EMerge_Hunt,						'Hunting and Fishing Licenses'},						l_src);
		export whois				:= row({'WHOIS',					MDR.sourceTools.set_Whois_domains,					'Internet Domain Registrations'},						l_src);
		export phone				:= row({'PHONE',					MDR.sourceTools.set_Gong_phone_append,			'Phones'},																	l_src);
		export assessment		:= row({'ASSESSMENT',			set_prop_a,																	'Tax Assessor Records'},										l_src);
		export assessment2	:= row({'ASSESSMENT_V2',	set_prop_a,																	'Tax Assessor Records'},										l_src);
		export deed					:= row({'DEED',						set_prop_d,																	'Deed Transfers'},													l_src);
		export deed2				:= row({'DEED_V2',				set_prop_d,																	'Deed Transfers'},													l_src);
		export flcrash			:= row({'FLCRASH',				[],																					'Accident'}, 																l_src);
		export DOC					:= row({'DOC',						MDR.sourceTools.set_Accurint_DOC,						'Criminal'}, 																l_src);
		export SO						:= row({'SEXOFFENDER',		MDR.sourceTools.set_Accurint_Sex_offender,	'Sexual Offenses'}, 												l_src);
		export finder				:= row({'FINDER',					['FI'],																			'Historical Person Locator'}, 							l_src);
		export ak						:= row({'AK',							MDR.sourceTools.set_AK_Perm_Fund,						'Alaska Permanent Fund'}, 									l_src);
		export nod					:= row({'NOD',						MDR.sourceTools.set_Foreclosures_Delinquent,'Notice Of Defaults'},				 							l_src);
		export for					:= row({'FOR',						MDR.sourceTools.set_Foreclosures,						'Foreclosure Records'}, 										l_src);
		export util					:= row({'UTIL',						MDR.sourceTools.set_Utility_sources,				'Utility Data'},														l_src);
		export mswork				:= row({'MSWORK',					MDR.sourceTools.set_Workmans_Comp,					'Mississippi Worker\'s Compensation'},			l_src);
		export boater				:= row({'BOATER',					MDR.sourceTools.set_EMerge_Boat,						'Boat Registrations'}, 											l_src);
		export tu						:= row({'TU',							MDR.sourceTools.set_Transunion,							'Person Locator 2'}, 												l_src);
		export tn						:= row({'TN',							MDR.sourceTools.set_Transunion_Credit_Header,'Person Locator 6'}, 									  	l_src);
		export quickheader	:= row({'EQ',							MDR.sourceTools.set_Equifax,								'Person Locator 1'}, 												l_src); // Currently the same as Equifax
		export targ					:= row({'TARG',						MDR.sourceTools.set_Targus_White_pages,			'Person Locator 4'}, 												l_src);
		export phonesPlus		:= row({'PP',							MDR.sourceTools.set_Phones_Plus,						'Phones'}, 																	l_src);
		export FBNv2				:= row({'FBN',						MDR.sourceTools.set_Fbnv2,									'Fictitious Business Names Records'}, 			l_src);
		//Business only sources ---------v
		export bbbm   			:= row({'BBBM',  					MDR.sourceTools.set_BBB_Member,							'Better Business Bureau Member'}, 					l_src);
		export bbbnm  			:= row({'BBBNM',  				MDR.sourceTools.set_BBB_Non_Member,					'Better Business Bureau Non-Member'},				l_src);
    export bfinder			:= row({'BFINDER',	 		  MDR.sourceTools.set_Business_header,				'Business Finder'}, 												l_src);
		export castax  			:= row({'CASALESTAX', 		MDR.sourceTools.set_CA_Sales_Tax,						'California Sales Tax'}, 										l_src);
		export cont   			:= row({'CONTACTS',   		MDR.sourceTools.set_Business_contacts,			'Business Contacts'}, 											l_src);
		export corp     		:= row({'CORP',						MDR.sourceTools.set_CorpV2,									'Corporate Filings'},												l_src);
		export corpv2    		:= row({'CORP_V2',				MDR.sourceTools.set_CorpV2,									'Corporate Filings'},												l_src);
 	  export dnb    			:= row({'DNB',    				MDR.sourceTools.set_Dunn_Bradstreet,				'Dun & Bradstreet'}, 		 										l_src);
		export ebr    			:= row({'EBR',						MDR.sourceTools.set_EBR,										'Experian Business Reports'}, 							l_src);
		export fdic    			:= row({'FDIC',    				MDR.sourceTools.set_FDIC,										'FDIC'}, 																		l_src);
		export iastax  			:= row({'IASALESTAX',  		MDR.sourceTools.set_IA_Sales_Tax,						'Iowa Sales Tax'}, 													l_src);
		export irs5500 			:= row({'IRS5500', 				MDR.sourceTools.set_IRS_5500,								'IRS Form 5500'}, 													l_src);
		export irsnp   			:= row({'IRSNP', 					MDR.sourceTools.set_IRS_Non_Profit,					'IRS Form 990'}, 														l_src);
		export orwork				:= row({'ORWORK',					MDR.sourceTools.set_OR_Worker_Comp,					'Oregon Worker\'s Compensation'},						l_src);
	end;
  // NOTE: a similar list of codes appears in doxie.Comprehensive_Report_Service and
	//       doxie_cbrs/all_base_records_prs and ESP also maintains a list of codes,
	//       descriptions, and a couple other values that differ in some fairly small ways.
  //       In a perfect world, we'd find a way to consolidate these four lists.

	export versioned_sources := [
		src_code.bk.code,					src_code.bkv2.code,
		src_code.lien.code,				src_code.lienv2.code,
		src_code.veh.code,				src_code.vehv2.code,
		src_code.dea.code,				src_code.deav2.code,
		src_code.ucc.code,				src_code.uccv2.code,
		src_code.voter.code,			src_code.voterv2.code,
		src_code.assessment.code,	src_code.assessment2.code,
		src_code.deed.code,				src_code.deed2.code,
		src_code.corp.code,				src_code.corpv2.code,
		src_code.email.code,			src_code.emailv2.code
	];

	// valid datum codes
	export datum_code := module
		export name		:= 'NAME';
		export ssn		:= 'SSN';
		export dob		:= 'DOB';
		export fein		:= 'FEIN';
		export addr		:= 'ADDR';
		export phone	:= 'PHONE';
	end;
	export max_datum := 6;

	// =-=-=-=-=-=-=-=-=-=-=-= Handshake =-=-=-=-=-=-=-=-=-=-=-=

	// INPUT: each record in each child dataset of the source report must be transformed to...
	export l_in := record
		string13	src;
		string50	src_desc;
		boolean		hasName  := false;
		boolean		hasSSN   := false;
		boolean		hasDOB   := false;
		boolean		hasFEIN  := false;
		boolean		hasAddr  := false;
		boolean		hasPhone := false;
		unsigned	dt_first_seen;
		unsigned	dt_last_seen;
	end;

	// OUTPUT: which we'll roll up into...
	export l_ref := record
		string50 src; // NOTE: for ESP purposes, this will actually contain the description
		unsigned occurrences;
		l_in.dt_first_seen;
		l_in.dt_last_seen;
	end;

	export l_out := record
		string5					datum;
		unsigned1				num_sources;
		dataset(l_ref)	sources { maxcount(max_sources) };
	end;

	// =-=-=-=-=-=-=-=-=-=-=-= Code =-=-=-=-=-=-=-=-=-=-=-=

	// ---- convert ridSrc strings to their descriptions
	export ridSrc_to_desc(string2 ridSrc) := map(
		ridSrc in src_code.atf.ridSrc					=> src_code.atf.desc,
		ridSrc in src_code.bk.ridSrc					=> src_code.bk.desc,
		ridSrc in src_code.lien.ridSrc				=> src_code.lien.desc,
		ridSrc in src_code.dl.ridSrc					=> src_code.dl.desc,
		ridSrc in src_code.death.ridSrc				=> src_code.death.desc,
		ridSrc in src_code.proflic.ridSrc			=> src_code.proflic.desc,
		ridSrc in src_code.sanc.ridSrc				=> src_code.sanc.desc,
		ridSrc in src_code.prov.ridSrc				=> src_code.prov.desc,
		ridSrc in src_code.email.ridSrc				=> src_code.email.desc,
		ridSrc in src_code.veh.ridSrc					=> src_code.veh.desc,
		ridSrc in src_code.eq.ridSrc					=> src_code.eq.desc,
		ridSrc in src_code.en.ridSrc					=> src_code.en.desc,
		ridSrc in src_code.dea.ridSrc					=> src_code.dea.desc,
		ridSrc in src_code.airc.ridSrc				=> src_code.airc.desc,
		ridSrc in src_code.pilot.ridSrc				=> src_code.pilot.desc,
		ridSrc in src_code.pilotcert.ridSrc		=> src_code.pilotcert.desc,
		ridSrc in src_code.watercraft.ridSrc	=> src_code.watercraft.desc,
		ridSrc in src_code.ucc.ridSrc					=> src_code.ucc.desc,
		ridSrc in src_code.corpAffil.ridSrc		=> src_code.corpAffil.desc,
		ridSrc in src_code.ccw.ridSrc					=> src_code.ccw.desc,
		ridSrc in src_code.voter.ridSrc				=> src_code.voter.desc,
		ridSrc in src_code.hunt.ridSrc				=> src_code.hunt.desc,
		ridSrc in src_code.whois.ridSrc				=> src_code.whois.desc,
		ridSrc in src_code.phone.ridSrc				=> src_code.phone.desc,
		ridSrc in src_code.assessment.ridSrc	=> src_code.assessment.desc,
		ridSrc in src_code.deed.ridSrc				=> src_code.deed.desc,
		ridSrc in src_code.flcrash.ridSrc			=> src_code.flcrash.desc,
		ridSrc in src_code.DOC.ridSrc					=> src_code.DOC.desc,
		ridSrc in src_code.SO.ridSrc					=> src_code.SO.desc,
		ridSrc in src_code.finder.ridSrc			=> src_code.finder.desc,
		ridSrc in src_code.ak.ridSrc					=> src_code.ak.desc,
		ridSrc in src_code.nod.ridSrc					=> src_code.nod.desc,
		ridSrc in src_code.for.ridSrc					=> src_code.for.desc,
		ridSrc in src_code.util.ridSrc				=> src_code.util.desc,
		ridSrc in src_code.mswork.ridSrc			=> src_code.mswork.desc,
		ridSrc in src_code.boater.ridSrc			=> src_code.boater.desc,
		ridSrc in src_code.tu.ridSrc					=> src_code.tu.desc,
		ridSrc in src_code.tn.ridSrc					=> src_code.tn.desc,
		ridSrc in src_code.quickheader.ridSrc	=> src_code.quickheader.desc,
		ridSrc in src_code.targ.ridSrc				=> src_code.targ.desc,
		ridSrc in src_code.phonesPlus.ridSrc	=> src_code.phonesPlus.desc,
		ridSrc in src_code.FBNv2.ridSrc				=> src_code.FBNv2.desc,
		''
	);

  // Business sources ------------------v
	// Convert Business Header 2 char source codes to their descriptions.
	// A separate BHSrc_to_desc map was created since some business descriptions
	// are different than the people descriptions for the same source codes
	// (i.e. 'Corporate Filings' vs "Corpate Affliations') and
	// certain business codes are in multiple MDR.sourceTools.set_*** attributes
	// (i.e. code=BR=src_Business_Registration is in set_Business_Contacts and
	// set_Business_Header).
	//NOTE: The order of the map entries below matches the order of the child datasets
	//  in the results of doxie_cbrs.Business_Report_Source_Service, except
	//  the "finder" child dataset is output first in order, but is
	//  checked for after all the other individual sources since some sources
	//  are in their own set_*** and in the set_business_header.
	//  Also the "contacts" chlid dataset has no correpsonding "map" entry due to
	//  those sources codes also being mapped to "bfinder" description.
	export BHSrc_to_desc(string2 BHSrc) := map(
    BHSrc in src_code.dnb.ridSrc			    => src_code.dnb.desc,
		BHSrc in src_code.corp.ridSrc		  		=> src_code.corp.desc,
	  BHSrc in src_code.bk.ridSrc						=> src_code.bk.desc,
		BHSrc in src_code.ucc.ridSrc				  => src_code.ucc.desc,
    BHSrc in src_code.lien.ridSrc					=> src_code.lien.desc,
		// Skipped Business Contacts section on purpose because those related
		// source codes are also in the Business Finder section/set_business_header.
		//BHSrc in src_code.cont.ridSrc		  		=> src_code.cont.desc,
		BHSrc in src_code.assessment.ridSrc		=> src_code.assessment.desc,
		BHSrc in src_code.deed2.ridSrc				=> src_code.deed2.desc,
		BHSrc in src_code.nod.ridSrc			    => src_code.nod.desc,
    BHSrc in src_code.for.ridSrc			    => src_code.for.desc,
    BHSrc in src_code.whois.ridSrc		  	=> src_code.whois.desc,
    BHSrc in src_code.proflic.ridSrc		  => src_code.proflic.desc,
		BHSrc in src_code.veh.ridSrc				  => src_code.veh.desc,
    BHSrc in src_code.watercraft.ridSrc		=> src_code.watercraft.desc,
		BHSrc in src_code.airc.ridSrc			  	=> src_code.airc.desc,
    BHSrc in src_code.ebr.ridSrc			    => src_code.ebr.desc,
    BHSrc in src_code.irs5500.ridSrc		  => src_code.irs5500.desc,
    BHSrc in src_code.irsnp.ridSrc			  => src_code.irsnp.desc,
    BHSrc in src_code.fdic.ridSrc			    => src_code.fdic.desc,
    BHSrc in src_code.bbbm.ridSrc			    => src_code.bbbm.desc,
    BHSrc in src_code.bbbnm.ridSrc			  => src_code.bbbnm.desc,
    BHSrc in src_code.castax.ridSrc			  => src_code.castax.desc,
    BHSrc in src_code.iastax.ridSrc			  => src_code.iastax.desc,
 		BHSrc in src_code.mswork.ridSrc				=> src_code.mswork.desc,
		BHSrc in src_code.orwork.ridSrc			  => src_code.orwork.desc,
    BHSrc in src_code.bfinder.ridSrc			=> src_code.bfinder.desc,
    // Default = If input code does not match to any of the ones above,
		// just output the 2 char source code that was input to this map for
		// debugging purposes.
		BHSrc
	);

	// ---- the main rollup logic ----
	shared dataset(l_out) roll(dataset(l_in) ds_in) := function

		// produce separate records for each data type
		l_tmp := record(l_ref)
			l_in.src_desc;
			l_out.datum;
		end;
		l_tmp toTmp(l_in L, integer C) := transform
			self.datum := choose(C,
				if (L.hasName,	datum_code.name,	skip),
				if (L.hasSSN,		datum_code.ssn,		skip),
				if (L.hasDOB,		datum_code.dob,		skip),
				if (L.hasFEIN,	datum_code.fein,	skip),
				if (L.hasAddr,	datum_code.addr,	skip),
				if (L.hasPhone,	datum_code.phone,	skip),
				skip
			);
			self.occurrences := 1;
			self := L;
		end;
		tmp := normalize(ds_in, max_datum, toTmp(left, counter));

		// rollup by src/datum, counting occurrences as we go
		l_tmp toCnt(l_tmp L, l_tmp R) := transform
			self.occurrences		:= L.occurrences + R.occurrences;
			self.dt_first_seen	:= ut.min2(L.dt_first_seen, R.dt_first_seen);
			self.dt_last_seen		:= Max(L.dt_last_seen, R.dt_last_seen);
			self := L;
		end;
		cnt := rollup(sort(tmp, datum, src), toCnt(left,right), datum, src);

		// merge occurrences by datum/src_desc one of two ways...
		// - for versioned records we need to avoid duplicated counts
		// - otherwise just accomodate cases where src:src_desc is many:1 (e.g. Phones & Phones Plus)
		l_tmp toMerged(l_tmp L, l_tmp R) := transform
			self.occurrences		:= if(L.src in versioned_sources, L.occurrences, L.occurrences + R.occurrences);
			self.dt_first_seen	:= ut.min2(L.dt_first_seen, R.dt_first_seen);
			self.dt_last_seen		:= Max(L.dt_last_seen, R.dt_last_seen);
			self := L;
		end;
		cnt_s		:= sort(cnt, datum, src_desc, -occurrences, src, record);
		merged	:= rollup(cnt_s, toMerged(left,right), datum, src_desc);

		// rollup by datum to show occurrences in a child dataset
		l_out toOut(l_tmp L, dataset(l_tmp) R) := transform
			self.datum				:= L.datum;
			self.num_sources	:= count(R);
			all_sources				:= project(choosen(R, max_sources), transform(l_ref,self.src:=left.src_desc,self:=left)); // the choosen is just insurance
			self.sources			:= sort(all_sources, -dt_last_seen, dt_first_seen, src, record);
		end;
		grp := group(sort(merged, datum, src, record), datum);
		results := rollup(grp, group, toOut(left, rows(left)));

		// output(ds_in,		named('ds_in'));		// DEBUG
		// output(tmp,			named('tmp'));			// DEBUG
		// output(cnt,			named('cnt'));			// DEBUG
		// output(merged, 	named('merged'));		// DEBUG

		return results;

	end; // roll()

	// --- Common date macros
	// Convert iesp date format to YYYYMMDD
	shared normDate_iesp(iesp.share.t_Date d) := (unsigned)(d.Year*10000 + d.Month*100 + d.Day);

	// macros to extract dt_first_seen/dt_last_seen from a child dataset
	shared mac_dt_first(ds, field) := macro
		ut.NormDate(min(ds(field<>0), field))
	endmacro;
	shared mac_dt_first_str(ds, field) := macro
		ut.NormDate(min(ds(field<>''), (unsigned)field))
	endmacro;
	shared mac_dt_last(ds, field) := macro
		ut.NormDate(max(ds, field))
	endmacro;
	shared mac_dt_last_str(ds, field) := macro
		ut.NormDate(max(ds, (unsigned)field))
	endmacro;

  // define whether DATUM is present; we don't need real validity check, just most basic.
  shared boolean is_valid_dob (string8 dob) := (integer) dob[1..4] > 0;

	// --- generate results from doxie.HeaderSource_Service results ----
	export dataset(l_out) fromHSS(dataset(Doxie_Raw.Layout_crs_raw) ds_in) := function

		// HSS returns a single row every time
		base := ds_in[1];

		// One section at a time, work our way through the HSS output,
		// transforming each piece into the common input layout we need

		ds_atf := project(base.atf_child, transform(l_in,
			self.src 						:= src_code.atf.code;
			self.src_desc				:= src_code.atf.desc;
			self.hasName				:= (left.License_Name<>'');
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.Premise_State<>'' or left.Premise_orig_Zip<>'' or left.Mail_State<>'' or left.Mail_Zip_Code<>'');
			self.hasPhone				:= (left.Voice_Phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_bk := project(base.bk_child, transform(l_in,
			self.src 						:= src_code.bk.code;
			self.src_desc				:= src_code.bk.desc;
			self.hasName				:= exists(left.debtor_records(exists(names(debtor_lname<>'' or debtor_fname<>''))));
			self.hasSSN					:= exists(left.debtor_records(debtor_ssn<>''));
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.debtor_records(exists(addresses(st<>'' or z5<>''))));
			self.hasPhone				:= false; // STUB - v1/v2 mismatch
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.disposed_date), ut.NormDate((unsigned)left.reopen_date) );
		));

		ds_bkv2 := project(base.bk_V2_child, transform(l_in,
			self.src 						:= src_code.bkv2.code;
			self.src_desc				:= src_code.bkv2.desc;
			self.hasName				:= exists(left.debtors(exists(names(orig_name<>''))));
			self.hasSSN					:= exists(left.debtors(exists(names(ssn<>''))));
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.debtors(exists(addresses(orig_st<>'' or orig_zip5<>''))));
			self.hasPhone				:= exists(left.debtors(exists(phones)));
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.disposed_date), ut.NormDate((unsigned)left.reopen_date) );
		));

		ds_lien := project(base.lien_child, transform(l_in,
			self.src 						:= src_code.lien.code;
			self.src_desc				:= src_code.lien.desc;
			self.hasName				:= (left.defname<>'');
			self.hasSSN					:= (left.orig_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.orig_state<>'' or left.orig_zip<>'');
			self.hasPhone				:= false; // STUB - v1/v2 mismatch
			dt_filing						:= ut.NormDate((unsigned)left.filing_date);
			self.dt_first_seen	:= dt_filing;
			self.dt_last_seen		:= Max(dt_filing, ut.NormDate((unsigned)left.release_date));
		));

		ds_lienv2 := project(base.lien_V2_child, transform(l_in,
			self.src 						:= src_code.lienv2.code;
			self.src_desc				:= src_code.lienv2.desc;
			self.hasName				:= exists(left.debtors(orig_name<>''));
			self.hasSSN					:= exists(left.debtors(exists(parsed_parties(ssn<>''))));
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.debtors(exists(addresses)));
			self.hasPhone				:= exists(left.debtors(exists(addresses(exists(phones (phone != ''))))));
			dt_filing						:= ut.NormDate((unsigned)left.orig_filing_date);
			dt_rel							:= ut.NormDate((unsigned)left.release_date);
			dt_judsat						:= ut.NormDate((unsigned)left.judg_satisfied_date);
			dt_judvac						:= ut.NormDate((unsigned)left.judg_vacated_date);
			self.dt_first_seen	:= dt_filing;
			self.dt_last_seen		:= max(dt_filing, dt_rel, dt_judsat, dt_judvac);
		));

		ds_dl := project(base.dl_child, transform(l_in,
			self.src 						:= src_code.dl.code;
			self.src_desc				:= src_code.dl.desc;
			self.hasName				:= (left.name<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= (left.dob<>0);
			self.hasAddr				:= (left.state<>'' or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate(left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate(left.dt_last_seen);
		));

		l_dl2		:= recordof(base.dl2_child);
		tmp_dl2 := rollup(base.dl2_child, true, transform(l_dl2, self.dl:=left.dl+right.dl, self:=[]));
		ds_dl2	:= project(tmp_dl2[1].dl, transform(l_in,
			self.src 						:= src_code.dl2.code;
			self.src_desc				:= src_code.dl2.desc;
			self.hasName				:= (left.name<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= (left.dob<>0);
			self.hasAddr				:= (left.state<>'' or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate(left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate(left.dt_last_seen);
		));

		ds_death := project(base.death_child, transform(l_in,
			self.src 						:= src_code.death.code;
			self.src_desc				:= src_code.death.desc;
			self.hasName				:= (left.lname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= is_valid_dob (left.dob) or is_valid_dob (left.dob8);
			self.hasAddr				:= (left.state<>'' or left.zip_lastres<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dob8);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dod8);
		));

		ds_proflic := project(base.proflic_child, transform(l_in,
			self.src 						:= src_code.proflic.code;
			self.src_desc				:= src_code.proflic.desc;
			self.hasName				:= (left.orig_name<>'');
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= is_valid_dob (left.dob);
			self.hasAddr				:= (left.orig_st<>'' or left.orig_zip<>'');
			self.hasPhone				:= (left.phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_sanc := project(base.sanc_child, transform(l_in,
			self.src 						:= src_code.sanc.code;
			self.src_desc				:= src_code.sanc.desc;
			self.hasName				:= (left.Prov_Clean_lname<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= is_valid_dob (left.SANC_DOB);
			self.hasAddr				:= (left.ProvCo_Address_Clean_st<>'' or left.ProvCo_Address_Clean_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_prov := project(base.prov_child, transform(l_in,
			self.src 						:= src_code.prov.code;
			self.src_desc				:= src_code.prov.desc;
			self.hasName				:= exists(left.name(Prov_Clean_lname<>''));
			self.hasSSN					:= false;
			self.hasDOB					:= exists(left.dob (is_valid_dob (BirthDate)));
			self.hasAddr				:= exists(left.business_address(prov_clean_st<>'' or prov_clean_zip<>''));
			self.hasPhone				:= exists(left.business_address(exists(phone(phonenumber<>''))));
			self.dt_first_seen	:= mac_dt_first_str(left.license, Effective_Date);
			self.dt_last_seen		:= mac_dt_last_str(left.license, Termination_Date);
		));

		ds_email := project(base.email_child, transform(l_in,
			self.src 						:= src_code.email.code;
			self.src_desc				:= src_code.email.desc;
			self.hasName				:= exists(left.names(lname<>''));
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= left.best_dob<>0;
			self.hasAddr				:= exists(left.addresses(st<>'' or zip<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate(left.best_dob);
			self.dt_last_seen		:= ut.NormDate(left.latest_orig_login_date);
		));

		ds_emailv2 := project(base.email_v2_child, transform(l_in,
			self.src 						:= src_code.emailv2.code;
			self.src_desc				:= src_code.emailv2.desc;
			self.hasName				:= left.Cleaned.Name.last<>'';
			self.hasSSN					:= left.Cleaned.ssn<>'';
			self.hasDOB					:= left.Cleaned.dob>0;
			self.hasAddr				:= left.Cleaned.Address.state<>'' or left.Cleaned.Address.zip5<>'';
			self.hasPhone				:= left.Cleaned.phone<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.DateFirstSeen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.DateLastSeen);
		));

		ds_veh := project(base.veh_child, transform(l_in,
			self.src 						:= src_code.veh.code;
			self.src_desc				:= src_code.veh.desc;
			self.hasName				:= (left.own_1_customer_name<>'' or left.own_2_customer_name<>'' or
															left.reg_1_customer_name<>'' or left.reg_2_customer_name<>'' or
															left.lh_1_customer_name<>'' or left.lh_2_customer_name<>'' or left.lh_3_customer_name<>'');
			self.hasSSN					:= (left.own_1_feid_ssn<>'' or left.own_2_feid_ssn<>'' or
															left.reg_1_feid_ssn<>'' or left.reg_2_feid_ssn<>'' or
															left.lh_1_feid_ssn<>'' or left.lh_2_feid_ssn<>'' or left.lh_3_feid_ssn<>'');
			self.hasDOB					:= (left.own_1_dob<>'' or left.own_2_dob<>'' or
															left.reg_1_dob<>'' or left.reg_2_dob<>'' or
															left.lh_1_dob<>'' or left.lh_2_dob<>'' or left.lh_3_dob<>'');
			self.hasAddr				:= (left.own_1_state<>'' or left.own_2_state<>'' or
															left.reg_1_state<>'' or left.reg_2_state<>'' or
															left.lh_1_state<>'' or left.lh_2_state<>'' or left.lh_3_state<>'' or
															left.own_1_zip5_zip4_foreign_postal<>'' or left.own_2_zip5_zip4_foreign_postal<>'' or
															left.reg_1_zip5_zip4_foreign_postal<>'' or left.reg_2_zip5_zip4_foreign_postal<>'' or
															left.lh_1_zip5_zip4_foreign_postal<>'' or left.lh_2_zip5_zip4_foreign_postal<>'' or left.lh_3_zip5_zip4_foreign_postal<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate(left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate(left.dt_last_seen);
		));

		ds_vehv2 := project(base.veh_v2_child, transform(l_in,
			self.src 						:= src_code.vehv2.code;
			self.src_desc				:= src_code.vehv2.desc;
			self.hasName				:= exists(left.registrants(orig_name<>''));
			self.hasSSN					:= exists(left.registrants(orig_ssn<>''));
			self.hasDOB					:= exists(left.registrants(is_valid_dob (orig_dob)));
			self.hasAddr				:= exists(left.registrants(st<>'' or zip5<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= mac_dt_first_str(left.registrants, Reg_Earliest_Effective_Date);
			self.dt_last_seen		:= mac_dt_last_str(left.registrants, Reg_Latest_Effective_Date);
		));

		ds_eq := project(base.eq_child, transform(l_in,
			self.src 						:= src_code.eq.code;
			self.src_desc				:= src_code.eq.desc;
			self.hasName				:= (left.first_name<>'' or left.last_name<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.current_state<>'' or left.current_zip<>'');
			self.hasPhone				:= false;
			//#138824 : Changing dt_first_seen and dt_last_seen based on date_first_seen & date_last_seen that has become newly available for QH & WH rids.
			self.dt_first_seen	:= if(left.date_first_seen = '' ,
																ut.NormDate((unsigned)left.current_address_date_reported) ,
																ut.NormDate((unsigned)left.date_first_seen));

			// Bug #100330: The eq data here is guaranteed to be current by the header build. Changing the last seen date to reflect that.
			self.dt_last_seen   := if(left.date_last_seen = '' ,
																ut.NormDate(CHOOSEN (dx_header.key_max_dt_last_seen(), 1)[1].max_date_last_seen),
																ut.NormDate((unsigned)left.date_last_seen));

			 // NOTE: The eq data contains two other dates that are about old addresses not shown in the person
			 //       search cite lists, so for consistency here we need to reference the current date only.
		));

		ds_en := project(base.en_child, transform(l_in,
			self.src 						:= src_code.en.code;
			self.src_desc				:= src_code.en.desc;
			self.hasName				:= (left.orig_fname<>'' or left.orig_lname<>'');
			self.hasSSN					:= (left.social_security_number<>'');
			self.hasDOB					:= is_valid_dob (left.date_of_birth);
			self.hasAddr				:= (left.orig_state<>'' or left.orig_zipcode<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= Left.date_first_seen;
			self.dt_last_seen		:= Left.date_last_seen;
		));

		ds_dea := project(base.dea_child, transform(l_in,
			self.src 						:= src_code.dea.code;
			self.src_desc				:= src_code.dea.desc;
			self.hasName				:= (left.lname<>'' or left.fname<>'');
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.state<>'' or left.zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_reported);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_reported);
		));

		ds_deav2 := project(base.dea_v2_child, transform(l_in,
			self.src 						:= src_code.deav2.code;
			self.src_desc				:= src_code.deav2.desc;
			self.hasName				:= exists(left.children(name<>''));
			self.hasSSN					:= exists(left.children(best_ssn<>''));
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.children(address<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= mac_dt_first_str(left.Children, Expiration_Date);
			self.dt_last_seen		:= mac_dt_last_str(left.Children, Expiration_Date);
		));

		ds_airc := project(base.airc_child, transform(l_in,
			self.src 						:= src_code.airc.code;
			self.src_desc				:= src_code.airc.desc;
			self.hasName				:= (left.name<>'');
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.state<>'' or left.zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_pilot := project(base.pilot_child, transform(l_in,
			self.src 						:= src_code.pilot.code;
			self.src_desc				:= src_code.pilot.desc;
			self.hasName				:= (left.orig_lname<>'' or left.orig_fname<>'');
			self.hasSSN					:= (left.best_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.state<>'' or left.zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_pilotcert := project(base.pilotcert_child, transform(l_in,
			// There's nothing in this layout that's useful to us!  I'm
			// just keeping this code here to show it wasn't forgotten.
			self.src 						:= src_code.pilotcert.code;
			self.src_desc				:= src_code.pilotcert.desc;
			self.hasName				:= false;
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= false;
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_watercraft := project(base.watercraft_child, transform(l_in,
			self.src 						:= src_code.watercraft.code;
			self.src_desc				:= src_code.watercraft.desc;
			self.hasName				:= exists(left.owners(lname<>'' or fname<>''));
			self.hasSSN					:= exists(left.owners(ssn<>''));
			self.hasDOB					:= exists(left.owners(is_valid_dob (dob)));
			self.hasAddr				:= exists(left.owners(st<>'' or zip5<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_last_seen); // no first_seen
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_ucc := project(base.ucc_child, transform(l_in,
			self.src 						:= src_code.ucc.code;
			self.src_desc				:= src_code.ucc.desc;
			self.hasName				:= (left.debtor_fname<>'' or left.debtor_lname<>'' or left.secured_name<>''); // STUB - do we count secured?
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.debtor_st<>'' or left.debtor_zip<>'' or left.secured_st<>'' or left.secured_zip<>''); // STUB - do we count secured?
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.orig_filing_date);
		));

		ds_uccv2 := project(base.ucc_v2_child, transform(l_in,
			self.src 						:= src_code.uccv2.code;
			self.src_desc				:= src_code.uccv2.desc;
			self.hasName				:= exists(left.debtors(orig_name<>'')) or exists(left.secureds(orig_name<>'')); // STUB - do we count secured?
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.debtors(exists(addresses))) or exists(left.secureds(exists(addresses)));
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.orig_filing_date), ut.NormDate((unsigned)left.cmnt_effective_date) );
		));

		ds_corpAffil := project(base.corpaffil_child, transform(l_in,
			self.src 						:= src_code.corpAffil.code;
			self.src_desc				:= src_code.corpAffil.desc;
			self.hasName				:= (left.contact_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.st<>'' or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.filing_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.filing_date);
		));

		l_in x_emerge(Doxie_Raw.Layout_emerge_raw L, string13 code, string50 desc) := transform
			self.src 						:= code;
			self.src_desc				:= desc;
			self.hasName				:= (L.lname_in<>'' or L.fname_in<>'');
			self.hasSSN					:= (L.best_ssn<>'');
			self.hasDOB					:= is_valid_dob (L.dob_str_in);
			self.hasAddr				:= (L.res_state<>'' or L.res_zip<>'' or L.mail_state<>'' or L.mail_zip<>'' or L.st<>'' or L.zip<>'');
			self.hasPhone				:= (L.phone<>'' or L.work_phone<>'' or L.other_phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)L.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)L.date_last_seen);
		end;
		ds_ccw		:= project(base.emerge_child(file_id='CCW'),	x_emerge(left, src_code.ccw.code, src_code.ccw.desc));
		ds_hunt		:= project(base.emerge_child(file_id='HUNT'),	x_emerge(left, src_code.hunt.code, src_code.hunt.desc));
		ds_voter	:= project(base.emerge_child(file_id='VOTE'),	x_emerge(left, src_code.voter.code, src_code.voter.desc));

		ds_voterv2 := project(base.voters_v2_child, transform(l_in,
			self.src 						:= src_code.voterv2.code;
			self.src_desc				:= src_code.voterv2.desc;
			self.hasName				:= (left.name.lname<>'' or left.name.fname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= is_valid_dob(left.dob);
			self.hasAddr				:= (left.res.st<>'' or left.res.zip5<>'' or left.mail.st<>'' or left.mail.zip5<>'');
			self.hasPhone				:= (left.phone<>'' or left.work_phone<>'');
			d1 := ut.NormDate((unsigned)left.RegDate);
			d2 := ut.NormDate((unsigned)left.LastDateVote);
			self.dt_first_seen	:= ut.Min2(d1,d2);
			self.dt_last_seen		:= Max(d1,d2);
		));

		ds_whois := project(base.whois_child, transform(l_in,
			self.src 						:= src_code.whois.code;
			self.src_desc				:= src_code.whois.desc;
			self.hasName				:= (left.registrant_name<>'' or left.admin_name<>'' or left.tech_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.registrant_address1<>'' or left.admin_address1<>'' or left.tech_address1<>'');
			self.hasPhone				:= false; // Phone may exist in an address field, but there's no good way to id it here.
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_phone := project(base.phone_child, transform(l_in,
			self.src 						:= src_code.phone.code;
			self.src_desc				:= src_code.phone.desc;
			self.hasName				:= (left.listed_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.st<>'' or left.z5<>'');
			self.hasPhone				:= (left.phone10<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_assessment := project(base.assessor_child, transform(l_in,
			self.src 						:= src_code.assessment.code;
			self.src_desc				:= src_code.assessment.desc;
			self.hasName				:= (left.assessee_name<>'' or left.second_assessee_name<>'' or
															left.fares_non_parsed_assessee_name<>'' or left.fares_non_parsed_second_assessee_name<>'' or
															left.fares_seller_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.mailing_city_state_zip<>'' or left.property_city_state_zip<>'');
			self.hasPhone				:= (left.assessee_phone_number<>'');
      rc_dt         	    := ut.NormDate((unsigned)left.recording_date);
			av_dt               := ut.NormDate((unsigned)left.assessed_value_year);
			mv_dt               := ut.NormDate((unsigned)left.market_value_year);
			// Then use the recording_date if not zero or assessed_value_year if not zero,
			// otherwise use the market_value_year
		  self.dt_first_seen  := if(rc_dt<>0,rc_dt,
			                          if(av_dt<>0,av_dt, mv_dt));
		  // don't use rc_dt for last seen unless other 2 are empty
			self.dt_last_seen	  := if(av_dt<>0, av_dt,
			                          if(mv_dt<>0, mv_dt, rc_dt));
		));

		ds_assessment2 := project(base.assessor2_child, transform(l_in,
			self.src 						:= src_code.assessment2.code;
			self.src_desc				:= src_code.assessment2.desc;
			self.hasName				:= exists(left.parties(exists(orig_names(orig_name<>''))));
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.parties(orig_csz<>''));
			self.hasPhone				:= exists(left.parties(phone_number<>''));
			// Find min & max of 3 dates from all the assessments child dataset records
			rc_dt_first	        := mac_dt_first_str(left.assessments, recording_date);
			rc_dt_last	        := mac_dt_last_str(left.assessments, recording_date);
			av_dt_first         := mac_dt_first_str(left.assessments, assessed_value_year);
			av_dt_last          := mac_dt_last_str(left.assessments, assessed_value_year);
			mv_dt_first         := mac_dt_first_str(left.assessments, market_value_year);
			mv_dt_last          := mac_dt_last_str(left.assessments, market_value_year);
			// Then use the recording_date if not zero or assessed_value_year if not zero,
			// otherwise use the market_value_year
		  self.dt_first_seen  := if(rc_dt_first<>0,rc_dt_first,
			                          if(av_dt_first<>0,av_dt_first, mv_dt_first));
		  // don't use rc_dt for last seen unless other 2 are empty
			self.dt_last_seen	  := if(av_dt_last<>0, av_dt_last,
			                          if(mv_dt_last<>0, mv_dt_last, rc_dt_last));
		));

		ds_deed := project(base.deed_child, transform(l_in,
			self.src 						:= src_code.deed.code;
			self.src_desc				:= src_code.deed.desc;
			self.hasName				:= (left.name1<>'' or left.name2<>'' or left.seller1<>'' or left.seller2<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.mailing_csz<>'' or left.seller_mailing_address_citystatezip<>'' or left.property_address_citystatezip<>'');
			self.hasPhone				:= (left.phone_number<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.process_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.process_date);
		));

		ds_deed2 := project(base.deed2_child, transform(l_in,
			self.src 						:= src_code.deed2.code;
			self.src_desc				:= src_code.deed2.desc;
			self.hasName				:= exists(left.parties(exists(orig_names(orig_name<>''))));
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.parties(orig_csz<>''));
			self.hasPhone				:= exists(left.parties(phone_number<>''));
			self.dt_first_seen	:= ut.NormDate((unsigned)(left.deeds[1].recording_date));
			self.dt_last_seen		:= ut.NormDate((unsigned)(left.deeds[1].recording_date));
		));

		ds_flcrash := project(base.flcrash_child, transform(l_in,
			self.src 						:= src_code.flcrash.code;
			self.src_desc				:= src_code.flcrash.desc;
			self.hasName				:= exists(left.flcrash_vehicle(lname<>'')) or exists(left.flcrash_driver(driver_full_name<>''));
			self.hasSSN					:= false;
			self.hasDOB					:= exists(left.flcrash_driver(is_valid_dob (driver_dob)));
			self.hasAddr				:= exists(left.flcrash_vehicle(st<>'' or zip<>'')) or exists(left.flcrash_driver(st<>'' or zip<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= mac_dt_first_str(left.flcrash_time_location, accident_date);
			self.dt_last_seen		:= mac_dt_last_str(left.flcrash_time_location, accident_date);
		));

		ds_DOC := project(base.DOC_people_child, transform(l_in,
			self.src 						:= src_code.doc.code;
			self.src_desc				:= src_code.doc.desc;
			self.hasName				:= (left.fname<>'' or left.lname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= is_valid_dob(left.dob);
			self.hasAddr				:= (left.st<>'' or left.zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.file_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.case_date);
		));

		ds_SO := project(base.SexOffender_people_child, transform(l_in,
			self.src 						:= src_code.so.code;
			self.src_desc				:= src_code.so.desc;
			self.hasName				:= (left.fname<>'' or left.lname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= is_valid_dob(left.dob);
			self.hasAddr				:= (left.st<>'' or left.zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_reported);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_reported);
		));

		ds_finder := project(base.finder_child, transform(l_in,
			self.src 						:= src_code.finder.code;
			self.src_desc				:= src_code.finder.desc;
			self.hasName				:= (left.fname<>'' or left.lname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= left.dob<>0;
			self.hasAddr				:= (left.st<>'' or left.zip<>'');
			self.hasPhone				:= (left.phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_ak := project(base.ak_child, transform(l_in,
			self.src 						:= src_code.ak.code;
			self.src_desc				:= src_code.ak.desc;
			self.hasName				:= (left.first_name<>'' or left.last_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.state<>'' or left.zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.process_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.process_date);
		));

		ds_nod := project(base.nod_child, transform(l_in,
			self.src 						:= src_code.nod.code;
			self.src_desc				:= src_code.nod.desc;
			self.hasName				:= exists(left.Defendants(Name.Last<>'' or Name.First<>''));
			self.hasSSN					:= exists(left.Defendants(SSN<>''));
			self.hasDOB					:= false;
			self.hasAddr				:= (left.SiteAddress.State<>'' or left.SiteAddress.Zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= normDate_iesp(left.FilingDate);
			self.dt_last_seen		:= normDate_iesp(left.FilingDate);
		));

		ds_for := project(base.for_child, transform(l_in,
			self.src 						:= src_code.for.code;
			self.src_desc				:= src_code.for.desc;
			self.hasName				:= (left.name1_first<>'' or left.name1_last<>'' or left.name2_first<>'' or left.name2_last<>'' or left.name3_first<>'' or left.name3_last<>'' or left.name4_first<>'' or left.name4_last<>'');
			self.hasSSN					:= (left.name1_ssn<>'' or left.name2_ssn<>'' or left.name3_ssn<>'' or left.name4_ssn<>'');
			self.hasDOB					:= false;
			self.hasAddr				:= (left.property_state_1<>'' or left.property_address_zip_code_1<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.recording_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.recording_date);
		));

		ds_util := project(base.util_child, transform(l_in,
			self.src 						:= src_code.util.code;
			self.src_desc				:= src_code.util.desc;
			self.hasName				:= (left.orig_fname<>'' or left.orig_lname<>'');
			self.hasSSN					:= (left.ssn<>'');
			self.hasDOB					:= is_valid_dob(left.dob);
			self.hasAddr				:= (left.address_state<>'' or left.address_zip<>'');
			self.hasPhone				:= (left.phone<>'' or left.work_phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_first_seen); // no date_last_seen
		));

		ds_mswork := project(base.mswork_child, transform(l_in,
			self.src 						:= src_code.mswork.code;
			self.src_desc				:= src_code.mswork.desc;
			self.hasName				:= (left.claimant_name<>'');
			self.hasSSN					:= (left.claimant_ssn<>'');
			self.hasDOB					:= is_valid_dob(left.claimant_dob);
			self.hasAddr				:= (left.claimant_state<>'' or left.claimant_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_boater := project(base.boater_child, transform(l_in,
			self.src 						:= src_code.boater.code;
			self.src_desc				:= src_code.boater.desc;
			self.hasName				:= (left.last_name<>'' or left.first_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.home_state<>'' or left.home_zip<>'' or left.mail_state<>'' or left.mail_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_tu := project(base.tu_child, transform(l_in,
			self.src 						:= src_code.tu.code;
			self.src_desc				:= src_code.tu.desc;
			self.hasName				:= (left.orig_last_name<>'' or left.orig_first_name<>'');
			self.hasSSN					:= (left.orig_ssn<>'');
			self.hasDOB					:= is_valid_dob(left.orig_birthdate_ccyymm);
			self.hasAddr				:= (left.orig_state<>'' or left.orig_zip5<>'');
			self.hasPhone				:= (left.orig_telephone<>'');
			dt_1								:= ut.NormDate((unsigned)left.file_date);
			dt_2								:= ut.NormDate((unsigned)left.orig_file_date_mmddccyy);
			dt_3								:= ut.NormDate((unsigned)left.orig_date_reported_mmddccyy);
			// NOTE: We'd originally looked at orig_birthdate_ccyymm as well, but that was not producing good results
			self.dt_first_seen	:= ut.min2( ut.min2( dt_1, dt_2 ), dt_3 );
			self.dt_last_seen		:= max(dt_1, dt_2, dt_3);
		));
	ds_tn := project(base.tn_child, transform(l_in,
			self.src 						:= src_code.tn.code;
			self.src_desc				:= src_code.tn.desc;
			self.hasName				:= (left.lname<>'' or left.fname<>'');
			self.hasSSN					:= (left.clean_ssn<>'');
			self.hasDOB					:= left.clean_dob <> 0;
			self.hasAddr				:= (left.st<>'' or left.zip<>'');
			self.hasPhone				:= (left.clean_phone<>'');
			self.dt_first_seen	:= left.dt_first_seen;
			self.dt_last_seen		:= left.dt_last_seen;
		));
		ds_quickheader := project(base.quickheader_child, transform(l_in,
			self.src 						:= src_code.quickheader.code;
			self.src_desc				:= src_code.quickheader.desc;
			self.hasName				:= (left.fname<>'' or left.lname<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.st<>'' or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_targ := project(base.targ_child, transform(l_in,
			self.src 						:= src_code.targ.code;
			self.src_desc				:= src_code.targ.desc;
			self.hasName				:= (left.fname<>'' or left.lname<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.st<>'' or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_phonesPlus := project(base.phonesPlus_child, transform(l_in,
			self.src 						:= src_code.phonesPlus.code;
			self.src_desc				:= src_code.phonesPlus.desc;
			self.hasName				:= (left.listed_name<>'');
			self.hasSSN					:= false;
			self.hasDOB					:= false;
			self.hasAddr				:= (left.st<>'' or left.z5<>'');
			self.hasPhone				:= (left.phoneno<>'');
			self.dt_first_seen	:= 0;
			self.dt_last_seen		:= 0;
		));

		ds_FBNv2 := project(base.fbnv2_child, transform(l_in,
			self.src 						:= src_code.FBNv2.code;
			self.src_desc				:= src_code.FBNv2.desc;
			self.hasName				:= exists(left.Owners(Name<>''));
			self.hasSSN					:= exists(left.Owners(FEIN<>''));
			self.hasDOB					:= false;
			self.hasAddr				:= exists(left.Owners(Address.State<>''or Address.zip5<>''));
			self.hasPhone				:= exists(left.Owners(Phone<>''));
			self.dt_first_seen	:= normDate_iesp(left.OriginalFilingDate);
			dt_last1						:= normDate_iesp(left.FilingExpirationDate);
			dt_last2						:= normDate_iesp(left.FilingCancellationDate);
			self.dt_last_seen		:= if(dt_last1<>0, dt_last1, dt_last2);
		));

		// concatenate and process all the inputs
		ds_all := ds_atf + ds_bk + ds_bkv2 + ds_lien + ds_lienv2 + ds_dl + ds_dl2 + ds_death + ds_proflic +
							ds_sanc + ds_prov + ds_email + ds_emailv2 + ds_veh + ds_vehv2 + ds_eq + ds_en + ds_dea + ds_deav2 + ds_airc +
							ds_pilot + ds_pilotcert + ds_watercraft + ds_ucc + ds_uccv2 +
							ds_corpAffil + ds_ccw + ds_voter + ds_voterv2 + ds_hunt + ds_whois + ds_phone +
							ds_assessment + ds_assessment2 + ds_deed + ds_deed2 +
							ds_flcrash + ds_DOC + ds_SO + ds_finder + ds_ak + ds_nod + ds_for +
							ds_util + ds_mswork + ds_boater + ds_tn + ds_tu + ds_quickheader + ds_targ + ds_phonesPlus + ds_FBNv2;
		results := roll(ds_all);

		return results;

	end; // fromHSS()


  // *********************************************************************************
	// --- generate results from doxie_cbrs.Business_Report_Service_Raw results ----
  export dataset(l_out) fromBRSR(dataset(doxie_cbrs.layout_source) ds_in) := function

		// BRSR returns a single row every time
		base := ds_in[1];

		// *** Work our way through the BRSR output one section at a time,
		// transforming each piece into the common output layout we need.

		ds_bfinder := project(base.finder, transform(l_in,
			self.src 						:= src_code.bfinder.code;
			self.src_desc				:= src_code.bfinder.desc;
			self.hasName				:= left.company_name<>'';
			self.hasFEIN				:= left.fein<>'';
			self.hasAddr				:= (left.state<>'' or left.zip<>'');
			self.hasPhone				:= left.phone<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_dnb := project(base.dnb, transform(l_in,
			self.src 						:= src_code.dnb.code;
			self.src_desc				:= src_code.dnb.desc;
			self.hasName				:= left.business_name<>'';
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.st<>''      or left.zip<>'' or
			                        left.mail_st<>'' or left.mail_zip<>'');
			self.hasPhone				:= left.telephone_number<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_corp := project(base.corporate_filings, transform(l_in,
			self.src 						:= src_code.corp.code;
			self.src_desc				:= src_code.corp.desc;
			self.hasName				:= left.corp_legal_name<>'';
			self.hasFEIN				:= left.corp_fed_tax_id<>'';
			self.hasAddr				:= (left.corp_addr1_state<>'' or left.corp_addr1_zip5<>'');
			self.hasPhone				:= left.corp_phone_number<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));

		ds_corpv2 := project(base.corporate_filings_v2, transform(l_in,
			self.src 						:= src_code.corpv2.code;
			self.src_desc				:= src_code.corpv2.desc;
			self.hasName				:= exists(left.corp_hist(corp_legal_name<>''));
			self.hasFEIN				:= exists(left.corp_hist(corp_fed_tax_id<>''));
			self.hasAddr				:= exists(left.corp_hist(corp_addr1_state<>'' or corp_addr1_zip5<>''));
			self.hasPhone				:= exists(left.corp_hist(corp_phone10<>''));
			self.dt_first_seen	:= ut.NormDate((unsigned)(left.corp_hist[1].corp_filing_date));
			self.dt_last_seen		:= ut.NormDate((unsigned)(left.corp_hist[1].dt_last_seen));
		));

		ds_bk := project(base.bankruptcy, transform(l_in,
			self.src 						:= src_code.bk.code;
			self.src_desc				:= src_code.bk.desc;
			self.hasName				:= exists(left.debtor_records(exists(names(debtor_company<>''))));
			self.hasFEIN				:= exists(left.debtor_records(debtor_ssn<>''));
			self.hasAddr				:= exists(left.debtor_records(exists(addresses(st<>'' or z5<>''))));
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.disposed_date), ut.NormDate((unsigned)left.reopen_date) );
		));

		ds_bkv2 := project(base.bankruptcy_v2, transform(l_in,
			self.src 						:= src_code.bkv2.code;
			self.src_desc				:= src_code.bkv2.desc;
			self.hasName				:= exists(left.debtors(exists(names(cname<>''))));
			self.hasFEIN				:= exists(left.debtors(exists(names(tax_id<>''))));
			self.hasAddr				:= exists(left.debtors(exists(addresses(orig_st<>'' or orig_zip5<>''))));
			self.hasPhone				:= exists(left.debtors(exists(phones)));
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.disposed_date), ut.NormDate((unsigned)left.reopen_date) );
		));

		ds_ucc := project(base.uccs, transform(l_in,
			self.src 						:= src_code.ucc.code;
			self.src_desc				:= src_code.ucc.desc;
			self.hasName				:= (left.debtor_name<>'' or left.secured_name<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.debtor_st<>'' or left.debtor_zip<>'' or left.secured_st<>'' or left.secured_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.orig_filing_date);
		));

		ds_uccv2 := project(base.uccs_v2, transform(l_in,
			self.src 						:= src_code.uccv2.code;
			self.src_desc				:= src_code.uccv2.desc;
			self.hasName				:= exists(left.debtors(orig_name<>'')) or exists(left.secureds(orig_name<>'')); // STUB - also check bdid<>''; do we count secureds & assignees & creditors & ?
			self.hasFEIN				:= exists(left.debtors(exists(parsed_parties(fein<>'')))); // & secureds pp fein? & assignees PP fein & creditors pp fein ???
			self.hasAddr				:= exists(left.debtors(exists(addresses))) or exists(left.secureds(exists(addresses)));  // assignees PP addrs & creditors pp addrs ???
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.orig_filing_date);
			self.dt_last_seen		:= Max( ut.NormDate((unsigned)left.orig_filing_date), ut.NormDate((unsigned)left.cmnt_effective_date) );
		));

		ds_lien := project(base.liens_judgments, transform(l_in,
			self.src 						:= src_code.lien.code;
			self.src_desc				:= src_code.lien.desc;
			self.hasName				:= (left.def_company<>'' or left.plain_company<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.orig_state<>'' or left.orig_zip<>'');
			self.hasPhone				:= false;
			dt_filing						:= ut.NormDate((unsigned)left.filing_date);
			self.dt_first_seen	:= dt_filing;
			self.dt_last_seen		:= Max(dt_filing, ut.NormDate((unsigned)left.release_date));
		));

		ds_lienv2 := project(base.liens_judgments_v2, transform(l_in,
			self.src 						:= src_code.lienv2.code;
			self.src_desc				:= src_code.lienv2.desc;
			self.hasName				:= exists(left.debtors(exists(parsed_parties(cname<>''))));
			self.hasFEIN				:= exists(left.debtors(exists(parsed_parties(tax_id<>''))));
			self.hasAddr				:= exists(left.debtors(exists(addresses)));
			self.hasPhone				:= exists(left.debtors(exists(addresses(exists(phones)))));
			dt_filing						:= ut.NormDate((unsigned)left.orig_filing_date);
			dt_rel							:= ut.NormDate((unsigned)left.release_date);
			dt_judsat						:= ut.NormDate((unsigned)left.judg_satisfied_date);
			dt_judvac						:= ut.NormDate((unsigned)left.judg_vacated_date);
			self.dt_first_seen	:= dt_filing;
			self.dt_last_seen		:= max(dt_filing, dt_rel, dt_judsat, dt_judvac);
		));

		/* removed out per email discussion with George Wenz on 04/14/10,
		   but left the coding comented out here in case it is needed
			 to be re-activated in the future.
		ds_cont := project(base.contacts, transform(l_in,
			self.src 						:= src_code.cont.code;
			self.src_desc				:= src_code.cont.desc;
			self.hasName				:= left.company_name<>'';
			self.hasFEIN				:= left.company_fein<>'';
			self.hasAddr				:= (left.company_state<>'' or left.company_zip<>'');
			self.hasPhone				:= (left.company_phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.dt_last_seen);
		));
    */

		ds_assessment := project(base.property, transform(l_in,
			self.src 						:= src_code.assessment.code;
			self.src_desc				:= src_code.assessment.desc;
			self.hasName				:= (left.name_owner_1<>'' or left.name_owner_2<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.property_address_citystatezip<>'' or
			                        left.buyer_mailing_address_citystatezip<>'' or
															left.owners_address_ace_state<>'' or
															left.owners_address_ace_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.tax_year);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.tax_year);
		));

		ds_assessment2 := project(base.property_v2_assess, transform(l_in,
			self.src 						:= src_code.assessment2.code;
			self.src_desc				:= src_code.assessment2.desc;
			self.hasName				:= exists(left.parties(exists(orig_names(orig_name<>''))));
			self.hasFEIN				:= false;
			self.hasAddr				:= exists(left.parties(orig_csz<>''));
			self.hasPhone				:= exists(left.parties(phone_number<>''));
			// Find min & max of 3 dates from all the assessments child dataset records
			rc_dt_first	        := mac_dt_first_str(left.assessments, recording_date);
			rc_dt_last	        := mac_dt_last_str(left.assessments, recording_date);
			av_dt_first         := mac_dt_first_str(left.assessments, assessed_value_year);
			av_dt_last          := mac_dt_last_str(left.assessments, assessed_value_year);
			mv_dt_first         := mac_dt_first_str(left.assessments, market_value_year);
			mv_dt_last          := mac_dt_last_str(left.assessments, market_value_year);
			// Then use the recording_date if not zero or assessed_value_year if not zero,
			// otherwise use the market_value_year
		  self.dt_first_seen  := if(rc_dt_first<>0,rc_dt_first,
			                          if(av_dt_first<>0,av_dt_first, mv_dt_first));
		  // don't use rc_dt for last seen unless other 2 are empty
			self.dt_last_seen	  := if(av_dt_last<>0, av_dt_last,
			                          if(mv_dt_last<>0, mv_dt_last, rc_dt_last));
		));

		ds_deed2 := project(base.property_v2_deed, transform(l_in,
			self.src 						:= src_code.deed2.code;
			self.src_desc				:= src_code.deed2.desc;
			self.hasName				:= exists(left.parties(exists(orig_names(orig_name<>''))));
			self.hasFEIN			  := false;
			self.hasAddr				:= exists(left.parties(orig_csz<>''));
			self.hasPhone				:= exists(left.parties(phone_number<>''));
			self.dt_first_seen	:= ut.NormDate((unsigned)(left.deeds[1].recording_date));
			self.dt_last_seen		:= ut.NormDate((unsigned)(left.deeds[1].recording_date));
		));

		ds_nod := project(base.Notice_Of_Defaults, transform(l_in,
			self.src 						:= src_code.nod.code;
			self.src_desc				:= src_code.nod.desc;
			self.hasName				:= exists(left.Defendants(CompanyName<>''));
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.SiteAddress.State<>'' or left.SiteAddress.Zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= normDate_iesp(left.FilingDate);
			self.dt_last_seen		:= normDate_iesp(left.FilingDate);
		));

		ds_for := project(base.Foreclosures, transform(l_in,
			self.src 						:= src_code.for.code;
			self.src_desc				:= src_code.for.desc;
			self.hasName				:= exists(left.Defendants(CompanyName<>''));
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.SiteAddress.State<>'' or left.SiteAddress.Zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= normDate_iesp(left.RecordingDate);
			self.dt_last_seen		:= normDate_iesp(left.RecordingDate);
		));

		// internet = whois
		ds_internet := project(base.internet, transform(l_in,
			self.src 						:= src_code.whois.code;
			self.src_desc				:= src_code.whois.desc;
			self.hasName				:= (left.registrant_name<>'' or left.admin_name<>'' or left.tech_name<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.registrant_address1<>'' or left.admin_address1<>'' or left.tech_address1<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_proflic := project(base.professional_licenses, transform(l_in,
			self.src 						:= src_code.proflic.code;
			self.src_desc				:= src_code.proflic.desc;
			self.hasName				:= (left.company_name<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.orig_st<>'' or left.orig_zip<>'');
			self.hasPhone				:= (left.phone<>'');
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_veh := project(base.motor_vehicles, transform(l_in,
			self.src 						:= src_code.veh.code;
			self.src_desc				:= src_code.veh.desc;
			self.hasName				:= (left.own_1_customer_name<>'' or left.own_2_customer_name<>'' or
															left.reg_1_customer_name<>'' or left.reg_2_customer_name<>'' or
															left.lh_1_customer_name<>''  or left.lh_2_customer_name<>'' or left.lh_3_customer_name<>'');
			self.hasFEIN				:= (left.own_1_feid_ssn<>'' or left.own_2_feid_ssn<>'' or
															left.reg_1_feid_ssn<>'' or left.reg_2_feid_ssn<>'' or
															left.lh_1_feid_ssn<>''  or left.lh_2_feid_ssn<>'' or left.lh_3_feid_ssn<>'');
			self.hasAddr				:= (left.own_1_state<>'' or left.own_2_state<>'' or
															left.reg_1_state<>'' or left.reg_2_state<>'' or
															left.lh_1_state<>''  or left.lh_2_state<>'' or left.lh_3_state<>'' or
															left.own_1_zip5_zip4_foreign_postal<>'' or left.own_2_zip5_zip4_foreign_postal<>'' or
															left.reg_1_zip5_zip4_foreign_postal<>'' or left.reg_2_zip5_zip4_foreign_postal<>'' or
															left.lh_1_zip5_zip4_foreign_postal<>''  or left.lh_2_zip5_zip4_foreign_postal<>'' or left.lh_3_zip5_zip4_foreign_postal<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate(left.dt_first_seen);
			self.dt_last_seen		:= ut.NormDate(left.dt_last_seen);
		));

		ds_vehv2 := project(base.motor_vehicles_v2, transform(l_in,
			self.src 						:= src_code.vehv2.code;
			self.src_desc				:= src_code.vehv2.desc;
			self.hasName				:= exists(left.registrants(orig_name<>''));
			self.hasFEIN				:= false;
			self.hasAddr				:= exists(left.registrants(st<>'' or zip5<>''));
			self.hasPhone				:= false;
			self.dt_first_seen	:= mac_dt_first_str(left.registrants, Reg_Earliest_Effective_Date);
			self.dt_last_seen		:= mac_dt_last_str(left.registrants, Reg_Latest_Effective_Date);
		));

		ds_watercraft := project(base.watercrafts, transform(l_in,
			self.src 						:= src_code.watercraft.code;
			self.src_desc				:= src_code.watercraft.desc;
			self.hasName				:= exists(left.owners(company_name<>'')) or
			                       exists(left.lienholders(lien_name<>''));
			self.hasFEIN				:= exists(left.owners(orig_fein<>''));
			self.hasAddr				:= exists(left.owners(st<>'' or zip5<>'')) or
			                       exists(left.lienholders(lien_state<>'' or lien_zip<>''));
			self.hasPhone				:= exists(left.owners(phone_1<>'' or phone_2<>''));
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_last_seen); // no first_seen
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_airc := project(base.aircrafts, transform(l_in,
			self.src 						:= src_code.airc.code;
			self.src_desc				:= src_code.airc.desc;
			self.hasName				:= (left.compname<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.state<>'' or left.zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_ebr := project(base.experian_business_reports, transform(l_in,
			self.src 						:= src_code.ebr.code;
			self.src_desc				:= src_code.ebr.desc;
			self.hasName				:= left.header_recs.company_name<>'';
			self.hasFEIN				:= false; // ???
			self.hasAddr				:= left.header_recs.state_code<>'' or
			                       left.header_recs.orig_zip<>'';
			self.hasPhone				:= left.header_recs.phone_number<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.header_recs.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.header_recs.date_last_seen);
		));

		ds_irs5500 := project(base.irs_5500, transform(l_in,
			self.src 						:= src_code.irs5500.code;
			self.src_desc				:= src_code.irs5500.desc;
			self.hasName				:= (left.sponsor_dfe_name<>''   or
			                        left.spons_dfe_dba_name<>'' or
															left.admin_name<>''         or
			                        left.preparer_name<>'');
			self.hasFEIN				:= (left.ein<>'' or left.admin_ein<>'' or left.preparer_ein<>'' );
			self.hasAddr				:= (left.spons_dfe_state<>'' or left.spons_dfe_zip_code<>'' or
			                        left.admin_state<>''     or left.admin_zip_code<>''     or
															left.preparer_state<>''  or left.preparer_zip_code<>'');
			self.hasPhone				:= (left.spon_dfe_phone_num<>'' or left.admin_phone_num<>'' or
			                        left.preparer_phone_num<>'');
      pe_dt	              := ut.NormDate((unsigned)left.plan_eff_date);
			as_dt 		          := ut.NormDate((unsigned)left.admin_signed_date);
			self.dt_first_seen	:= pe_dt;
			self.dt_last_seen		:= if(as_dt<>0,as_dt,pe_dt);
		));

		ds_irsnp := project(base.irs_non_profit, transform(l_in,
			self.src 						:= src_code.irsnp.code;
			self.src_desc				:= src_code.irsnp.desc;
			self.hasName				:= (left.primary_name_of_organization<>'' or
			                        left.cname<>'');
			self.hasFEIN				:= (left.employer_id_number<>'');
			self.hasAddr				:= (left.state<>'' or left.zip_code<>'' or
															left.st<>''    or left.zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.process_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.process_date);
		));

		ds_fdic := project(base.fdic, transform(l_in,
			self.src 						:= src_code.fdic.code;
			self.src_desc				:= src_code.fdic.desc;
			self.hasName				:= (left.chrtagnt<>'' or
			                        left.insagnt1<>'' or left.insagnt2<>''  or
															left.name<>''     or
															left.regagnt<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.address<>'' or
			                        left.stcnty<>'' or left.zip<>'' or
															left.st<>''     or left.zip5<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.insdate);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.process_date);
		));

		ds_bbbm := project(base.bbbmember, transform(l_in,
			self.src 						:= src_code.bbbm.code;
			self.src_desc				:= src_code.bbbm.desc;
			self.hasName				:= left.company_name<>'';
			self.hasFEIN				:= false;
			self.hasAddr				:= left.address<>'';
			self.hasPhone				:= left.phone<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_bbbnm := project(base.bbbnonmember, transform(l_in,
			self.src 						:= src_code.bbbnm.code;
			self.src_desc				:= src_code.bbbnm.desc;
			self.hasName				:= left.company_name<>'';
			self.hasFEIN				:= false;
			self.hasAddr				:= left.address<>'';
			self.hasPhone				:= left.phone<>'';
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_castax := project(base.casalestax, transform(l_in,
			self.src 						:= src_code.castax.code;
			self.src_desc				:= src_code.castax.desc;
			self.hasName				:= left.firm_name<>''; // or owner_name<>'' ???
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.location_state<>'' or left.location_zip<>'' or
			                        left.mailing_state<>''  or left.mailing_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.start_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.start_date);
		));

		ds_iastax := project(base.iasalestax, transform(l_in,
			self.src 						:= src_code.iastax.code;
			self.src_desc				:= src_code.iastax.desc;
			self.hasName				:= (left.company_name_1<>'' or left.company_name_2<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.location_state<>'' or left.location_zip_code<>'' or
			                        left.mailing_state<>''  or left.mailing_zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.issue_date);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.issue_date);
		));

		ds_mswork := project(base.msworkcomp, transform(l_in,
			self.src 						:= src_code.mswork.code;
			self.src_desc				:= src_code.mswork.desc;
			self.hasName				:= (left.employer_name<>'' or left.carrier_name<>'');
			self.hasFEIN				:= (left.employer_fein<>'');
			self.hasAddr				:= (left.employer_state<>'' or left.employer_zip<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));

		ds_orwork := project(base.orworkcomp, transform(l_in,
			self.src 						:= src_code.orwork.code;
			self.src_desc				:= src_code.orwork.desc;
			self.hasName				:= (left.employer_legal_name<>''  or
															left.leasing_company_name<>'' or
															left.insurer_name<>'');
			self.hasFEIN				:= false;
			self.hasAddr				:= (left.ppb_state<>''     or left.ppb_zip_code<>'' or
			                        left.mailing_state<>'' or left.mailing_zip_code<>'');
			self.hasPhone				:= false;
			self.dt_first_seen	:= ut.NormDate((unsigned)left.date_first_seen);
			self.dt_last_seen		:= ut.NormDate((unsigned)left.date_last_seen);
		));


		// Concatenate all the inputs
		ds_all_bus := ds_bfinder + ds_dnb + ds_corp + ds_corpv2
		              + ds_bk + ds_bkv2 + ds_ucc + ds_uccv2 + ds_lien + ds_lienv2
							    // + ds_cont  // removed 04/14/10, see comment above
							    + ds_assessment + ds_assessment2 + ds_deed2 + ds_nod + ds_for
							    + ds_internet + ds_proflic
							    + ds_veh + ds_vehv2 + ds_watercraft + ds_airc
                  + ds_ebr + ds_irs5500 + ds_irsnp
							    + ds_fdic + ds_bbbm + ds_bbbnm
							    + ds_castax + ds_iastax + ds_mswork + ds_orwork;

		results := roll(ds_all_bus);

		return results;

	end; // fromBRSR()

end;  // module
