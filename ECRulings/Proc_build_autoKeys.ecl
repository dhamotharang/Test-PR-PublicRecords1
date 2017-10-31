import autokeyb2, ut, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,versioncontrol;

export Proc_build_autoKeys(

	 string								pversion
	,dataset(ECRulings.Layouts.Clean_comp_DeciPub_EconomicAct_Eventdoc)	pBase =Files(pversion).keyBase
	
) :=FUNCTION
zero := 0;
 lskname:=Constants().autokeytemplate	;
llgname:= Keynames(pversion).autokeyroot.new;

	autokey.mac_useFakeIDs(
		 pBase
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);


	dBase_Prep_Autokey :=  project(pBase_withFakeID
	,transform(autokey.layouts.master,
		self.inp.bname						:= 	left.BusinessName; 
		self.inp.bst						:= 	left.EU_country_code; 
		self.FakeID 						:= 	left.fakeid;
		self								:=	[];
	));  	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata := dBase_Prep_Autokey											; 
		export string	L_inkeyname						 := Constants().autokeytemplate						;
		export string	L_inlogical						 := Keynames(pversion).autokeyroot.new			;
		export set of string1 		L_build_skip_set	 := Constants().autokey_buildskipset			; 
	end; 
	
	Build_autokeys := sequential(AutokeyB2.Fn_Build.Do(mod_AKB
   									,AutoKeyI.BuildI_Indv.DoBuild
   									,AutoKeyI.BuildI_Biz.DoBuild
   											)); 

	return parallel(
		 build_payload_key
		,Build_autokeys
	);


end;

