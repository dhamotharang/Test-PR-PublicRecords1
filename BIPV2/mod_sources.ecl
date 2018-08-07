// mod_sources
// 1. various ways to retrieve a bitmap corresponding to one or more sources
// 2. lists of sources included in header, and partitioned vs. citizen

import MDR, ut, AutoStandardI;

export mod_sources := module
	
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// 1. various ways to retrieve a bitmap corresponding to one or more sources
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	
	// Terms:
	//
	// src - a source is the two-character source value as defined in MDR.sourceTools
	// code - an enumerated type defined below representing each of the restrictable sources we care about
	// bmap - a bitmap representation of a set of zero to many codes
	
	export code := enum(
		UNRESTRICTED=0,	// 1
		DNB,						// 2
		EBR,						// 4
		DPPA,						// 8
		PROP_FARES,			// 16
		PROP_FIDELITY,	// 32
		PROP_DAYTON,    // 64
  MV_INFUTOR,			// 128
  WC_INFUTOR,			// 256
  MARKETING_UNRESTRICTED // 512
		);
	
	
	// The first character of a ln_fares_id (a.k.a. fid) has a value of R, O, or D which tells us
	// whether the property record is "Fares", "Fidelity" or "Dayton".  This is valuable information
	// when determining data restrictions, because the source value alone doesn't differentiate
	// between the "O" and "D" records.
	//
	// Property records in the BIP2 header don't have a distinct field for the fid, but fid does help
	// form the vl_id field via the following construct:
	//
	//   SELF.vl_id := pSearch.source_code[1..2] + TRIM(pSearch.vendor_source_flag) + pSearch.ln_fares_id[1..12];
	//
	// This section of code manages conversions among these field variations so we can apply restrictions.
	//
	export boolean	isDayton_vlid(string vlid)	:= vlid[4]='D'; // skip over 3 characters to find the one we want
	export string15	faux_vlid(string12 fid)			:= '---' + fid; // left-pad with 3 irrelevant characters
	
	
	export unsigned exlusiveSrc2code(string2 src, string34 vl_id='') := map(
		MDR.sourceTools.SourceIsDPPA(src)									=> code.DPPA,
		MDR.sourceTools.SourceIsDunn_Bradstreet(src)			=> code.DNB,
		MDR.sourceTools.SourceIsEBR(src)									=> code.EBR,
		MDR.sourceTools.SourceIsLnPropV2_Fares_Asrs(src)	=> code.PROP_FARES, // a subset of SourceIsProperty
		MDR.sourceTools.SourceIsLnPropV2_Fares_Deeds(src)	=> code.PROP_FARES, // a subset of SourceIsProperty
		MDR.sourceTools.SourceIsProperty(src)							=> if(isDayton_vlid(vl_id), code.PROP_DAYTON, code.PROP_FIDELITY),
    MDR.sourceTools.SourceIsInfutor_All_Veh(src)      => code.MV_INFUTOR,
    MDR.sourceTools.SourceIsInfutor_Watercraft(src)   => code.WC_INFUTOR,
		code.UNRESTRICTED);
		
	export unsigned code2bmap(code c) := ut.bit_set(0,(unsigned)c);
	
 export unsigned inclusiveSrc2bmap (string2 src) :=  if(src in MDR.sourceTools.set_Marketing_Restricted, 0, code2bmap(code.MARKETING_UNRESTRICTED));
              
	export unsigned src2bmap(string2 src, string34 vl_id='') := code2bmap(exlusiveSrc2code(src,vl_id)) | inclusiveSrc2bmap(src); // called by SALT - becomes *_data_permits
	
	shared l_code	:= {code c};
	shared l_src	:= {string2 src};
	shared s_code	:= set of code;
	shared s_src	:= set of string2;
	
	export code2bmap_multi(s_code s) := function
		l_tmp	:= {l_code; unsigned bmap;};
		tmp		:= project(dataset(s,l_code), transform(l_tmp, self.bmap:=code2bmap(left.c), self:=left));
		roll	:= rollup(tmp, true, transform(l_tmp, self.bmap:=left.bmap|right.bmap, self:=[]));
		return if(exists(s), roll[1].bmap, 0);
	end;
	
	
	// ---------------------------------
	// Runtime Code
	// ---------------------------------
	
	export iParams := interface(
		AutoStandardI.DataRestrictionI.params,
		AutoStandardI.PermissionI_Tools.params,
		AutoStandardI.InterfaceTranslator.ln_branded_value.params)
	end;
	
	export in_mod_values(iParams in_mod, boolean dnbWillMask=false) := module
		export DRM				:= AutoStandardI.DataRestrictionI.val(in_mod);
		export GLB				:= AutoStandardI.PermissionI_Tools.val(in_mod).GLB;
		export DPPA				:= AutoStandardI.PermissionI_Tools.val(in_mod).DPPA;
		export AllowAll		:= AutoStandardI.PermissionI_Tools.val(in_mod).AllowAll_value;
		export LnBranded	:= AutoStandardI.InterfaceTranslator.ln_branded_value.val(in_mod);
		
		// Potential issue...
		// - Is it OK that we're not using DPPA.state_ok? We don't know the source in aggregates like best.
		export my_bmap 		:= code2bmap_multi(
			[code.UNRESTRICTED]
			+ if(AllowAll OR dnbWillMask, [code.DNB], [])
			+ if(~DRM.EBR, [code.EBR], [])
			+ if(DPPA.ok(DPPA.stored_value), [code.DPPA], [])
			+ if(~DRM.FARES, [code.PROP_FARES], [])
			+ if(~DRM.Fidelity, [code.PROP_FIDELITY], [])
			+ if(~DRM.Fidelity AND LnBranded, [code.PROP_DAYTON], [])
			+ if(~DRM.InfutorMV AND DPPA.ok(DPPA.stored_value), [code.MV_INFUTOR], [])
			+ if(~DRM.InfutorWC AND DPPA.ok(DPPA.stored_value), [code.WC_INFUTOR], [])
		);
	end;

	// When caller sets dnbWillMask=true, he must also apply DNB masking to the resulting records!
	export isPermitted(iParams in_mod, boolean dnbWillMask=false) := module
	
		shared ivals := in_mod_values(in_mod, dnbWillMask);
		
		// inspired by TopBusiness_Services.Functions
		export boolean bySource(string2 src, string34 vl_id='',unsigned4 dt_first_seen=0) := function
      // Had to glb separetly as it's not mutually exclusive with the others
      boolean glb := ivals.GLB.ok(in_mod.GLBPurpose) OR ivals.GLB.HeaderIsPreGLB(0,dt_first_seen,src);
      
      boolean other_restrictions := case(
                                          exlusiveSrc2code(src,vl_id),
                                          code.DPPA						=> ivals.DPPA.state_ok(MDR.SourceTools.DPPAOriginState(src),ivals.DPPA.stored_value,,src),
                                          code.DNB						=> ivals.AllowAll OR dnbWillMask,
                                          code.EBR						=> ~ivals.DRM.EBR,
                                          code.PROP_FARES			=> ~ivals.DRM.FARES,
                                          code.PROP_FIDELITY	=> ~ivals.DRM.Fidelity,
                                          code.PROP_DAYTON		=> ivals.LnBranded AND ~ivals.DRM.Fidelity,
                                          code.MV_INFUTOR     => ~ivals.DRM.InfutorMV AND ivals.DPPA.ok(ivals.DPPA.stored_value),
                                          code.WC_INFUTOR     => ~ivals.DRM.InfutorWC AND ivals.DPPA.ok(ivals.DPPA.stored_value),
                                          true
                                        );
      return glb and other_restrictions;
    end;
    
		export boolean byBmap(unsigned rec_bmap) := function
			// rec_bmap indicates which sources contributed to the best value
			// my_bmap indicates which sources I'm allowed to see
			return ivals.AllowAll OR (rec_bmap&ivals.my_bmap <> 0);
		end;
		
	end;
	
	// Set a field if it exists -- useful in transforms with indeterminate layouts
	EXPORT setField(ds,rec,fld,fld_exclude='') := MACRO
		// IMPORT ut;
		#UNIQUENAME(fldExists);
		#UNIQUENAME(fldExcludes);
		ut.hasField(ds, fld, %fldExists%);
		#IF(#TEXT(fld_exclude)='')
			%fldExcludes% := false;
		#ELSE
			ut.hasField(ds, fld_exclude, %fldExcludes%);
		#END
		#IF(%fldExists% AND (#TEXT(fld_exclude)='' OR NOT %fldExcludes%))
			SELF.fld := rec.fld;
		#END
	ENDMACRO;
	
	// Apply masking to DNB_DMI records with indeterminate layout -- I've named/written this somewhat
	// generically so we can potentially extend it to additional sorts of masking in the future
	EXPORT applyMasking(ds0, in_mod, permitField='', srcField='source') := FUNCTIONMACRO
		IMPORT MDR, BIPV2, AutoStandardI, ut;
		MaskSources	:= MDR.sourceTools.set_Dunn_Bradstreet;
		MaskPermits := BIPV2.mod_sources.code2bmap(BIPV2.mod_sources.code.DNB);
		ivals 			:= BIPV2.mod_sources.in_mod_values(in_mod, true);
		
		ds := ds0; // resolves some strange syntax errors
		
		#IF(#TEXT(permitField)<>'')
			no_mask		:= IF(ivals.AllowAll, ds, ds(permitField&ivals.my_bmap&BNOT(MaskPermits) <> 0));
			yes_mask	:= IF(ivals.AllowAll, DATASET([],RECORDOF(ds)), ds(permitField&ivals.my_bmap&BNOT(MaskPermits) = 0));
		#ELSEIF(#TEXT(srcField)<>'')
			no_mask		:= IF(ivals.AllowAll, ds, ds(srcField NOT IN MaskSources));
			yes_mask	:= IF(ivals.AllowAll, DATASET([],RECORDOF(ds)), ds(srcField IN MaskSources));
		#ELSE
			dummy('Cannot compile because we require permitField or srcField.');
		#END
		
		ds doMask(ds L) := TRANSFORM
			// We retain some infrastructure fields
			BIPV2.mod_sources.setField(ds,L,rcid);
			BIPV2.mod_sources.setField(ds,L,dotid);
			BIPV2.mod_sources.setField(ds,L,proxid);
			BIPV2.mod_sources.setField(ds,L,lgid3);
			BIPV2.mod_sources.setField(ds,L,powid);
			BIPV2.mod_sources.setField(ds,L,empid);
			BIPV2.mod_sources.setField(ds,L,orgid);
			BIPV2.mod_sources.setField(ds,L,ultid);
			BIPV2.mod_sources.setField(ds,L,seleid);
			BIPV2.mod_sources.setField(ds,L,ultimate_Proxid);
			BIPV2.mod_sources.setField(ds,L,sele_Proxid);
			BIPV2.mod_sources.setField(ds,L,parent_Proxid);
			BIPV2.mod_sources.setField(ds,L,org_Proxid);		
      BIPv2.mod_sources.setField(ds,L,sources); // this will allow source information to be seen.
			
			BIPV2.mod_sources.setField(ds,L,company_name_data_permits);
			BIPV2.mod_sources.setField(ds,L,company_name_method);
			BIPV2.mod_sources.setField(ds,L,company_address_data_permits);
			BIPV2.mod_sources.setField(ds,L,company_address_method);
			BIPV2.mod_sources.setField(ds,L,cnp_name); // for use in internal cname dedup/comparision only not for 
			                                         // customer display.
			
			// And retain a few fields for customer display
			BIPV2.mod_sources.setField(ds,L,company_name);
			BIPV2.mod_sources.setField(ds,L,company_phone);
			BIPV2.mod_sources.setField(ds,L,v_city_name);
			BIPV2.mod_sources.setField(ds,L,address_v_city_name);
			BIPV2.mod_sources.setField(ds,L,st);
			BIPV2.mod_sources.setField(ds,L,company_st);
		
			
			// All other fields are masked
			SELF := [];
		END;
		
		RETURN no_mask + PROJECT(yes_mask, doMask(LEFT));
	ENDMACRO;
	
	
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// 2. lists of sources included in header, and partitioned vs. citizen
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// This is the "master list" of sources included in the BIPv2 header,
	// mapped to a short code suitable for matching.  If a source isn't listed
	// here it will NOT be allowed into the internal linking process.
  import bipv2_tools;
  export string2 nonCode := 'xx';

  export ingest_whitelist := 
      MDR.sourceTools.set_BBB                   
    + MDR.sourceTools.set_BK   
    + MDR.sourceTools.set_Business_Credit       //sbfe
    + MDR.sourceTools.set_Business_Registration 
    + MDR.sourceTools.set_CA_Sales_Tax          
    + MDR.sourceTools.set_CClue          
    + MDR.sourceTools.set_CorpV2                
    + MDR.sourceTools.set_Credit_Unions        
    + MDR.sourceTools.set_DCA                   
    + MDR.sourceTools.set_Dea                  
    + MDR.sourceTools.set_Dunn_Bradstreet      
    + MDR.sourceTools.set_Dunn_Bradstreet_Fein 
    + MDR.sourceTools.set_EBR                  
    + MDR.sourceTools.set_Experian_CRDB        
    + MDR.sourceTools.set_Experian_FEIN        
    + MDR.sourceTools.set_FAA                   
    + MDR.sourceTools.set_FBNV2                
    + MDR.sourceTools.set_FDIC                 
    + MDR.sourceTools.set_Frandx               
    + MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ 
    + MDR.sourceTools.set_IRS_5500              
    + MDR.sourceTools.set_IRS_Non_Profit       
    + MDR.sourceTools.set_Liens_v2             
    + MDR.sourceTools.set_LnPropertyV2         
    + MDR.sourceTools.set_OSHAIR                
    + MDR.sourceTools.set_TXBUS                 
    + MDR.sourceTools.set_UCCV2                
    + MDR.sourceTools.set_Vehicles             
    + MDR.sourceTools.set_WC                   
    + MDR.sourceTools.set_Workers_Compensation 
    + MDR.sourceTools.set_Yellow_Pages         
    + MDR.sourceTools.set_Cortera         
  ;
  
  // -- ingest_blacklist
  // -- not used anywhere, just nice to keep track of sources filtered out of ingest
  export ingest_blacklist :=
		  MDR.sourceTools.set_CrashCarrier   
		+ MDR.sourceTools.set_Gong                  
		+ MDR.sourceTools.set_INFOUSA_DEAD_COMPANIES
		+ MDR.sourceTools.set_Prolic                
		+ MDR.sourceTools.set_SKA                   
		+ MDR.sourceTools.set_Utilities             
    + MDR.sourceTools.set_ZOOM                    
    ;
    
  // export src2numcode2(string2 src) := BIPV2_Tools.mac_source2code(ingest_whitelist,nonCode);
  // export boolean srcInBIPV2Header2(string2 src) := src in ingest_whitelist;

  // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// 2a. lists of sources allowed in bipv2.commonbase.ds_clean for downstream processes
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  export base_whitelist := 
      MDR.sourceTools.set_BBB                   
    + MDR.sourceTools.set_BK            
    + MDR.sourceTools.set_Business_Registration 
    + MDR.sourceTools.set_CA_Sales_Tax          
    + MDR.sourceTools.set_CorpV2                
    + MDR.sourceTools.set_Credit_Unions        
    + MDR.sourceTools.set_DCA                   
    + MDR.sourceTools.set_Dea                  
    + MDR.sourceTools.set_Dunn_Bradstreet      
    + MDR.sourceTools.set_Dunn_Bradstreet_Fein 
    + MDR.sourceTools.set_EBR                  
    + MDR.sourceTools.set_Experian_CRDB        
    + MDR.sourceTools.set_Experian_FEIN        
    + MDR.sourceTools.set_FAA                   
    + MDR.sourceTools.set_FBNV2                
    + MDR.sourceTools.set_FDIC                 
    + MDR.sourceTools.set_Frandx               
    + MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ 
    + MDR.sourceTools.set_IRS_5500              
    + MDR.sourceTools.set_IRS_Non_Profit       
    + MDR.sourceTools.set_Liens_v2             
    + MDR.sourceTools.set_LnPropertyV2         
    + MDR.sourceTools.set_OSHAIR                
    + MDR.sourceTools.set_TXBUS                 
    + MDR.sourceTools.set_UCCV2                
    + MDR.sourceTools.set_Vehicles             
    + MDR.sourceTools.set_WC                   
    + MDR.sourceTools.set_Workers_Compensation 
    + MDR.sourceTools.set_Yellow_Pages                  
    + MDR.sourceTools.set_Cortera                 
  ;

  export base_blacklist :=
      MDR.sourceTools.set_Business_Credit       //sbfe
  	+ MDR.sourceTools.set_CClue                 
		+ MDR.sourceTools.set_CrashCarrier   
		+ MDR.sourceTools.set_Gong                  
		+ MDR.sourceTools.set_INFOUSA_DEAD_COMPANIES
		+ MDR.sourceTools.set_Prolic                
		+ MDR.sourceTools.set_SKA                   
		+ MDR.sourceTools.set_Utilities             
    + MDR.sourceTools.set_ZOOM                    
    ;
  export boolean srcInBase(string2 src) := src in base_whitelist;

  // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// 2b. lists of sources allowed in bipv2.commonbase.ds_xlink for use in xlink keys(minus the payload key)
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  export xlink_whitelist := 
      base_whitelist                   
    + MDR.sourceTools.set_Business_Credit       // sbfe
  	+ MDR.sourceTools.set_CClue                 // commercial clue
  ;

  export boolean srcInXlink(string2 src) := src in xlink_whitelist;

  // =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	// 2c. lists of sources not allowed to come from BIPV2.File_Business_Sources and into BIPV2_Build.key_contact_linkids
	// =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  export contacts_key_blacklist := 
      MDR.sourceTools.set_CClue
    + MDR.sourceTools.set_Business_Credit //sbfe
    + mdr.sourcetools.set_zoom
  ;

  export boolean srcInContacts_Key(string2 src) := not srcInBase(src) and src not in contacts_key_blacklist;

	// export string2 nonCode := 'xx';
	export string2 src2numCode(string2 src) := 
  map(
		MDR.sourceTools.SourceIsBusiness_Registration (src)	=> '01', // a.k.a. Accutrend
		MDR.sourceTools.SourceIsCorpV2                (src)	=> '02', // a.k.a. Corp SOS
		MDR.sourceTools.SourceIsDCA                   (src)	=> '03', // a.k.a. LNCA
		MDR.sourceTools.SourceIsDunn_Bradstreet       (src)	=> '04', // a.k.a. DNB_DMI
		MDR.sourceTools.SourceIsDunn_Bradstreet_Fein  (src)	=> '05', // a.k.a. DNB_FEIN
		MDR.sourceTools.SourceIsEBR                   (src)	=> '06',
		MDR.sourceTools.SourceIsFBNV2                 (src)	=> '07', // a.k.a. Fictional Business
		MDR.sourceTools.SourceIsFrandx                (src)	=> '08',
		// MDR.sourceTools.SourceIsGong                  (src) => '09',
		MDR.sourceTools.SourceIsYellow_Pages          (src) => '10',
		MDR.sourceTools.SourceIsBBB                   (src) => '11',
		MDR.sourceTools.SourceIsCA_Sales_Tax          (src) => '12',
		MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ  (src) => '13',
		MDR.sourceTools.SourceIsIRS_5500              (src) => '14',
		MDR.sourceTools.SourceIsLiens_v2              (src) => '15', // a.k.a. Judgements
		MDR.sourceTools.SourceIsLnPropertyV2          (src) => '16',
		MDR.sourceTools.SourceIsOSHAIR                (src) => '17',
		// MDR.sourceTools.SourceIsProlic                (src) => '18',
		MDR.sourceTools.SourceIsTXBUS                 (src) => '19',
		MDR.sourceTools.SourceIsUCCV2                 (src) => '20',
		// MDR.sourceTools.SourceIsUtilities             (src) => '21',
		MDR.sourceTools.SourceIsVehicle               (src) => '22',
		// MDR.sourceTools.SourceIsZOOM                  (src) => '23',
		MDR.sourceTools.SourceIsBankruptcy            (src) => '24',
		// MDR.sourceTools.SourceIsSKA                   (src) => '25',
		MDR.sourceTools.SourceIsCredit_Unions         (src) => '26',
		MDR.sourceTools.SourceIsDea                   (src) => '27',
		MDR.sourceTools.SourceIsFAA                   (src) => '28', // a.k.a. Aircraft
		MDR.sourceTools.SourceIsIRS_Non_Profit        (src) => '29', // a.k.a. IRS 990
		// MDR.sourceTools.SourceIsINFOUSA_DEAD_COMPANIES(src) => '30',
		MDR.sourceTools.SourceIsExperian_FEIN         (src) => '31',
		MDR.sourceTools.SourceIsWC                    (src) => '32',
		MDR.sourceTools.SourceIsFDIC                  (src) => '33',
		MDR.sourceTools.SourceIsWorkers_Compensation  (src) => '34',
		// MDR.sourceTools.SourceIsCrashCarrier          (src) => '35',
		MDR.sourceTools.SourceIsExperian_CRDB         (src) => '36',
		MDR.sourceTools.SourceIsCClue                 (src) => '37',
		MDR.sourceTools.SourceIsBusiness_Credit       (src) => '38',
		MDR.sourceTools.SourceIsCortera               (src) => '39',
		nonCode
	);
	export boolean srcInBIPV2Header(string2 src) := src2numCode(src) <> nonCode;
	
	// This is a subset of the sources listed above that have been determined
	// to be of sufficient veracity to be considered a "citizen" -- their data
	// can be propagated, included in best keys, etc.
	// STUB - update comments to reflect diff between trusted and citizen
	
	export set_Trusted :=
		MDR.sourceTools.set_CorpV2
		+ MDR.sourceTools.set_DCA
		+ MDR.sourceTools.set_FBNV2
		+ MDR.sourceTools.set_Dunn_Bradstreet_Fein // a.k.a. DNB_FEIN
		+ MDR.sourceTools.set_EBR
		+ MDR.sourceTools.set_Business_Registration
		+ MDR.sourceTools.set_Dunn_Bradstreet // a.k.a. DNB_DMI
		+ MDR.sourceTools.set_Frandx;

	// This list will expand as partitioned sources prove their veracity
	export set_Citizen := [
		set_Trusted
		,MDR.sourceTools.set_UCCV2					// S2
		,MDR.sourceTools.set_Liens_v2				// S7
		,MDR.sourceTools.set_Experian_FEIN	// S16
		,MDR.sourceTools.set_IRS_5500				// S18
		,MDR.sourceTools.set_TXBUS					// S18
		,MDR.sourceTools.set_Experian_CRDB	// S27
    ,MDR.sourceTools.set_Business_Credit// S31
	];

	// These sources participate in the header build, but are excluded
	// before the header goes downstream for key builds, etc.
	export set_Excluded := [
		MDR.sourceTools.set_CClue //make sure to exclude this from keybuilds for now.
	];
	
	export boolean srcIsTrusted(string2 src) := src in set_Trusted;
	export boolean srcIsCitizen(string2 src) := src in set_Citizen;
	export boolean srcIsExcluded(string2 src) := src in set_Excluded;
	
	
	// Sources with lower or unknown veracity can still be included as
	// a probationary source -- the logic to implement that requires
	// the "partition" value defined here
	export string4 src2partition(string2 src) := if(srcIsCitizen(src), '', src2numCode(src));
	// export string4 src2partition2(string2 src) := if(srcIsCitizen(src), '', src2numCode2(src));
	
	
	// We tend to care about our sources in aggregate, and sometimes want to report them that way
	export TranslateSource_aggregate(string2 pSource) := map(
		MDR.sourceTools.SourceIsBBB(pSource)					=> 'BBB',
		MDR.sourceTools.SourceIsCorpV2(pSource)				=> 'CorpV2',
		MDR.sourceTools.SourceIsFBNV2(pSource)				=> 'FBNV2',
		MDR.sourceTools.SourceIsGong(pSource)					=> 'Gong',
		MDR.sourceTools.SourceIsLnPropertyV2(pSource)	=> 'LnPropertyV2',
		MDR.sourceTools.SourceIsVehicle(pSource)			=> 'Vehicle',
		MDR.sourceTools.SourceIsWC(pSource)						=> 'Watercraft',
		MDR.sourceTools.SourceIsExperian_FEIN(pSource)	=> 'Experian FEIN',
		MDR.sourceTools.SourceIsLiquor_Licenses (pSource)	=> 'Liquor Licenses',
		MDR.sourceTools.SourceIsDL              (pSource)	=> 'Drivers Licenses',
		MDR.sourceTools.SourceIsDeath           (pSource)	=> 'Death',
		MDR.sourceTools.SourceIsEmerges         (pSource)	=> 'Emerges',
		pSource in MDR.sourceTools.set_Utility_sources	=> 'Utility',
		MDR.sourceTools.SourceIsWorkmans_Comp   (pSource)	=> 'Workmans Comp',
		MDR.sourceTools.SourceIsLiens           (pSource)	=> 'Liens',
		MDR.sourceTools.SourceIsState_Sales_Tax (pSource)	=> 'State Sales Tax',
		pSource in (MDR.sourceTools.set_Foreclosures_Delinquent + MDR.sourceTools.set_Foreclosures)	=> 'Foreclosures',
		pSource in (MDR.sourceTools.set_SDA + MDR.sourceTools.set_SDAA)	=> 'SDA & SDAA',
		// NOTE: this isn't a complete list yet (e.g. Drivers)
		MDR.sourceTools.TranslateSource(pSource)
	);
	shared code2src1(string2 code) := case(code,
		'01' => MDR.sourceTools.set_Business_Registration[1],
		'02' => MDR.sourceTools.set_CorpV2[1],
		'03' => MDR.sourceTools.set_DCA[1],
		'04' => MDR.sourceTools.set_Dunn_Bradstreet[1],
		'05' => MDR.sourceTools.set_Dunn_Bradstreet_Fein[1],
		'06' => MDR.sourceTools.set_EBR[1],
		'07' => MDR.sourceTools.set_FBNV2[1],
		'08' => MDR.sourceTools.set_Frandx[1],
		'09' => MDR.sourceTools.set_Gong[1],
		'10' => MDR.sourceTools.set_Yellow_Pages[1],
		'11' => MDR.sourceTools.set_BBB[1],
		'12' => MDR.sourceTools.set_CA_Sales_Tax[1],
		'13' => MDR.sourceTools.set_INFOUSA_ABIUS_USABIZ[1],
		'14' => MDR.sourceTools.set_IRS_5500[1],
		'15' => MDR.sourceTools.set_Liens_v2[1],
		'16' => MDR.sourceTools.set_LnPropertyV2[1],
		'17' => MDR.sourceTools.set_OSHAIR[1],
		'18' => MDR.sourceTools.set_Prolic[1],
		'19' => MDR.sourceTools.set_TXBUS[1],
		'20' => MDR.sourceTools.set_UCCV2[1],
		'21' => MDR.sourceTools.set_Utilities[1],
		'22' => MDR.sourceTools.set_Vehicles[1],
		'23' => MDR.sourceTools.set_ZOOM[1],
		'24' => MDR.sourceTools.set_bk[1],
		'25' => MDR.sourceTools.set_SKA[1],
		'26' => MDR.sourceTools.set_Credit_Unions[1],
		'27' => MDR.sourceTools.set_Dea[1],
		'28' => MDR.sourceTools.set_FAA[1],
		'29' => MDR.sourceTools.set_IRS_Non_Profit[1],
		'30' => MDR.sourceTools.set_INFOUSA_DEAD_COMPANIES[1],
		'31' => MDR.sourceTools.set_Experian_FEIN[1],
		'32' => MDR.sourceTools.set_WC[1],
		'33' => MDR.sourceTools.set_FDIC[1],
		'34' => MDR.sourceTools.set_Workers_Compensation[1],
		'35' => MDR.sourceTools.set_CrashCarrier[1],
		'36' => MDR.sourceTools.set_Experian_CRDB[1],
		'37' => MDR.sourceTools.set_CClue[1],
		'39' => MDR.sourceTools.set_Cortera[1],
		nonCode
	);
	export TranslateCode(string2 code) := TranslateSource_aggregate(code2src1(code));
	
	export string1 srcType(string2 src) := map(
		srcIsTrusted(src) or srcIsCitizen(src) => 'A',
		srcInBIPV2Header(src) => 'B',
		''
	);
	
	export string1 codeType(string2 code) := srcType(code2src1(code));

end;