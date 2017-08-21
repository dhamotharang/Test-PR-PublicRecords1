
import demo_data;
import domains;

file_in := dataset('~thor::base::demo_data_file_whois_base_prodcopy', domains.Layout_Whois_Base, flat);

//null_ds := dataset([], domains.layout_whois_base);
//export scramble_whois_base := null_ds;

// this one requires a manual set of data, it is too complex to scramble, let 10 records thru fields populated.

//Add Fields to conform to Macro Interface Files
mod_file_rec:=RECORD
recordof(file_in);
String100 street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,phone,
		  false,dl_number ,   // dl_number field name
		  false,dob,		// DOB field name
		  false,ssn, 		//SSN field name
		  true,did,  		// DID field name
		  true,bdid,		// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businesName Field
		  //
		  true,street,
		  true,v_city_name,
		  true,st,
		  true,zip,
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
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := clean_addr[1..8];
self.prim_name  := TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := l.v_city_name;
self.domain_name:='Domain name';
self.admin_email:='Admin email';
self.tech_email:= 'Tech email';
//self.prim_range:='prim range';
//self.v_city_name :='v city';
//self.p_city_name :='p city';
self.admin_prim_range:='admin prim range';
self.admin_prim_name:='admin prim name';
self.admin_v_city_name :='admin v city';
self.admin_p_city_name :='admin p city';
self.tech_prim_range:='tech prim range';
self.tech_prim_name:='tech prim name';
self.tech_v_city_name :='tech v city';
self.tech_p_city_name :='tech p city';

self.domain_server1:='domain server1';
self.domain_server2:='domain server2';
self.domain_server3:='domain server3';
self.domain_server4:='';
self.domain_server5:='';
self.domain_server6:='';
self.domain_server7:='';
self.domain_server8:='';

self.registrant_name:='Registrant Name';
self.registrant_address1:='Reg addr1';
self.registrant_address2:='Reg addr2';
self.registrant_address3:='Reg addr3';
self.registrant_address4:='';
self.registrant_address5:='';
self.registrant_address6:='';
self.registrant_address7:='';
self.registrant_address8:='';
self.registrant_address9:='';
self.registrant_address10:='';

self.admin_name:='Admin Name';
self.admin_address1:='Admin addr1';
self.admin_address2:='Admin addr2';
self.admin_address3:='Admin addr3';
self.admin_address4:='';
self.admin_address5:='';
self.admin_address6:='';
self.admin_address7:='';
self.admin_address8:='';
self.admin_address9:='';
self.admin_address10:='';
self.admin_address11:='';
self.admin_address12:='';

self.tech_name:='Tech Name';
self.tech_address1:='Tech addr1';
self.tech_address2:='Tech addr2';
self.tech_address3:='Tech addr3';
self.tech_address4:='';
self.tech_address5:='';
self.tech_address6:='';
self.tech_address7:='';
self.tech_address8:='';
self.tech_address9:='';
self.tech_address10:='';
self.tech_address11:='';
self.tech_address12:='';
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(LEFT));

export scramble_whois_base  := choosen(scrambled1(did<>0),5)+choosen(scrambled1(bdid<>0),5);
