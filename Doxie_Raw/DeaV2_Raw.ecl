

import Doxie, dea,deav2_services,doxie_files,doxie_cbrs,business_header,codes, suppress, ut;

export DeaV2_Raw(
								dataset(Doxie.layout_references) dids = DATASET([],doxie.layout_references)
								,dataset(Doxie.Layout_ref_bdid) bdids = DATASET([],Doxie.Layout_ref_bdid)
								,dataset(DeaV2_Services.Assorted_Layouts.layout_search_IDs) regNums = DATASET([],DeaV2_Services.Assorted_Layouts.layout_search_IDs)
								,unsigned1 dppa_purpose = 0
								,unsigned1 glb_purpose = 0
								,string6 ssn_mask_value = 'NONE'
								,string32 appType
								) := FUNCTION
		
		
		bydid := DEAV2_services.DEA_raw.get_deaKeys_from_dids(dids,);

    bdids1 := project(bdids,doxie_cbrs.layout_references);							
		
		bybdid := DEAV2_services.DEA_raw.get_deaKeys_from_bdids(bdids1,);
		
		reg_nums := bydid+bybdid+regNums;
		
		sorted_regNums :=  dedup(sort(reg_nums,dea_registration_number),dea_registration_number);
	
	  out := DEAV2_services.DEA_raw.search_view.by_deakey(sorted_regNums, ssn_mask_value, appType);
	
  	return out;

END;								