import AutokeyB2,doxie,Txbus, business_header, doxie_cbrs, autokeyi, AutoStandardI, AutoHeaderI;

export Autokey_Header_ids(boolean workHard = true,boolean noFail = false,boolean includeDeepDive=true) := 

FUNCTION

business_header.doxie_MAC_Field_Declare()

boolean is_CompSearchL := company_name_value <> '' or phone_value <> '' or Business_Header.stored_bdid_value > 0;
boolean is_ContSearchL := lname_value <> '' or phone_value <> '' or addr_value <> '';	

outrec := TxBusV2_Services.layout_search_IDs;

//****** SEARCH THE AUTOKEYS
t := Txbus.Constants.autokey_qa_name;
ds := dataset([],Txbus.Layouts_Txbus.Layout_Autokeys);
typestr := 'BC';
tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t;
	export string typestr := ^.typestr;
	export set of string1 get_skip_set := txbus.constants.skip_set;
	export boolean workHard := ^.workHard;
	export boolean noFail := ^.noFail;
	export boolean useAllLookups := true;
end;
ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
TXBUSV2_Services.mac_get_payload_ids(ids,t,ds,outpl,did,bdid, typestr,, newdids, newbdids)

//***** DIDs
dids := if(is_ContSearchL, PROJECT (doxie.Get_Dids(true,true), doxie.layout_references));

newbydid := TxBusV2_Services.TxBus_raw.get_TaxNumber_from_dids(dedup(newdids+dids,all));

//***** BDIDs
tempbhmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
	export boolean score_results := false;
	export boolean nofail := true;
end;
bdids := if(is_CompSearchL,project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempbhmod),doxie_cbrs.layout_references));
newbybdid := TxBusV2_Services.TxBus_raw.get_TaxNumber_from_bdids(dedup(newbdids+bdids,all));

//***** FOR DEEP DIVES
DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));


//****** IDS DIRECTLY FROM THE PAYLOAD KEY
byak := project(outpl(taxpayer_number<>''), outrec);

dups := byak + 
	    if(includeDeepDive, deepDives);

return dedup(sort(dups, taxpayer_number, if(isDeepDive,1,0)), taxpayer_number);

END;