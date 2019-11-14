// based on chuckjensen.Key_Nbr_Address_UID

import doxie,Data_Services, dx_Header,header;

nbr_pre_ccpa_compliance := PROJECT (doxie.nbr_headers, TRANSFORM(dx_Header.layouts.i_nbr_uid,SELF:=LEFT,SELF.global_sid:=0,SELF.record_sid:=0));
nbr_wth_ccpa_compliance := header.fn_suppress_ccpa(nbr_pre_ccpa_compliance,true);

export data_key_nbr_headers_uid := nbr_wth_ccpa_compliance;
// index(
// 	doxie.nbr_headers,																												// baserecset
// 	{zip,prim_name,suffix,predir,postdir,uid},																// keys
// 	{did,prim_range,sec_range,dt_first_seen,dt_last_seen,rid,pflag3,ssn,tnt,	// payload
// 	 dt_nonglb_last_seen, src, valid_SSN,
// 	 phone, title, fname, mname, lname, name_suffix, unit_desig,
// 	 city_name, st, zip4, county, geo_blk, dob, county_name, RawAID
// 	},
// 	Data_Services.Data_location.Prefix('PersonHeader')+'thor_Data400::key::header_nbr_uid_' + doxie.Version_SuperKey		// indexfile
// );

// Build this on the "400way" cluster with...
//
// import doxie;
// buildindex(doxie.key_nbr_headers_uid, OVERWRITE);
