import  Business_Header_SS, Business_Header, ut, did_add, MDR;

	BDID_Rec := record
	 Ingenix_NatlProf.layout_sanctions_bdid;
	 string2 source
	end;
	
	trimUpper(string s) := function
		return trim(stringlib.StringToUppercase(s),left,right);
	end;
	
	BDID_Rec BDIDs(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates l) := transform
		self.Bdid        := 0;
		self.BDID_Score  := 0;
		self.sanc_busnme := stringlib.StringToUppercase(trim(l.sanc_busnme,left,right));	
		self.SANC_TIN    := stringlib.stringfilter(l.SANC_TIN , '0123456789');
		self.source			 := MDR.sourceTools.src_Ingenix_Sanctions;
		self 			 			 := l;
	end;
	
	common_in := project(Ingenix_NatlProf.File_Sanctions_Cleaned_DIDed_dates, BDIDs(left));
	
	matchset 	:= ['A', 'F','N'];
	
	Business_Header_SS.MAC_Add_BDID_Flex(
			   common_in									 		          	    					  // Input Dataset						
				,matchset                                                  // BDID Matchset           
				,sanc_busnme       		             		                    // company_name	              
				,ProvCo_Address_Clean_prim_range		                     // prim_range		              
				,ProvCo_Address_Clean_prim_name		                      // prim_name		              
				,ProvCo_Address_Clean_zip 					                   // zip5					              
				,ProvCo_Address_Clean_sec_range		                    // sec_range		              
				,ProvCo_Address_Clean_st				                     // state				              
				,''		           					                          // phone				              
				,SANC_TIN                                          // fein              
				,bdid											 					              // bdid												
				,BDID_Rec	   							 											 // Output Layout 
				,true                         			            // output layout has bdid score field?                       
				,BDID_Score                                    // bdid_score                 
				,postBDID                                     // Output Dataset   
				,																             // deafult threscold
				,													 			            // use prod version of superfiles
				,															             // default is to hit prod from dataland, and on prod hit prod.		
				,BIPV2.xlink_version_set 			            // Create BIP Keys only
				,           								             // Url
				,								                        // Email
				,ProvCo_Address_Clean_p_city_name			 // City
				,Prov_Clean_fname					            // fname
				,Prov_Clean_mname			               // mname
				,Prov_Clean_lname		                // lname
				,                      						 // ssn
				,source														//sourceField
				,source_rec_id 			 						 //persistent_rec_id
				,                               // 
);

CurrentProcessDate	:=	max(postBDID,process_date);

MedSanctionSet	:=	['EXCLUSION','SUSPENSION AND FINE','TERMINATION'];
FedSanctionSet	:=	['DEBARRED/EXCLUDED','DEBARRED/SUSPENDED','EXCLUDED/DELETED','EXCLUDED'];

Ingenix_NatlProf.layout_sanctions_bdid tPropagateReinstateDate(BDID_Rec l)	:=	transform
		DerivedYear										:=	if (l.process_date[5..6]='12',(string)((integer)l.process_date[1..4] + 1),l.process_date[1..4]);
		DerivedMonth									:=	if (l.process_date[5..6]='12','01',intformat((integer)l.process_date[5..6] + 1,2,1));
		DerivedDate										:=	DerivedYear + DerivedMonth + '01'; 
		self.DerivedReinstateDate			:=	if(trimUpper(l.SANC_BRDTYPE)='MEDICAID BOARD' and trimUpper(l.SANC_SRC_DESC)='STATE MEDICAID BOARD' and l.SANC_REINDTE = '' and l.process_date<CurrentProcessDate,
																						DerivedDate,
																						if(trimUpper(l.SANC_BRDTYPE)='MEDICAL BOARD' and trimUpper(l.SANC_TYPE) in MedSanctionSet and l.SANC_REINDTE = '' and l.process_date<CurrentProcessDate,
																								DerivedDate,
																								if(trimUpper(l.SANC_BRDTYPE)='FEDERAL BOARDS' and trimUpper(l.SANC_SRC_DESC)='OFFICE OF PERSONNEL MANAGEMENT' and l.SANC_REINDTE = '' and l.SANC_SANCST = 'DC' and l.process_date<CurrentProcessDate,
																										DerivedDate,
																										if(trimUpper(l.SANC_BRDTYPE)='FEDERAL BOARDS' and trimUpper(l.SANC_TYPE) in FedSanctionSet and l.SANC_REINDTE = '' and l.SANC_SANCST = 'DC' and l.process_date<CurrentProcessDate,
																												derivedDate,
																												''
																											)
																									)
																							)
																				);
																			
		//self.SANC_REINDTE							:=	if (trim(l.SANC_REINDTE) = '' and trim(self.DerivedReinstateDate) <> '', trim(self.DerivedReinstateDate), trim(l.SANC_REINDTE));
		self.SANC_REINDTE_Form				:=	if (trim(l.SANC_REINDTE_Form) = '' and trim(self.DerivedReinstateDate) <> '', trim(self.DerivedReinstateDate), trim(l.SANC_REINDTE_Form));
																						
		self													:=	l;
end;		

export Sanctioned_providers_Bdid:= project(postBDID,tPropagateReinstateDate(left));
