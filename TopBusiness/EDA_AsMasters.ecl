/*2011-08-10T17:37:27Z (george heureux)

*/
import Gong,MDR;

export EDA_AsMasters := module(Interface_AsMasters.Unlinked.Default)

	shared base := Gong.File_History(listing_type_bus != '' or listing_type_gov != '');
	
	export dataset(Layout_Linking.Unlinked) As_Linking_Master := function
	
		filtered := base(listed_name != '');
		
		extract := normalize(filtered,if(left.v_city_name != left.p_city_name,2,1),
			transform(Layout_Linking.Unlinked,
				self.source := MDR.sourceTools.src_Gong_Business,
				self.source_docid := trim(left.bell_id) + '//' + trim(left.filedate) + '//' + trim(left.group_id) + '//' + trim(left.sequence_number),
				self.source_party := 'C' + hash32(left.listed_name),
				self.date_first_seen := (unsigned4)left.filedate[1..8],
				self.date_last_seen := (unsigned4)left.filedate[1..8],
				self.company_name := stringlib.StringToUpperCase(left.listed_name),
				self.company_name_type := Constants.Company_Name_Types.UNKNOWN,
				self.address_type := Constants.Address_Types.UNKNOWN,
				self.phone_type := Constants.Phone_Types.UNKNOWN,
				self.aid := 0,
				self.prim_range := left.prim_range,
				self.predir := left.predir,
				self.prim_name := left.prim_name,
				self.addr_suffix := left.suffix,
				self.postdir := left.postdir,
				self.unit_desig := left.unit_desig,
				self.sec_range := left.sec_range,
				self.city_name := choose(counter,
					left.p_city_name,
					left.v_city_name),
				self.state := left.st,
				self.zip := left.z5,
				self.county_fips := left.county_code[3..5],
				self.msa := left.msa,
				self.phone := left.phone10,
				self.fein := '',
				self.url := '',
				self.duns := '',
				self.experian := '',
				self.zoom := '',
				self.incorp_state := '',
				self.incorp_number := ''));
		
		return extract;
	
	end;

end;
