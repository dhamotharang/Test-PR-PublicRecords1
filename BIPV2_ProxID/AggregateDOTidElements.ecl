import BIPV2_Tools,tools;
EXPORT AggregateDOTidElements(
	 pDataset
	,pShouldFilt	= 'true'
) :=
functionmacro
	dslim := project(pDataset, transform(
	{pDataset.proxid,pDataset.company_name,pDataset.cnp_name,pDataset.cnp_number,pDataset.cnp_btype
	,string address,string contact
,pDataset.source,pDataset.active_duns_number,pDataset.active_enterprise_number,string1 company_foreign_domestic,string active_domestic_corp_key,string fein,pDataset.dotid
},
//		self.corp_key	:= if(left.company_charter_state != '' and left.company_charter_number != ''	,trim(left.company_charter_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');
		self.fein			:= left.company_fein;
		self.address	:= stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
		self.contact	:= trim(left.fname,left,right) + ' ' + trim(left.lname,left,right);
		self					:= left;	
	));
	
	dpost := tools.mac_AggregateFieldsPerID(dslim,dotid,,false,pLimitChildDatasts := 100);
		
	return dpost;
	
endmacro;
