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
		,BDID_field
		,outrec
		,bool_outrec_has_score
		,BDID_Score_field
		,keep_count = '1'
		,score_threshold = '75'
		// ,pFileVersion = '\'prod\''
		// ,pUseOtherEnvironment = business_header._Dataset().IsDataland
		// ,pSetLinkingVersions = BIPV2.IDconstants.xlink_versions_default
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
		,bGetAllScores=TRUE
	) := functionmacro

	import BIPV2_Company_Names, BizLinkFull,ut,_Control;

	#uniquename(zipset)
	#uniquename(infilec)
	#uniquename(outfile1)
	#uniquename(infilecnp)
	%infilec% :=
	project(infile,
		transform(
			{infile, unsigned6 cntr, DATASET(BizLinkFull.Process_Biz_layouts.layout_zip_cases) %zipset%},
				self.cntr := counter,
				self.%zipset% :=
				#if('A' in matchset)
					DATASET([{left.zip_field,100}],BizLinkFull.Process_Biz_layouts.layout_zip_cases);
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
	string4 %force% := '' : stored('did_add_force');
	boolean %NodesUnder400% := thorlib.nodes() < 400;
	boolean %InfileSmall% := count(infile) < 10000000;
	boolean %ThorForced% := %force% = 'thor';
	%useKeyedJoins% := (%NodesUnder400%) and not %ThorForced%;  //motivated by bug 112406

	local infile_augmented := PROJECT(%infilecnp%,
		TRANSFORM({RECORDOF(left); STRING input_company_phone_3 := '',
		           STRING input_company_phone_7 := ''; STRING Input_fname_preferred := '';},
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
		Input_fname := pContact_fname,
		Input_fname_preferred := Input_fname_preferred,
		Input_mname := pContact_mname,
		Input_lname := pContact_lname,
		Input_contact_ssn := pContact_ssn,
		Outfile := %OutFile1%,
		// AsIndex := %useKeyedJoins%,
		AsIndex := true, // TODO
		In_bGetAllScores := bGetAllScores
	);


  #uniquename(outnorm)
  %outnorm% :=
  normalize(
		%OutFile1%((results[1].score >= (integer)score_threshold or results_ultid[1].score >= (integer)score_threshold), (results[1].proxid > 0 or results_ultid[1].ultid > 0)), //filter not necessary here, but might save some work
		(integer)keep_count,
		transform(
		  {%OutFile1%.reference, %OutFile1%.results.proxid, %OutFile1%.results.weight, %OutFile1%.results.score, %OutFile1%.results.seleid, %OutFile1%.results.orgid, %OutFile1%.results.ultid, %OutFile1%.results.powid
				, unsigned4 seleweight, unsigned4 selescore, unsigned4 orgweight, unsigned4 orgscore, unsigned4 ultweight, unsigned4 ultscore, UNSIGNED4 powweight, UNSIGNED4 powscore
			//part 1 of 2 of the street force hack, but not harmful if left in 
				,%OutFile1%.results.prim_Range, %OutFile1%.results.prim_Rangeweight, %OutFile1%.results.prim_name, %OutFile1%.results.prim_nameweight
			//end hack
				,%OutFile1%.results.cnp_nameweight
		  },
		  PG := left.results[counter].score >= (integer)score_threshold;
		  SG := PG or left.results_seleid[counter].score >= (integer)score_threshold;
		  OG := SG or left.results_orgid[counter].score >= (integer)score_threshold;
		  UG := OG or left.results_ultid[counter].score >= (integer)score_threshold;
		  POWG := UG or left.results_powid[counter].score >= (integer)score_threshold;
		  self.reference := left.reference;
		  
		  self.weight := if(PG,left.results[counter].weight,0);
		  self.score := if(PG,left.results[counter].score,0);
		  self.proxid := if(PG,left.results[counter].proxid,0);
		  
		  self.seleweight := if(SG,left.results_seleid[counter].weight,0);
		  self.selescore  := if(SG,left.results_seleid[counter].score,0);
		  self.seleid := if(SG,IF(left.results_seleid[counter].seleid=0,LEFT.results[COUNTER].seleid,left.results_seleid[counter].seleid),0);
		  
		  self.orgweight := if(OG,left.results_orgid[counter].weight,0);
		  self.orgscore := if(OG,left.results_orgid[counter].score,0);
		  self.orgid := if(OG,IF(left.results_orgid[counter].orgid=0,LEFT.results[COUNTER].orgid,left.results_orgid[counter].orgid),0);
		  
		  self.ultweight := if(UG,left.results_ultid[counter].weight,0);
		  self.ultscore := if(UG,left.results_ultid[counter].score,0);
		  self.ultid := if(UG,IF(left.results_ultid[counter].ultid=0,LEFT.results[COUNTER].ultid,left.results_ultid[counter].ultid),0);
		  
		  self.powweight := if(UG,left.results_powid[counter].weight,0);
		  self.powscore := if(UG,left.results_powid[counter].score,0);
		  self.powid := if(UG,IF(left.results_powid[counter].powid=0,LEFT.results[COUNTER].powid,left.results_powid[counter].powid),0);
		  self:= left.results[counter];    
		)
	)((score >= (integer)score_threshold or ultscore >= (integer)score_threshold), (proxid > 0 or ultid > 0));// proxid > 0 also because of case where threshold is zero (without this you get keep_count records even with no IDs on them)


	#uniquename(outfile20);
	%outfile20% :=
	join(
		%infilec%,
    // %infilecnp%,        //THIS COULD VERY WELL BE A DISASTER!!!!!!! 
		%outnorm%,
		left.cntr = right.reference
			#if('A' in matchset)
				and( 
					(left.prange_field <> '' and left.prange_field = right.prim_Range) //exact nonblank pr match
						or not(                                                            //or just not a complete miss on both pr and pn
							(left.prange_field <> '' and right.prim_Range <> '' and right.prim_Rangeweight <= 0)
						OR
							(left.pname_field <> '' and right.prim_name <> '' and right.prim_nameweight <= 0)
					)
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
				
		  self := left
		),
		hash,      
		left outer
  );

	return %outfile20%;

	// return parallel(
		// output(infile_augmented, named('in_biz_batch'));
		// output(%outfile1%, named('biz_batch'));
	// );

endmacro;