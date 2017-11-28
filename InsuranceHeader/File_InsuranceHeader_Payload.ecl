IMPORT HEADER , InsuranceHeader_xLink, mdr , idl_header ;
 
Key := idl_header.files.DS_IDL_POLICY_HEADER_BASE(src[1..3]='ADL');//InsuranceHeader_xLink.file_insuranceheader(src[1..3]='ADL') ; //PULL(InsuranceHeader_xLink.Process_xIDL_Layouts().key); 
  
hr  := DISTRIBUTE(header.file_header_raw(header.Blocked_data()),HASH(rid));											

/*EXPORT File_InsuranceHeader_Payload := JOIN(hr,DISTRIBUTE(Key,HASH(source_rid))
                                  ,LEFT.rid = RIGHT.source_rid AND 
                                   LEFT.src = RIGHT.src[4..5]
                                  ,TRANSFORM(header.layout_header,
                                   SELF.did := RIGHT.did;
                                   SELF.jflag2 := RIGHT.ambiguous;		
                                   SELF.src := RIGHT.src[4..5];
                                   SELF.vendor_id := RIGHT.vendor_id;
                                   SELF.phone := RIGHT.phone;
                                   SELF.ssn := RIGHT.ssn;
                                   SELF.dob := RIGHT.dob;
                                   SELF.title := RIGHT.title;
                                   SELF.fname := RIGHT.fname;
                                   SELF.mname := RIGHT.mname;
                                   SELF.lname := RIGHT.lname;
                                   SELF.name_suffix:= RIGHT.sname; 
// get from raw header as Alpha doesnt have county , cbsa , geo_blk 
                                   SELF.rid := LEFT.rid;
                                   SELF.prim_range  := LEFT.prim_range; 
                                   SELF.predir      := LEFT.predir; 
                                   SELF.prim_name   := LEFT.prim_name; 
                                   SELF.suffix      := LEFT.suffix; 
                                   SELF.postdir     := LEFT.postdir; 
                                   SELF.unit_desig  := LEFT.unit_desig; 
                                   SELF.sec_range   := LEFT.sec_range; 
                                   SELF.city_name   := LEFT.city_name; 
                                   SELF.st          := LEFT.st; 
                                   SELF.zip         := LEFT.zip; 
                                   SELF.zip4        := LEFT.zip4; 
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
                                   SELF.persistent_record_ID := 0 ),local) :persist('test::ak::header_full_base');

*/EXPORT File_InsuranceHeader_Payload :=DATASET('~thor400_44::test::ak::header_full_base__p1490819976_fixrids',header.layout_header,FLAT);
																	 
