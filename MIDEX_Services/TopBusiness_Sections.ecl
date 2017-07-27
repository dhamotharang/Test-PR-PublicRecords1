IMPORT AutoStandardI, BIPV2, iesp, MIDEX_Services, TopBusiness_Services;
EXPORT TopBusiness_Sections( dataset(BIPV2.IDlayouts.l_xlink_ids) in_linkid, MIDEX_Services.Iparam.reportrecords in_mod ) :=
	FUNCTION
	// set the FETCH LEVEL for join to main bus header key 
	FETCH_LEVEL := in_mod.BusinessIDFetchLevel;
	
	in_topbusiness_ds := PROJECT(in_linkid, 
			TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids,
				SELF.acctno := '001';
				SELF 				:= LEFT));
				
	TopBusiness_Services.BusinessReportComprehensive_Layouts xform_topbusiness_options() := TRANSFORM
		SELF.IncludeAssociatedBusinesses	:= TRUE;
		SELF.IncludeBankruptcies  				:= TRUE;
		SELF.IncludeContacts 							:= TRUE; //executives (current and prior), individuals (current and prior), etc.
		SELF.IncludeLiensJudgments				:= TRUE;
		SELF.IncludeProperties  					:= TRUE;
		SELF.IncludeNameVariations 				:= TRUE;
		SELF.IncludeParents 							:= TRUE;
		SELF.IncludeOpsSites 							:= TRUE;
		SELF.IncludeIncorporation					:= TRUE;
		SELF.IncludeConnectedBusinesses		:= TRUE;
		SELF.IncludeRegisteredAgents			:= TRUE;
		SELF.BusinessReportFetchLevel 		:= in_mod.BusinessIDFetchLevel;
		SELF.ApplicationType							:= in_mod.ApplicationType;
		SELF 															:= [];
	END;
	in_topbusiness_options 	:= row(xform_topbusiness_options());
	
	in_topbusiness_mod			:= module (project(in_mod, AutoStandardI.DataRestrictionI.params, opt)) end;
	
	// Per Don L., don't call Guts directly but rather call the TopBusiness_Services sections as needed in a similar fashion as Guts
	
	// set the dotid/empid/powid values to 0 regardless of what is in input	
	// This is how the BIP report (TopBusiness_Services/BusinessReportService) currently works
	ds_input_data := project(in_linkid, 
		transform(TopBusiness_Services.Layouts.rec_input_ids,
			self.acctno := '001';
			self.dotid := 0;
			self.empid := 0;
			self.powid := 0;
			self := left));

	ds_in_unique_ids_only := project(in_linkid, 
		transform(BIPV2.IDlayouts.l_xlink_ids, 	
			self.dotid := 0;
			self.powid := 0;															 
			self.empid := 0;															
			self.proxweight := 0;
			self.proxscore := 0;
			self.seleweight := 0;
			self.selescore := 0;
			self.ultscore := 0;
			self.ultweight := 0;
			self.dotscore := 0;
			self.dotweight := 0;
			self.orgscore := 0;
			self.orgweight := 0;
			self.powscore := 0;
			self.powweight := 0;
			self.empscore := 0;
			self.empweight := 0;																														 													
			self := left, 														
			));
														 
	ds_busHeaderRecs := BIPV2.Key_BH_Linking_Ids.kfetch(ds_in_unique_ids_only,FETCH_LEVEL,
	                             ,,TopBusiness_Services.Constants.BusHeaderKfetchMaxLimit,TRUE);
			
	seed_results := project(ds_input_data,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.acctno := '001',
			self := []));
			
  add_best := 
	  join(seed_results,
			TopBusiness_Services.BestSection.fn_fullView(
				in_topbusiness_ds, // passing in full set of ids with dot/emp/pow possibly populated 
											// will zero out as needed in best
				project(dataset(in_topbusiness_options), 
					transform(TopBusiness_Services.BestSection_Layouts.rec_OptionsLayout, self := left, self := []))[1],
				in_topbusiness_mod,
				ds_busheaderRecs
				),
		  left.acctno = right.acctno,
		  transform(MIDEX_Services.Layouts.rec_TopBusiness,
			  self.BestSection := right,
			  self := left),
		  left outer);		
 
  // save best cname and pass to property section below.
  bestCname := add_best[1].BestSection.companyname;

	add_parent :=	join(
		add_best,
		TopBusiness_Services.ParentSection.fn_fullView(
			project(ds_input_data, transform(TopBusiness_Services.ParentSection_Layouts.rec_Input, self := left)),
			project(dataset(in_topbusiness_options),TopBusiness_Services.ParentSection_Layouts.rec_OptionsLayout)[1],
			in_topbusiness_mod,
			ds_busHeaderRecs
			),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.ParentSection := right,
			self := left),
		left outer);	
	
	add_associate := join(
		add_parent,
		TopBusiness_Services.AssociateSection.fn_fullView(
			ds_input_data,
			project(dataset(in_topbusiness_options),TopBusiness_Services.Layouts.rec_input_options)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.AssociateSection := right,
			self := left),
		left outer);

	add_contact := join(
		add_associate,
		TopBusiness_Services.ContactSection.fn_fullView(
			project(ds_input_data, transform(TopBusiness_Services.ContactSection_Layouts.rec_Input, self := left))
			,project(dataset(in_topbusiness_options),TopBusiness_Services.ContactSection_Layouts.rec_OptionsLayout)[1],
			in_topbusiness_mod),											  
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.ContactSection := right,
			self := left),
		left outer);
		
  add_incorporation := join(
		add_contact,				
		TopBusiness_Services.IncorporationSection.fn_fullView(
			ds_input_data,
			project(dataset(in_topbusiness_options), TopBusiness_Services.Layouts.rec_input_options)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.IncorporationSection := right,
			self := left),
		left outer);		
	
	add_property := join(
		add_incorporation,
		TopBusiness_Services.PropertySection.fn_fullView(			
			project(ds_input_data, 
					transform(TopBusiness_Services.PropertySection_Layouts.rec_Input, self := left))
			,project(dataset(in_topbusiness_options),TopBusiness_Services.PropertySection_Layouts.rec_OptionsLayout)[1]
			,in_topbusiness_mod
			,bestCname),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.PropertySection := right,
			self := left), 	
		left outer);

  // Save off Property Section, "Properties" child dataset to pass into the Ops/Sites Section below.
  ds_properties := add_property[1].PropertySection.PropertyRecords.Properties;

	add_opssites := join(
		add_property,
		TopBusiness_Services.OperationsSitesSection.fn_fullView(
			ds_input_data,
			project(dataset(in_topbusiness_options), TopBusiness_Services.Layouts.rec_input_options)[1],
			in_topbusiness_mod,
			ds_properties
			,ds_busHeaderRecs
			),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.OperationsSitesSection := right,
			self := left),
		left outer);
	
	add_bankruptcy := join(
		add_opssites,
		TopBusiness_Services.BankruptcySection.fn_fullView(
			project(ds_input_data, transform(TopBusiness_Services.BankruptcySection_Layouts.rec_Input, self := left)),
			project(dataset(in_topbusiness_options),TopBusiness_Services.BankruptcySection_Layouts.rec_OptionsLayout)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.BankruptcySection := right,
			self := left),
		left outer);

	add_liens := join(
		add_bankruptcy,
		TopBusiness_Services.LienSection.fn_fullView(
			ds_input_data,
			project(dataset(in_topbusiness_options),TopBusiness_Services.Layouts.rec_input_options)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.LienSection := right,
			self := left),
		left outer);

	add_RegisteredAgents := join(
		add_liens,
		TopBusiness_Services.RegisteredAgentSection.fn_fullView(
			project(ds_input_data, transform(TopBusiness_Services.RegisteredAgentSection_Layouts.rec_Input, self := left)),
			project(dataset(in_topbusiness_options),TopBusiness_Services.RegisteredAgentSection_Layouts.rec_OptionsLayout)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.RegisteredAgentSection := right,
			self := left),
		left outer);
		
	topBusinessRecs := join(
		add_RegisteredAgents,
		TopBusiness_Services.ConnectedBusinessSection.fn_fullView(
			project(ds_input_data, transform(TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_Input, self := left)),
			project(dataset(in_topbusiness_options),TopBusiness_Services.ConnectedBusinessSection_Layouts.rec_OptionsLayout)[1],
			in_topbusiness_mod),
		left.acctno = right.acctno,
		transform(MIDEX_Services.Layouts.rec_TopBusiness,
			self.ConnectedBusinessSection := right,
			self := left),
		left outer);
		
	RETURN topBusinessRecs;
END;