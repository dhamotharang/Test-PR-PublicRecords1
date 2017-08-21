import autokeyb2, autokey, AutoKeyI;

export Build_Autokeys(

	 string											pversion
	,dataset(Layouts.Base.Main_without_rid)	pBase			=	project (Files(pversion).Base.Main.Built,Layouts.Base.Main_without_rid)
	
) :=
FUNCTION
	
	zero := 0;
	
	lskname := Keynames(pversion).lAutoKeyTemplate;
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


	dBase_Prep_Autokey :=  normalize(pBase_withFakeID
	,if(left.clean_phones.fax != '',2,1)
	,transform(autokey.layouts.master, 
		self.inp.fname				:= left.clean_name.fname; 
		self.inp.mname				:= left.clean_name.mname; 
		self.inp.lname				:= left.clean_name.lname; 
		self.inp.ssn					:= '';
		self.inp.dob					:= (unsigned)left.rawdemographicsfields.dob_date; 
		self.inp.phone				:= choose(counter,left.clean_phones.phone,left.clean_phones.fax);
		self.inp.prim_name		:= left.clean_company_address.prim_name; 
		self.inp.prim_range		:= left.clean_company_address.prim_range; 
		self.inp.st						:= left.clean_company_address.st; 
		self.inp.city_name		:= left.clean_company_address.p_city_name; 
		self.inp.zip					:= left.clean_company_address.zip;
		self.inp.sec_range		:= left.clean_company_address.sec_range; 
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
		self.inp.bname				:= left.rawdemographicsfields.ACCT_NAME; 
		self.inp.fein					:= left.rawdemographicsfields.TAX_ID;
		self.inp.bphone				:= choose(counter,left.clean_phones.phone,left.clean_phones.fax);
		self.inp.bprim_name		:= left.clean_company_address.prim_name; 
		self.inp.bprim_range	:= left.clean_company_address.prim_range; 
		self.inp.bst					:= left.clean_company_address.st; 
		self.inp.bcity_name		:= left.clean_company_address.p_city_name; 
		self.inp.bzip					:= left.clean_company_address.zip; 
		self.inp.bsec_range		:= left.clean_company_address.sec_range; 
		self.inp.BDID					:= (unsigned6)left.BDID; 
		self.FakeID 					:= left.fakeid;
		self.p								:= []; 
		self.b								:= [];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata								:= dBase_Prep_Autokey											; 
		export string														L_inkeyname							:= _Constants().autokeytemplate						;
		export string														L_inlogical							:= Keynames(pversion).autokeyroot.new			;
		export set of string1 									L_build_skip_set				:= _Constants().autokey_buildskipset			; 
	  export boolean                          L_processCompoundNames	:= true;
	end; 

	Build_autokeys := PARALLEL(build_payload_key,
	                           AutokeyB2.Fn_Build.Do(mod_AKB,
							                                     AutoKeyI.BuildI_Indv.DoBuild,
							                                     AutoKeyI.BuildI_Biz.DoBuild)); 

	AutoKeyB2.MAC_AcceptSK_to_QA(_Constants().autokeytemplate, moveToQA);

	return SEQUENTIAL(
		 Build_autokeys
		,moveToQA
	);

end;
