IMPORT ut, doxie, autokeyb2, Autokey;

export FetchBizFein (String keyNameRoot, boolean aNoFail = true) := function

	companyIdSet := Functions.getCompanyIdSet();
	
	doxie.MAC_Header_Field_Declare ();
	
	fv := if(fein_value = 0, '', trim(Stringlib.StringFilterOut(fein_val,'-')));
			
	//***** DECLARE KEYS
	kb 	:= autokeyb2.Key_FEIN(keyNameRoot);
	kbread := kb(fv<>'',keyed(f1=fv[1]),keyed(f2=fv[2]),keyed(f3=fv[3]),keyed(f4=fv[4]),keyed(f5=fv[5]),keyed(f6=fv[6]),keyed(f7=fv[7]),keyed(f8=fv[8]),keyed(f9=fv[9]), lookups in CompanyIdSet);
			
	//***** INTO OUTREC AND CHECK LOOKUP IN B2
	outrec := autokeyb2.layout_fetch;
	pb 	:= project(kbread, outrec);

	nofail := aNoFail;
			
	//***** LIMIT
	Autokey.mac_Limits(pb,p_ret)

	return p_ret;
end;
	