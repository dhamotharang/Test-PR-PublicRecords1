import Business_Header;

export IdAppendThorLocal(
		infile
		,matchset
		,company_name_field
		,prange_field
		,pname_field
		,zip_field
		,srange_field
		,state_field
		,phone_field
		,fein_field
		,BDID_field = '' // not being used
		,outrec
		,bool_outrec_has_score
		,BDID_Score_field = '' // not being used
		,keep_count = '1'
		,score_threshold = '75'
		,pURL = ''
		,pEmail = ''
		,pCity = ''
		,pContact_fname = ''
		,pContact_mname = ''
		,pContact_lname = ''
		,pContact_ssn = ''
		,pSource = ''
		,pSource_record_id = ''
		,src_matching_is_priority = FALSE
		,bGetAllScores = TRUE
		,useFuzzy = false
		,primForcePost = false
		,weightThreshold = 0
		,disableSaltForce = false
		,segmentation = true
		,reAppend = true
	) := functionmacro

	import BIPV2_Company_Names, BizLinkFull,ut,_Control,BIPV2_xlink_segmentation;

	#uniquename(zipset)
	#uniquename(infilec)
	#uniquename(outfile0)
	#uniquename(infilecnp)
	%infilec% :=
	project(infile(reAppend or (proxid = 0 and seleid = 0)),
		transform(
			{infile, unsigned6 cntr, DATASET(BizLinkFull.Process_Biz_layouts.layout_zip_cases) %zipset%},
				self.cntr := counter,
				self.%zipset% :=
				#if('A' in matchset)
					if(left.zip_field != '', DATASET([{left.zip_field,100}],BizLinkFull.Process_Biz_layouts.layout_zip_cases),
					   DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases));
				#else
					DATASET([],BizLinkFull.Process_Biz_layouts.layout_zip_cases);
				#end
				self := left
		));

	//clean up company names
	BIPV2_Company_Names.functions.mac_go(%infilec%,%infilecnp%,cntr,company_name_field,,FALSE);
	//decide whether to use keyed or pulled joins
	#uniquename(force)
	#uniquename(NodesUnder400)
	#uniquename(InfileSmall)
	#uniquename(ThorForced)
	#uniquename(useKeyedJoins)
	#uniquename(company_name_prefix)
	string4 %force% := '' : stored('did_add_force');
	boolean %NodesUnder400% := thorlib.nodes() < 400;
	boolean %InfileSmall% := count(infile) < 10000000;
	boolean %ThorForced% := %force% = 'thor';
	%useKeyedJoins% := (%NodesUnder400%) and not %ThorForced%;  //motivated by bug 112406

	local infile_augmented := PROJECT(%infilecnp%,
		TRANSFORM({RECORDOF(left); string %company_name_prefix% := '', STRING input_company_phone_3 := '',
		           STRING input_company_phone_7 := ''; STRING Input_fname_preferred := '';},
			self.%company_name_prefix% := if(useFuzzy, BizLinkFull.fn_company_name_prefix(left.cnp_name), '');
			#if('P' in matchset and #text(phone_field) != '')
				SELF.phone_field:=TRIM(LEFT.phone_field);
				SELF.input_company_phone_3:=IF(LENGTH(TRIM(LEFT.phone_field))=10,
				                               TRIM(LEFT.phone_field)[..3], '');
				SELF.input_company_phone_7:=IF(LENGTH(TRIM(LEFT.phone_field))=10,
				                               TRIM(LEFT.phone_field)[4..],
				                               IF(LENGTH(TRIM(LEFT.phone_field))=7,
				                                  TRIM(LEFT.phone_field), ''));
			#end
			#if(#TEXT(pContact_fname) != '')
				self.input_fname_preferred := BizLinkFull.fn_PreferredName(LEFT.pContact_fname);
			#end
			self := left));

	BizLinkFull.MAC_MEOW_Biz_Batch(
		infile_augmented,
		ref := cntr,
		input_source := pSource,
		Input_source_record_id := pSource_record_id,
		Input_company_name := company_name_field,
		Input_company_name_prefix := %company_name_prefix%,
		Input_cnp_name := cnp_name,
		Input_cnp_number := cnp_number,
		Input_cnp_btype := cnp_btype,
		Input_cnp_lowv := cnp_lowv,
		#if('P' in matchset)
			Input_company_phone := phone_field,
			Input_company_phone_3 := input_company_phone_3,
			Input_company_phone_7 := input_company_phone_7,
		#end
		#if('F' in matchset)
			Input_company_fein := fein_field,
		#end
		#if('A' in matchset)
			Input_prim_range := prange_field,
			Input_prim_name := pname_field,
			Input_sec_range := srange_field,
			Input_city := pCity,
			Input_st := state_field,
			Input_zip := %zipset%,
		#end
		Input_company_url := pURL,
		Input_fname := pContact_fname,
		Input_fname_preferred := Input_fname_preferred,
		Input_mname := pContact_mname,
		Input_lname := pContact_lname,
		Input_contact_ssn := pContact_ssn,
		Outfile := %OutFile0%,
		AsIndex := %useKeyedJoins%,
		In_bGetAllScores := bGetAllScores
		,In_disableForce := disableSaltForce
	);

	#UNIQUENAME(OutSegResult)
	%OutSegResult% := BIPV2_xlink_segmentation.mac_Segmentation(%OutFile0%,%useKeyedJoins%);
	
	#UNIQUENAME(OutFile1)
	%OutFile1% := IF(segmentation, %OutSegResult%, %OutFile0%);

  #uniquename(outnorm)
  %outnorm% := normalize(
	%OutFile1%((results[1].score >= (integer)score_threshold or results_seleid[1].score >= (integer)score_threshold or results_ultid[1].score >= (integer)score_threshold)
	           ,(results[1].weight >= (integer)weightThreshold or results_seleid[1].weight >= weightThreshold)
	           ,(results[1].proxid > 0 or results_seleid[1].seleid > 0 or results_ultid[1].ultid > 0)), //filter not necessary here, but might save some work
	(integer)keep_count,
	transform(
		{%OutFile1%.reference, %OutFile1%.results.proxid, %OutFile1%.results.weight, %OutFile1%.results.score, %OutFile1%.results.keys_used, %OutFile1%.results.keys_failed, %OutFile1%.results.seleid, %OutFile1%.results.orgid, %OutFile1%.results.ultid, %OutFile1%.results.powid
		  , unsigned4 seleweight, unsigned4 selescore, unsigned4 orgweight, unsigned4 orgscore, unsigned4 ultweight, unsigned4 ultscore, UNSIGNED4 powweight, UNSIGNED4 powscore
			//part 1 of 2 of the street force hack, but not harmful if left in 
		  ,%OutFile1%.results.prim_Range, %OutFile1%.results.prim_Rangeweight, %OutFile1%.results.prim_name, %OutFile1%.results.prim_nameweight
			//end hack
		  ,%OutFile1%.results.cnp_nameweight
		  ,BIPV2.IdAppendLayouts.parentIds
		},

		isProxResolved := left.results[counter].score >= (integer)score_threshold and left.results[counter].weight >= (integer)weightThreshold;
		isSeleResolved := left.results_seleid[counter].score >= (integer)score_threshold and left.results_seleid[counter].weight >= (integer)weightThreshold; 
		isOrgResolved := left.results_orgid[counter].score >= (integer)score_threshold and left.results_orgid[counter].weight >= (integer)weightThreshold; 
		isUltResolved := left.results_ultid[counter].score >= (integer)score_threshold and left.results_ultid[counter].weight >= (integer)weightThreshold; 
		isPowResolved := left.results_powid[counter].score >= (integer)score_threshold and left.results_powid[counter].weight >= (integer)weightThreshold; 

		isProxObvious := left.results[counter].score > 50;
		isSeleObvious := left.results_seleid[counter].score > 50;
		isOrgObvious := left.results_orgid[counter].score > 50;

		isSeleWrong := isProxObvious and left.results[counter].seleid != left.results_seleid[counter].seleid;
		isOrgProxWrong := isProxObvious and left.results[counter].orgid != left.results_orgid[counter].orgid;
		isOrgSeleWrong := not isProxObvious and isSeleObvious and left.results_seleid[counter].orgid != left.results_orgid[counter].orgid;
		isOrgWrong := isOrgProxWrong or isOrgSeleWrong;
		isUltProxWrong := isProxObvious and left.results[counter].ultid != left.results_ultid[counter].ultid;
		isUltSeleWrong := not isProxObvious and isSeleObvious and left.results_seleid[counter].ultid != left.results_ultid[counter].ultid;
		isUltOrgWrong := not isProxObvious and not isSeleObvious and isOrgObvious
		                   and left.results_orgid[counter].ultid != left.results_ultid[counter].ultid;
		isUltWrong := isUltProxWrong or isUltSeleWrong or isUltOrgWrong;
		isPowWrong := isProxObvious and left.results[counter].powid != left.results_powid[counter].powid;


		proxid := if(isProxResolved, left.results[counter].proxid, 0);
		proxScore := if(isProxResolved, left.results[counter].score, 0);
		proxWeight := if(isProxResolved, left.results[counter].weight, 0);

		// If the proxid is a good match, use the seleid associated with it, otherwise use the best matching seleid.
		// If the proxid has a score of > 50, then only return seleid associated with it to avoid returning different
		// seleids when different thresholds are used.
		seleid := map(isProxResolved => left.results[counter].seleid,
		              isSeleResolved and not isSeleWrong => left.results_seleid[counter].seleid,
					  0);
		// If proxid resolves, it doesn't make sense for sele score to be less than prox score so pick max(proxscore, selescore).
		// If seleid results don't match with proxid, then use score from proxid.
		// If proxid is non-ambiguous, then sele must match with it to avoid returning different results when
		// different thresholds are used.
		seleScore := map(isProxResolved and not isSeleWrong => max(proxScore, left.results_seleid[counter].score),
		                 isProxResolved and isSeleWrong => proxScore,
					     isSeleResolved and not isSeleWrong => left.results_seleid[counter].score, 0);

		// If seleid results don't match with proxid, then use score from proxid.
		// If proxid is non-ambiguous, then sele must match with it to avoid returning different results when
		// different thresholds are used.
		seleWeight := map(isProxResolved and not isSeleWrong => left.results_seleid[counter].weight,
		                  isProxResolved and isSeleWrong => proxWeight,
					      isSeleResolved and not isSeleWrong => left.results_seleid[counter].weight, 0);

		// Use similar logic for orgid and ultid that was used for seleid.
		orgid := map(isProxResolved => left.results[counter].orgid,
		             isSeleResolved and not isSeleWrong => left.results_seleid[counter].orgid,
					 isOrgResolved and not isOrgWrong => left.results_orgid[counter].orgid,
				     0);
		orgScore := map((isProxResolved or isSeleResolved) and not isOrgWrong => max(seleScore, left.results_orgid[counter].score),
		                (isProxResolved or isSeleResolved) and isOrgWrong => seleScore,
						isOrgResolved and not isOrgWrong => left.results_orgid[counter].score, 0);
		orgWeight := map((isProxResolved or isSeleResolved) and not isOrgWrong => left.results_orgid[counter].weight,
		                 (isProxResolved or isSeleResolved) and isOrgWrong => seleWeight,
						 isOrgResolved and not isOrgWrong => left.results_orgid[counter].weight, 0);

		ultid := map(isProxResolved => left.results[counter].ultid,
		             isSeleResolved and not isSeleWrong => left.results_seleid[counter].ultid,
					 isOrgResolved and not isOrgWrong => left.results_orgid[counter].ultid,
					 isUltResolved and not isUltWrong => left.results_ultid[counter].ultid,
				     0);
		ultScore := map((isProxResolved or isSeleResolved or isOrgResolved) and not isUltWrong
		                  => max(orgScore, left.results_ultid[counter].score),
		                (isProxResolved or isSeleResolved or isOrgResolved) and isUltWrong
						  => orgScore,
						isUltResolved and not isUltWrong => left.results_ultid[counter].score, 0);
		ultWeight := map((isProxResolved or isSeleResolved or isOrgResolved) and not isUltWrong => left.results_ultid[counter].weight,
		                 (isProxResolved or isSeleResolved or isOrgResolved) and isUltWrong => orgWeight,
						 isUltResolved and not isUltWrong => left.results_ultid[counter].weight, 0);

		// Powid is above proxid in the id hierarchy so it is treated similar to seleid logic.
		powid := map(isProxResolved => left.results[counter].powid,
		             isPowResolved and not isPowWrong => left.results_powid[counter].powid,
					 0);
		
		powScore := map(isProxResolved and not isPowWrong => max(proxScore, left.results_powid[counter].score),
		                isProxResolved and isPowWrong => proxScore,
					    isPowResolved and not isPowWrong => left.results_powid[counter].score, 0);

		powWeight := map(isProxResolved and not isPowWrong => left.results_powid[counter].weight,
		                 isProxResolved and isPowWrong => proxWeight,
					     isPowResolved and not isPowWrong => left.results_powid[counter].weight, 0);


		self.reference := left.reference;

		self.proxid := proxid;		  
		self.weight := proxWeight;
		self.score := proxScore;
		  
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
		self.sele_proxid := map(isProxResolved => left.results[counter].sele_proxid,
		                        isSeleResolved and not isSeleWrong => left.results_seleid[counter].sele_proxid,
		                        0);
		self.org_proxid := map(isProxResolved => left.results[counter].org_proxid,
		                       isSeleResolved and not isSeleWrong => left.results_seleid[counter].org_proxid,
		                       0);
		self.ultimate_proxid := map(isProxResolved => left.results[counter].ultimate_proxid,
		                            isSeleResolved and not isSeleWrong => left.results_seleid[counter].ultimate_proxid,
		                            0);
		self.keys_used := left.results[counter].keys_used;
		self.keys_failed := left.results[counter].keys_failed;
																
		self:= left.results[counter];    
		)
	)((score >= (integer)score_threshold or selescore >= (integer)score_threshold or ultscore >= (integer)score_threshold), (proxid > 0 or seleid > 0 or ultid > 0));// proxid > 0 also because of case where threshold is zero (without this you get keep_count records even with no IDs on them)


	#uniquename(outfile20);
	%outfile20% :=
	join(
		%infilec%,
    // %infilecnp%,        //THIS COULD VERY WELL BE A DISASTER!!!!!!! 
		%outnorm%,
		left.cntr = right.reference
			#if('A' in matchset)
				and (NOT primForcePost OR ( 
					(left.prange_field <> '' and left.prange_field = right.prim_Range) //exact nonblank pr match
						or not(                                                            //or just not a complete miss on both pr and pn
							(left.prange_field <> '' and right.prim_Range <> '' and right.prim_Rangeweight <= 0)
						OR
							(left.pname_field <> '' and right.prim_name <> '' and right.prim_nameweight <= 0)
					))
				)
			#end
        
    
		,transform(outrec, 
		  //*** Real values
		  self.proxid := right.proxid;
		  self.proxweight := right.weight;
		  self.proxscore := right.score;
		  //*** Faked out values
		  self.seleID := right.SELEid;
		  self.SELEweight := right.SELEweight, 
		  self.SELEscore := right.SELEscore,       
		  
		  self.orgid := right.orgid;
		  self.orgweight := right.orgweight,  
		  self.orgscore := right.orgscore,
		  
		  self.ultid := right.ultid;
		  self.ultweight := right.ultweight,  
		  self.ultscore := right.ultscore,  
		  
		  self.powid := RIGHT.powid,
		  self.powweight := RIGHT.powweight,
		  self.powscore := RIGHT.powscore,   
		  
		  //*** Empty values
		  self.dotid := 0;
		  self.dotweight := 0;
		  self.dotscore := 0;
		  
		  self.empid := 0,
		  self.empweight := 0,
		  self.empscore := 0,   

			self.parent_proxid := right.parent_proxid,
			self.sele_proxid := right.sele_proxid,
			self.org_proxid := right.org_proxid,
			self.ultimate_proxid := right.ultimate_proxid,
			self.keys_used := right.keys_used,
			self.keys_failed := right.keys_failed,
				
		  self := left
		),
		hash,      
		left outer
  );

	passThruIn := project(infile(proxid != 0 or seleid != 0),
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

	postPassThru := project(passThru, transform(recordof(%outfile20%),
		self.request_id := left.uniqueid,
		self := left;
		self := []));

	return %outfile20% + postPassThru;

endmacro;