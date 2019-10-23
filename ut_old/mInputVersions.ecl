export mInputVersions(string ptemplatename) :=
module

	shared fVersion(string pversion) := regexreplace('@version@', ptemplatename, pversion);+ test create the conflict  
	conflict creation for ThorDev 
	shared lsprayed		:= 'sprayed';
	shared lusing		:= 'using';
	shared lused		:= 'used';
	shared ldelete		:= 'delete';

	export Root									:= regexreplace('::@version@', ptemplatename, '');
	export Sprayed								:= fVersion(lsprayed);
	export Using								:= fVersion(lusing);
	export Used									:= fVersion(lused);
	export Delete								:= fVersion(ldelete);
	export Template								:= ptemplatename;
	export New(string pdate, integer pcnt = 0)	:= if(pcnt = 0, fVersion(pdate), fVersion(pdate) + '_' + (string) pcnt);

	export dAll_superfilenames := 
	DATASET([

		 (Root)
		,(Sprayed)
		,(Using)
		,(Used)
		,(Delete)

	], ut.Layout_Names);
	
	export dNew(string pdate, integer pcnt = 0) :=
	DATASET([

		 (New(pdate, pcnt))

	], ut.Layout_Names);

end;
