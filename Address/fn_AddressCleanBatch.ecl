import ut;

export fn_AddressCleanBatch(dataset(address.Layout_Batch_In) in_addrs) := function

//Clean up input strings to match prior behavior of Fetch Address Cache
ca(string s) := stringlib.StringToUpperCase(stringlib.StringCleanSpaces(trim(s, left)));

address.Layout_Batch_Out cleanAddr(address.Layout_Batch_In le) := transform	
	//Check to see if addr2 or parsed info entered
	addr2_set := if(le.addr2 != '', le.addr2, address.addr2FromComponents(le.city_name,le.st,le.zip));

	//Clean input address
	addr1_prepped := ca(le.addr1);
	addr2_prepped := ca(addr2_set);
	pa := Address.CleanAddressParsed(addr1_prepped,addr2_prepped);
	zipSt := ziplib.ZipToState2(pa.zip);

	self.addr1 := addr1_prepped;
	self.addr2 := addr2_prepped;
	
  self.prim_range := pa.prim_range;
  self.predir := pa.predir;
  self.prim_name := pa.prim_name;
  self.addr_suffix := pa.addr_suffix;
  self.postdir := pa.postdir;
  self.unit_desig := pa.unit_desig;
  self.sec_range := pa.sec_range;
  self.p_city_name := pa.p_city_name;
  self.v_city_name := pa.v_city_name;	
  self.st := if(pa.st ='',zipSt,pa.st);
  self.zip := pa.zip;
  self.zip4 := pa.zip4;
  self.cart := pa.cart;
  self.cr_sort_sz := pa.cr_sort_sz;
  self.lot := pa.lot;
  self.lot_order := pa.lot_order;
  self.dbpc := pa.dbpc;
  self.chk_digit := pa.chk_digit;
  self.rec_type := pa.rec_type;
  self.county := pa.fips_state + pa.fips_county;    // mimic prior behavior
  self.geo_lat := pa.geo_lat;
  self.geo_long := pa.geo_long;
  self.msa := pa.msa;
  self.geo_blk := pa.geo_blk;
  self.geo_match := pa.geo_match;
  self.err_stat := pa.err_stat;
  self.clean_appends := if (pa.st = '' and zipSt <> '',ut.bit_set(0,6),0);
	self := le;
end;

final_out := project(in_addrs, cleanAddr(LEFT));

return final_out;
end;