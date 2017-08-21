import autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export Build_Autokeys_Bid(

	 string									pversion
	,dataset(Layouts.Base)	pBase			= files().base.built
	
) :=
FUNCTION
	
	zero := 0;
	
	lskname := _Constants().autokeytemplate + 'bid::' 				;
	llgname := Keynames(pversion).autokeyrootbid.new 	;
  Bidbase := project(pbase,transform(layouts.base, self.bdid := left.bid,self.bdid_score := left.bid_score,self := left));
	autokey.mac_useFakeIDs(
		 Bidbase
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
		self.inp.prim_name		:= left.FormattedBranchAddr.prim_name; 
		self.inp.prim_range		:= left.FormattedBranchAddr.prim_range; 
		self.inp.st						:= left.FormattedBranchAddr.st; 
		self.inp.city_name		:= left.FormattedBranchAddr.p_city_name; 
		self.inp.zip					:= left.FormattedBranchAddr.zip;
		self.inp.sec_range		:= left.FormattedBranchAddr.sec_range; 
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
		self.inp.DID					:= (unsigned6)left.DID; 
		self.inp.bname				:= left.rawfields.InstitutionName; 
		self.inp.fein					:= ''; 
		self.inp.bphone				:= ''; 
		self.inp.bprim_name		:= left.FormattedBranchAddr.prim_name; 
		self.inp.bprim_range	:= left.FormattedBranchAddr.prim_range; 
		self.inp.bst					:= left.FormattedBranchAddr.st; 
		self.inp.bcity_name		:= left.FormattedBranchAddr.p_city_name; 
		self.inp.bzip					:= left.FormattedBranchAddr.zip; 
		self.inp.bsec_range		:= left.FormattedBranchAddr.sec_range; 
		self.inp.BDID					:= (unsigned6)left.bdid; 
		self.FakeID 					:= left.fakeid;
		self.p								:= []; 
		self.b								:= [];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata							:= dBase_Prep_Autokey											; 
		export string														L_inkeyname						:= _Constants().autokeytemplate+'bid::'					;
		export string														L_inlogical						:= Keynames(pversion).autokeyrootbid.new			;
		export set of string1 									L_build_skip_set			:= _Constants().autokey_buildskipset			; 
	end; 

	Build_autokeys_bid := AutokeyB2.Fn_Build.Do(
							 mod_AKB
							,AutoKeyI.BuildI_Indv.DoBuild
							,AutoKeyI.BuildI_Biz.DoBuild
						); 

	return parallel(
		 build_payload_key
		,Build_autokeys_bid
	);

end;
