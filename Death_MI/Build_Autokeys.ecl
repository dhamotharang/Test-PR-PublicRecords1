IMPORT Autokey, AutokeyB2, AutoKeyI;

EXPORT Build_Autokeys(STRING pversion,
                      DATASET(Layouts.Base) pBase = Files(pversion).Base.Main.Built,
											BOOLEAN							  pOverwrite = FALSE) := FUNCTION

	UNSIGNED4 zero := 0;

	lskname := Keynames(pversion).lAutoKeyTemplate;
	llgname := Keynames(pversion).autokeyroot.new;

	clear_autokey_files_w_delete :=
	  SEQUENTIAL(FileServices.StartSuperFileTransaction();
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::address', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::citystname', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::name', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::ssn2', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::stname', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::zip', TRUE);
							 FileServices.ClearSuperFile('~thor_data400::key::Death_MI::qa::autokey::payload', TRUE);
							 FileServices.FinishSuperFileTransaction();
	            );

	Autokey.mac_useFakeIDs(pBase,
		                     pBase_withFakeID,
		                     build_payload_key,
		                     lskname,
		                     llgname,
		                     did,
		                     bdid);

	dBase_Prep_Autokey :=
	  PROJECT(pBase_withFakeID,
						TRANSFORM(AutoKey.Layouts.Master,
											SELF.inp.fname			 := LEFT.clean_name.fname;
											SELF.inp.mname			 := LEFT.clean_name.mname;
											SELF.inp.lname			 := LEFT.clean_name.lname;
											SELF.inp.ssn				 := '';
											SELF.inp.dob				 := (UNSIGNED)LEFT.dob;
											SELF.inp.phone			 := '';
											SELF.inp.prim_name	 := LEFT.clean_address.prim_name;
											SELF.inp.prim_range	 := LEFT.clean_address.prim_range;
											SELF.inp.st					 := LEFT.clean_address.st;
											SELF.inp.city_name	 := LEFT.clean_address.p_city_name;
											SELF.inp.zip				 := LEFT.clean_address.zip;
											SELF.inp.sec_range	 := LEFT.clean_address.sec_range;
											SELF.inp.states			 := zero;
											SELF.inp.lname1			 := zero;
											SELF.inp.lname2			 := zero;
											SELF.inp.lname3			 := zero;
											SELF.inp.city1			 := zero;
											SELF.inp.city2			 := zero;
											SELF.inp.city3			 := zero;
											SELF.inp.rel_fname1	 := zero;
											SELF.inp.rel_fname2	 := zero;
											SELF.inp.rel_fname3	 := zero;
											SELF.inp.lookups		 := zero;
											SELF.inp.DID				 := (UNSIGNED)LEFT.DID;
											SELF.inp.bname			 := '';
											SELF.inp.fein				 := '';
											SELF.inp.bphone			 := '';
											SELF.inp.bprim_name	 := '';
											SELF.inp.bprim_range := '';
											SELF.inp.bst				 := '';
											SELF.inp.bcity_name	 := '';
											SELF.inp.bzip				 := '';
											SELF.inp.bsec_range	 := '';
											SELF.inp.BDID				 := zero;
											SELF.FakeID 				 := LEFT.fakeid;
											SELF.p							 := [];
											SELF.b							 := [];));

	mod_AKB :=
	  MODULE(AutokeyB2.Fn_Build.params)
		  EXPORT DATASET(AutoKey.Layouts.Master) L_indata               := dBase_Prep_Autokey;
		  EXPORT STRING													 L_inkeyname						:= _Constants().autokeytemplate;
		  EXPORT STRING													 L_inlogical						:= Keynames(pversion).autokeyroot.new;
		  EXPORT SET OF STRING1 								 L_build_skip_set			  := _Constants().autokey_buildskipset;
		  EXPORT BOOLEAN                         L_processCompoundNames := TRUE;
	  END;

	Build_autokeys := PARALLEL(build_payload_key,
	                           AutokeyB2.Fn_Build.Do(mod_AKB,
							                                     AutoKeyI.BuildI_Indv.DoBuild,
							                                     AutoKeyI.BuildI_Biz.DoBuild));

	AutoKeyB2.MAC_AcceptSK_to_QA(_Constants().autokeytemplate, moveToQA);

	RETURN SEQUENTIAL(IF(pOverwrite, clear_autokey_files_w_delete),
	                  Build_autokeys,
		                moveToQA);

END;
