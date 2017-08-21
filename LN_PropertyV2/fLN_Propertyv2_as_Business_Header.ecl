import Business_Header_SS, Business_Header,Business_HeaderV2, ut;

export fLN_Propertyv2_as_Business_Header(

	 dataset(Layout_DID_Out													                  ) pLNPropertySearch  		= File_Search_DID			
	,dataset(Layouts.layout_deed_mortgage_common_model_base_scrubs	  ) pLNPropertyDeed		    = Files.Base.DeedMortgage
	,dataset(Layouts.layout_property_common_model_base_scrubs			    ) pLNPropertyTax			  = Files.Base.Assessment	
	,dataset(layout_addl_fares_deed									                  ) pLNPropertyAddlDeed   = File_addl_fares_deed	
	,dataset(layout_addl_fares_tax									                   ) pLNPropertyAddlTax	  = File_addl_Fares_tax	
	,Boolean IsPRCT = false
) :=
function

	// Per Jill, the fips_code filter to throw out "crap records"  :-)
	// Omitting "bad pairs" of name/address.  Namely, "OS" and "SO" (owner name, seller address and vice versa)
	LN_Propertyv2_as_Business_Preparation := 
									ln_propertyv2_as_Business_Prep(
										 pLNPropertySearch  
										,pLNPropertyDeed		
										,pLNPropertyTax			
										,pLNPropertyAddlDeed
										,pLNPropertyAddlTax	
										,
										,IsPRCT
									);

	Business_Header.Layout_Business_Header_New	tPropertyPrepToBusHdr(layout_business_prep pInput)
	 :=
		transform
		self	:=	pInput;
		end
	 ;

	dPropertyPrepCompanyOnly	:=	LN_Propertyv2_as_Business_Preparation(company_name != '');
	dPropertyPrepAsBusHdr		:=	project(dPropertyPrepCompanyOnly,tPropertyPrepToBusHdr(left));

	ut.MAC_Sequence_Records(dPropertyPrepAsBusHdr, group1_id, dPropertyPrepAsBusHdrSeq)

	////////////////////////////////////////////////////////////////////////
	Property_clean_rollup := Business_Header.As_Business_Header_Function(dPropertyPrepAsBusHdrSeq);

	return Property_clean_rollup;

end;