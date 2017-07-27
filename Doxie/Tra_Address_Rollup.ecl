IMPORT doxie, FFD;

pickNonEmpty(string l, string r) := if ( l = '', r, l );

export doxie.Layout_Comp_Addresses Tra_Address_Rollup(doxie.Layout_Comp_Addresses le, doxie.Layout_Comp_Addresses ri) := transform
  self.dt_first_seen := if(ri.dt_first_seen = 0 or (le.dt_first_seen < ri.dt_first_seen and le.dt_first_seen>0),le.dt_first_seen,ri.dt_first_seen);
  self.dt_last_seen := if(le.dt_last_seen > ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen );
  self.sec_range 	:= if ( length(trim(le.sec_range)) > length(trim(ri.sec_range)), le.sec_range, ri.sec_range );
  self.geo_blk 		:= pickNonEmpty( le.geo_blk, 		ri.geo_blk );
  self.county 		:= pickNonEmpty( le.county, 		ri.county );
	self.tnt := if(doxie.tnt_score(ri.tnt) > 0 and doxie.tnt_score(ri.tnt) < doxie.tnt_score(le.tnt), ri.tnt, le.tnt);
	self.dt_vendor_first_reported := if(ri.dt_vendor_first_reported = 0 or (le.dt_vendor_first_reported < ri.dt_vendor_first_reported and le.dt_vendor_first_reported>0),le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
  self.dt_vendor_last_reported := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported, le.dt_vendor_last_reported, ri.dt_vendor_last_reported );
  self.phone := if (le.phone = '', ri.phone, le.phone);
  self.listed_phone := if (le.listed_phone = '', ri.listed_phone, le.listed_phone);
	boolean pick_ri_statements := le.phone = '' or le.listed_phone = '';
	self.statementids := 
		le.statementids(recordtype in [
			FFD.Constants.RecordType.HS, 
			FFD.Constants.RecordType.HSN, 
			FFD.Constants.RecordType.HSA,
			FFD.Constants.RecordType.HSP
			]) + 
			IF(pick_ri_statements, 
				ri.statementids(recordtype in [
					FFD.Constants.RecordType.HS, 
					FFD.Constants.RecordType.HSP
					]), 
				dataset([], FFD.Layouts.StatementIdRec)
				);
  self.isdisputed := le.isdisputed or (pick_ri_statements and ri.isdisputed);  
  self := le;
  end;
