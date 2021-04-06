IMPORT  autokey, AutoKeyI,AutokeyB2, dx_FraudDefenseNetwork;

EXPORT Build_Autokeys(STRING pversion,
	                    DATASET(Layouts.Base.Main) pBaseMainBuilt =	Files(pversion).Base.Main.Built) := FUNCTION
	
	dAutokey			:=	File_Autokey(pBaseMainBuilt) ; 
	zero := 0;
	
	lskname := dx_FraudDefenseNetwork.Constants.ak_keyname;
	llgname := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.FDN_AUTOKEY + '::';
	
	autokey.mac_useFakeIDs(
		 dAutokey
		,pBase_withFakeID
		,build_payload_key
		,lskname
		,llgname
		,DID
		,bdid
	);

	layout_autokey_temp := RECORD
	  autokey.Layouts.master;
	  dx_FraudDefenseNetwork.Layouts.address_cleaner additional_address;
	END;

	dBase_Prep_Autokey_Temp :=  NORMALIZE(pBase_withFakeID
															,IF(LEFT.clean_phones.cell_phone != '',2,1)
															,TRANSFORM(layout_autokey_temp, 
    BOOLEAN is_company 		  := IF(LEFT.clean_business_name<>'',TRUE,FALSE); 
		SELF.inp.fname					:= LEFT.cleaned_name.fname; 
		SELF.inp.mname					:= LEFT.cleaned_name.mname; 
		SELF.inp.lname					:= LEFT.cleaned_name.lname; 
		SELF.inp.ssn						:= LEFT.ssn;
		SELF.inp.dob						:= (UNSIGNED)left.dob; 
		SELF.inp.phone					:= CHOOSE(COUNTER,LEFT.clean_phones.phone_number,LEFT.clean_phones.cell_phone);
		SELF.inp.prim_name			:= LEFT.clean_address.prim_name;  
		SELF.inp.prim_range			:= LEFT.clean_address.prim_range;  
		SELF.inp.st							:= LEFT.clean_address.st;  
		SELF.inp.city_name			:= LEFT.clean_address.p_city_name;  
		SELF.inp.zip						:= LEFT.clean_address.zip; 
		SELF.inp.sec_range			:= LEFT.clean_address.sec_range;  
		SELF.inp.states					:= zero; 
		SELF.inp.lname1					:= zero; 
		SELF.inp.lname2					:= zero; 
		SELF.inp.lname3					:= zero; 
		SELF.inp.city1					:= zero; 
		SELF.inp.city2					:= zero; 
		SELF.inp.city3					:= zero; 
		SELF.inp.rel_fname1			:= zero; 
		SELF.inp.rel_fname2			:= zero; 
		SELF.inp.rel_fname3			:= zero; 
		SELF.inp.lookups				:= zero; 
		SELF.inp.DID						:=  LEFT.DID; 
		SELF.inp.bname					:=  IF(is_company,LEFT.clean_business_name,''); 
		SELF.inp.fein						:=  IF(is_company,LEFT.fein,'');
		SELF.inp.bphone					:=  IF(is_company,CHOOSE(COUNTER,LEFT.clean_phones.phone_number,LEFT.clean_phones.cell_phone),'');
		SELF.inp.bprim_name			:=  IF(is_company,LEFT.clean_address.prim_name,''); 
		SELF.inp.bprim_range		:=  IF(is_company,LEFT.clean_address.prim_range,'');  
		SELF.inp.bst						:=  IF(is_company,LEFT.clean_address.st,''); 
		SELF.inp.bcity_name			:=  IF(is_company,LEFT.clean_address.p_city_name,''); 
		SELF.inp.bzip						:=  IF(is_company,LEFT.clean_address.zip,''); 
		SELF.inp.bsec_range			:=  IF(is_company,LEFT.clean_address.sec_range,'');
		SELF.inp.BDID						:=  IF(is_company,(UNSIGNED6)LEFT.BDID,0); 
		SELF.FakeID 						:=  LEFT.fakeid; 
		SELF.additional_address	:=  LEFT.additional_address;
		SELF.p									:= []; 
		SELF.b									:= [];
	)); 	  
	
	dBase_Prep_Autokey				:=NORMALIZE(dBase_Prep_Autokey_Temp
															,IF((LEFT.additional_address.clean_address.prim_name<>'' AND
															LEFT.additional_address.clean_address.prim_range<>'' AND
															LEFT.additional_address.clean_address.p_city_name<>'' AND
															LEFT.additional_address.clean_address.st<>''),2,1)					
		,transform(autokey.layouts.master, 
		SELF.inp.prim_name		:= choose(COUNTER,LEFT.inp.prim_name,LEFT.additional_address.clean_address.prim_name);  
		SELF.inp.prim_range		:= choose(COUNTER,LEFT.inp.prim_range,LEFT.additional_address.clean_address.prim_range);  
		SELF.inp.st						:= choose(COUNTER,LEFT.inp.st,LEFT.additional_address.clean_address.st);  
		SELF.inp.city_name		:= choose(COUNTER,LEFT.inp.city_name,LEFT.additional_address.clean_address.p_city_name);  
		SELF.inp.zip					:= choose(COUNTER,LEFT.inp.zip,LEFT.additional_address.clean_address.zip); 
		SELF.inp.sec_range		:= choose(COUNTER,LEFT.inp.sec_range,LEFT.additional_address.clean_address.sec_range);  
		SELF.inp.bprim_name		:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bprim_name,LEFT.additional_address.clean_address.prim_name),''); 
		SELF.inp.bprim_range	:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bprim_range,LEFT.additional_address.clean_address.prim_range),'');  
		SELF.inp.bst					:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bst,LEFT.additional_address.clean_address.st),''); 
		SELF.inp.bcity_name		:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bcity_name,LEFT.additional_address.clean_address.p_city_name),''); 
		SELF.inp.bzip					:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bzip,LEFT.additional_address.clean_address.zip),''); 
		SELF.inp.bsec_range		:=  IF(LEFT.inp.bname<>'',CHOOSE(COUNTER,LEFT.inp.bsec_range,LEFT.additional_address.clean_address.sec_range),''); 
		SELF				 					:=  LEFT;
   	)); 
	
	
	mod_AKB :=
	MODULE(AutokeyB2.Fn_Build.params) 
		EXPORT DATASET(autokey.layouts.master)	L_indata								:= dBase_Prep_Autokey; 
		EXPORT STRING														L_inkeyname							:= dx_FraudDefenseNetwork.Constants.ak_keyname;
		EXPORT STRING														L_inlogical							:= dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.FDN_AUTOKEY + '::';
		EXPORT SET OF STRING1 									L_build_skip_set				:= dx_FraudDefenseNetwork.Constants.ak_skipSet;
	  EXPORT BOOLEAN                          L_processCompoundNames	:= TRUE;
	END; 

	Build_autokeys := PARALLEL(build_payload_key,
	                           AutokeyB2.Fn_Build.Do(mod_AKB,
							                                     AutoKeyI.BuildI_Indv.DoBuild,
							                                     AutoKeyI.BuildI_Biz.DoBuild)); 

	AutoKeyB2.MAC_AcceptSK_to_QA(_Dataset().autokeytemplate, moveToQA);

	RETURN SEQUENTIAL(
		 Build_autokeys
		,moveToQA
	);

END;
