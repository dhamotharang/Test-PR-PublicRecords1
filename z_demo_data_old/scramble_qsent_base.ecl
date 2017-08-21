import demo_data;
import phonesplus;


file_in:= dataset('~thor::base::demo_data_file_qsent_base_prodcopy',phonesplus.layoutCommonOut,flat);

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
//self.mail_street := (string8)L.mail_prim_range+' '+(string30)L.mail_prim_name+' '+(string3)L.mail_addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  true,cellphone,
		  false,dl_number ,   // dl_number field name
		
		  true,dob,		// DOB field name
		  false,ssn, 		//SSN field name
		  true,did,  		// DID field name
		  false,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,company, // businessName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip5,
		  true,zip4,
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip5+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.email	:= '';
self.origname:='orig_not scrambled';
self.address1:= 'orig_not scrambled';
self.address2:='';
self.address3:='';
self.origcity :='';
self.origstate :='';
self.origzip :='';
self.homephone := ''; 	// demo_data_scrambler.fn_scramblePII('phone',l.homephone);
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));

export scramble_qsent_base := dedup(sort(scrambled1(company='' and lname<>'' and fname<>''),record),all);