import dx_Header;
import BIPV2;
import BIPV2_Company_Names;
import BIPV2_Suppression;
import BizLinkFull;
import SALT44;
import Std.Str;
import BIPV2_xlink_segmentation;

// Should we disable fallback? Can we disable fallback?

export IdAppendRoxieLocal(
		dataset(BIPV2.IdAppendLayouts.AppendInput) inputDs
		,unsigned scoreThreshold = 75
		,unsigned weightThreshold = IdConstants.APPEND_WEIGHT_THRESHOLD_ROXIE
		,boolean disableSaltForce = true
		,boolean primForcePost = false 
		,boolean useFuzzy = true
		,boolean doZipExpansion = false
		,boolean reAppend = true
		,boolean segmentation = true
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
		                  dx_Header.Key_CityStChance()(KEYED(city_name = newCity) and percent_chance >= 99)[1].st));
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
		self.city := if(doZipExpansion, if(zipsExpanded[1].city='', left.city, zipsExpanded[1].city) , left.city);
		self.state := if(doZipExpansion, if(zipsExpanded[1].state='', left.state, zipsExpanded[1].state), left.state);
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
	namePrefix := BizLinkFull.Fields.Make_company_name_prefix((SALT44.StrType) BizLinkFull.fn_company_name_prefix(left.cnp_name));
  self.company_name_prefix := if(not useFuzzy, '',
	                               (typeof(Template.company_name_prefix)) namePrefix);
  self.cnp_number     := (typeof(Template.cnp_number))left.cnp_number;
  self.cnp_btype      := (typeof(Template.cnp_btype))left.cnp_btype;
  self.cnp_lowv       := (typeof(Template.cnp_lowv))left.cnp_lowv;
  self.cnp_name       := (typeof(Template.cnp_name))BizLinkFull.Fields.Make_cnp_name((SALT44.StrType)LEFT.cnp_name);
  self.prim_range     := (typeof(Template.prim_range))left.prim_range;
  self.prim_name      := (typeof(Template.prim_name))BizLinkFull.Fields.Make_prim_name((SALT44.StrType)LEFT.prim_name);
  self.sec_range      := (typeof(Template.sec_range))BizLinkFull.Fields.Make_sec_range((SALT44.StrType)LEFT.sec_range);   
  self.city           := (typeof(Template.city))BizLinkFull.Fields.Make_city((SALT44.StrType)LEFT.city);
  self.st             := (typeof(Template.st))BizLinkFull.Fields.Make_st((SALT44.StrType)LEFT.state);
  self.zip_cases      := LEFT.zip_cases;
  self.company_phone  := (typeof(Template.company_phone))left.phone10;
  self.company_phone_3 := (typeof(Template.company_phone_3))left.company_phone_3;
  self.company_phone_3_ex:= '';
  self.company_phone_7 := (typeof(Template.company_phone_7))left.company_phone_7;
  self.company_fein   := (typeof(Template.company_fein))LEFT.fein;
  self.company_url    := (typeof(Template.company_url))BizLinkFull.Fields.Make_company_url((SALT44.StrType)LEFT.url);
  self.company_sic_code1 :=(typeof(Template.company_sic_code1))BizLinkFull.Fields.Make_company_sic_code1((SALT44.StrType)LEFT.sic_code);
  self.fname          := (typeof(Template.fname))BizLinkFull.Fields.Make_fname((SALT44.StrType)left.contact_fname);
  self.mname          := (typeof(Template.mname))BizLinkFull.Fields.Make_mname((SALT44.StrType)left.contact_mname);
  self.lname          := (typeof(Template.lname))BizLinkFull.Fields.Make_lname((SALT44.StrType)left.contact_lname);
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
meowBizRawResults := BizLinkFull.MEOW_Biz(SALTInput).raw_results; 

OutSegResult := BIPV2_xlink_segmentation.mac_Segmentation(meowBizRawResults, ,UniqueId);

rawResults := IF(segmentation, OutSegResult, meowBizRawResults);

topIds := 
	normalize(rawResults((results[1].score >= (integer)scoreThreshold
			or results_seleid[1].score >= (integer)scoreThreshold 
			or results_ultid[1].score >= (integer)scoreThreshold)
		,(results[1].weight >= (integer)weightThreshold 
			or results_seleid[1].weight >= weightThreshold)
		,(results[1].proxid > 0
			or results_seleid[1].seleid > 0 
			or results_ultid[1].ultid > 0)), //filter not necessary here, but might save some work,
	1, // trying to keep code mostly in sync with thor side. Changing to PROJECT
		// would mean replacing "counter" in this transform to [1]
	transform(BIPV2.IdAppendLayouts.IdsOnlyDebug,
		isProxResolved := left.results[counter].score >= (integer)scoreThreshold 
			and left.results[counter].weight >= (integer)weightThreshold;
		isSeleResolved := left.results_seleid[counter].score >= (integer)scoreThreshold 
			and left.results_seleid[counter].weight >= (integer)weightThreshold; 
		isOrgResolved := left.results_orgid[counter].score >= (integer)scoreThreshold 
			and left.results_orgid[counter].weight >= (integer)weightThreshold; 
		isUltResolved := left.results_ultid[counter].score >= (integer)scoreThreshold 
			and left.results_ultid[counter].weight >= (integer)weightThreshold; 
		isPowResolved := left.results_powid[counter].score >= (integer)scoreThreshold 
			and left.results_powid[counter].weight >= (integer)weightThreshold; 

		isProxObvious := left.results[counter].score > 50;
		isSeleObvious := left.results_seleid[counter].score > 50;
		isOrgObvious := left.results_orgid[counter].score > 50;

		isSeleWrong := isProxObvious
			and left.results[counter].seleid != left.results_seleid[counter].seleid;
		isOrgProxWrong := isProxObvious 
			and left.results[counter].orgid != left.results_orgid[counter].orgid;
		isOrgSeleWrong := not isProxObvious 
			and isSeleObvious 
			and left.results_seleid[counter].orgid != left.results_orgid[counter].orgid;
		isOrgWrong := isOrgProxWrong or isOrgSeleWrong;
		isUltProxWrong := isProxObvious 
			and left.results[counter].ultid != left.results_ultid[counter].ultid;
		isUltSeleWrong := not isProxObvious 
			and isSeleObvious 
			and left.results_seleid[counter].ultid != left.results_ultid[counter].ultid;
		isUltOrgWrong := not isProxObvious and not isSeleObvious and isOrgObvious 
			and left.results_orgid[counter].ultid != left.results_ultid[counter].ultid;
		isUltWrong := isUltProxWrong or isUltSeleWrong or isUltOrgWrong;
		isPowWrong := isProxObvious 
			and left.results[counter].powid != left.results_powid[counter].powid;


		proxid := if(isProxResolved, left.results[counter].proxid, 0);
		proxScore := if(isProxResolved, left.results[counter].score, 0);
		proxWeight := if(isProxResolved, left.results[counter].weight, 0);

		// If the proxid is a good match, use the seleid associated with it, otherwise use the best matching seleid.
		// If the proxid has a score of > 50, then only return seleid associated with it to avoid returning different
		// seleids when different thresholds are used.
		seleid := map(
			isProxResolved => left.results[counter].seleid,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].seleid,
			0);
		// If proxid resolves, it doesn't make sense for sele score to be less than prox score so pick max(proxscore, selescore).
		// If seleid results don't match with proxid, then use score from proxid.
		// If proxid is non-ambiguous, then sele must match with it to avoid returning different results when
		// different thresholds are used.
		seleScore := map(
			isProxResolved and not isSeleWrong => max(proxScore, left.results_seleid[counter].score),
			isProxResolved and isSeleWrong => proxScore,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].score, 
			0);

		// If seleid results don't match with proxid, then use score from proxid.
		// If proxid is non-ambiguous, then sele must match with it to avoid returning different results when
		// different thresholds are used.
		seleWeight := map(
			isProxResolved and not isSeleWrong => left.results_seleid[counter].weight,
			isProxResolved and isSeleWrong => proxWeight,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].weight, 
			0);

		// Use similar logic for orgid and ultid that was used for seleid.
		orgid := map(isProxResolved => left.results[counter].orgid,
		             isSeleResolved and not isSeleWrong => left.results_seleid[counter].orgid,
		             isOrgResolved and not isOrgWrong => left.results_orgid[counter].orgid,
		             0);
		orgScore := map(
			(isProxResolved or isSeleResolved) and not isOrgWrong 
				=> max(seleScore, left.results_orgid[counter].score),
			(isProxResolved or isSeleResolved) and isOrgWrong => seleScore,
			isOrgResolved and not isOrgWrong => left.results_orgid[counter].score, 
			0);
		orgWeight := map(
			(isProxResolved or isSeleResolved) and not isOrgWrong 
				=> left.results_orgid[counter].weight,
			(isProxResolved or isSeleResolved) and isOrgWrong => seleWeight,
			isOrgResolved and not isOrgWrong => left.results_orgid[counter].weight, 
			0);

		ultid := map(isProxResolved => left.results[counter].ultid,
		             isSeleResolved and not isSeleWrong => left.results_seleid[counter].ultid,
		             isOrgResolved and not isOrgWrong => left.results_orgid[counter].ultid,
		             isUltResolved and not isUltWrong => left.results_ultid[counter].ultid,
		             0);
		ultScore := map(
			(isProxResolved or isSeleResolved or isOrgResolved) and not isUltWrong
				=> max(orgScore, left.results_ultid[counter].score),
			(isProxResolved or isSeleResolved or isOrgResolved) and isUltWrong
				=> orgScore,
			isUltResolved and not isUltWrong => left.results_ultid[counter].score, 
			0);
		ultWeight := map(
			(isProxResolved or isSeleResolved or isOrgResolved) and not isUltWrong 
				=> left.results_ultid[counter].weight,
			(isProxResolved or isSeleResolved or isOrgResolved) and isUltWrong => orgWeight,
			isUltResolved and not isUltWrong => left.results_ultid[counter].weight, 
			0);

		// Powid is above proxid in the id hierarchy so it is treated similar to seleid logic.
		powid := map(isProxResolved => left.results[counter].powid,
					 isPowResolved and not isPowWrong => left.results_powid[counter].powid,
					 0);
		
		powScore := map(
			isProxResolved and not isPowWrong 
				=> max(proxScore, left.results_powid[counter].score),
			isProxResolved and isPowWrong => proxScore,
			isPowResolved and not isPowWrong => left.results_powid[counter].score, 
			0);

		powWeight := map(isProxResolved and not isPowWrong => left.results_powid[counter].weight,
		                 isProxResolved and isPowWrong => proxWeight,
		                 isPowResolved and not isPowWrong => left.results_powid[counter].weight, 
		                 0);


		self.request_id := left.UniqueId;

		self.proxid := proxid;		  
		self.proxWeight := proxWeight;
		self.proxScore := proxScore;
		  
		self.seleid := seleid;
		self.seleweight := seleWeight;
		self.selescore  := seleScore;

		self.orgid := orgid;		  
		self.orgweight := orgWeight;
		self.orgscore := orgScore;

		self.ultid := ultid;		  
		self.ultweight := ultWeight;
		self.ultscore := ultScore;

		self.powid := powid;		  
		self.powweight := powWeight;
		self.powscore := powScore;

		// If there is a proxid that meets the threshold, grab the parent info from it.
		// Otherwise grab the parent info from the matching seleid.
		// sele_proxid, org_proxid, and ultimate_proxid are the same at any level of BIP ids.
		// parent_proxid only applies to the given proxid.
		self.parent_proxid := if(isProxResolved, left.results[counter].parent_proxid, 0);
		self.sele_proxid := map(
			isProxResolved => left.results[counter].sele_proxid,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].sele_proxid,
			0);
		self.org_proxid := map(
			isProxResolved => left.results[counter].org_proxid,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].org_proxid,
			0);
		self.ultimate_proxid := map(
			isProxResolved => left.results[counter].ultimate_proxid,
			isSeleResolved and not isSeleWrong => left.results_seleid[counter].ultimate_proxid,
			0);
		self.keys_used := left.results[counter].keys_used;
		self.keys_failed := left.results[counter].keys_failed;
		)
	)((proxscore >= (integer)scoreThreshold 
			or selescore >= (integer)scoreThreshold 
			or ultscore >= (integer)scoreThreshold)
		,(proxid > 0 or seleid > 0 or ultid > 0));


	preSuppression := 
		join(inputDsZip, topIds,
		left.request_id = right.request_id,
		transform(BIPV2.IdAppendLayouts.IdsOnlyDebug,
			self.request_id := left.request_id,
			self := right),
		left outer);
			

	passThruIn := project(inputDs(proxid != 0 or seleid != 0),
		transform(BizLinkFull.Process_Biz_Layouts.id_stream_layout,
			self.uniqueId := left.request_id,
			self.proxid := left.proxid,
			self.seleid := if(left.proxid != 0, 0, left.seleid);
			self := left;
			self := []));
	passThruIds := if(reAppend, dataset([], recordof(passThruIn)),
	                  BizLinkFull.Process_Biz_Layouts.id_stream_complete(passThruIn));
	passThruMissingIds := passThruIds(ultid = 0 and (seleid != 0 or proxid != 0));
	passThruHistoric := BizLinkFull.Process_Biz_Layouts.id_stream_historic(passThruMissingIds);
	passThruRenew :=
		join(passThruMissingIds, passThruHistoric,
			left.uniqueid = right.uniqueid,
			transform(recordof(left),
				self := if(right.ultid != 0, right, left)),
			keep(1), left outer);
	passThru := passThruIds(not (ultid = 0 and (seleid != 0 or proxid != 0))) + passThruRenew;

	passThruPreSuppress := project(passThru, transform(recordof(preSuppression),
		self.request_id := left.uniqueid,
		self := left,
		self := []));

	suppressed :=  BIPV2_Suppression.macSuppress(preSuppression + passThruPreSuppress);

	return suppressed;

end;