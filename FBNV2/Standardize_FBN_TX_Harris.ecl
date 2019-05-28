import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_TX_Harris(	 
	string									pversion
	,boolean								pOverwrite			= false																															
	,dataset(Layout_File_TX_Harris_in.combinedSprayed	)	pSprayed_TX_Harris_File = FBNV2.File_TX_Harris_in.raw
) :=
function

	dTX_Harris_in          := pSprayed_TX_Harris_File;
	
	
	Layout_File_TX_Harris_in.Cleaned tFiling(dTX_Harris_in l) := transform
	
			self.process_date 			:= trim(pversion);
			self.FILE_NUMBER				:= trim(l.FILE_NUMBER,left,right);
			self.RECORD_TYPE				:= ''; // New input format has no record type
			
			self.NAME1				 			:= stringlib.stringtouppercase(trim(l.NAME1));
			self.STREET_ADD1				:= stringlib.stringtouppercase(l.STREET_ADD1);
			self.CITY1							:= stringlib.stringtouppercase(l.CITY1);
			self.STATE1							:= stringlib.stringtouppercase(l.STATE1);
			self.ZIP1								:= trim(l.ZIP1,left,right);
			
			self.TERM								:= stringlib.stringtouppercase(trim(l.TERM));
			
			self.NAME2				 			:= stringlib.stringtouppercase(trim(l.NAME2));
						
			self.STREET_ADD2				:= stringlib.stringtouppercase(trim(l.STREET_ADD2));
			self.CITY2							:= stringlib.stringtouppercase(trim(l.CITY2));
			self.STATE2							:= stringlib.stringtouppercase(trim(l.STATE2));
			self.ZIP2								:= trim(l.ZIP2,left,right);

			self.FILM_CODE					:= stringlib.stringtouppercase(trim(l.FILM_CODE));
						
      // Old input format was MMDDYYYY, new format is YYYYMMDD.  So, change to old format, to get
			// everything the same and then change to the proper format down the line.
			the_date_filed					:= stringlib.stringfilter(trim(l.DATE_FILED),'1234567890');
			self.DATE_FILED					:= the_date_filed[5..8] + the_date_filed[1..4];
			// New input format has no bus_type or annex_code
			self.BUS_TYPE						:= '';
			self.ANNEX_CODE					:= '';
	
			self.prep_addr1_line1 		:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.STREET_ADD1,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr1_line_last := address.Addr2FromComponents(
																					trim(l.CITY1 )
																					,trim(l.STATE1)
																					,l.ZIP1[1..5]);
			
			self.prep_addr2_line1 		:= address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.STREET_ADD2,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_addr2_line_last := address.Addr2FromComponents(
																					trim(l.CITY2 )
																					,trim(l.STATE2)
																					,l.ZIP2[1..5]);
																					
			self 										:= l;
			self 										:= [];
	end;
	
	prepFilings := project(dTX_Harris_in, tFiling(left));
	
	Address.Mac_Is_Business(prepFilings(name1 != ''), name1, dClean_Name1, name_flag, false, true );

	cln_layout := RECORD
		Layout_File_TX_Harris_in.Cleaned;
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
		
	dName1Blank	:=      project(prepFilings(name1 = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName1	:=      dClean_Name1   +  dName1Blank;

	Layout_File_TX_Harris_in.Cleaned  CleanUpName1( dCleanName1  l) := transform
		self.name1_title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								l.name_flag = 'U' => l.name1_title, 
																								''
																							);
		self.name1_fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								l.name_flag = 'U' => l.name1_fname, 
																								''
																							);
		self.name1_mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																								l.name_flag = 'U' => l.name1_mname, 
																								''
																							);
		self.name1_lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								l.name_flag = 'U' => l.name1_lname, 
																								''
																							 );
		self.name1_name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								l.name_flag = 'U' => l.name1_name_suffix, 
																								''
																							);
		self						:=	l;
		self						:=	[];
	end;		
					
	Clean_Filings_Names1	:=project(dCleanName1 ,CleanUpName1(left));
	
	//*** Cleaning name2 names.
	Address.Mac_Is_Business(Clean_Filings_Names1(name2 != ''), name2, dClean_Name2, name_flag, false, true );

	dName2Blank	:=      project(Clean_Filings_Names1(name2 = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName2	:=      dClean_Name2   +  dName2Blank;

	Layout_File_TX_Harris_in.Cleaned  CleanUpName2( dCleanName2  l) := transform
		self.name2_title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								l.name_flag = 'U' => l.name2_title, 
																								''
																							);
		self.name2_fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								l.name_flag = 'U' => l.name2_fname, 
																								''
																							);
		self.name2_mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																								l.name_flag = 'U' => l.name2_mname, 
																								''
																							);
		self.name2_lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								l.name_flag = 'U' => l.name2_lname, 
																								''
																							 );
		self.name2_name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								l.name_flag = 'U' => l.name2_name_suffix, 
																								''
																							);
		self						:=	l;
		self						:=	[];
	end;		
					
	Clean_Filings_Names2	:=project(dCleanName2 ,CleanUpName2(left));

	logicalfile := '~thor_data400::in::fbnv2::TX::Harris::'+pversion+'::Cleaned';

	VersionControl.macBuildNewLogicalFile(logicalfile	,Clean_Filings_Names2	,filing_out		,,,pOverwrite);		
	
	mapped_Filing 	:= 	filing_out;
	source					:= 'HARRIS';
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