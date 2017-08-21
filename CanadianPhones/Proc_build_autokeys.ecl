IMPORT CanadianPhones, PromoteSupers, autokeyb2, RoxieKeyBuild, standard, autokey;

// ===========================================================================
// ================================= HELPERS =================================
// ===========================================================================
string SetVersion (string pFilenameTemplate, string pVersionString) :=
  RegExReplace('@version@', StringLib.stringtolowercase(pFilenameTemplate), pVersionString);

cleanFile (string fname) := IF (FileServices.SuperFileExists (fname), FileServices.ClearSuperFile (fname));
createFile (string fname) := IF (~FileServices.SuperFileExists (fname), FileServices.CreateSuperFile (fname));
//////// CanadianPhones.key_fdids.CanadianPhones.Constants.FILE_NAME_MASK = thor_data400::temp::key::canadianwp::@version@::autokey:: //////// 
BASE_NAME := CanadianPhones.Constants.FILE_NAME_MASK;

// creates version superfile
createVersion (string version) := FUNCTION
  sk_name := SetVersion (BASE_NAME, version);
  action := PARALLEL (
    createFile (sk_name + 'address'),
    createFile (sk_name + 'addressb2'),
    createFile (sk_name + 'citystname'),
    createFile (sk_name + 'citystnameb2'),
    createFile (sk_name + 'name'),
    createFile (sk_name + 'namewords2'),
    createFile (sk_name + 'nameb2'),
    createFile (sk_name + 'fein2'),
    createFile (sk_name + 'phone2'),
    createFile (sk_name + 'phoneb2'),
    createFile (sk_name + 'stname'),
    createFile (sk_name + 'stnameb2'),
    createFile (sk_name + 'zipb2'),
    createFile (sk_name + 'zip'),
    createFile (sk_name + 'zipPRLname'));

  return action;
END;

// creates BUILT, FATHER, QA, if not yet created
createSuperAutoFiles () := FUNCTION
  return PARALLEL (createVersion ('built'), createVersion ('qa'), createVersion ('father'));
END;


CleanSuperFile (string fname) := FUNCTION
  delete := SEQUENTIAL (
    FileServices.StartSuperFileTransaction (),
    FileServices.ClearSuperFile (fname),
    FileServices.FinishSuperFileTransaction()
  );
  return IF (FileServices.SuperFileExists (fname), delete);
END;

// removes all subfiles from superfiles, like "qa", "father", etc.
CleanSuperFileFamily (string fname) := FUNCTION
  action := PARALLEL (
    CleanSuperFile (SetVersion (fname, 'built')),
    CleanSuperFile (SetVersion (fname, 'qa')),
    CleanSuperFile (SetVersion (fname, 'father')),
    CleanSuperFile (SetVersion (fname, 'grandfather')),
    CleanSuperFile (SetVersion (fname, 'grandgrandfather'))
  );
  return action;
END;

CleanAutoFamily () := FUNCTION
  return PARALLEL (
    CleanSuperFileFamily (BASE_NAME + 'address'),
    CleanSuperFileFamily (BASE_NAME + 'addressb2'),
    CleanSuperFileFamily (BASE_NAME + 'citystname'),
    CleanSuperFileFamily (BASE_NAME + 'citystnameb2'),
    CleanSuperFileFamily (BASE_NAME + 'name'),
    CleanSuperFileFamily (BASE_NAME + 'namewords2'),
    CleanSuperFileFamily (BASE_NAME + 'nameb2'),
    CleanSuperFileFamily (BASE_NAME + 'fein2'),
    CleanSuperFileFamily (BASE_NAME + 'phone2'),
    CleanSuperFileFamily (BASE_NAME + 'phoneb2'),
    CleanSuperFileFamily (BASE_NAME + 'stname'),
    CleanSuperFileFamily (BASE_NAME + 'stnameb2'),
    CleanSuperFileFamily (BASE_NAME + 'zipb2'),
    CleanSuperFileFamily (BASE_NAME + 'zip'),
    CleanSuperFileFamily (BASE_NAME + 'zipPRLname')
  ); 
END;



// moves from BUILT to QA and cleans BUILT
moveSuperAutoFiles () := FUNCTION
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'address', 'Q', mv_1, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'addressb2', 'Q', mv_1b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'citystname', 'Q', mv_2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'citystnameb2', 'Q', mv_2b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'name', 'Q', mv_3, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'namewords2', 'Q', mv_3w2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'nameb2', 'Q', mv_3b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'fein2', 'Q', mv_3f, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'phone2', 'Q', mv_4, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'phoneb2', 'Q', mv_4b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'stname', 'Q', mv_5, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'stnameb2', 'Q', mv_5b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'zipb2', 'Q', mv_6b2, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'zip', 'Q', mv_6, 2);
  RoxieKeyBuild.MAC_SK_Move_V2 (BASE_NAME + 'zipPRLname', 'Q', mv_7, 2);
  move := PARALLEL (mv_1, mv_1b2,mv_2,mv_2b2, mv_3,mv_3w2, mv_3b2, mv_3f, mv_4,mv_4b2, mv_5, mv_6, mv_5b2, mv_6b2, mv_7);

  sk_name := SetVersion (BASE_NAME, 'built');
  clean := PARALLEL (
    cleanFile (sk_name + 'address'),
    cleanFile (sk_name + 'addressb2'),
    cleanFile (sk_name + 'citystname'),
    cleanFile (sk_name + 'citystnameb2'),
    cleanFile (sk_name + 'name'),
    cleanFile (sk_name + 'namewords2'),
    cleanFile (sk_name + 'nameb2'),
    cleanFile (sk_name + 'fein2'),
    cleanFile (sk_name + 'phone2'),
    cleanFile (sk_name + 'phoneb2'),
    cleanFile (sk_name + 'stname'),
    cleanFile (sk_name + 'stnameb2'),
    cleanFile (sk_name + 'zipb2'),
    cleanFile (sk_name + 'zip'),
    cleanFile (sk_name + 'zipPRLname'));

  action := SEQUENTIAL (move, clean);
  return action;
END;

EXPORT proc_build_autokeys (string filedate) := FUNCTION

// ===========================================================================
// =========================== BUILD MAIN FILE/KEYS ==========================
// ===========================================================================

  RoxieKeyBuild.Mac_SK_BuildProcess_v2_local (CanadianPhones.key_fdids, '',
    '~thor_data400::key::canadianwp::'+filedate+'::fdids', bld_fdid);
				 
// ===========================================================================
// ============================ BUILD AUTOKEYS ===============================
// ===========================================================================
  base := CanadianPhones.file_cwp_with_fdid;

newbase:= record
base;
zero := 0;
blank:= '';
// bdid := 0;
typeof(base.fdid) fdid2;
end;

newbase Prepare (base L) := TRANSFORM
    SELF.zero := 0;
		self.fdid2 := l.fdid;
    SELF := L;
  END;
  
base_autoready := PROJECT (base, Prepare (Left));



// BUILD AUTOKEYS USING THE NEW INTERFACE APPROACH

outdataset := 
	project(
		base_autoready,
		transform(
			autokey.layouts.master,
			self.inp.fname := left.firstname;
			self.inp.mname := left.middlename;
			self.inp.lname := left.lastname;
			self.inp.ssn := '';
			self.inp.dob := 0;
			self.inp.phone := (string10)left.phonenumber;
			self.inp.prim_name := left.prim_name;
			self.inp.prim_range := left.prim_range;
			self.inp.st := left.state;
			self.inp.city_name := left.p_city_name;
			self.inp.zip := (string6)left.zip;
			self.inp.sec_range := left.sec_range;
			self.inp.states := 0;
			self.inp.lname1 := 0;
			self.inp.lname2 := 0;
			self.inp.lname3 :=0;
			self.inp.city1 := 0;
			self.inp.city2 := 0;
			self.inp.city3 := 0;
			self.inp.rel_fname1 := 0;
			self.inp.rel_fname2 := 0;
			self.inp.rel_fname3 := 0;
			self.inp.lookups := 0;
			self.inp.DID := (unsigned6)left.fdid;
			self.inp.bname := left.company_name;
			self.inp.fein := '';
			self.inp.bphone := (string10)left.phonenumber;
			self.inp.bprim_name := left.prim_name;
			self.inp.bprim_range := left.prim_range;
			self.inp.bst := left.state;
			self.inp.bcity_name := left.p_city_name;
			self.inp.bzip := (string6)left.zip;
			self.inp.bsec_range := left.sec_range;
			self.inp.BDID := (unsigned6)left.fdid2;
			self.FakeID := 0;
			self.p := [];
			self.b := [];
		)
	);


akmod := module(AutokeyB2.Fn_Build.params)
	export dataset(autokey.layouts.master) L_indata := outdataset;
	export string L_inkeyname 								:= BASE_NAME;
	export string L_inlogical 								:= SetVersion (BASE_NAME, filedate);
	export boolean L_diffing 									:= false;
	export boolean L_Indv_useAllLookups				:= true;				
	export boolean L_useOnlyRecordIDs					:= true;
	export boolean L_useFakeIDs								:= false;
	export boolean L_AddCities								:= false;
	export set of string1 L_build_skip_set 		:= CanadianPhones.Constants.skip_set;
end;	


bld_auto_keys := AutokeyB2.Fn_Build.Do(akmod,CanadianPhones.MAutokey,CanadianPhones.MAutokeyb);




// ========================================================================
// ============================ MOVE TO ... ===============================
// ========================================================================
		
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::canadianwp_fdids',
	   '~thor_data400::key::canadianwp::'+filedate+'::fdids',mv_fdid_to_blt);

  PromoteSupers.MAC_SK_Move_v2('~thor_data400::key::canadianwp_fdids', 'Q', mv_fdid_to_qa);


  createSupers := createSuperAutoFiles ();
  moveSupers := moveSuperAutoFiles ();

  res := 
		parallel(
			SEQUENTIAL(
				// /*CleanAutoFamily (),*/
        createSupers,  // creates, if necessary, super files
        bld_auto_keys,  //  builds autokeys
        moveSupers     // moves, cleans, etc.
      ),
			SEQUENTIAL(
				bld_fdid,
				mv_fdid_to_blt,
				mv_fdid_to_qa
			)
		);

  return res;
end;
