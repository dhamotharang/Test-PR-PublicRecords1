import Statistics, versioncontrol, address, corp2, paw;
export fCoreBusinesses(

	 string																						pversion
	,dataset(Layout_Business_Header_Base) 						pBh										= files().base.business_headers.built
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps				= PAW.fCorpInactives()
	
) := 
function

	lay_bh_address :=
	record
		Layout_Business_Header_Base;
		string200 address;
	end;
	
	InactiveCorpsBdids := project(pInactiveCorps, transform({unsigned6 bdid}, self := left));
	
	Bh := project(pbh, transform(lay_bh_address, self := left;
					self.address := trim(stringlib.stringtolowercase(
													Address.Addr1FromComponents(left.prim_range, left.predir, left.prim_name,
											 left.addr_suffix, left.postdir, left.unit_desig, left.sec_range) 
					+ ' ' + Address.Addr2FromComponents(left.city, left.state, intformat(left.zip,5,1))))));

	find_one_record_bdids	:= table(Bh, {bdid, unsigned8 cnt := count(group)}, bdid)(cnt = 1);
	one_record_bdids			:= join( Bh										
																,find_one_record_bdids
																,left.bdid = right.bdid
																,transform(lay_bh_address, self := left)
														);

	one_year_ago := (unsigned4)((string)((unsigned)pversion[1..4] - 1) + pversion[5..]);
	find_old_bdids	:= table(Bh, {bdid, unsigned4 dt_last_seen := max(group, dt_last_seen)}, bdid)(dt_last_seen < one_year_ago);
														
	multiple_record_bdids		:= join( 
																 Bh										
																,find_one_record_bdids
																,left.bdid = right.bdid
																,transform(lay_bh_address, self := left)
																,left only
														);
	active_businesses := join(multiple_record_bdids
													,InactiveCorpsBdids
													,left.bdid = right.bdid
													,transform(lay_bh_address, self := left)
													,left only
											);
				
	good_businesses := join( sort(distribute(active_businesses, bdid), bdid, local)
													,sort(distribute(find_old_bdids, bdid), bdid, local)
													,left.bdid = right.bdid
													,transform(lay_bh_address, self := left)
													,left only
													,local
											);
											
	return good_businesses;
	
end;