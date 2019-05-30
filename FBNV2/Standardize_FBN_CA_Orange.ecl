import ut,fbnv2,address,VersionControl,std;

export Standardize_FBN_CA_Orange(	 
	string														pversion
	,boolean													pOverwrite			= false																															
	,dataset(Layout_File_CA_Orange_in.Sprayed	)	pSprayed_CA_Orange_File		= FBNV2.File_CA_Orange_in.raw
) :=
function

	dFiling			            := dedup(pSprayed_CA_Orange_File,all);
	
	layout_temp := record
			layout_file_ca_orange_in.cleaned;
			string80 full_name;
	end;

	layout_temp tFiling(dFiling l) := transform
			string25 fname 					:= if (trim(l.First_Name) = '' or 
																		 stringlib.stringtouppercase(trim(l.First_Name)) = 'NULL', '',
																		 stringlib.stringtouppercase(trim(l.First_Name)));
			string20 mname 					:= if (trim(l.MIDDLE_NAME) = '' or 
																		 stringlib.stringtouppercase(trim(l.MIDDLE_NAME)) = 'NULL', '',
																		 stringlib.stringtouppercase(trim(l.MIDDLE_NAME)));
																		 
			string35 lname_comp			:= if (trim(l.LAST_NAME_COMPANY) = '' or 
																		 stringlib.stringtouppercase(trim(l.LAST_NAME_COMPANY)) = 'NULL', '',
																		 stringlib.stringtouppercase(trim(l.LAST_NAME_COMPANY)));
																		 
			addr_city								:= if (stringlib.stringtouppercase(trim(l.CITY)) = 'NONE','',stringlib.stringtouppercase(trim(l.CITY)));
			addr_st									:= if (stringlib.stringtouppercase(trim(l.STATE))  = 'NONE','',stringlib.stringtouppercase(trim(l.STATE)));
			string9	zip							:= stringlib.stringfilter(trim(l.ZIP_CODE),'1234567890');
			owner_city							:= if (stringlib.stringtouppercase(trim(l.OWNER_CITY)) = 'NONE','',stringlib.stringtouppercase(trim(l.OWNER_CITY)));
			owner_st								:= if (stringlib.stringtouppercase(trim(l.OWNER_STATE))  = 'NONE','',stringlib.stringtouppercase(trim(l.OWNER_STATE)));
			string9	owner_zip				:= stringlib.stringfilter(trim(l.OWNER_ZIP_CODE),'1234567890');
		
			self.process_date 			:= trim(pversion);
			self.REGIS_NBR 					:= if (stringlib.stringtouppercase(trim(l.REGIS_NBR)) in ['','NULL'],'',stringlib.stringtouppercase(trim(l.REGIS_NBR)));	
			self.BUSINESS_LETTER 		:= stringlib.stringtouppercase(trim(l.BUSINESS_LETTER));	
			self.BUSINESS_NAME 			:= stringlib.stringtouppercase(trim(l.BUSINESS_NAME));	
			self.ADDRESS 						:= stringlib.stringtouppercase(trim(l.ADDRESS));	
			self.CITY								:= trim(addr_city);
			self.STATE							:= trim(addr_st);	
			self.ZIP_CODE						:= zip;
			self.PHONE_NBR					:= stringlib.stringfilter(trim(l.PHONE_NBR),'1234567890');
			self.FILE_DATE					:= if (l.file_date[1] = '#', 
																				stringlib.stringfilter(trim(l.FILE_DATE)[2..11],'1234567890'),
																				Std.Date.ConvertDateFormat(trim(l.FILE_DATE))
																		 );	
			self.DOCETYEP 					:= stringlib.stringtouppercase(trim(l.DOCETYEP));	
			self.OWNER_NBR 					:= stringlib.stringtouppercase(trim(l.OWNER_NBR));	
			self.FIRST_NAME 				:= fname;	
			self.MIDDLE_NAME 				:= mname;	
			self.LAST_NAME_COMPANY 	:= lname_comp;	
			self.OWNER_ADDRESS 			:= stringlib.stringtouppercase(trim(l.OWNER_ADDRESS)) ;	
			self.OWNER_CITY 				:= trim(owner_city);	
			self.OWNER_STATE 				:= trim(owner_st);
			self.OWNER_ZIP_CODE 		:= owner_zip;	
			self.BUSINESS_TYPE 			:= stringlib.stringtouppercase(trim(l.BUSINESS_TYPE));
			self.prep_bus_addr_line1		 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.ADDRESS,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_bus_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(l.CITY ))
																					,stringlib.stringtouppercase(trim(l.STATE))
																					,zip[1..5]);
			self.prep_owner_addr_line1	 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.OWNER_ADDRESS,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_owner_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(l.OWNER_CITY ))
																					,stringlib.stringtouppercase(trim(l.OWNER_STATE))
																					,owner_zip[1..5]);
			self.full_name					:= trim(fname) +' '+ trim(mname) +' '+ trim(lname_comp);
			self 										:= l;
			self 										:= [];
	end;

	PrepFilings := project(dFiling, tFiling(left));
	
	Address.Mac_Is_Business(PrepFilings(trim(full_name) != ''), full_name, dClean_Name, name_flag, false, true );

	cln_layout := RECORD
		layout_temp;
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
		
	dNameBlank	:=      project(PrepFilings(trim(full_name) = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName	:=      dClean_Name   +  dNameBlank;

	layout_file_ca_orange_in.cleaned  CleanUpName( dCleanName  l) := transform
		self.title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								l.name_flag = 'U' => l.title, 
																								''
																							);
		self.fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								l.name_flag = 'U' => l.fname, 
																								''
																							);
		self.mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																								l.name_flag = 'U' => l.mname, 
																								''
																							);
		self.lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								l.name_flag = 'U' => l.lname, 
																								''
																							 );
		self.name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								l.name_flag = 'U' => l.name_suffix, 
																								''
																							);
		self.CName			:= if(l.name_flag = 'B',
													trim(l.LAST_NAME_COMPANY,left,right),
													''
												 );	
		self						:=	l;
		self						:=	[];
	end;		
					
	Clean_Filings_Names	:=project(dCleanName ,CleanUpName(left));
	
	logicalfile := '~thor_data400::in::fbnv2::CA::Orange::'+pversion+'::cleaned';
	
	VersionControl.macBuildNewLogicalFile(logicalfile	,Clean_Filings_Names	,filing_out		,,,pOverwrite);		
	
	mapped_Filing 	:= 	sequential(filing_out);
	source					:= 'ORANGE';
	superfilename 	:= FBNV2.Get_Update_SupperFilename(source);
	Create_Super		:= FileServices.CreateSuperFile(superfilename,false);
	
	result := 
		sequential(
			mapped_Filing
			,if(~FileServices.FileExists(superfilename), Create_Super)
			,fileservices.clearSuperFile( superfilename)
			,fileservices.addsuperfile( superfilename,logicalfile)								  
		);
	
	return result;
	
end;