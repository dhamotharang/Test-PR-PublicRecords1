import demo_data;
import business_header;
 
file_in:= demo_data_scrambler.scramble_business_contacts_plus;

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
string5 szip;
string4 szip4;
string9 sssn;
string sphone;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.company_prim_range+' '+(string30)L.company_prim_name+' '+(string3)L.company_addr_suffix;
self.szip := (string5) l.company_zip;
self.szip4 := (string4) l.company_zip4;
self.sssn := (string9) l.company_fein;
self.sphone := (string) l.company_phone;
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
		  false,did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,x_clean_name,	// cleanName field name
		  //
		  true,company_Name, // businessName Field
		  //
		  true,street,
		  true,company_city,
		  true,company_state,
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
self.company_prim_range := clean_addr[1..8];
self.company_prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.company_zip := (unsigned) l.szip;
self.company_zip4 := (unsigned) l.szip4;
self.company_fein := (unsigned) l.sssn;
self.company_phone := (unsigned) l.sphone;
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_business_contacts_plus2 := dedup(sort(scrambled1,record),all);
