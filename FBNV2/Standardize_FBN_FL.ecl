import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_FL:=
module
 
	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess Florida Filing data.
	// -- Standardize & clean the data fields.
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcessFiling(string 																	 pversion,
													 boolean																	 pOverwrite		= false,
													 dataset(Layout_File_FL_in.Sprayed.Filing) pRawFilingInput	= FBNV2.File_FL_Filing_in.raw) :=
	function
			dFL_Filing_in          := pRawFilingInput;

			//*** Normalize the child owner records.
			Layout_File_FL_in.Temporary.Filing_Norm_Out trfNormOwner(dFL_Filing_in l, integer c) := transform,
																															skip (trim(l.FIC_OWNERS[c].FIC_OWNER_DOC_NUM) = '' and
																																		trim(l.FIC_OWNERS[c].FIC_OWNER_NAME) = ''
																																	 )
					self.seq				  						:= (string) c;
					self.FIC_OWNER_DOC_NUM 				:= trim(l.FIC_OWNERS[c].FIC_OWNER_DOC_NUM);
					self.FIC_OWNER_NAME 	  	 		:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_NAME));
					self.FIC_OWNER_NAME_FORMAT  	:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_NAME_FORMAT));
					self.FIC_OWNER_ADDR 	  		 	:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_ADDR));
					self.FIC_OWNER_CITY 	  		 	:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_CITY));
					self.FIC_OWNER_STATE   		 		:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_STATE));
					self.FIC_OWNER_ZIP5				 		:= trim(l.FIC_OWNERS[c].FIC_OWNER_ZIP5);
					self.FIC_OWNER_ZIP4				 		:= trim(l.FIC_OWNERS[c].FIC_OWNER_ZIP4);
					self.FIC_OWNER_COUNTRY 		 		:= stringlib.stringtouppercase(trim(l.FIC_OWNERS[c].FIC_OWNER_COUNTRY));
					self.FIC_OWNER_FEI_NUM 		 		:= trim(l.FIC_OWNERS[c].FIC_OWNER_FEI_NUM);
					self.FIC_OWNER_CHARTER_NUM  	:= trim(l.FIC_OWNERS[c].FIC_OWNER_CHARTER_NUM);
					self              						:= l;
			end;
			
			norm_file := normalize(dFL_Filing_in, 
														 //if(trim(left.FIC_GREATER_THAN__OWNERS,left,right) = 'Y',10,(unsigned)left.FIC_FIL_TOTAL_OWN_CUR_CTR)
														 10
														 ,trfNormOwner(left,counter));

			//*** Transforming the normalized records and propagate the prep addr fields.
			Layout_File_FL_in.Cleaned.Filing tFiling(norm_file l) := transform																						
				self.process_date 						:= trim(pversion);
				self.FIC_FIL_DOC_NUM					:= trim(l.FIC_FIL_DOC_NUM,left,right);
				self.FIC_FIL_NAME 						:= stringlib.stringtouppercase(trim(l.FIC_FIL_NAME));
				self.FIC_FIL_COUNTY						:= stringlib.stringtouppercase(trim(l.FIC_FIL_COUNTY));
				self.FIC_FIL_ADDR1						:= stringlib.stringtouppercase(trim(l.FIC_FIL_ADDR1));
				self.FIC_FIL_ADDR2						:= stringlib.stringtouppercase(trim(l.FIC_FIL_ADDR2));
				self.FIC_FIL_CITY							:= stringlib.stringtouppercase(trim(l.FIC_FIL_CITY));
				self.FIC_FIL_STATE						:= stringlib.stringtouppercase(trim(l.FIC_FIL_STATE));
				self.FIC_FIL_ZIP5							:= trim(l.FIC_FIL_ZIP5,left,right);
				self.FIC_FIL_ZIP4							:= trim(l.FIC_FIL_ZIP4,left,right);
				self.FIC_FIL_COUNTRY					:= stringlib.stringtouppercase(trim(l.FIC_FIL_COUNTRY));
				self.FIC_FIL_COUNTRY_DEC			:= FBNV2.FBN_Code_Desc_Tables.FL_Country(l.FIC_FIL_COUNTRY);
				
				self.FIC_FIL_DATE							:= trim(l.FIC_FIL_DATE[5..8]) + trim(l.FIC_FIL_DATE[1..4]);				
				self.FIC_FIL_PAGES						:= stringlib.stringtouppercase(l.FIC_FIL_PAGES);
				self.FIC_FIL_STATUS						:= stringlib.stringtouppercase(l.FIC_FIL_STATUS);
				self.FIC_FIL_STATUS_DEC 			:= map(stringlib.stringtouppercase(l.FIC_FIL_STATUS) = 'C' => 'CANCELLED',
																						 stringlib.stringtouppercase(l.FIC_FIL_STATUS) = 'E' => 'EXPIRED',
																						 stringlib.stringtouppercase(l.FIC_FIL_STATUS) = 'A' => 'ACTIVE',
																						 '');
				self.FIC_FIL_CANCELLATION_DATE:= trim(l.FIC_FIL_CANCELLATION_DATE[5..8]) + trim(l.FIC_FIL_CANCELLATION_DATE[1..4]);
				self.FIC_FIL_EXPIRATION_DATE	:= trim(l.FIC_FIL_EXPIRATION_DATE[5..8]) + trim(l.FIC_FIL_EXPIRATION_DATE[1..4]);
				
				self.FIC_FIL_TOTAL_OWN_CUR_CTR:= trim(l.FIC_FIL_TOTAL_OWN_CUR_CTR);
				self.FIC_FIL_FEI_NUM					:= stringlib.stringtouppercase(trim(l.FIC_FIL_FEI_NUM));
				self.FIC_GREATER_THAN__OWNERS	:= stringlib.stringtouppercase(trim(l.FIC_GREATER_THAN__OWNERS));
				
				self.FIC_OWNER_DOC_NUM 				:= trim(l.FIC_OWNER_DOC_NUM);
				self.FIC_OWNER_NAME 	  	 		:= stringlib.stringtouppercase(trim(l.FIC_OWNER_NAME));
				self.FIC_OWNER_NAME_FORMAT  	:= stringlib.stringtouppercase(trim(l.FIC_OWNER_NAME_FORMAT));
				self.FIC_OWNER_ADDR 	  		 	:= stringlib.stringtouppercase(trim(l.FIC_OWNER_ADDR));
				self.FIC_OWNER_CITY 	  		 	:= stringlib.stringtouppercase(trim(l.FIC_OWNER_CITY));
				self.FIC_OWNER_STATE   		 		:= stringlib.stringtouppercase(trim(l.FIC_OWNER_STATE));
				self.FIC_OWNER_ZIP5				 		:= trim(l.FIC_OWNER_ZIP5);
				self.FIC_OWNER_ZIP4				 		:= trim(l.FIC_OWNER_ZIP4);
				self.FIC_OWNER_COUNTRY 		 		:= stringlib.stringtouppercase(trim(l.FIC_OWNER_COUNTRY));
				self.FIC_OWNER_COUNTRY_DEC 		:= FBNV2.FBN_Code_Desc_Tables.FL_Country(l.FIC_OWNER_COUNTRY);
				self.FIC_OWNER_FEI_NUM 		 		:= trim(l.FIC_OWNER_FEI_NUM);
				self.FIC_OWNER_CHARTER_NUM  	:= trim(l.FIC_OWNER_CHARTER_NUM);
								
				self.p_owner_name							:= if (stringlib.stringtouppercase(trim(l.FIC_OWNER_NAME_FORMAT)) = 'P',
																						 stringlib.stringtouppercase(address.CleanPerson73(trim(l.FIC_OWNER_NAME,left,right))), '');
				self.c_owner_name							:= if (stringlib.stringtouppercase(trim(l.FIC_OWNER_NAME_FORMAT)) = 'C',
																						 stringlib.stringtouppercase(l.FIC_OWNER_NAME), '');
				
				self.prep_addr_line1 					:= address.Addr1FromComponents(
																						stringlib.stringtouppercase(trim(l.FIC_FIL_ADDR1,left,right))
																						,stringlib.stringtouppercase(trim(l.FIC_FIL_ADDR2,left,right))
																						,''
																						,''
																						,''
																						,''
																						,'');
				self.prep_addr_line_last 			:= address.Addr2FromComponents(
																						stringlib.stringtouppercase(trim(l.FIC_FIL_CITY ))
																						,stringlib.stringtouppercase(trim(l.FIC_FIL_STATE))
																						,trim(l.FIC_FIL_ZIP5));
																						
				self.prep_owner_addr_line1 		:= address.Addr1FromComponents(
																						stringlib.stringtouppercase(trim(l.FIC_OWNER_ADDR,left,right))
																						,''
																						,''
																						,''
																						,''
																						,''
																						,'');
				self.prep_owner_addr_line_last:= address.Addr2FromComponents(
																						stringlib.stringtouppercase(trim(l.FIC_OWNER_CITY ))
																						,stringlib.stringtouppercase(trim(l.FIC_OWNER_STATE))
																						,l.FIC_OWNER_ZIP5);
				
				self 													:= l;
				self 													:= [];
			end;
	
			PrepFilings := project(norm_file, tFiling(left));
			
			logicalfile_filing := '~thor_data400::in::fbnv2::FL::Filing::'+pversion+'::Cleaned';
			
			VersionControl.macBuildNewLogicalFile(logicalfile_filing	,PrepFilings	,filing_out		,false,,pOverwrite);		
	
			mapped_Filing 	:= 	sequential(filing_out);
			source					:= 'Filing';
			superfilename 	:= FBNV2.Get_Update_SupperFilename(source);
			Create_Super		:= FileServices.CreateSuperFile(superfilename,false);
			
			result := 
				sequential(
					mapped_Filing
					,if(~FileServices.FileExists(superfilename), Create_Super)
					//,FileServices.StartSuperFileTransaction()
					,fileservices.clearSuperFile(superfilename)
					,fileservices.addsuperfile(superfilename,logicalfile_filing)
			   	//,FileServices.FinishSuperFileTransaction()								  
				);	

			return result;
	end;
	

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess Florida EVENT records..
	// -- Standardize and clean the data fields.
	//////////////////////////////////////////////////////////////////////////////////////
	export fPreProcessEvent(string 																	 pversion,
													boolean																	 pOverwrite	= false,
													dataset(Layout_File_FL_in.Sprayed.Event) pRawEventInput = FBNV2.File_FL_Event_in.raw) :=
	function
	
			dFL_Event_in          := pRawEventInput;
			
			Layout_File_FL_in.Cleaned.Event tEvent(dFL_Event_in l) := transform
			
					self.process_date 					:= trim(pversion);
					self.EVENT_DOC_NUMBER 			:= stringlib.stringtouppercase(trim(l.EVENT_DOC_NUMBER));
					self.EVENT_ORIG_DOC_NUMBER 	:= stringlib.stringtouppercase(trim(l.EVENT_ORIG_DOC_NUMBER));
					self.EVENT_FIC_NAME 				:= stringlib.stringtouppercase(trim(l.EVENT_FIC_NAME));
					self.EVENT_ACTION_CTR 			:= stringlib.stringtouppercase(trim(l.EVENT_ACTION_CTR));
					
					self.EVENT_SEQ_NUMBER 			:= regexreplace('^0+',l.EVENT_SEQ_NUMBER,'');
					self.EVENT_PAGES 						:= regexreplace('^0+',l.EVENT_PAGES,'');
					self.EVENT_DATE 						:= trim(l.EVENT_DATE[5..8]) + trim(l.EVENT_DATE[1..4]);
					self.ACTION_SEQ_NUMBER 			:= regexreplace('^0+',l.ACTION_SEQ_NUMBER,'');
					self.ACTION_CODE 						:= trim(l.ACTION_CODE);
					self.ACTION_VERBAGE 				:= FBNV2.FBN_Code_Desc_Tables.FL_History(l.ACTION_CODE);
					self.ACTION_OLD_FEI 				:= if ((integer)trim(l.ACTION_OLD_FEI) <> 0, trim(l.ACTION_OLD_FEI), '');
					self.ACTION_OLD_COUNTY 			:= stringlib.stringtouppercase(trim(l.ACTION_OLD_COUNTY));
					self.ACTION_OLD_ADDR1 			:= stringlib.stringtouppercase(trim(l.ACTION_OLD_ADDR1));
					self.ACTION_OLD_ADDR2 			:= stringlib.stringtouppercase(trim(l.ACTION_OLD_ADDR2));
					self.ACTION_OLD_CITY 				:= stringlib.stringtouppercase(trim(l.ACTION_OLD_CITY));
					self.ACTION_OLD_STATE 			:= stringlib.stringtouppercase(trim(l.ACTION_OLD_STATE));
					self.ACTION_OLD_ZIP5 				:= stringlib.stringfilter(l.ACTION_OLD_ZIP5,'1234567890');
					self.ACTION_OLD_ZIP4 				:= stringlib.stringfilter(l.ACTION_OLD_ZIP4,'1234567890');
					self.ACTION_OLD_COUNTRY 		:= stringlib.stringtouppercase(trim(l.ACTION_OLD_COUNTRY));
					self.ACTION_OLD_COUNTRY_DESC:= FBNV2.FBN_Code_Desc_Tables.FL_Country(l.ACTION_OLD_COUNTRY);
					
					self.ACTION_NEW_FEI 				:= if ((integer)trim(l.ACTION_NEW_FEI) <> 0, trim(l.ACTION_NEW_FEI), '');
					self.ACTION_NEW_COUNTY 			:= stringlib.stringtouppercase(trim(l.ACTION_NEW_COUNTY));					
					self.ACTION_NEW_ADDR1 			:= stringlib.stringtouppercase(trim(l.ACTION_NEW_ADDR1));
					self.ACTION_NEW_ADDR2 			:= stringlib.stringtouppercase(trim(l.ACTION_NEW_ADDR2));
					self.ACTION_NEW_CITY 				:= stringlib.stringtouppercase(trim(l.ACTION_NEW_CITY));
					self.ACTION_NEW_STATE 			:= stringlib.stringtouppercase(trim(l.ACTION_NEW_STATE));
					self.ACTION_NEW_ZIP5 				:= stringlib.stringfilter(l.ACTION_NEW_ZIP5,'1234567890');
					self.ACTION_NEW_ZIP4 				:= stringlib.stringfilter(l.ACTION_NEW_ZIP4,'1234567890');
					self.ACTION_NEW_COUNTRY			:= stringlib.stringtouppercase(trim(l.ACTION_NEW_COUNTRY));
					self.ACTION_NEW_COUNTRY_DESC:= FBNV2.FBN_Code_Desc_Tables.FL_Country(l.ACTION_NEW_COUNTRY);
					
					self.ACTION_OWN_NAME 				:= stringlib.stringtouppercase(trim(l.ACTION_OWN_NAME));
					self.ACTION_OWN_ADDRESS 		:= stringlib.stringtouppercase(trim(l.ACTION_OWN_ADDRESS));
					self.ACTION_OWN_CITY 				:= stringlib.stringtouppercase(trim(l.ACTION_OWN_CITY));
					self.ACTION_OWN_STATE 			:= stringlib.stringtouppercase(trim(l.ACTION_OWN_STATE));
					self.ACTION_OWN_ZIP5 				:= stringlib.stringfilter(l.ACTION_OWN_ZIP5,'1234567890');
					self.ACTION_OWN_FEI 				:= trim(l.ACTION_OWN_FEI);
					self.ACTION_OWN_CHARTER_NUMBER := trim(l.ACTION_OWN_CHARTER_NUMBER);
					self.ACTION_OLD_NAME_SEQ 		:= regexreplace('^0+',l.ACTION_OLD_NAME_SEQ,'');
					self.ACTION_NEW_NAME_SEQ 		:= regexreplace('^0+',l.ACTION_NEW_NAME_SEQ,'');
					
					self.prep_old_addr_line1 := address.Addr1FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_OLD_ADDR1,left,right))
																							,stringlib.stringtouppercase(trim(l.ACTION_OLD_ADDR2,left,right))
																							,''
																							,''
																							,''
																							,''
																							,'');
					self.prep_old_addr_line_last := address.Addr2FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_OLD_CITY ))
																							,stringlib.stringtouppercase(trim(l.ACTION_OLD_STATE))
																							,stringlib.stringfilter(l.ACTION_OLD_ZIP5,'1234567890'));
					
					self.prep_new_addr_line1 := address.Addr1FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_NEW_ADDR1,left,right))
																							,stringlib.stringtouppercase(trim(l.ACTION_NEW_ADDR2,left,right))
																							,''
																							,''
																							,''
																							,''
																							,'');
					self.prep_new_addr_line_last := address.Addr2FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_NEW_CITY ))
																							,stringlib.stringtouppercase(trim(l.ACTION_NEW_STATE))
																							,stringlib.stringfilter(l.ACTION_NEW_ZIP5,'1234567890'));
																							
					self.prep_owner_addr_line1 := address.Addr1FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_OWN_ADDRESS,left,right))
																							,''
																							,''
																							,''
																							,''
																							,''
																							,'');
					self.prep_owner_addr_line_last := address.Addr2FromComponents(
																							stringlib.stringtouppercase(trim(l.ACTION_OWN_CITY ))
																							,stringlib.stringtouppercase(trim(l.ACTION_OWN_STATE))
																							,stringlib.stringfilter(l.ACTION_OWN_ZIP5,'1234567890'));
			
					self 												:= l;
					self 												:= [];
			end;
	
			PrepEvent := project(dFL_Event_in, tEvent(left));
			
			Address.Mac_Is_Business(PrepEvent(ACTION_OWN_NAME != ''), ACTION_OWN_NAME, dClean_Name, name_flag, false, true );

			cln_layout := RECORD
				Layout_File_FL_in.Cleaned.Event;
				string1		name_flag;
				string5		cln_title;
				string20	cln_fname;
				string20	cln_mname;
				string20	cln_lname;
				string5		cln_suffix;
				string5		cln_title2;
				string20	cln_fname2;
				string20	cln_mname2;
				string20	cln_lname2;
				string5		cln_suffix2;
			END;
				
			dNameBlank	:=      project(PrepEvent(ACTION_OWN_NAME = ''),transform(cln_layout,self	:=	left; self	:=	[]));
			dCleanName	:=      dClean_Name   +  dNameBlank;

			Layout_File_FL_in.Cleaned.Event  CleanUpName( dCleanName  l) := transform
				self.owner_title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																										l.name_flag = 'U' => l.owner_title, 
																										''
																									);
				self.owner_fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																										l.name_flag = 'U' => l.owner_fname, 
																										''
																									);
				self.owner_mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																										l.name_flag = 'U' => l.owner_mname, 
																										''
																									);
				self.owner_lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																										l.name_flag = 'U' => l.owner_lname, 
																										''
																									 );
				self.owner_name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																										l.name_flag = 'U' => l.owner_name_suffix, 
																										''
																									);
				self.CName			:= if(l.name_flag = 'B',
															trim(l.ACTION_OWN_NAME,left,right),
															'');	
				self						:=	l;
				self						:=	[];
			end;		
							
			Clean_Event_Names	:=project(dCleanName ,CleanUpName(left));
			
			logicalfile_event := '~thor_data400::in::fbnv2::FL::Event::'+pversion+'::Cleaned';
			
			//VersionControl.macBuildNewLogicalFile(logicalfile_event	,Clean_Event_Names	,Event_out		,,,pOverwrite);	
			VersionControl.macBuildNewLogicalFile(logicalfile_event	,Clean_Event_Names	,Event_out		,false,,pOverwrite);
	
			mapped_Event 	:= 	sequential(Event_out);
			source				:= 'Event';
			superfilename := FBNV2.Get_Update_SupperFilename(source);
			Create_Super		:= FileServices.CreateSuperFile(superfilename,false);
			
			result := 
				sequential(
					mapped_Event
					,if(~FileServices.FileExists(superfilename), Create_Super)
					//,FileServices.StartSuperFileTransaction()
					,fileservices.clearSuperFile( superfilename)
					,fileservices.addsuperfile( superfilename,logicalfile_event)
					//,FileServices.FinishSuperFileTransaction()
				);	
			
			return result;
	end;
	
end;