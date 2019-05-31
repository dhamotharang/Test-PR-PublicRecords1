import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_CA_Santa_Clara(	 
	string									pversion
	,boolean								pOverwrite			= false																															
	,dataset(Layout_File_CA_Santa_Clara_in.Sprayed	)	pSprayed_CA_Santa_Clara_File		= FBNV2.File_CA_Santa_Clara_in.raw
) :=
function

	dCA_Santa_Clara_in          := pSprayed_CA_Santa_Clara_File;

	Layout_File_Ca_Santa_Clara_in.Cleaned tFiling(dCA_Santa_Clara_in l) := transform
			city										:= stringlib.stringtouppercase(trim(l.BUSINESS_ADDRESS_CITY,left,right));
			state										:= stringlib.stringtouppercase(trim(l.BUSINESS_ADDRESS_STATE,left,right));
			zip											:= if(trim(l.BUSINESS_ADDRESS_ZIP,left,right) <> '0', trim(l.BUSINESS_ADDRESS_ZIP,left,right), '');
			owner_city							:= stringlib.stringtouppercase(trim(l.REGISTRANT_ADDRESS_CITY,left,right));
			owner_state							:= stringlib.stringtouppercase(trim(l.REGISTRANT_ADDRESS_STATE,left,right));
			owner_zip								:= if(trim(l.REGISTRANT_ADDRESS_ZIP,left,right) <> '0', trim(l.REGISTRANT_ADDRESS_ZIP,left,right), '');
		
			self.process_date 			:= trim(pversion);
			self.status							:= trim(l.FILING_TYPE);
			self.FILED_DATE					:= trim(l.RECORDING_DATE);
			self.FBN_TYPE						:= stringlib.stringtouppercase(trim(l.DOCUMENT_TYPE));
			self.FILING_TYPE		  	:= trim(l.FILING_TYPE);
			
			self.BUSINESS_NAME 			:= stringlib.stringtouppercase(trim(l.BUSINESS_NAMES));
			self.BUSINESS_TYPE 			:= stringlib.stringtouppercase(trim(l.BUSINESS_TYPE));
			self.ORIG_FILED_DATE		:= '';
			self.ORIG_FBN_NUM				:= '';
			self.FBN_NUM						:= trim(l.FILE_NUMBER,left,right);
			self.BUSINESS_ADDR1			:= stringlib.stringtouppercase(trim(l.BUSINESS_ADDRESS_STREET));
			self.BUSINESS_ADDR2			:= '';
			self.BUS_CITY						:= city;
			self.BUS_ST							:= state;	
			self.BUS_ZIP						:= zip;
			self.ADDTL_BUSINESS			:= '';	
			self.OWNER_NAME 				:= stringlib.stringtouppercase(trim(l.REGISTRANT_NAME));
			self.OWNER_TYPE 				:= stringlib.stringtouppercase(trim(l.REGISTRANT_TYPE));
			self.OWNER_ADDR1			  := stringlib.stringtouppercase(trim(l.REGISTRANT_ADDRESS_STREET));
			self.OWNER_CITY					:= owner_city;
			self.OWNER_ST						:= owner_state;	
			self.OWNER_ZIP					:= owner_zip;
      
			self.prep_addr_line1		        := stringlib.stringtouppercase(trim(l.BUSINESS_ADDRESS_STREET));
			self.prep_addr_line_last        := address.Addr2FromComponents(city, state, zip[1..5]);
			self.prep_owner_addr_line1		  := stringlib.stringtouppercase(trim(l.REGISTRANT_ADDRESS_STREET));
			self.prep_owner_addr_line_last  := address.Addr2FromComponents(owner_city, owner_state, owner_zip[1..5]);

			self 										:= l;
			self 										:= [];
	end;
	
	prepFilings := project(dCA_Santa_Clara_in, tFiling(left));
	
	Address.Mac_Is_Business( prepFilings(OWNER_NAME != ''), OWNER_NAME, dClean_Name, name_flag, false, true );

	cln_layout := RECORD
		Layout_File_Ca_Santa_Clara_in.Cleaned;
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
		
	dNameBlank	:=      project(prepFilings(OWNER_NAME = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName	:=      dClean_Name   +  dNameBlank;

	Layout_File_Ca_Santa_Clara_in.Cleaned  CleanUpName( dCleanName  l) := transform
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
		self						:=	l;
		self						:=	[];
	end;		
					
	Clean_Filings_Names	:=project(dCleanName ,CleanUpName(left));
	
	logicalfile := '~thor_data400::in::fbnv2::CA::Santa_Clara::'+pversion+'::Cleaned';
	
	VersionControl.macBuildNewLogicalFile(logicalfile	,Clean_Filings_Names	,filing_out		,,,pOverwrite);		
	
	mapped_Filing 	:= 	sequential(filing_out);
	source					:= 'SANTA_CLARA';
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
