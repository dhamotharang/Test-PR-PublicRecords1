//output(enth(onvia.As_Business_Header,1000), named('OnviaAsBusinessHeader'), all);
//output(enth(onvia.As_Business_Contact,1000), named('OnviaAsBusinessContact'), all);
import business_header, business_header_SS;

asbh := onvia.As_Business_Header;
asbc := onvia.As_Business_Contact;

bh := business_header.File_Business_Header;
bc := business_header.File_Business_Contacts;

bh_layout := business_header.Layout_Business_Header;
bc_layout := business_header.Layout_Business_Contact_Full;


BDID_Matchset 			:= ['A','P'];

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records Second Pass on address and phone
//////////////////////////////////////////////////////////////////////////////////////////////

Business_Header_SS.MAC_Add_BDID_Flex(asbh,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
                                  sec_range, state,
                                  phone, fein_field,
                                  bdid, bh_layout,
                                  false, BDID_score_field,
                                  as_bh_with_bdid);

as_bh_with_bdid1 := as_bh_with_bdid : persist('persist::onvia::bdided_recs');
output(count(as_bh_with_bdid1), named('TotalOnviaAsBusHeaderRecs'));
output(count(as_bh_with_bdid1(bdid != 0)), named('TotalOnviaAsBusHeaderRecsWithBdid'));
output(count(as_bh_with_bdid1(bdid = 0)), named('TotalOnviaAsBusHeaderRecsWithoutBdid'));
output(enth(as_bh_with_bdid1(bdid != 0), 1000), named('SampleOnviaWithBdidRecs'), all);
output(enth(as_bh_with_bdid1(bdid = 0), 1000), named('SampleOnviaWithoutBdidRecs'), all);




