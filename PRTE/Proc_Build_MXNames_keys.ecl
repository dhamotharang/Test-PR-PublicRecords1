EXPORT Proc_Build_MXNames_keys(string pVersion) := function

Synonym_idx := record
	string6 	term1M1;
	string6 	term1M2;
	string40 	t1;
	string6 	term2M1;
	string6 	term2M2;	
	string40 	t2;
	unicode40 term1;
	unicode40 term2;
	unsigned2	score;
end;

synonym_idx_key := buildindex(index(dataset([],synonym_idx), {term1M1, term1M2, t1}, {term2M1, term2M2, t2, term1, term2, score},
																'keyname'), '~prte::key::mxd_names::'+ pVersion +'::synonym_idx', update);
return	sequential(synonym_idx_key, 
												 
						PRTE.UpdateVersion('MXDocketKeys',		//	Package name
																pVersion,					//	Package version
																'uma.pamarthy@lexisnexis.com;anantha.venkatachalam@lexisnexis.com'	//	Who to email with specifics
																,'B',									//	B = Boca, A = Alpharetta
																'N',									//	N = Non-FCRA, F = FCRA
																'N'									//	N = Do not also include boolean, Y = Include boolean, too
															)
						);
end;