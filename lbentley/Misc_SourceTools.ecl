import lbentley,mdr;
export Misc_SourceTools :=
module

	export fGenerateSourceTools(
	
		 boolean																			pUseNewCodes 	= true
		,dataset(sourceTools.layout_description			) pSourceCodes	= lbentley.oldsourceTools.dSource_Codes_proj
		,dataset(Align_These_Sources.layout_mapping	) pAlignCodes		= lbentley.Align_These_Sources.dSources				
	
	) := 
	function
	
		dSourcecodes := pSourceCodes;
		
		dExtraOldSources := dataset([
			 {'AW','Watercraft'     }
			,{'AF','Atf'            }
			,{'B ','Bankruptcy2'    }
			,{'DE','DEA2'           }
			,{'FA','Aircrafts2'     }
			,{'PR','OldProp'        }
			,{'WC','MS_Worker_Comp2'}
		], oldsourceTools.layout_description);
		
		dExtraSource := dataset([
			 {'WH','WH_src'     }
		], oldsourceTools.layout_description);

		dAllSourceCodes :=	dSourcecodes + dExtraSource
											+ if(pUseNewCodes = false,dExtraOldSources, dataset([], oldsourceTools.layout_description) );
											
		dSourcecodeChanges := pAlignCodes;
		
		setChangesThatAddNewCodes := ['AW','AF','B ','DE','FA','PR','WC','AE','MV'];
		//remove the codes that add new symbolic references since that has already been done
		//rest of these will be translated to old codes
		dSourcecodeChanges_filter := dSourcecodeChanges(old_code not in setChangesThatAddNewCodes);
		
		//these are old business header source codes that duplicate header ones(that we are in the process of changing)
		//we need them for translating back and forth, but not to create the ecl code(we only want one refernce to each code) 
		exceptions := ['LN Property','Property File','Experian Vehicles','Motor Vehicles'];
		
		string100 tempstring100 := ' ';
		string30  tempstring30  := ' ';
		string60  tempstring60  := ' ';
		string36  tempstring36  := ' ';
		
		mylayout :=
		record
			unsigned8 uid					;
			string30	varname			;
			string		eclcode			;
			string		code				;
			string		description	;
		end;
		
		ecllayout :=
		record, maxlength(20000)
			string		eclcode			;
		end;

		// -----------------------------------------
		// -- Create code for Symbolic References to codes
		// -----------------------------------------
		mylayout tCreateSymbolicReferences(dSourcecodes l, unsigned8 cnt) :=
		transform
			//clean up descriptions, make smaller for variable names
			temp		:= trim(l.description);
			temp1		:= StringLib.StringFindReplace(temp		,'A corrections/override (used in FCRA products) record'	,'FCRA Corrections record'	);
			temp2		:= StringLib.StringFindReplace(temp1	,'ACF - America\'s Corporate Financial Directory'					,'ACF'											);
			temp3		:= StringLib.StringFindReplace(temp2	,'SDA - Standard Directory of Advertisers'								,'SDA'											);
			temp4		:= StringLib.StringFindReplace(temp3	,'SDAA - Standard Directory of Ad Agencies'								,'SDAA'											);
			temp5		:= StringLib.StringFindReplace(temp4	,'Texas Sales Tax Registrations(TXBUS)'										,'TXBUS'										);
			temp6		:= StringLib.StringFindReplace(temp5	,'Ingenix National Provider Sanctions'										,'Ingenix_Sanctions'				);
			temp7		:= StringLib.StringFindReplace(temp6	,'Appended phone from gong file'													,'Gong phone append'				);
			temp8		:= StringLib.StringFindReplace(temp7	,'Domain Registrations (WHOIS)'														,'Whois domains'						);
			temp9		:= StringLib.StringFindReplace(temp8	,'Redbooks International Advertisers'											,'Redbooks'									);
			temp10	:= StringLib.StringFindReplace(temp9	,'LN_Propertyv2'																					,'LnPropV2'									);
			temp11	:= StringLib.StringFindReplace(temp10	,'Better Business Bureau'																	,'BBB'											);
			temp12	:= StringLib.StringFindReplace(temp11	,'ATF Firearms and Explosives'														,'ATF'											);
			temp13	:= StringLib.StringFindReplace(temp12	,'California'																							,'CA'												);
			temp14	:= StringLib.StringFindReplace(temp13	,'Conneticut'																							,'CT'												);
			temp15	:= StringLib.StringFindReplace(temp14	,'Indiana'																								,'IN'												);
			temp16	:= StringLib.StringFindReplace(temp15	,'Louisana'																								,'LA'												);
			temp17	:= StringLib.StringFindReplace(temp16	,'New Jersey'																							,'NJ'												);
			temp18	:= StringLib.StringFindReplace(temp17	,'Ohio'																										,'OH'												);
			temp19	:= StringLib.StringFindReplace(temp18	,'Pennsylvania'																						,'PA'												);
			temp20	:= StringLib.StringFindReplace(temp19	,'Texas'																									,'TX'												);
			temp21	:= StringLib.StringFindReplace(temp20	,'Florida'   																							,'FL'												);
			temp22	:= StringLib.StringFindReplace(temp21	,'Infousa'   																							,'INF'											);
			temp23	:= StringLib.StringFindReplace(temp22	,'New_York'  																							,'NY'												);
			temp24	:= StringLib.StringFindReplace(temp23	,'Iowa'  																									,'IA'												);
			temp25	:= StringLib.StringFindReplace(temp24	,'Assessors'          																		,'Asrs'											);
			temp26	:= StringLib.StringFindReplace(temp25	,'and Mortgages'																					,'Mtgs'											);
			temp27	:= StringLib.StringFindReplace(temp26	,'Medical Information Directory'													,'AMIDIR'										);
			temp28	:= StringLib.StringFindReplace(temp27	,'SK&A Medical Professionals'															,'SKA'											);
			temp29	:= StringLib.StringFindReplace(temp28	,'AK Commercial Fishing Vessels'													,'AK_Fishing_boats'					);
			temp30	:= StringLib.StringFindReplace(temp29	,'Alaska Business Registrations'													,'AK_Busreg'								);
			temp31	:= StringLib.StringFindReplace(temp30	,'Experian Business Reports'															,'EBR'											);
			temp32	:= StringLib.StringFindReplace(temp31	,'Foreclosures - Notice of Delinquency'										,'Foreclosures Delinquent'	);
			temp33	:= StringLib.StringFindReplace(temp32	,'Historical Choicepoint'																	,'Hist Choicepoint'					);
			temp34	:= StringLib.StringFindReplace(temp33	,'American Correctional Association'											,'ACA'											);
			temp35	:= regexreplace('[ ()-/.,\'&]'			,temp34	,'_'	);
			temp36	:= regexreplace('[_]+'							,temp35	,'_'	);
			temp37	:= regexreplace('^(.*?)[_]$'				,temp36	,'$1'	);
			temp38	:= regexreplace('^.*?(FBNV2.*)$'		,temp37	,'$1'	,nocase);
			temp39	:= regexreplace('^.*?(Liens_v2.*)$'	,temp38	,'$1'	,nocase);

			string2 lcode := if(pUseNewCodes = true or count(dSourcecodeChanges_filter(l.code in new_codes)) = 0
				,l.code
				,dSourcecodeChanges_filter(l.code in new_codes)[1].old_code
			);
			
			self.uid			:= cnt;
			self.varname	:= if(trim(l.description) = 'WH_src', 'WH_src',
												'src_'
											+ temp39
											)
											;
			self.eclcode := 'export ' 
											+ trim(self.varname)
											+ tempstring36[(length(trim(self.varname)) + 8)..] 
											+ ' := \''
											+ regexreplace('\\\\',trim(lcode),'\\\\\\')
											+ if(length(trim(lcode)) = 2, '\';',' \';')
											;
			self.code			:= l.code;
			self.description := l.description;
		
		
		end;
		
		dSourcecodes_code := project(dAllSourceCodes(trim(description) not in exceptions)
													,tCreateSymbolicReferences(left,counter));
		dSourcecodes_code_justnew := project(dSourceCodes(trim(description) not in exceptions)
													,tCreateSymbolicReferences(left,counter));

		dwh_src := dSourcecodes_code(trim(varname) = 'WH_src');

		dSourcecodes_code_deduped := sort(if(pUseNewCodes, dedup(dSourcecodes_code(trim(varname) != 'WH_src'), code,all), dSourcecodes_code(trim(varname) != 'WH_src')), uid);
		dSourcecodes_code_deduped_only := sort(dedup(dSourcecodes_code_justnew(trim(varname) != 'WH_src'), code,all), uid);
		
		fAddSourcesToSet(set of string pSourceSet,boolean pIsBusinessHeader = true) :=
		function
		
			countpSourceSet := count(pSourceSet);

			dpSourceSet := normalize(dataset([''],{string crap})
																		,countpSourceSet
																		,transform({string code}
																			,self.code := pSourceSet[counter];
																		)
												);
			dDedupSet		:= dedup(dpSourceSet, code,all);
			
			dFilter := dDedupSet(code not in ['FB','FA','FP','LA']);

			dBacktoset := set(dFilter, code);
			
			dreturnset := if(pIsBusinessHeader = true,dBacktoset, pSourceSet);

			return dreturnset + ['AW','AF','PR','DE','FA','B '];
		
		
		end;


		set_faa								:= oldsourceTools.set_faa								+ if(pUseNewCodes, [],['FA']);
		set_dea								:= oldsourceTools.set_dea								+ if(pUseNewCodes, [],['DE']);
		set_wc								:= oldsourceTools.set_WC								+ if(pUseNewCodes, [],['AW']);
		set_property					:= oldsourceTools.set_property					+ if(pUseNewCodes, [],['PR']);
		set_bk								:= oldsourceTools.set_bk								+ if(pUseNewCodes, [],['B ']);
		set_atf								:= oldsourceTools.set_atf								+ if(pUseNewCodes, [],['AF']);
		set_business_header		:= if(pUseNewCodes,oldsourceTools.set_business_header		 ,fAddSourcesToSet(oldsourceTools.set_business_header					));
		set_paw								:= if(pUseNewCodes,oldsourceTools.set_paw								 ,fAddSourcesToSet(oldsourceTools.set_paw								,false));
		set_business_contacts	:= if(pUseNewCodes,oldsourceTools.set_business_contacts	 ,fAddSourcesToSet(oldsourceTools.set_business_contacts	,false));
                                             
		// -----------------------------------------
		// Create code for sets
		// -----------------------------------------
		set_layout :=
		record, maxlength(1000000)
			string set_DPPA_sources						;
			string set_DPPA_Probation_sources	;
			string set_NonDPPA_sources				;
			string set_Utility_sources				;
			string set_FCRA_sources						;
			string set_FCRA_Probation_sources	;
			string set_TEMP_Probation_sources ;
			string set_GLB 										;
			string set_NoMix                  ;
			string set_LNOnly                 ;
			string set_Death 			            ;
			string set_experian_dl           	;
			string set_direct_dl              ;
			string set_DL                     ;
			string set_experian_vehicles      ;
			string set_direct_vehicles        ;
			string set_vehicles               ;
			string set_WC 				            ;
			string set_lnpropertyV2           ;
			string set_property 	            ;
			string set_transunion             ;
			string set_liens                  ;
			string set_fbnv2                 	;
			string set_corpv2									;
			string set_bk                     ;
			string set_atf                    ;
			string set_header                 ;
			string set_business_header        ;
			string set_paw			             	;
			string set_business_contacts 			;
			string set_BBB							 			;
			string set_Liquor_Licenses	 			;
			string set_Emerges					 			;
			string set_Criminal_History  			;
			string set_Sex_Offender			 			;
			string set_FAA							 			;
			string set_Infousa					 			;
			string set_Gong							 			;
			string set_UCCS							 			;
			string set_Workmans_Comp		 			;
			string set_Equifax					 			;
			string set_Sales_Tax				 			;
			string set_TCOA							 			;
			string set_NonUpdatingSrc 				;
			string set_dea						 				;
			string filter_from_moxie	 				;
			set of string countset_DPPA_sources						;
			set of string countset_DPPA_Probation_sources	;
			set of string countset_NonDPPA_sources					;
			set of string countset_Utility_sources					;
			set of string countset_FCRA_sources						;
			set of string countset_FCRA_Probation_sources	;
			set of string countset_TEMP_Probation_sources 	;
			set of string countset_GLB 										;
			set of string countset_NoMix                  	;
			set of string countset_LNOnly                 	;
			set of string countset_Death 			            ;
			set of string countset_experian_dl           	;
			set of string countset_direct_dl              	;
			set of string countset_DL                     	;
			set of string countset_experian_vehicles      	;
			set of string countset_direct_vehicles        	;
			set of string countset_vehicles               	;
			set of string countset_WC 				            	;
			set of string countset_lnpropertyV2           	;
			set of string countset_property 	            	;
			set of string countset_transunion             	;
			set of string countset_liens                  	;
			set of string countset_fbnv2                 	;
			set of string countset_corpv2                 	;
			set of string countset_bk                     	;
			set of string countset_atf                    	;
			set of string countset_header                 	;
			set of string countset_business_header        	;
			set of string countset_paw			             		;
			set of string countset_business_contacts       ;
			set of string countset_BBB							        ;
			set of string countset_Liquor_Licenses	        ;
			set of string countset_Emerges					        ;
			set of string countset_Criminal_History        ;
			set of string countset_Sex_Offender			      ;
			set of string countset_FAA							        ;
			set of string countset_Infousa					        ;
			set of string countset_Gong							      ;
			set of string countset_UCCS							      ;
			set of string countset_Workmans_Comp		        ;
			set of string countset_Equifax					        ;
			set of string countset_Sales_Tax				        ;
			set of string countset_TCOA							      ;
			set of string countset_NonUpdatingSrc     			;
			set of string countset_dea						     			;
			set of string countfilter_from_moxie	     			;
		end;           
		set_layout tCreateSets(dSourcecodes_code_deduped l) :=
		transform

			self.set_DPPA_sources							:= if(l.code in oldsourceTools.set_DPPA_sources						, ',' + l.varname, '');
			self.set_DPPA_Probation_sources	  := if(l.code in oldsourceTools.set_DPPA_Probation_sources	, ',' + l.varname, '');
			self.set_NonDPPA_sources				  := if(l.code in oldsourceTools.set_NonDPPA_sources				, ',' + l.varname, '');
			self.set_Utility_sources				  := if(l.code in oldsourceTools.set_Utility_sources				, ',' + l.varname, '');
			self.set_FCRA_sources						  := if(l.code in oldsourceTools.set_FCRA_sources						, ',' + l.varname, '');
			self.set_FCRA_Probation_sources	  := if(l.code in oldsourceTools.set_FCRA_Probation_sources	, ',' + l.varname, '');
			self.set_TEMP_Probation_sources   := if(l.code in oldsourceTools.set_TEMP_Probation_sources , ',' + l.varname, '');
			self.set_GLB   										:= if(l.code in oldsourceTools.set_GLB  									, ',' + l.varname, '');
			self.set_NoMix                    := if(l.code in oldsourceTools.set_NoMix                  , ',' + l.varname, '');
			self.set_LNOnly                   := if(l.code in oldsourceTools.set_LNOnly                 , ',' + l.varname, '');
			self.set_Death 			              := if(l.code in oldsourceTools.set_Death 			            , ',' + l.varname, '');
			self.set_experian_dl           	  := if(l.code in oldsourceTools.set_experian_dl           	, ',' + l.varname, '');
			self.set_direct_dl                := if(l.code in oldsourceTools.set_direct_dl              , ',' + l.varname, '');
			self.set_DL                       := if(l.code in oldsourceTools.set_DL                     , ',' + l.varname, '');
			self.set_experian_vehicles        := if(l.code in oldsourceTools.set_experian_vehicles      , ',' + l.varname, '');
			self.set_direct_vehicles          := if(l.code in oldsourceTools.set_direct_vehicles        , ',' + l.varname, '');
			self.set_vehicles                 := if(l.code in oldsourceTools.set_vehicles               , ',' + l.varname, '');
			self.set_WC 				              := if(l.code in set_wc 				             								, ',' + l.varname, '');
			self.set_lnpropertyV2             := if(l.code in oldsourceTools.set_lnpropertyV2           , ',' + l.varname, '');
			self.set_property 	              := if(l.code in set_property 	             								, ',' + l.varname, '');
			self.set_transunion               := if(l.code in oldsourceTools.set_transunion             , ',' + l.varname, '');
			self.set_liens                    := if(l.code in oldsourceTools.set_liens                  , ',' + l.varname, '');
			self.set_fbnv2                 	  := if(l.code in oldsourceTools.set_fbnv2                 	, ',' + l.varname, '');
			self.set_corpv2                	  := if(l.code in oldsourceTools.set_corpv2                 , ',' + l.varname, '');
			self.set_bk                       := if(l.code in set_bk                      							, ',' + l.varname, '');
			self.set_atf                      := if(l.code in set_atf                     							, ',' + l.varname, '');
			self.set_header                   := if(l.code in oldsourceTools.set_header                 , ',' + l.varname, '');
			self.set_business_header          := if(l.code in set_business_header         							, ',' + l.varname, '');
			self.set_paw			             	  := if(l.code in set_paw             											, ',' + l.varname, '');
			self.set_business_contacts      	:= if(l.code in set_business_contacts											, ',' + l.varname, '');
			self.set_BBB							      	:= if(l.code in oldsourceTools.set_BBB										, ',' + l.varname, '');
			self.set_Liquor_Licenses	      	:= if(l.code in oldsourceTools.set_Liquor_Licenses				, ',' + l.varname, '');
			self.set_Emerges					      	:= if(l.code in oldsourceTools.set_Emerges								, ',' + l.varname, '');
			self.set_Criminal_History       	:= if(l.code in oldsourceTools.set_Criminal_History 			, ',' + l.varname, '');
			self.set_Sex_Offender			      	:= if(l.code in oldsourceTools.set_Sex_Offender						, ',' + l.varname, '');
			self.set_FAA							      	:= if(l.code in set_FAA																		, ',' + l.varname, '');
			self.set_Infousa					      	:= if(l.code in oldsourceTools.set_Infousa								, ',' + l.varname, '');
			self.set_Gong							      	:= if(l.code in oldsourceTools.set_Gong										, ',' + l.varname, '');
			self.set_UCCS							      	:= if(l.code in oldsourceTools.set_UCCS										, ',' + l.varname, '');
			self.set_Workmans_Comp		      	:= if(l.code in oldsourceTools.set_Workmans_Comp					, ',' + l.varname, '');
			self.set_Equifax					      	:= if(l.code in oldsourceTools.set_Equifax								, ',' + l.varname, '');
			self.set_Sales_Tax				      	:= if(l.code in oldsourceTools.set_Sales_Tax							, ',' + l.varname, '');
			self.set_TCOA							      	:= if(l.code in oldsourceTools.set_TCOA										, ',' + l.varname, '');
			self.set_NonUpdatingSrc      			:= if(l.code in oldsourceTools.set_NonUpdatingSrc					, ',' + l.varname, '');
			self.set_dea      								:= if(l.code in set_dea																		, ',' + l.varname, '');
			self.filter_from_moxie      			:= if(l.code in oldsourceTools.filter_from_moxie					, ',' + l.varname, '');
                                                                                                                           
			self.countset_DPPA_sources						:= if(l.code in oldsourceTools.set_DPPA_sources						,[l.code] ,[]);
			self.countset_DPPA_Probation_sources	:= if(l.code in oldsourceTools.set_DPPA_Probation_sources	,[l.code] ,[]);
			self.countset_NonDPPA_sources				  := if(l.code in oldsourceTools.set_NonDPPA_sources				,[l.code] ,[]);
			self.countset_Utility_sources				  := if(l.code in oldsourceTools.set_Utility_sources				,[l.code] ,[]);
			self.countset_FCRA_sources						:= if(l.code in oldsourceTools.set_FCRA_sources						,[l.code] ,[]);
			self.countset_FCRA_Probation_sources	:= if(l.code in oldsourceTools.set_FCRA_Probation_sources	,[l.code] ,[]);
			self.countset_TEMP_Probation_sources  := if(l.code in oldsourceTools.set_TEMP_Probation_sources ,[l.code] ,[]);
			self.countset_GLB 										:= if(l.code in oldsourceTools.set_GLB 										,[l.code] ,[]);
			self.countset_NoMix                   := if(l.code in oldsourceTools.set_NoMix                  ,[l.code] ,[]);
			self.countset_LNOnly                  := if(l.code in oldsourceTools.set_LNOnly                 ,[l.code] ,[]);
			self.countset_Death 			            := if(l.code in oldsourceTools.set_Death 			            ,[l.code] ,[]);
			self.countset_experian_dl           	:= if(l.code in oldsourceTools.set_experian_dl           	,[l.code] ,[]);
			self.countset_direct_dl               := if(l.code in oldsourceTools.set_direct_dl              ,[l.code] ,[]);
			self.countset_DL                      := if(l.code in oldsourceTools.set_DL                     ,[l.code] ,[]);
			self.countset_experian_vehicles       := if(l.code in oldsourceTools.set_experian_vehicles      ,[l.code] ,[]);
			self.countset_direct_vehicles         := if(l.code in oldsourceTools.set_direct_vehicles        ,[l.code] ,[]);
			self.countset_vehicles                := if(l.code in oldsourceTools.set_vehicles               ,[l.code] ,[]);
			self.countset_WC 				              := if(l.code in set_wc 				            								,[l.code] ,[]);
			self.countset_lnpropertyV2            := if(l.code in oldsourceTools.set_lnpropertyV2           ,[l.code] ,[]);
			self.countset_property 	              := if(l.code in set_property 	            								,[l.code] ,[]);
			self.countset_transunion              := if(l.code in oldsourceTools.set_transunion             ,[l.code] ,[]);
			self.countset_liens                   := if(l.code in oldsourceTools.set_liens                  ,[l.code] ,[]);
			self.countset_fbnv2                 	:= if(l.code in oldsourceTools.set_fbnv2                 	,[l.code] ,[]);
			self.countset_corpv2                 	:= if(l.code in oldsourceTools.set_corpv2                 ,[l.code] ,[]);
			self.countset_bk                      := if(l.code in set_bk                     								,[l.code] ,[]);
			self.countset_atf                     := if(l.code in set_atf                    								,[l.code] ,[]);
			self.countset_header                  := if(l.code in oldsourceTools.set_header                 ,[l.code] ,[]);
			self.countset_business_header         := if(l.code in set_business_header        								,[l.code] ,[]);
			self.countset_paw			             	  := if(l.code in set_paw			             									,[l.code] ,[]);
			self.countset_business_contacts     	:= if(l.code in set_business_contacts     								,[l.code] ,[]);
			self.countset_BBB							     	  := if(l.code in oldsourceTools.set_BBB							     	,[l.code] ,[]);
			self.countset_Liquor_Licenses	     	  := if(l.code in oldsourceTools.set_Liquor_Licenses	     	,[l.code] ,[]);
			self.countset_Emerges					     	  := if(l.code in oldsourceTools.set_Emerges					     	,[l.code] ,[]);
			self.countset_Criminal_History      	:= if(l.code in oldsourceTools.set_Criminal_History      	,[l.code] ,[]);
			self.countset_Sex_Offender			     	:= if(l.code in oldsourceTools.set_Sex_Offender			     	,[l.code] ,[]);
			self.countset_FAA							     	  := if(l.code in set_FAA							     									,[l.code] ,[]);
			self.countset_Infousa					     	  := if(l.code in oldsourceTools.set_Infousa					     	,[l.code] ,[]);
			self.countset_Gong							     	:= if(l.code in oldsourceTools.set_Gong							     	,[l.code] ,[]);
			self.countset_UCCS							     	:= if(l.code in oldsourceTools.set_UCCS							     	,[l.code] ,[]);
			self.countset_Workmans_Comp		     	  := if(l.code in oldsourceTools.set_Workmans_Comp		     	,[l.code] ,[]);
			self.countset_Equifax					     	  := if(l.code in oldsourceTools.set_Equifax					     	,[l.code] ,[]);
			self.countset_Sales_Tax				     	  := if(l.code in oldsourceTools.set_Sales_Tax				     	,[l.code] ,[]);
			self.countset_TCOA							     	:= if(l.code in oldsourceTools.set_TCOA							     	,[l.code] ,[]);
			self.countset_NonUpdatingSrc    			:= if(l.code in oldsourceTools.set_NonUpdatingSrc	  			,[l.code] ,[]);
			self.countset_dea    									:= if(l.code in set_dea														  			,[l.code] ,[]);
			self.countfilter_from_moxie    				:= if(l.code in oldsourceTools.filter_from_moxie					,[l.code] ,[]);
                                                                           
		end;                                                                                                   

		ftrimit(string peclcode) := trim(stringlib.stringtouppercase(peclcode));
		                                                                                             
		fsortsourcesinit(string peclcode) := 
		function

			sortright := map(
				 ftrimit(peclcode[8..28]) in ['WATERCRAFT_LN'	] => 'WATERCRAFT__LN'
				,ftrimit(peclcode[8..28]) in ['EXPERIAN_DL'		] => 'DL__EXPERIAN'
				,ftrimit(peclcode[8..28]) in ['EXPERIAN_VEH'	] => 'VEH__EXPERIAN'
				,ftrimit(peclcode[5..28]) in ['STATE_SALES_TAX'	] => 'SALES_TAX_STATE'
				,trim(peclcode[8..31])
			);
		
			sortstring := 
			if(ftrimit(peclcode[8..30]) = 'DL'
			or ftrimit(peclcode[8..29]) = 'EXPERIAN_DL'
			or ftrimit(peclcode[8..21]) = 'VEH'							
			or ftrimit(peclcode[8..30]) = 'EXPERIAN_VEH'		
			or ftrimit(peclcode[8..17]) = 'WATERCRAFT'			
			or ftrimit(peclcode[8..28]) = 'WATERCRAFT_LN'			
			or ftrimit(peclcode[8..20]) = 'CH'							
			or ftrimit(peclcode[8..20]) = 'SO'							
			or ftrimit(peclcode[8..33]) = 'GAMING_LICENSES'	
			or ftrimit(peclcode[8..30]) = 'CORPORATIONS'		
			or ftrimit(peclcode[8..18]) = 'WORKER_COMP'		
			or ftrimit(peclcode[8..33]) = 'LIQUOR_LICENSES'	
			or ftrimit(peclcode[8..33]) = 'SALES_TAX'	
			or ftrimit(peclcode[11..33]) = 'SALES_TAX'	
			
				,trim(peclcode[1..4]) + sortright + trim(peclcode[4]) + trim(peclcode[5..6])
				,trim(peclcode[1..])
			);
				
			return ftrimit(sortstring);
			
		end;

		dSetsCode := project(sort(dSourcecodes_code_deduped	,fsortsourcesinit(varname)),tCreateSets(left));
		
		fAddLineFeed(string pString) :=
		function
			
			//find line feed
			lfCount := if(stringlib.stringfindcount(pString, '\n') = 0, 1, stringlib.stringfindcount(pString, '\n'));
			lfindex := if(stringlib.stringfind(pString, '\n',lfCount) = 0, 1, stringlib.stringfind(pString, '\n',lfCount) + 1);
			
			pStringleft := pString[lfindex..];
			lengthleft := length(pStringleft);
			
			return if(lengthleft > 120, '\n\t', '');
		
		end;
		
		set_layout tRollupSets(set_layout l, set_layout r) :=
		transform

			self.set_DPPA_sources							:= l.set_DPPA_sources						+	fAddLineFeed(l.set_DPPA_sources						)+ r.set_DPPA_sources						;
			self.set_DPPA_Probation_sources	  := l.set_DPPA_Probation_sources	+	fAddLineFeed(l.set_DPPA_Probation_sources	)+ r.set_DPPA_Probation_sources	;
			self.set_NonDPPA_sources				  := l.set_NonDPPA_sources				+	fAddLineFeed(l.set_NonDPPA_sources				)+ r.set_NonDPPA_sources				;
			self.set_Utility_sources				  := l.set_Utility_sources				+	fAddLineFeed(l.set_Utility_sources				)+ r.set_Utility_sources				;
			self.set_FCRA_sources						  := l.set_FCRA_sources						+	fAddLineFeed(l.set_FCRA_sources						)+ r.set_FCRA_sources						;
			self.set_FCRA_Probation_sources	  := l.set_FCRA_Probation_sources	+	fAddLineFeed(l.set_FCRA_Probation_sources	)+ r.set_FCRA_Probation_sources	;
			self.set_TEMP_Probation_sources   := l.set_TEMP_Probation_sources + fAddLineFeed(l.set_TEMP_Probation_sources )+ r.set_TEMP_Probation_sources ;
			self.set_GLB						  				:= l.set_GLB										+	fAddLineFeed(l.set_GLB										)+ r.set_GLB										;
			self.set_NoMix                    := l.set_NoMix                  + fAddLineFeed(l.set_NoMix                  )+ r.set_NoMix                  ;
			self.set_LNOnly                   := l.set_LNOnly                 + fAddLineFeed(l.set_LNOnly                 )+ r.set_LNOnly                 ;
			self.set_Death 			              := l.set_Death 			            + fAddLineFeed(l.set_Death 			            )+ r.set_Death 			            ;
			self.set_experian_dl           	  := l.set_experian_dl           	+	fAddLineFeed(l.set_experian_dl           	)+ r.set_experian_dl           	;
			self.set_direct_dl                := l.set_direct_dl              + fAddLineFeed(l.set_direct_dl              )+ r.set_direct_dl              ;
			self.set_DL                       := l.set_DL                     + fAddLineFeed(l.set_DL                     )+ r.set_DL                     ;
			self.set_experian_vehicles        := l.set_experian_vehicles      + fAddLineFeed(l.set_experian_vehicles      )+ r.set_experian_vehicles      ;
			self.set_direct_vehicles          := l.set_direct_vehicles        + fAddLineFeed(l.set_direct_vehicles        )+ r.set_direct_vehicles        ;
			self.set_vehicles                 := l.set_vehicles               + fAddLineFeed(l.set_vehicles               )+ r.set_vehicles               ;
			self.set_WC 				              := l.set_WC 				            +	fAddLineFeed(l.set_WC 				            )+ r.set_WC 				            ;
			self.set_lnpropertyV2             := l.set_lnpropertyV2           +	fAddLineFeed(l.set_lnpropertyV2           )+ r.set_lnpropertyV2           ;
			self.set_property 	              := l.set_property 	            +	fAddLineFeed(l.set_property 	            )+ r.set_property 	            ;
			self.set_transunion               := l.set_transunion             + fAddLineFeed(l.set_transunion             )+ r.set_transunion             ;
			self.set_liens                    := l.set_liens                  + fAddLineFeed(l.set_liens                  )+ r.set_liens                  ;
			self.set_fbnv2                 	  := l.set_fbnv2                 	+	fAddLineFeed(l.set_fbnv2                 	)+ r.set_fbnv2                 	;
			self.set_corpv2                 	:= l.set_corpv2                 + fAddLineFeed(l.set_corpv2                 )+ r.set_corpv2                 ;
			self.set_bk                       := l.set_bk                     + fAddLineFeed(l.set_bk                     )+ r.set_bk                     ;
			self.set_atf                      := l.set_atf                    + fAddLineFeed(l.set_atf                    )+ r.set_atf                    ;
			self.set_header                   := l.set_header                 + fAddLineFeed(l.set_header                 )+ r.set_header                 ;
			self.set_business_header          := l.set_business_header        + fAddLineFeed(l.set_business_header        )+ r.set_business_header        ;
			self.set_paw			             	  := l.set_paw             				+	fAddLineFeed(l.set_paw             				)+ r.set_paw             				;
			self.set_business_contacts      	:= l.set_business_contacts			+	fAddLineFeed(l.set_business_contacts			)+ r.set_business_contacts			;
			self.set_BBB							      	:= l.set_BBB										+	fAddLineFeed(l.set_BBB										)+ r.set_BBB										;
			self.set_Liquor_Licenses	      	:= l.set_Liquor_Licenses				+	fAddLineFeed(l.set_Liquor_Licenses				)+ r.set_Liquor_Licenses				;
			self.set_Emerges					      	:= l.set_Emerges								+	fAddLineFeed(l.set_Emerges								)+ r.set_Emerges								;
			self.set_Criminal_History       	:= l.set_Criminal_History 			+	fAddLineFeed(l.set_Criminal_History 			)+ r.set_Criminal_History 			;
			self.set_Sex_Offender			      	:= l.set_Sex_Offender						+	fAddLineFeed(l.set_Sex_Offender						)+ r.set_Sex_Offender						;
			self.set_FAA							      	:= l.set_FAA										+	fAddLineFeed(l.set_FAA										)+ r.set_FAA										;
			self.set_Infousa					      	:= l.set_Infousa								+	fAddLineFeed(l.set_Infousa								)+ r.set_Infousa								;
			self.set_Gong							      	:= l.set_Gong										+	fAddLineFeed(l.set_Gong										)+ r.set_Gong										;
			self.set_UCCS							      	:= l.set_UCCS										+	fAddLineFeed(l.set_UCCS										)+ r.set_UCCS										;
			self.set_Workmans_Comp		      	:= l.set_Workmans_Comp					+	fAddLineFeed(l.set_Workmans_Comp					)+ r.set_Workmans_Comp					;
			self.set_Equifax					      	:= l.set_Equifax								+	fAddLineFeed(l.set_Equifax								)+ r.set_Equifax								;
			self.set_Sales_Tax				      	:= l.set_Sales_Tax							+	fAddLineFeed(l.set_Sales_Tax							)+ r.set_Sales_Tax							;
			self.set_TCOA							      	:= l.set_TCOA										+	fAddLineFeed(l.set_TCOA										)+ r.set_TCOA										;
			self.set_NonUpdatingSrc      			:= l.set_NonUpdatingSrc					+	fAddLineFeed(l.set_NonUpdatingSrc					)+ r.set_NonUpdatingSrc					;
			self.set_dea      								:= l.set_dea										+	fAddLineFeed(l.set_dea										)+ r.set_dea										;
			self.filter_from_moxie      			:= l.filter_from_moxie					+	fAddLineFeed(l.filter_from_moxie					)+ r.filter_from_moxie					;
                                                                                                                                 
			self.countset_DPPA_sources						:= l.countset_DPPA_sources					+ r.countset_DPPA_sources						;
			self.countset_DPPA_Probation_sources  := l.countset_DPPA_Probation_sources+ r.countset_DPPA_Probation_sources	;
			self.countset_NonDPPA_sources				  := l.countset_NonDPPA_sources				+ r.countset_NonDPPA_sources				;
			self.countset_Utility_sources				  := l.countset_Utility_sources				+ r.countset_Utility_sources				;
			self.countset_FCRA_sources					  := l.countset_FCRA_sources					+ r.countset_FCRA_sources						;
			self.countset_FCRA_Probation_sources  := l.countset_FCRA_Probation_sources+ r.countset_FCRA_Probation_sources	;
			self.countset_TEMP_Probation_sources  := l.countset_TEMP_Probation_sources+ r.countset_TEMP_Probation_sources ;
			self.countset_GLB 										:= l.countset_GLB 									+ r.countset_GLB 										;
			self.countset_NoMix                   := l.countset_NoMix                 + r.countset_NoMix                  ;
			self.countset_LNOnly                  := l.countset_LNOnly                + r.countset_LNOnly                 ;
			self.countset_Death 			            := l.countset_Death 			          + r.countset_Death 			            ;
			self.countset_experian_dl             := l.countset_experian_dl           + r.countset_experian_dl           	;
			self.countset_direct_dl               := l.countset_direct_dl             + r.countset_direct_dl              ;
			self.countset_DL                      := l.countset_DL                    + r.countset_DL                     ;
			self.countset_experian_vehicles       := l.countset_experian_vehicles     + r.countset_experian_vehicles      ;
			self.countset_direct_vehicles         := l.countset_direct_vehicles       + r.countset_direct_vehicles        ;
			self.countset_vehicles                := l.countset_vehicles              + r.countset_vehicles               ;
			self.countset_WC 				              := l.countset_WC 				            + r.countset_WC 				            ;
			self.countset_lnpropertyV2            := l.countset_lnpropertyV2          + r.countset_lnpropertyV2           ;
			self.countset_property 	              := l.countset_property 	            + r.countset_property 	            ;
			self.countset_transunion              := l.countset_transunion            + r.countset_transunion             ;
			self.countset_liens                   := l.countset_liens                 + r.countset_liens                  ;
			self.countset_fbnv2                   := l.countset_fbnv2                 + r.countset_fbnv2                 	;
			self.countset_corpv2                  := l.countset_corpv2                + r.countset_corpv2                 ;
			self.countset_bk                      := l.countset_bk                    + r.countset_bk                     ;
			self.countset_atf                     := l.countset_atf                   + r.countset_atf                    ;
			self.countset_header                  := l.countset_header                + r.countset_header                 ;
			self.countset_business_header         := l.countset_business_header       + r.countset_business_header        ;
			self.countset_paw			             	  := l.countset_paw			             	+ r.countset_paw			             	;
			self.countset_business_contacts     	:= l.countset_business_contacts     + r.countset_business_contacts      ;
			self.countset_BBB							     	  := l.countset_BBB							     	+ r.countset_BBB							      ;
			self.countset_Liquor_Licenses	     	  := l.countset_Liquor_Licenses	     	+ r.countset_Liquor_Licenses	      ;
			self.countset_Emerges					     	  := l.countset_Emerges					     	+ r.countset_Emerges					      ;
			self.countset_Criminal_History      	:= l.countset_Criminal_History      + r.countset_Criminal_History       ;
			self.countset_Sex_Offender			     	:= l.countset_Sex_Offender			    + r.countset_Sex_Offender			      ;
			self.countset_FAA							     	  := l.countset_FAA							     	+ r.countset_FAA							      ;
			self.countset_Infousa					     	  := l.countset_Infousa					     	+ r.countset_Infousa					      ;
			self.countset_Gong							     	:= l.countset_Gong							    + r.countset_Gong							      ;
			self.countset_UCCS							     	:= l.countset_UCCS							    + r.countset_UCCS							      ;
			self.countset_Workmans_Comp		     	  := l.countset_Workmans_Comp		     	+ r.countset_Workmans_Comp		      ;
			self.countset_Equifax					     	  := l.countset_Equifax					     	+ r.countset_Equifax					      ;
			self.countset_Sales_Tax				     	  := l.countset_Sales_Tax				     	+ r.countset_Sales_Tax				      ;
			self.countset_TCOA							     	:= l.countset_TCOA							    + r.countset_TCOA							      ;
			self.countset_NonUpdatingSrc     			:= l.countset_NonUpdatingSrc    		+ r.countset_NonUpdatingSrc     		;
			self.countset_dea     								:= l.countset_dea    								+ r.countset_dea     								;
			self.countfilter_from_moxie     			:= l.countfilter_from_moxie    			+ r.countfilter_from_moxie     			;

		end;

		dSetsRollup := rollup(dSetsCode,tRollupSets(left,right),true);
		
		fCheckSets(
		
			 string		pSetname
			,string		pSetCode
			,set of string pRealSet
			,set of string pCalculatedSet
		) :=
		function
			
			string30 tempy := ' ';
			unsigned setnamelength := length(trim(pSetname));
			
			pRealSetcount				:= count(pRealSet);
			pCalculatedSetcount := count(pCalculatedSet);
			
			dpRealSet := normalize(dataset([''],{string crap})
															,pRealSetcount
															,transform({string code}
																,self.code := pRealSet[counter];
															)
									);

			dpCalculatedSet := normalize(dataset([''],{string crap})
															,pCalculatedSetcount
															,transform({string code}
																,self.code := pCalculatedSet[counter];
															)
									);
			
			dMissingSourcecodes := join(
			
				 dpRealSet
				,dpCalculatedSet
				,left.code = right.code
				,transform({string code},self := left)
				,left only
			
			);
			
			drollupmissingcodes := rollup(dMissingSourcecodes,transform({string code}, self.code := ',' + left.code + ',' + right.code),true);
				
			return
				if(pRealSetCount = pCalculatedSetCount or pUseNewCodes = false
					,'export ' + trim(pSetname)	+ tempy[setnamelength..] + ':= [\n\t ' + pSetCode	[2..] + '\n];\n'
					,'The Set, '+ trim(pSetname) + ' is missing ' + (string)(pRealSetCount - pCalculatedSetCount) + ' source codes: ' + drollupmissingcodes[1].code
				);
			
			
		end;
		
		fdedupset(

			set of string pSourceSet

		) := function

			countpSourceSet := count(pSourceSet);

			dpSourceSet := normalize(dataset([''],{string crap})
																		,countpSourceSet
																		,transform({string code}
																			,self.code := pSourceSet[counter];
																		)
												);
			dDedupSet		:= dedup(dpSourceSet, code,all);

			dBacktoset := set(dDedupSet, code);

			return dBacktoset;

		end;

		ecllayout tSetsnorm(set_layout l, unsigned4 cnt) :=
		transform
		
			self.eclcode :=  
										  choose(cnt, fCheckSets('set_DPPA_sources'					  ,l.set_DPPA_sources						,fdedupset(oldsourceTools.set_DPPA_sources						) ,fdedupset(l.countset_DPPA_sources						))
			                          , fCheckSets('set_DPPA_Probation_sources' ,l.set_DPPA_Probation_sources	,fdedupset(oldsourceTools.set_DPPA_Probation_sources	) ,fdedupset(l.countset_DPPA_Probation_sources	))
			                          , fCheckSets('set_NonDPPA_sources'				,l.set_NonDPPA_sources				,fdedupset(oldsourceTools.set_NonDPPA_sources					) ,fdedupset(l.countset_NonDPPA_sources					))
			                          , fCheckSets('set_Utility_sources'				,l.set_Utility_sources				,fdedupset(oldsourceTools.set_Utility_sources					) ,fdedupset(l.countset_Utility_sources					))
			                          , fCheckSets('set_FCRA_sources'					  ,l.set_FCRA_sources						,fdedupset(oldsourceTools.set_FCRA_sources						) ,fdedupset(l.countset_FCRA_sources						))
			                          , fCheckSets('set_FCRA_Probation_sources' ,l.set_FCRA_Probation_sources	,fdedupset(oldsourceTools.set_FCRA_Probation_sources	) ,fdedupset(l.countset_FCRA_Probation_sources	))
			                          , fCheckSets('set_TEMP_Probation_sources' ,l.set_TEMP_Probation_sources ,fdedupset(oldsourceTools.set_TEMP_Probation_sources 	) ,fdedupset(l.countset_TEMP_Probation_sources 	))
			                          , fCheckSets('set_GLB'					 					,l.set_GLB										,fdedupset(oldsourceTools.set_GLB 										) ,fdedupset(l.countset_GLB 										))
			                          , fCheckSets('set_NoMix'                  ,l.set_NoMix                  ,fdedupset(oldsourceTools.set_NoMix                  	) ,fdedupset(l.countset_NoMix                  	))
			                          , fCheckSets('set_LNOnly'                 ,l.set_LNOnly                 ,fdedupset(oldsourceTools.set_LNOnly                 	) ,fdedupset(l.countset_LNOnly                 	))
			                          , fCheckSets('set_Death' 			            ,l.set_Death 			            ,fdedupset(oldsourceTools.set_Death 			            ) ,fdedupset(l.countset_Death 			            ))
			                          , fCheckSets('set_Experian_dl'            ,l.set_experian_dl           	,fdedupset(oldsourceTools.set_experian_dl           	) ,fdedupset(l.countset_experian_dl           	))
			                          , fCheckSets('set_Direct_dl'              ,l.set_direct_dl              ,fdedupset(oldsourceTools.set_direct_dl              	) ,fdedupset(l.countset_direct_dl              	))
			                          , fCheckSets('set_DL'                     ,l.set_DL                     ,fdedupset(oldsourceTools.set_DL                     	) ,fdedupset(l.countset_DL                     	))
			                          , fCheckSets('set_Experian_vehicles'      ,l.set_experian_vehicles      ,fdedupset(oldsourceTools.set_experian_vehicles      	) ,fdedupset(l.countset_experian_vehicles      	))
			                          , fCheckSets('set_Direct_vehicles'        ,l.set_direct_vehicles        ,fdedupset(oldsourceTools.set_direct_vehicles        	) ,fdedupset(l.countset_direct_vehicles        	))
			                          , fCheckSets('set_Vehicles'               ,l.set_vehicles								,fdedupset(oldsourceTools.set_vehicles               	) ,fdedupset(l.countset_vehicles               	))
			                          , fCheckSets('set_WC' 				            ,l.set_WC 				            ,fdedupset(set_wc 				            								) ,fdedupset(l.countset_WC 				            	))
			                          , fCheckSets('set_LnPropertyV2'           ,l.set_lnpropertyV2           ,fdedupset(oldsourceTools.set_lnpropertyV2           	) ,fdedupset(l.countset_lnpropertyV2	          ))
			                          , fCheckSets('set_Property' 	            ,l.set_property 	            ,fdedupset(set_property 	            								) ,fdedupset(l.countset_property 	            	))
			                          , fCheckSets('set_Transunion'             ,l.set_transunion             ,fdedupset(oldsourceTools.set_transunion             	) ,fdedupset(l.countset_transunion             	))
			                          , fCheckSets('set_Liens'                  ,l.set_liens                  ,fdedupset(oldsourceTools.set_liens                  	) ,fdedupset(l.countset_liens                  	))
			                          , fCheckSets('set_Fbnv2'                  ,l.set_fbnv2                 	,fdedupset(oldsourceTools.set_fbnv2                 	) ,fdedupset(l.countset_fbnv2                 	))
			                          , fCheckSets('set_CorpV2'                 ,l.set_corpv2                	,fdedupset(oldsourceTools.set_corpv2                 	) ,fdedupset(l.countset_corpv2                 	))
			                          , fCheckSets('set_Bk'                     ,l.set_bk                     ,fdedupset(set_bk                     								) ,fdedupset(l.countset_bk                     	))
			                          , fCheckSets('set_Atf'                    ,l.set_atf                    ,fdedupset(set_atf                    								) ,fdedupset(l.countset_atf                     ))
			                          , fCheckSets('set_Header'                 ,l.set_header                 ,fdedupset(oldsourceTools.set_header                 	) ,fdedupset(l.countset_header                 	))
			                          , fCheckSets('set_Business_header'        ,l.set_business_header        ,fdedupset(set_business_header        								) ,fdedupset(l.countset_business_header        	))
		                            , fCheckSets('set_Paw'             			  ,l.set_paw             				,fdedupset(set_paw			             									) ,fdedupset(l.countset_paw			             		))
		                            , fCheckSets('set_Business_contacts'      ,l.set_business_contacts			,fdedupset(set_business_contacts      								) ,fdedupset(l.countset_business_contacts      	))
		                            , fCheckSets('set_BBB'							      ,l.set_BBB										,fdedupset(oldsourceTools.set_BBB							      	) ,fdedupset(l.countset_BBB							      	))
		                            , fCheckSets('set_Liquor_Licenses'        ,l.set_Liquor_Licenses				,fdedupset(oldsourceTools.set_Liquor_Licenses	      	) ,fdedupset(l.countset_Liquor_Licenses	      	))
		                            , fCheckSets('set_Emerges'             		,l.set_Emerges								,fdedupset(oldsourceTools.set_Emerges					      	) ,fdedupset(l.countset_Emerges					      	))
		                            , fCheckSets('set_Criminal_History'       ,l.set_Criminal_History 			,fdedupset(oldsourceTools.set_Criminal_History       	) ,fdedupset(l.countset_Criminal_History       	))
		                            , fCheckSets('set_Sex_Offender'           ,l.set_Sex_Offender						,fdedupset(oldsourceTools.set_Sex_Offender			      ) ,fdedupset(l.countset_Sex_Offender			      ))
		                            , fCheckSets('set_FAA'						        ,l.set_FAA										,fdedupset(oldsourceTools.set_FAA							      	) ,fdedupset(l.countset_FAA							      	))
		                            , fCheckSets('set_Infousa'					      ,l.set_Infousa								,fdedupset(oldsourceTools.set_Infousa					      	) ,fdedupset(l.countset_Infousa					      	))
		                            , fCheckSets('set_Gong'							      ,l.set_Gong										,fdedupset(oldsourceTools.set_Gong							      ) ,fdedupset(l.countset_Gong							      ))
		                            , fCheckSets('set_UCCS'							      ,l.set_UCCS										,fdedupset(oldsourceTools.set_UCCS							      ) ,fdedupset(l.countset_UCCS							      ))
		                            , fCheckSets('set_Workmans_Comp'		      ,l.set_Workmans_Comp					,fdedupset(oldsourceTools.set_Workmans_Comp		      	) ,fdedupset(l.countset_Workmans_Comp		      	))
		                            , fCheckSets('set_Equifax'					      ,l.set_Equifax								,fdedupset(oldsourceTools.set_Equifax					      	) ,fdedupset(l.countset_Equifax					      	))
		                            , fCheckSets('set_State_Sales_Tax'				,l.set_Sales_Tax							,fdedupset(oldsourceTools.set_Sales_Tax				      	) ,fdedupset(l.countset_Sales_Tax				      	))
		                            , fCheckSets('set_TCOA'							      ,l.set_TCOA										,fdedupset(oldsourceTools.set_TCOA							      ) ,fdedupset(l.countset_TCOA							      ))
		                            , fCheckSets('set_NonUpdatingSrc'		  		,l.set_NonUpdatingSrc					,fdedupset(oldsourceTools.set_NonUpdatingSrc    			) ,fdedupset(l.countset_NonUpdatingSrc      		))
		                            , fCheckSets('set_Dea'		  							,l.set_dea										,fdedupset(oldsourceTools.set_dea    									) ,fdedupset(l.countset_dea      								))
		                            , fCheckSets('filter_from_moxie'					,l.filter_from_moxie					,fdedupset(oldsourceTools.filter_from_moxie    				) ,fdedupset(l.countfilter_from_moxie      			))
													);                                                                                                                                                                                                  
		                                                                                              
		end;
		
		dSetsNormalize := normalize(dSetsRollup,46,tSetsnorm(left,counter));

		setIndividualSources := 
			fdedupset(
//				oldsourceTools.set_Death 			           
//			+ oldsourceTools.set_experian_dl           	
//			+ oldsourceTools.set_direct_dl              
//			+ oldsourceTools.set_DL                     
//			+ oldsourceTools.set_experian_vehicles      
//			+ oldsourceTools.set_direct_vehicles        
//			+ oldsourceTools.set_vehicles              
//			+ set_wc 		
//			+ oldsourceTools.set_lnpropertyV2
//			+ set_property 	            
//			+ oldsourceTools.set_transunion            
//			+ oldsourceTools.set_liens                 
//			+ oldsourceTools.set_fbnv2                 
//			+ oldsourceTools.set_corpv2                
			 set_bk                    
//			+ set_atf                   
//			+ oldsourceTools.set_BBB							      
//			+ oldsourceTools.set_Liquor_Licenses	      
//			+ oldsourceTools.set_Emerges					      
//			+ oldsourceTools.set_Criminal_History      
//			+ oldsourceTools.set_Sex_Offender			    
//			+ oldsourceTools.set_FAA							      
//			+ oldsourceTools.set_Infousa					      
//			+ oldsourceTools.set_Gong							    
//			+ oldsourceTools.set_UCCS							    
//			+ oldsourceTools.set_Workmans_Comp		      
//			+ oldsourceTools.set_Equifax					      
//			+ oldsourceTools.set_Sales_Tax				      
//			+	oldsourceTools.set_TCOA	
			+	['DA']
			+ ['AF','AW','PR']
		)
		;

		ecllayout tCreateExtraSets(mylayout l) :=
		transform
		
			lsetname := trim(map(
				 trim(l.varname[5..]) = 'TransUnion'	=> 'TransUnion_Direct'
				,trim(l.varname[5..]) = 'Equifax'			=> 'Equifax_Direct'
				,trim(l.varname[5..]) = 'Liens'				=> 'LiensV1'
				,trim(l.varname[5..])
			));
			
			lspaces := length(trim(lsetname)) + 5;
			
			self.eclcode := 'export set_' + lsetname	+ tempstring30[lspaces..] + ':= [' + l.varname + '];';
		                                                                                              
		end;

		dextrasets_source_codes := project(dSourcecodes_code_deduped(code not in setIndividualSources
		and varname not in['src_Aircrafts2','src_MS_Worker_Comp2']
		), tCreateExtraSets(left));
		
		// -----------------------------------------
		// -- Permissioning
		// -----------------------------------------
		dpermissioning_dataset := 
		dataset([
			 {'export str_DPPA 						:= \'A\';'}
			,{'export str_DPPA_Probation		:= \'B\';'}
			,{'export str_NonDPPA 					:= \' \';'}
			,{'export str_Utility					:= \'U\';'}
			,{'export str_FCRA 						:= \'D\';'}
			,{'export str_FCRA_Probation 	:= \'E\';'}
			,{'export str_Other_Probation 	:= \'C\';'}
			,{'\n'}
			,{'export set_FCRA   					:= [str_FCRA, str_FCRA_Probation];'}
			,{'export set_DPPA   					:= [str_DPPA, str_DPPA_Probation];'}
			,{'export set_Probation   			:= [str_DPPA_Probation, str_FCRA_Probation, str_Other_Probation];'}
			,{'\n'}
			,{'export SourceGroup(string2 sr) := '}
			,{'  MAP( '}
			,{'     sr in set_TEMP_Probation_sources	=> str_Other_Probation'}
			,{'		,sr in set_DPPA_Probation_sources	=> str_DPPA_Probation'}
			,{'		,sr in set_DPPA_sources 			 		=> str_DPPA 			 '}
			,{'		,sr in set_NonDPPA_sources				=> str_NonDPPA '}
			,{'		,sr in set_Utility_sources		 		=> str_Utility '}
			,{'		,sr in set_FCRA_sources			 			=> str_FCRA '}
			,{'		,sr in set_FCRA_Probation_sources => str_FCRA_Probation'}
			,{'		,																		 str_Other_Probation'}
			,{'	 ); '}
			,{'\n'}
			,{'// -----------------------------------------'}
			,{'// -- Source Tests'													}
			,{'// -----------------------------------------'}
		], ecllayout)
		;                                        

		dsourceis := 
		dataset([
			 {'export SourceIsDPPA                       (string2 sr) := SourceGroup(sr)  in set_DPPA                       ;'}
			,{'export SourceIsFCRA                       (string2 sr) := SourceGroup(sr)  in set_FCRA                       ;'}                        
			,{'export SourceNot4Despray                  (string2 sr) := SourceGroup(sr)  in [\'none\']                       ;'}
			,{'export SourceIsUtility                    (string  sr) := SourceGroup(sr)  =  str_Utility                    ;'}                        
			,{'export SourceIsOnProbation                (string  sr) := SourceGroup(sr)  in set_Probation                  ;'}
			,{'export SourceIsGLB                        (string2 sr) := sr               in set_GLB                        ;'}
			,{'export SourceIsDeath                      (string  sr) := sr               in set_Death                      ;'}
			,{'export SourceIsExperianDL                 (string  sr) := sr               in set_experian_dl                ;'}
			,{'export SourceIsDirectDL                   (string  sr) := sr               in set_direct_dl                  ;'}
			,{'export SourceIsDL                         (string  sr) := sr               in set_dl                         ;'}
			,{'export SourceIsExperianVehicle            (string  sr) := sr               in set_experian_vehicles          ;'}
			,{'export SourceIsDirectVehicle              (string  sr) := sr               in set_direct_vehicles            ;'}
			,{'export SourceIsVehicle                    (string  sr) := sr               in set_vehicles                   ;'}
			,{'export SourceIsWC                         (string  sr) := sr               in set_WC                         ;'}
			,{'export SourceIsLnPropertyV2               (string  sr) := sr               in set_lnpropertyV2               ;'}
			,{'export SourceIsProperty                   (string  sr) := sr               in set_property                   ;'}
			,{'export SourceIsTransUnion                 (string  sr) := sr               in set_transunion                 ;'}
			,{'export SourceIsLiens                      (string  sr) := sr               in set_liens                      ;'}
			,{'export SourceIsFBNV2                      (string  sr) := sr               in set_fbnv2                      ;'}
			,{'export SourceIsCorpV2                     (string  sr) := sr               in set_CorpV2                     ;'}
			,{'export SourceIsBankruptcy                 (string  sr) := sr               in set_bk                         ;'}
			,{'export SourceIsATF                        (string  sr) := sr               in set_atf                        ;'}
			,{'export SourceIsWeeklyHeader               (string  sr) := sr               =  src_Equifax_Weekly             ;'}
			,{'export SourceIsPeopleHeader               (string  sr) := sr               in set_header                     ;'}
			,{'export SourceIsBusinessHeader             (string  sr) := sr               in set_business_header            ;'}
			,{'export SourceIsPaw                        (string  sr) := sr               in set_paw                        ;'}
		], ecllayout)
		;                                        

		fCreateSourceIs(
		
				string		pSetname
			 ,boolean 	pchange 	= false
		) :=
		function
			
			string30 tempy := ' ';

			lsetname := trim(map(
				 trim(pSetname[5..]) = 'TransUnion'	=> 'TransUnion_Direct'
				,trim(pSetname[5..]) = 'Equifax'		and pchange => 'Equifax_Direct'
				,trim(pSetname[5..]) = 'Liens'			=> 'LiensV1'
				,trim(pSetname[5..])
			));
			
			unsigned setnamelength := length(trim(lsetname)) + 4;
			
			return 'export SourceIs' + lsetname	+ tempy[setnamelength..] + '(string  sr) := sr' 
				+ tempy[16..] + 'in set_' + lsetname + tempy[setnamelength..] + ';';
			
			
		end;

		ecllayout tSourceIsNorm(set_layout l, unsigned4 cnt) :=
		transform
		
			self.eclcode :=  
										  choose(cnt, fCreateSourceIs('set_Business_contacts' )
		                            , fCreateSourceIs('set_BBB'							  )
		                            , fCreateSourceIs('set_Liquor_Licenses'   )
		                            , fCreateSourceIs('set_Emerges'           )
		                            , fCreateSourceIs('set_Criminal_History'  )
		                            , fCreateSourceIs('set_Sex_Offender'      )
		                            , fCreateSourceIs('set_FAA'						    )
		                            , fCreateSourceIs('set_Infousa'					  )
		                            , fCreateSourceIs('set_Gong'							)
		                            , fCreateSourceIs('set_UCCS'							)
		                            , fCreateSourceIs('set_Workmans_Comp'		  )
		                            , fCreateSourceIs('set_Equifax'					  )
		                            , fCreateSourceIs('set_State_Sales_Tax'		)
		                            , fCreateSourceIs('set_TCOA'							)
		                            , fCreateSourceIs('set_NonUpdatingSrc'		)
		                            , fCreateSourceIs('set_Dea'								)
													);                                                                                                                                                  
		                                                                                              
		end;
		
		dSourceIsNormalize := normalize(dSetsRollup,16,tSourceIsNorm(left,counter));

		// -- Create rest of sourceis attributes
		ecllayout tCreateExtraSourceIs(mylayout l) :=
		transform
		
			self.eclcode := fCreateSourceIs('set_' + l.varname[5..] ,true);
		                                                                                              
		end;

		dextra_SourceIs:= project(dSourcecodes_code_deduped(code not in setIndividualSources 
		and varname not in['src_Aircrafts2','src_MS_Worker_Comp2']), tCreateExtraSourceIs(left));
		
		dallsourceis := dsourceis + dSourceIsNormalize + dextra_SourceIs;
		//break out into groups, sort, then put back together
		
	
		fsort(string peclcode) := 
		function

			sortright := map(
				 ftrimit(peclcode[19..31]) in ['WATERCRAFT_LN'	] => 'WATERCRAFT__LN'
				,ftrimit(peclcode[19..31]) in ['EXPERIAN_DL'		] => 'DL__EXPERIAN'
				,ftrimit(peclcode[19..31]) in ['EXPERIAN_VEH'		] => 'VEH__EXPERIAN'
				,ftrimit(peclcode[16..31]) in ['STATE_SALES_TAX'] => 'SALES_TAX_STATE'
				,trim(peclcode[19..])
			);
		
			sortstring := 
			if(ftrimit(peclcode[19..20]) = 'DL'
			or ftrimit(peclcode[19..29]) = 'EXPERIAN_DL'
			or ftrimit(peclcode[19..21]) = 'VEH'							
			or ftrimit(peclcode[19..30]) = 'EXPERIAN_VEH'		
			or ftrimit(peclcode[19..28]) = 'WATERCRAFT'			
			or ftrimit(peclcode[19..31]) = 'WATERCRAFT_LN'			
			or ftrimit(peclcode[19..20]) = 'CH'							
			or ftrimit(peclcode[19..20]) = 'SO'							
			or ftrimit(peclcode[19..33]) = 'LIQUOR_LICENSES'	
			or ftrimit(peclcode[19..30]) = 'CORPORATIONS'		
			or ftrimit(peclcode[19..29]) = 'WORKER_COMP'		
			or ftrimit(peclcode[19..33]) = 'GAMING_LICENSES'	
			or ftrimit(peclcode[19..33]) = 'SALES_TAX'	
			or ftrimit(peclcode[22..33]) = 'SALES_TAX'	
			
				,trim(peclcode[14..15]) + sortright + trim(peclcode[18]) + trim(peclcode[16..17])
				,trim(peclcode[14..])
			);
				
			return ftrimit(sortstring);
			
		end;
		
		
		dallsourceis_sorted := sort(dallsourceis,fsort(eclcode));
		
		dallsourceis_sorted_proj := project(dallsourceis_sorted,transform(
			recordof(dallsourceis_sorted)
			,self.eclcode := if(regexfind('SourceIsOnProbation',left.eclcode,nocase)
												,
'#if(_Control.ThisEnvironment.IsPlatformThor = true)\n'
+ '	export SourceIsOnProbation                (string  sr) := SourceGroup(sr)  in set_Probation                  ;\n'
+ '#else\n'
+ '	export SourceIsOnProbation                (string  sr) := codes.KeyCodes(\'HEADER_MASTER_V5\',\'PROBATION\',,sr)<>\'\';\n'
+ '#end'

												,left.eclcode
			 );
		
		
		));
		
		fsortsourcedataset(string peclcode) := 
		function

			sortright := map(
				 ftrimit(peclcode[9..21]) in ['WATERCRAFT_LN'	] => 'WATERCRAFT__LN'
				,ftrimit(peclcode[9..21]) in ['EXPERIAN_DL'		] => 'DL__EXPERIAN'
				,ftrimit(peclcode[9..21]) in ['EXPERIAN_VEH'	] => 'VEH__EXPERIAN'
				,ftrimit(peclcode[6..21]) in ['STATE_SALES_TAX'	] => 'SALES_TAX_STATE'
				,trim(peclcode[9..31])
			);

			sortstring := 
			if(ftrimit(peclcode[9..10]) = 'DL'
			or ftrimit(peclcode[9..19]) = 'EXPERIAN_DL'
			or ftrimit(peclcode[9..11]) = 'VEH'							
			or ftrimit(peclcode[9..20]) = 'EXPERIAN_VEH'		
			or ftrimit(peclcode[9..18]) = 'WATERCRAFT'			
			or ftrimit(peclcode[9..21]) = 'WATERCRAFT_LN'			
			or ftrimit(peclcode[9..10]) = 'CH'							
			or ftrimit(peclcode[9..10]) = 'SO'							
			or ftrimit(peclcode[9..23]) = 'LIQUOR_LICENSES'	
			or ftrimit(peclcode[9..20]) = 'CORPORATIONS'		
			or ftrimit(peclcode[9..23]) = 'WORKER_COMP'		
			or ftrimit(peclcode[9..23]) = 'GAMING_LICENSES'	
			or ftrimit(peclcode[9..23]) = 'SALES_TAX'	
			or ftrimit(peclcode[12..23]) = 'SALES_TAX'	
			
				,trim(peclcode[2..5]) + sortright + trim(peclcode[8]) + trim(peclcode[6..7])
				,trim(peclcode[2..])
			);
				
			return ftrimit(sortstring);
			
		end;
		
		// -----------------------------------------
		// Create Code for Master Dataset
		// -----------------------------------------
		dSourcecodes_dataset := 
		dataset([
			 {''}
			,{'export layout_description :='}
			,{'RECORD'}
			,{''}
			,{'	STRING2		code												        ;'}
			,{'	STRING100	description									        ;'}
			,{'	boolean		IsBusinessHeaderSource		:= false	;'}
			,{'	boolean		IsPeopleHeaderSource			:= false	;'}
			,{'	boolean		IsBusinessContactsSource	:= false	;'}
			,{'	boolean		IsPawSource								:= false	;'}
			,{'	boolean		IsFCRA										:= false	;'}
			,{'	boolean		IsDPPA										:= false	;'}
			,{'	boolean		IsUtility									:= false	;'}
			,{'	boolean		IsOnProbation							:= false	;'}
			,{'	boolean		IsDeath 									:= false	;'}
			,{'	boolean		IsDL 											:= false	;'}
			,{'	boolean		IsWC											:= false	;'}
			,{'	boolean		IsProperty								:= false	;'}
			,{'	boolean		IsTransUnion							:= false	;'}
			,{'	boolean		isWeeklyHeader						:= false	;'}
			,{'	boolean		isVehicle									:= false	;'}
			,{'	boolean		isLiens										:= false	;'}
			,{'	boolean		isBankruptcy							:= false	;'}
			,{'	boolean		isCorpV2									:= false	;'}
			,{'	boolean		isUpdating								:= true		;'}
			,{''}                           
			,{'END;																			'}
			,{''}                        
			,{'export dSource_Codes := DATASET(['}
			], ecllayout)
			+           
			project(
				sort(
					join(dSourcecodes
						,dSourcecodes_code_deduped_only
						,left.code = right.code
						,transform({ecllayout, unsigned4 uid}
						, self.eclcode := 	'{' 
															+ if(left.code != right.code
																,'\'' + regexreplace('\\\\',trim(left.code),'\\\\\\') + '\''
																,trim(right.varname)
															)
															+ tempstring30[(length(trim(if(left.code != right.code
																,'\'' + regexreplace('\\\\',trim(left.code),'\\\\\\') + '\''
																,trim(right.varname)
															))) + 1)..] 
															+ ',\''
															+ regexreplace('\'',trim(left.description),'\\\\\'')
															+ '\''
															+ tempstring60[(length('\'' + trim(regexreplace('\'',trim(left.description),'\\\\\'')) + '\'') + 1)..] 
															+ '}';
						 self.uid := right.uid
						)
					)
				,fsortsourcedataset(eclcode))
			,transform(ecllayout, self.eclcode := if(counter != 1	,'\t,','\t ') + left.eclcode; self := left))
		+ dataset(['], layout_description);\n'], ecllayout);
		;

		fsortmapstatement(string peclcode) := 
		function

			sortright := map(
				 ftrimit(peclcode[8..20]) in ['WATERCRAFT_LN'	] => 'WATERCRAFT__LN'
				,ftrimit(peclcode[8..20]) in ['EXPERIAN_DL'		] => 'DL__EXPERIAN'
				,ftrimit(peclcode[8..20]) in ['EXPERIAN_VEH'	] => 'VEH__EXPERIAN'
				,ftrimit(peclcode[5..20]) in ['STATE_SALES_TAX'	] => 'SALES_TAX_STATE'
				,trim(peclcode[8..30])
			);

			sortstring := 
			if(ftrimit(peclcode[8..9]) = 'DL'
			or ftrimit(peclcode[8..18]) = 'EXPERIAN_DL'
			or ftrimit(peclcode[8..10]) = 'VEH'							
			or ftrimit(peclcode[8..19]) = 'EXPERIAN_VEH'		
			or ftrimit(peclcode[8..17]) = 'WATERCRAFT'			
			or ftrimit(peclcode[8..20]) = 'WATERCRAFT_LN'			
			or ftrimit(peclcode[8..9]) = 'CH'							
			or ftrimit(peclcode[8..9]) = 'SO'							
			or ftrimit(peclcode[8..22]) = 'LIQUOR_LICENSES'	
			or ftrimit(peclcode[8..19]) = 'CORPORATIONS'		
			or ftrimit(peclcode[8..22]) = 'WORKER_COMP'		
			or ftrimit(peclcode[8..22]) = 'GAMING_LICENSES'	
			or ftrimit(peclcode[8..22]) = 'SALES_TAX'	
			or ftrimit(peclcode[11..22]) = 'SALES_TAX'	
			
				,trim(peclcode[1..4]) + sortright + trim(peclcode[7]) + trim(peclcode[5..6])
				,trim(peclcode[1..])
			);
				
			return ftrimit(sortstring);
			
		end;

		// -----------------------------------------
		// Create Code for Map Statement
		// -----------------------------------------
		dSourcecodes_map_statement := 
		dataset([
			 {'export TranslateSource(string2 pSource) :='}
			,{'case(pSource'}
			], ecllayout)
			+           
			project(
				sort(dedup(
					join(dSourcecodes
						,dSourcecodes_code_deduped_only
						,left.code = right.code
						,transform({ecllayout, unsigned4 uid, string code}
						, self.eclcode := 	'' 
															+ if(left.code != right.code
																,'\'' + regexreplace('\\\\',trim(left.code),'\\\\\\') + '\''
																,trim(right.varname)
															)
															+ tempstring30[(length(trim(if(left.code != right.code
																,'\'' + regexreplace('\\\\',trim(left.code),'\\\\\\') + '\''
																,trim(right.varname)
															))) + 1)..] 
															+ '=> \''
															+ regexreplace('\'',trim(left.description),'\\\\\'')
															+ '\''
															+ tempstring60[(length('\'' + trim(regexreplace('\'',trim(left.description),'\\\\\'')) + '\'') + 1)..] 
															+ '';
						 self.uid := right.uid;
						 self.code := if(pUseNewCodes = true or count(dSourcecodeChanges_filter(left.code in new_codes)) = 0
														,left.code
														,dSourcecodeChanges_filter(left.code in new_codes)[1].old_code
														);
						)
					)
					,hash(code),all)
				,fsortmapstatement(eclcode))
			,transform(ecllayout, self.eclcode := if(counter != 1	,'\t,','\t,') + left.eclcode; self := left))
		+ dataset(['\t,\'?\' + pSource\n);\n'], ecllayout);
		;

	dRestofcode_dataset := 
	dataset([
		 {'layout_description tSetSources(layout_description l) :='}
		,{'transform'}
		,{'	self.IsBusinessHeaderSource	  := SourceIsBusinessHeader	   (l.code);'}
		,{'	self.IsPeopleHeaderSource		  := SourceIsPeopleHeader			 (l.code);'}
		,{'	self.IsBusinessContactsSource := SourceIsBusiness_contacts (l.code);'}
		,{'	self.IsPawSource							:= SourceIsPaw							 (l.code);'}
		,{'	self.IsFCRA						 		 		:= SourceIsFCRA							 (l.code);'}
		,{'	self.IsDPPA						 		 		:= SourceIsDPPA							 (l.code);'}
		,{'	self.IsUtility				 		 		:= SourceIsUtility					 (l.code);'}
		,{'	self.IsOnProbation						:= SourceIsOnProbation			 (l.code);'}
		,{'	self.IsDeath 									:= SourceIsDeath 						 (l.code);'}
		,{'	self.IsDL 										:= SourceIsDL 							 (l.code);'}
		,{'	self.IsWC											:= sourceIsWC								 (l.code);'}
		,{'	self.IsProperty								:= SourceIsProperty					 (l.code);'}
		,{'	self.IsTransUnion							:= SourceIsTransUnion				 (l.code);'}
		,{'	self.isWeeklyHeader						:= sourceisWeeklyHeader			 (l.code);'}
		,{'	self.isVehicle								:= sourceisVehicle					 (l.code);'}
		,{'	self.isLiens									:= sourceisLiens						 (l.code);'}
		,{'	self.isBankruptcy							:= sourceisBankruptcy				 (l.code);'}
		,{'	self.isCorpV2									:= sourceisCorpV2						 (l.code);'}
		,{'	self.isUpdating								:= not SourceIsNonUpdatingSrc(l.code);'}
		,{'	self													:= l                                 ;'}
		,{'end;\n'}                 
		,{'export dSource_Codes_proj := project(dSource_Codes, tSetSources(left));\n'}
		,{'export fTranslateSource(string pSource) :='}
		,{'function'}
		,{'	lcode := dSource_Codes_proj.code;'}
		,{'	source_filter 		:= 	(		trim(pSource,left,right) = trim(lcode,left,right)'}
		,{'															);'}
		,{'	dsource 					:= dSource_Codes_proj(source_filter		)[1].description;'}
		,{'	returnDescription := dsource;'}
		,{'	return if(returnDescription != \'\', returnDescription, \'?\' + pSource);'}
		,{'end;\n'}
//		,{'export TranslateSource(string2 pSource) := fTranslateSource(pSource);\n'}
		], ecllayout)
		+ dSourcecodes_map_statement
		+ dataset([
		 {'shared dSource_Codes_proj_FBNV2					:= dSource_Codes_proj(regexfind(\'FBNV2\'												,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_CorpV2				:= dSource_Codes_proj(regexfind(\'Corporations\'								,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_fLiensV2			:= dSource_Codes_proj(regexfind(\'liens\'												,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_fProperty			:= dSource_Codes_proj(regexfind(\'LN_Propertyv2\'								,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_Experian_DL		:= dSource_Codes_proj(regexfind(\'^(?=.*?Experian.*).*?DL.*$\'	,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_Direct_DL			:= dSource_Codes_proj(regexfind(\'^(?!.*?Experian.*).*?DL.*$\'	,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_Experian_Veh	:= dSource_Codes_proj(regexfind(\'^(?=.*?Experian.*).*?Veh.*$\'	,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_Direct_Veh		:= dSource_Codes_proj(regexfind(\'^(?!.*?Experian.*).*?Veh.*$\'	,Description	,nocase)) : global;'}
		,{'shared dSource_Codes_proj_Watercraft		:= dSource_Codes_proj(regexfind(\'Watercraft\'									,Description	,nocase)) : global;\n'}

		,{'export fSourceCodeSpecific(string pStateFilter = \'\',dataset(layout_description) psource_codes = dSource_Codes_proj) :='}
		,{'function'}
		,{'	State_filter				:= if(pStateFilter != \'\''}
		,{'													,regexfind(pStateFilter, psource_codes.Description, nocase)'}
		,{'													,true'}
		,{'											);'}
		,{'	'}
		,{'	dCodes := psource_codes(State_filter);'}
		,{'	'}
		,{'	returncode := dCodes[1].code;'}
		,{'	return returncode;'}
		,{'end;																																																									'}

		,{'// --------------------------------------------------------------------------------'}
		,{'// -- Functions to figure out source codes for builds with multiple source codes'}
		,{'// -- pass in data to figure out which source code to use'}
		,{'// --------------------------------------------------------------------------------'}
		,{'export fSourceCode(string pDescriptionFilter, string pStateFilter = \'\') :='}
		,{'function'}
		,{''}
		,{'	Description_filter	:= regexfind(pDescriptionFilter	, dSource_Codes_proj.Description, nocase);'}
		,{'	State_filter				:= if(pStateFilter != \'\''}
		,{'													,regexfind(pStateFilter, dSource_Codes_proj.Description, nocase)'}
		,{'													,true'}
		,{'											);'}
		,{'	'}
		,{'	dCodes := dSource_Codes_proj(Description_filter,State_filter);'}
		,{'	'}
		,{'	returncode := dCodes[1].code;'}
		,{''}
		,{'	return returncode;'}
		,{''}
		,{'end;\n'}

//		,{'	fSourceCode(\'FBNV2\', regexreplace(\'^(FL|CP|[[:alpha:]]{3}).*$\',trim(pTmsid), \'$1\',nocase));'}
		,{'export fFBNV2(string pTmsid) := '}
		,{'	case(trim(pTmsid[1..2])'}
		,{'		,\'CP\'	=>	src_FBNV2_FL'}
		,{'		,\'FL\'	=>	src_Liens_v2_Chicago_Law'}
		,{'		,case(trim(pTmsid[1..3])'}
		,{'			,\'CAO\'	=>	src_FBNV2_CA_Orange_county'}
		,{'			,\'CSC\'	=>	src_FBNV2_CA_Santa_Clara  '}
		,{'			,\'CAB\'	=>	src_FBNV2_CA_San_Bernadino'}
		,{'			,\'CAS\'	=>	src_FBNV2_CA_San_Diego    '}
		,{'			,\'CAV\'	=>	src_FBNV2_CA_Ventura      '}
		,{'			,\'EXP\'	=>	src_FBNV2_Experian_Direct '}
		,{'			,\'INF\'	=>	src_FBNV2_INF       '}
		,{'			,\'NBX\'	=>	src_FBNV2_New_York  '}
		,{'			,\'NYN\'	=>	src_FBNV2_New_York'}
		,{'			,\'NKI\'	=>	src_FBNV2_New_York'}
		,{'			,\'NQU\'	=>	src_FBNV2_New_York'}
		,{'			,\'NRI\'	=>	src_FBNV2_New_York'}
		,{'			,\'TXD\'	=>	src_FBNV2_TX_Dallas'}
		,{'			,\'TXH\'	=>	src_FBNV2_TX_Harris  '}
		,{'			,						\'\'												'}
		,{'	));'}
       
		,{'export fCorpV2(string pCorpKey	,string pstate = \'\') := '}
		,{'function'}
		,{'	stateabbr := if(trim(pcorpkey) != \'\', Corp2.fStateCodetoStateAbbr(trim(pcorpkey)[1..2]), trim(pstate));'}
		,{'	return'}
		,{'	fSourceCodeSpecific(\'^\' + stateabbr + \'.*$\',dSource_Codes_proj_CorpV2);'}
		,{'end;\n'}

		,{'/* -- Not broken out yet.  Future enhancement'}
		,{'export fLiensV2(string pTmsid) := '}
		,{'if(pTmsid[1..3] = \'NYC\'	,	src_Liens_v2_NYC'}
		,{'	,case(trim(pTmsid[1..2])'}
		,{'	,\'CA\'	=>	src_Liens_v2_CA_Federal'}
		,{'	,\'CL\'	=>	src_Liens_v2_Chicago_Law'}
		,{'	,\'CJ\'	=>	src_Liens_v2_Chicago_Law'}
		,{'	,\'HG\'	=>	src_Liens_v2_Hogan'}
		,{'	,\'IL\'	=>	src_Liens_v2_ILFDLN'}
		,{'	,\'MA\'	=>	src_Liens_v2_MA    '}
		,{'	,\'NY\'	=>	src_Liens_v2_NYFDLN'}
		,{'	,\'SA\'	=>	src_Liens_v2_Service_Abstract'}
		,{'	,\'SU\'	=>	src_Liens_v2_Superior_Party  '}
		,{'	,					\'\'													'}
		,{'	));\n*/'}
       
		,{'export fProperty(string pln_fares_id) := '}
		,{'map('}
		,{'  pln_fares_id[2]  = \'\'  and pln_fares_id[1] =\'\'  => \'\''}
		,{'	,pln_fares_id[2] != \'A\' and pln_fares_id[1] =\'R\' => src_LnPropV2_Fares_Deeds'}
		,{'	,pln_fares_id[2] != \'A\' and pln_fares_id[1]!=\'R\' => src_LnPropV2_Lexis_Deeds_Mtgs'}
		,{'	,pln_fares_id[2]  = \'A\' and pln_fares_id[1] =\'R\' => src_LnPropV2_Fares_Asrs'}
		,{'	,pln_fares_id[2]  = \'A\' and pln_fares_id[1]!=\'R\' => src_LnPropV2_Lexis_Asrs'}
		,{'	,																										\'\''}
		,{');\n'}

		,{'// compare to Drivers.header_src'}
		,{'export fDLs(string2 pSource, string2 pState) := '}
		,{'	if(pSource <> \'AX\''}
		,{'		,case(pState			//non-Experian'}
		,{'			,\'MO\' => src_MO_DL'}
		,{'			,\'MN\' => src_MN_DL'}
		,{'			,\'FL\' => src_FL_DL'}
		,{'			,\'OH\' => src_OH_DL'}
		,{'			,\'TX\' => src_TX_DL'}
		,{'			,\'NM\' => src_NM_DL'}
		,{'			,\'WI\' => src_WI_DL'}
		,{'			,\'ID\' => src_ID_DL'}
		,{'			,\'OR\' => src_OR_DL'}
		,{'			,\'ME\' => src_ME_DL'}
		,{'			,\'WV\' => src_WV_DL'}
		,{'			,\'MI\' => src_MI_DL'}
		,{'			,\'UT\' => src_UT_DL'}
		,{'			,\'IA\' => src_IA_DL'}
		,{'			,\'MA\' => src_MA_DL'}
		,{'			,\'TN\' => src_TN_DL'}
		,{'			,\'WY\' => src_WY_DL'}
		,{'			,\'KY\' => src_KY_DL'}
		,{'			,\'CT\' => src_CT_DL'}
		,{'			,\'\'             '}
		,{'		)'}
		,{'		,case(pState			//Experian'}
		,{'			,\'CO\' => src_CO_Experian_DL'}
		,{'			,\'DE\' => src_DE_Experian_DL'}
		,{'			,\'ID\' => src_ID_Experian_DL'}
		,{'			,\'IL\' => src_IL_Experian_DL'}
		,{'			,\'KY\' => src_KY_Experian_DL'}
		,{'			,\'LA\' => src_LA_Experian_DL'}
		,{'			,\'MD\' => src_MD_Experian_DL'}
		,{'			,\'MS\' => src_MS_Experian_DL'}
		,{'			,\'ND\' => src_ND_Experian_DL'}
		,{'			,\'NH\' => src_NH_Experian_DL'}
		,{'			,\'SC\' => src_SC_Experian_DL'}
		,{'			,\'WV\' => src_WV_Experian_DL'}
		,{'			,\'\''}
		,{'		)'}
		,{'	);\n'}

		,{'// compare to VehLic.Header_Src'}
		,{'export fVehicles(string2 pState_Origin, string2 pSource_code) := '}
		,{'	if(pSource_code!=\'AE\''}
		,{'		,case(pState_Origin'}
		,{'			,\'FL\' => src_FL_Veh'}
		,{'			,\'TX\' => src_TX_Veh'}
		,{'			,\'MS\' => src_MS_Veh'}
		,{'			,\'WI\' => src_WI_Veh'}
		,{'			,\'OH\' => src_OH_Veh'}
		,{'			,\'MO\' => src_MO_Veh'}
		,{'			,\'MN\' => src_MN_Veh'}
		,{'			,\'ME\' => src_ME_Veh'}
		,{'			,\'NC\' => src_NC_Veh'}
		,{'			,\'NM\' => src_NM_Veh'}
		,{'			,\'NE\' => src_NE_Veh'}
		,{'			,\'ID\' => src_ID_Veh'}
		,{'			,\'UT\' => src_UT_Veh'}
		,{'			,\'ND\' => src_ND_Veh'}
		,{'			,\'MT\' => src_MT_Veh'}
		,{'			,\'WY\' => src_WY_Veh'}
		,{'			,\'NV\' => src_NV_Veh'}
		,{'			,\'KY\' => src_KY_Veh'}
		,{'			,\'\''}
		,{'		) '}
		,{'                '}
		,{'		//Experian Vehicles'}
		,{'		,case(pState_Origin'}
		,{'			,\'AK\' => src_AK_Experian_Veh'}
		,{'			,\'CT\' => src_CT_Experian_Veh'}
		,{'			,\'DE\' => src_DE_Experian_Veh'}
		,{'			,\'MD\' => src_MD_Experian_Veh'}
		,{'			,\'OK\' => src_OK_Experian_Veh'}
		,{'			,\'SC\' => src_SC_Experian_Veh'}
		,{'			,\'AL\' => src_AL_Experian_Veh'}
		,{'			,\'CO\' => src_CO_Experian_Veh'}
		,{'			,\'DC\' => src_DC_Experian_Veh'}
		,{'			,\'IL\' => src_IL_Experian_Veh'}
		,{'			,\'LA\' => src_LA_Experian_Veh'}
		,{'			,\'MA\' => src_MA_Experian_Veh'}
		,{'			,\'MI\' => src_MI_Experian_Veh'}
		,{'			,\'NY\' => src_NY_Experian_Veh'}
		,{'			,\'TN\' => src_TN_Experian_Veh'}
		,{'			,\'UT\' => src_UT_Experian_Veh'}
		,{'			,\'FL\' => src_FL_Experian_Veh'}
		,{'			,\'ID\' => src_ID_Experian_Veh'}
		,{'			,\'KY\' => src_KY_Experian_Veh'}
		,{'			,\'ME\' => src_ME_Experian_Veh'}
		,{'			,\'MN\' => src_MN_Experian_Veh'}
		,{'			,\'MS\' => src_MS_Experian_Veh'}
		,{'			,\'MO\' => src_MO_Experian_Veh'}
		,{'			,\'MT\' => src_MT_Experian_Veh'}
		,{'			,\'NE\' => src_NE_Experian_Veh'}
		,{'			,\'NV\' => src_NV_Experian_Veh'}
		,{'			,\'ND\' => src_ND_Experian_Veh'}
		,{'			,\'OH\' => src_OH_Experian_Veh'}
		,{'			,\'TX\' => src_TX_Experian_Veh'}
		,{'			,\'WI\' => src_WI_Experian_Veh'}
		,{'			,\'WY\' => src_WY_Experian_Veh'}
		,{'			,\'NM\' => src_NM_Experian_Veh'}
		,{'			,\'OR\' => src_OR_Experian_Veh'}
		,{'			,\'\''}
		,{'		)'}
		,{'	);\n'}

		,{'// compare to watercraft.Header_Source_Code'}
		,{'export fWatercraft(string2 pSource, string2 pState) :='}
		,{'	if(pSource=\'CG\''}
		,{'		,src_US_Coastguard'}
		,{'		,case(pState'}
		,{'			,\'AK\'	=> src_AK_Watercraft'}
		,{'			,\'AL\'	=> src_AL_Watercraft'}
		,{'			,\'AR\'	=> src_AR_Watercraft'}
		,{'			,\'AZ\'	=> src_AZ_Watercraft'}
		,{'			,\'CO\'	=> src_CO_Watercraft'}
		,{'			,\'CT\'	=> src_CT_Watercraft'}
		,{'			,\'GA\'	=> src_GA_Watercraft'}
		,{'			,\'IA\'	=> src_IA_Watercraft'}
		,{'			,\'IL\'	=> src_IL_Watercraft'}
		,{'			,\'KS\'	=> src_KS_Watercraft'}
		,{'			,\'MA\'	=> src_MA_Watercraft'}
		,{'			,\'MD\'	=> src_MD_Watercraft'}
		,{'			,\'ME\'	=> src_ME_Watercraft'}
		,{'			,\'MI\'	=> src_MI_Watercraft'}
		,{'			,\'MN\'	=> src_MN_Watercraft'}
		,{'			,\'MS\'	=> src_MS_Watercraft'}
		,{'			,\'MT\'	=> src_MT_Watercraft'}
		,{'			,\'NC\'	=> src_NC_Watercraft'}
		,{'			,\'ND\'	=> src_ND_Watercraft'}
		,{'			,\'NE\'	=> src_NE_Watercraft'}
		,{'			,\'NH\'	=> src_NH_Watercraft'}
		,{'			,\'NV\'	=> src_NV_Watercraft'}
		,{'			,\'NY\'	=> src_NY_Watercraft'}
		,{'			,\'OH\'	=> src_OH_Watercraft'}
		,{'			,\'OR\'	=> src_OR_Watercraft'}
		,{'			,\'SC\'	=> src_SC_Watercraft'}
		,{'			,\'TN\'	=> src_TN_Watercraft'}
		,{'			,\'TX\'	=> src_TX_Watercraft'}
		,{'			,\'UT\'	=> src_UT_Watercraft'}
		,{'			,\'VA\'	=> src_VA_Watercraft'}
		,{'			,\'WI\'	=> src_WI_Watercraft'}
		,{'			,\'WV\'	=> src_WV_Watercraft'}
		,{'			,\'WY\'	=> src_WY_Watercraft'}
		,{'			,\'FL\'	=> src_FL_Watercraft'}
		,{'			,\'MO\'	=> src_MO_Watercraft'}
		,{'			,\'KY\'	=> src_KY_Watercraft'}
		,{'			,\'FV\'	=> src_AK_Fishing_boats'}
		,{'			,\'\''}
		,{'		)'}
		,{'	);\n'}
       
		,{'// ---------------------------------------------------------------'}
		,{'// -- Translate Weekly Indicators'}
		,{'// -- in a normalized record 1, 3, 4, and 7 should never be valid'}
		,{'// ---------------------------------------------------------------'}
		,{'export TranslateWeeklyInd(string1 pIn) := '}
		,{'case(pIn'}
		,{'	,\'W\' => \'New\''}
		,{'	,\'1\' => \'Name Chg,Addr Chg,SSN Chg,Former Name Chg\''}
		,{'	,\'2\' => \'Name Chg,Addr Chg,SSN Chg\''}
		,{'	,\'3\' => \'Name Chg,SSN Chg,Former Name Chg\''}
		,{'	,\'4\' => \'Name Chg,Addr Chg,Former Name Chg\''}
		,{'	,\'5\' => \'Name Chg,Addr Chg\''}
		,{'	,\'6\' => \'Name Chg,SSN Chg\''}
		,{'	,\'7\' => \'Name Chg,Former Name Chg\''}
		,{'	,\'N\' => \'Name Chg\''}
		,{'	,\'8\' => \'Addr Chg,SSN Chg,Former Name Chg\''}
		,{'	,\'9\' => \'Addr Chg,SSN Chg\''}
		,{'	,\'Y\' => \'Addr Chg,Former Name Chg\''}
		,{'	,\'A\' => \'Addr Chg\''}
		,{'	,\'Z\' => \'SSN Chg,Former Name Chg\''}
		,{'	,\'S\' => \'SSN Chg\''}
		,{'	,\'F\' => \'Former Name Chg\''}
		,{'	,\'-\' => \'No Relevant Information\''}
		,{'	,pIn'}    
		,{');\n'}
		,{'//convert multiple sources for source match usage'}
		,{'export str_convert_property := \'PP\';'}
		,{'export str_convert_utility  := \'UU\';'}
		,{'export str_convert_ATF      := \'AF\';'}
		,{'export str_convert_DL       := \'DR\';'}
		,{'export str_convert_vehicle  := \'VV\';'}
		,{'export str_convert_WC       := \'WC\';'}
		,{'export str_convert_infutor  := \'IF\';'}
//		,{'export filter_from_moxie    := [\'TS\',\'CY\',\'EN\'];'}
	], ecllayout);

		dall_sources := dSourcecodes_code_deduped + dwh_src;
		
	
		fsortsources(string peclcode) := 
		function

			sortright := map(
				 ftrimit(peclcode[15..28]) in ['WATERCRAFT_LN'	] => 'WATERCRAFT__LN'
				,ftrimit(peclcode[15..28]) in ['EXPERIAN_DL'		] => 'DL__EXPERIAN'
				,ftrimit(peclcode[15..28]) in ['EXPERIAN_VEH'		] => 'VEH__EXPERIAN'
				,trim(peclcode[15..37])
			);
		
			sortstring := 
			if(ftrimit(peclcode[15..20]) = 'DL'
			or ftrimit(peclcode[15..29]) = 'EXPERIAN_DL'
			or ftrimit(peclcode[15..21]) = 'VEH'							
			or ftrimit(peclcode[15..30]) = 'EXPERIAN_VEH'		
			or ftrimit(peclcode[15..28]) = 'WATERCRAFT'			
			or ftrimit(peclcode[15..28]) = 'WATERCRAFT_LN'			
			or ftrimit(peclcode[15..20]) = 'CH'							
			or ftrimit(peclcode[15..20]) = 'SO'							
			or ftrimit(peclcode[15..33]) = 'LIQUOR_LICENSES'	
			or ftrimit(peclcode[15..25]) = 'WORKER_COMP'		
			or ftrimit(peclcode[15..30]) = 'CORPORATIONS'		
			or ftrimit(peclcode[15..33]) = 'GAMING_LICENSES'	
			or ftrimit(peclcode[15..33]) = 'SALES_TAX'	
			
				,trim(peclcode[8..11]) + sortright + trim(peclcode[14]) + trim(peclcode[12..13])
				,trim(peclcode[8..])
			);
				
			return ftrimit(sortstring);
			
		end;
		
		dall_sources_sorted := sort(dall_sources,fsortsources(eclcode));

		dsets_norm_sorted := sort(dSetsNormalize(not regexfind('filter_from_moxie',eclcode,nocase)),fsortsources(eclcode));
		dextrasets_sorted := sort(dextrasets_source_codes,fsortsources(eclcode));
		
		dfilter_from_moxie := dSetsNormalize(regexfind('filter_from_moxie',eclcode,nocase));


		return
		  dataset([{'import corp2,doxie,codes,_control;'					}], ecllayout)
		+ dataset([{'// -- Please if you make a change to the source code dataset'					}], ecllayout)
		+ dataset([{'// -- also make the change in the translatesource case statement'			}], ecllayout)
		+ dataset([{'// -- it\'s temporary until have better solution'											}], ecllayout)
		+	dataset([{'export sourceTools :=\nMODULE'								}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dataset([{'// -- Source Codes'													}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ project(dall_sources_sorted, transform(ecllayout, self := left))
		+ dataset([{'\n'}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dataset([{'// -- Sets of Multiple Source Codes'					}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dsets_norm_sorted
		+ dataset([{'\n'}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dataset([{'// -- Sets of Individual Source Codes'				}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dextrasets_sorted
		+ dataset([{'\n'}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dataset([{'// -- Permissioning of Source Codes'					}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dpermissioning_dataset
		+ dallsourceis_sorted_proj
		+ dataset([{'\n'}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dataset([{'// -- Dataset of Source Codes + Descriptions'}], ecllayout)
		+ dataset([{'// -----------------------------------------'}], ecllayout)
		+ dSourcecodes_dataset
		+ dRestofcode_dataset
		+ dfilter_from_moxie
		+ dataset([{'end;'																				}], ecllayout)
		;
		
	end;


	export oldmdrsourcetools := output(
		fGenerateSourceTools(
			 pUseNewCodes := false
			,pSourceCodes	:= lbentley.oldsourceTools.dSource_Codes_proj
			,pAlignCodes	:= lbentley.Align_These_Sources.dSources			
		)	,named('MdrSourceToolsWithOldCodes'),all);

	export newmdrsourcetools := output(
		fGenerateSourceTools(
			 pUseNewCodes := true
			,pSourceCodes	:= lbentley.oldsourceTools.dSource_Codes_proj
			,pAlignCodes	:= lbentley.Align_These_Sources.dSources			
		)	,named('MdrSourceToolsWithNewCodes'),all);
	
	export allsourcetools := sequential(
	
		 oldmdrsourcetools
		,newmdrsourcetools
	
	);
end;