import Address;
import BIPV2;
import BIPV2_Company_Names;
import BIPV2_Suppression;
import BizLinkFull;
import SALT37;
import Std.Str;

// Should we disable fallback? Can we disable fallback?

export IdAppendRoxieLocal(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = 0
		,boolean disableSaltForce = false
		,boolean primForcePost = false 
		,boolean useFuzzy = true
		,boolean doZipExpansion = true
		,boolean reAppend = true
	) := function

inputRecPlus := {
	inputDs,
	string company_phone_3,
	string company_phone_7,
	string company_name_prefix,
	string fname_preferred,
	dataset(BizLinkFull.Process_Biz_Layouts.layout_zip_cases) zip_cases,
};

inputDsZip :=
	project(inputDs(reAppend or (proxid = 0 and seleid = 0)), transform(inputRecPlus,
		airportReplacement := BIPV2.fn_translate_city(Str.ToUpperCase(left.city));
		newCity := Str.ToUpperCase(if(count(airportReplacement) = 0, left.city, airportReplacement[1]));
		newState0 := Str.ToUpperCase(if(count(airportReplacement) = 0, left.state, airportReplacement[2]));
		newState := if(newState0 != '', newState0,
		               if(newCity = '', '',
		                  Address.Key_CityStChance(city_name = newCity and percent_chance >= 99)[1].st));
		inputZipRadius := left.zip_radius_miles;
		zipsExpanded := BIPV2.fn_get_zips_2(newCity, newState, left.zip5, left.zip_radius_miles);
		zipCases := project(zipsExpanded, transform(BizLinkFull.Process_Biz_Layouts.layout_zip_cases,
		                  self.weight := 100 - ((left.radius / inputZipRadius) * 80); self := left));
		noZip := (doZipExpansion and zipCases[1].zip = '') or (not doZipExpansion and left.zip5 = '');
		oneZip := dataset(row(transform(BizLinkFull.Process_Biz_Layouts.layout_zip_cases,
		                        self.zip := left.zip5, self.weight := 100)));
		self.zip_cases :=
			map(nozip => dataset([], BizLinkFull.Process_Biz_Layouts.layout_zip_cases),
		      doZipExpansion => zipCases,
			    oneZip);
		self.city := if(doZipExpansion, zipsExpanded[1].city, left.city);
		self.state := if(doZipExpansion, zipsExpanded[1].state, left.state);
		lenPhone := length(trim(left.phone10));
		self.company_phone_3 := if(lenPhone = 10, left.phone10[..3], '');
		self.company_phone_7 := if(lenPhone = 10, left.phone10[4..10], if(lenPhone = 7, trim(left.phone10), ''));
		self.company_name_prefix := '';
		self.fname_preferred := BizLinkFull.fn_PreferredName(left.Contact_fname);
		self := left;
	));

BIPV2_Company_Names.functions.mac_go(inputDsZip, inputDsCnp, request_id, company_name, include_translations := FALSE);

template := bizlinkfull.process_biz_layouts.inputlayout;
SALTInput := project(inputDsCnp, transform({BizLinkFull.Process_Biz_Layouts.InputLayout},
  self.UniqueID       := (typeof(Template.UniqueID))left.request_id;
	// company name prefix is an option
	namePrefix := BizLinkFull.Fields.Make_company_name_prefix((SALT37.StrType) BizLinkFull.fn_company_name_prefix(left.cnp_name));
  self.company_name_prefix := if(not useFuzzy, '',
	                               (typeof(Template.company_name_prefix)) namePrefix);
  self.cnp_number     := (typeof(Template.cnp_number))left.cnp_number;
  self.cnp_btype      := (typeof(Template.cnp_btype))left.cnp_btype;
  self.cnp_lowv       := (typeof(Template.cnp_lowv))left.cnp_lowv;
  self.cnp_name       := (typeof(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT37.StrType)LEFT.cnp_name);
  self.prim_range     := (typeof(Template.prim_range))left.prim_range;
  self.prim_name      := (typeof(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT37.StrType)LEFT.prim_name);
  self.sec_range      := (typeof(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT37.StrType)LEFT.sec_range);   
  self.city           := (typeof(Template.city))BizLinkFull.Fields.Make_city((SALT37.StrType)LEFT.city);
  self.st             := (typeof(Template.st))BizLinkFull.Fields.Make_st((SALT37.StrType)LEFT.state);
  self.zip_cases      := LEFT.zip_cases;
  self.company_phone  := (typeof(Template.company_phone))left.phone10;
  self.company_phone_3 := (typeof(Template.company_phone_3))left.company_phone_3;
  self.company_phone_3_ex:= '';
  self.company_phone_7 := (typeof(Template.company_phone_7))left.company_phone_7;
  self.company_fein   := (typeof(Template.company_fein))LEFT.fein;
  self.company_url    := (typeof(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT37.StrType)LEFT.url);
  self.company_sic_code1 :=(typeof(Template.company_sic_code1))BizLinkFull.Fields.Make_company_sic_code1((SALT37.StrType)LEFT.sic_code);
  self.fname          := (typeof(Template.fname))BizLinkFull.Fields.Make_fname((SALT37.StrType)left.contact_fname);
  self.mname          := (typeof(Template.mname))BizLinkFull.Fields.Make_mname((SALT37.StrType)left.contact_mname);
  self.lname          := (typeof(Template.lname))BizLinkFull.Fields.Make_lname((SALT37.StrType)left.contact_lname);
  self.fname_preferred := (typeof(Template.fname_preferred))left.fname_preferred;
  self.contact_email  := (typeof(Template.contact_email))left.Email;
  self.contact_ssn    := (typeof(Template.contact_ssn))left.contact_ssn;
  self.contact_did    := (typeof(Template.contact_did))left.contact_did;
  self.MaxIDs         := 10; // scoring happens after filtering down to maxids so can't have maxids too small
  self.sele_flag      := '_';
  self.org_flag       := '_';
  self.ult_flag       := '_';
  self.leadthreshold  := 10;
	self.bGetAllScores  := TRUE;
	self.disableForce   := disableSaltForce;
  self := [];
));

// get meow_biz.raw_results
rawResults := BizLinkFull.MEOW_Biz(SALTInput).raw_results; 

// apply score threshold
// convert layout 
topScores := 
	project(rawResults, transform(BIPV2.IdAppendLayouts.IdsOnly,
		topProx0 := topn(left.results(proxid != 0), 1, -score, proxid)(score >= scoreThreshold, weight >= weightThreshold);
		// If doing address matching and prim name/range post-force, check for no mismatch
		// topProx := if('A' not in matchSet or not primForcePost, topProx0,
		topProx := if(not primForcePost, topProx0,
		              topProx0((left.prim_range != '' and prim_range_match_code = SALT37.MatchCode.ExactMatch)
		                         or (not (left.prim_range != '' and prim_rangeWeight <= 0)
		                               and not (left.prim_name != '' and prim_nameWeight <= 0)
		                       )));
		topSele := topn(left.results_seleid(seleid != 0), 1, -score)(score >= scoreThreshold, weight >= weightThreshold);
		topOrg  := topn(left.results_orgid(orgid != 0),  1, -score)(score >= scoreThreshold, weight >= weightThreshold);
		topUlt  := topn(left.results_ultid(ultid != 0),  1, -score)(score >= scoreThreshold, weight >= weightThreshold);
		topPow  := topn(left.results_powid(powid != 0),  1, -score)(score >= scoreThreshold, weight >= weightThreshold);
		self.proxid     := if(exists(topProx), topProx[1].proxid, 0);
		self.proxWeight := if(exists(topProx), topProx[1].weight, 0);
		self.proxScore  := if(exists(topProx), topProx[1].score,  0);
		self.seleid     := if(exists(topSele), topSele[1].seleid, 0);
		self.seleWeight := if(exists(topSele), topSele[1].weight, 0);
		self.seleScore  := if(exists(topSele), topSele[1].score,  0);
		self.orgid      := if(exists(topOrg),  topOrg[1].orgid,   0);
		self.orgWeight  := if(exists(topOrg),  topOrg[1].weight,  0);
		self.orgScore   := if(exists(topOrg),  topOrg[1].score,   0);
		self.ultid      := if(exists(topUlt),  topUlt[1].ultid,   0);
		self.ultWeight  := if(exists(topUlt),  topUlt[1].weight,  0);
		self.ultScore   := if(exists(topUlt),  topUlt[1].score,   0);
		self.powid      := if(exists(topPow),  topPow[1].powid,   0);
		self.powWeight  := if(exists(topPow),  topPow[1].weight,  0);
		self.powScore   := if(exists(topPow),  topPow[1].score,   0);
		self.request_id := left.uniqueid;
		self := left;
		self := []));

	// If there is an unambiguous proxid, then the higher level ids should go with this proxid.
	preIdStream := project(topScores(proxid != 0 or seleid != 0),
		transform(BizLinkFull.Process_Biz_Layouts.id_stream_layout,
			self.uniqueid := left.request_id,
			self.seleid := if(left.proxid != 0, 0, left.seleid);
			self.orgid := 0;
			self.ultid := 0;
			self.powid := if(left.proxid != 0, 0, left.powid);
			self := left,
			self := []));
	addHigherIds := BizLinkFull.Process_Biz_Layouts.id_stream_complete(preIdStream);
	fixScores :=
		join(topScores, addHigherIds,
			left.request_id = right.uniqueid,
			transform(recordof(left),
				newSele := right.seleid != 0 and left.seleid != right.seleid;
				newOrg := right.orgid != 0 and left.orgid != right.orgid;
				newUlt := right.ultid != 0 and left.ultid != right.ultid;
				newPow := right.powid != 0 and left.powid != right.powid;
				self.seleid := if(newSele, right.seleid, left.seleid);
				self.seleWeight := if(newSele, left.proxWeight, left.seleWeight);
				self.seleScore := if(newSele, left.proxScore, left.seleScore);
				self.orgid := if(newOrg, right.orgid, left.orgid);
				self.orgWeight := if(newOrg, left.proxWeight, left.orgWeight);
				self.orgScore := if(newOrg, left.proxScore, left.orgScore);
				self.ultid := if(newUlt, right.ultid, left.ultid);
				self.ultWeight := if(newUlt, left.proxWeight, left.ultWeight);
				self.ultScore := if(newUlt, left.proxScore, left.ultScore);
				self.powid := if(newPow, right.powid, left.powid);
				self.powWeight := if(newPow, left.proxWeight, left.powWeight);
				self.powScore := if(newPow, left.proxScore, left.powScore);
				self := left),
			left outer);

	preSuppression := fixScores;

	passThru0 := project(inputDs(proxid != 0 or seleid != 0),
		transform(BizLinkFull.Process_Biz_Layouts.id_stream_layout,
			self.uniqueId := left.request_id,
			self.proxid := left.proxid,
			self.seleid := if(left.proxid != 0, 0, left.seleid);
			self := left;
			self := []));
	passThru := if(reAppend, dataset([], recordof(passThru0)),
	               BizLinkFull.Process_Biz_Layouts.id_stream_complete(passThru0));

	passThruPreSuppress := project(passThru, transform(recordof(preSuppression),
		self.request_id := left.uniqueid,
		self := left,
		self := []));

	suppressed :=  BIPV2_Suppression.macSuppress(preSuppression + passThruPreSuppress);

	return suppressed;

	// return parallel(
		// output(SALTInput, named('SALTInput'));
		// output(rawResults, named('rawResults'));
		// output(preSuppression, named('preSuppression'));
		// output(passThru0, named('passThru0'));
		// output(passThru, named('passThru'));
		// output(passThruPreSuppress, named('passThruPreSuppress'));
		// output(suppressed, named('suppressed'));
	// );

end;