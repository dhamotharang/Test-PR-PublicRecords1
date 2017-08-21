import lib_fileservices;

export SuperList
 :=
  module
	//--------------------------------------------------------------------------------------
	export	dRaw					:=	lib_fileservices.FileServices.LogicalFileList('*',false,true,true);	//	final TRUE makes unknown size/count return as zero
	//--------------------------------------------------------------------------------------
	shared	FileManager.Helpers.rFileListMaskedFixed	tMaskFixed(lib_fileservices.FsLogicalFileInfoRecord pInput)
	 :=
	  transform
		self.NameMaskedVersionToken	:=	FileManager.Helpers.fMaskSuperVersionToken(pInput.Name);
		self.NameVersionToken		:=	FileManager.Helpers.fGetSuperVersionToken(pInput.Name);
		self.NameVersionTokenNoPunc	:=	FileManager.Helpers.fMaskedStringNoPunctuation(self.NameVersionToken);
		self.NameFirstDir			:=	regexfind('[^:]+::([^\\:]+)',pInput.Name,1);
		self						:=	pInput;
	  end
	 ;
	//--------------------------------------------------------------------------------------
	export	dMaskedFixed			:=	project(dRaw,tMaskFixed(left));
	export	dMasked					:=	FileManager.Helpers.fFileListMaskedFixedToVariable(dMaskedFixed);
	//--------------------------------------------------------------------------------------
	shared	rMaskedVersionRollup
	 :=
	  record,maxlength(4096)
		string		NameMaskedVersionToken;
		string		NameFirstDir;
		string		NameVersionTokenNoPunc;
		string1		Version_Prod				:=	'';
		string1		Version_QA					:=	'';
		string1		Version_Father				:=	'';
		string1		Version_Grandfather			:=	'';
		string1		Version_Grandgrandfather	:=	'';
		string1		Version_Delete				:=	'';
		string1		Version_Built				:=	'';
		string1		Version_Building			:=	'';
	  end
	 ;
	shared	dMaskedVersionRollupPrep	:=	project(dMaskedFixed,rMaskedVersionRollup);
	shared	rMaskedVersionRollup	tMaskedVersionRollup(dMaskedVersionRollupPrep pLeft, dMaskedVersionRollupPrep pRight)
	 :=
	  transform
		self.NameMaskedVersionToken		:=	trim(pLeft.NameMaskedVersionToken);
		self.NameFirstDir				:=	trim(pLeft.NameFirstDir);
		self.NameVersionTokenNoPunc		:=	trim(pRight.NameVersionTokenNoPunc);
		self.Version_Prod				:=	if(pLeft.Version_Prod = 'Y'				or pRight.NameVersionTokenNoPunc = 'prod','Y','');
		self.Version_QA					:=	if(pLeft.Version_QA	= 'Y'				or pRight.NameVersionTokenNoPunc = 'qa','Y','');
		self.Version_Father				:=	if(pLeft.Version_Father	= 'Y'			or pRight.NameVersionTokenNoPunc = 'father','Y','');
		self.Version_Grandfather		:=	if(pLeft.Version_Grandfather = 'Y'		or pRight.NameVersionTokenNoPunc = 'grandfather','Y','');
		self.Version_Grandgrandfather	:=	if(pLeft.Version_Grandgrandfather = 'Y'	or pRight.NameVersionTokenNoPunc = 'grandgrandfather','Y','');
		self.Version_Delete				:=	if(pLeft.Version_Delete = 'Y'			or pRight.NameVersionTokenNoPunc = 'delete','Y','');
		self.Version_Built				:=	if(pLeft.Version_Built = 'Y'			or pRight.NameVersionTokenNoPunc = 'built','Y','');
		self.Version_Building			:=	if(pLeft.Version_Building = 'Y'			or pRight.NameVersionTokenNoPunc = 'building','Y','');
	  end
	 ;
	export	dMaskedVersionRollup		:=	rollup(sort(dMaskedVersionRollupPrep,NameMaskedVersionToken),
												   left.NameMaskedVersionToken = right.NameMaskedVersionToken,
												   tMaskedVersionRollup(left,right)
												  );
	//--------------------------------------------------------------------------------------
	export	dMaskedVersionRollup_NoVersion		:=	dMaskedVersionRollup(NameVersionTokenNoPunc = '');
	export	dMaskedVersionRollup_WIthVersion	:=	dMaskedVersionRollup(NameVersionTokenNoPunc <> '');
	//--------------------------------------------------------------------------------------
  end
 ;