#stored('did_add_force','thor');
import DID_Add,didville,fair_isaac,header_slimsort,ut,watchdog,census_data,mdr,header;

infile := file_airmen_data_in;

bt_rec := record
  unsigned6 did := 0;
  unsigned2 did_score := 0;
  layout_airmen_data_in;
end;

bt_rec addDID(layout_airmen_data_in L):= transform
 self := l;
end;

infile_did := project(infile,addDID(left));

//add src 
src_rec := record
header_slimsort.Layout_Source;
bt_rec;
end;

DID_Add.Mac_Set_Source_Code(infile_did, src_rec, MDR.sourceTools.src_Airmen, infile_did_src)

matchset := ['A'];//['A','P','D'];  removing phone for now cuz of skew

//DID file
DID_Add.MAC_Match_Flex(infile_did_src,matchset,junk,junk,fname,mname,
	lname,name_suffix,prim_range,prim_name,sec_range,
	zip,st,junk,
	did,src_rec,true,did_score, 
	75,infile_out,true,src)

outrec := layout_airmen_data_out;

outrec forthem(src_rec l) := transform
	self.record_type := map(L.current_flag = 'A' => 'ACTIVE',
													L.current_flag = 'H' => 'HISTORICAL',
													'UNK');						
	self.DID_out := if (l.did = 0,'',intformat(l.did, 12, 1));
	self.d_score := intformat(l.did_score,3,1);
	self.best_ssn := '';
	self.county_name := '';
	self.source			 := MDR.sourceTools.src_Airmen;
	self := l;
end;
	

withdid := project(infile_out, forthem(left));

dw := watchdog.File_Best;

outrec getssn(dw L, withdid R) := transform
	self.best_ssn := if((l.did = 0 or l.ssn = '000000000' or l.ssn = ''),'',intformat((integer)L.ssn,9,1));
	self := R;
end;

ssn_records := join(distribute(dw,hash((integer)did)),distribute(withdid(did_out != ''),hash((integer)did_out)),(integer)left.did = (integer)right.did_out,getssn(LEFT,RIGHT),right outer,local);

ssn_records getCounty(ssn_records L, census_data.File_Fips2County R) := transform
	self.county_name := R.county_name;
	self := L;
end;

county_in := ssn_records + withdid(did_out = '');

final_out := join(county_in, census_data.file_fips2county, left.county = right.county_fips and
				left.st = right.state_code,getCounty(LEFT,RIGHT),left outer, lookup);
				
dedup_final := dedup(final_out, record, all);			
				
export airmen_data_did_ssn := dedup_final;