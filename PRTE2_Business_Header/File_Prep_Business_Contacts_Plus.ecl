import business_header, header_services, mdr, ut;

/////////////////////////////////////////////////////////////////////////
in_hdr := File_Prep_BC_CleanAddr_KeyBuild;

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 business_header.Layout_Business_Contact_Plus;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(business_header.Layout_Business_Contact_Plus l) := transform                            
 self.hval := hashmd5(intformat(l.bdid,15,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

business_header.Layout_Business_Contact_Plus tSuppress(dHeader_withMD5 l) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,
													dSuppressedIn,
                          left.hval = right.hval,
													tSuppress(left),
													left only,
													lookup);

//**********************************************
//*   BDID Only
//**********************************************

header_services.Supplemental_Data.mac_verify('businesscontactsall_sup.txt', Suppression_Layout, contacts_all_supp_ds_func);
 
Contacts_All_Suppression_In := contacts_all_supp_ds_func();

dContactsAllSuppressedIn := project(Contacts_All_Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashBDID := header_services.Supplemental_Data.layout_out;

rFullOut_HashBDID := record
 Business_Header.Layout_Business_Contact_Plus;
 rHashBDID;
end;

rFullOut_HashBDID tHashBDID(Business_Header.Layout_Business_Contact_Plus l) := transform                             
 self.hval := hashmd5(intformat((unsigned6)l.bdid,15,1));
 self := l;
end;

dContactAllHeader_withMD5 := project(full_out_suppress, tHashBDID(left));

Business_Header.Layout_Business_Contact_Plus tContactAllSuppress(dContactAllHeader_withMD5 l) := transform
 self := l;
end;

contact_all_full_out_suppress := JOIN(dContactAllHeader_withMD5,
																			dContactsAllSuppressedIn,
																			left.hval = right.hval,
																			tContactAllSuppress(left),
																			left only,
																			lookup);
																			


//**********************************************
//*   BDID + DID
//**********************************************

header_services.Supplemental_Data.mac_verify('businesscontacts_sup.txt', Suppression_Layout, contact_supp_ds_func);
 
Contact_Suppression_In := contact_supp_ds_func();

dContactSuppressedIn := project(Contact_Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashBDIDDID := header_services.Supplemental_Data.layout_out;

rFullOut_HashBDIDDID := record
 Business_Header.Layout_Business_Contact_Plus;
 rHashBDIDDID;
end;

rFullOut_HashBDIDDID tHashBDIDDID(Business_Header.Layout_Business_Contact_Plus l) := transform                            
 self.hval := hashmd5(intformat((unsigned6)l.bdid,15,1), intformat((unsigned6)l.did,15,1));
 self := l;
end;

dContactHeader_withMD5 := project(contact_all_full_out_suppress, tHashBDIDDID(left));

Business_Header.Layout_Business_Contact_Plus tContactSuppress(dContactHeader_withMD5 l) := transform
 self := l;
end;

contact_full_out_suppress := join(	dContactHeader_withMD5,
																		dContactSuppressedIn,
																		left.hval = right.hval,
																		tContactSuppress(left),
																		left only,
																		lookup );
				
				
//**********************************************
//* Company_Title 
//**********************************************
header_services.Supplemental_Data.mac_verify(	'businesscontactsbytitle_sup.txt',
																							Suppression_Layout,BCbytitle_ds_func	);
 
BCbytitle_Suppression_In := BCbytitle_ds_func();

dBCbytitle_SuppressedIn := PROJECT(	BCbytitle_Suppression_In, 
																		header_services.Supplemental_Data.in_to_out(left));

rHashVal := header_services.Supplemental_Data.layout_out;

BCbytitle_withHash := RECORD
	Business_Header.Layout_Business_Contact_Plus;
	rHashVal;
end;

BCbytitle_withHash addBCHash(Business_Header.Layout_Business_Contact_Plus l) := transform                               
 self.hval := hashmd5(intformat((unsigned6)l.bdid,15,1), (string35)l.company_title, (string20)l.lname, (string20)l.fname);
 self := l;
end;

BC_withTitleHash := project(contact_full_out_suppress, addBCHash(left));

Business_Header.Layout_Business_Contact_Plus removeHash(BC_withTitleHash l) := transform
 self := l;
end;


contact_full_w_title_suppress := JOIN(	BC_withTitleHash,
																				dBCbytitle_SuppressedIn,
																				left.hval = right.hval,
																				removeHash(left),
																				left only,
																				lookup);																										
				
dreturndataset := contact_full_w_title_suppress;

export File_Prep_Business_Contacts_Plus := dreturndataset;