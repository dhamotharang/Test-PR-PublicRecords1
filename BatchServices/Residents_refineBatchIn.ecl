/*

*/


EXPORT Residents_refineBatchIn(dataset(BatchServices.Layouts.Resident.batch_in) batch_in ,
																boolean ExcludeDropIndCheck = false) := function

import address,Advo,BatchServices; 																
																
rec_batch_in := BatchServices.Layouts.Resident.batch_in;
rec_cln_batch_in := BatchServices.Layouts.Resident.cln_batch_in;
		
		rec_cln_batch_in cln_transform(rec_batch_in l) := transform
			addr1 := 	If(l.addr <> '', l.addr,StringLib.StringCleanSpaces(
								l.prim_range + ' ' +
								l.predir + ' ' +
								l.prim_name + ' ' +
								l.addr_suffix + ' ' +
								l.postdir + ' ' +
								l.sec_range
									));
			addr2 := StringLib.StringCleanSpaces(
								l.p_city_name + ' ' +
								l.st + ' ' +
								l.z5 
								);
			clean_addr := address.GetCleanAddress(addr1,addr2,address.Components.country.US).str_addr;
			ca:=Address.CleanFields(clean_addr);
			self.prim_range := ca.prim_range;
			self.predir := ca.predir;
			self.prim_name := ca.prim_name;
			self.addr_suffix := ca.addr_suffix;
			self.postdir := ca.postdir;
			self.unit_desig := ca.unit_desig;
			self.sec_range := ca.sec_range;
			self.p_city_name := ca.p_city_name;
			self.st := ca.st;
			self.z5 := ca.zip;
			self.zip4 := ca.zip4;
			self.drop_ind := '';
			self.rec_type := ca.rec_type;
			self.acctno := l.acctno;
			// do not search for residents where the sec range is missing but required
			self.missing_sec_range := (ca.rec_type = 'H' or ca.rec_type ='HD') and ca.sec_range = '';
		end;
		cln_batch_in := project(batch_in, cln_transform(LEFT));
		drop_batch_in := join(cln_batch_in,Advo.Key_Addr1,   // join to the advo file looking for drop indicator
												keyed(left.z5 != '' and left.z5 = right.zip) and
												keyed(left.prim_range = right.prim_range) and
												keyed(left.prim_name = right.prim_name) and
												keyed(left.addr_suffix = right.addr_suffix) and
												keyed(left.predir = right.predir) and
												keyed(left.postdir = right.postdir) 
												and	(left.sec_range = right.sec_range or left.sec_range = '') 
												and right.drop_indicator = 'Y'
												, transform(rec_cln_batch_in,
																		self.drop_ind := right.drop_indicator,
																		self.missing_sec_range := right.drop_indicator = 'Y' or left.missing_sec_range,
																		self := left),keep(1),left outer);
		final_batch_in := if(ExcludeDropIndCheck,cln_batch_in,drop_batch_in);
		
return(final_batch_in);
end;