//
// created Feb-12-2020 in support of BI-20
//
// expanded AID and BipV2 embedded layouts to remove Boca Dependency
//

EXPORT Regulatory := module

		import AID, BIPV2, Suppress;
	 
		Export Party_layout:= 
				record
						string30		Vehicle_Key;
						string15		Iteration_Key;
						string15		Sequence_Key;
						string2			Source_Code;
						string2			State_Origin;
						
						unsigned8		State_Bitmap_Flag;
						string1			Latest_Vehicle_Flag;
						string1			Latest_Vehicle_Iteration_Flag;
						string1			History;
						unsigned4		Date_First_Seen;
						unsigned4		Date_Last_Seen;
						unsigned4		Date_Vendor_First_Reported;
						unsigned4		Date_Vendor_Last_Reported;
						string1			Orig_Party_Type;
						string1			Orig_Name_Type;
						string10		Orig_Conjunction;
						string70		Orig_Name;
						
						string70		Orig_Address;
						string35		Orig_City;
						string2			Orig_State;
						String30    orig_province;
						String30    orig_country;
						string10		Orig_Zip;
						
						string9			Orig_SSN;
						string9			Orig_FEIN;
						string20		Orig_DL_Number;
						string8			Orig_DOB;
						string1			Orig_Sex;
						string8			Orig_Lien_Date;
						
						string5			title;
						string20		fname;
						string20		mname;
						string20		lname;
						string5			name_suffix;
						string3			name_score;
						string70		Append_Clean_CName;
						
						string150		Append_Ace1_PrepAddr1	:=	'';
						string100		Append_Ace1_PrepAddr2	:=	'';
//					AID.Common.xAID	Append_Ace1_RawAID		:=	0;
						unsigned8 	Append_Ace1_RawAID		:=	0;
						string150		Append_Ace2_PrepAddr1	:=	'';
						string50		Append_Ace2_PrepAddr2	:=	'';
//					AID.Common.xAID	Append_Ace2_RawAID		:=	0;
						unsigned8 	Append_Ace2_RawAID		:=	0;
						
						string10		prim_range;
						string2			predir;
						string28		prim_name;
						string4			addr_suffix;
						string2			postdir;
						string10		unit_desig;
						string8			sec_range;
						string25		v_city_name;
						string2			st;
						string5			zip5;
						string4			zip4;
						string2			addr_rec_type;
						string2			fips_state;
						string3			fips_county;
						string10		geo_lat;
						string11		geo_long;
						string4			cbsa;
						string7			geo_blk;
						string1			geo_match;
						string4			err_stat;
						
						string10		ace_prim_range;
						string2			ace_predir;
						string28		ace_prim_name;
						string4			ace_addr_suffix;
						string2			ace_postdir;
						string10		ace_unit_desig;
						string8			ace_sec_range;
						string25		ace_p_city_name;
						string25		ace_v_city_name;
						string2			ace_st;
						string5			ace_zip5;
						string4			ace_zip4;
						string2			ace_addr_rec_type;
						string2			ace_fips_state;
						string3			ace_fips_county;
						string10		ace_geo_lat;
						string11		ace_geo_long;
						string4			ace_cbsa;
						string7			ace_geo_blk;
						string1			ace_geo_match;
						string4			ace_err_stat;
						
						unsigned6		Append_DID;
						unsigned1		Append_DID_Score;
						unsigned6		Append_BDID;
						unsigned1		Append_BDID_Score;
						string20		Append_DL_Number;
						string9			Append_SSN;
						string9			Append_FEIN;
						string8     Append_DOB;
						
						string8			Reg_First_Date;
						string8			Registration_Effective_Date;
						string8			Reg_Earliest_Effective_Date;
						string8			Reg_Latest_Effective_Date;
						string8			Registration_Expiration_Date;
						string10		Reg_Latest_Expiration_Date;
						unsigned1		Reg_Rollup_Count;
						string10		Reg_Decal_Number;
						string4			Reg_Decal_Year;
						string1			Reg_Status_Code;
						string20		Reg_Status_Desc;
						string10		Reg_True_License_Plate;
						string10		Reg_License_Plate;
						string2			Reg_License_State;
						string4			Reg_License_Plate_Type_Code;
						string65		Reg_License_Plate_Type_Desc;
						string2			Reg_Previous_License_State;
						string10		Reg_Previous_License_Plate;
						string20		Ttl_Number;
						string8			Title_Issue_Date;
						string8			Ttl_Earliest_Issue_Date;
						string8			Ttl_Latest_Issue_Date;
						string8			Ttl_Previous_Issue_Date;
						unsigned1		Ttl_Rollup_Count;
						string2			Ttl_Status_Code;
						string48		Ttl_Status_Desc;
						string2     Previous_Title_State;
						string7			Ttl_Odometer_Mileage;
						string1			Ttl_Odometer_Status_Code;
						string42		Ttl_Odometer_Status_Desc;
						string8			Ttl_Odometer_Date;
						string8			SRC_FIRST_DATE	:= '';	//New fields added for Infutor batch project - bug #155364
						string8			SRC_LAST_DATE	:= '';		//New fields added for Infutor batch project
				end;
				
    export LZ_l_xlink_ids := Suppress.Layout_regulatory.LZ_l_xlink_ids ;
		
		export	Party_Bip_layout	:=record
						Party_Layout;
						// Bipv2.IDlayouts.l_xlink_ids;
						LZ_l_xlink_ids;		 							
						unsigned8		source_rec_id := 0;	 	//Added for BIP project
		end;
	
		// Layout of the Vehicle base file 
		export	Party_CCPA_in	:=record
		        Party_Bip_layout ;
						//Added for CCPA-103
						unsigned4 global_sid := 0;
						unsigned8 record_sid := 0;
						//Added for DF-25578
						string30 raw_name;
    end;		
		
				
		//
		// process vehicle party information
		//
		export applyMotorVehicleP(ds) := 
				functionmacro	
				
						VehiclePartySupHashAll(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, left, right));
	         
					  VehiclePartySupHashRegistrant(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, left, right), 
																													 trim((string)l.Iteration_key, left, right));
																													 
					  VehiclePartySupHashUniqueRegistrant(recordof(ds) L) := hashmd5(trim((string)l.Vehicle_key, 	 left, right), 
																													 trim((string)l.Iteration_key, left, right),
																													 trim((string)l.Append_Clean_CName,  left, right),
																													 trim((string)l.fname,         left, right),
																													 trim((string)l.mname,         left, right),
																													 trim((string)l.lname,         left, right));
																														 
	         
						ds1 := Suppress.applyRegulatory.complex_sup_trio(ds, 'file_vehicle_party_sup.txt', VehiclePartySupHashAll, 
																																										 VehiclePartySupHashRegistrant,
																																										 VehiclePartySupHashUniqueRegistrant);

						return suppress.applyRegulatory.simple_append(ds1, 'file_vehicle_party_inj.thor', VehicleV2.Regulatory.Party_Bip_layout); 
				endmacro;

		//
		// process vehicle information
		// code has been commented as need and keys haven't been determine.  
		// Note the infrastructure changes made in vehicleV2.files and prep_build still support the calling of this file in case future direction changes	
		//
		export applyMotorVehicleM(ds) := 
				functionmacro
						return ds;
				endmacro;
end;
					