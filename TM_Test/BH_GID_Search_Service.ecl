/*--SOAP--
<message name="BH_GID_Search_Service">
  <part name="BDID" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service displays best information for the related super group of BDIDs containing the specified BDID.*/
/*--HTML-- xslt.bh */
/*--RESULT-- xslt.bh */

export BH_GID_Search_Service() := macro

string14 bdid_val := '' : stored('BDID');

kb := Business_Header.Key_BH_SuperGroup_BDID((unsigned6)bdid_val <> 0, bdid = (unsigned6)bdid_val);
kg := Business_Header.Key_BH_SuperGroup_GroupID;

Business_Header.Layout_BH_Super_Group FetchBDIDGroup(kb l, kg r) := transform
self := r;
end;

bh_group_fetched := join(kb,
					kg,
				     left.group_id = right.group_id,
				     FetchBDIDGroup(left, right),
					limit(50000));
					
bh_group_enth := enth(bh_group_fetched, 1000);

bh_group_select := if(count(bh_group_fetched) < 1000, bh_group_fetched, bh_group_enth);		

// Get the 'best' information for this group of bdids
bhkb := Business_Header.Key_BH_Best;

Business_Header.Layout_BH_Best SelectBest(bhkb r) := transform
	self := r;
end;

//best_group_info := join(bh_group_fetched,
best_group_info := join(bh_group_select,
                        bhkb,
				    keyed(left.bdid = right.bdid),
				    SelectBest(right));

output(choosen(sort(best_group_info, bdid),1000), named('Group_Best_Company_Information'));

endmacro;