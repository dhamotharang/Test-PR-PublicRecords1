export Mac_SKDiff_BuildProcess(pPrevIndex,pNewIndex,pKeyName,pSeqName)	:=
macro

/*
pPrevIndex is the old index that exists in production
pNewIndex is the new index that was created and not yet released to cert or production
pKeyName is 'key::xxxx' (logical file name)
pSeqName is the sequential output name
*/
	
	pSeqName	:=	keydiff(pPrevIndex,pNewIndex,pKeyName);

endmacro;