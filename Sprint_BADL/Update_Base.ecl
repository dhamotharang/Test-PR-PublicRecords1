import business_header;

export Update_Base(

	 dataset(layouts.Input																)	pUpdateFile	= files().input.Exist.using
	,dataset(business_header.Layout_Business_Header_Base	)	pBusinessH	= business_header.files().base.business_headers.qa

) :=
function


	//Do three different joins
	//One to find the bdids that still exist(found)
	//One to find the ones that changed(changed)
	//One to find the ones that we can't find(not found)
	
	dBH_Slim := table(pBusinessH, {bdid}, bdid);
	
	// -- FOUND
	dFound := join(
		 distribute(dBH_Slim		,bdid)
		,distribute(pUpdateFile	,(unsigned6)bdid)
		,left.bdid = (unsigned6)right.bdid
		,transform(layouts.temp, self := right;self.rtype := 'F';)
		,local
	);
	
	// -- CHANGED
	dNotFound1 := join(
		 distribute(dBH_Slim		,bdid)
		,distribute(pUpdateFile	,(unsigned6)bdid)
		,left.bdid = (unsigned6)right.bdid
		,transform(layouts.temp, self := right;self.rtype := '';)
		,local
		,right only
	);

	dChanged := join(
		 distribute(pBusinessH	,rcid)
		,distribute(dNotFound1	,(unsigned6)bdid)
		,left.rcid = (unsigned6)right.bdid
		,transform(layouts.temp, self.bdid := intformat(left.bdid,12,1); self.rtype := 'C';self := right;)
		,local
	);
	
	// -- NOT FOUND
	dNotFound2 := join(
		 distribute(pBusinessH	,rcid)
		,distribute(dNotFound1	,(unsigned6)bdid)
		,left.rcid = (unsigned6)right.bdid
		,transform(layouts.temp, self.rtype := 'N';self := right;)
		,local
		,right only
	);


	dall_changes :=  
		dFound 
	+ dChanged
	+ dNotFound2
	;
	

	// -- Find Bad sources
	bh_bad := pBusinessH(city = '',state = '',zip = 0,fein = 0,phone = 0);

	bh_bad_sources := sort(table(bh_bad, {source, unsigned8 cnt := count(group)}, source, few), -cnt);
	bh_bad_sources_unique_bdid := sort(
		table(
			table(bh_bad, {source, bdid}, source, bdid)
		,{source, unsigned8 cnt := count(group)}, source, few), -cnt);

	one_record_bdids := table(pBusinessH, {bdid, unsigned8 cnt := count(group)}, bdid)(cnt = 1);

	bh_bad_one_record_bdids := join(
		 distribute(bh_bad					, bdid)
		,distribute(one_record_bdids, bdid)
		,left.bdid = right.bdid
		,transform({unsigned6 bdid}, self := left)
		,local
	);

	dall_changes_bad 	:= join(bh_bad_one_record_bdids,dall_changes,left.bdid = (unsigned6)right.bdid,transform(recordof(dall_changes),self.rtype := 'N';self := right), local);
																 
	dall_changes_good := join(bh_bad_one_record_bdids,dall_changes,left.bdid = (unsigned6)right.bdid,transform(recordof(dall_changes),self := right), local,right only);

	dExistTable := table(dall_changes_good , {rtype, unsigned4 cnt := count(group)}, rtype, few);
															 
	dExistNotF	:= dedup(dall_changes_good (rtype != 'F') + dall_changes_bad	,bdid,local);
																								 
	dExistNotF_good 	:= join(bh_bad_one_record_bdids,dExistNotF,left.bdid = (unsigned6)right.bdid,transform(recordof(dall_changes),self := right), local,right only);
																									
	dReturn := project(dExistNotF_good ,transform({string	account_number, string	bdid}, self.bdid := if(left.rtype = 'N', '', left.bdid);self := left));

	return dReturn;

end;