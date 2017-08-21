import Business_Header, ut, PRTE2;

export BC_Init_Final(

	 dataset(layouts.Out.Layout_BC_Out	)				pInput_BusCont_Init		= BC_Init()
	
) :=
function
	
	dBC_Init_Recs		:= distribute(pInput_BusCont_Init, hash(link_fein, link_inc_date));
	
	Business_Header.Layout_Business_Contact_Full_New trfToBC_base(dBC_Init_Recs l) := transform
			
			self.bdid 								:= l.bdid;
			self.dt_first_seen				:= (unsigned4)l.dt_first_seen;
			self.dt_last_seen					:= (unsigned4)l.dt_last_seen;
			self.source								:= l.src;
			self.company_name 				:= l.bus_name;
			self.company_prim_range		:= l.company_clean_addr.prim_range;
			self.company_predir				:= l.company_clean_addr.predir;
			self.company_prim_name		:= l.company_clean_addr.prim_name;
			self.company_addr_suffix	:= l.company_clean_addr.addr_suffix;
			self.company_postdir			:= l.company_clean_addr.postdir;
			self.company_unit_desig		:= l.company_clean_addr.unit_desig;
			self.company_sec_range		:= l.company_clean_addr.sec_range;
			self.company_city					:= l.company_clean_addr.p_city_name;
			self.company_state				:= l.company_clean_addr.st;
			self.company_zip					:= (unsigned3)l.company_clean_addr.zip;
			self.company_zip4					:= (unsigned2)l.company_clean_addr.zip4;
			self.company_phone				:= (unsigned6)l.bus_phone;
			self.company_fein 				:= (unsigned4)l.orig_fein;
			
			self.did 									:= l.did;
			self.ssn									:= (unsigned4)l.contact_ssn;
			self.contact_score 				:= if(trim(l.cust_name) = '', (unsigned1)l.contact_score,
																			if(l.did = 0, 1, 3));
			self.company_source_group	:= if(trim(l.cust_name) = '',
																			ut.CleanSpacesAndUpper(l.company_source_group),
																			ut.CleanSpacesAndUpper(l.link_fein + l.link_inc_date));
			self.vendor_id						:= if(trim(l.cust_name) = '',
																			ut.CleanSpacesAndUpper(l.vendor_id),
																			ut.CleanSpacesAndUpper(l.link_fein + l.link_inc_date));
			self.vl_id								:= if(trim(l.cust_name) = '',
																			'',
																			ut.CleanSpacesAndUpper(l.link_fein + l.link_inc_date));
			self.company_title				:= ut.CleanSpacesAndUpper(l.company_title);
			self.company_department		:= '';
			self.title								:= if(trim(l.cust_name) = '', l.contact_title, l.title);
			self.fname								:= l.fname;
			self.mname								:= l.mname;
			self.lname								:= l.lname;
			self.name_suffix					:= l.name_suffix;
			self.name_score						:= if(trim(l.cust_name) = '', '0', l.name_score);
			self.prim_range						:= l.contact_clean_addr.prim_range;
			self.predir								:= l.contact_clean_addr.predir;
			self.prim_name						:= l.contact_clean_addr.prim_name;
			self.addr_suffix					:= l.contact_clean_addr.addr_suffix;
			self.postdir							:= l.contact_clean_addr.postdir;
			self.unit_desig						:= l.contact_clean_addr.unit_desig;
			self.sec_range						:= l.contact_clean_addr.sec_range;
			self.city									:= l.contact_clean_addr.p_city_name;
			self.state								:= l.contact_clean_addr.st;
			self.zip									:= (unsigned3)l.contact_clean_addr.zip;
			self.zip4									:= (unsigned2)l.contact_clean_addr.zip4;
			self.county								:= l.contact_clean_addr.fips_county;
			self.msa									:= l.contact_clean_addr.msa;
			self.geo_lat							:= l.contact_clean_addr.geo_lat;
			self.geo_long							:= l.contact_clean_addr.geo_long;
			self.phone								:= (unsigned6)l.contact_phone;
			self.email_address				:= '';			
			self.record_type					:= 'C';
			self.from_hdr							:= l.from_hdr;
			self.glb									:= if(trim(l.glb) = '0', false, true); 
			self.dppa									:= if(trim(l.dppa) = '0', false, true);
			self 											:= l;
			
	end;

	dBC_W_Cnames := project(dBC_Init_Recs, trfToBC_base(left));
	
	return dBC_W_Cnames;
	
end;