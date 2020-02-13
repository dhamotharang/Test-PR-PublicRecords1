import ut, PromoteSupers, NID, Address, STD, MDR, AID, AID_Support, PRTE2, email_data, _control, tools;
dsEmailDataAlpha := project(Files.INCOMING_ALPhA, transform(Layouts.base, 
																														self.email_rec_key := Email_Data.Email_rec_key(left.clean_email,
																																																					 left.clean_address.prim_range,
																																																					 left.clean_address.prim_name, 	
																														  																						left.clean_address.sec_range, 
																																																					 left.clean_address.zip,
																																																					 left.Clean_Name.lname, 
																																																					 left.Clean_Name.fname
																																																					 );
																														self := left;
																														self := [];
																														));
																														
addGlobal_SID_Alpha			:= MDR.macGetGlobalSid(dsEmailDataAlpha, 'EmailDataV2', 'email_src', 'global_sid');																
PromoteSupers.Mac_SF_BuildProcess(addGlobal_SID_Alpha,Constants.base_prefix_name+'alpha'	,alpha_base,,,true);		
export proc_build_alpha := alpha_base;				
