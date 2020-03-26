export _ErrMsg(boolean isFCRA=false , string pVersion='' )  := module

shared fcra_str := if(isFCRA, 'FCRA','Non-FCRA');

shared 	Err_Msg_No_Riskwise_Input   := if (Inql_v2._Flags(isFCRA).Exist_Riskwise_FilesToProcess,'', 'There is no '+ fcra_str + ' Riskkwise Input File to process');   
shared 	Err_Msg_No_Accurint_Input   := if (Inql_v2._Flags(isFCRA).Exist_Accurint_FilesToProcess,'', 'There is no '+ fcra_str + ' Accurint Input File to process');  
shared 	Err_Msg_No_Batch_Input   		:= if (Inql_v2._Flags(isFCRA).Exist_Batch_FilesToProcess,   '', 'There is no '+ fcra_str + ' Batch Input File to process');  
shared 	Err_Msg_No_BatchR3_Input   	:= if (Inql_v2._Flags(isFCRA).Exist_BatchR3_FilesToProcess, '', 'There is no '+ fcra_str + ' BatchR3 Input File to process'); 
shared 	Err_Msg_No_Custom_Input   	:= if (Inql_v2._Flags(isFCRA).Exist_Custom_FilesToProcess, 	'', 'There is no '+ fcra_str + ' Custom Input File to process'); 
shared 	Err_Msg_No_IDM_Input   			:= if (Inql_v2._Flags(isFCRA).Exist_IDM_FilesToProcess, 		'', 'There is no '+ fcra_str + ' IDM Input File to process'); 
shared 	Err_Msg_No_SBA_Input   			:= if (Inql_v2._Flags(isFCRA).Exist_SBA_FilesToProcess, 		'', 'There is no '+ fcra_str + ' SBA Input File to process'); 
shared 	Err_Msg_No_Banko_Input   		:= if (Inql_v2._Flags(isFCRA).Exist_Banko_FilesToProcess, 	'', 'There is no '+ fcra_str + ' Banko Input File to process'); 
shared 	Err_Msg_No_Bridger_Input   	:= if (Inql_v2._Flags(isFCRA).Exist_Bridger_FilesToProcess, '', 'There is no '+ fcra_str + ' Bridger Input File to process'); 

export 	Err_Msg_NonFCRA_Daily_Base_Build_Active  	:= if (Inql_v2._Versions.NonFCRA_Daily_Base_Build_ActiveWU='',''
																												,'Non-FCRA Daily Base Build is being executed already - ' + Inql_v2._Versions.NonFCRA_Daily_Base_Build_ActiveWU);

export 	Err_Msg_FCRA_Daily_Base_Build_Active  		:= if (Inql_v2._Versions.FCRA_Daily_Base_Build_ActiveWU='',''
																												,'FCRA Daily Base Build is being executed already ' + Inql_v2._Versions.FCRA_Daily_Base_Build_ActiveWU);

shared 	Err_Msg_NonFCRA_Daily_Base_Version    		:= if (Inql_v2._Flags(isFCRA).NonFCRA_Daily_Base_Version_OK, ''
																												,'Non-FCRA Daily Base Build Version is not valid'); 

export 	Err_Msg_FCRA_Daily_Base_Version  					:= if (Inql_v2._Flags(isFCRA).FCRA_Daily_Base_Version_OK,''
																												,'FCRA Daily Base Build Version is not valid'); 

export  Err_Msg_NonFCRA_Weekly_Base_Build_Active 	:= if (Inql_v2._Versions.NonFCRA_Weekly_Base_Build_ActiveWU='','', 'Non-FCRA Weekly Base Build is being executed already - ' + Inql_v2._Versions.NonFCRA_Weekly_Base_Build_ActiveWU);
export 	Err_Msg_NonFCRA_Weekly_Base_Version 			:= if (Inql_v2._Flags(isFCRA).NonFCRA_Weekly_Base_Version_OK, '', 'Non-FCRA Weekly Base Build Version is not valid'); 
export 	Err_Msg_NonFCRA_Weekly_Base_Age     			:= if (Inql_v2._Flags(isFCRA).nonFCRA_Daily_Base_Aged, '', 'Non-FCRA Daily Base is not aged'); 

export  Err_Msg_FCRA_Weekly_Base_Build_Active 		:= if (Inql_v2._Versions.FCRA_Weekly_Base_Build_ActiveWU='','', 'FCRA Weekly Base Build is being executed already - ' + Inql_v2._Versions.FCRA_Weekly_Base_Build_ActiveWU);
export 	Err_Msg_FCRA_Weekly_Base_Version 					:= if (Inql_v2._Flags(isFCRA).FCRA_Weekly_Base_Version_OK, '', 'FCRA Weekly Base Build Version is not valid'); 
export 	Err_Msg_FCRA_Weekly_Base_Age     					:= if (Inql_v2._Flags(isFCRA).FCRA_Daily_Base_Aged, '', 'FCRA Daily Base is not aged');

export 	Err_Msg_NonFCRA_Keys_Build_Active 				:= if (Inql_v2._Versions.NonFCRA_Weekly_Keys_Build_ActiveWU='','', 'Non-FCRA Weekly Keys Build is being executed already - ' + Inql_v2._Versions. NonFCRA_Weekly_Keys_Build_ActiveWU);
export 	Err_Msg_NonFCRA_Keys_Version 							:= if (Inql_v2._Flags(isFCRA).NonFCRA_Keys_Version_OK, '', 'Non-FCRA Keys Build Version is not valid'); 
export 	Err_Msg_NonFCRA_Keys_NotInQA  						:= if (INQL_v2._Versions.thor_nonfcra_keys <> INQL_v2._Versions.dops_nonfcra_keys_certQA
																												,'', INQL_v2._Versions.thor_nonfcra_keys + ' InquiryTable Keys are not in CertQA yet'); 
export 	Err_Msg_NonFCRA_Keys_NotApproved					:= if (INQL_v2._Versions.thor_nonfcra_keys = INQL_v2._Versions.dops_nonfcra_keys_certQA and
																												INQL_v2._Versions.dops_nonfcra_keys_certQA  <> INQL_v2._Versions.dops_nonfcra_keys_prod  
																												,'', INQL_v2._Versions.thor_nonfcra_keys + ' InquiryTable Keys are not approved yet'); 

export Err_Msg_NonFCRA_Update_Keys_Build_Active 	:= if (Inql_v2._Versions.NonFCRA_Daily_Keys_Build_ActiveWU='','', 'Non-FCRA Update Keys Build is being executed already - ' + Inql_v2._Versions.NonFCRA_Daily_Keys_Build_ActiveWU);
export Err_Msg_NonFCRA_Update_Keys_Version 				:= if (Inql_v2._Flags(isFCRA).NonFCRA_Update_Keys_Version_OK, '', 'Non-FCRA Update Keys Build Version is not valid'); 
export Err_Msg_NonFCRA_Update_Keys_NotInQA  			:= if (INQL_v2._Versions.thor_nonfcra_update_keys <> INQL_v2._Versions.dops_nonfcra_update_keys_certQA
																												,'', INQL_v2._Versions.thor_nonfcra_update_keys + ' InquiryUpdateTable Keys are not in CertQA yet'); 
export Err_Msg_NonFCRA_Update_Keys_NotApproved		:= if (INQL_v2._Versions.thor_nonfcra_update_keys = INQL_v2._Versions.dops_nonfcra_update_keys_certQA and
																												 INQL_v2._Versions.dops_nonfcra_update_keys_certQA  <> INQL_v2._Versions.dops_nonfcra_update_keys_prod  
																												,'', INQL_v2._Versions.thor_nonfcra_update_keys + ' InquiryUpadteTable Keys are not approved yet'); 

export Err_Msg_FCRA_Keys_Build_Active 						:= if (Inql_v2._Versions.FCRA_Weekly_Keys_Build_ActiveWU='','', 'FCRA Weekly Keys Build is being executed already - ' + Inql_v2._Versions.FCRA_Weekly_Keys_Build_ActiveWU);
export Err_Msg_FCRA_Keys_Version 									:= if (Inql_v2._Flags(isFCRA).FCRA_Keys_Version_OK, '', 'FCRA Keys Build Version is not valid'); 
export Err_Msg_FCRA_Keys_NotInQA  								:= if (INQL_v2._Versions.thor_fcra_keys <> INQL_v2._Versions.dops_fcra_keys_certQA
																													,'', INQL_v2._Versions.thor_fcra_keys + ' FCRA_InquiryTable Keys are not in CertQA yet'); 
export Err_Msg_FCRA_Keys_NotApproved							:= if (	INQL_v2._Versions.thor_fcra_keys = INQL_v2._Versions.dops_fcra_keys_certQA and
																													INQL_v2._Versions.dops_fcra_keys_certQA  <> INQL_v2._Versions.dops_fcra_keys_prod  
																													,'', INQL_v2._Versions.thor_fcra_keys + ' FCRA_InquiryTable Keys are not approved yet'); 


Export Build_NonFcra_Daily_Base_ErrMsgs  				:= stringlib.stringcleanspaces
																									(
																										Err_Msg_NonFCRA_Daily_Base_Build_Active +
																										if( Err_Msg_No_Riskwise_Input 		<> '' ,'\n\n'+ Err_Msg_No_Riskwise_Input,'') +
																										if( Err_Msg_No_Accurint_Input 		<> '' ,'\n\n'+ Err_Msg_No_Accurint_Input,'') +
																										if( Err_Msg_No_Batch_Input    		<> '' ,'\n\n'+ Err_Msg_No_Batch_Input,'') +
																										if( Err_Msg_No_BatchR3_Input  		<> '' ,'\n\n'+ Err_Msg_No_BatchR3_Input,'') +
																										if( Err_Msg_No_Custom_Input   		<> '' ,'\n\n'+ Err_Msg_No_Custom_Input,'') +
																									//	if( Err_Msg_No_IDM_Input   				<> '' ,'\n\n'+ Err_Msg_No_IDM_Input,'') +
																										if( Err_Msg_No_SBA_Input   				<> '' ,'\n\n'+ Err_Msg_No_SBA_Input,'') +
																										if( Err_Msg_NonFCRA_Daily_Base_Version    <> '' ,'\n\n'+ Err_Msg_NonFCRA_Daily_Base_Version,'')
																									);
																						
Export Build_NonFcra_Weekly_Base_ErrMsgs  			:= stringlib.stringcleanspaces
																									(
																										Err_Msg_NonFCRA_Weekly_Base_Build_Active +
																										if (Err_Msg_NonFCRA_Weekly_Base_Age    		 <> '' ,'\n\n'+ Err_Msg_NonFCRA_Weekly_Base_Age,'') + 
																										if (Err_Msg_NonFCRA_Keys_NotInQA    	     <> '' ,'\n\n'+ Err_Msg_NonFCRA_Keys_NotInQA,'') +	
																										if (Err_Msg_NonFCRA_Keys_NotApproved	     <> '' ,'\n\n'+ Err_Msg_NonFCRA_Keys_NotApproved,'')
																									);																							

Export Build_NonFCRA_Update_Keys_ErrMsgs  			:= stringlib.stringcleanspaces
																									(
																										Err_Msg_NonFCRA_Update_Keys_Build_Active +
																										if (Err_Msg_NonFCRA_Update_Keys_Version    	<> '' ,'\n\n'+ Err_Msg_NonFCRA_Update_Keys_Version,'') +
																										if (Err_Msg_NonFCRA_Update_Keys_NotInQA    	<> '' ,'\n\n'+ Err_Msg_NonFCRA_Update_Keys_NotInQA,'') +	
																										if (Err_Msg_NonFCRA_Update_Keys_NotApproved <> '' ,'\n\n'+ Err_Msg_NonFCRA_Update_Keys_NotApproved,'')
																									);

Export Build_NonFCRA_Keys_ErrMsgs  							:= stringlib.stringcleanspaces
																									(
																										Err_Msg_NonFCRA_Keys_Build_Active +
																										if (Err_Msg_NonFCRA_Keys_Version    	<> '' ,'\n\n'+ Err_Msg_NonFCRA_Keys_Version,'') +
																										if (Err_Msg_NonFCRA_Keys_NotInQA    	<> '' ,'\n\n'+ Err_Msg_NonFCRA_Keys_NotInQA,'') +	
																										if (Err_Msg_NonFCRA_Keys_NotApproved	<> '' ,'\n\n'+ Err_Msg_NonFCRA_Keys_NotApproved,'')
																									);

Export Build_FCRA_Daily_Base_ErrMsgs  					:= stringlib.stringcleanspaces
																									(
																										Err_Msg_FCRA_Daily_Base_Build_Active +
																										if( Err_Msg_No_Riskwise_Input 		<> '' ,'\n\n'+ Err_Msg_No_Riskwise_Input,'') +
																										if( Err_Msg_No_Accurint_Input 		<> '' ,'\n\n'+ Err_Msg_No_Accurint_Input,'') +
																										if( Err_Msg_No_Batch_Input    		<> '' ,'\n\n'+ Err_Msg_No_Batch_Input,'') +
																										if( Err_Msg_No_BatchR3_Input  		<> '' ,'\n\n'+ Err_Msg_No_BatchR3_Input,'') +
																										if (Err_Msg_FCRA_Daily_Base_Version    <> '' ,'\n\n'+ Err_Msg_FCRA_Daily_Base_Version,'')
																									);

Export Build_FCRA_Weekly_Base_ErrMsgs  					:= stringlib.stringcleanspaces
																									(
																										Err_Msg_FCRA_Weekly_Base_Build_Active +
																										if (Err_Msg_FCRA_Weekly_Base_Version    <> '' ,'\n\n'+ Err_Msg_FCRA_Weekly_Base_Version,'') +
																										if (Err_Msg_FCRA_Weekly_Base_Age    		<> '' ,'\n\n'+ Err_Msg_FCRA_Weekly_Base_Age,'') 																							
																									);	

Export Build_FCRA_Keys_ErrMsgs  								:= stringlib.stringcleanspaces
																									(
																										Err_Msg_FCRA_Keys_Build_Active +
																										if (Err_Msg_FCRA_Keys_Version    	<> '' ,'\n\n'+ Err_Msg_FCRA_Keys_Version,'') +
																										if (Err_Msg_FCRA_Keys_NotInQA    	<> '' ,'\n\n'+ Err_Msg_FCRA_Keys_NotInQA,'') +	
																										if (Err_Msg_FCRA_Keys_NotApproved	<> '' ,'\n\n'+ Err_Msg_FCRA_Keys_NotApproved,'')
																									);
																				
end;