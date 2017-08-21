#OPTION('multiplePersistInstances',FALSE);
import business_header,business_header_ss,ut,mdr;

///////////////////////////////////////////////////////////////////////
// -- Base Files Used
///////////////////////////////////////////////////////////////////////
Onvia_Base 	:= onvia.Files.Thesample(company <> '');

///////////////////////////////////////////////////////////////////////
// -- Add Unique ID field to Onvia File
///////////////////////////////////////////////////////////////////////
Layout_Onvia_Local := 
record
	unsigned6 record_id := 0;
	Layouts.TheSample;
end;

Layout_Onvia_Local AddRecordID(Layouts.TheSample L) := 
transform
	self := L;
end;

Onvia_Init := project(Onvia_Base, AddRecordID(left));


///////////////////////////////////////////////////////////////////////
// -- Sequence Onvia File
///////////////////////////////////////////////////////////////////////
ut.MAC_Sequence_Records(Onvia_Init, record_id, Onvia_Seq)


///////////////////////////////////////////////////////////////////////
// -- Convert Onvia File to Business Header format
///////////////////////////////////////////////////////////////////////
business_header.Layout_Business_Header t2busheaderformat(Layout_Onvia_Local pInput)
 :=
  transform
	self.source 					:=	'OV';
	self.group1_id 					:=	pInput.record_id;
	self.dppa						:=	false;
	self.dt_first_seen 				:=	0;
	self.dt_last_seen 				:=	0;
	self.dt_vendor_last_reported  	:=	0;
	self.dt_vendor_first_reported 	:=	0;
	self.vendor_id 					:=	(trim(pInput.zip) + trim(pInput.zip4) + trim(pInput.prim_name) + trim(pInput.Company))[1..34];
	self.source_group 				:=  '';
	self.prim_range 				:=	pInput.prim_range;
	self.predir 					:=	pInput.predir;
	self.prim_name 					:=	pInput.prim_name;
	self.addr_suffix 				:=	pInput.addr_suffix;
	self.postdir 					:=	pInput.postdir;
	self.unit_desig 				:=	pInput.unit_desig;
	self.sec_range 					:=	pInput.sec_range;
	self.city 						:=	pInput.p_city_name;
	self.state 						:=	pInput.st;
	self.zip 						:=	(unsigned3)pInput.zip;
	self.zip4 						:=	(unsigned2)pInput.zip4;
	self.county 					:=	pInput.fips_county;
	self.msa 						:=	pInput.msa;
	self.geo_lat 					:=	pInput.geo_lat;
	self.geo_long 					:=	pInput.geo_long;
	self.current 					:=	true;
	self.phone 						:=	(UNSIGNED6)((UNSIGNED8)stringlib.stringfilter(pInput.phone_number,'01234567889'));
    self.phone_score 				:=  IF(self.phone = 0, 0, 1);
	self.company_name 				:=	pInput.company;
	self.bdid 						:=	0;
  end
 ;

dOnviaAsBusHdr				:=	project(Onvia_Seq,t2busheaderformat(left));

///////////////////////////////////////////////////////////////////////
// -- Pass Both to As Business Header function
///////////////////////////////////////////////////////////////////////
//Onvia_rollup			:= Business_Header.As_Business_Header_Function(dOnviaAsBusHdr, false, false);
Onvia_rollup			:= dOnviaAsBusHdr;


export As_Business_Header
 :=	Onvia_rollup
 :	persist('~thor_data400::persist::onvia::as_business_header');