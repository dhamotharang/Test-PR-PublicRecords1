// Alpharetta has the Input_Phone at the end of argument list, Distance default is 6
// Change name to _Boca instead of new
export mac_xLinking_on_thor_Boca (infile, IDL ='', Input_SNAME = '', Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_Gender = '', Input_Derived_Gender = '',
														Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN = '',
														Input_DOB = '', Input_Phone = '', Input_DL_STATE = '',Input_DL_NBR = '', 
														outfile, weight_score = 30, Distance = 3, Segmentation = true, forceIndex=true) := MACRO

IMPORT InsuranceHeader_xLink, ut;
	
	#UNIQUENAME(asindex)
	%asIndex% := IF(forceIndex = TRUE, TRUE, IF(thorlib.nodes() < 400 OR COUNT(infile) < 15000000, TRUE, FALSE));
	
	#UNIQUENAME(hasUniqueId)
	ut.hasField(infile, UniqueId, %hasUniqueId%);
	
	#uniquename(layout_seq)
	%layout_seq% := record
		#IF (~%hasUniqueID%) unsigned6 UniqueID; #END
		recordof(infile);
	end;

	#uniquename(assignSeq)
	%layout_seq% %AssignSeq%(infile l, unsigned6 cnt) := transform
		self.uniqueID := #IF (%hasUniqueID%) l.uniqueID; #ELSE cnt; #END
		self := l;
	end;

	#uniquename(infile_seq_temp)
	%infile_seq_temp% := project(infile, %AssignSeq%(left, counter));

	#uniquename(into)
	IDLExternalLinking.xIDLConstants.in_new_layout %into%(%infile_seq_temp% le) := transform
		self.UniqueId := le.uniqueId;
		#IF ( #TEXT(Input_SNAME) <> '' )
			self.SNAME := (typeof(SELF.SNAME))le.Input_SNAME;
		#ELSE
			self.SNAME := (typeof(SELF.SNAME))'';
		#END
		#IF ( #TEXT(Input_FNAME) <> '' )
			self.FNAME := (typeof(SELF.FNAME))le.Input_FNAME;
		#ELSE
			self.FNAME := (typeof(SELF.FNAME))'';
		#END
		#IF ( #TEXT(Input_MNAME) <> '' )
			self.MNAME := (typeof(SELF.MNAME))le.Input_MNAME;
		#ELSE
			self.MNAME := (typeof(SELF.MNAME))'';
		#END
		#IF ( #TEXT(Input_LNAME) <> '' )
			self.LNAME := (typeof(SELF.LNAME))le.Input_LNAME;
		#ELSE
			self.LNAME := (typeof(SELF.LNAME))'';
		#END
		#IF ( #TEXT(Input_GENDER) <> '' )
			self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))le.Input_GENDER;
		#ELSEIF ( #TEXT(Input_DERIVED_GENDER) <> '' )
			self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))le.Input_DERIVED_GENDER;
		#ELSE
			self.DERIVED_GENDER := (typeof(SELF.DERIVED_GENDER))'';
		#END  
		#IF ( #TEXT(Input_PRIM_NAME) <> '' )
			self.PRIM_NAME := (typeof(SELF.PRIM_NAME))le.Input_PRIM_NAME;
		#ELSE
			self.PRIM_NAME := (typeof(SELF.PRIM_NAME))'';
		#END
		#IF ( #TEXT(Input_PRIM_RANGE) <> '' )
			self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
		#ELSE
			self.PRIM_RANGE := (typeof(SELF.PRIM_RANGE))'';
		#END
		#IF ( #TEXT(Input_SEC_RANGE) <> '' )
			self.SEC_RANGE := (typeof(SELF.SEC_RANGE))le.Input_SEC_RANGE;
		#ELSE
			self.SEC_RANGE := (typeof(SELF.SEC_RANGE))'';
		#END
		#IF ( #TEXT(Input_CITY) <> '' )
			self.CITY := (typeof(SELF.CITY))le.Input_CITY;
		#ELSE
			self.CITY := (typeof(SELF.CITY))'';
		#END
		#IF ( #TEXT(Input_ST) <> '' )
			self.ST := (typeof(SELF.ST))le.Input_ST;
		#ELSE
			self.ST := (typeof(SELF.ST))'';
		#END
		#IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP_cases := DATASET([{le.Input_ZIP, 100}],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases);
  #ELSE
     SELF.ZIP_cases := DATASET([],InsuranceHeader_xLink.Process_xIDL_layouts().layout_ZIP_cases);
  #END
		#IF ( #TEXT(Input_SSN) <> '')
			self.SSN5 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn5;
			self.SSN4 := InsuranceHeader_xLink.mod_SSNParse(le.Input_SSN).ssn4;
		#ELSE
			self.SSN5 := '';
			SELF.SSN4 := '';
		#END
		#IF ( #TEXT(Input_DOB) <> '' )
			self.DOB := (typeof(SELF.DOB))le.Input_DOB;
		#ELSE
			self.DOB := (typeof(SELF.DOB))'';
		#END
		 #IF ( #TEXT(Input_PHONE) <> '' )
			self.PHONE := (typeof(SELF.PHONE))le.Input_PHONE;
		#ELSE
			self.PHONE := (typeof(SELF.PHONE))'';
		#END
		#IF ( #TEXT(Input_DL_STATE) <> '' )
			self.DL_STATE := (typeof(SELF.DL_STATE))le.Input_DL_STATE;
		#ELSE
			self.DL_STATE := (typeof(SELF.DL_STATE))'';
		#END
		#IF ( #TEXT(Input_DL_NBR) <> '' )
			self.DL_NBR := (typeof(SELF.DL_NBR))le.Input_DL_NBR;
		#ELSE
			self.DL_NBR := (typeof(SELF.DL_NBR))'';
		#END  
		self.SRC := (typeof(SELF.SRC))'';
		self.SOURCE_RID := (typeof(SELF.SOURCE_RID))'';  
		self.MaxIDs := IDLExternalLinking.Constants.max_idls,
		self := [];
	end;
	#uniquename(pr)
		%pr% := project(%infile_seq_temp%,%into%(left)); // Into roxie input format
	#uniquename(res_out)

	InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(%pr%, UniqueId, ,SNAME, fname, mname, lname, derived_gender, 
																prim_range, prim_name, SEC_RANGE, CITY, ST, ZIP_cases,
																SSN5, SSN4, DOB, PHONE, DL_STATE, DL_NBR,
																SRC, SOURCE_RID, , , %res_out%, true);

	#UNIQUENAME(result_trim)
	IDLExternalLinking.mac_trim_xidl_layout(%res_out%, %result_trim%, reference);

	// select a DID base only on distance and make sure the score is 75 or greater	
	#UNIQUENAME(trimLayout)
	%trimLayout% := recordof(%result_trim%);
	
	#UNIQUENAME(resultsDistance)
	IDLExternalLinking.mac_distance (%result_trim%, %resultsDistance%, weight_score, distance)
	
	#UNIQUENAME(forSegmentation)
	%forSegmentation% := %resultsDistance%(xIDL=0);
	
	#UNIQUENAME(resultsSeg)
	IDLExternalLinking.mac_segmentation(%forSegmentation%, %resultsSeg%, weight_score, distance);

	#UNIQUENAME(result)
	%result% := IF (segmentation, %resultsDistance%(xIDL>0) + %resultsSeg%, %resultsDistance%); 
	
	// Prepare to return results for one DID only
	#UNIQUENAME(infiledist)
	#UNIQUENAME(exlinkdist)
	%infiledist% := DISTRIBUTE(%infile_seq_temp%, uniqueId);
	%exlinkdist% := DISTRIBUTE(%result%, reference);
	
	#UNIQUENAME(resultsLayout)
	%resultsLayout% := RECORDOF(%exlinkdist%.results);	
	
	#UNIQUENAME(AssignDID)
	#UNIQUENAME(hasDistance)
	#UNIQUENAME(hasMatches)
	#UNIQUENAME(hasKeysUsed)
	#UNIQUENAME(hasWeight)
	#UNIQUENAME(hasScore)
	#UNIQUENAME(hasCandidate)
	#UNIQUENAME(hasSegmentation)
	#UNIQUENAME(hasNewScore)

	ut.hasField(infile, xlink_distance, %hasDistance%);
	ut.hasField(infile, xlink_matches, %hasMatches%);
	ut.hasField(infile, xlink_keys, %hasKeysUsed%);
	ut.hasField(infile, xlink_weight, %hasWeight%);
	ut.hasField(infile, xlink_score, %hasScore%);	
	ut.hasField(infile, xlink_candidates_count, %hasCandidate%);
	ut.hasField(infile, xlink_segmentation, %hasSegmentation%);
	ut.hasField(infile, new_score, %hasNewScore%);
	
	RECORDOF(infile) %assignDID%(%infiledist% l, %exlinkdist% r) := transform	
		self.IDL := r.xIDL;	
			// this is for debug fields
		 res := IF (r.xIDL > 0, r.results(did=r.xIDL), r.results);
		 #if (%hasDistance%) self.xlink_distance := r.RecDistance; #end	
		 #if (%hasKeysUsed%) self.xlink_keys := res[1].keys_used; #end
		 #if (%hasWeight%) self.xlink_weight := res[1].weight; #end
		 #if (%hasScore%) self.xlink_score := res[1].score; #end		
		 #if (%hasCandidate%) self.xlink_candidates_count := count(r.results); #end
		 #if (%hasSegmentation%) self.xlink_segmentation := res[1].ind; #end		
		 #if (%hasNewScore%) self.new_score := r.score; #end
		 #if (%hasMatches%) IDLExternalLinking.mac_matchCodes(res[1]); #end		 
		 
		self := l;
	end; 

	#UNIQUENAME(result_v1)
	%result_v1% := JOIN(%infiledist%, %exlinkdist%, 
													left.uniqueid = right.reference, 
													%assignDID%(left, right), left outer, LOCAL);
													
	
	outFile := %result_v1%;
	// output(%pr%, named('pr'));
	// output(sort(%res_out%, reference), named('res_out'));
	// output(sort(%result_trim%, reference), named('result_trim'));
	// output(sort(%resultsDistance%, reference), named('resultsDistance'));
	// output(sort(%resultsSeg%, reference), named('resultsSeg'));
	// #uniquename(LayoutScoredFetch1)
	// #uniquename(OutputLayout_Base1)
	// #uniquename(OutputLayout_Batch1)
	
	// %LayoutScoredFetch1% := RECORD	
		// string ind;
		// INTEGER2 NAMEWEIGHT := 0;
		// INTEGER2 ADDRWEIGHT := 0;
		// INTEGER2 MAINNAMEWeight := 0;
		// InsuranceHeader_xLink.Process_xIDL_Layouts.LayoutScoredFetch -mainnameweight; 
		// STRING KEY_DESC;
		// string xLink_matches;
		// string matches_desc;
		// string5 best_ssn5 := '';
		// string4 best_ssn4 := '';
		// unsigned4 best_dob := 0;
		// boolean match_best_ssn := false;
	// END;
	
	// %OutputLayout_Base1% := RECORD,MAXLENGTH(32000)
  // BOOLEAN Verified := FALSE; // has found possible results
  // BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  // BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  // BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  // BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  // DATASET(%LayoutScoredFetch1%) Results;  
// END;

// %OutputLayout_Batch1% := RECORD(%OutputLayout_Base1%),MAXLENGTH(32006)
		// SALT33.UIDType Reference;
	// END;	


// output(sort(project(%res_out%, transform(%OutputLayout_Batch1%, 
			// res := project(choosen(left.results,4), transform(%LayoutScoredFetch1%, 
					// self.key_desc := InsuranceHeader_xLink.Process_xIDL_Layouts.KeysUsedToText(left.keys_used);					
					
					// best_didRec := InsuranceHeader_PostProcess.segmentation_keys.key_did_ind(did=left.did);
					// self.ind := best_didRec[1].ind;
					// self.best_ssn5 := InsuranceHeader_xLink.mod_SSNParse(best_didRec[1].ssn).ssn5,
					// self.best_ssn4 := InsuranceHeader_xLink.mod_SSNParse(best_didRec[1].ssn).ssn4,														
					// self.match_best_ssn := (left.ssn5_match_code=7 and left.ssn5 = self.best_ssn5 or left.ssn5weight=0) and 
																	// (left.ssn4_match_code=7 and left.ssn4=self.best_ssn4) ;																	
					// self.best_dob := best_didRec[1].dob;
					
					// #if (%hasMatches%) IDLExternalLinking.mac_matchCodes(left); #end									
					// self.matches_desc := InsuranceHeader_xLink.fn_MatchesToText(self.xLink_matches);	
					// self.did := if ((left.did > 140737488355328 
															// and InsuranceHeader_xLink.Environment.Current=InsuranceHeader_xLink.Environment.Values.BOCA )or 
														// (left.stweight > 7 and left.prim_name='' and left.prim_range = ''),
															// skip, left.did);	
					// self.nameweight := MAX(0, left.fnameweight) + MAX(0, left.mnameweight) + MAX(0, LEFT.lnameweight);
					// self.mainnameweight := left.mainnameweight;
					// self.addrweight := MAX(0, left.prim_rangeweight) + MAX(0, left.prim_nameweight) + MAX(0, left.sec_rangeweight) + 
					// MAX(0, LEFT.stweight) + MAX(0, LEFT.cityweight)+ MAX(0, left.zipweight);					
					// self := left));
			// self.results := res;
			// self := left)), reference));

ENDMACRO;