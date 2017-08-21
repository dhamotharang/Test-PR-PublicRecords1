import demo_data;
import business_header;

file_in:= dataset('~thor::base::demo_data_file_business_contacts_plus_prodcopy', business_header.Layout_Business_Contact_full_new,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
string5 szip;
string4 szip4;
string9 sssn;
string sphone;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self.szip := (string5) l.zip;
self.szip4 := (string4) l.zip4;
self.sssn := (string9) l.ssn;
self.sphone := (string) l.phone;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));

mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
          mod_file_in,      		// data set to be scrambled
          scrambled_file, 	//scrambled output data set attribute
		  true,sphone,
		  false,x_DL_Number ,   // dl_number field name
		  false,x_dob,		// DOB field name
		  true,sssn,	//SSN field name
		  true,did,  		// DID field name
		  true,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,x_clean_name,	// cleanName field name
		  //
		  false,x_bizName, // businessName Field
		  //
		  true,street,
		  true,city,
		  true,state,
		  true,szip,
		  true,szip4,
		  false,dr_clean_address,// cleanAddress fieldname
		  //
		  
		  0, // Number of orig fields to be marked as '**scrambled'	
				    // fields above are automatically replaced so do not need to be 
					// marked. The Fields MUST be STRING TYPES..
		  mark_f1,
		  mark_f2,
		  etc
				);

//****     REFORMAT SOME FIELDS BACK INTO THE ORIGINAL FILE
recordof(file_in) reformat(scrambled_file L):= TRANSFORM
clean_addr := fn.cleanAddress(L.street, L.city+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.zip := (unsigned) l.szip;
self.zip4 := (unsigned) l.szip4;
self.ssn := (unsigned) l.sssn;
self.phone := (unsigned) l.sphone;
self.email_address := if(l.email_address<>'',trim(l.fname[1..1])+trim(l.lname)+'@mycompany.com','');
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_business_contacts_plus := dedup(sort(scrambled1,record),all) : persist('thor::persist::scramble_business_contacts_plus');


/*
  qstring34 company_source_group := ''; // Source group
  qstring120 company_name;
  qstring10 company_prim_range;
  string2   company_predir;
  qstring28 company_prim_name;
  qstring4  company_addr_suffix;
  string2   company_postdir;
  qstring5  company_unit_desig;
  qstring8  company_sec_range;
  qstring25 company_city;
  string2   company_state;
  unsigned3 company_zip;
  unsigned2 company_zip4;
  unsigned6 company_phone;
  unsigned4 company_fein := 0;
*/