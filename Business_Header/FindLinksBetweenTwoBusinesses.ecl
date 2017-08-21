/*pass in name, address of two bdids
find bdid1, bdid2
then from that, get groupid for them
then from that, find relative link chain
then from that, filter so that each bdid1, bdid2 pair is either bdid1, bdid2, or the groupid
Example:
Business_Header.FindLinksBetweenTwoBusinesses(

	 pCname1			:= 'CHASTAIN JOY DR'
	,pCAddress1_1	:= '1500 OGLETHORPE AVE STE 3000'
	,pCAddress1_2	:= 'ATHENS GA 30606-2190'
	,pCname2			:= 'ALDRIDGE HOLLY MD'
	,pCAddress2_1	:= '1500 OGLETHORPE AVE'
	,pCAddress2_2	:= 'ATHENS GA 30606-2179'
);
*/
import address,Business_Risk,Business_Header_SS;
export FindLinksBetweenTwoBusinesses(

	 string pCname1
	,string	pCAddress1_1
	,string pCAddress1_2
	,string pCname2
	,string	pCAddress2_1
	,string pCAddress2_2
	,dataset(Layout_BH_Super_Group			)	pSuperGroup	= Files().base.Super_Group.qa
	
) :=
function

	kbhaddress	:= Business_Risk.Key_Business_Header_Address;//{zip,prim_range,prim_name,sec_range}
	kbhbdidpl		:= Business_Header_SS.Key_BH_BDID_pl				;
	
	//clean two addresses passed in
	cleanaddress1 := Address.CleanAddressParsed(pCAddress1_1,pCAddress1_2);
	cleanaddress2 := Address.CleanAddressParsed(pCAddress2_1,pCAddress2_2);

	//filter business header address key by addresses passed in
	kbhaddress_filtaddr1 := kbhaddress(zip = (unsigned3)cleanaddress1.zip, prim_range = cleanaddress1.prim_range, prim_name = cleanaddress1.prim_name,sec_range = cleanaddress1.sec_range);
	kbhaddress_filtaddr2 := kbhaddress(zip = (unsigned3)cleanaddress2.zip, prim_range = cleanaddress2.prim_range, prim_name = cleanaddress2.prim_name,sec_range = cleanaddress2.sec_range);

	//furthur filter address key by company name
	kbhaddress_filtaddr1_name := kbhaddress_filtaddr1(regexfind(pCname1,company_name,nocase));
	kbhaddress_filtaddr2_name := kbhaddress_filtaddr2(regexfind(pCname2,company_name,nocase));

	//dedup on bdid
	kbhaddress_filtaddr1_name_dedup := dedup(kbhaddress_filtaddr1_name,bdid,hash);
	kbhaddress_filtaddr2_name_dedup := dedup(kbhaddress_filtaddr2_name,bdid,hash);
	
	//filter bdid pl key on bdids found to get all records with those bdids(to account for name variations, extra phones, etc that might 
	//not be in the above records
	kbhbdidpl_filt1	:= kbhbdidpl(bdid in set(kbhaddress_filtaddr1_name_dedup,bdid));
	kbhbdidpl_filt2	:= kbhbdidpl(bdid in set(kbhaddress_filtaddr2_name_dedup,bdid));

	//get groupid 
	dSuperGroup_groupid := pSuperGroup(bdid in [kbhaddress_filtaddr1_name_dedup[1].bdid,kbhaddress_filtaddr2_name_dedup[1].bdid]);
	
	drelativelinkchain := fFindRelativeLink(kbhaddress_filtaddr1_name_dedup[1].bdid,kbhaddress_filtaddr2_name_dedup[1].bdid,dSuperGroup_groupid[1].group_id);

	kbr := Key_Business_Relatives;
	lbdids := [kbhaddress_filtaddr1_name_dedup[1].bdid,kbhaddress_filtaddr2_name_dedup[1].bdid,dSuperGroup_groupid[1].group_id];

	drelativelinkchain_filt := drelativelinkchain(bdid1 in lbdids,bdid2 in lbdids);
	
	kbr_filt := kbr(bdid1 in lbdids,bdid2 in lbdids);

	return
	parallel(
		 output(kbhaddress_filtaddr1_name				,named('kbhaddress_filtaddr1_name'			))
		,output(kbhaddress_filtaddr2_name				,named('kbhaddress_filtaddr2_name'			))
		,output(kbhaddress_filtaddr1_name_dedup	,named('kbhaddress_filtaddr1_name_dedup'))
		,output(kbhaddress_filtaddr2_name_dedup	,named('kbhaddress_filtaddr2_name_dedup'))
		,output(dSuperGroup_groupid							,named('dSuperGroup_groupid'						))
		,output(drelativelinkchain							,named('drelativelinkchain'							))
		,output(drelativelinkchain_filt					,named('drelativelinkchain_filt'				))
		,output(kbr_filt												,named('kbr_filt'												))
		,output(kbhbdidpl_filt1									,named('kbhbdidpl_filt1'								))
		,output(kbhbdidpl_filt2									,named('kbhbdidpl_filt2'								))
	);
	
end;