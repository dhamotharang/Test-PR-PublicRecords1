import autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild,versioncontrol;

export Proc_build_Bid_autoKeys(

	 string								pversion
	,dataset(Layouts.new_bid_KeyBuild)	pBase = files(pversion).KeyBuild
	
) :=FUNCTION
zero := 0;
 lskname:=Constants().bid_autokeytemplate	;
llgname:=Keynames(pversion).bid_autokeyroot.new;

new_pBase:=project(pBase,transform(Layouts.KeyBuild, self.bdid:=left.bid;self:=left;));

autokey.mac_useFakeIDs(
		 new_pBase
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);


	dBase_Prep_Autokey :=  project(pBase_withFakeID
	,transform(autokey.layouts.master, 
		self.inp.fname						:= 	left.fname; 
		self.inp.mname						:= 	left.mname; 
		self.inp.lname						:= 	left.lname; 
		//self.inp.phone					:= 	(string10)left.phone1; 
		self.inp.prim_name					:= 	left.prim_name; 
		self.inp.prim_range					:= 	left.prim_range; 
		self.inp.st							:= 	left.st; 
		self.inp.city_name					:= 	left.v_city_name; 
		self.inp.zip						:= 	left.zip;
		self.inp.sec_range					:= 	left.sec_range; 
		self.inp.states						:= 	zero; 
		self.inp.lname1						:= 	zero; 
		self.inp.lname2						:= 	zero; 
		self.inp.lname3						:= 	zero; 
		self.inp.city1						:= 	zero; 
		self.inp.city2						:= 	zero; 
		self.inp.city3						:= 	zero; 
		self.inp.rel_fname1					:= 	zero; 
		self.inp.rel_fname2					:= 	zero; 
		self.inp.rel_fname3					:= 	zero; 
		self.inp.lookups					:= 	zero; 
		self.inp.DID						:= 	left.DID; 
		self.inp.ssn                        :=	left.ssn;
		self.inp.bname						:= 	left.busname; 
		//self.inp.bphone					:= 	(string10)left.phone1; 
		self.inp.bprim_name					:= 	left.prim_name; 
		self.inp.bprim_range				:= 	left.prim_range; 
		self.inp.bst						:= 	left.st; 
		self.inp.bcity_name					:= 	left.v_city_name; 
		self.inp.bzip						:= 	left.zip; 
		self.inp.bsec_range					:= 	left.sec_range; 
		self.inp.BDID						:= 	left.BDID; 
		self.FakeID 						:= 	left.fakeid;
		self								:=	[];
	));  	  
	 
	mod_AKB :=
	module(AutokeyB2.Fn_Build.params) 
		export dataset(autokey.layouts.master)	L_indata := dBase_Prep_Autokey											; 
		export string	L_inkeyname						 := Constants().Bid_autokeytemplate						;
		export string	L_inlogical						 := Keynames(pversion).bid_autokeyroot.new			;
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

