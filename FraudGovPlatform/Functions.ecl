IMPORT FraudShared;
EXPORT Functions :=  MODULE 
	
	EXPORT     fSlashedMDYtoCYMD(string pDateIn) 
				:=          intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
					 +     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
					 +     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);


	EXPORT Classification (

			 dataset(FraudShared.Layouts.Base.Main) pBaseFile ) := 
						 
	FUNCTION 

		dBaseFile := distribute(pull(pBaseFile));
		
		MBS_CVD_Rec := DEDUP(TABLE(dBaseFile,{Customer_ID, Source}),ALL);	

		MBS_Layout := RECORD
			string12 			Customer_ID;
			string100			Source;
			FraudShared.Layouts.Classification.source			classification_source; 
			FraudShared.Layouts.Classification.Activity		classification_Activity;
			FraudShared.Layouts.Classification.Entity			classification_Entity;
		END;

		MBS_CVD_T := PROJECT (MBS_CVD_Rec , transform(MBS_Layout , 
			self.classification_source.Source_type_id := 0; 
			self.classification_source.Primary_source_Entity_id	:= 0;
			self.classification_source.Expectation_of_Victim_Entities_id := 0;
			self.classification_Activity.Suspected_Discrepancy_id := 0;
			self.classification_Activity.Confidence_that_activity_was_deceitful_id := 0;
			self.classification_Activity.workflow_stage_committed_id := 0;
			self.classification_Activity.workflow_stage_detected_id := 0;
			self.classification_Activity.Channels_id := 0;
			self.classification_Activity.Threat_id := 0;
			self.classification_Activity.Alert_level_id := 0;	
			self.classification_Entity.Entity_type_id := 0;
			self.classification_Entity.Entity_sub_type_id := 0;
			self.classification_Entity.role_id := 0;
			self.classification_Entity.Evidence_id := 0;	
			self.classification_source.source_type := ''; 
			self.classification_source.Primary_source_Entity := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).PrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).ExpOfVicEntities;
			self.classification_source.Industry_segment := ''; 
			self.classification_source.Customer_State := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).CustomerState;
			self.classification_source.Customer_County := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).CustomerCounty;
			self.classification_source.Customer_Vertical := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).CustomerVertical;			
			self.classification_Activity.Suspected_Discrepancy:= FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).SuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful:= FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).ConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).WrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).WrkFlowStgDetected;
			self.classification_Activity.Channels := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).Channels;
			self.classification_Activity.category_or_fraudtype:= 'GENERAL';
			self.classification_Activity.description:= 'This individual was investigated for potential fraud by professionals from the industry shown against "INDUSTRY SEGMENT" on the date shown against "DATE EVENT REPORTED"';
			self.classification_Activity.Threat := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).Threat; 
			self.classification_Activity.Exposure := '';
			self.classification_Activity.write_off_loss := '';
			self.classification_Activity.Mitigated  := '';
			self.classification_Activity.Alert_level:= FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).AlertLevel;
			self.classification_Entity.Entity_type  := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).EntityType;
			self.classification_Entity.Entity_sub_type := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).EntitySubType;
			self.classification_Entity.role := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).Role;
			self.classification_Entity.Evidence := FraudGovPlatform.Mod_MbsContext((unsigned6) left.Customer_ID,left.Source).Evidence;
			self.classification_Entity.investigated_count := '';
			self := left;
		));	

		JCVD := join (dBaseFile , MBS_CVD_T, 
		left.Customer_ID = right.Customer_ID
		and  left.Source = right.Source,
								transform (FraudShared.Layouts.Base.Main ,
										self.classification_source.Primary_source_Entity := right.classification_source.Primary_source_Entity; 
										self.classification_source.Expectation_of_Victim_Entities := right.classification_source.Expectation_of_Victim_Entities; 
										self.classification_source.Industry_segment := right.classification_source.Industry_segment; 
										self.classification_source.Customer_State := right.classification_source.Customer_State; 
										self.classification_source.Customer_County := right.classification_source.Customer_County; 
										self.classification_source.Customer_Vertical := right.classification_source.Customer_Vertical; 
										self.classification_Activity.Suspected_Discrepancy := right.classification_Activity.Suspected_Discrepancy; 
										self.classification_Activity.Confidence_that_activity_was_deceitful := right.classification_Activity.Confidence_that_activity_was_deceitful;
										self.classification_Activity.workflow_stage_committed := right.classification_Activity.workflow_stage_committed; 
										self.classification_Activity.workflow_stage_detected := right.classification_Activity.workflow_stage_detected; 
										self.classification_Activity.Channels := right.classification_Activity.Channels; 
										self.classification_Activity.category_or_fraudtype := right.classification_Activity.category_or_fraudtype; 
										self.classification_Activity.description := right.classification_Activity.description; 
										self.classification_Activity.Threat := right.classification_Activity.Threat; 
										self.classification_Activity.Exposure := right.classification_Activity.Exposure; 
										self.classification_Activity.write_off_loss := right.classification_Activity.write_off_loss; 
										self.classification_Activity.Mitigated  := right.classification_Activity.Mitigated; 
										self.classification_Activity.Alert_level := right.classification_Activity.Alert_level; 
										self.classification_Entity.Entity_type  := right.classification_Entity.Entity_type; 
										self.classification_Entity.Entity_sub_type := right.classification_Entity.Entity_sub_type; 
										self.classification_Entity.role := right.classification_Entity.role; 
										self.classification_Entity.Evidence := right.classification_Entity.Evidence; 
										self.classification_Entity.investigated_count := right.classification_Entity.investigated_count; 
										self:= left ) , left outer , lookup );

		MBS := Files().Input.MBS.Sprayed; 

		JMbs  := join (JCVD , MBS(status = 1) , 
		left.source = right.fdn_file_code and 
		left.Customer_ID = (string)right.gc_id,
										transform (FraudShared.Layouts.Base.Main,
										v_deceitful_confidence_id := if( regexfind('DELTA', left.source, nocase),left.classification_Activity.confidence_that_activity_was_deceitful_id, right.confidence_that_activity_was_deceitful);
										v_deceitful_confidence_desc := MAP(	
													v_deceitful_confidence_id=1=>'PROBABLE',
													v_deceitful_confidence_id=2=>'POTENTIAL',
													v_deceitful_confidence_id=3=>'KNOWN GOOD',
													v_deceitful_confidence_id=4=>'NEUTRAL',
													v_deceitful_confidence_id=5=>'PROVEN',
													'');

										v_file_type_id :=	if( regexfind('DELTA', left.source, nocase),left.classification_Permissible_use_access.file_type, right.file_type);
										v_file_type_desc := MAP(	
												v_file_type_id=1=>'EVENT OUTCOMES',
												v_file_type_id=2=>'APPLICABLE PUBLIC RECORDS',
												v_file_type_id=3=>'TRANSACTIONS',
												v_file_type_id=4=>'REL. ANALYTICS',
												v_file_type_id=5=>'STATUS UPDATE',
												'');

										// Start RIN Customizations
										self.classification_Permissible_use_access.file_type := v_file_type_id;
										self.classification_source.Source_type_id := v_file_type_id;
										self.classification_source.source_type := v_file_type_desc;
										self.classification_Activity.Confidence_that_activity_was_deceitful_id := v_deceitful_confidence_id;
										self.classification_Activity.Confidence_that_activity_was_deceitful := v_deceitful_confidence_desc;	
										// End RIN Customizations
										self.classification_Permissible_use_access.fdn_file_info_id := right.fdn_file_info_id ; 
										self.classification_Permissible_use_access.fdn_file_code := StringLib.StringToUppercase(right.fdn_file_code) ; 
										self.classification_Permissible_use_access.gc_id := right.gc_id ; 										
										self.classification_Permissible_use_access.description := StringLib.StringToUppercase(right.description) ; 
										self.classification_Permissible_use_access.primary_source_entity := right.primary_source_entity; 
										self.classification_Permissible_use_access.Ind_type := right.Ind_type; 
										self.classification_Permissible_use_access.update_freq := right.update_freq;
										self.classification_Permissible_use_access.Expiration_days := right.Expiration_days;
										self.classification_Permissible_use_access.post_contract_expiration_days := right.post_contract_expiration_days ; 
										self.classification_Permissible_use_access.status := right.status; 
										self.classification_Permissible_use_access.product_include := right.product_include ; 
										self.classification_Permissible_use_access.date_added := StringLib.StringToUppercase(right.date_added) ; 
										self.classification_Permissible_use_access.user_added := StringLib.StringToUppercase(right.user_added ); 
										self.classification_Permissible_use_access.date_changed := StringLib.StringToUppercase(right.date_changed)  ; 
										self.classification_Permissible_use_access.user_changed := StringLib.StringToUppercase(right.user_changed); 
										self.classification_Permissible_use_access.p_industry_segment := '' ;
										self.classification_Permissible_use_access.usage_term := '';
										self.classification_source.Primary_source_Entity_id := right.Primary_source_Entity;
										self.classification_source.Expectation_of_Victim_Entities_id := right.Expectation_of_Victim_Entities;
										self.classification_Activity.Suspected_Discrepancy_id := right.Suspected_Discrepancy;
										self.classification_Activity.workflow_stage_committed_id := right.workflow_stage_committed;
										self.classification_Activity.workflow_stage_detected_id := right.workflow_stage_detected;
										self.classification_Activity.Channels_id := right.Channels;
										self.classification_Activity.Threat_id := right.Threat;
										self.classification_Activity.Alert_level_id := right.Alert_level;
										self.classification_Entity.Entity_type_id := right.Entity_type;
										self.classification_Entity.Entity_sub_type_id := right.Entity_sub_type;
										self.classification_Entity.role_id := right.role;
										self.classification_Entity.Evidence_id := right.Evidence;
										self:= left ) , left outer , lookup );
		 
		return JMbs;
		
	end; 

	EXPORT nullset := ['none','NONE','','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null', '\\N'];

	EXPORT CleanFields(inputFile,outputFile) := macro
			import ut;
			
			LOADXML('<xml/>');

			#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

			#uniquename(myCleanFunction)

			STRING %myCleanFunction%(STRING x) := if(TRIM(x,all) in FraudGovPlatform.Functions.nullset , '',stringlib.stringcleanspaces(stringlib.stringtouppercase(ut.fn_RemoveSpecialChars(x))));
			
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
		
	EXPORT fraud_type_fn(string off_desc_clean) := function 

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

	RETURN frd_typ;
	END;
			
	EXPORT file_type_fn(string4 Source) := function
		file_type_v := map(
											 regexfind('IDDT',Source) => 3,
											 regexfind('KNFD',Source) => 1,
											 0
											);
		RETURN file_type_v;
	END;
	EXPORT ind_type_fn(string1 customer_program) := function
		import _Control;
		ind_type_prod_v := map(
											 customer_program = 'S' => 1014,
											 customer_program = 'M' => 1024,
											 customer_program = 'U' => 1029,
											 customer_program = 'N' => 1312,
											 customer_program = 'D' => 1049,	
											 customer_program = 'X' => 1127,										 
											 0
											);
		RETURN ind_type_prod_v;
	END;

	EXPORT customer_program_fn(unsigned6 ind_type) := function
		import _Control;
		customer_program := map(
											 ind_type = 1014 => 'S',
											 ind_type = 1024 => 'M',
											 ind_type = 1029 => 'U',
											 ind_type = 1312 => 'N',
											 ind_type = 1049 => 'D',
											 ind_type = 1127 => 'X',
											 ''
											);
		RETURN customer_program;
	END;


	Current_Build := IF(_Flags.FileExists.Base.Main, FraudShared.Files().Base.Main.Built, DATASET([], FraudShared.Layouts.Base.Main));
	
	EXPORT LastRinID := MAX(Current_Build(DID >= FraudGovPlatform.Constants().FirstRinID), DID);

END; 
			