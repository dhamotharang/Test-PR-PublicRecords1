import business_header,dea,mdr;

export fDEA_As_Business_Header(

	dataset(DEA.layout_dea_out_basev2) pDEA = DEA.File_DEAv2

)
 :=
  function

	inf := pDEA;
	outrec := Business_Header.Layout_Business_Header_New;

	outrec tra(inf l) := transform
	  SELF.rcid := 0;
	  SELF.bdid := (integer)L.bdid;
	  SELF.source := MDR.sourceTools.src_Dea;
	  SELF.source_group := l.dea_registration_number;
	  SELF.pflag := ''; 
	  SELF.group1_id := 0;
		SELF.vl_id := l.dea_registration_number;
	  SELF.vendor_id := l.dea_registration_number;
	  SELF.dt_first_seen := (unsigned4)l.date_first_reported;
	  SELF.dt_last_seen := (unsigned4)l.date_last_reported;
	  SELF.dt_vendor_first_reported := (unsigned4)l.date_first_reported;
	  SELF.dt_vendor_last_reported := (unsigned4)l.date_last_reported;
	  SELF.company_name := L.cname;
	  SELF.prim_range := L.prim_range;
	  SELF.predir := L.predir;
	  SELF.prim_name := L.prim_name;
	  SELF.addr_suffix := L.addr_suffix;
	  SELF.postdir := L.postdir;
	  SELF.unit_desig := L.unit_desig;
	  SELF.sec_range := L.sec_range;
	  SELF.city := l.v_city_name;
	  SELF.state := l.st;
	  SELF.zip := (INTEGER)L.zip;
	  SELF.zip4 := (INTEGER)L.zip4;
	  SELF.county := L.county[3..5];
	  SELF.msa := L.msa;
	  SELF.geo_lat := L.geo_lat;
	  SELF.geo_long := L.geo_long;
	  SELF.phone := 0;
	  SELF.phone_score := 0;
	  SELF.fein := 0;
	  SELF.current := TRUE;
	end;

	outf := project(inf(cname <> ''), tra(left));

	return outf;
	
  end
 ;
