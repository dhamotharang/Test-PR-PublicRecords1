import autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export Build_Autokeys(

	 string									pversion
	,dataset(Layouts.Base)	pBase			= files().base.built
	
) :=
FUNCTION
	
	zero := 0;
	
	lskname := _Constants().autokeytemplate				;
	llgname := Keynames(pversion).autokeyroot.new	;
	
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
		self.inp.fname				:= left.subject_name.fname; 
		self.inp.mname				:= left.subject_name.mname; 
		self.inp.lname				:= left.subject_name.lname; 
		self.inp.ssn					:= if(left.subject_ssn=0,'',intformat(left.subject_ssn,9,1)); 
		self.inp.dob					:= left.subject_dob; 
		self.inp.phone				:= (string10)left.subject_phone; 
		self.inp.prim_name		:= left.subject_address.prim_name; 
		self.inp.prim_range		:= left.subject_address.prim_range; 
		self.inp.st						:= left.subject_address.st; 
		self.inp.city_name		:= left.subject_address.city_name; 
		self.inp.zip					:= left.subject_address.zip;
		self.inp.sec_range		:= left.subject_address.sec_range; 
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
		self.inp.bname				:= left.company_name; 
		self.inp.fein					:= if(left.company_fein		=0,'',intformat(left.company_fein,9,1)); 
		self.inp.bphone				:= if(left.company_phone 	=0,'',(string10)left.company_phone		); 
		self.inp.bprim_name		:= left.company_address.prim_name; 
		self.inp.bprim_range	:= left.company_address.prim_range; 
		self.inp.bst					:= left.company_address.st; 
		self.inp.bcity_name		:= left.company_address.city_name; 
		self.inp.bzip					:= left.company_address.zip; 
		self.inp.bsec_range		:= left.company_address.sec_range; 
		self.inp.BDID					:= (unsigned6)left.BDID; 
		self.FakeID 					:= left.fakeid;
		self.p								:= []; 
		self.b								:= [];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata							:= dBase_Prep_Autokey											; 
		export string														L_inkeyname						:= _Constants().autokeytemplate						;
		export string														L_inlogical						:= Keynames(pversion).autokeyroot.new			;
		export set of string1 									L_build_skip_set			:= _Constants().autokey_buildskipset			; 
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
