IMPORT PRTE2_Common, PRTE2_Email_Data, data_services,PRTE2_Common, mdr;


EXPORT Files := MODULE
  EXPORT INCOMING_BOCA_1					:= dataset(Constants.in_prefix_name + 'boca', Layouts.incoming_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
	
	EXPORT INCOMING_BOCA				    := project(INCOMING_BOCA_1(clean_email !=''),Layouts.incoming_base);
		
	EXPORT INCOMING_INS_1					  := dataset(constants.in_prefix_name  + 'ins', Layouts.incoming_base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
  
	EXPORT INCOMING_INS 				    := project(INCOMING_INS_1(clean_email !=''),Layouts.incoming_base); 	
	
	EXPORT INCOMING_BOCA_ALL			  :=	INCOMING_BOCA +   INCOMING_INS;
	
	
//Insurance Input Base File--	
	EXPORT email_Base_SF_PROD			:= PRTE2_Common.Constants.Add_Foreign_prod(Constants.base_prefix_alpha + Constants.qaVersion + 'alpha_base');	
	EXPORT INCOMING_ALPHA  				:= DATASET( email_Base_SF_PROD, Layouts.incoming_alpha, THOR);
	
	EXPORT ALPHA_BASE							:= dataset(Constants.base_prefix_name+'alpha', Layouts.base, thor);
	EXPORT BOCA_BASE							:= dataset(Constants.base_prefix_name+'boca', Layouts.base, thor);
	
	EXPORT Combined_Base_Prep    			:= ALPHA_BASE + BOCA_BASE;
	
	Export Combined_Base:=project(Combined_Base_Prep,
      Transform(Layouts.base,
		  self.orig_first_name := if(left.email_src = mdr.sourceTools.src_Whois_domains,'', left.orig_first_name);
			self.orig_last_name  := if(left.email_src = mdr.sourceTools.src_Whois_domains,'', left.orig_last_name);
		  Self:=Left;
      ));
	
	
  
	EXPORT File_Key								:= project(Combined_Base, transform(Layouts.keyRec, 
	  																																							 self.best_ssn := if(left.best_ssn <> '', left.best_ssn, left.link_ssn);
																																										self.best_dob := if(left.best_dob <> 0, left.best_dob, (unsigned)left.best_dob);
																																										self := left;
																																										)): INDEPENDENT;
	EXPORT File_AutoKey 					:= project(File_Key,Layouts.Autokey_layout);

//Eliminate src_InfutorNare 	
	EXPORT FCRA_Email_did					:= File_Key(did > 0 and activecode <> 'I' and email_src <> '!I' );

// just for early testing  
	EXPORT email_Base_SF					:= '~'+Constants.base_prefix_alpha + Constants.qaVersion + 'alpha_base';
	EXPORT INCOMING_ALPHA_DEV		:= DATASET( email_Base_SF, Layouts.incoming_alpha, THOR);

END;

