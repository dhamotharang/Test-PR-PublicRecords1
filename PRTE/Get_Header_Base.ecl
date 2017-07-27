IMPORT PRTE_CSV, ut, NID, Doxie, address, STD;

EXPORT Get_Header_Base := MODULE

	// ******************** START: Apply TITLE for relative key ********************************* //
  titlesSet := [2,3,4,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,43,44,45,46];
  SHARED prte_csv.ge_header_base.layout_payload assignRelativeTitles(prte_csv.ge_header_base.layout_payload L, prte_csv.ge_header_base.layout_payload R, integer c) := TRANSFORM
  
      SELF.rtitle := titlesSet[((R.person1+R.person2) % 22)+1];
      SELF        := R;
  
  END;
  // ******************** END: Apply TITLE for relative key ********************************* //
  // ******************** START: Lookups                     ********************************* //
  SHARED lookups := 	  doxie.lookup_setter(2,			'SEX') |
							doxie.lookup_setter(3, 		'CRIM') |
							doxie.lookup_setter(4, 			'CCW') |
							doxie.lookup_setter(3, 			'VEH') |
							doxie.lookup_setter(4, 			'DL') |
							doxie.lookup_setter(3, 		'REL') |
							doxie.lookup_setter(3, 		'FIRE') |
							doxie.lookup_setter(3, 		'FAA') |
							doxie.lookup_setter(3, 		'VESS') |
							doxie.lookup_setter(3, 		'PROF') |
							doxie.lookup_setter(3, 		'BUS') | 
							doxie.lookup_setter(3, 		'PROP') | 
							doxie.lookup_setter(3, 		'BK') |
							doxie.lookup_setter(3, 		'PAW') | 
							doxie.lookup_setter(3, 		'BC') | 
							doxie.lookup_setter(3, 	'PROP_ASSES') | 
							doxie.lookup_setter(3, 	'PROP_DEEDS') | 
							doxie.lookup_setter(3, 	'PROV') | 
							doxie.lookup_setter(3, 	'SANC') | ut.bit_set(0,0);
  // ******************** END: Lookups                    ********************************* //
  // ******************** STAT: addToZip                  ********************************* //

  SHARED addToZipCode :=
                        '                       self.prim_range := clean_address[1..10];                            \r\n'+
                        '                       self.predir := clean_address[11..12];                               \r\n'+
                        '                       self.prim_name := clean_address[13..40];                            \r\n'+
                        '                       self.addr_suffix := clean_address[41..44];                          \r\n'+
                        '                       self.postdir := clean_address[45..46];                              \r\n'+
                        '                       self.unit_desig := clean_address[47..56];                           \r\n'+
                        '                       self.sec_range := clean_address[57..64];                            \r\n'+
                        '                       self.city_name := clean_address[65..89];                            \r\n'+
                        '                       self.p_city_name := clean_address[65..89];                          \r\n'+
                        '                       self.v_city_name := clean_address[90..114];                         \r\n'+
                        '                       self.st := clean_address[115..116];                                 \r\n';
                        
  SHARED mac_addToZip := MACRO #expand(addToZipCode); ENDMACRO;
  
  // ******************** END  : addToZip                  ********************************* //
  // ******************** START: zipTossnDlname            ********************************* //
  
  SHARED zipTossnDlnameCode := 
  
                        '              self.zip4 := clean_address[122..125];                      \r\n'+
                        '              self.cart := clean_address[126..129];                      \r\n'+
                        '              self.cr_sort_sz := clean_address[130];                     \r\n'+
                        '              self.lot := clean_address[131..134];                       \r\n'+
                        '              self.lot_order := clean_address[135];                      \r\n'+
                        '              self.dbpc := clean_address[136..137];                      \r\n'+
                        '              self.chk_digit := clean_address[138];                      \r\n'+
                        '              self.rec_type := clean_address[139..140];                  \r\n'+
                        '              self.county := clean_address[143..145];                    \r\n'+
                        '              self.geo_lat := clean_address[146..155];                   \r\n'+
                        '              self.geo_long := clean_address[156..166];                  \r\n'+
                        '              self.msa := clean_address[167..170];                       \r\n'+
                        '              self.geo_blk := clean_address[171..177];                   \r\n'+
                        '              self.geo_match := clean_address[178];                      \r\n'+
                        '              self.err_stat := clean_address[179..182];                  \r\n'+
                        '              self.src := \'EQ\';                                        \r\n'+
                        '              self.ssn4 := ((string)l.ssn)[6..9];                        \r\n'+
                        '              self.ssn5 := ((string)l.ssn)[1..5];                        \r\n'+
                        '              self.s1 := ((string)l.ssn)[1..1];                          \r\n'+
                        '              self.s2 := ((string)l.ssn)[2..2];                          \r\n'+
                        '              self.s3 := ((string)l.ssn)[3..3];                          \r\n'+
                        '              self.s4 := ((string)l.ssn)[4..4];                          \r\n'+
                        '              self.s5 := ((string)l.ssn)[5..5];                          \r\n'+
                        '              self.s6 := ((string)l.ssn)[6..6];                          \r\n'+
                        '              self.s7 := ((string)l.ssn)[7..7];                          \r\n'+
                        '              self.s8 := ((string)l.ssn)[8..8];                          \r\n'+
                        '              self.s9 := ((string)l.ssn)[9..9];                          \r\n'+
                        '              self.dph_lname := metaphonelib.DMetaPhone1(l.lname);       \r\n';

  SHARED mac_zipTossnDlname :=  MACRO #expand(zipTossnDlnameCode); ENDMACRO;

  // ******************** END  : zipTossnDlname            ********************************* //
  // ******************** START  : generateRelativePairs            ********************************* //
  
  SHARED   generateRelativePairs(dataset(prte_csv.ge_header_base.layout_payload) ds) := 
  
      join(ds,ds
				,left.prim_range = right.prim_range
				and left.did <> right.did
				,TRANSFORM({ds}
					,self.person1:=left.did
					,self.person2:=right.did
					,self:=left)
				,left outer
				);
  
  // ******************** END  : generateRelativePairs            ********************************* //
  
	ds := prte_csv.ge_header_base.dheader_file_on_lz;
	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);
		string month := intformat((integer)ut.words(l.dob,1,1,'/'),2,1);
		string day := intformat((integer)ut.words(l.dob,2,2,'/'),2,1);
		string year := ut.words(l.dob,3,3,'/');
		self.dob := (integer4)(year + month + day);
		
    mac_addToZip();

		self.zip := '59981';
    
		mac_zipTossnDlname();
    
		self.city_code := doxie.Make_CityCode(l.city);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.yob := (unsigned2)year;
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.mname:=stringlib.StringToUpperCase(l.mname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.minit := l.mname[1];
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := if(l.dt_first_seen>0,l.dt_first_seen,198001);
		self.dt_last_seen := if(l.dt_last_seen>0,l.dt_last_seen,201201);
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := project( ds,proj_recs(left));

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		self.did := if (l.did = 0,prte_csv.ge_header_base.GE_INIT_DID, l.did + 1);
		self.s_did := if (l.did = 0,prte_csv.ge_header_base.GE_INIT_DID, l.did + 1);
		self.hhid := if (l.did = 0,prte_csv.ge_header_base.GE_INIT_DID, l.did + 1);
		self.rid := if (l.did = 0,prte_csv.ge_header_base.GE_INIT_DID, l.did + 1);
		self.uid := if (l.did = 0,prte_csv.ge_header_base.GE_INIT_DID, l.did + 1);
		self := r;
	END;
	
	retds := iterate(before_itr,itr_hdr(left,right));
	retds2:= iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT GE := retds2;

 
	ds := prte_csv.ge_header_base.dExcelon_file_on_lz;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);

		mac_addToZip();

		self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(l.city);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.yob := (integer)l.dob[1..4];
		self.dob := (integer)l.dob;
		self.dt_first_seen := (unsigned)l.dt_first_seen;
		self.dt_last_seen := (unsigned)l.dt_last_seen;
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.mname:=stringlib.StringToUpperCase(l.mname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.minit := stringlib.StringToUpperCase(l.mname[1]);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.number_cohabits := 8;
		self.recent_cohabit := self.dt_first_seen;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := sort(project( ds,proj_recs(left)),fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.Excelon_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	retds1:= generateRelativePairs(retds0);
	retds := dedup(retds1,all);
	retds2:= iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT Excelon := retds2;

	ds := prte_csv.ge_header_base.file_rbs_prct;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);
		
		mac_addToZip();

		// self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.dob := (integer)l.dob;
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198001;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := sort(project( ds,proj_recs(left)),fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.RBS_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);  
  
	retds:=dedup(retds1,all);
	retds2:=iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT RBS := retds2;

	ds := prte_csv.ge_header_base.file_amex_prct;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);
		
		mac_addToZip();

		// self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.dob := (integer)l.dob;
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198001;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := sort(project( ds,proj_recs(left)),fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.AMEX_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);
  
	retds:=dedup(retds1,all);
	retds2:=iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT AMEX := retds2;

	ds := prte_csv.ge_header_base.file_captone_prct;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);

		mac_addToZip();

		// self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.dob := (integer)l.dob;
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198001;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := sort(project( ds,proj_recs(left)),fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.captone_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);        
  
	retds:=dedup(retds1,all);
	retds2:=iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT captone := retds2;

	ds := prte_csv.ge_header_base.file_citi_prct;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);

		mac_addToZip();

		// self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.dob := (integer)l.dob;
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198001;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr := sort(project( ds,proj_recs(left)),fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.citi_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);
        
	retds:=dedup(retds1,all);
  retds2:=iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT citi := retds2;


	ds := prte_csv.ge_header_base.dSantander_file_on_lz;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l,integer c) := TRANSFORM
		
		string clean_address := address.CleanAddress182(trim(Stringlib.stringcleanspaces(l.addr1 + if(l.addr2='*','',l.addr2))),l.st + ' ' + l.zip);
		
		mac_addToZip();

		self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		ph:=intformat((integer)choose(c,l.hphone,l.cphone,''),10,1);
		self.phone := map((integer)ph=0 and c=1 => ''
											,(integer)ph=0 and c=2 => 'nocellph'
											,(string)(integer)ph);
		self.cellphone := (integer)ph>0 and c=2;
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198001;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr0 := dedup(normalize( ds,2,proj_recs(left,counter)))(phone<>'nocellph');
	before_itr := sort( before_itr0,fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.Santander_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);
  
	retds:=dedup(retds1,all);
  retds2:= iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT Santander := retds2;


	ds := prte_csv.ge_header_base.dTest_seed_file_on_lz;

	prte_csv.ge_header_base.layout_payload proj_recs(ds l,integer c) := TRANSFORM
		
		string clean_address := address.CleanAddress182(l.addr,l.city + ' ' + l.st + ' ' + l.zip);
		
		mac_addToZip();

		self.zip := '59981';
		    
		mac_zipTossnDlname();

		self.city_code := doxie.Make_CityCode(l.city);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.yob := (integer)l.dob[1..4];
		self.dob := (integer)l.dob;
		self.dt_first_seen := (unsigned)l.dt_first_seen;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		ph:=intformat((integer)l.phone,10,1);
		self.phone := if((integer)ph=0,'',(string)(integer)ph);
		self.p3 := if((integer)ph[1..3]=0,'',ph[1..3]);
		self.p7 := if((integer)ph[4..]=0,'',ph[4..]);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.mname:=stringlib.StringToUpperCase(l.mname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.minit := stringlib.StringToUpperCase(l.mname[1]);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.number_cohabits := 8;
		self.recent_cohabit := self.dt_first_seen;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;

		self := l;
		self := [];
	END;

	before_itr0 := dedup(normalize( ds,2,proj_recs(left,counter)))(phone<>'nocellph');
	before_itr := sort( before_itr0,fname,lname);

	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.test_seed_INIT_DID;
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self.number_cohabits := 8;
		self.recent_cohabit := 201001;
		self.same_lname := true;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	
	retds1:= generateRelativePairs(retds0);
  
	retds:=dedup(retds1,all);
  retds2:= iterate(retds,assignRelativeTitles(LEFT,RIGHT,COUNTER));
	EXPORT test_seed := retds2;


// ***************************************************************	
//* Add header subjects from new Customer Test Foreclosure / LNProperty keys:
// ***************************************************************	
/**************************************************************************************************************
	EXPORT AlpharettaBaseName	:= '~prte::persist::custtest::PeopleHeader_LNPForeclosure_DID';
	EXPORT LNP_Forclosure_Common_Header_Layout := RECORD
			STRING  Tmp_Source := '';
			STRING  lname := '';
			STRING  fname := '';
			STRING  mname := '';
			STRING  SSN := '';
			STRING  dob := '';
			STRING  address := '';
			STRING  apt := '';
			STRING  city := '';
			STRING  st := '';
			STRING  zip := '';
	END;
	
  ds1 := prte_csv.ge_header_base.Foreclosure_file_on_lz;
  ds2 := prte_csv.ge_header_base.LNProperty_file_on_lz;
	LNP_Forclosure_Common_Header_Layout PROJECT_FORCLOSURE_HDRS(DS1 L) := TRANSFORM
		SELF.Tmp_Source := 'F';		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		SELF := L;
	END;
	LNP_Forclosure_Common_Header_Layout PROJECT_LNPROPERTY_HDRS(DS2 L) := TRANSFORM
		SELF.Tmp_Source := 'L';		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		SELF := L;
	END;
	ds1a := PROJECT(ds1,PROJECT_FORCLOSURE_HDRS(LEFT) );
	ds2a := PROJECT(ds2,PROJECT_LNPROPERTY_HDRS(LEFT) );
	dsus := ds1a + ds2a;
	ds := SORT(dsus, lname,fname,-Tmp_Source) : PERSIST('~prte::persist::custtest::PeopleHeader_Common_FORCL_LNP');
	
	prte_csv.ge_header_base.layout_payload proj_recs(ds l,integer c) := TRANSFORM
		string clean_address := address.CleanAddress182(l.address, l.city + ' ' + l.st + ' ' + l.zip);
	  self.prim_range := clean_address[1..10];
		self.predir := clean_address[11..12];
		self.prim_name := clean_address[13..40];
		self.suffix      := clean_address[41..44];
		self.addr_suffix := clean_address[41..44];
		self.postdir := clean_address[45..46];
		self.unit_desig := clean_address[47..56];
		self.sec_range := l.apt;
		// or this could come from clean_address[57..64];
		self.city_name := clean_address[65..89];
		self.p_city_name := clean_address[65..89];
		self.v_city_name := clean_address[90..114];
		self.st := clean_address[115..116];
		self.zip := clean_address[117..121]; 
		self.zip4 := clean_address[122..125];
		self.cart := clean_address[126..129];
		self.cr_sort_sz := clean_address[130];
		self.lot := clean_address[131..134];
		self.lot_order := clean_address[135];
		self.dbpc := clean_address[136..137];
		self.chk_digit := clean_address[138];
		self.rec_type := clean_address[139..140];
		self.county := clean_address[143..145];
		self.geo_lat := clean_address[146..155];
		self.geo_long := clean_address[156..166];
		self.msa := clean_address[167..170];
		self.geo_blk := clean_address[171..177];
		self.geo_match := clean_address[178];
		self.err_stat := clean_address[179..182];
		self.src := 'EQ';
		self.ssn4 := ((string)l.ssn)[6..9];
		self.ssn5 := ((string)l.ssn)[1..5];
		self.s1 := ((string)l.ssn)[1..1];
		self.s2 := ((string)l.ssn)[2..2];
		self.s3 := ((string)l.ssn)[3..3];
		self.s4 := ((string)l.ssn)[4..4];
		self.s5 := ((string)l.ssn)[5..5];
		self.s6 := ((string)l.ssn)[6..6];
		self.s7 := ((string)l.ssn)[7..7];
		self.s8 := ((string)l.ssn)[8..8];
		self.s9 := ((string)l.ssn)[9..9];
		self.dph_lname := metaphonelib.DMetaPhone1(l.lname);
		self.city_code := doxie.Make_CityCode(self.v_city_name);
		self.pfname := NID.PreferredFirstVersionedStr(l.fname,2);
		self.fname:=stringlib.StringToUpperCase(l.fname);
		self.lname:=stringlib.StringToUpperCase(l.lname);
		self.l4 := stringlib.StringToUpperCase(l.lname[1..4]);
		self.f3 := stringlib.StringToUpperCase(l.fname[1..3]);
		self.dt_first_seen := 198801;
		self.dt_last_seen := (unsigned)((string)Std.Date.Today())[1..6];
		self.addr_dt_first_seen := self.dt_first_seen;
		self.addr_dt_last_seen := self.dt_last_seen;
		self.number_cohabits := 8;
		self.recent_cohabit := 198001;
		self.same_lname := true;
		self.lookup_did := lookups;
		self.lookups     := lookups;
		self.s_ssn     := l.ssn;
		self.cnt     := 2;
		self.dob     := (integer) l.dob;
		self.yob     := (unsigned2) l.dob[1..4];
		self := l;
		self := [];
	END;
	
	before_itr0 := project( ds,proj_recs(left, counter));
	before_itr  := sort(before_itr0,fname,lname); // : PERSIST('~prte::persist::custtest::PeopleHeader_LNProperty_PRELIM');

	// TRANSFORM TO ASSIGN DID VALUES TO THE FIELDS	
	prte_csv.ge_header_base.layout_payload itr_hdr(before_itr l,before_itr r) := TRANSFORM
		init := prte_csv.ge_header_base.Foreclosure_INIT_DID;
		// init := prte_csv.ge_header_base.LNProperty_INIT_DID;		// IN CASE WE CARE TO LATER OFFSET DID DIFFERENTLY
		new_id := l.fname<>r.fname or l.lname<>r.lname;
		rid := map( l.did=0 => init, l.rid + 1 );
		did := map( l.did=0 => rid, ~new_id => l.did, rid );
		self.did := did;
		self.s_did := did;
		self.hhid := did;
		self.rid := rid;
		self.uid := rid;
		self := r;
	END;
	
	retds0 := iterate(before_itr,itr_hdr(left,right));
	SHARED retds1 := dedup(retds0, RECORD, all); 

	// NOTE: Danny designed this to make everyone related to everyone.
	// However, it looks like he actually made relationships only if streetNums are equal.
	//TODO - will this cause any issues with alpharetta test cases?
	// For alpharetta here, I'm thinking about adding street name = street name - RESEARCH WHAT TO DO
	// Long term I think we might need to bring in from spreadsheet for alpha data.
	SHARED retds := join(retds1,retds1
				,left.prim_range = right.prim_range
				// AND left.prim_name = right.prim_name
				// AND left.zip+left.zip4 = right.zip+right.zip4
				AND left.did <> right.did
				,TRANSFORM({retds1}
					,self.person1:=left.did
					,self.person2:=right.did
					,self:=left)
				,left outer
				);
					
	// retdsjunk := SORT(retds1, did) : PERSIST('~prte::persist::custtest::PeopleHeader_LNProperty_Dedup_Sort');

	//TODO - check out all of this to see what is happening under the covers with what came from the spreadsheet.
	EXPORT LNPForeclosureDIDPersistData := retds  : PERSIST(AlpharettaBaseName);
	// NOTE: then can I bring in the spreadsheet DIDs?  Also might want to bring in relationships.
	// If we can, then only new spreadsheet items without the existing DID need to have a new DID assigned.

*****************************************************************************************************************/

// *************************************************************************************	
// TEMPORARY - Provide access for the Foreclosure and LNProperty until those are re-written.
	EXPORT LNPForeclosureDIDPersistData := PRTE_CSV.ge_header_base.AlphaFinalHeaderDS;
// *************************************************************************************	

// *************************************************************************************	
//* Final Definition now with all of these concatenated together plus get_Payload.header
// *************************************************************************************	
/* 	
EXPORT Boca_Only := 
   										citi
   									+ captone
   									+ AMEX
   									+ RBS
   									+ GE
   									+ Excelon
   									+ Santander
   									+ test_seed
   									+ PRTE.Get_payload.header	//NO!  This is no longer just Boca data
   									;
*/

	EXPORT payload :=
									citi
								+ captone
								+ AMEX
								+ RBS
								+ GE
								+ Excelon
								+ Santander
								+	test_seed
								+ iterate(PRTE.Get_payload.header,assignRelativeTitles(LEFT,RIGHT,COUNTER));		// Feb 2015, this now includes Boca and Alpharetta main base data.
								;
END;