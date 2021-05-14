IMPORT  PromoteSupers, ut, NID, Address, STD,PRTE2, AID, MDR;

EXPORT Proc_Build_Contact(String filedate) := FUNCTION

PRTE2.CleanFields(files.contact_combine,ContactCln);

//Address Cleaner
contact_addr_cleaned := PRTE2.AddressCleaner(ContactCln,  
																					['CONTACT_ADDR'],
																					['dummy1'],
																					['CONTACT_CITY'],
																					['CONTACT_STATE'],
																					['CONTACT_ZIP'],
																					['contact_address'],
																					['contact_address_rawaid']
																					);
																					
                                          

Layouts.Combined_Contact_Base_ext xformContact(contact_addr_cleaned L) := TRANSFORM
		string73 tempname 		 					 := if(trim(L.Contact_name_format) = 'P',Address.CleanPersonFML73(L.contact_name),'');
		pname 							 	 					 := Address.CleanNameFields(tempName);
		self.title						 					 := pname.title;
		self.fname 						 					 := pname.fname;        
		self.mname 						 					 := pname.mname;
		self.lname 						 					 := pname.lname;		  
		self.name_suffix 			 					 := pname.name_suffix;
		self.name_score			   					 := pname.name_score;
		self.contact_name_format				 := L.contact_name_format;

//Clean Contact Address
		self.prim_range 		:= L.contact_address.prim_range;
		self.predir     		:= L.contact_address.predir;
		self.prim_name			:= L.contact_address.prim_name;
		self.addr_suffix		:= L.contact_address.addr_suffix;
		self.postdir				:= L.contact_address.postdir;
		self.unit_desig			:= L.contact_address.unit_desig;
		self.sec_range			:= L.contact_address.sec_range;
		self.v_city_name		:= L.contact_address.v_city_name;
		self.st							:= L.contact_address.st;
		self.zip5           := L.contact_address.zip;
		self.zip4						:= L.contact_address.zip4;
		self.addr_rec_type	:= L.contact_address.rec_type;
		self.fips_state			:= L.contact_address.fips_state;
		self.fips_county		:= L.contact_address.fips_county;	
		self.geo_lat				:= L.contact_address.geo_lat;
		self.geo_long				:= L.contact_address.geo_long;
		SELF.geo_blk				:= L.contact_address.geo_blk;
		self.geo_match			:= L.contact_address.geo_match;
		self.err_stat				:= L.contact_address.err_stat;
	  self.RawAID 				:= L.contact_address_rawaid;
		self.Prep_Addr_Line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.contact_addr),'','','','','',''); 
		self.Prep_Addr_Line_Last := Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.contact_city),
																																 ut.CleanSpacesAndUpper(L.contact_State),
																																 TRIM((string)L.contact_ZIP,left,right));
		
		self.Did				:=	if(L.did > 0, L.did, Prte2.fn_AppendFakeID.did(pname.fname, pname.lname, l.link_ssn, L.link_dob, l.cust_name));		

//Assuming contact address is business address		
		self.bdid      	:= if(trim(L.Contact_name_format) = 'P',0, prte2.fn_AppendFakeID.bdid(L.link_bus_name, L.contact_address.prim_range,  L.contact_address.prim_name,  
																																													L.contact_address.v_city_name,  L.contact_address.st,  L.contact_address.zip,  
																																													L.cust_name)
																																													);

		self.seq_no						:= L.seq_no;
		self.contact_zip			:= (unsigned)L.contact_zip;
		self.withdrawal_date	:= (unsigned)L.withdrawal_date;
		self := L;
		SELF := [];
	END;
		
		
df_contact	:= PROJECT(contact_addr_cleaned, xformContact(left));

///////////////////////////////////////////////////////////////////////////////////////
// Apply Global_SIDs
///////////////////////////////////////////////////////////////////////////////////////

//Apply Global_SID - TMSID[1..3]
addGlobalSID 		:= MDR.macGetGlobalSid(df_contact, 'Fbn2', 'tmsid[1..3]', 'global_sid'); 

withGSIDs				:= addGlobalSID(global_sid<>0);	//Global_SIDs Populated
remainRec				:= addGlobalSID(global_sid=0);	//No Global_SIDs Populated

//Apply Global_SID - TMSID[1..2]
addGlobalSID2		:= MDR.macGetGlobalSid(remainRec, 'Fbn2', 'tmsid[1..2]', 'global_sid');

//Concat All Results
concatRecs			:= withGSIDs + addGlobalSID2;


PromoteSupers.MAC_SF_BuildProcess(concatRecs,constants.Base_fbnv2_Contact, writefile_contact);

Return writefile_contact;

END;