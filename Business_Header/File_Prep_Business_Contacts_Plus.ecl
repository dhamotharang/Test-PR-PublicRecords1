import header_services,mdr,ut;

/////////////////////////////////////////////////////////////////////////
in_hdr := File_Prep_BC_CleanAddr_KeyBuild;

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 Layout_Business_Contact_Plus;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(Layout_Business_Contact_Plus l) := transform                            
 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(in_hdr, tHashDIDAddress(left));

Layout_Business_Contact_Plus_orig tSuppress(dHeader_withMD5 l) := transform
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

rFullOut_HashBDID tHashBDID(Business_Header.Layout_Business_Contact_Plus_orig l) := transform                            
 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1));
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
 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), intformat((unsigned6)l.did,15,1));
 self := l;
end;

dContactHeader_withMD5 := project(contact_all_full_out_suppress, tHashBDIDDID(left));

Business_Header.Layout_Business_Contact_Plus_orig tContactSuppress(dContactHeader_withMD5 l) := transform
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

BCbytitle_withHash addBCHash(Business_Header.Layout_Business_Contact_Plus_Orig l) := transform                            
 self.hval := hashmd5(intformat((unsigned6)l.bdid,12,1), (string35)l.company_title, (string20)l.lname, (string20)l.fname);
 self := l;
end;

BC_withTitleHash := project(contact_full_out_suppress, addBCHash(left));

Business_Header.Layout_Business_Contact_Plus_orig removeHash(BC_withTitleHash l) := transform
 self := l;
end;


contact_full_w_title_suppress := JOIN(	BC_withTitleHash,
																				dBCbytitle_SuppressedIn,
																				left.hval = right.hval,
																				removeHash(left),
																				left only,
																				lookup);																										
				

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
string15 bdid := '0';       
string15 did := '0';       
string3 contact_score := '0';
string34 vendor_id := ''; 
string10 dt_first_seen;
string10 dt_last_seen;
string2   source;
string1   record_type;
string1   from_hdr := 'N';
string1   glb := '0';
string1	  dppa := '0';
string35 company_title;
string35 company_department := '';
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string1   name_score;
string10 prim_range;
string2   predir;
string28 prim_name;
string4  addr_suffix;
string2   postdir;
string5  unit_desig;
string8  sec_range;
string25 city;
string2   state;
string8 zip;
string5 zip4;
string3   county;
string4   msa;
string10 geo_lat;
string11 geo_long;
string15 phone;
string60 email_address;
string10 ssn := '0';
  string34 company_source_group := '';
  string120 company_name;
  string10 company_prim_range;
  string2   company_predir;
  string28 company_prim_name := '';
  string4  company_addr_suffix := '';
  string2   company_postdir := '';
  string5  company_unit_desig := '';
  string8  company_sec_range := '';
  string25 company_city := '';
  string2   company_state := '';
  string8 company_zip := '';
  string5 company_zip4 := '';
  string15 company_phone := '';
  string10 company_fein := '0';
  string2 eor := '\r\n';
end;

header_services.Supplemental_Data.mac_verify('file_business_contact_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();
max_file_pos := max(in_hdr,__filepos) : global;

Layout_Business_Contact_Plus_orig reformat_header(Base_File_Append_In L, integer c) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
	self.did := (unsigned6) L.did;
	self.bdid := (unsigned6) L.bdid;
	self.dt_first_seen := (unsigned4) L.dt_first_seen;
	self.dt_last_seen := (unsigned4) L.dt_last_seen;
	self.contact_score := (unsigned1) L.contact_score;
	self.glb := (boolean) if(l.glb = '1', true, false);
	self.dppa := (boolean) if(l.dppa = '1', true,  false);
	self.zip := (unsigned3) L.zip;
	self.zip4 := (unsigned2) L.zip4;
	self.phone := (unsigned6) L.phone;
	self.ssn := (unsigned4) L.ssn;
	self.company_zip := (unsigned3) L.company_zip;
	self.company_zip4 := (unsigned2) L.company_zip4;
	self.company_phone := (unsigned6) L.company_phone;
	self.company_fein := (unsigned4) L.company_fein;
	self.__filepos := max_file_pos + c;
    self := L;
 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left, counter)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

dall := contact_full_w_title_suppress + Base_File_Append;
		
dreturndataset := dall;

export File_Prep_Business_Contacts_Plus := dreturndataset;