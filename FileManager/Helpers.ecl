export Helpers
 :=
  module
	//--------------------------------------------------------------------------------------
	//	LogicalVersionRegExString
	//
	//	When used with RegExFind or RegExReplace, will correctly find the following:
	//	 thor_data400::base::job_file_w20080114-123456			finds	w20080114-123456
	//	 thor_data400::base::job_file_w20080114-123456-1		finds	w20080114-123456-1
	//	 thor_data400::base::job_file_w20080114-123456_file		finds	w20080114-123456
	//	 thor_data400::base::job_file_w20080114-123456-1_file	finds	w20080114-123456-1
	//	 thor_data400::base::job::20080114::file				finds	20080114
	//	 thor_data400::base::job::20080114b::file				finds	20080114b
	//	and many combinations thereof.
	//
	//	Basically it should properly find WUID with upper or lowercase "w" and with or
	//	 without the trailing "-#" sequencing number.  It will also find an 8-digit number
	//	 optionally followed by a single letter such as 20080114 or 20080114b.  This does
	//	 not guarantee that the actual version intended will be found, as the filename in
	//	 question may contain additional number strings potentially valid as dates.
	//
	//	When possible, the two RegEx strings below should be used in sequence (WUID first)
	//	 to prevent the possibility of extracting a date from a filename and not pulling the
	//	 WUID first (WUID should supersede all others if it exists?).  Either way, care
	//	 should be taken when using this one.  Good naming conventions will always help.
	//--------------------------------------------------------------------------------------
	export	string	LogicalVersionRegExString		:=	'[w|W]?[0-9]{8}[0-9|-]*[a-z]?';

	//--------------------------------------------------------------------------------------
	//	LogicalVersionWUIDRegExString
	//   
	//	When used with RegExFind or RegExReplace, will correctly find the following:
	//	 thor_data400::base::job_file_w20080114-123456			finds	w20080114-123456
	//	 thor_data400::base::job_file_w20080114-123456-1		finds	w20080114-123456-1
	//	 thor_data400::base::job_file_w20080114-123456_file		finds	w20080114-123456
	//	 thor_data400::base::job_file_w20080114-123456-1_file	finds	w20080114-123456-1
	//	and many combinations thereof.
	//   
	//	Basically it should properly find WUID with upper or lowercase "w" and with or
	//	 without the trailing "-#" sequencing number.  This does  not guarantee that the
	//	 actual version intended will be found, as the filename in question may contain
	//	 additional number strings potentially valid as WUID--this is unlikely, however.
	//--------------------------------------------------------------------------------------
	export	string	LogicalVersionWUIDRegExString	:=	'[w|W][0-9]{8}-[0-9|-]+';

	//--------------------------------------------------------------------------------------
	//	LogicalVersionDateRegExString
	//   
	//	When used with RegExFind or RegExReplace, will correctly find the following:
	//	 thor_data400::base::job::20080114::file				finds	20080114
	//	 thor_data400::base::job::20080114b::file				finds	20080114b
	//	and many combinations thereof.
	//   
	//	Basically it should properly find an 8-digit number optionally followed by a single
	//	 letter such as 20080114 or 20080114b.  This does not guarantee that the actual
	//	 version intended will be found, as the filename in question may contain additional
	//	 number strings potentially valid as dates.
	//--------------------------------------------------------------------------------------
	export	string	LogicalVersionDateRegExString	:=	'[0-9]{8}[a-z]?';
  	//--------------------------------------------------------------------------------------
	shared	rSingleString
	 :=
	  record,maxlength(255)
		string	StringValue;
	  end
	 ;
  	//--------------------------------------------------------------------------------------
	export	dSuperVersionString
	 :=
	  dataset([
				'qa'				,
				'father'			,
				'grandfather'		,
				'grandgrandfather'	,
				'built'				,
				'building'			,
				'prod'				,
				'prod_next'			,
				'delete'			,
				'sprayed'			,
				'using'				,
				'used'
			  ],
			  rSingleString
			 );
  	//--------------------------------------------------------------------------------------
	export	dIncludedSuperDirs
	 :=
	  dataset([
				'base'			,
				'in'			,
				'in_rolling'	,
				'key'			,
				'out'
			  ],
			  rSingleString
			 );
  	//--------------------------------------------------------------------------------------
	export	dValidClusterPrefix
	 :=
	  dataset([
				'thor_dell400'			,
				'thor_dell400_2'		,
				'thor_200'				,
				'production_watch_thor'	,
				'thor_data400'
			  ],
			  rSingleString
			 );
  	//--------------------------------------------------------------------------------------
	export	string	fConcatenatedStringFromDataset(dataset(rSingleString) pDatasetIn, string pDelimiter='|')
	 :=
	  function
		rSingleString	tFlattenStrings(rSingleString pLeft, rSingleString pRight)
		 :=
		  transform
			self.StringValue	:=	pLeft.StringValue	+	if(pLeft.StringValue <> '',pDelimiter,'')	+	pRight.StringValue;
		  end
		 ;
		dReturnDataset	:=	rollup(pDatasetIn,true,tFlattenStrings(left,right));
		return	dReturnDataset[1].StringValue;
	  end
	 ;
  	//--------------------------------------------------------------------------------------
	export	SuperVersionStringsPipeDelimted	:=	fConcatenatedStringFromDataset(dSuperVersionString);
	//--------------------------------------------------------------------------------------
	export	string	lVersionReplacementBaseToken	:=	'@version@';
	shared	string	lSuperVersionRegExEnding		:=	'_(' + SuperVersionStringsPipeDelimted + ')$';
	shared	string	lSuperVersionRegExMiddle		:=	'::(' + SuperVersionStringsPipeDelimted + ')::';
	shared	string	lVersionReplacementEndingToken	:=	'_' + lVersionReplacementBaseToken;
	shared	string	lVersionReplacementMiddleToken	:=	'::' + lVersionReplacementBaseToken + '::';
	//--------------------------------------------------------------------------------------
	export	string	fMaskedStringNoPunctuation(string pFullString)	:=	regexreplace('::',regexreplace('^_',pFullString,''),'');
	shared	string	fMaskFilenameVersionToken(string pFileName, string pRegExOption1, string pReplaceOption1, string pRegExOption2, string pReplaceOption2)
	 :=
	  function
		string	lMaskedVersionOption1		:=	regexreplace(pRegExOption1,pFileName,pReplaceOption1);
		string	lMaskedVersionOption2		:=	regexreplace(pRegExOption2,pFileName,pReplaceOption2);
		return	if(lMaskedVersionOption1 <> pFileName,
				   lMaskedVersionOption1,
				   lMaskedVersionOption2
				  );
	  end
	 ;
	shared	string	fGetFilenameVersionToken(string pFileName, string pRegExOption1, string pRegExOption2)
	 :=
	  function
		string	lOption1Token				:=	regexfind(pRegExOption1,pFileName,0);
		string	lOption2Token				:=	regexfind(pRegExOption2,pFileName,0);
		return	if(lOption1Token <> '',
				   lOption1Token,
				   lOption2Token
				  );
	  end
	 ;
	//--------------------------------------------------------------------------------------
	export	string	fMaskSuperVersionToken(string pFileName)	:=	fMaskFilenameVersionToken(pFileName,lSuperVersionRegExEnding,lVersionReplacementEndingToken,lSuperVersionRegExMiddle,lVersionReplacementMiddleToken);
	export	string	fGetSuperVersionToken(string pFileName)		:=	fGetFilenameVersionToken(pFileName,lSuperVersionRegExEnding,lSuperVersionRegExMiddle);
	export	string	fMaskLogicalVersionToken(string pFileName)	:=	fMaskFilenameVersionToken(pFileName,LogicalVersionWUIDRegExString,lVersionReplacementBaseToken,LogicalVersionDateRegExString,lVersionReplacementBaseToken);
	export	string	fGetLogicalVersionToken(string pFileName)	:=	fGetFilenameVersionToken(pFileName,LogicalVersionDateRegExString,lSuperVersionRegExMiddle);
	//--------------------------------------------------------------------------------------
	export	rFileListMaskedFixed
	 :=
	  record
		string255	Name;			// from lib_fileservices.FsLogicalFileInfoRecord, but fixed length here
		boolean		Superfile;		// from lib_fileservices.FsLogicalFileInfoRecord
		unsigned8	Size;			// from lib_fileservices.FsLogicalFileInfoRecord
		unsigned8	Rowcount;		// from lib_fileservices.FsLogicalFileInfoRecord
		string19	Modified;		// from lib_fileservices.FsLogicalFileInfoRecord
		string255	Owner;			// from lib_fileservices.FsLogicalFileInfoRecord, but fixed length here
		string255	Cluster;		// from lib_fileservices.FsLogicalFileInfoRecord, but fixed length here
		string255	NameMaskedVersionToken;
		string30	NameVersionToken;
		string30	NameVersionTokenNoPunc;
		string30	NameFirstDir;
	  end
	 ;
	//--------------------------------------------------------------------------------------
	export	rFileListMasked
	 :=
	  record,maxlength(4096)
		string		Name;			// from lib_fileservices.FsLogicalFileInfoRecord
		string		Superfile;		// from lib_fileservices.FsLogicalFileInfoRecord
		string		Size;			// from lib_fileservices.FsLogicalFileInfoRecord
		string		Rowcount;		// from lib_fileservices.FsLogicalFileInfoRecord
		string19	Modified;		// from lib_fileservices.FsLogicalFileInfoRecord
		string		Owner;			// from lib_fileservices.FsLogicalFileInfoRecord
		string		Cluster;		// from lib_fileservices.FsLogicalFileInfoRecord
		string		NameMaskedVersionToken;
		string		NameVersionToken;
		string		NameVersionTokenNoPunc;
		string		NameFirstDir;
	  end
	 ;
	//--------------------------------------------------------------------------------------
	shared	rFileListMasked	tFixedToVariable(rFileListMaskedFixed pInput)
	 :=
	  transform
		self.Name					:=	trim(pInput.Name);
		self.SuperFile				:=	if(pInput.SuperFile,'true','false');
		self.Size					:=	(string)pInput.Size;
		self.RowCount				:=	(string)pInput.Rowcount;
		self.Modified				:=	trim(pInput.Modified);
		self.Owner					:=	trim(pInput.Owner);
		self.Cluster				:=	trim(pInput.Cluster);
		self.NameMaskedVersionToken	:=	trim(pInput.NameMaskedVersionToken);
		self.NameVersionToken		:=	trim(pInput.NameVersionToken);
		self.NameVersionTokenNoPunc	:=	trim(pInput.NameVersionTokenNoPunc);
		self.NameFirstDir			:=	trim(pInput.NameFirstDir);
	  end
	 ;
	export	fFileListMaskedFixedToVariable(dataset(rFileListMaskedFixed) pFixedInput)	:=	project(pFixedInput,tFixedToVariable(left));
	//--------------------------------------------------------------------------------------
	export	fFirstDirTable(dataset(rFileListMaskedFixed) pFileListMaskedFixed)
	 :=
	  function
		rFirstDirTable
		 :=
		  record,maxlength(4096)
			pFileListMaskedFixed.NameFirstDir;
			unsigned8	Total	:=	count(group);
		  end
		 ;
		return(sort(table(pFileListMaskedFixed,rFirstDirTable,NameFirstDir,few),-Total));
	  end
	 ;
	//--------------------------------------------------------------------------------------
  end
 ;
