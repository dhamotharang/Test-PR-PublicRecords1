IMPORT FraudShared;
EXPORT Functions := 
	module 
	
Export     fSlashedMDYtoCYMD(string pDateIn) 
               :=          intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
                     +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
                     +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1); 
										 
Export     fHypenYMDtoCYMD(string pDateIn)
               := if(pDateIn <> '',
							             (intformat((integer2)regexreplace('([0-9]+)-.*-.*',pDateIn,'$1'),4,1) 
                     +     intformat((integer1)regexreplace('.*-([0-9]+)-.*',pDateIn,'$1'),2,1)
                     +     intformat((integer1)regexreplace('.*-.*-([0-9]+)',pDateIn,'$1'),2,1)),
										 '');  
	
Export Classification (

           dataset(FraudShared.Layouts.Base.Main) pBaseFile ) := 
					 
function 

      MBSPrimary := FraudShared.Files().Input.MBS.Sprayed; 
			
	JMbs  := join (pBaseFile , MBSPrimary(status = 1) , trim(StringLib.StringToUppercase(left.source),left,right) = trim(StringLib.StringToUppercase(right.fdn_file_code),left,right) , 
	
	               transform (FraudShared.Layouts.Base.Main , 
								  
												self.classification_Permissible_use_access.fdn_file_info_id                            := right.fdn_file_info_id ; 
												self.classification_Permissible_use_access.fdn_file_code                               := StringLib.StringToUppercase(right.fdn_file_code) ; 
											  self.classification_Permissible_use_access.gc_id                                       := right.gc_id ; 
												self.classification_Permissible_use_access.file_type                                   := right.file_type ; 
												self.classification_Permissible_use_access.description                                 := StringLib.StringToUppercase(right.description) ; 
												self.classification_Permissible_use_access.primary_source_entity                       := right.primary_source_entity; 
												self.classification_Permissible_use_access.Ind_type                                    := right.Ind_type; 
											  self.classification_Permissible_use_access.update_freq                                 := right.update_freq;
												self.classification_Permissible_use_access.Expiration_days                             := right.Expiration_days;
												self.classification_Permissible_use_access.post_contract_expiration_days               := right.post_contract_expiration_days ; 
												self.classification_Permissible_use_access.status                                      := right.status; 
												self.classification_Permissible_use_access.product_include                             := right.product_include ; 
												self.classification_Permissible_use_access.date_added                                  := StringLib.StringToUppercase(right.date_added) ; 
												self.classification_Permissible_use_access.user_added                                  := StringLib.StringToUppercase(right.user_added ); 
												self.classification_Permissible_use_access.date_changed                                := StringLib.StringToUppercase(right.date_changed)  ; 
												self.classification_Permissible_use_access.user_changed                                := StringLib.StringToUppercase(right.user_changed); 
												self.classification_Permissible_use_access.p_industry_segment                          := '';
												self.classification_Permissible_use_access.usage_term                                  := '';
												self.classification_source.Source_type_id                                              := right.file_type;
												self.classification_source.Primary_source_Entity_id                                    := right.Primary_source_Entity;
												self.classification_source.Expectation_of_Victim_Entities_id                           := right.Expectation_of_Victim_Entities;
												self.classification_Activity.Suspected_Discrepancy_id                                  := right.Suspected_Discrepancy;
												self.classification_Activity.Confidence_that_activity_was_deceitful_id                 := if(left.source = 'ERIE', left.classification_Activity.Confidence_that_activity_was_deceitful_id,
												                                                                                                                   right.Confidence_that_activity_was_deceitful);
												self.classification_Activity.workflow_stage_committed_id                               := right.workflow_stage_committed;
												self.classification_Activity.workflow_stage_detected_id                                := right.workflow_stage_detected;
												self.classification_Activity.Channels_id                                               := right.Channels;
												self.classification_Activity.Threat_id                                                 := right.Threat;
												self.classification_Activity.Alert_level_id                                            := right.Alert_level;
												self.classification_Entity.Entity_type_id                                              := if(left.source in ['ERIE', 'ERIE_NICB_WATCHLIST', 'ERIE_WATCHLIST'],
												                                                                                             left.classification_Entity.Entity_type_id, 
                                                                                                                   right.Entity_type); 
												self.classification_Entity.Entity_sub_type_id                                          := if(left.source = 'ERIE', left.classification_Entity.Entity_sub_type_id,
												                                                                                                                   right.Entity_sub_type);
												self.classification_Entity.role_id                                                     := if(left.source = 'ERIE', left.classification_Entity.role_id, 
												                                                                                                                   right.role);
												self.classification_Entity.Evidence_id                                                 := right.Evidence;
												self:= left ) , left outer , lookup ); 
	 
	return JMbs;
	
end; 

 EXPORT nullset := ['none','NONE','','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null'];

	EXPORT CleanFields(inputFile,outputFile) := macro

		LOADXML('<xml/>');

		#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

		#uniquename(myCleanFunction)

		STRING %myCleanFunction%(STRING x) := if(TRIM(x,all) in Functions.nullset , '',stringlib.stringcleanspaces(stringlib.stringtouppercase(x)));
		
			#uniquename(tra)
		inputFile %tra%(inputFile le) :=
			TRANSFORM

			#IF (%'doCleanFieldText'%='')
			 #DECLARE(doCleanFieldText)
			#END
			#SET (doCleanFieldText, false)
			#FOR (doCleanFieldMetaInfo)
			 #FOR (Field)
				#IF (%'@type'% = 'string')
				#SET (doCleanFieldText, 'SELF.' + %'@name'%)
					#APPEND (doCleanFieldText, ':= ' + %'myCleanFunction'% + '(le.')
				#APPEND (doCleanFieldText, %'@name'%)
				#APPEND (doCleanFieldText, ');\n')
				%doCleanFieldText%;
				#END
			 #END
			#END
				SELF := le;
		END;

		outputFile := PROJECT(inputFile, %tra%(LEFT));
	ENDMACRO;
	
	export fraud_type_fn(string off_desc_clean) := function 

   										frd_typ     := MAP(REGEXFIND('FRAUD| WELFARE FRD | WELFARE FARUD | WELFARE FRUAD | FAUDULENT | FRADULENT ',' ' + off_desc_clean + ' ')
																		                      => 'FRAUD - MULTIPLE CATEGORIES',	
																		REGEXFIND('SCHEME',off_desc_clean) AND  REGEXFIND(' DEFRD ',' ' + off_desc_clean + ' ')
																		                      => 'FRAUD - MULTIPLE CATEGORIES',	
																		REGEXFIND('FALSE| FALS | FLSE | FLS | FALES | FAL | FLASE ', ' ' + off_desc_clean + ' ') AND REGEXFIND('PRET',' ' + off_desc_clean + ' ')
																													=> 'FRAUD - FALSE PRETENSE',
																		REGEXFIND('CRIM', off_desc_clean) AND REGEXFIND('IMPERS',  off_desc_clean)
																													=> 'FRAUD - CRIMINAL IMPERSONATION', 
																		REGEXFIND('FOOD', off_desc_clean) AND REGEXFIND('STAMP|STMP',  off_desc_clean)
																													=> 'FRAUD - FOOD STAMP',
																		REGEXFIND(' TAX | TAXES ', ' ' + off_desc_clean+ ' ') AND  ~REGEXFIND('DRIVING',  off_desc_clean) AND ~REGEXFIND('VEHICLE',  off_desc_clean)
																													 => 'FRAUD - TAX',
																		REGEXFIND(' FRD ',' ' + off_desc_clean+ ' ') AND  REGEXFIND(' AGG HM RPR | AGG HOME REP | TRUST | VENDOR |RECIP',' ' + off_desc_clean+ ' ')
																		                      => 'FRAUD - MULTIPLE CATEGORIES',
																		REGEXFIND('EXPLOIT| EXPLT ', ' ' + off_desc_clean+ ' ') AND  (REGEXFIND('ELDERLY|AGED|DISABLED', off_desc_clean) OR (REGEXFIND(' ELD ',  ' ' + off_desc_clean + ' ') AND REGEXFIND(' DISABL ',  ' ' + off_desc_clean + ' ')))
																													=> 'FRAUD - EXPLOITATION',
																		REGEXFIND('FORGERY|FORGE| FOREGERY | FORGING | FORG ', ' ' + off_desc_clean+ ' ')
																													=> 'FORGERY - MULTIPLE CATEGORIES',
																		REGEXFIND('COUNTERF', off_desc_clean)
																													=> 'FORGERY - COUNTERFEIT', 
																		REGEXFIND('CHECK| CH | CHACK | CHCK | CHCKS | CHE | CHK | CHKS | CK | CKS ',' ' + off_desc_clean + ' ') AND REGEXFIND('WORTH|UTTER|BOGUS|BAD', off_desc_clean)
																													=> 'BAD CHECK - MULTIPLE CATEGORIES',
																		REGEXFIND(' W L CHECK | BD CK | BD CKS | BD CHK | BD CHKS | BD CHCK | BD CHCKS | BD CHECK | W L CK | BAD CHACK ',' ' + off_desc_clean + ' ') 
																													=> 'BAD CHECK - MULTIPLE CATEGORIES',
																		REGEXFIND(' UNLAWFUL ', ' ' + off_desc_clean + ' ') AND REGEXFIND(' USE ', ' ' + off_desc_clean + ' ') AND REGEXFIND('FUND', off_desc_clean)
																													=> 'BAD CHECK - FUNDS', 
																		REGEXFIND('CHECKS',  off_desc_clean)
																													=> 'BAD CHECK - CHECKS', 
																		REGEXFIND('FALSE| FAL | FALS | FLS | FLSE | FALES | FLASE ',' ' + off_desc_clean + ' ') AND REGEXFIND('STMT|INFO|NAME|REP|STATEM', off_desc_clean)
																													=> 'FALSE STATEMENTS & REPORTS', 
																		REGEXFIND('FALSE| FALS | FLSE | FLS | FALES | FAL | FLASE ',' ' + off_desc_clean + ' ') AND (REGEXFIND(' ID | CARD | CRD |TOKEN|CLAIM|SIGN', ' ' + off_desc_clean + ' ') OR (REGEXFIND('VERIF', off_desc_clean) AND REGEXFIND('OWNER', off_desc_clean)))
																													=> 'FALSE STATEMENTS & REPORTS',  
																		REGEXFIND('THEFT| THFT ',' ' + off_desc_clean + ' ') AND REGEXFIND('DECEPT| DEC | DECEP ', ' ' + off_desc_clean + ' ')
																													=> 'THEFT - DECEPTION', 
																		REGEXFIND('\\$1|\\$2|\\$3|\\$4|\\$5|\\$6|\\$7|\\$8|\\$9', off_desc_clean) AND (REGEXFIND('HOT CHECK| TRICK | FRD ', ' ' + off_desc_clean + ' ') OR (REGEXFIND('SEC', off_desc_clean) AND REGEXFIND('EXE', off_desc_clean) AND REGEXFIND('DOC', off_desc_clean) AND REGEXFIND('DECEP', off_desc_clean)))
																													=> 'THEFT - DECEPTION', 
																		REGEXFIND('\\$', off_desc_clean) AND REGEXFIND('COMPUTER', off_desc_clean) 
																													=> 'FRAUD - COMPUTER FRAUD', 
																		REGEXFIND('EMBEZZ', off_desc_clean)
																													=> 'THEFT - EMBEZZLEMENT', 
																		REGEXFIND('BREACH', off_desc_clean) AND REGEXFIND('TRUST', off_desc_clean) 
																													=> 'THEFT - BREACH OF TRUST', 
																		REGEXFIND('THEFT| STOLEN | THFT ', ' ' + off_desc_clean + ' ') AND REGEXFIND(' IDENTITY | IDENTY | IDENFY |IDENTIFICAT| ID | CRD | CARD ', ' ' + off_desc_clean + ' ') 
																													=> 'THEFT - MULTIPLE CATEGORIES', 
																		REGEXFIND('THEFT| THFT | STOLEN | LARC |LARCEN', ' ' + off_desc_clean + ' ') AND REGEXFIND('CHECK| CHK | CHKS | CK | CKS | CHE | CH | CHCK | CHCKS | CHACK ', ' ' + off_desc_clean + ' ') 
																													=> 'THEFT - MULTIPLE CATEGORIES', 
																		REGEXFIND('\\$1|\\$2|\\$3|\\$4|\\$5|\\$6|\\$7|\\$8|\\$9', off_desc_clean) AND REGEXFIND(' CRD | CARD ', ' ' + off_desc_clean + ' ')
																													=> 'THEFT - MULTIPLE CATEGORIES', 
																		REGEXFIND('CREDIT', off_desc_clean) AND REGEXFIND('CARD', off_desc_clean) 
																													=> 'THEFT - CREDIT CARD', 
																		REGEXFIND('THEFT| THFT ',' ' + off_desc_clean + ' ') AND REGEXFIND('SERV', off_desc_clean) 
																													=> 'THEFT - SERVICES',
																		REGEXFIND('MISREP' ,off_desc_clean) 
																													=> 'FRAUD - MISREPRESENTATION', 
																		REGEXFIND('DECEIT|DECEIV|SWINDLE',off_desc_clean)
																													=> 'FRAUD - DECEIT', 
																		(REGEXFIND('TRICK',off_desc_clean) AND REGEXFIND('DECEPT',off_desc_clean)) OR REGEXFIND(' TRICK AVOID PAYMENT | TRICK AVOID PMT ',' ' + off_desc_clean + ' ')
																													=> 'FRAUD - DECEIT', 
																		REGEXFIND('PYRAMID',off_desc_clean) AND REGEXFIND('SCHEME',off_desc_clean)
																													=> 'FRAUD - DECEIT', 
																		REGEXFIND(' TROVER ',' ' + off_desc_clean + ' ') 
																													=> 'THEFT - TROVER', 
																		REGEXFIND('FALSE', off_desc_clean) AND REGEXFIND('PERS', off_desc_clean)
																													=> 'FALSE PERSONATION', 
																		REGEXFIND('MONEY|\\$', off_desc_clean) AND REGEXFIND('LAUNDER', off_desc_clean)
																													=> 'MONEY LAUNDERING', 
																		REGEXFIND(' MISAPPROPRIATE | ALT',' ' + off_desc_clean + ' ') AND REGEXFIND(' ID |IDEN',' ' + off_desc_clean + ' ')
																													=> 'TAMPERING',
																		REGEXFIND('FALSIFICAT', off_desc_clean) 
																													=> 'FRAUD - FALSIFICATION', 
																		REGEXFIND('DECEPT', off_desc_clean) AND  ~REGEXFIND(' DRUG ',' ' + off_desc_clean + ' ') AND ~REGEXFIND(' DRUGS ',' ' + off_desc_clean + ' ') AND
																		~REGEXFIND(' DRG ',' ' + off_desc_clean + ' ') AND ~REGEXFIND(' DRGS ',' ' + off_desc_clean + ' ') AND ~REGEXFIND(' DRU ',' ' + off_desc_clean + ' ')
																													=> 'THEFT - DECEPTION', //
																		REGEXFIND('FALSE FIREARM TRANSACTION|FALSE SWEAR', off_desc_clean) OR (REGEXFIND('FALSE',off_desc_clean) AND REGEXFIND('DECLARATION',off_desc_clean) AND REGEXFIND('OWNERSHIP',off_desc_clean)) OR
																		REGEXFIND('FALSE STATMENT|FALSE STATMNT|FALSE STATMT|FALSE STMNT|FALSE STM', off_desc_clean)
																													=> 'FALSE STATEMENTS & REPORTS', //
																		REGEXFIND(' WELFARE ',' ' + off_desc_clean + ' ') AND REGEXFIND(' FALSE ',' ' + off_desc_clean + ' ')
																													=> 'FRAUD - FALSE WELFARE', //
																			'');	

return frd_typ;
end;

 	export Erie_IndustrySegment(string TypeOfLoss)  :=
																			map(TypeOfLoss  = 'ABI'           => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'APD'           => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'AFB'           => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'AT'            => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'AFB'           => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'AC'            => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'AO'            => 'INSURANCE - AUTO',
																					TypeOfLoss  = 'HT'            => 'INSURANCE - PROPERTY',
																					TypeOfLoss  = 'HF'            => 'INSURANCE - PROPERTY',
																					TypeOfLoss  = 'HO'            => 'INSURANCE - PROPERTY',
																					TypeOfLoss  = 'CPT'           => 'INSURANCE - COMMERCIAL',
																					TypeOfLoss  = 'CPF'           => 'INSURANCE - COMMERCIAL',
																					TypeOfLoss  = 'CAT'           => 'INSURANCE - COMMERCIAL',
																					TypeOfLoss  = 'CAF'           => 'INSURANCE - COMMERCIAL',
																					TypeOfLoss  = 'CO'            => 'INSURANCE - COMMERCIAL',
																					TypeOfLoss  = 'W/C'           => 'INSURANCE - WORKERS COMP',
																					TypeOfLoss  = 'MU'            => 'INSURANCE - OTHER',
																					TypeOfLoss  = 'ML'            => 'INSURANCE - OTHER',
																					TypeOfLoss  = 'MF'            => 'INSURANCE - OTHER',
																					TypeOfLoss  = 'MO'            => 'INSURANCE - OTHER',
																					TypeOfLoss  = 'SUB'           => 'INSURANCE - OTHER',
																					TypeOfLoss  = 'RE'            => 'INSURANCE - OTHER',
																					'INSURANCE (UNSPECIFIED SEGMENT)'
																					);

 	export Erie_SubType(string TypeOfLoss)  :=
																			map(TypeOfLoss  = 'ABI'           => 'BODILY INJURY',
																					TypeOfLoss  = 'APD'           => 'PROPERTY DAMAGE',
																					TypeOfLoss  = 'AFB'           => 'FPF/PIP',
																					TypeOfLoss  = 'AT'            => 'THEFT',
																					TypeOfLoss  = 'AFB'           => 'FIRE',
																					TypeOfLoss  = 'AC'            => 'COLLISON',
																					TypeOfLoss  = 'AO'            => 'OTHER',
																					TypeOfLoss  = 'HT'            => 'THEFT',
																					TypeOfLoss  = 'HF'            => 'FIRE',
																					TypeOfLoss  = 'HO'            => 'OTHER',
																					TypeOfLoss  = 'CPT'           => 'THEFT',
																					TypeOfLoss  = 'CPF'           => 'FIRE',
																					TypeOfLoss  = 'CAT'           => 'THEFT',
																					TypeOfLoss  = 'CAF'           => 'FIRE',
																					TypeOfLoss  = 'CO'            => 'OTHER',
																					TypeOfLoss  = 'W/C'           => '',
																					TypeOfLoss  = 'MU'            => '',
																					TypeOfLoss  = 'ML'            => '',
																					TypeOfLoss  = 'MF'            => 'FORGERY',
																					TypeOfLoss  = 'MO'            => '',
																					TypeOfLoss  = 'SUB'           => '',
																					TypeOfLoss  = 'RE'            => '',
																					''
																					);

 	export Erie_ConfActivityDeceitful(string Findings)  :=
																			map(Findings  = 'F'/*'FRAUD'*/           => Mod_MbsContext.ErieConfActivityDeceitful_pr,//'PROBABLE',
																					Findings  = 'I'/*'INCONCLUSIVE'*/    => Mod_MbsContext.ErieConfActivityDeceitful_po,//'POTENTIAL',
																					Findings  = 'O'/*'OTHER'*/           => Mod_MbsContext.ErieConfActivityDeceitful_po,//'POTENTIAL',
																					Findings  = 'V' /*'VALID'*/           => Mod_MbsContext.ErieConfActivityDeceitful_ne,//'NEUTRAL',
																					Mod_MbsContext.ErieConfActivityDeceitful_ne
																					);

 	export Erie_ConfActivityDeceitful_id(string Findings)  :=
																			map(Findings  = 'F'/*'FRAUD'*/          => Mod_MbsContext.ErieConfActivityDeceitful_pr_id,//'PROBABLE',
																					Findings  = 'I'/*'INCONCLUSIVE'*/   => Mod_MbsContext.ErieConfActivityDeceitful_po_id,//'POTENTIAL',
																					Findings  = 'O'/*'OTHER'*/          => Mod_MbsContext.ErieConfActivityDeceitful_po_id,//'POTENTIAL',
																					Findings  = 'V' /*'VALID'*/         => Mod_MbsContext.ErieConfActivityDeceitful_ne_id,//'NEUTRAL',
																					Mod_MbsContext.ErieConfActivityDeceitful_ne_id
																					);

 	export Erie_EntityType(string entity)  :=
																			map(entity      = 'PERSON'        => Mod_MbsContext.ErieEntityType_person,//'PERSON',
																					entity      = 'BUSINESS'      => Mod_MbsContext.ErieEntityType_business,//'BUSINESS',
																					Mod_MbsContext.ErieEntityType_unknown //UNKNOWN
																					);

 	export Erie_EntityType_id(string entity)  :=
																			map(entity      = 'PERSON'        => Mod_MbsContext.ErieEntityType_person_id,//'PERSON',
																					entity      = 'BUSINESS'      => Mod_MbsContext.ErieEntityType_business_id,//'BUSINESS',
																					Mod_MbsContext.ErieEntityType_unknown_id //UNKNOWN
																					);

 	export ErieWL_EntityType_id(string entity)  :=
																			map(entity      = 'PERSON'        => Mod_MbsContext.ErieWatchListEntityType_person_id,
																					entity      = 'BUSINESS'      => Mod_MbsContext.ErieWatchListEntityType_business_id,
																					Mod_MbsContext.ErieWatchListEntityType_unknown_id 
																					);

 	export ErieNICBWL_EntityType_id(string entity)  :=
																			map(entity      = 'PERSON'        => Mod_MbsContext.ErieNICBWatchListEntityType_person_id,
																					entity      = 'BUSINESS'      => Mod_MbsContext.ErieNICBWatchListEntityType_business_id,
																					Mod_MbsContext.ErieNICBWatchListEntityType_unknown_id
																					);
																		 
end; 
			