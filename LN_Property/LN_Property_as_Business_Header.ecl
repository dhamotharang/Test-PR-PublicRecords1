import Business_Header,ut,Business_HeaderV2;

Business_Header.Layout_Business_Header	tPropertyPrepToBusHdr(LN_Property.LN_Property_as_Business_Prep pInput)
 :=
  transform
	self	:=	pInput;
  end
 ;

dPropertyPrepCompanyOnly	:=	LN_Property.LN_Property_as_Business_Prep(company_name != '');
dPropertyPrepAsBusHdr		:=	project(dPropertyPrepCompanyOnly,tPropertyPrepToBusHdr(left));

ut.MAC_Sequence_Records(dPropertyPrepAsBusHdr, group1_id, dPropertyPrepAsBusHdrSeq)

////////////////////////////////////////////////////////////////////////
Property_clean_rollup := Business_Header.As_Business_Header_Function(dPropertyPrepAsBusHdrSeq);



export LN_Property_as_Business_Header
 :=	Property_clean_rollup
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::LN_Property::LN_Property_as_Business_Header')
	;