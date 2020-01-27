import MDR;


  SHARED SET OF STRING ssAuthorityAll := [
      'BC'                           //SBFE
     ,MDR.SourceTools.set_CorpV2     //SOS
     ,'RR'                           //Cortera
		 ,'D'                            //D&B
  ];

	  SHARED SET OF STRING ssHeaderAll := [
        ssAuthorityAll
			 ,'Z1'  //Equifax Business Marketing File
			 ,'BA'  //Bankruptcy
			 ,'L2'  //Judgement and Liens
			 ,'LA'  //Real Property
			 ,'BR'  //Business Registrations
			 ,'DN'  //Duns and Bradstreet FEIN
			 ,'E6'  //Experian FEIN Unrestricted
			 ,'E5'  //Experian FEIN Restricted
    ];
		
  SHARED SET OF STRING ssExternalSets := [
				'GR'  //Garnishments
			 ,'SP'  //Spoke
			 ,'@@'  //Taxpro
			 ,'!!'  //Thrive
			 ,'V@' 	//Vickers13
			 ,'V#' 	//VICKERS
			 ,'ZM' 	//ZOOM
			 ,'BY'	//BANKRUPTCY_ATTORNEY
			 ,'MP'	//Mari professional license
			 ,'S@'	//Sanctn
			 ,'M@'	//Sanctn np
  ];
  
  
  SHARED SET OF STRING ssBatchSets := [
			'B#' //Batch
  ];
  
	SHARED SET OF STRING ssInquirySets := [
		 'B#' //Batch
		,'T1'
    ,'T2'
    ,'T3'
    ,'T4'
    ,'T5'
    ,'T'
    ,'P'
  ];
  SHARED SET OF STRING ssAllSources := ssHeaderAll + ssExternalSets;
	
EXPORT modProfiles := MODULE

EXPORT regressionProfiles := DATASET([
        {'Header',ssHeaderAll,	44,	0,	75,	1, 2, '',[]}
       ,{'HeaderAuthority',ssAuthorityAll,	44,	0,	75,	1, 2, '',[]}
       ,{'External',ssExternalSets,	44,	0,	75,	1, 2, '',[]}
       ,{'Batch',ssBatchSets,	44,	0,	75,	1, 2, '',[]}
	    ], modLayouts.profileRec);


EXPORT IARProfile := DATASET([
		  {'Comp_Addr All H',ssHeaderAll,	44, 0,	75,	5, 1, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Force H',ssHeaderAll,	44, 0,	75,	5, 2, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Fuzzy H',ssHeaderAll,	44, 0,	75,	5, 3, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Zip H',ssHeaderAll,	44, 0,	75,	5, 4, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}		
		, {'Comp_Addr All I',ssInquirySets,	44, 0,	75,	5, 1, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Force I',ssInquirySets,	44, 0,	75,	5, 2, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Fuzzy I',ssInquirySets,	44, 0,	75,	5, 3, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		, {'Comp_Addr Zip I',ssInquirySets,	44, 0,	75,	5, 4, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}		  

		, {'Comp_Addr_Contact All H',ssHeaderAll,	44, 0,	75,	5, 1, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Force H',ssHeaderAll,	44, 0,	75,	5, 2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Fuzzy H',ssHeaderAll,	44, 0,	75,	5, 3, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Zip H',ssHeaderAll,	44, 0,	75,	5, 4, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact All I',ssInquirySets,	44, 0,	75,	5, 1, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Force I',ssInquirySets,	44, 0,	75,	5, 2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Fuzzy I',ssInquirySets,	44, 0,	75,	5, 3, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}
		, {'Comp_Addr_Contact Zip I',ssInquirySets,	44, 0,	75,	5, 4, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_lname']}

		 ], modLayouts.profileRec);
		 

  EXPORT statProfiles := DATASET([
		 {'Comp_Addr H',ssHeaderAll,	44, 0,	75,	9, 8, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','city','state','zip5']}
		,{'Comp_Fein H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','fein']}
		,{'Comp_Phone H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','phone10']}
		,{'Comp_Email H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','email']}
		,{'Comp_Url H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name','url']}
		,{'Fein H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['fein']}
		,{'Comp H',ssHeaderAll,	44, 0,	75, 9, 8, 'Header',['company_name']}
		,{'Comp_Addr I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','city','state','zip5']}
		,{'Comp_Fein I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','fein']}
		,{'Comp_Phone I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','phone10']}
		,{'Comp_Email I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','email']}
		,{'Comp_Url I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name','url']}
		,{'Fein I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['fein']}
		,{'Comp I',ssInquirySets,	44, 0,	75, 9, 8, 'Inquiry',['company_name']}
    ], modLayouts.profileRec);


  EXPORT statProfiles_SALT311Test := DATASET([
		 {'Comp_Addr H',ssHeaderAll,	44, 0,	75,	10, 11, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','city','state','zip5']}
		,{'Comp_Fein H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','fein']}
		,{'Comp_Phone H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','phone10']}
		,{'Comp_Email H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','email']}
		,{'Comp_Url H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name','url']}
		,{'Fein H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['fein']}
		,{'Comp H',ssHeaderAll,	44, 0,	75, 10, 11, 'Header',['company_name']}
		,{'Comp_Addr I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','city','state','zip5']}
		,{'Comp_Fein I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','fein']}
		,{'Comp_Phone I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','phone10']}
		,{'Comp_Email I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','email']}
		,{'Comp_Url I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name','url']}
		,{'Fein I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['fein']}
		,{'Comp I',ssInquirySets,	44, 0,	75, 10, 11, 'Inquiry',['company_name']}
    ], modLayouts.profileRec);
		
 EXPORT dProfileAll := DATASET([
		{'SBFE',['BC'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'CORTERA',['RR'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 9, 8, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	9, 8, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Bankruptcy',['BA'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 9, 8, 'Header', []} 
 ,	{'Business Registrations',['BR'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 9, 8, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 9, 8, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 9, 8, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 9, 8, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 9, 8, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 9, 8, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 9, 8, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 9, 8, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 9, 8, 'External', []}
    ], modLayouts.profileRec);

 EXPORT dProfileAll_SALT311Test := DATASET([
		{'SBFE',['BC'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'CORTERA',['RR'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 10, 11, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	10, 11, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Bankruptcy',['BA'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Business Registrations',['BR'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 10, 11, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 10, 11, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 10, 11, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 10, 11, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 10, 11, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 10, 11, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 10, 11, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 10, 11, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 10, 11, 'External', []}
    ], modLayouts.profileRec);

EXPORT dProfileAll_segmentation_roxie_overall := DATASET([
		// {'SBFE',['BC'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'CORTERA',['RR'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 9, 8, 'Header', []}
 // ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	9, 8, 'Header', []}
 // ,  {'Experian Business Reports',['ER'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Bankruptcy',['BA'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Judgement and Liens',['L2'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 9, 8, 'Header', []} 
 // ,	{'Business Registrations',['BR'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 9, 8, 'Header', []}
 // ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 9, 8, 'Header', []}
   {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 14, 15, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 14, 15, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 14, 15, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 14, 15, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 14, 15, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 14, 15, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 14, 15, 'External', []}
    ], modLayouts.profileRec);

EXPORT dProfileAll_segmentation_thor_overall := DATASET([
		// {'SBFE',['BC'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'CORTERA',['RR'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 17, 18, 'Header', []}
 // ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	17, 18, 'Header', []}
 // ,  {'Experian Business Reports',['ER'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Bankruptcy',['BA'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Judgement and Liens',['L2'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 17, 18, 'Header', []} 
 // ,	{'Business Registrations',['BR'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 17, 18, 'Header', []}
 // ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 17, 18, 'Header', []}
   {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 17, 18, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 17, 18, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 17, 18, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 17, 18, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 17, 18, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 17, 18, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 17, 18, 'External', []}
    ], modLayouts.profileRec);

EXPORT dProfileAll_segmentation_MMF_overall := DATASET([
		{'SBFE',['BC'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'CORTERA',['RR'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 21, 22, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	21, 22, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Bankruptcy',['BA'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 21, 22, 'Header', []} 
 ,	{'Business Registrations',['BR'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 21, 22, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 21, 22, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 21, 22, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 21, 22, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 21, 22, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 21, 22, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 21, 22, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 21, 22, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 21, 22, 'External', []}
    ], modLayouts.profileRec);

EXPORT dProfileAll_sRid_MMF_weight_overall := DATASET([
		{'SBFE',['BC'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'CORTERA',['RR'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	0,  0,	75, 22, 23, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	0, 0,	75,	22, 23, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Bankruptcy',['BA'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Business Registrations',['BR'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	0, 0,	75, 22, 23, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	0, 0,	75, 22, 23, 'Header', []}
//  , 	{'BUSINESSCREDITREPORT',['T1'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,  {'SMALLBUSINESSANALYTICS', ['T2'], 0, 0,	75, 22, 23, 'Inquiry', []}
//  ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,	{'SMALLBUSINESSRISK', ['T4'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,	{'BUSINESSINSTANTID2', ['T5'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,	{'TOPBUSINESS', ['T'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,	{'PREFILL', ['P'],	0, 0,	75, 22, 23, 'Inquiry', []}
//  ,	{'BATCH', ['B#'],	0, 0,	75, 22, 23, 'Batch', []} //missing
//  ,	{'GARNISH', ['GR'],	0, 0,	75, 22, 23, 'External', []}
//  ,	{'SPOKE', ['SP'],	0, 0,	75, 22, 23, 'External', []}
//  ,	{'TAXPRO', ['@@'],	0, 0,	75, 22, 23, 'External', []}
//  ,	{'THRIVE', ['!!'],	0, 0,	75, 22, 23, 'External', []}//missing
//  ,	{'VICKERS13', ['V@'],	0, 0,	75, 22, 23, 'External', []}
//  ,	{'VICKERS', ['V#'],	0, 0,	75, 22, 23, 'External', []}
//  ,	{'ZOOM', ['ZM'],	0, 0,	75, 22, 23, 'External', []} //missing
//  ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 22, 23, 'External', []}
     ], modLayouts.profileRec);

EXPORT dProfileAll_MMF_weight_overall := DATASET([
// 		{'SBFE',['BC'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'CORTERA',['RR'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Dunn Bradstreet', ['D'],	0,  0,	75, 24, 25, 'Header', []}
//  ,  {'SOS',MDR.SourceTools.set_CorpV2,	0, 0,	75,	24, 25, 'Header', []}
//  ,  {'Experian Business Reports',['ER'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Equifax Business Marketing File', ['Z1'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Bankruptcy',['BA'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Judgement and Liens',['L2'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Business Registrations',['BR'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Duns and Bradstreet FEIN',['DN'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Experian FEIN Unrestricted',['E6'],	0, 0,	75, 24, 25, 'Header', []}
//  ,	{'Experian FEIN Restricted',['E5'],	0, 0,	75, 24, 25, 'Header', []}
// ,  {'BUSINESSCREDITREPORT',['T1'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,  {'SMALLBUSINESSANALYTICS', ['T2'], 0, 0,	75, 24, 25, 'Inquiry', []}
// ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,	{'SMALLBUSINESSRISK', ['T4'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,	{'BUSINESSINSTANTID2', ['T5'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,	{'TOPBUSINESS', ['T'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,	{'PREFILL', ['P'],	0, 0,	75, 24, 25, 'Inquiry', []}
// ,	{'BATCH', ['B#'],	0, 0,	75, 24, 25, 'Batch', []} //missing
	{'GARNISH', ['GR'],	0, 0,	75, 24, 25, 'External', []}
 ,	{'SPOKE', ['SP'],	0, 0,	75, 24, 25, 'External', []}
 ,	{'TAXPRO', ['@@'],	0, 0,	75, 24, 25, 'External', []}
 ,	{'THRIVE', ['!!'],	0, 0,	75, 24, 25, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	0, 0,	75, 24, 25, 'External', []}
 ,	{'VICKERS', ['V#'],	0, 0,	75, 24, 25, 'External', []}
 ,	{'ZOOM', ['ZM'],	0, 0,	75, 24, 25, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 24, 25, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 24, 25, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 24, 25, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 24, 25, 'External', []}
     ], modLayouts.profileRec);

EXPORT dProfileAll_zipExpansion := DATASET([
		// {'SBFE',['BC'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'CORTERA',['RR'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 12, 13, 'Header', []}
 // ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	12, 13, 'Header', []}
 // ,  {'Experian Business Reports',['ER'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 12, 13, 'Header', []}
 	{'Bankruptcy',['BA'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Judgement and Liens',['L2'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 12, 13, 'Header', []}
 ,	{'Business Registrations',['BR'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 12, 13, 'Header', []}
 // ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 12, 13, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 12, 13, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 12, 13, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 12, 13, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 12, 13, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 12, 13, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 12, 13, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 12, 13, 'External', []}
    ], modLayouts.profileRec);

EXPORT dProfileAll_roxie_segmentation := DATASET([
		{'BUSINESSCREDITREPORT_CNP_R',['T1'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name']}
 ,	{'BUSINESSCREDITREPORT_CNP_ADDRFULL_R',['T1'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_CNP_LOCALE_R',['T1'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_CNP_FEIN_R',['T1'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSCREDITREPORT_CNP_PHN_R',['T1'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSCREDITREPORT_CNP_ADDR_FEIN_PHN_R',['T1'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSANALYTICS_CNP_R',['T2'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_ADDRFULL_R',['T2'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_LOCALE_R',['T2'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_FEIN_R',['T2'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_PHN_R',['T2'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_ADDR_FEIN_PHN_R',['T2'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_R',['T3'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_ADDRFULL_R',['T3'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_LOCALE_R',['T3'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_FEIN_R',['T3'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_PHN_R',['T3'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_ADDR_FEIN_PHN_R',['T3'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSRISK_CNP_R',['T4'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSRISK_CNP_ADDRFULL_R',['T4'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_CNP_LOCALE_R',['T4'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_CNP_FEIN_R',['T4'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSRISK_CNP_PHN_R',['T4'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSRISK_CNP_ADDR_FEIN_PHN_R',['T4'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BUSINESSINSTANTID2_CNP_R',['T5'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name']}
 ,	{'BUSINESSINSTANTID2_CNP_ADDRFULL_R',['T5'],	44, 0,	75, 14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_CNP_LOCALE_R',['T5'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_CNP_FEIN_R',['T5'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSINSTANTID2_CNP_PHN_R',['T5'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSINSTANTID2_CNP_ADDR_FEIN_PHN_R',['T5'],	44, 0,	75,  14, 15, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BATCH_CNP_R',['B#'],	44, 0,	75, 14, 15, 'Batch', ['company_name']}
 ,	{'BATCH_CNP_ADDRFULL_R',['B#'],	44, 0,	75, 14, 15, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BATCH_CNP_LOCALE_R',['B#'],	44, 0,	75,  14, 15, 'Batch', ['company_name','city','state','zip5']}
 ,	{'BATCH_CNP_FEIN_R',['B#'],	44, 0,	75,  14, 15, 'Batch', ['company_name','fein']}
 ,	{'BATCH_CNP_PHN_R',['B#'],	44, 0,	75,  14, 15, 'Batch', ['company_name','phone10']}
 ,	{'BATCH_CNP_ADDR_FEIN_PHN_R',['B#'],	44, 0,	75,  14, 15, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
], modLayouts.profileRec);

EXPORT dProfileAll_thor_segmentation := DATASET([
	{'BUSINESSCREDITREPORT_CNP_T',['T1'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name']}
 ,	{'BUSINESSCREDITREPORT_ADDRFULL_T',['T1'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_LOCALE_T',['T1'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_CNP_FEIN_T',['T1'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSCREDITREPORT_CNP_PHN_T',['T1'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSCREDITREPORT_CNP_ADDR_FEIN_PHN_T',['T1'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSANALYTICS_CNP_T',['T2'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSANALYTICS_ADDRFULL_T',['T2'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_LOCALE_T',['T2'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_FEIN_T',['T2'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_PHN_T',['T2'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_ADDR_FEIN_PHN_T',['T2'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_T',['T3'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_ADDRFULL_T',['T3'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_LOCALE_T',['T3'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_FEIN_T',['T3'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_PHN_T',['T3'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_ADDR_FEIN_PHN_T',['T3'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSRISK_CNP_T',['T4'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSRISK_ADDRFULL_T',['T4'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_LOCALE_T',['T4'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_CNP_FEIN_T',['T4'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSRISK_CNP_PHN_T',['T4'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSRISK_CNP_ADDR_FEIN_PHN_T',['T4'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BUSINESSINSTANTID2_CNP_T',['T5'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name']}
 ,	{'BUSINESSINSTANTID2_ADDRFULL_T',['T5'],	44, 0,	75, 17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_LOCALE_T',['T5'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_CNP_FEIN_T',['T5'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSINSTANTID2_CNP_PHN_T',['T5'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSINSTANTID2_CNP_ADDR_FEIN_PHN_T',['T5'],	44, 0,	75,  17, 18, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BATCH_CNP_T',['B#'],	44, 0,	75, 17, 18, 'Batch', ['company_name']}
 ,	{'BATCH_ADDRFULL_T',['B#'],	44, 0,	75, 17, 18, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BATCH_LOCALE_T',['B#'],	44, 0,	75,  17, 18, 'Batch', ['company_name','city','state','zip5']}
 ,	{'BATCH_CNP_FEIN_T',['B#'],	44, 0,	75,  17, 18, 'Batch', ['company_name','fein']}
 ,	{'BATCH_CNP_PHN_T',['B#'],	44, 0,	75,  17, 18, 'Batch', ['company_name','phone10']}
 ,	{'BATCH_CNP_ADDR_FEIN_PHN_T',['B#'],	44, 0,	75,  17, 18, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
], modLayouts.profileRec);

EXPORT statProfiles_MMF_segmentation := DATASET([
	{'BUSINESSCREDITREPORT_CNP',['T1'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name']}
 ,	{'BUSINESSCREDITREPORT_ADDRFULL',['T1'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_LOCALE',['T1'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSCREDITREPORT_CNP_FEIN',['T1'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSCREDITREPORT_CNP_PHN',['T1'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSCREDITREPORT_CNP_ADDR_FEIN_PHN',['T1'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSANALYTICS_CNP',['T2'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSANALYTICS_ADDRFULL',['T2'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_LOCALE',['T2'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_FEIN',['T2'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_PHN',['T2'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSANALYTICS_CNP_ADDR_FEIN_PHN',['T2'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP',['T3'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_ADDRFULL',['T3'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_LOCALE',['T3'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_FEIN',['T3'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_PHN',['T3'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSBIPCOMBINEDREPORT_CNP_ADDR_FEIN_PHN',['T3'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'SMALLBUSINESSRISK_CNP',['T4'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name']}
 ,	{'SMALLBUSINESSRISK_ADDRFULL',['T4'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_LOCALE',['T4'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'SMALLBUSINESSRISK_CNP_FEIN',['T4'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','fein']}
 ,	{'SMALLBUSINESSRISK_CNP_PHN',['T4'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','phone10']}
 ,	{'SMALLBUSINESSRISK_CNP_ADDR_FEIN_PHN',['T4'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BUSINESSINSTANTID2_CNP',['T5'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name']}
 ,	{'BUSINESSINSTANTID2_ADDRFULL',['T5'],	44, 0,	75, 21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_LOCALE',['T5'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','city','state','zip5']}
 ,	{'BUSINESSINSTANTID2_CNP_FEIN',['T5'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','fein']}
 ,	{'BUSINESSINSTANTID2_CNP_PHN',['T5'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','phone10']}
 ,	{'BUSINESSINSTANTID2_CNP_ADDR_FEIN_PHN',['T5'],	44, 0,	75,  21, 22, 'Inquiry', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
 ,	{'BATCH_CNP',['B#'],	44, 0,	75, 21, 22, 'Batch', ['company_name']}
 ,	{'BATCH_ADDRFULL',['B#'],	44, 0,	75, 21, 22, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5']}
 ,	{'BATCH_LOCALE',['B#'],	44, 0,	75,  21, 22, 'Batch', ['company_name','city','state','zip5']}
 ,	{'BATCH_CNP_FEIN',['B#'],	44, 0,	75,  21, 22, 'Batch', ['company_name','fein']}
 ,	{'BATCH_CNP_PHN',['B#'],	44, 0,	75,  21, 22, 'Batch', ['company_name','phone10']}
 ,	{'BATCH_CNP_ADDR_FEIN_PHN',['B#'],	44, 0,	75,  21, 22, 'Batch', ['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']} 
], modLayouts.profileRec);

EXPORT dProfileAll_ThorProdVsThorLocal := DATASET([
	{'SBFE',['BC'],	0,0,0, 2, 2, 'Header', []}
 ,	{'CORTERA',['RR'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	0,0,0, 2, 2, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	0,0,0,	2, 2, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Bankruptcy',['BA'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	0,0,0, 2, 2, 'Header', []}
 ,	{'Business Registrations',['BR'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	0,0,0, 2, 2, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'], 0,0,0, 2, 2, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	0,0,0, 2, 2, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	0,0,0, 2, 2, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 0,0,0, 2, 2, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	0,0,0, 2, 2, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	0,0,0, 2, 2, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	0,0,0, 2, 2, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	0,0,0, 2, 2, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	0,0,0, 2, 2, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	0,0,0, 2, 2, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	0,0,0, 2, 2, 'External', []}
 ,	{'SPOKE', ['SP'],	0,0,0, 2, 2, 'External', []}
 ,	{'TAXPRO', ['@@'],	0,0,0, 2, 2, 'External', []}
 ,	{'THRIVE', ['!!'],	0,0,0, 2, 2, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	0,0,0, 2, 2, 'External', []}
 ,	{'VICKERS', ['V#'],	0,0,0, 2, 2, 'External', []}
 ,	{'ZOOM', ['ZM'],	0,0,0, 2, 2, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	0, 0,	0, 2, 2, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	0, 0,	0, 2, 2, 'External', []}
 ,	{'SANCTN', ['S@'],	0, 0,	0, 2, 2, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	0, 0,	0, 2, 2, 'External', []}
    ], modLayouts.profileRec);         
 
EXPORT dProfileAll_ThorUsingRoxieDefaults := DATASET([
	{'SBFE',['BC'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'CORTERA',['RR'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 19, 20,'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	19, 20,'Header', []}
 ,  {'Experian Business Reports',['ER'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Bankruptcy',['BA'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Judgement and Liens',['L2'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 19, 20,'Header', []}
 ,	{'Business Registrations',['BR'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 19, 20,'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 19, 20,'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 19, 20,'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 19, 20,'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 19, 20,'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 19, 20,'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 19, 20,'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 19, 20,'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 19, 20,'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 19, 20,'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 19, 20,'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 19, 20,'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 19, 20, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 19, 20, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 19, 20, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 19, 20, 'External', []}
    ], modLayouts.profileRec); 

EXPORT statProfiles_ThorUsingRoxieDefaults := DATASET([
		 {'Comp_Addr H',ssHeaderAll,	44, 0,	75,	19, 20,'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','city','state','zip5']}
		,{'Comp_Fein H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','fein']}
		,{'Comp_Phone H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','phone10']}
		,{'Comp_Email H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','email']}
		,{'Comp_Url H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name','url']}
		,{'Fein H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['fein']}
		,{'Comp H',ssHeaderAll,	44, 0,	75, 19, 20,'Header',['company_name']}
		,{'Comp_Addr I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','city','state','zip5']}
		,{'Comp_Fein I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','fein']}
		,{'Comp_Phone I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','phone10']}
		,{'Comp_Email I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','email']}
		,{'Comp_Url I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name','url']}
		,{'Fein I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['fein']}
		,{'Comp I',ssInquirySets,	44, 0,	75, 19, 20,'Inquiry',['company_name']}
    ], modLayouts.profileRec);

EXPORT dNDRoxieVsRoxie := DATASET([
 	{'ND_WC', ['ND_WC'],	34, 0,	51, 11, 9, 'ND_WC', []} 
], modLayouts.profileRec);

EXPORT dNDThorVsThor := DATASET([
 	{'ND_WC', ['ND_WC'],	34, 0,	51, 2, 2, 'ND_WC', []} 
], modLayouts.profileRec);

EXPORT dNDRoxieVsThor := DATASET([
 	{'ND_WC', ['ND_WC'],	34, 0,	51, 9, 2, 'ND_WC', []} 
], modLayouts.profileRec);


// DEFAULT BASE LINE FOR ALL SOURCES INDIVIDUALLY. DONT CHANGE AND CHECKIN!!
EXPORT dProfileAllDefault := DATASET([
	{'SBFE',['BC'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'CORTERA',['RR'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Dunn Bradstreet', ['D'],	44,  0,	75, 1, 2, 'Header', []}
 ,  {'SOS',MDR.SourceTools.set_CorpV2,	44, 0,	75,	1, 2, 'Header', []}
 ,  {'Experian Business Reports',['ER'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Equifax Business Marketing File', ['Z1'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Bankruptcy',['BA'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Judgement and Liens',['L2'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Business Registrations',['BR'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Duns and Bradstreet FEIN',['DN'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Experian FEIN Unrestricted',['E6'],	44, 0,	75, 1, 2, 'Header', []}
 ,	{'Experian FEIN Restricted',['E5'],	44, 0,	75, 1, 2, 'Header', []}
 ,  {'BUSINESSCREDITREPORT',['T1'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,  {'SMALLBUSINESSANALYTICS', ['T2'], 44, 0,	75, 1, 2, 'Inquiry', []}
 ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,	{'SMALLBUSINESSRISK', ['T4'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,	{'BUSINESSINSTANTID2', ['T5'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,	{'TOPBUSINESS', ['T'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,	{'PREFILL', ['P'],	44, 0,	75, 1, 2, 'Inquiry', []}
 ,	{'BATCH', ['B#'],	44, 0,	75, 1, 2, 'Batch', []} //missing
 ,	{'GARNISH', ['GR'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'SPOKE', ['SP'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'TAXPRO', ['@@'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'THRIVE', ['!!'],	44, 0,	75, 1, 2, 'External', []}//missing
 ,	{'VICKERS13', ['V@'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'VICKERS', ['V#'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'ZOOM', ['ZM'],	44, 0,	75, 1, 2, 'External', []} //missing
 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'MARI_PROF_LICENSE', ['MP'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'SANCTN', ['S@'],	44, 0,	75, 1, 2, 'External', []}
 ,	{'SANCTN_NP', ['M@'],	44, 0,	75, 1, 2, 'External', []}
    ], modLayouts.profileRec);        

// DEFAULT BASE LINE FOR STATS. DONT CHANGE AND CHECKIN!!
EXPORT statProfilesDefault := DATASET([
		 {'Comp_Addr H',ssHeaderAll,	44, 0,	75,	1, 2, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','city','state','zip5']}
		,{'Comp_Fein H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','fein']}
		,{'Comp_Phone H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','phone10']}
		,{'Comp_Email H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','email']}
		,{'Comp_Url H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name','url']}
		,{'Fein H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['fein']}
		,{'Comp H',ssHeaderAll,	44, 0,	75, 1, 2, 'Header',['company_name']}
		,{'Comp_Addr I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','city','state','zip5']}
		,{'Comp_Fein I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','fein']}
		,{'Comp_Phone I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','phone10']}
		,{'Comp_Email I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','email']}
		,{'Comp_Url I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name','url']}
		,{'Fein I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['fein']}
		,{'Comp I',ssInquirySets,	44, 0,	75, 1, 2, 'Inquiry',['company_name']}
    ], modLayouts.profileRec);

EXPORT AllSourcesProfileConfigurable(unsigned inScore = 75, unsigned inWeight = 44, unsigned inDistance = 0, unsigned mode_1 = 1, unsigned mode_2 = 2, set of string filterSet = all) := function
    return DATASET([
        	{'SBFE',['BC'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'CORTERA',['RR'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Dunn Bradstreet', ['D'],	inWeight,  inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,  {'SOS',MDR.SourceTools.set_CorpV2,	inWeight, inDistance,	inScore,	mode_1, mode_2, 'Header', []}
         ,  {'Experian Business Reports',['ER'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Equifax Business Marketing File', ['Z1'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Bankruptcy',['BA'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Judgement and Liens',['L2'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Real Property',MDR.SourceTools.set_LnPropertyV2,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []} 
         ,	{'Business Registrations',['BR'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Duns and Bradstreet FEIN',['DN'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Experian FEIN Unrestricted',['E6'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,	{'Experian FEIN Restricted',['E5'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header', []}
         ,  {'BUSINESSCREDITREPORT',['T1'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,  {'SMALLBUSINESSANALYTICS', ['T2'], inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,  {'SMALLBUSINESSBIPCOMBINEDREPORT', ['T3'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,	{'SMALLBUSINESSRISK', ['T4'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,	{'BUSINESSINSTANTID2', ['T5'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,	{'TOPBUSINESS', ['T'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,	{'PREFILL', ['P'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry', []}
         ,	{'BATCH', ['B#'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'Batch', []} //missing
         ,	{'GARNISH', ['GR'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
         ,	{'SPOKE', ['SP'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
         ,	{'TAXPRO', ['@@'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
         ,	{'THRIVE', ['!!'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}//missing
         ,	{'VICKERS13', ['V@'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
         ,	{'VICKERS', ['V#'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
         ,	{'ZOOM', ['ZM'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []} //missing
				 ,	{'BANKRUPTCY_ATTORNEY', ['BY'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
				 ,	{'MARI_PROF_LICENSE', ['MP'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
				 ,	{'SANCTN', ['S@'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
				 ,	{'SANCTN_NP', ['M@'],	inWeight, inDistance,	inScore, mode_1, mode_2, 'External', []}
            ], modLayouts.profileRec)(srcCategory in filterSet);        
end;

EXPORT StatProfileConfigurable(unsigned inScore = 75, unsigned inWeight = 44, unsigned inDistance = 0, unsigned mode_1 = 1, unsigned mode_2 = 2, set of string filterSet = all) := function
    return DATASET([
		 {'Comp_Addr H',ssHeaderAll,	inWeight, inDistance,	inScore,	mode_1, mode_2, 'Header',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','city','state','zip5']}
		,{'Comp_Fein H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','fein']}
		,{'Comp_Phone H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','phone10']}
		,{'Comp_Email H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','email']}
		,{'Comp_Url H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name','url']}
		,{'Fein H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['fein']}
		,{'Comp H',ssHeaderAll,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Header',['company_name']}
		,{'Comp_Addr I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5']}
		,{'Comp_Addr_Contact I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','contact_fname','contact_mname','contact_lname']}
		,{'Comp_Addr_Fein_Phone I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','prim_range','prim_name','city','state','zip5','phone10','fein']}
		,{'Comp_locale I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','city','state','zip5']}
		,{'Comp_Fein I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','fein']}
		,{'Comp_Phone I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','phone10']}
		,{'Comp_Email I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','email']}
		,{'Comp_Url I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name','url']}
		,{'Fein I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['fein']}
		,{'Comp I',ssInquirySets,	inWeight, inDistance,	inScore, mode_1, mode_2, 'Inquiry',['company_name']}
    ], modLayouts.profileRec)(srcCategory in filterSet);
end;

EXPORT BizLinkFull_ELERT.modLayouts.profileQARec convertToQAFormat(dataset(BizLinkFull_ELERT.modLayouts.profileRec) inRec) := FUNCTION
		   sfRecs := normalize(inRec, count(left.srcfilters), 
								           transform({recordof(left); string srcFilter}, 
														          self.srcFilter := map(counter = 1 and counter = count(left.srcfilters) => '[\''+ left.srcfilters[counter]+'\']',
																			                      counter = 1  => '[\''+ left.srcfilters[counter]+'\'',
																			                      counter = count(left.srcfilters) =>',\''+ left.srcfilters[counter]+'\']',
																															',\''+ left.srcfilters[counter]+'\'');
																			self := left));
       
		   sfRecsRoll := rollup(sfRecs,	left.srcCategory=right.srcCategory,  
			                      transform(recordof(left),
																			self.srcFilter := trim(left.srcFilter + right.srcFilter,left,right);
																			self           := left));
																						
			 return project(sfRecsRoll, BizLinkFull_ELERT.modLayouts.profileQARec);
							
		END;
END;	
