import doxie, header, header_services, ut;

export Did_From_Name_Batch(DATASET(DidVille.Layout_BestInfo_BatchIn) indata, 
					  boolean dodedup, boolean name_phonetics, boolean first_nicknames)
:= function
	
	unsigned4 reclimit := ut.limits.default;
	
	parent_rec := RECORD,maxlength(100 + (reclimit*6))
	     qstring20 acctno;
		DATASET(doxie.layout_references) child_dids;
	END;
	
	parent_rec tranLFSC(DidVille.Layout_BestInfo_BatchIn l) := TRANSFORM
		bignames := Header_Services.Fetch_Header_StCityLFname_Function(l.name_first, l.name_last,
		                                                               name_phonetics, first_nicknames, l.st, l.p_city_name);
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF := l;
	END;
	ParentRecsLFSC := project(indata(p_city_name!='' AND st!='' AND name_last!=''),tranLFSC(LEFT));

	parent_rec tranLFS(DidVille.Layout_BestInfo_BatchIn l) := TRANSFORM
		bignames := Header_Services.Fetch_Header_StFnameLname_Function(l.name_first, l.name_last,
		                                                               name_phonetics, first_nicknames, l.st, '');
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF := l;
	END;
	ParentRecsLFS := project(indata(p_city_name='' AND st!='' AND name_last!=''),tranLFS(LEFT));

	parent_rec tranFSmall(DidVille.Layout_BestInfo_BatchIn l) := TRANSFORM
		bignames := Header_Services.Fetch_Header_FnameSmall_Function(l.name_first, l.p_city_name,
														 l.st, l.z5, 0, l.prim_name);
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF := l;
	END;
	ParentRecsFsmall := project(indata(name_first!='' and name_last='' and (st!='' or z5!='')),tranFSmall(LEFT));
     /*
	parent_rec tranLF(DidVille.Layout_BestInfo_BatchIn l) := TRANSFORM
		bignames := Header_Services.Fetch_Header_Name_Function(l.name_first, l.name_last,
		                                                       name_phonetics, first_nicknames);
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF := l;
	END;
	ParentRecsLF := project(indata((p_city_name='' and st='' and length(trim(ssn))<>9 and
							  phoneno='' and z5='' and name_last!='')),tranLF(LEFT));
	*/
	ParentRecs := ParentRecsLFSC + ParentRecsLFS + ParentRecsFsmall;
     
	out_rec := record
	     qstring20 acctno;
		doxie.layout_references;
	end;
	
	out_rec NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
	     SELF.acctno := l.acctno;
		SELF.did := r.did;
	END;

	NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));
	Outrecs := IF(dodedup, DEDUP(SORT(NormRecs,acctno,did),acctno,did), NormRecs);
	
	return Outrecs;

END;