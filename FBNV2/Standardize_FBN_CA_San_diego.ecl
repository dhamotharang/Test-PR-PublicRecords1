import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_CA_San_diego(	 
	string									pversion
	,boolean								pOverwrite			= false																															
	,dataset(Layout_File_CA_San_Diego_in.Sprayed	)	pSprayed_CA_San_Diego_File		= FBNV2.File_CA_San_Diego_in.raw
) :=
function

	dCA_San_Diego_in          := pSprayed_CA_San_Diego_File;
	
	Layout_File_Ca_San_Diego_in.Cleaned tFiling(dCA_San_Diego_in l) := transform,
																			skip ((integer)l.ORIG_FILING_NUMBER = 0)
		
			self.process_date 			:= trim(pversion);
			self.ORIG_FILING_NUMBER	:= trim(l.ORIG_FILING_NUMBER);
			self.TYPE_OF_RECORD			:= trim(l.TYPE_OF_RECORD,left,right);
			self.BUSINESS_NAME 			:= if (trim(l.TYPE_OF_RECORD) = '2',
																		 stringlib.stringtouppercase(trim(l.BUSINESS_NAME)[1..25]),		
																		 stringlib.stringtouppercase(trim(l.BUSINESS_NAME)));
			
			self.OWNER_NAME					:= if (trim(l.TYPE_OF_RECORD) = '2',
																		 stringlib.stringtouppercase(trim(l.BUSINESS_NAME)[26..]),		
																		 '');
			self.fbn_type						:= stringlib.stringtouppercase(trim(l.ABANDON_WITHDRAW_IND));
			self.FILING_DATE				:= trim(l.FILING_DATE[5..8],left,right) + trim(l.FILING_DATE[1..4]);
			self.ORIG_FILING_DATE		:= trim(l.ORIG_FILING_DATE[5..8],left,right) + trim(l.ORIG_FILING_DATE[1..4]);
			self.NEW_FILING_NUMBER	:= trim(l.NEW_FILING_NUMBER,left,right);

			self.PNAME 							:= if (trim(l.TYPE_OF_RECORD) = '2' and trim(l.BUSINESS_NAME[26..]) <> '', 
																		 stringlib.stringtouppercase(address.CleanPerson73(trim(l.BUSINESS_NAME)[26..])),'');
			self 										:= l;
			self 										:= [];
	end;
	
	prepFilings := project(dCA_San_Diego_in, tFiling(left));
	
	logicalfile := '~thor_data400::in::fbnv2::CA::San_Diego::'+pversion+'::Cleaned';

	VersionControl.macBuildNewLogicalFile(logicalfile	,prepFilings	,filing_out		,,,pOverwrite);		
	
	mapped_Filing 	:= 	sequential(filing_out);
	source					:= 'San_Diego';
	superfilename 	:= FBNV2.Get_Update_SupperFilename(source); 
	Create_Super		:= FileServices.CreateSuperFile(superfilename,false);
	
	result := 
		sequential(
			mapped_Filing
			,if(~FileServices.FileExists(superfilename), Create_Super)
			,fileservices.addsuperfile( superfilename,logicalfile)								  
		);	
	
	return result;

end;
