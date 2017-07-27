import header,ut,mdr;

export Vehicle_as_header(dataset(VehicleV2.Layout_Base_Main) pVehiclemain = dataset([],VehicleV2.Layout_Base_Main),
                         dataset(VehicleV2.Layout_Base_party) pVehicleSearch = dataset([],VehicleV2.Layout_Base_party), 
						 boolean pForHeaderBuild=false)
 :=

  function

	dVehiclesAsSource	:=	vehiclev2.Vehicle_as_Source(pVehiclemain,pVehicleSearch,pForHeaderBuild);

	h := record
	
	  header.Layout_New_Records;
	  string1 orig_party_type := '';
	  end;

	h trans(dVehiclesAsSource l) := transform
	  self.did := 0;
	  self.rid := 0;
	  self.dt_first_seen := l.date_first_seen;
	  self.dt_last_seen  := l.date_last_seen;
	  self.dt_vendor_last_reported  := l.date_vendor_last_reported;
	  self.dt_vendor_first_reported := l.date_vendor_first_reported;
	  self.dt_nonglb_last_seen      := l.date_last_seen;
	  self.rec_type                 := IF(l.history='','1','2');
	  self.vendor_id                := l.vehicle_key;
	  self.ssn						:= if ((integer)l.orig_ssn=0,'',l.orig_ssn);
	  self.dob						:= (integer)l.orig_DOB;
	  self.title					:= l.Append_Clean_Name.title;
	  self.fname					:= l.Append_Clean_Name.lname;
	  self.mname					:= l.Append_Clean_Name.mname;
	  self.lname					:= l.Append_Clean_Name.lname;
	  self.name_suffix				:= l.Append_Clean_Name.name_suffix;
	  self.prim_range				:= l.Append_Clean_Address.prim_range;
	  self.predir					:= l.Append_Clean_Address.predir;
	  self.prim_name				:= l.Append_Clean_Address.prim_name;
	  self.suffix					:= l.Append_Clean_Address.addr_suffix;
	  self.postdir					:= l.Append_Clean_Address.postdir;
	  self.unit_desig				:= l.Append_Clean_Address.unit_desig;
	  self.sec_range				:= l.Append_Clean_Address.sec_range;
	  self.city_name				:= l.Append_Clean_Address.v_city_name;
	  self.st						:= l.Append_Clean_Address.st;
	  self.zip					    := l.Append_Clean_Address.zip5;
	  self.zip4					    := l.Append_Clean_Address.zip4;
	  self.county					:= l.Append_Clean_Address.fips_county;
	  self.cbsa					    := l.Append_Clean_Address.cbsa;
	  self.geo_blk				    := l.Append_Clean_Address.geo_blk;
	  self.phone					:= '';
	             
	  self := l;
	  end
	 ;

	from_vr := project(dVehiclesAsSource,trans(left));

	// we don't really have to dedup as the RIDing technology does that
	ded := dedup(from_vr(fname<>'',lname<>'', orig_party_type <> 'B'),fname,ssn,lname,vendor_id,prim_name,prim_range,all,local);

    return ded;
  end
 ;

