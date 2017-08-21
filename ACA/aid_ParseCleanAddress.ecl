export aid_ParseCleanAddress(infile,outlayout,outfile) := macro
////////////////////////////////////////////////////////////////////////////////////////
// Macro: Parse Appended Clean Address
////////////////////////////////////////////////////////////////////////////////////////
#uniquename(rPreProcess)
#uniquename(tCleancontactAddressAppended)
#uniquename(dCleancontactAddressAppended)
#uniquename(tCleancontactAddressAppended)

outlayout %tCleancontactAddressAppended%(infile pInput) := transform
	self.rawaid		 				:= pInput.AIDWork_RawAID;
	self.prim_range 				:= pInput.AIDWork_ACECache.prim_range;
	self.predir 					:= pInput.AIDWork_ACECache.predir;
	self.prim_name 					:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix 				:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig 				:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range 					:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name 				:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name 				:= pInput.AIDWork_ACECache.v_city_name;
	self.st 						:= pInput.AIDWork_ACECache.st;
	self.z5 						:= pInput.AIDWork_ACECache.zip5;
	self.zip4 						:= pInput.AIDWork_ACECache.zip4;

self := pInput;
end;

outfile:= project(infile,%tCleancontactAddressAppended%(left));
endmacro;