//This process copies all the keys for a chosen datasets from production to
//the current system, renames them to start with 'PRTE::KEY::', and puts them 
//in superfiles.  If the superfiles do not exist they are created.

IMPORT DOPS, _Control, STD, tools;
Export BWR_Copy_Prod_To_PRTE := Function
//The datasets as named in DOPS to be copied
	SHARED ds_datasets_to_copy := Dataset([
			  {'AccidentStateResKeys'}, 
				{'HeaderNonUpdatingKeys'}, 
				{'CDSKeys'},
				{'FCRA_CDSKeys'},
				{'CityStZipKeys'}, 
				{'CodesV3Keys'},
				{'CountyKeys'},
				{'EASIKeys'},
				{'SICCodeKeys'},
				{'SSNIssue2Keys'},
				{'FCRA_SSNIssue2Keys'},
				{'TelcordiaTdsKeys'},
				{'TelcordiaTpmKeys'},
				{'FCRA_TelcordiaTpmKeys'},
				{'Vina_VinKeys'},
				{'TestSeedKeys'}
				],
				{string datasetName});
/////////////////////////////////////////////////////////////////////////
//Superfile creation function
	SHARED MakeSuperKeys(string name) := FUNCTION
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'),, true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'),, true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'),, true);
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'),, true);
		RETURN 'SUCCESS';
	END;
	
	SHARED RoxieCert := '10.173.235.23';
	
	shared layout_dops_rec_details := record
		string keyedfields;
		string fulllayout;
		string errormsg;
	end;
	
	SHARED outrec := record,maxlength(50000)
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
	end;
	
	SHARED layout_key_details := record(outrec)
		string qa_key;
		string qa_key_create_sf;
		string keyname;
		string full_layout;
		string layout;
		string keyedfields;
		dataset(layout_dops_rec_details) FileDetails;
		string best_file_match := '';
		string orig_logicalkey := '';
	end;
	
	SHARED GetKeyInfo(	string dopskeyname, 
					string dopsFCRAkeyname ='', 
					string eflag = 'N', 
					string location = 'B') := FUNCTION
			dNonPRCTKeys := dops.GetRoxieKeys(dopskeyname
									, location
									, 'N'
									,
									,'N'
									,'prod'
								);				
			dFCRANonPRCTKeys := dops.GetRoxieKeys(dopsFCRAkeyname
									, location
									, 'F'
									,
									,'N'
									,'prod'
								);			
			allKeyRecs := IF (dopsFCRAkeyname = '', dNonPRCTKeys, dFCRANonPRCTKeys + dNonPRCTKeys);
			layout_key_details xform1(allKeyRecs l) := transform
				SELF.FileDetails := dops.FileInfo(l.logicalkey, RoxieCert).LayoutDetails();
				SELF.keyedfields := regexreplace('^(,)',SELF.FileDetails[1].keyedfields, ''); 
				SELF.layout 	:= SELF.FileDetails[1].fulllayout;
				rec_layout_sc := regexreplace(',', SELF.FileDetails[1].fulllayout, ';');
				// rep1 := regexfindset('\\b\\w+\\b;', rec_layout_sc);
				// rep2 := STD.Str.CombineWords(rep1,',');
				// full_rec_layout := regexreplace(';|,end;',rep2,'', NOCASE);
				firstword := STD.Str.SplitWords(l.superkey,':')[1];
				SELF.full_layout := '';//full_rec_layout;
				self.orig_logicalkey := regexreplace('[\r\n]',l.logicalkey,'',nocase);//regexreplace(firstword,regexreplace('[\r\n]',l.logicalkey,'',nocase),'prte',nocase);
				SELF.qa_key := regexreplace(firstword,regexreplace('[\r\n]',l.superkey,'',nocase),'prte',nocase);
				SELF.logicalkey :=  '~' + regexreplace(firstword,
										regexreplace('::[0-9]+[a-z]*::', l.logicalkey,'::\' + filedate + \'::', NOCASE)
									,'prte',nocase);
				SELF.superkey := '~' + regexreplace('qa',SELF.qa_key,'@version@', nocase) ;
				SELF.keyname := 	regexreplace('[\\.]', 
														regexreplace('__',
															'key_' + 
															regexreplace('::',
																regexreplace('~prte::key::',
																	regexreplace('@version@',
																		SELF.superkey
																		,'_',nocase)
																,'',nocase)
															,'',nocase)
														,'',nocase)
													, '_');
									
				SELF.qa_key_create_sf := 'MakeSuperKeys (\'' +
				SELF.superkey  +'\');';
				SELF := l;
			end;
			prctSFRec := PROJECT(allKeyRecs, xform1(LEFT));
			return prctSFRec;
end;



	layout_dops_details := record
		string keyname;
		string version;
		Dataset(layout_key_details) ds;
	end;

	layout_copy_details := record
		string oldname;
		string newname;
		string superkey;
		string qa_key;
		string superadd;
		string moveb;
		string moveq;
		string keyname;
	end;

	layout_dops_details xform1(ds_datasets_to_copy l) := transform
		tempds :=  if (l.datasetName[1..4] = 'FCRA',
					GetKeyInfo('',l.datasetName,'N'),
					GetKeyInfo(l.datasetName,'','N'));
		superkeys := tempds(superkey != '~prte');
		self.ds := superkeys;
		self.keyname := l.datasetName;
		self.version := RegExReplace('::',RegExFind('::[0-9]{8,}?::',self.ds[1].orig_logicalkey,0),'');
	end;

	ds_copy_recs := project(ds_datasets_to_copy, xform1(left));
//output(ds_copy_recs);
	layout_copy_details norm_xform(layout_key_details l) := transform
		firstword := STD.Str.SplitWords(l.orig_logicalkey,':')[1];
		orig_logicalkey := if(RegExFind('key::accident_state_restrictions', l.orig_logicalkey,NOCASE) = TRUE,
													RegExReplace('20111201', l.orig_logicalkey, '20111129'), l.orig_logicalkey);
		self.oldname :=  '~foreign::' + _control.IPAddress.prod_thor_dali + '::' +  orig_logicalkey;
		self.newname :=  '~' + regexreplace(firstword, orig_logicalkey,'prte',nocase);
		self.superkey := l.superkey;
		self.qa_key 	:= l.qa_key;
		self.keyname := l.keyname;
		//The following is used to create dynamic ecl to move keys to superfiles.
		self.superadd := 	'RoxieKeyBuild.MAC_SK_Move_To_Built_V2( \'' + l.superkey + '\' , \'' +self.newname + '\', move_built_' + l.keyname + ');' +
					'RoxieKeyBuild.MAC_SK_Move_v2( \'' + l.superkey + '\' ,\'Q\', move_qa_' + l.keyname + ');';
		self.moveb 	:= 'move_built_' + l.keyname;
		self.moveq 	:= 'move_qa_' + l.keyname;
	end;
	//ds_copy_recs contains a record for each dataset to be copied.  
	//Each of those has a recordset of the keys for the dataset.  Normalizing
	//to have one record for each key to copy with the details of the copy operation.
	shared normedrecs := normalize(ds_copy_recs, left.ds,norm_xform(right));
	output(normedrecs);
	//For each key try to create a set of superfiles
	seq_create_superkeys := apply( normedrecs, Evaluate(MakeSuperKeys(superkey)));
	//For each key copy from prod to current cluster with new prte name.
	seq_copy_files := apply(	normedrecs,
		if (~STD.File.FileExists(newname),
		STD.File.Copy(	oldname, tools.fun_Clustername_DFU(), newname,,,,, true))
	);
	//Create dynamic ecl to move new logical keys to the appropriate superfiles.
	ecl1	:=  	STD.str.CombineWords(Set(normedrecs, superadd),'\n') +
			'SEQUENTIAL(' + 	STD.str.CombineWords(Set(normedrecs, moveb),',\n') + ',' +
							STD.str.CombineWords(Set(normedrecs, moveq),',\n') + ');';

 	seq_superfile_manipulation := _Control.fSubmitNewWorkunit(ecl1,std.system.job.target());
	
	return sequential(seq_create_superkeys, seq_copy_files, seq_superfile_manipulation);
	
end;
	

	
	
	
	
	
	