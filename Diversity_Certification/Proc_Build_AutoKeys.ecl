import autokeyb2, ut, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export Proc_Build_Autokeys(

	 string									pversion
	
) :=
FUNCTION
	
	zero := 0;
	
	lskname := Constants().autokeytemplate				;
	llgname := Keynames(pversion).autokeyroot.new	;
	
	Addr_file:=Diversity_Certification.Address_Norm(pversion);
	autokey.mac_useFakeIDs(
		 Addr_file
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);


	dBase_Prep_Autokey :=  project(pBase_withFakeID
	,transform(autokey.layouts.master, 
		self.inp.fname				:= 	left.fname; 
		self.inp.mname				:= 	left.mname; 
		self.inp.lname				:= 	left.lname; 
		self.inp.phone				:= 	(string10)left.phone1; 
		self.inp.prim_name		:= 	left.prim_name; 
		self.inp.prim_range		:= 	left.prim_range; 
		self.inp.st						:= 	left.st; 
		self.inp.city_name		:= 	left.v_city_name; 
		self.inp.zip					:= 	left.zip;
		self.inp.sec_range		:= 	left.sec_range; 
		self.inp.states				:= 	zero; 
		self.inp.lname1				:= 	zero; 
		self.inp.lname2				:= 	zero; 
		self.inp.lname3				:= 	zero; 
		self.inp.city1				:= 	zero; 
		self.inp.city2				:= 	zero; 
		self.inp.city3				:= 	zero; 
		self.inp.rel_fname1		:= 	zero; 
		self.inp.rel_fname2		:= 	zero; 
		self.inp.rel_fname3		:= 	zero; 
		self.inp.lookups			:= 	zero; 
		self.inp.DID					:= 	(unsigned6)left.DID; 
		self.inp.bname				:= 	left.businessname; 
		self.inp.bphone				:= 	(string10)left.phone1; 
		self.inp.bprim_name		:= 	left.prim_name; 
		self.inp.bprim_range	:= 	left.prim_range; 
		self.inp.bst					:= 	left.st; 
		self.inp.bcity_name		:= 	left.v_city_name; 
		self.inp.bzip					:= 	left.zip; 
		self.inp.bsec_range		:= 	left.sec_range; 
		self.inp.BDID					:= 	(unsigned6)left.BDID; 
		self.FakeID 					:= 	left.fakeid;
		self									:=	[];
		self.p								:= 	[]; 
		self.b								:= 	[];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata							:= dBase_Prep_Autokey											; 
		export string														L_inkeyname						:= Constants().autokeytemplate						;
		export string														L_inlogical						:= Keynames(pversion).autokeyroot.new			;
		export set of string1 									L_build_skip_set			:= Constants().autokey_buildskipset			; 
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
