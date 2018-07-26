IMPORT OKC_Probate,	tools;
EXPORT PersistNames := 
MODULE

	SHARED persistroot	:=	_Dataset().PersistTemplate;

	EXPORT OKCProbateCleanAddress	:=	persistroot + 'OKCProbateCleanAddress';
	EXPORT OKCProbateDID	:=	persistroot + 'OKCProbateDID';

	EXPORT dAll_persistnames := 
	DATASET([
		 (OKCProbateCleanAddress)
		 ,(OKCProbateDID)
	], tools.Layout_Names);

END;