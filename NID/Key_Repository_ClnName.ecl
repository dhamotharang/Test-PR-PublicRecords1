export Key_Repository_ClnName := Index(NameRepository(cln_lname<>''),
{cln_lname,	cln_fname, cln_mname, cln_suffix},
{NameRepository},
	Common.filename_NameRepository_CleanName_Key)
;