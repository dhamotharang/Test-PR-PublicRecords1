import  autokey, AutoKeyI,AutokeyB2;

export Build_Autokeys(

	 string											pversion
	,dataset(Layouts.Base.Main)		      pBaseMainBuilt		  =	Files(pversion).Base.Main.Built	

) :=
FUNCTION
	
	dAutokey			:=	FraudDefenseNetwork.File_Autokey(pBaseMainBuilt) ; 
	zero := 0;
	
	lskname := Keynames(pversion).llogicalautoTmplt;
	llgname := Keynames(pversion).autokeyroot.new	;
	
	autokey.mac_useFakeIDs(
		 dAutokey
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);

	dBase_Prep_Autokey :=  normalize(pBase_withFakeID
	  ,if(left.clean_phones.cell_phone != '',2,1)
		,transform(autokey.layouts.master, 
		  boolean is_company := if(left.clean_business_name<>'',true,false); 
		self.inp.fname				:= left.cleaned_name.fname; 
		self.inp.mname				:= left.cleaned_name.mname; 
		self.inp.lname				:= left.cleaned_name.lname; 
		self.inp.ssn					:= left.ssn;
		self.inp.dob					:= (unsigned)left.dob; 
		self.inp.phone				:= choose(counter,left.clean_phones.phone_number,left.clean_phones.cell_phone);
		self.inp.prim_name		:= left.clean_address.prim_name;  
		self.inp.prim_range		:= left.clean_address.prim_range;  
		self.inp.st						:= left.clean_address.st;  
		self.inp.city_name		:= left.clean_address.p_city_name;  
		self.inp.zip					:= left.clean_address.zip; 
		self.inp.sec_range		:= left.clean_address.sec_range;  
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
		self.inp.DID					:=  left.DID; 
		self.inp.bname				:=  if(is_company,left.clean_business_name,''); 
		self.inp.fein					:=  if(is_company,left.fein,'');
		self.inp.bphone				:=  if(is_company,choose(counter,left.clean_phones.phone_number,left.clean_phones.cell_phone),'');
		self.inp.bprim_name		:=  if(is_company,left.clean_address.prim_name,''); 
		self.inp.bprim_range	:=  if(is_company,left.clean_address.prim_range,'');  
		self.inp.bst					:=  if(is_company,left.clean_address.st,''); 
		self.inp.bcity_name		:=  if(is_company,left.clean_address.p_city_name,''); 
		self.inp.bzip					:=  if(is_company,left.clean_address.zip,''); 
		self.inp.bsec_range		:=  if(is_company,left.clean_address.sec_range,''); 
		self.inp.BDID					:=  if(is_company,(unsigned6)left.BDID,0); 
		self.FakeID 					:=  left.fakeid; 
		self.p								:= []; 
		self.b								:= [];
	)); 	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata								:= dBase_Prep_Autokey											; 
		export string														L_inkeyname							:= _Dataset().autokeytemplate						;
		export string														L_inlogical							:= Keynames(pversion).autokeyroot.new			;
		export set of string1 									L_build_skip_set				:= _Dataset().autokey_buildskipset			; 
	  export boolean                          L_processCompoundNames	:= true;
	end; 

	Build_autokeys := PARALLEL(build_payload_key,
	                           AutokeyB2.Fn_Build.Do(mod_AKB,
							                                     AutoKeyI.BuildI_Indv.DoBuild,
							                                     AutoKeyI.BuildI_Biz.DoBuild)); 

	AutoKeyB2.MAC_AcceptSK_to_QA(_Dataset().autokeytemplate, moveToQA);

	return SEQUENTIAL(
		 Build_autokeys
		,moveToQA
	);

end;
