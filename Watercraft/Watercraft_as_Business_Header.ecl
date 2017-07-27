import Business_Header, Business_Header_SS, Ut, MDR;

dWatercraftSearch	:=	Watercraft.File_Base_Search_Prod;

Business_Header.Layout_Business_Header tWatercraftAsBusinessHeader(dWatercraftSearch pInput)
 :=
  transform
	self.source 					:=	'AW';	// Watercraft is 'AW' everywhere else...
	self.dppa						:=	pInput.state_origin in Watercraft.sDPPA_Restricted_Watercraft_States;
	self.dt_first_seen 				:=	if((unsigned)pInput.date_first_seen < 300000, (unsigned)pInput.date_first_seen * 100, (unsigned)pInput.date_first_seen);
	self.dt_last_seen 				:=	if((unsigned)pInput.date_last_seen < 300000, (unsigned)pInput.date_last_seen * 100, (unsigned)pInput.date_last_seen);
	self.dt_vendor_last_reported	:=	if((unsigned)pInput.date_vendor_last_reported < 300000, (unsigned)pInput.date_vendor_last_reported * 100, (unsigned)pInput.date_vendor_last_reported);
	self.dt_vendor_first_reported	:=	if((unsigned)pInput.date_vendor_first_reported < 300000, (unsigned)pInput.date_vendor_first_reported * 100, (unsigned)pInput.date_vendor_first_reported);
	self.vendor_id					:=	pInput.state_origin + trim(pInput.watercraft_key,left,right) + trim(pInput.sequence_key,left,right);
	self.prim_range					:=	pInput.prim_range;
	self.predir						:=	pInput.predir;
	self.prim_name					:=	pInput.prim_name;
	self.addr_suffix				:=	pInput.suffix;
	self.postdir					:=	pInput.postdir;
	self.unit_desig					:=	pInput.unit_desig;
	self.sec_range					:=	pInput.sec_range;
	self.city						:=	pInput.p_city_name;
	self.state						:=	pInput.st;
	self.zip						:=	(unsigned)pInput.zip5;
	self.zip4						:=	(unsigned)pInput.zip4;
	self.county						:=	pInput.county;
	self.msa						:=	pInput.msa;
	self.geo_lat					:=	pInput.geo_lat;
	self.geo_long					:=	pInput.geo_long;
	self.current					:=	(pInput.History_Flag = '');
	self.phone						:=	(unsigned)pInput.phone_1;
	self.company_name				:=	pInput.company_name;
	self.bdid						:=	(typeof(self.bdid))pInput.bdid;
  end
 ;

dWatercraftCompanyOnly		:=	dWatercraftSearch(company_name != '');
dWatercraftAsBusHdr			:=	project(dWatercraftCompanyOnly,tWatercraftAsBusinessHeader(left));
dWatercraftAsBusHdrDedup	:=	dedup(dWatercraftAsBusHdr,company_name,vendor_id,prim_name,prim_range,all);  // we don't really have to dedup as the RIDing technology does that

ut.MAC_Sequence_Records(dWatercraftAsBusHdrDedup, group1_id, dWatercraftPrepAsBusHdrSeq)

////////////////////////////////////////////////////////////////////////


Watercraft_clean_rollup := Business_Header.As_Business_Header_Function(dWatercraftPrepAsBusHdrSeq);



export Watercraft_as_Business_Header	
 :=	Watercraft_clean_rollup
 :	persist('persist::BusHdr_watercraft_as_bus_hdr')
 ;
