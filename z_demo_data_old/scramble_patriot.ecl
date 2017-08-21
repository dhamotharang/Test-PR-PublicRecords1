import demo_data;
import patriot;

layout_did_key:= 
 RECORD
  unsigned integer6 did;
  string10 pty_key;
  string60 source;
  string350 orig_pty_name;
  string350 orig_vessel_name;
  string100 country;
  string10 name_type;
  string50 addr_1;
  string50 addr_2;
  string50 addr_3;
  string50 addr_4;
  string50 addr_5;
  string50 addr_6;
  string50 addr_7;
  string50 addr_8;
  string50 addr_9;
  string50 addr_10;
  string75 remarks_1;
  string75 remarks_2;
  string75 remarks_3;
  string75 remarks_4;
  string75 remarks_5;
  string75 remarks_6;
  string75 remarks_7;
  string75 remarks_8;
  string75 remarks_9;
  string75 remarks_10;
  string75 remarks_11;
  string75 remarks_12;
  string75 remarks_13;
  string75 remarks_14;
  string75 remarks_15;
  string75 remarks_16;
  string75 remarks_17;
  string75 remarks_18;
  string75 remarks_19;
  string75 remarks_20;
  string75 remarks_21;
  string75 remarks_22;
  string75 remarks_23;
  string75 remarks_24;
  string75 remarks_25;
  string75 remarks_26;
  string75 remarks_27;
  string75 remarks_28;
  string75 remarks_29;
  string75 remarks_30;
  string350 cname;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 a_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned integer8 __fpos;
 END;

layout_bdid_key:= 
 RECORD
  unsigned integer6 bdid;
  string10 pty_key;
  string60 source;
  string350 orig_pty_name;
  string350 orig_vessel_name;
  string100 country;
  string10 name_type;
  string50 addr_1;
  string50 addr_2;
  string50 addr_3;
  string50 addr_4;
  string50 addr_5;
  string50 addr_6;
  string50 addr_7;
  string50 addr_8;
  string50 addr_9;
  string50 addr_10;
  string75 remarks_1;
  string75 remarks_2;
  string75 remarks_3;
  string75 remarks_4;
  string75 remarks_5;
  string75 remarks_6;
  string75 remarks_7;
  string75 remarks_8;
  string75 remarks_9;
  string75 remarks_10;
  string75 remarks_11;
  string75 remarks_12;
  string75 remarks_13;
  string75 remarks_14;
  string75 remarks_15;
  string75 remarks_16;
  string75 remarks_17;
  string75 remarks_18;
  string75 remarks_19;
  string75 remarks_20;
  string75 remarks_21;
  string75 remarks_22;
  string75 remarks_23;
  string75 remarks_24;
  string75 remarks_25;
  string75 remarks_26;
  string75 remarks_27;
  string75 remarks_28;
  string75 remarks_29;
  string75 remarks_30;
  string350 cname;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string3 a_score;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 record_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  unsigned integer8 __fpos;
 END;

file1_in := dataset('~thor::base::demo_data_file_patriot_prodcopy',patriot.layout_patriot,flat);
file2_in := dataset('~thor::base::demo_data_file_patriot_did_hits_prodcopy',layout_did_key,flat);
file3_in := dataset('~thor::base::demo_data_file_patriot_bdid_hits_prodcopy',layout_bdid_key,flat);

layout_joined := record
unsigned6 did;
unsigned6 bdid;
recordof(file1_in);
end;
layout_joined to_get_did(file1_in l, file2_in r) := transform
self.did:= r.did;
self.bdid:= 0;
self := l;
end;
ds_join1 := join(file1_in,file2_in,left.pty_key=right.pty_key,to_get_did(left,right),left outer);
layout_joined to_get_bdid(ds_join1 l,file3_in r) := transform
self.bdid := r.bdid;
self :=l;
end;
ds_join2 := join(ds_join1,file3_in,left.pty_key=right.pty_key,to_get_bdid(left,right),left outer);

//
file_in := ds_join2;


mod_file_rec:=RECORD
recordof(file_in);
String100 street;
//String100 mail_street;
END;

mod_file_rec addCleanName(file_in L):= transform
self.street := (string8)L.prim_range+' '+(string30)L.prim_name+' '+(string3)L.addr_suffix;
self:=l;
END;

mod_file_in:=PROJECT(file_in,addCleanName(Left));


mac_scramble_pii_v2( //** THE ORDER OF THE FIELD NAMES IS CRITICAL ***
         mod_file_in,      		// data set to be scrambled
         scrambled_file, 	//scrambled output data set attribute
		  false,xphone,
		  false,xdl_number ,   // dl_number field name
		
		  false,xdobs,				// DOB field name
		  false,xssn, 		//SSN field name
		  true,did,  		// DID field name
		  true,bdid,				// BDID field name
		  true,fname,
		  true,mname,
		  true,lname,
		  false,clean_name,	// cleanName field name
		  //
		  false,param_bizName, // businessName Field
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
patriot.Layout_Patriot reformat(scrambled_file L):= TRANSFORM
scrambled_cname := if(l.cname<>'', demo_data_scrambler.fn_scrambleBizName(l.cname),'');
clean_addr := fn.cleanAddress(L.street, L.v_city_name+' '+L.zip+' '+L.zip4);
self.prim_range := '';	//	clean_addr[1..8];
self.prim_name  := '';	//	TRIM(clean_addr[10..38],LEFT,RIGHT);
self.p_city_name  := '';	//if(l.v_city_name not in['HAPPYPARK','GREENBEACH','BARVALLEY','MALLLAKE'],l.v_city_name,'');
self.v_city_name  := '';	//if(l.v_city_name not in['HAPPYPARK','GREENBEACH','BARVALLEY','MALLLAKE'],l.v_city_name,'');
self.zip := 		'';	//if(l.zip<>'00000', l.zip,'');
self.addr_suffix := '';
self.predir := '';
self.postdir := '';
self.sec_range := '';
self.unit_desig:= '';
self.st := '';
self.orig_pty_name := trim(l.fname)+' '+trim(l.mname)+' '+trim(l.lname);
self.orig_vessel_name := '';
self.addr_1 := '';
self.addr_2 := '';
self.addr_3 := '';
self.addr_4 := '';
self.addr_5 := '';
self.addr_6 := '';
self.addr_7 := '';
self.addr_8 := '';
self.addr_9 := '';
self.addr_10 := '';
self.remarks_1 := if(stringlib.stringcontains(l.remarks_1,'BIRTH',true),'',l.remarks_1);
self.remarks_2 := '';
self.remarks_3 := '';
self.remarks_4 := '';
self.remarks_5 := '';
self.remarks_6 := '';
self.remarks_7 := '';
self.remarks_8 := '';
self.remarks_9 := '';
self.remarks_10 := '';
self.remarks_11 := '';
self.remarks_12 := '';
self.remarks_13 := '';
self.remarks_14 := '';
self.remarks_15 := '';
self.remarks_16 := '';
self.remarks_17 := '';
self.remarks_18 := '';
self.remarks_19 := '';
self.remarks_20 := '';
self.remarks_21 := '';
self.remarks_22 := '';
self.remarks_23 := '';
self.remarks_24 := '';
self.remarks_25 := '';
self.remarks_26 := '';
self.remarks_27 := '';
self.remarks_28 := '';
self.remarks_29 := '';
self.remarks_30 := '';
self.cname := if(scrambled_cname<>'',scrambled_cname,'');
self:=l;
END;

scrambled1 := project(scrambled_file,reformat(left));
export scramble_patriot  :=dedup(sort(scrambled1,record),all);


