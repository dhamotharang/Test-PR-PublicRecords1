// This attribute gets certain fields from the base flcrash2v, 4, 7, and 9 files and appends them
// to the already created base flcrash_did file to create a new base flcrash_ss (Search 
// Service) file which will be used to create certain key files (AccNbr, DLNbr, etc.).  
// Those key files will then be used by the FLAccidents_Services.SearchService.

import flaccidents, ut;

// Don't forget to update the Version Development attribute with the new build date
#workunit ('name', 'Build FLCrash SearchService File');

base_did_file := flaccidents.BaseFile_FLCrash_Did; //main slimmed (did+) base file
base_file2 := flaccidents.BaseFile_FLCrash2v;  //Vehicle & Owner info
base_file4 := flaccidents.BaseFile_FLCrash4;   //Driver info
base_file7 := flaccidents.BaseFile_FLCrash7;   //Property damage info
base_file9 := flaccidents.BaseFile_FLCrash9;	//Witness info

flaccidents.layout_flcrash_srchserv xf2(base_did_file l, base_file2 r) := transform
	self.dlnbr_st    := '',
	self.tagnbr_st   := if(r.vehicle_tag_nbr<>'',stringlib.stringcleanspaces(r.vehicle_reg_state),''),
	self.b_did       := r.b_did,
	self.ultid       := r.ultid,
  self.orgid       := r.orgid,
  self.seleid      := r.seleid,
  self.proxid      := r.proxid,
  self.powid       := r.powid,
  self.empid       := r.empid,
  self.dotid       := r.dotid,
  self.ultscore    := r.ultscore,
  self.orgscore    := r.orgscore,
  self.selescore   := r.selescore,
  self.proxscore   := r.proxscore,
  self.powscore    := r.powscore,
  self.empscore    := r.empscore,
  self.dotscore    := r.dotscore,
  self.ultweight   := r.ultweight,
  self.orgweight   := r.orgweight,
  self.seleweight  := r.seleweight,
  self.proxweight  := r.proxweight,
  self.powweight   := r.powweight,
  self.empweight   := r.empweight,
  self.dotweight   := r.dotweight,	
	self             := l,
end;

base_did2 := join(base_did_file, base_file2, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'Vehicle Owner'  and
                       left.vin = right.vehicle_id_nbr,
				   xf2(left,right), left outer, keep(1), hash);


flaccidents.layout_flcrash_srchserv xf4(base_did2 l, base_file4 r) := transform
	self.dlnbr_st := if(r.driver_dl_nbr <> '', stringlib.stringcleanspaces(r.driver_lic_st),l.dlnbr_st),
	self          := l,
end;

base_did4 := join(base_did2, base_file4, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'Vehicle Driver'  and
                       left.driver_license_nbr = right.driver_dl_nbr,
				   xf4(left,right), left outer, keep(1), hash);


flaccidents.layout_flcrash_srchserv xf7(base_did4 l, base_file7 r) := transform
	self.b_did       := if(r.b_did<>'',r.b_did,l.b_did),
	self.ultid       := if(r.ultid      <> 0, r.ultid     , 0),
  self.orgid       := if(r.orgid      <> 0, r.orgid     , 0),
  self.seleid      := if(r.seleid     <> 0, r.seleid    , 0),
  self.proxid      := if(r.proxid     <> 0, r.proxid    , 0),
  self.powid       := if(r.powid      <> 0, r.powid     , 0),
  self.empid       := if(r.empid      <> 0, r.empid     , 0),
  self.dotid       := if(r.dotid      <> 0, r.dotid     , 0),
  self.ultscore    := if(r.ultscore   <> 0, r.ultscore  , 0),
  self.orgscore    := if(r.orgscore	  <> 0, r.orgscore 	, 0),
  self.selescore   := if(r.selescore	<> 0, r.selescore	, 0),
  self.proxscore   := if(r.proxscore  <> 0, r.proxscore , 0),
  self.powscore    := if(r.powscore	  <> 0, r.powscore 	, 0),
  self.empscore    := if(r.empscore	  <> 0, r.empscore 	, 0),
  self.dotscore    := if(r.dotscore	  <> 0, r.dotscore 	, 0),
  self.ultweight   := if(r.ultweight  <> 0, r.ultweight , 0),
  self.orgweight   := if(r.orgweight  <> 0, r.orgweight , 0),
  self.seleweight  := if(r.seleweight	<> 0, r.seleweight, 0),
  self.proxweight  := if(r.proxweight	<> 0, r.proxweight, 0),
  self.powweight   := if(r.powweight  <> 0, r.powweight	, 0),
  self.empweight   := if(r.empweight 	<> 0, r.empweight	, 0),
  self.dotweight   := if(r.dotweight 	<> 0, r.dotweight , 0),
	self             := l,
end;

base_did7 := join(base_did4, base_file7, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'Property Owner' and
											 left.cname = right.prop_owner_name,
				   xf7(left,right), left outer, keep(1), hash);


flaccidents.layout_flcrash_srchserv xf9(base_did7 l, base_file9 r) := transform
	self             := l,
end;

base_did9 := join(base_did7, base_file9, 
                       left.accident_nbr = right.accident_nbr and
                       left.record_type = 'Witness',
				   xf9(left,right), left outer, keep(1), hash);

ut.MAC_SF_BuildProcess(base_did9, '~thor_data400::base::flcrash_ss', build_flcrash_ss, 2,,true);

export FLCrash_BuildSSFile := build_flcrash_ss;