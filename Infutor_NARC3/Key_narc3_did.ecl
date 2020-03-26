
	
EXPORT	Key_narc3_did(STRING	pVersion, 
											BOOLEAN	pUseProd	=	FALSE,
											BOOLEAN	isFCRA		=	FALSE)	:=	FUNCTION


  base	:=  DATASET(Infutor_NARC3.Filenames(,pUseProd).base.consumer.qa, Infutor_NARC3.Layout_Basefile, THOR, OPT);

  did_base := base(did >0);

  key_name	:=	Keynames(pVersion,pUseProd,isFCRA).did.QA;

	RETURN	INDEX(did_base,{did},{did_base},key_name);
END;