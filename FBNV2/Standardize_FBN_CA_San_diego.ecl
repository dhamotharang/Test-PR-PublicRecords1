import ut,fbnv2,address, lib_stringlib, VersionControl;

export Standardize_FBN_CA_San_diego(	 
	string									pversion
	,boolean								pOverwrite			= false																															
	,dataset(Layout_File_CA_San_Diego_in.Sprayed	)	pSprayed_CA_San_Diego_File		= FBNV2.File_CA_San_Diego_in.raw
) :=
function

	dCA_San_Diego_in          := pSprayed_CA_San_Diego_File;
	
	Layout_File_Ca_San_Diego_in.Cleaned tFiling(dCA_San_Diego_in l) := transform,
																			skip ((integer)l.FILE_NUMBER = 0)
		
			self.process_date 			      := trim(pversion);
			self.FILE_NUMBER              := trim(l.FILE_NUMBER,left,right);
			self.FILE_DATE                := if(regexfind('(\\d{1,2}[/]\\s?\\d{1,2}[/]\\d{4})',l.FILE_DATE),ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.FILE_DATE),'0');
			self.EXPIRATION_DATE          := if(regexfind('(\\d{1,2}[/]\\s?\\d{1,2}[/]\\d{4})',l.EXPIRATION_DATE),ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.EXPIRATION_DATE),'0');
			self.PREV_FILE_NUMBER         := trim(l.PREV_FILE_NUMBER,left,right);
			self.PREV_FILE_DATE           := if(regexfind('(\\d{1,2}[/]\\s?\\d{1,2}[/]\\d{4})',l.PREV_FILE_DATE),ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.PREV_FILE_DATE),'0');
			self.FILING_TYPE              := stringlib.StringToUpperCase(trim(l.FILING_TYPE,left,right));
			self.BUSINESS_START_DATE      := if(regexfind('(\\d{1,2}[/]\\s?\\d{1,2}[/]\\d{4})',l.BUSINESS_START_DATE),ut.date_slashed_MMDDYYYY_to_YYYYMMDD(l.BUSINESS_START_DATE),'0');
			self.OWNERSHIP_TYPE           := stringlib.StringToUpperCase(trim(l.OWNERSHIP_TYPE,left,right));
			self.BUSINESS_NAME            := stringlib.StringToUpperCase(trim(l.BUSINESS_NAME,left,right));
			self.TYPE_OF_NAME             := stringlib.StringToUpperCase(trim(l.TYPE_OF_NAME,left,right));
			self.TYPE_OF_NAME_SEQ_NUM     := stringlib.stringfilter(l.TYPE_OF_NAME_SEQ_NUM,'0123456789');
			self.STREET_ADDRESS1          := stringlib.StringToUpperCase(trim(l.STREET_ADDRESS1,left,right));
			self.STREET_ADDRESS2          := stringlib.StringToUpperCase(trim(l.STREET_ADDRESS2,left,right));
			self.CITY                     := stringlib.StringToUpperCase(trim(l.CITY,left,right));
			self.STATE                    := stringlib.StringToUpperCase(trim(l.STATE,left,right));
			self.ZIP_CODE                 := stringlib.stringfilter(l.ZIP_CODE,'0123456789');
			self.COUNTRY                  := stringlib.StringToUpperCase(trim(l.COUNTRY,left,right));
			self.MAILING_ADDRESS1         := stringlib.StringToUpperCase(trim(l.MAILING_ADDRESS1,left,right));
			self.MAILING_ADDRESS2         := stringlib.StringToUpperCase(trim(l.MAILING_ADDRESS2,left,right));
			self.MAILING_CITY             := stringlib.StringToUpperCase(trim(l.MAILING_CITY,left,right));
			self.MAILING_STATE            := stringlib.StringToUpperCase(trim(l.MAILING_STATE,left,right));
			self.MAILING_ZIP_CODE         := stringlib.stringfilter(l.MAILING_ZIP_CODE,'0123456789');
			self.MAILING_COUNTRY          := stringlib.StringToUpperCase(trim(l.MAILING_COUNTRY,left,right));
			self.PNAME 							      := if (not ut.IsCompany(l.BUSINESS_NAME) and self.TYPE_OF_NAME = 'O', 
																		   stringlib.stringtouppercase(address.CleanPerson73(l.BUSINESS_NAME)),'');
			self.prep_addr_line1          := StringLib.StringCleanSpaces(stringlib.stringtouppercase(trim(l.STREET_ADDRESS1,left,right)) + ' ' + 
			                                                             stringlib.stringtouppercase(trim(l.STREET_ADDRESS2,left,right)));
			self.prep_addr_line_last      := StringLib.StringCleanSpaces(stringlib.stringtouppercase(trim(l.CITY,left,right)) + ', ' + 
			                                                             stringlib.stringtouppercase(trim(l.STATE,left,right)) + ' ' +
																																	 if(length(trim(l.ZIP_CODE)) >= 5,l.ZIP_CODE[1..5],''));
			self.prep_mail_addr_line1     := StringLib.StringCleanSpaces(stringlib.stringtouppercase(trim(l.MAILING_ADDRESS1,left,right)) + ' ' + 
			                                                             stringlib.stringtouppercase(trim(l.MAILING_ADDRESS2,left,right)));
			self.prep_mail_addr_line_last := StringLib.StringCleanSpaces(stringlib.stringtouppercase(trim(l.MAILING_CITY,left,right)) + ', ' + 
			                                                             stringlib.stringtouppercase(trim(l.MAILING_STATE,left,right)) + ' ' +
																																	 if(length(trim(l.MAILING_ZIP_CODE)) >= 5,l.MAILING_ZIP_CODE[1..5],''));
			self 										      := l;
			self 										      := [];
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
