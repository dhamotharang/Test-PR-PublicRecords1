import business_header, header, ut,paw,corp2,mdr;

laycorp := corp2.Layout_Corporate_Direct_Corp_Base;

export BWR_Create_HRI_Addr_Sic_FCRA(

	 boolean																pUseDatasets		= false
	,string																	pPersistUnique	= 'fcra.hri::'
	,dataset(laycorp											)	pInactiveCorps 	= paw.fCorpInactives()
	,string																	pBhVersion			= 'qa'
	,dataset(layouts.layout_HRI_Businesses)	pHri_Businesses	= HRI_Businesses(true,pUseDatasets,pPersistUnique := pPersistUnique,pInactiveCorps := pInactiveCorps,pBhVersion := pBhVersion)
	,string																	pPersistname		= persistnames().BWRCreateHRIAddrSicFCRA

) := 
function

//*** The new Correctional Facilities records are filtered out from this FCRA key as per JIRA# DF-20295
f_sic_addr_out := pHri_Businesses(~mdr.sourceTools.sourceIsCorrectional_Facilities(source));

f_sic_addr_valid := f_sic_addr_out(prim_name<>'');

f_sic_addr_dist := distribute(f_sic_addr_valid,hash(prim_range,predir,prim_name,
	                                               addr_suffix,postdir,unit_desig,
                                                    sec_range,city,state,zip,zip4,sic_code));
	 
f_sic_addr_sort := sort(f_sic_addr_dist,prim_range,predir,prim_name,
	                                   addr_suffix,postdir,unit_desig,
                                        sec_range,city,state,zip,zip4,sic_code,local);

f_sic_addr_sort roll_date(f_sic_addr_sort le, f_sic_addr_sort ri) :=
TRANSFORM
	SELF.dt_first_seen := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
	SELF := le;
END;

f_sic_addr_dedup := rollup(f_sic_addr_sort,roll_date(LEFT,RIGHT),prim_range,predir,prim_name,
	                                     addr_suffix,postdir,unit_desig,
                                          sec_range,city,state,zip,zip4,sic_code,local) ;

out_addr_rec := Layout_HRI_Address_Sic;

out_addr_rec slim_addr(f_sic_addr_dedup l) := transform
     self.addr_type := '2240';
	self.zip := intformat(l.zip,5,1);
	self.zip4 := intformat(l.zip4,4,1);
	self.source := l.source;
	self := l;
end;

f_addr_slim := project(f_sic_addr_dedup, slim_addr(left)): persist(pPersistname);

return f_addr_slim;

end;