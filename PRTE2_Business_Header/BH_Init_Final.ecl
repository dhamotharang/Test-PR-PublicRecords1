import Business_Header, ut, prte2, STD;

export BH_Init_Final (
		dataset(Layouts.Out.Layout_BH_Out	)	pInput_BusHdr_Init		= BH_Init()	
	//,dataset(Business_Header.Layout_Business_Header_Base)	pBusiness_Headers							= Files().Base.Business_Headers.QA
	
) :=
function

	dBH_Search_Recs := pInput_BusHdr_Init(trim(long_bus_name) <> '');
	
	// $TODO: This logic is stolen from Gong.Gong_As_Business_Header,
	// it should be common.
	STRING10 sf(INTEGER ph) := INTFORMAT(ph, 10, 1);
	INTEGER ph_score(INTEGER ph) := 2 * (
						IF(sf(ph)[9..10] = '00', 500, 0) +
						IF(sf(ph)[8..10] = '000', 500, 0) +
						IF(sf(ph)[1..3] IN ['800','811','822','833','844','855','866','877','888'], 250, 0));

	Business_Header.Layout_Business_Header_Base trfBH_Map_to_BHF(dBH_Search_Recs l) := transform

		self.dt_first_seen     				:= (unsigned4)l.dt_first_seen;																								   
	  self.dt_last_seen      				:= (unsigned4)l.dt_last_seen;																								  
	  self.dt_vendor_first_reported := (unsigned4)l.dt_vendor_first_reported;
	  self.dt_vendor_last_reported  := (unsigned4)l.dt_vendor_last_reported;
		self.rcid											:= l.bdid;
		self.bdid											:= l.bdid;
	  self.vl_id             				:= if(trim(l.cust_name) = '', '', ut.CleanSpacesAndUpper(l.src) + STD.Str.CleanSpaces(l.link_fein + l.link_inc_date));
		self.group1_id         				:= if(trim(l.cust_name) = '', (unsigned6)l.group_id, 0);
	  self.vendor_id         				:= if(trim(l.cust_name) = '', trim(l.vendor_id), ut.CleanSpacesAndUpper(l.src) + STD.Str.CleanSpaces(l.link_fein + l.link_inc_date));
		self.source_group      				:= if(trim(l.cust_name) = '', trim(l.source_group), ut.CleanSpacesAndUpper(l.src) + STD.Str.CleanSpaces(l.link_fein + l.link_inc_date));
		self.phone            				:= (unsigned6)l.bus_phone;
	  self.phone_score      				:= ph_score((unsigned6)l.bus_phone);
	  self.source           				:= ut.CleanSpacesAndUpper(l.src);	  
	  self.company_name      				:= ut.CleanSpacesAndUpper(l.long_bus_name);
	  self.prim_range        				:= l.prim_range;
	  self.predir            				:= l.predir;
	  self.prim_name        				:= l.prim_name;
	  self.addr_suffix       				:= l.addr_suffix;
	  self.postdir           				:= l.postdir;
	  self.unit_desig        				:= l.unit_desig;
	  self.sec_range         				:= l.sec_range;
	  self.city              				:= l.v_city_name;
	  self.state             				:= l.st;
	  self.zip               				:= (unsigned3)l.zip;
	  self.zip4              				:= (unsigned2)l.zip4;
	  self.county            				:= l.fips_county;
	  self.msa               				:= l.msa;
	  self.geo_lat           				:= l.geo_lat;
	  self.geo_long          				:= l.geo_long;  
	  self.fein              				:= (unsigned4)l.orig_fein;
	  self.current           				:= true;
		self.match_company_name				:= ut.CleanSpacesAndUpper(l.bus_name);
		self.match_branch_unit				:= '';
		self.dppa											:= if(trim(l.dppa) in ['0',''], false, true);
		
	end;
	
	BH_final_recs := project(dBH_Search_Recs, trfBH_Map_to_BHF(left));
	
	return BH_final_recs;
	
end;