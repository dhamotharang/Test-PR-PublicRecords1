import lib_fileservices;

export LogicalList
 :=
  module
	//--------------------------------------------------------------------------------------
	export	dRaw					:=	lib_fileservices.FileServices.LogicalFileList('*',true,false,true);	//	final TRUE makes unknown size/count return as zero
	//--------------------------------------------------------------------------------------
	shared	FileManager.Helpers.rFileListMaskedFixed	tMaskFixed(lib_fileservices.FsLogicalFileInfoRecord pInput)
	 :=
	  transform
		self.NameMaskedVersionToken	:=	FileManager.Helpers.fMaskLogicalVersionToken(pInput.Name);
		self.NameVersionToken		:=	FileManager.Helpers.fGetLogicalVersionToken(pInput.Name);
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
		string		VersionTokenLow;
		string		VersionTokenHigh;
		unsigned8	NameMaskedVersionTotal;
	  end
	 ;
	shared	rMaskedVersionRollup	tMaskedVersionRollupPrep(dMaskedFixed pInput)
	 :=
	  transform
		self.NameMaskedVersionToken	:=	trim(pInput.NameMaskedVersionToken);
		self.NameFirstDir			:=	trim(pInput.NameFirstDir);
		self.NameVersionTokenNoPunc	:=	trim(pInput.NameVersionTokenNoPunc);
		self.VersionTokenLow		:=	trim(pInput.NameVersionToken);
		self.VersionTokenHigh		:=	trim(pInput.NameVersionToken);
		self.NameMaskedVersionTotal	:=	1;
	  end
	 ;
	shared	dMaskedVersionRollupPrep	:=	project(dMaskedFixed,tMaskedVersionRollupPrep(left));
	shared	rMaskedVersionRollup	tMaskedVersionRollup(dMaskedVersionRollupPrep pLeft, dMaskedVersionRollupPrep pRight)
	 :=
	  transform
		self.NameMaskedVersionToken	:=	pRight.NameMaskedVersionToken;
		self.NameFirstDir			:=	pRight.NameFirstDir;
		self.NameVersionTokenNoPunc	:=	pRight.NameVersionTokenNoPunc;
		self.VersionTokenLow		:=	if(pLeft.VersionTokenLow <> '',
										   pLeft.VersionTokenLow,
										   pRight.VersionTokenLow
										  );
		self.VersionTokenHigh		:=	if(pRight.VersionTokenHigh <> '',
										   pRight.VersionTokenHigh,
										   pLeft.VersionTokenHigh
										  );
		self.NameMaskedVersionTotal	:=	pLeft.NameMaskedVersionTotal + pRight.NameMaskedVersionTotal;
	  end
	 ;
	export	dMaskedVersionRollup	:=	rollup(sort(dMaskedVersionRollupPrep,NameMaskedVersionToken),
												   left.NameMaskedVersionToken = right.NameMaskedVersionToken,
												   tMaskedVersionRollup(left,right)
												  );
	//--------------------------------------------------------------------------------------
	export	dMaskedVersionRollup_NoVersion		:=	dMaskedVersionRollup(NameVersionTokenNoPunc = '');
	export	dMaskedVersionRollup_WIthVersion	:=	dMaskedVersionRollup(NameVersionTokenNoPunc <> '');
	//--------------------------------------------------------------------------------------
	shared	rMaskedFixedAndSuperSubFixedSuper
	 :=
	  record,maxlength(4096)
		FileManager.Helpers.rFileListMaskedFixed;
		string255	SuperName					:=	'';
		string255	SuperNameMaskedVersionToken	:=	'';
		string30	SuperNameVersionToken		:=	'';
		string30	SuperNameVersionTokenNoPunc	:=	'';
	  end
	 ;
	shared	rMaskedFixedAndSuperSubFixedSuper	tLogicalAndSuperSubSuper(FileManager.Helpers.rFileListMaskedFixed pLogical, FileManager.SuperSubList.rMaskedFixed pSuperSub)
	 :=
	  transform
		self	:=	pLogical;
		self	:=	pSuperSub;
	  end
	 ;
	export	dInSuperSub		:=	join(dMaskedFixed,FileManager.SuperSubList.dMaskedFixed,
									 left.Name = right.SubName,
									 tLogicalAndSuperSubSuper(left,right)
									);
	export	dNotInSuperSub	:=	join(dMaskedFixed,FileManager.SuperSubList.dMaskedFixed,
									 left.Name = right.SubName,
									 tLogicalAndSuperSubSuper(left,right),
									 left only
									);
	//--------------------------------------------------------------------------------------
	shared	rInSuperSub_CountName
	 :=
	  record
		dInSuperSub.Name;
		unsigned8	Total	:=	count(group);
	  end
	 ;
	export	dInSuperSub_CountName	:=	table(dInSuperSub,rInSuperSub_CountName,Name,few);
	//--------------------------------------------------------------------------------------
	shared	rInSuperSub_CountNameMasked
	 :=
	  record
		dInSuperSub.NameMaskedVersionToken;
		unsigned8	Total	:=	count(group);
	  end
	 ;
	export	dInSuperSub_CountNameMasked	:=	table(dInSuperSub,rInSuperSub_CountNameMasked,NameMaskedVersionToken,few);
	//--------------------------------------------------------------------------------------
	shared	rInSuperSub_CountNameAndSuperMasked
	 :=
	  record
		dInSuperSub.Name;
		dInSuperSub.SuperNameMaskedVersionToken;
		unsigned8	Total	:=	count(group);
	  end
	 ;
	export	dInSuperSub_CountNameAndSuperMasked	:=	table(dInSuperSub,rInSuperSub_CountNameAndSuperMasked,Name,SuperNameMaskedVersionToken,few);
	//--------------------------------------------------------------------------------------
	shared	rInSuperSub_CountNameMaskedAndSuperMasked
	 :=
	  record
		dInSuperSub.NameMaskedVersionToken;
		dInSuperSub.SuperNameMaskedVersionToken;
		unsigned8	Total	:=	count(group);
	  end
	 ;
	export	dInSuperSub_CountNameMaskedAndSuperMasked	:=	table(dInSuperSub,rInSuperSub_CountNameMaskedAndSuperMasked,NameMaskedVersionToken,SuperNameMaskedVersionToken,few);
	//--------------------------------------------------------------------------------------
	shared	rNotInSuperSub_CountNameMasked
	 :=
	  record
		dNotInSuperSub.NameMaskedVersionToken;
		unsigned8	Total	:=	count(group);
	  end
	 ;
	export	dNotInSuperSub_CountNameMasked	:=	table(dNotInSuperSub,rNotInSuperSub_CountNameMasked,NameMaskedVersionToken,few);
	//--------------------------------------------------------------------------------------
  end
 ;