
import doxie,DEA,Suppress,doxie_cbrs;

export DEASearchService_ids(DATASET(assorted_Layouts.layout_DeaKey) keys 
														= DATASET([],assorted_Layouts.layout_DeaKey)
													 ) := FUNCTION

  EXPORT ID_params := MODULE(Interfaces.search_params)
			EXPORT String14 did                     := '' : STORED('DID');	
			EXPORT String bdid                     := '' : STORED('BDID');	
	END;
  doxie.MAC_Header_Field_Declare();
  doxie.MAC_Selection_Declare();
	
	//******* GRAB IDS
	ak_ids := autokey_ids(false,false,NoDeepDive);

	//******* GRAB IDS using REG NUM
	reg_ids:= PROJECT(keys,assorted_Layouts.Layout_Search_Ids);

	//******* CASCADING BOTH IDS
	dids := if( (integer)ID_params.did<>0, dataset([{(integer)ID_params.did}], doxie.layout_references) );
	by_did := dea_raw.get_deaKeys_from_dids(dids);
	bdids := if( (integer)ID_params.bdid<>0, dataset([{(integer)ID_params.bdid}], doxie_cbrs.layout_references) );
	by_bdid := dea_raw.get_deaKeys_from_bdids(bdids);
	
	ids := ak_ids + reg_ids+by_did+by_bdid ;

	DEASearch_results := DEAV2_Search_recs(ids, ssn_mask_value, application_type_value, include_CriminalIndicators_val);
	
	return (DEASearch_results);


END;

