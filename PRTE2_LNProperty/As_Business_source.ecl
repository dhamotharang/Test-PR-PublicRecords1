import header,ln_property,ln_mortgage,ut,business_header,business_headerv2,mdr;

export as_Business_source(
	 dataset(Layouts.Layout_DID_Out	 ) pLNPropertySearch  
	,dataset(Layouts.layout_deed_mortgage_common_model_base) pLNPropertyDeed		
	,dataset(Layouts.layout_property_common_model_base ) pLNPropertyTax	
	,dataset(Layouts.layout_addl_fares_deed) pLNPropertyAddlDeed	
	,dataset(Layouts.layout_addl_fares_tax ) pLNPropertyAddlTax		
	) := module
					
shared dLNPropertySearch    	:= pLNPropertySearch  (source_code not in ['SO','OS']);
shared dLNPropertyDeed		:= pLNPropertyDeed;
shared dLNPropertyTax		:= pLNPropertyTax;
shared dLNPropertyAddlDeed	:= pLNPropertyAddlDeed;
shared dLNPropertyAddlTax	:= pLNPropertyAddlTax;
						                 


in_file_tax := project(dLNPropertyTax, transform(LN_Property.Layout_Property_Common_Model_BASE, self := left, self := []));

src_rec_tax := record 
 header.Layout_Source_ID;
 LN_Property.Layout_Property_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1] ='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Fares_Asrs,withUID1)
header.Mac_Set_Header_Source(in_file_tax(ln_fares_id[1]!='R'),LN_Property.Layout_Property_Common_Model_BASE,src_rec_tax,mdr.sourceTools.src_LnPropV2_Lexis_Asrs,withUID2) 

shared merge_tax := withUID1 + withUID2 ; 

export ln_propertyv2_tax_as_business_source := merge_tax;

in_file_deed := project(dLNPropertyDeed, transform(LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE, self := left, self := []));

src_rec_deed := record 
 header.Layout_Source_ID;
 LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE;
end;

header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1] ='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Fares_Deeds			,withUID3)
header.Mac_Set_Header_Source(in_file_deed(ln_fares_id[1]!='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,src_rec_deed,mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,withUID4)
                                                                                                                 
shared merge_deed  := withUID3 + withUID4 ; 

export ln_propertyv2_deed_as_business_source	:= merge_deed;

r1 := record
 unsigned6 uid;
 string12  ln_fares_id;
 string2   src;
 string1   dummy_seg;
end;

r1 t1(ln_propertyv2_deed_as_business_source le) := transform
 self           := le;
end;

r1 t2(ln_propertyv2_tax_as_business_source le) := transform
 self           := le;
end;

p1 := project(ln_propertyv2_deed_as_business_source,t1(left));
p2 := project(ln_propertyv2_tax_as_business_source, t2(left));

concat_dupd      := p1+p2;								

layout_search_ext := record
 dLNPropertySearch;
 string80 old_cname := '';
end;

r2 := record
 boolean is_true;
 concat_dupd.uid;
 concat_dupd.src;
 concat_dupd.dummy_seg;
 layout_search_ext; 
end;

r2 t3(dLNPropertySearch le, concat_dupd ri) := transform
 self.is_true := if(le.ln_fares_id=ri.ln_fares_id and le.source_code[2]='P' and ri.dummy_seg<>'',true,false);
 self         := le;
 self         := ri;
end;

export p3 := join(dLNPropertySearch,concat_dupd,
									 left.ln_fares_id=right.ln_fares_id,
									 t3(left,right)
								 );

end;