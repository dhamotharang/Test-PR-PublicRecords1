// based on chuckjensen.Key_Nbr_Address_UID

import doxie,Data_Services, dx_Header;

export data_key_nbr_headers_uid := PROJECT (doxie.nbr_headers, dx_Header.layouts.i_nbr_uid);
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
