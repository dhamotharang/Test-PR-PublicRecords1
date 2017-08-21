import AutoKeyB2,standard; 

export Proc_Build_bid_Autokey(string filedate) :=
FUNCTION
 
layout_payload forAutokey(fcc.Layout_FCC_base_bid L, integer cnt) := transform
 self.bdid := choose(cnt,l.licensee_bid,l.dba_bid,l.firm_bid);
 self.did := choose(cnt,l.attention_did,l.attention_did,0);
 self.company := choose(cnt,l.clean_licensees_name,l.clean_dba_name,l.clean_firm_name);
 self.name.name_first := choose(cnt,l.attention_fname,l.attention_fname,'');
 self.name.name_middle := choose(cnt,l.attention_mname,l.attention_mname,'');
 self.name.name_last := choose(cnt,l.attention_lname,l.attention_lname,'');
 self.name.name_suffix := choose(cnt,l.attention_name_suffix,l.attention_name_suffix,'');
 self.addr.prim_range := choose(cnt,l.prim_range,l.prim_range,l.firm.prim_range);
 self.addr.predir := choose(cnt,l.predir,l.predir,l.firm.predir);
 self.addr.prim_name := choose(cnt,l.prim_name,l.prim_name,l.firm.prim_name);
 self.addr.addr_suffix := choose(cnt,l.addr_suffix,l.addr_suffix,l.firm.addr_suffix);
 self.addr.postdir := choose(cnt,l.postdir,l.postdir,l.firm.postdir);
 self.addr.unit_desig := choose(cnt,l.unit_desig,l.unit_desig,l.firm.unit_desig);
 self.addr.sec_range := choose(cnt,l.sec_range,l.sec_range,l.firm.sec_range);
 self.addr.p_city_name := choose(cnt,l.p_city_name,l.p_city_name,l.firm.p_city_name);
 self.addr.v_city_name := choose(cnt,l.v_city_name,l.v_city_name,l.firm.v_city_name);
 self.addr.st := choose(cnt,l.st,l.st,l.firm.st);
 self.addr.zip5 := choose(cnt,l.zip5,l.zip5,l.firm.zip5);
 self.addr.zip4 := choose(cnt,l.zip4,l.zip4,l.firm.zip4);
 self.addr.fips_state := choose(cnt,l.fips_state,l.fips_state,l.firm.fips_state);
 self.addr.fips_county := choose(cnt,l.fips_county,l.fips_county,l.firm.fips_county);
 self.addr.addr_rec_type := choose(cnt,l.addr_rec_type,l.addr_rec_type,l.firm.addr_rec_type);
 self.phone.phone10 := stringlib.stringfilter(choose(cnt,l.licensees_phone,l.licensees_phone,l.contact_firms_phone_number),'0123456789');
 self := l;
 end;

search_file := normalize(FCC.File_FCC_base_bid,3,forAutokey(left,counter));

AutoKeyB2.MAC_Build (search_file,
					name.name_first,name.name_middle,name.name_last,
					zero,
					zero,
					phone.phone10,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					DID,
					company,
					zero,
					phone.phone10,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					bdid,
					Constant(filedate).ak_bid_keyname,
					Constant(filedate).ak_bid_logical,
					outaction,
					false, //diffing
					Constant('').ak_skip_set,true,Constant('').ak_typeStr, //skip, use fake ids, typestr
					true,,,zero) //useOnlyRecordIDs

AutoKeyB2.MAC_AcceptSK_to_QA(Constant(filedate).ak_bid_keyname, mymove,false,fcc.Constant('').ak_skip_set)

retval := sequential(outaction,mymove);
 
return retval;
end;