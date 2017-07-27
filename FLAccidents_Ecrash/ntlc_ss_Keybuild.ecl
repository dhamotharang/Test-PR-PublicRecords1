/////////////////////////////////////////////////////////////////
//Expand Florida file 
/////////////////////////////////////////////////////////////////
import FLAccidents;

flc_ss 	:= FLAccidents.basefile_flcrash_ss(lname+cname+prim_name<>'');

xpnd_layout := record
    string8 dt_first_seen;
    string8 dt_last_seen;
    string2 report_code;
    string25 report_category;
    string65 report_code_desc;
	string10 vehicle_incident_id;
	string1	vehicle_status;
	string50 accident_location;
	string25 accident_street;
	string25 accident_cross_street;
	string25  jurisdiction;
	string2 jurisdiction_state;
	string5 jurisdiction_nbr;
	string25 IMAGE_HASH;
	string1 AIRBAGS_DEPLOY;
	string12  did,
	string10  accident_nbr,
	string8   accident_date, 
	string5   title,
	string20  fname,
	string20  mname,
	string20  lname,
	string5   name_suffix,
	string12  b_did,
	string25  cname,
	string10  prim_range,
	string2   predir,
	string28  prim_name,
	string4   addr_suffix,
	string2   postdir,
	string10  unit_desig,
	string8   sec_range,
	string25  v_city_name,
	string2   st,
	string5   zip,
	string4   zip4,
    string20  record_type,
	string15  driver_license_nbr,
	string2   dlnbr_st,
	string22  vin,
	string8   tag_nbr,
	string2   tagnbr_st,
  end;

xpnd_layout xpndrecs(flc_ss L, FLAccidents.Key_FLCrash2v R) := transform
self.dt_first_seen					:= L.accident_date;
self.dt_last_seen					:= L.accident_date;
self.report_code					:= 'FA';
self.report_category				:= 'Auto Report';
self.report_code_desc				:= 'Auto Accident';
self.vehicle_incident_id			:= '';
self.vehicle_status					:= map(L.accident_nbr = R.accident_nbr and 
										   L.vin = R. vehicle_id_nbr and 
										   R.vina_series+R.vina_model+R.reference_number+R.vina_make+R.vina_body_style+R.series_description
											+R.car_series+R.car_body_style+R.car_cid+R.car_cylinders<>''=>'V','');
self.accident_location		:= '';
self.accident_street		:= '';
self.accident_cross_street	:= '';
self.jurisdiction			:= 'FLORIDA HP';
self.jurisdiction_state		:= 'FL';
self.jurisdiction_nbr		:= '';
self.IMAGE_HASH				:= '';
self.AIRBAGS_DEPLOY			:= '';

self 								:= L;
end;

pflc_ss := join(distribute(flc_ss,hash(accident_nbr,vin)),
				distribute(pull(FLAccidents.Key_FLCrash2v),hash(accident_nbr,vehicle_id_nbr)),
				left.accident_nbr = right.accident_nbr and 
				left.vin = right.vehicle_id_nbr,
				xpndrecs(left,right),left outer, local);
  
/////////////////////////////////////////////////////////////////
//Slim National file 
///////////////////////////////////////////////////////////////// 
ntlFile := FLAccidents.BaseFile_NtlAccidents_Alpharetta;

pflc_ss slimrec(ntlFile L) := transform
string8     fSlashedMDYtoCYMD(string pDateIn) :=
intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
+     intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
+     intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

self.did					:= if(L.did = 0,'000000000000',intformat(L.did,12,1));	
self.accident_nbr 			:= (string11)((unsigned6)L.vehicle_incident_id+10000000000);
self.accident_date			:= fSlashedMDYtoCYMD(L.loss_date[1..10]);
self.b_did					:= if(L.bdid = 0,'',intformat(L.bdid,12,1)); 
self.cname					:= stringlib.stringtouppercase(L.business_name);
self.addr_suffix 			:= L.suffix;
self.zip					:= L.zip5;
self.record_type			:= CASE(L.party_type
									,'OWNER'=>'Property Owner'
									,'DRIVER'=>'Vehicle Driver'
									,'');
self.driver_license_nbr		:= if(L.pty_drivers_license !=''
									,L.pty_drivers_license
									,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license,''));
self.dlnbr_st				:= if(L.pty_drivers_license_st !=''
									,L.pty_drivers_license_st
									,if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.drivers_license_st,''));	
self.tag_nbr				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag,'');	
self.tagnbr_st				:= if(L.LAST_NAME+L.FIRST_NAME = L.LAST_NAME_1+L.FIRST_NAME_1,L.tag_state,'');
self.vin					:= L.vehvin;
self.accident_location		:= map(L.cross_street!='' and L.cross_street!= 'N/A' => L.street+' & '+L.cross_street,L.street);
self.accident_street		:= L.street;
self.accident_cross_street	:= map(L.cross_street!= 'N/A' => L.cross_street,'');
self.jurisdiction			:= L.edit_agency_name;
self.jurisdiction_state		:= L.STATE_ABBR;
self.st						:= if(l.st = '',self.jurisdiction_state,l.st);
self.jurisdiction_nbr		:= L.AGENCY_ID;
self.IMAGE_HASH				:= L.PDF_IMAGE_HASH;
self.AIRBAGS_DEPLOY			:= L.AIRBAGS_DEPLOY;
self						:= L;

end;
pntl := project(ntlFile,slimrec(left));

allrecs := pntl+pflc_ss: persist('~thor_data400::persist::ecrash_ss');

export ntlc_ss_Keybuild := allrecs;