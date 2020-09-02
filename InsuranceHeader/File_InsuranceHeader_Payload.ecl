﻿IMPORT HEADER , InsuranceHeader_xLink, mdr , idl_header ;
 
Alphabase := idl_header.files.DS_IDL_POLICY_HEADER_BASE(src[1..3]='ADL');
  
hr  := DISTRIBUTE(header.file_header_raw(header.Blocked_data()),HASH(rid));											

EXPORT File_InsuranceHeader_Payload := JOIN(hr,DISTRIBUTE(Alphabase,HASH(source_rid))
                                  ,LEFT.rid = RIGHT.source_rid AND 
                                   LEFT.src = RIGHT.src[4..5]
                                  ,TRANSFORM(header.layout_header,
                                   SELF.did := RIGHT.did;
                                   SELF.jflag2 := RIGHT.ambiguous;		
                                   SELF.src := RIGHT.src[4..5];
                                   SELF.vendor_id := RIGHT.vendor_id;
                                   SELF.phone := if(LEFT.src = 'WP', '', RIGHT.phone);
                                   SELF.ssn := RIGHT.ssn;
                                   SELF.dob := RIGHT.dob;
                                   SELF.title := RIGHT.title;
                                   SELF.fname := RIGHT.fname;
                                   SELF.mname := RIGHT.mname;
                                   SELF.lname := RIGHT.lname;
                                   SELF.name_suffix:= RIGHT.sname; 
                                   SELF.rid := RIGHT.rid;
                                   SELF.prim_range  := RIGHT.prim_range; 
                                   SELF.predir      := RIGHT.predir; 
                                   SELF.prim_name   := RIGHT.prim_name; 
                                   SELF.suffix      := RIGHT.ADDR_SUFFIX; 
                                   SELF.postdir     := RIGHT.postdir; 
                                   SELF.unit_desig  := RIGHT.unit_desig; 
                                   SELF.sec_range   := RIGHT.sec_range; 
                                   SELF.city_name   := RIGHT.city; 
                                   SELF.st          := RIGHT.st; 
                                   SELF.zip         := RIGHT.zip; 
                                   SELF.zip4        := RIGHT.zip4; 
// missing address fields get from raw header as Alpha doesnt have county , cbsa , geo_blk 
                                   SELF.county      := LEFT.county; 
                                   SELF.geo_blk     := LEFT.geo_blk; 
                                   SELF.cbsa        := LEFT.cbsa; 
                                   
                                   SELF.dt_nonglb_last_seen := LEFT.dt_nonglb_last_seen; 
																	                  SELF.dt_first_seen := LEFT.dt_first_seen;
                                   SELF.dt_last_seen  := LEFT.dt_last_seen;
                                   SELF.dt_vendor_last_reported  := LEFT.dt_vendor_last_reported;
                                   SELF.dt_vendor_first_reported := LEFT.dt_vendor_first_reported;

                                   SELF.tnt        := LEFT.tnt; 
                                   SELF.valid_SSN  := LEFT.valid_SSN; 
                                   SELF.rec_type   := LEFT.rec_type; 
                                   SELF.jflag1     := LEFT.jflag1; 
                                   SELF.jflag3     := LEFT.jflag3; 
                                   SELF.pflag1     := LEFT.pflag1; 	
                                   SELF.pflag2     := LEFT.pflag2; 		
                                   SELF.pflag3     := LEFT.pflag3; 
                                   SELF.RawAID     := LEFT.RawAID; 
                                   SELF.Dodgy_tracking:= LEFT.Dodgy_tracking; 
																	 // blank all these seems not used any more and let it calculate as needed 
                                   SELF.NID:=0; 
                                   SELF.address_ind:=0;  
                                   SELF.name_ind:=0;  
                                   SELF.persistent_record_ID := 0 ),LOCAL) :PERSIST('persist::header::insurancepayload'); 

				