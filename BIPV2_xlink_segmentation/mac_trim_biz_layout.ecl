EXPORT mac_trim_biz_layout(inDataset, inReference_field = 'reference') := functionmacro //inReference_field = 'reference' for thor, 'uniqueid' for roxie

IMPORT BizLinkFull;
#UNIQUENAME(LayoutScoredFetch)
	%LayoutScoredFetch% := RECORD(BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch)
	 string ind := '';
  END;
	
#UNIQUENAME(OutFileLayoutTrim)
%OutFileLayoutTrim% := RECORD
	DATASET(%LayoutScoredFetch%) results_seleid;
	UNSIGNED6 reference_biz;
	end;
	
#UNIQUENAME(outDataset)
%outDataset% := PROJECT(inDataset, TRANSFORM(%OutFileLayoutTrim%, 
												SELF.reference_biz := LEFT.inReference_field,													
												SELF.results_seleid := PROJECT(LEFT.results_seleid, TRANSFORM(%LayoutScoredFetch%, SELF := LEFT; SELF := [];))
												));
return %outDataset%;
endmacro;


