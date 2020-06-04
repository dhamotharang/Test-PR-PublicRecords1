import autokeyb2, ut, standard, ut, doxie, autokey, AutoKeyI, RoxieKeyBuild;

export Build_Autokeys(

	 string									pversion
	,dataset(Layouts.Base)	pBase			= files().base.built
	
) :=
FUNCTION
	
	zero := 0;
	
	lskname := _Constants().autokeytemplate				;
	llgname := Keynames(pversion).autokeyroot.new	;
	newBase := PROJECT(pBase, TRANSFORM(Layouts.Keybuild, SELF := LEFT));
	
	autokey.mac_useFakeIDs(
		 newBase
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);


	dBase_Prep_Autokey :=  project(pBase_withFakeID
	,transform(autokey.layouts.master, 
		self.inp.fname				:= '';
		self.inp.mname				:= '';
		self.inp.lname				:= '';
		self.inp.ssn					:= ''; 
		self.inp.dob					:= zero; 
		self.inp.phone				:= ''; 
		self.inp.prim_name		:= ''; 
		self.inp.prim_range		:= ''; 
		self.inp.st						:= ''; 
		self.inp.city_name		:= ''; 
		self.inp.zip					:= '';
		self.inp.sec_range		:= ''; 
		self.inp.states				:= zero; 
		self.inp.lname1				:= zero; 
		self.inp.lname2				:= zero; 
		self.inp.lname3				:= zero; 
		self.inp.city1				:= zero; 
		self.inp.city2				:= zero; 
		self.inp.city3				:= zero; 
		self.inp.rel_fname1		:= zero; 
		self.inp.rel_fname2		:= zero; 
		self.inp.rel_fname3		:= zero; 
		self.inp.lookups			:= zero; 
		self.inp.DID					:= zero; 
		self.inp.bname				:= left.rawfields.BusinessName; 
		self.inp.fein					:= ''; 
		self.inp.bphone				:= left.clean_phones.phone; 
		self.inp.bprim_name		:= left.clean_address.prim_name; 
		self.inp.bprim_range	:= left.clean_address.prim_range; 
		self.inp.bst					:= left.clean_address.st; 
		self.inp.bcity_name		:= left.clean_address.p_city_name; 
		self.inp.bzip					:= left.clean_address.zip; 
		self.inp.bsec_range		:= left.clean_address.sec_range; 
		self.inp.BDID					:= left.BDID; 
		self.FakeID 					:= left.fakeid;
		self.p								:= []; 
		self.b								:= [];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata							:= dBase_Prep_Autokey; 
		export string														L_inkeyname						:= _Constants().autokeytemplate;
		export string														L_inlogical						:= Keynames(pversion).autokeyroot.new;
		export set of string1 									L_build_skip_set			:= _Constants().ak_skipSet; 
	end; 

	Build_autokeys := AutokeyB2.Fn_Build.Do(
							 mod_AKB
							,AutoKeyI.BuildI_Indv.DoBuild
							,AutoKeyI.BuildI_Biz.DoBuild
						); 

	return parallel(
		 build_payload_key
		,Build_autokeys
	);

end;
