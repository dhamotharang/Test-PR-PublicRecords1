import	lib_fileservices;

export SuperSubList
 :=
  module
	//--------------------------------------------------------------------------------------
	export	rMaskedFixed
	 :=
	  record
		string255	SuperName;			// from lib_fileservices.FsLogicalSuperSubRecord, but fixed length here
		string255	SubName;			// from lib_fileservices.FsLogicalSuperSubRecord, but fixed length here
		string255	SuperNameMaskedVersionToken;
		string30	SuperNameVersionToken;
		string30	SuperNameVersionTokenNoPunc;
		string255	SubNameMaskedVersionToken;
		string30	SubNameVersionToken;
		string30	SubNameVersionTokenNoPunc;
	  end
	 ;
	export	rMaskedFixed	tMaskFixed(lib_fileservices.FsLogicalSuperSubRecord pInput)
	 :=
	  transform
		self.SuperNameMaskedVersionToken	:=	FileManager.Helpers.fMaskSuperVersionToken(pInput.SuperName);
		self.SuperNameVersionToken			:=	FileManager.Helpers.fGetSuperVersionToken(pInput.SuperName);
		self.SuperNameVersionTokenNoPunc	:=	FileManager.Helpers.fMaskedStringNoPunctuation(self.SuperNameVersionToken);
		self.SubNameMaskedVersionToken		:=	FileManager.Helpers.fMaskLogicalVersionToken(pInput.SubName);
		self.SubNameVersionToken			:=	FileManager.Helpers.fGetLogicalVersionToken(pInput.SubName);
		self.SubNameVersionTokenNoPunc		:=	FileManager.Helpers.fMaskedStringNoPunctuation(self.SubNameVersionToken);
		self								:=	pInput;
	  end
	 ;
	//--------------------------------------------------------------------------------------
	export	dRaw							:=	lib_fileservices.FileServices.LogicalFileSuperSubList();
	export	dMaskedFixed					:=	project(dRaw,tMaskFixed(left));
	export	dMaskedFixed_SuperMaskedOnly	:=	dMaskedFixed(SuperNameVersionToken <> '' and SubNameVersionToken = '');
	export	dMaskedFixed_SubMaskedOnly		:=	dMaskedFixed(SubNameVersionToken <> '' and SuperNameVersionToken = '');
	export	dMaskedFixed_BothMasked			:=	dMaskedFixed(SuperNameVersionToken <> '' and SubNameVersionToken <> '');
	//--------------------------------------------------------------------------------------
	shared	mOneFieldTable(pDatasetIn, pCountGroupField, pVersionTokenField, pTableOut)
	 :=
	  macro
		#uniquename(rSuperMaskedCount)
		shared	%rSuperMaskedCount%
		 :=
		  record
			pDatasetIn.pCountGroupField;
			string30	VersionLow	:=	min(group,pVersionTokenField);
			string30	VersionHigh	:=	max(group,pVersionTokenField);
			unsigned8	Total		:=	count(group);
		  end
		 ;
		shared	pTableOut	:=	table(pDatasetIn,%rSuperMaskedCount%,pCountGroupField,few);
	  endmacro
	 ;
	//--------------------------------------------------------------------------------------
	mOneFieldTable(dMaskedFixed,SuperNameMaskedVersionToken,dMaskedFixed.SuperNameVersionToken,ddMaskedFixed_CountSuperMaskedVersion);
	mOneFieldTable(dMaskedFixed,SubNameMaskedVersionToken,dMaskedFixed.SubNameVersionToken,ddMaskedFixed_CountSubMaskedVersion);
	mOneFieldTable(dMaskedFixed_SuperMaskedOnly,SuperNameMaskedVersionToken,dMaskedFixed.SuperNameVersionToken,ddMaskedFixed_SuperMaskedOnly_CountSuperMaskedVersion);
	mOneFieldTable(dMaskedFixed_SuperMaskedOnly,SubNameMaskedVersionToken,dMaskedFixed.SubNameVersionToken,ddMaskedFixed_SuperMaskedOnly_CountSubMaskedVersion);
	mOneFieldTable(dMaskedFixed_SubMaskedOnly,SuperNameMaskedVersionToken,dMaskedFixed.SuperNameVersionToken,ddMaskedFixed_SubMaskedOnly_CountSuperMaskedVersion);
	mOneFieldTable(dMaskedFixed_SubMaskedOnly,SubNameMaskedVersionToken,dMaskedFixed.SubNameVersionToken,ddMaskedFixed_SubMaskedOnly_CountSubMaskedVersion);
	mOneFieldTable(dMaskedFixed_BothMasked,SuperNameMaskedVersionToken,dMaskedFixed.SuperNameVersionToken,ddMaskedFixed_BothMasked_CountSuperMaskedVersion);
	mOneFieldTable(dMaskedFixed_BothMasked,SubNameMaskedVersionToken,dMaskedFixed.SubNameVersionToken,ddMaskedFixed_BothMasked_CountSubMaskedVersion);
	//--------------------------------------------------------------------------------------
	export	dMaskedFixed_CountSuperMaskedVersion					:=	ddMaskedFixed_CountSuperMaskedVersion;
	export	dMaskedFixed_CountSubMaskedVersion						:=	ddMaskedFixed_CountSubMaskedVersion;
	export	dMaskedFixed_SuperMaskedOnly_CountSuperMaskedVersion	:=	ddMaskedFixed_SuperMaskedOnly_CountSuperMaskedVersion;
	export	dMaskedFixed_SuperMaskedOnly_CountSubMaskedVersion		:=	ddMaskedFixed_SuperMaskedOnly_CountSubMaskedVersion;
	export	dMaskedFixed_SubMaskedOnly_CountSuperMaskedVersion		:=	ddMaskedFixed_SubMaskedOnly_CountSuperMaskedVersion;
	export	dMaskedFixed_SubMaskedOnly_CountSubMaskedVersion		:=	ddMaskedFixed_SubMaskedOnly_CountSubMaskedVersion;
	export	dMaskedFixed_BothMasked_CountSuperMaskedVersion			:=	ddMaskedFixed_BothMasked_CountSuperMaskedVersion;
	export	dMaskedFixed_BothMasked_CountSubMaskedVersion			:=	ddMaskedFixed_BothMasked_CountSubMaskedVersion;
	//--------------------------------------------------------------------------------------
  end
 ;
