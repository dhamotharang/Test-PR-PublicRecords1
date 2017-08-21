#workunit('name','Accutrend Moxie Keybuild/DKC ' + busreg.BusReg_Build_Date);

// BusReg.MOXIE_STUFF.server
// BusReg.MOXIE_STUFF.mount

build_keys	:= BusReg.Proc_Build_Moxie_Keys;
dkc_keys	:= BusReg.proc_DKC_Moxie_Keys;

sequential(

	 build_keys
	,dkc_keys
);