import autokey,AutoKeyB2,AutoKeyI,Prof_License_Mari; 


export proc_build_autokeys(string pVersion) := function

c		:= Prof_License_Mari.constants;

Layouts.SlimRec  	xformSearch(Prof_License_Mari.layouts.final L, integer cnt) := transform
			self.mari_rid							:= L.mari_rid;
			self.create_dte						:= L.create_dte;                  
		  self.last_upd_dte  				:= L.last_upd_dte; 
		  self.stamp_dte  					:= L.stamp_dte;
			self.date_vendor_first_reported		:= L.date_vendor_first_reported;
			self.date_vendor_last_reported		:= L.date_vendor_last_reported;
			self.date_first_seen			:= L.date_first_seen;
			self.date_last_seen				:= L.date_last_seen;
			self.did									:= L.did;
			self.bdid									:= L.bdid;
			self.std_prof_cd					:= L.std_prof_cd;
		  self.std_source_upd				:= L.std_source_upd;
			self.type_cd							:= L.type_cd;
			self.fname								:= L.fname;
			self.mname								:= L.mname;
			self.lname								:= L.lname;
			self.name_suffix					:= L.name_suffix;
			self.party_birth					:= L.birth_dte;
			self.license_nbr					:= L.license_nbr;	
			self.cln_license_nbr			:= L.cln_license_nbr;
			self.off_license_nbr			:= L.off_license_nbr;
			self.license_state				:= L.license_state;
			self.cmc_slpk							:= L.cmc_slpk;		
			self.pcmc_slpk						:= L.pcmc_slpk;
			self.tax_type							:= 	choose(cnt,L.tax_type_1,L.tax_type_2);
			self.ssn_taxid						:= 	choose(cnt,L.ssn_taxid_1,L.ssn_taxid_2);
			self.company							:= 	choose(cnt,L.name_company,L.name_company_dba);
			self.party_phone 					:= 	choose(cnt,L.phn_mari_1,L.phn_mari_2);
			self.addr_ind							:=  choose(cnt,L.addr_bus_ind,L.addr_mail_ind);
			self.prim_range 					:= 	choose(cnt,l.Bus_prim_range,l.Mail_prim_range);
			self.predir								:=  choose(cnt,l.Bus_predir,l.Mail_predir);
			self.prim_name 						:= 	choose(cnt,l.Bus_prim_name,l.Mail_prim_name);
			self.addr_suffix					:=  choose(cnt,l.Bus_addr_suffix,l.Mail_addr_suffix);
			self.postdir							:= 	choose(cnt,l.Bus_postdir,l.Mail_postdir);
			self.unit_desig						:=	choose(cnt,l.Bus_unit_desig,l.Mail_unit_desig);
			self.sec_range 						:=  choose(cnt,l.Bus_sec_range,l.Mail_sec_range);
			self.p_city_name					:=	choose(cnt,l.Bus_p_city_name,l.Mail_p_city_name);
			self.city_name						:= 	choose(cnt,l.Bus_v_city_name,l.Mail_v_city_name);
			self.st 									:= 	choose(cnt,l.Bus_state,l.Mail_state);
			self.zip5									:= 	choose(cnt,l.Bus_zip5,l.Mail_zip5);
			self.zip4									:=  choose(cnt,l.Bus_zip4,l.Mail_zip4);
			self.brkr_license_nbr			:= L.brkr_license_nbr;
			self.nmls_id							:= L.nmls_id;
			self.foreign_nmls_id			:= L.foreign_nmls_id;
			self.federal_regulator		:= L.federal_regulator;
			//CCPA-110
			self.global_sid		:= L.global_sid;
			self.record_sid		:= L.record_sid;
			self	:=L;
		end;


NormNameAddr := normalize(c.ak_dataset,2,xformSearch(LEFT,COUNTER));


/* Base file, which is a slimmed down version of the final layout */
ak_dataset := dedup(NormNameAddr,record,all,local);

ak_keyname	:= c.ak_keyname;
ak_logical	:= c.ak_logical(pVersion);
ak_setSkip		:= c.set_skip;
// ak_typeStr	:= c.ak_typeStr;

autokey.mac_useFakeIDs (ak_dataset, 
												ds_withFakeID_AKB,
												proc_build_payload_key_AKB,
												ak_keyname,
												ak_logical,
												did,
												bdid)


outdataset := 
			project(
						ds_withFakeID_AKB,
								transform(autokey.layouts.master,
												self.inp.fname := left.fname;
												self.inp.mname := left.mname;
												self.inp.lname := left.lname;
												self.inp.ssn := if(left.tax_type = 'S',left.ssn_taxid,'');
												self.inp.dob := (integer)left.party_birth;
												self.inp.phone := if(left.type_cd = 'MD' or left.type_cd = '',left.party_phone,'');
												self.inp.prim_name := if(left.type_cd = 'MD' or left.type_cd = '',left.prim_name,'');
												self.inp.prim_range := if(left.type_cd = 'MD' or left.type_cd = '',left.prim_range,'');
												self.inp.st := if(left.type_cd = 'MD' or left.type_cd = '',left.st,'');
												self.inp.city_name := if(left.type_cd = 'MD' or left.type_cd = '',left.city_name,'');
												self.inp.zip := if(left.type_cd = 'MD' or left.type_cd = '',(string6)left.zip5,'');
												self.inp.sec_range := if(left.type_cd = 'MD' or left.type_cd = '',left.sec_range,'');
												self.inp.states := 0;
												self.inp.lname1 := 0;
												self.inp.lname2 := 0;
												self.inp.lname3 := 0;
												self.inp.city1 := 0;
												self.inp.city2 := 0;
												self.inp.city3 := 0;
												self.inp.rel_fname1 := 0;
												self.inp.rel_fname2 := 0;
												self.inp.rel_fname3 := 0;
												self.inp.lookups := 0;
												self.inp.DID := (unsigned6)left.did;
												self.inp.bname := left.company;
												self.inp.fein := if(left.tax_type = 'E',left.ssn_taxid,'');
												self.inp.bphone := if(left.type_cd = 'GR',left.party_phone,'');
												self.inp.bprim_name := if(left.type_cd = 'GR',left.prim_name,'');
												self.inp.bprim_range := if(left.type_cd = 'GR',left.prim_range,'');
												self.inp.bst := if(left.type_cd = 'GR',left.st,'');
												self.inp.bcity_name := if(left.type_cd = 'GR',left.city_name,'');
												self.inp.bzip := if(left.type_cd = 'GR',(string5)left.zip5,'');
												self.inp.bsec_range := if(left.type_cd = 'GR',left.sec_range,'');
												self.inp.BDID := (unsigned6)left.bdid;
												// self.inp.lat := if(left.type_cd = 'GR',(unsigned)left.addr.geo_lat,0);
												// self.inp.long := if(left.type_cd = 'GR',(unsigned)left.addr.geo_long,0);
												self.FakeID := left.FakeID;
												self.p := [];
												self.b := [];		
												));


akmod := module(AutokeyB2.Fn_Build.params)
		export dataset(autokey.layouts.master) L_indata := outdataset;
		export string L_inkeyname := ak_keyname;
		export string L_inlogical := ak_logical;
		export set of string1 L_build_skip_set  := ak_setSkip;
end;


bld_auto_keys := parallel(proc_build_payload_key_AKB,
													AutokeyB2.Fn_Build.Do(akmod,
																								AutoKeyI.BuildI_Indv.DoBuild,
																								AutoKeyI.BuildI_Biz.DoBuild));
														
AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);

retval := sequential(bld_auto_keys,moveToQA);
																	 
return retval;														


end;

