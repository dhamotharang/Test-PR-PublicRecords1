import dca,standard;

export File_Autokey(

	dataset(Layouts.base.keybuildEntNum)	pFileKeybuild = DCAV2.File_Keybuild()
	

) :=
module

	pBase := project(pFileKeybuild ,transform(Layouts.base.keybuild , self := left));
	
	layouts.base.autokeybuild tranBC(Layouts.base.keybuild  pInput) :=
		TRANSFORM
			SELF.BDID                     := pInput.BDID;
			SELF.company_name             := pInput.Name;
			SELF.company_phone            := pInput.Phone;
			SELF.bus_addr.prim_range      := pInput.prim_range;
			SELF.bus_addr.predir          := pInput.predir;
			SELF.bus_addr.prim_name       := pInput.prim_name;
			SELF.bus_addr.addr_suffix     := pInput.addr_suffix;
			SELF.bus_addr.postdir         := pInput.postdir;
			SELF.bus_addr.unit_desig      := pInput.unit_desig;
			SELF.bus_addr.sec_range       := pInput.sec_range;
			SELF.bus_addr.p_city_name     := pInput.p_city_name;
			SELF.bus_addr.v_city_name     := pInput.v_city_name;
			SELF.bus_addr.st              := pInput.st;
			SELF.bus_addr.zip5            := pInput.z5;
			SELF.bus_addr.zip4            := pInput.zip4;
			SELF.bus_addr.fips_state      := '';
			SELF.bus_addr.fips_county     := pInput.county;
			SELF.bus_addr.addr_rec_type   := '';
			SELF                          := pInput;
		END;

	shared dAutokey := PROJECT(pBase, tranBC(LEFT));

	export Bdid := project(dAutokey	,transform(recordof(left),self.bdid := left.bdid,self := left));

end;