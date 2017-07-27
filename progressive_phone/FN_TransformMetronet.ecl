import MDR,progressive_phone;
export FN_TransformMetronet(infile, outlayout, callMetronet=false, extendLayout='true') := functionmacro

		rec_with_royal_layout := RECORD(recordof (outlayout))
			#if(extendLayout=true)
			STRING royalty_type := '';
			#end
		end;
		

rec_with_royal_layout into_out(infile pInput) := transform
	self.subj_name_dual := if(pInput.subj_phone_type_new = MDR.sourceTools.src_Metronet_Gateway, (trim(pInput.subj_first) + 
														(if(trim(pInput.subj_middle) != '', ' ' + trim(pInput.subj_middle), '' ))+ ' ' + 
														trim(pInput.subj_last) + if(trim(pInput.subj_suffix) != '', ' ' + trim(pInput.subj_suffix), '')), 
														pInput.subj_name_dual);
														
	self.subj_phone_type_new := if(pInput.subj_phone_type_new = MDR.sourceTools.src_Metronet_Gateway or 
																 pInput.subj_phone_type_new = progressive_phone.Constants.input_found_inFileOne, 'PR', pInput.subj_phone_type_new);
	
// Add royalty_type field for batch. Batch is not yet able to handle Royalty_Set.
	SELF.royalty_type := if(pInput.subj_phone_type_new = MDR.sourceTools.src_Metronet_Gateway,
												 Royalty.Constants.RoyaltyType.METRONET, 
												 #if(extendLayout)
													''
												 #else
													if(pInput.royalty_type<>'', pInput.royalty_type, '')
												 #end),
  self := pInput;
end;

outfile := if(callMetronet, project(infile, into_out(left)), project(infile, rec_with_royal_layout));

return outfile;

endmacro;
