Import doxie_files,ingenix_natlprof,ams;
EXPORT Provider_Records_Matching := Module
	Export matchData := record
		string		 	acctno := '';
		string			ingKey := '';
		string			amsKey := '';
		string		 	matchData := '';
		string		 	matchField := '';
		String			matchid := '';
	End;
	Export buildMatchTable (dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) ingPids, dataset(Healthcare_Provider_Services.Layouts.searchKeyResults_plus_input) amsPids) := function
		ing_did_matching := dedup(join(ingPids, doxie_files.key_provider_id,
											keyed(left.prov_id = right.l_providerid), 
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := (string)right.l_providerid;
																self.amsKey := '';
																self.matchData := (String)(integer)right.did;
																self.matchField := 'L'; //L is for LexID
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all)(matchData<>'0');
		ing_dea_matching := dedup(join(ingPids, ingenix_natlprof.key_DEA_providerid,
											keyed(left.prov_id = right.l_providerid),
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := (string)right.l_providerid;
																self.amsKey := '';
																self.matchData := trim(right.deanumber,all);
																self.matchField := 'D'; //D is for DEA
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
		ing_NPI_matching := dedup(join(ingPids, ingenix_natlprof.key_NPI_providerid,
											keyed(left.prov_id =right.l_providerid),
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := (string)right.l_providerid;
																self.amsKey := '';
																self.matchData := right.npi;
																self.matchField := 'N'; //N is for NPI
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
		ing_license_matching := dedup(join(ingPids, ingenix_natlprof.key_license_providerid,
											keyed(left.prov_id = right.l_providerid),
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := (string)right.l_providerid;
																self.amsKey := '';
																self.matchData := right.LicenseState+(integer)stringlib.stringfilter(right.LicenseNumber,'0123456789');
																self.matchField := 'S'; //S is for StateLicense
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
											
		ams_did_matching := dedup(join(amsPids, ams.keys().main.amsid.qa,
											keyed((string)left.prov_id = right.ams_id), 
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := '';
																self.amsKey := right.ams_id;
																self.matchData := (string)right.did;
																self.matchField := 'L'; //L is for LexID
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all)(matchData<>'0');
		ams_dea_matching := dedup(join(amsPids, ams.keys().IDNumber.AMSID.qa, 
											KEYED((string)LEFT.prov_id = RIGHT.ams_id)
											and right.src_cd_desc = 'DEA',
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := '';
																self.amsKey := right.ams_id;
																self.matchData := trim(right.rawfields.indy_id,all);
																self.matchField := 'D'; //D is for DEA
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
		ams_NPI_matching := dedup(join(amsPids, ams.keys().IDNumber.AMSID.qa, 
											KEYED((String)LEFT.prov_id = RIGHT.ams_id)
											and right.src_cd_desc = 'NPI',
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := '';
																self.amsKey := right.ams_id;
																self.matchData := right.rawfields.indy_id;
																self.matchField := 'N'; //N is for NPI
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
		ams_license_matching := dedup(join(amsPids, ams.keys().StateLicense.amsid.qa, 
											KEYED((String)LEFT.prov_id = RIGHT.ams_id),
											transform(matchData,
																self.acctno := left.acctno;
																self.ingKey := '';
																self.amsKey := right.ams_id;
																self.matchData := right.rawfields.st_lic_state+(integer)stringlib.stringfilter(right.rawfields.st_lic_num,'0123456789');
																self.matchField := 'S'; //S is for StateLicense
																self:=[]),
											 keep(Constants.MAX_RECS_ON_JOIN), limit(0)),all);
		//Rollup Transforms
		matchData doINGMatchRollup(matchData l, matchData r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ingKey := l.ingKey;
			self.amsKey := l.amsKey;
			self.matchData := l.matchData;
			self.matchField := l.matchField;
			self.matchid := if(l.ingKey <> r.ingKey,r.ingKey,'');
		END;

		matchData doAMSMatchRollup(matchData l, matchData r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ingKey := l.ingKey;
			self.amsKey := l.amsKey;
			self.matchData := l.matchData;
			self.matchField := l.matchField;
			self.matchid := if(l.amsKey <> r.amsKey,r.amsKey,'');
		END;

		matchData doMatchRollup(matchData l, matchData r) := TRANSFORM
			SELF.acctno := if(l.acctno <> '',l.acctno,r.acctno);
			self.ingKey := if(l.ingKey <> '',l.ingKey,r.ingKey);
			self.amsKey := if(l.amsKey <> '',l.amsKey,r.amsKey);
			self.matchData := if(l.matchData <> '',l.matchData,r.matchData);
			self.matchField := if(l.matchField <> '',l.matchField,r.matchField);
			self.matchid := if(l.matchid <> '',l.matchid,r.matchid);
		END;

		matchData doMatchRollupFinal(matchData l, matchData r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ingKey := l.ingKey;
			self.amsKey := l.amsKey;
			self.matchData := '';
			self.matchField := l.matchField+r.matchField;
			self.matchid := l.matchid;
		END;

		matchData doCleanupFinal(matchData l) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ingKey := l.ingKey;
			self.amsKey := l.amsKey;
			self.matchData := '';
			self.matchField := l.matchField;
			self.matchid := if(l.ingKey<>'' and l.amsKey<>'','',l.matchid);
		END;
		//Rollup Matching logic
		//match up ing records
		ing_did_matching_dedup:=dedup(sort(ing_did_matching,acctno,matchdata,matchfield,(integer)ingkey),acctno,matchdata,matchfield);
		ing_did_final := join(ing_did_matching,ing_did_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doINGMatchRollup(left,right));
		ing_dea_matching_dedup:=dedup(sort(ing_dea_matching,acctno,matchdata,matchfield,(integer)ingkey),acctno,matchdata,matchfield);
		ing_dea_final := join(ing_dea_matching,ing_dea_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doINGMatchRollup(left,right));
		ing_npi_matching_dedup:=dedup(sort(ing_NPI_matching,acctno,matchdata,matchfield,(integer)ingkey),acctno,matchdata,matchfield);
		ing_npi_final := join(ing_npi_matching,ing_npi_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doINGMatchRollup(left,right));
		ing_license_matching_dedup:=dedup(sort(ing_license_matching,acctno,matchdata,matchfield,(integer)ingkey),acctno,matchdata,matchfield);
		ing_license_final := join(ing_license_matching,ing_license_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doINGMatchRollup(left,right));
		ing_matching_results:=dedup(sort(ing_did_final+ing_dea_final+ing_npi_final+ing_license_final,record),record);
		//now match up AMS records
		ams_did_matching_dedup:=dedup(sort(ams_did_matching,acctno,matchdata,matchfield,(integer)amskey),acctno,matchdata,matchfield);
		ams_did_final := join(ams_did_matching,ams_did_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doAMSMatchRollup(left,right));
		ams_dea_matching_dedup:=dedup(sort(ams_dea_matching,acctno,matchdata,matchfield,(integer)amskey),acctno,matchdata,matchfield);
		ams_dea_final := join(ams_dea_matching,ams_dea_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doAMSMatchRollup(left,right));
		ams_npi_matching_dedup:=dedup(sort(ams_NPI_matching,acctno,matchdata,matchfield,(integer)amskey),acctno,matchdata,matchfield);
		ams_npi_final := join(ams_npi_matching,ams_npi_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doAMSMatchRollup(left,right));
		ams_license_matching_dedup:=dedup(sort(ams_license_matching,acctno,matchdata,matchfield,(integer)amskey),acctno,matchdata,matchfield);
		ams_license_final := join(ams_license_matching,ams_license_matching_dedup,
																		left.acctno= right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doAMSMatchRollup(left,right));
		ams_matching_results:=dedup(sort(ams_did_final+ams_dea_final+ams_npi_final+ams_license_final,record),record);
		combined_matching_results:=join(ing_matching_results,ams_matching_results,
																		left.acctno = right.acctno and 
																		left.matchdata = right.matchdata and
																		left.matchfield = right.matchfield,
																		doMatchRollup(left,right),full outer);
		// output(combined_matching_results,named('combined_matching_results'));
		// output(sort(combined_matching_results,acctno,ingkey,amskey,(integer)matchid),named('sorted_combined_matching_final'));
		combined_matching_final:=rollup(sort(combined_matching_results,acctno,ingkey,amskey,map((integer)matchid=0=>999999999999,(integer)matchid)),
																		left.acctno= right.acctno and 
																		left.ingkey = right.ingkey and
																		left.amskey = right.amskey,
																		doMatchRollupFinal(left,right));
		clean_final := project(combined_matching_final,doCleanupFinal(left));
		return clean_final;
	end;
end;