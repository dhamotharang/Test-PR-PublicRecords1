import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_CA_Ventura(	 
	string									pversion
	,boolean								pOverwrite			= false																															
	,dataset(Layout_File_CA_Ventura_in.Sprayed	)	pSprayed_CA_Ventura_File		= FBNV2.File_CA_Ventura_in.raw
) :=
function

	dCA_Ventura_in          := pSprayed_CA_Ventura_File;
	
	Layout_File_Ca_Ventura_in.Cleaned tFiling(dCA_Ventura_in l) := transform
	
			string4 bus_zip4 				:= if (length(trim(l.business_zip,left,right)) = 9, trim(l.business_zip,left,right)[6..9], '');
			string4 mail_zip4	 			:= if (length(trim(l.mail_zip,left,right)) = 9, trim(l.mail_zip,left,right)[6..9], '');
			string4 owner_zip4	 		:= if (length(trim(l.owner_zipcode)) = 9, trim(l.owner_zipcode)[6..9], '');
																					
			self.process_date 			:= trim(pversion);
			self.instrument_id			:= trim(l.instrument_id,left,right);
			self.recorded_date			:= stringlib.stringfilter(l.recorded_date_time[1..10],'01234567890');
			self.recorded_time			:= trim(l.recorded_date_time[11..],left,right);
			self.BUSINESS_NAME 			:= stringlib.stringtouppercase(trim(l.BUSINESS_NAME));
			self.business_street		:= stringlib.stringtouppercase(l.business_street);
			self.business_city			:= stringlib.stringtouppercase(l.business_city);
			self.business_state			:= stringlib.stringtouppercase(l.business_state);
			self.business_zip5			:= trim(l.business_zip,left,right)[1..5];
			self.business_zip4			:= bus_zip4;
			
			self.mail_street				:= stringlib.stringtouppercase(l.mail_street);
			self.mail_city					:= stringlib.stringtouppercase(l.mail_city);
			self.mail_state					:= stringlib.stringtouppercase(l.mail_state);
			self.mail_zip5					:= trim(l.mail_zip)[1..5];
			self.mail_zip4					:= mail_zip4;
			
			self.OWNER_NAME					:= stringlib.stringtouppercase(trim(l.owner_name));
			self.owner_firstname		:= stringlib.stringtouppercase(trim(l.owner_firstname));
						
			self.owner_address			:= stringlib.stringtouppercase(l.owner_address);
			self.owner_city					:= stringlib.stringtouppercase(l.owner_city);
			self.owner_state				:= stringlib.stringtouppercase(l.owner_state);
			self.owner_zipcode5			:= trim(l.owner_zipcode)[1..5];
			self.owner_zipcode4			:= owner_zip4;
			
			self.start_date					:= if((integer)stringlib.stringfilter(l.start_date,'1234567890') <> 0,
																	 stringlib.stringfilter(
																	 l.start_date[stringlib.stringfind(l.start_date,'/',2)+1..] +
																	 intformat((integer)l.start_date[stringlib.stringfind(l.start_date,'/',1)+1..stringlib.stringfind(l.start_date,'/',2)-1],2,1) +
																	 intformat((integer)l.start_date[1..stringlib.stringfind(l.start_date,'/',1)-1],2,1),'1234567890'),
																	 '');
																 
			self.abandondate				:= if((integer)stringlib.stringfilter(l.expiration,'1234567890') <> 0,
																		stringlib.stringfilter(
																		l.expiration[stringlib.stringfind(l.expiration,'/',2)+1..] +
																		intformat((integer)l.expiration[stringlib.stringfind(l.expiration,'/',1)+1..stringlib.stringfind(l.expiration,'/',2)-1],2,1) +
																		intformat((integer)l.expiration[1..stringlib.stringfind(l.expiration,'/',1)-1],2,1),'1234567890'),																	 
																		'');
			self.short_legal				:= '';			
			self.file_number				:= '';
			self.file_year					:= '';
			self.file_seq						:= '';

			self.pname							:= if (trim(l.owner_firstname) <> '', stringlib.stringtouppercase(trim(l.OWNER_NAME) +' '+ trim(l.owner_firstname)),'');
			self.prep_bus_addr_line1 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.business_street,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_bus_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(l.business_city ))
																					,stringlib.stringtouppercase(trim(l.business_state))
																					,l.business_zip[1..5]);
			
			self.prep_mail_addr_line1 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.mail_street,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_mail_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(l.mail_city ))
																					,stringlib.stringtouppercase(trim(l.mail_state))
																					,l.mail_zip[1..5]);
																					
			self.prep_owner_addr_line1 := address.Addr1FromComponents(
																					stringlib.stringtouppercase(trim(l.owner_address,left,right))
																					,''
																					,''
																					,''
																					,''
																					,''
																					,'');
			self.prep_owner_addr_line_last := address.Addr2FromComponents(
																					stringlib.stringtouppercase(trim(l.owner_city ))
																					,stringlib.stringtouppercase(trim(l.owner_state))
																					,l.owner_zipcode[1..5]);

			self 										:= l;
			self 										:= [];
	end;
	
	prepFilings := project(dCA_Ventura_in, tFiling(left));
	
	Address.Mac_Is_Business(prepFilings(pname != ''), pname, dClean_Name, name_flag, false, true );

	cln_layout := RECORD
		Layout_File_Ca_Ventura_in.Cleaned;
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
		
	dNameBlank	:=      project(prepFilings(pname = ''),transform(cln_layout,self	:=	left; self	:=	[]));
	dCleanName	:=      dClean_Name   +  dNameBlank;

	Layout_File_Ca_Ventura_in.Cleaned  CleanUpName( dCleanName  l) := transform
		self.owner_cln_title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																								l.name_flag = 'U' => l.owner_cln_title, 
																								''
																							);
		self.owner_cln_fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																								l.name_flag = 'U' => l.owner_cln_fname, 
																								''
																							);
		self.owner_cln_mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																								l.name_flag = 'U' => l.owner_cln_mname, 
																								''
																							);
		self.owner_cln_lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																								l.name_flag = 'U' => l.owner_cln_lname, 
																								''
																							 );
		self.owner_cln_name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																								l.name_flag = 'U' => l.owner_cln_name_suffix, 
																								''
																							);
		self.CName			:= if(l.name_flag = 'B',
													trim(l.Owner_Name,left,right),
													'');	
		self						:=	l;
		self						:=	[];
	end;		
					
	Clean_Filings_Names	:=project(dCleanName ,CleanUpName(left));
	
	logicalfile := '~thor_data400::in::fbnv2::CA::Ventura::'+pversion+'::Cleaned';

	VersionControl.macBuildNewLogicalFile(logicalfile	,Clean_Filings_Names	,filing_out		,,,pOverwrite);		
	
	mapped_Filing 	:= 	sequential(filing_out);
	source					:= 'VENTURA';
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
