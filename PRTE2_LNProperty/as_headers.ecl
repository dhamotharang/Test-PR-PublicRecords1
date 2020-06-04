import header,ln_property,ln_mortgage,ut, mdr,Business_Header,lib_stringlib, LN_PropertyV2;

EXPORT AS_HEADERS := MODULE
shared pLNPropertySearch 	:= Files.file_search_building_did_out;
shared pLNPropertyDeed   	:= Files.ln_propertyv2_deed;	
shared pLNPropertyTax    	:= Files.ln_propertyv2_tax;
shared pLNPropertyAddlTax	:= Files.DS_addlfarestax_fid;
shared pLNPropertyAddlDeed	:= Files.DS_addlfaresdeed_fid;
shared deedScrubs :=  Project(	pLNPropertyDeed , 
																Transform(Layouts.layout_deed_mortgage_common_model_base_scrubs, 
																					self := left, self := []));
shared taxScrubs := Project ( pLNPropertyTax,
																Transform(Layouts.layout_property_common_model_base_scrubs,
																					self := left, self := []));
EXPORT Person_Header  := Function

					
prop_search_filt :=		pLNPropertySearch	(
		did < (unsigned6)ln_property.irs_dummy_cutoff and source_code not in ['SO','OS']
		,fname<>'',lname<>''
		,~regexfind(' ',trim(mname))
		,length(trim(fname))>1
		,fname not in ['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX']
		);
LN_Property.Layout_Property_Common_Model_BASE to_assessors_base(pLNPropertyTax l) := transform
  self := l;
	self := [];
end;
assessor_base := project(pLNPropertyTax, to_assessors_base(left));

header.Mac_Set_Header_Source(assessor_base(ln_fares_id[1] ='R'),LN_Property.Layout_Property_Common_Model_BASE,header.layouts_SeqdSrc.FAT_src_rec,mdr.sourceTools.src_LnPropV2_Fares_Asrs,withUID1,1)
header.Mac_Set_Header_Source(assessor_base(ln_fares_id[1]!='R'),LN_Property.Layout_Property_Common_Model_BASE,header.layouts_SeqdSrc.FAT_src_rec,mdr.sourceTools.src_LnPropV2_Lexis_Asrs,withUID2,1) 

// shared	ln_propertyv2_tax_as_source	:=	withUID1 + withUID2;
ln_propertyv2_tax_as_source	:=	withUID1 + withUID2;

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE to_deeds_base(pLNPropertyDeed l) := transform
	self := l;
	self := [];
end;

deeds_base := project(pLNPropertyDeed, to_deeds_base(left));

header.Mac_Set_Header_Source(deeds_base(ln_fares_id[1] ='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,header.layouts_SeqdSrc.FAD_src_rec,mdr.sourceTools.src_LnPropV2_Fares_Deeds		 ,withUID3,1)
header.Mac_Set_Header_Source(deeds_base(ln_fares_id[1]!='R'),LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE,header.layouts_SeqdSrc.FAD_src_rec,mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs,withUID4,1)

// shared	ln_propertyv2_deed_as_source	:=	withUID3 + withUID4;
ln_propertyv2_deed_as_source	:=	withUID3 + withUID4;

r1	:=	record
	unsigned6 uid;
	string12  ln_fares_id;
	string2   src;
	string1   dummy_seg;
end;

p1	:=	project(ln_propertyv2_deed_as_source,r1);
p2	:=	project(ln_propertyv2_tax_as_source,r1);

concat     	:=	p1+p2;
concat_dupd	:=	dedup     (concat,ln_fares_id,uid,src, all);

search_dist	:=	prop_search_filt;

r2	:=	record
	boolean is_true;
	concat_dupd.uid;
	concat_dupd.src;
	concat_dupd.dummy_seg;
	prop_search_filt; 
end;

r2 t3(prop_search_filt le, concat_dupd ri)	:=	transform
	self.is_true	:=	if(le.ln_fares_id=ri.ln_fares_id and le.source_code[2]='P' and ri.dummy_seg<>'',true,false);
	self        	:=	le;
	self        	:=	ri;
end;

p3	:=	join(	prop_search_filt,concat_dupd,
										left.ln_fares_id=right.ln_fares_id,
										t3(left,right)
									);


p3_filt	:=	p3(~(is_true));

Layouts.r_layout_new_records_strings t4(p3_filt le)	:=	transform
	self.dt_nonglb_last_seen	:=	le.dt_last_seen;
	self.rec_type           	:=	if(le.source_code[1] in ['O','B'], '1', '2');   //buying = 1, selling = 2
	self.vendor_id          	:=	le.ln_fares_id+'FA'+((string)(hash(le.fname,le.lname,le.prim_name)))[1..4];
	self.ssn                	:=	'';
	self.dob                	:=	0;
	self.phone              	:=	le.phone_number;
	self.prim_range         	:=	header.fixPrimRange(le.prim_range);
	self.city_name          	:=	le.v_city_name;
	self.county             	:=	le.county[3..5];
	self.rid                	:=	0;
	self.uid                	:=	le.uid;
	self.src                	:=	le.src;
	self                    	:=	le;
end;

p4	:=	project(p3_filt,t4(left));



Layouts.r_layout_new_records_strings t_rollup(p4 le, p4 ri)	:=	transform
	 self.dt_first_seen           	:=	ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	 self.dt_last_seen            	:=	Max(le.dt_first_seen,ri.dt_first_seen);
	 self.dt_vendor_first_reported	:=	ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	 self.dt_vendor_last_reported 	:=	self.dt_last_seen;
	 self.dt_nonglb_last_seen     	:=	self.dt_last_seen;
	 self                         	:=	le;
end;

p_rollup	:=	rollup(	
					SORT(p4,src,vendor_id,fname ,mname ,lname  ,name_suffix,prim_range,predir ,
						prim_name ,suffix ,postdir ,unit_desig,sec_range ,city_name	,
						st ,zip ,zip4 ,county ,phone,rec_type),
					left.src         = right.src         and 
					left.vendor_id   = right.vendor_id   and
					left.fname       = right.fname       and 
					left.mname       = right.mname       and 
					left.lname       = right.lname       and 
					left.name_suffix = right.name_suffix and
					left.prim_range  = right.prim_range  and 
					left.predir      = right.predir      and
					left.prim_name   = right.prim_name   and
					left.suffix      = right.suffix      and
					left.postdir     = right.postdir     and
					left.unit_desig  = right.unit_desig  and
					left.sec_range   = right.sec_range   and 
					left.city_name   = right.city_name   and
					left.st          = right.st          and
					left.zip         = right.zip         and
					left.zip4        = right.zip4        and
					left.county      = right.county      and
					left.phone       = right.phone       and
					left.rec_type    = right.rec_type,
					t_rollup(left,right)
				);

p_rollup_new_records	:=	project(p_rollup
						,transform(header.Layout_New_Records
						,self:=left));

ln_propertyv2_as_header	:=	p_rollup_new_records
		(
			fname <> '',
			lname <> '', 
			length(trim(fname)) > 1,
			prim_name <> '',
			~(prim_range='' and zip4=''),
			length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')),
			trim(title)<>'SGT',
			trim(lname)<>'SG'
		);

return ln_propertyv2_as_header(did!=0);
End;

export As_Business_Header := function

return LN_Propertyv2.fLN_Propertyv2_as_Business_Header( pLNPropertySearch  
								,deedScrubs	
								,taxScrubs		
								,pLNPropertyAddlDeed
								,pLNPropertyAddlTax,
								true)(bdid!=0);	


end;

EXPORT As_Business_Contact := function
	
return Ln_propertyv2.fLN_Propertyv2_as_Business_Contact( pLNPropertySearch  
								,deedScrubs	
								,taxScrubs		
								,pLNPropertyAddlDeed
								,pLNPropertyAddlTax,
								true)(bdid!=0);	

end;

EXPORT As_Business_Linking := FUNCTION
								
	return LN_PropertyV2.fLN_Propertyv2_as_Business_Linking(
								 pLNPropertySearch  
								,deedScrubs		
								,taxScrubs		
								,pLNPropertyAddlDeed
								,pLNPropertyAddlTax,
								true);	
end;
END;