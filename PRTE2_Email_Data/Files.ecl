IMPORT PRTE2_Common, PRTE2_Email_Data, data_services,PRTE2_Common;


EXPORT Files := MODULE
  EXPORT INCOMING_BOCA					:= dataset(Constants.in_prefix_name + 'boca', Layouts.incoming_boca, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));

//Insurance Input Base File--	
	EXPORT email_Base_SF_PROD			:= PRTE2_Common.Constants.Add_Foreign_prod(Constants.base_prefix_alpha + Constants.qaVersion + 'alpha_base');	
	EXPORT INCOMING_ALPHA  				:= DATASET( email_Base_SF_PROD, Layouts.incoming_alpha, THOR);
	
	EXPORT ALPHA_BASE							:= dataset(Constants.base_prefix_name+'alpha', Layouts.base, thor);
	EXPORT BOCA_BASE							:= dataset(Constants.base_prefix_name+'boca', Layouts.base, thor);
	
	EXPORT Combined_Base    			:= ALPHA_BASE + BOCA_BASE;
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

