IMPORT LN_PropertyV2_Services, _Control, LN_PropertyV2;

l_raw				:= LN_PropertyV2_Services.layouts.parties.raw_source;
l_fid				:= LN_PropertyV2_Services.layouts.fid;
l_tmp1			:= {
	layouts.parties.tmp1 - orig_names - statementIDs - isDisputed;
	unsigned2 county_pen_1;
	unsigned2 county_pen_2;
	unsigned2 penalt_1;
	unsigned2 penalt_2;
	unsigned2 cPenalt_1;
	unsigned2 cPenalt_2;
	unsigned8 persistent_record_id;  //added so that two sellers that are both restricted do not get deduped to one
	};
l_tmp2			:= {
	layouts.parties.tmp2 - orig_names;
	unsigned2 county_pen_1;
	unsigned2 county_pen_2;
	unsigned2 penalt_1;
	unsigned2 penalt_2;
	unsigned2 cPenalt_1;
	unsigned2 cPenalt_2;
	unsigned8 persistent_record_id;
	};
l_entity		:= LN_PropertyV2_Services.layouts.parties.entity;
l_pparty		:= LN_PropertyV2_Services.layouts.parties.pparty;
l_rolled		:= LN_PropertyV2_Services.layouts.parties.rolled;
l_out				:= l_rolled;

max_raw			:= LN_PropertyV2_Services.consts.max_raw;
max_parties	:= LN_PropertyV2_Services.consts.max_parties;

max_penalt	:= 100;
min_penalt	:= 0;

export dataset(l_out) fn_get_parties_2(
  dataset(l_raw) ds_raw,
	boolean isFCRA = false,
	LN_PropertyV2_Services.interfaces.Iinput_report input_mod
) := function


	// add computed fields
	l_tmp1 addValue(ds_raw L) := transform
	
		// DID/BDID ---------------------------------------
		self.did	:= if(L.did<>0,		(string12)L.did,	'');
		self.bdid	:= if(L.bdid<>0,	(string12)L.bdid,	'');
		
		// Avoid Penalty calculations--causing timeouts on Cert. ----------------------------------------
		self.penalt_1 := 0; 
		self.penalt_2 := 0; 
		self.cPenalt_1 := 0;
		self.cPenalt_2 := 0;
		
		// Types -------------------------------------------
		ft := LN_PropertyV2.fn_fid_type(L.ln_fares_id);
		pt := L.source_code_1;
		at := L.source_code_2;
		
		self.fid_type					:= ft;
		self.fid_type_desc		:= fn_fid_type_desc(ft);
		self.addr_type				:= at;
		self.party_type				:= pt;
		self.party_type_name	:= party_type_named(ft,pt);	
		
		// Lookup Codes -----------------------------------
		self.vendor_source_desc := fn_vendor_source(L.vendor_source_flag);
		self.vendor_source_flag := fn_vendor_source_obscure(L.vendor_source_flag);
		
		// Placeholders (populated below) -----------------
		self.county_name	:= '';
		self.county_pen_1	:= 0;
		self.county_pen_2	:= 0;
		self.entity				:= dataset([],l_entity);
		self.orig_addr		:= '';
		self.orig_unit		:= '';
		self.orig_csz			:= '';
		self.current_record := '';
		
		// Everything else --------------------------------
		self := L;
		self := [];
		
	end;
	
	ds_value2 := project(ds_raw, addValue(left));


	// party/property addr cleaning
	l_tmp1 stripParsedAddr(l_tmp1 L) := transform
			self.prim_range		:= '';
			self.predir				:= '';
			self.prim_name		:= '';
			self.suffix				:= '';
			self.postdir			:= '';
			self.unit_desig		:= '';
			self.sec_range		:= '';
			self.p_city_name	:= '';
			self.v_city_name	:= '';
			self.st						:= '';
			self.zip					:= '';
			self.zip4					:= '';
			self.cart					:= '';
			self.cr_sort_sz		:= '';
			self.lot					:= '';
			self.lot_order		:= '';
			self.dbpc					:= '';
			self.chk_digit		:= '';
			self.rec_type			:= '';
			self.county				:= '';
			self.county_name	:= '';
			self.geo_lat			:= '';
			self.geo_long			:= '';
			self.msa					:= '';
			self.geo_blk			:= '';
			self.geo_match		:= '';
			self := L;
	end;
	ds_value2 cleanProp2(ds_value2 L) := transform
		self.penalt_1					:= max_penalt;
		self.cPenalt_1				:= max_penalt;
		self.penalt_2					:= max_penalt;
		self.cPenalt_2				:= max_penalt;
		self.party_type				:= 'P';
		self.party_type_name	:= 'Property';
		// self.nameasis					:= '';
		self.phone_number			:= '';
		self.title						:= '';
		self.fname						:= '';
		self.mname						:= '';
		self.lname						:= '';
		self.name_suffix			:= '';
		self.cname						:= '';
		self.did							:= '';
		self.bdid							:= '';
		self.app_ssn					:= '';
		self := L;
	end;
	ds_value3_p := ds_value2(addr_type='P');		// property addrs
	ds_value3_n := ds_value2(addr_type<>'P');		// non-property addrs
	ds_value3_x := join(												// propagated addrs with no alternative
		    ds_value3_p, ds_value3_n,
		    left.ln_fares_id = right.ln_fares_id and
		    left.party_type = right.party_type and 
				left.search_did = right.search_did,
		    stripParsedAddr(left),left only
	    );
	ds_value3 := project(ds_value3_p,cleanProp2(left)) + ds_value3_n + ds_value3_x;
	ds_value4 := dedup(ds_value3,except persistent_record_id, all);
		
	// rollup entities by party
	l_tmp2 xf_roll_entities( l_tmp1 L, dataset(l_tmp1) R) := transform
		self.entity := if( L.party_type='P', dataset([],l_entity), project(R,l_entity) );
		self.penalt_1 := min(R,penalt_1);
		self.penalt_2 := min(R,penalt_2);
		self.cPenalt_1 := min(R,cPenalt_1);
		self.cPenalt_2 := min(R,cPenalt_2);
		self.county_pen_1 := min(R,county_pen_1);
		self.county_pen_2 := min(R,county_pen_2);
		self := L;
	end;
	
#IF(_Control.Environment.OnThor)
	ds_value4_distributed := distribute(ds_value4, hash64(ln_fares_id));
	eroll1 := sort(ds_value4_distributed, ln_fares_id, search_did, party_type, if(input_mod.TwoPartySearch,penalt_1 + penalt_2,penalt_1), if(input_mod.TwoPartySearch,cPenalt_1 + cPenalt_2,cPenalt_1), -dt_last_seen, -prim_name, record, local); // added prim_name to ensure not getting a blank addr based on NonSubject Suppression.
	eroll2_temp := dedup(eroll1,ln_fares_id,search_did,party_type,keep(consts.max_entities), local);
  eroll2 := group(eroll2_temp, ln_fares_id, search_did, party_type);
#ELSE
	ds_value4_distributed := ds_value4;
	eroll1 := sort(ds_value4_distributed, ln_fares_id, search_did, party_type, if(input_mod.TwoPartySearch,penalt_1 + penalt_2,penalt_1), if(input_mod.TwoPartySearch,cPenalt_1 + cPenalt_2,cPenalt_1), -dt_last_seen, -prim_name, record); // added prim_name to ensure not getting a blank addr based on NonSubject Suppression.
	eroll2 := dedup(group(eroll1, ln_fares_id, search_did, party_type),ln_fares_id,search_did,party_type,keep(consts.max_entities));
#END

  eroll3 := rollup(eroll2, group, xf_roll_entities(left,rows(left)));
	
	
	// rollup parties by ln_fares_id
	//
	// Note (01 Dec 2008): In the case where the user provides a person's name, the penalty seems to be applied 
	// well enough; for the case where only an address is provided, the penalty is applied somewhat pell-mell. 
	// So, until penalties are straightened out, I'm gonna use an ugly hack to recalculate penalties for all 
	// parties where an address-only search is indicated for matched parties ('mp').	
	l_rolled xf_roll_parties(l_tmp2 L, dataset(l_tmp2) R) := transform
	
		par_s		:= choosen(R,max_parties);  // remove the sorts here for query performance improvement in the bocashell
    self.parties	:= project(par_s, transform(l_pparty, self := left, self := [];));

  	self	:= L;
		self := [];
	end;
	
	roll2 := group(eroll3, ln_fares_id, search_did);
	roll3 := rollup(roll2, group, xf_roll_parties(left,rows(left)) );
	
		// DEBUG
	// output(ds_raw,			named('ds_raw'));
	// output(ds_value2,	named('ds_value2'));
	// output(ds_value3,	named('ds_value3'));
	// output(ds_value4,	named('ds_value4'));
	// output(eroll1,			named('eroll1'));
	// output(eroll2,			named('eroll2'));
	// output(eroll3,			named('eroll3'));
	// output(ds_sort,		named('ds_sort'));
	// output(roll1,			named('roll1'));
	// output(roll2,			named('roll2'));
	// output(roll3,			named('roll3'));
	return roll3;
end;