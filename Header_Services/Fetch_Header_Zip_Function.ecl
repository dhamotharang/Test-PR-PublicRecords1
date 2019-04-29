
import doxie, dx_header, NID;

j := dx_header.key_zip();


doxie.layout_references xtz(j r) := TRANSFORM
                                SELF := r;
                                 END;

export Fetch_Header_Zip_Function (string10 prange_value
															,string28 pname_value
															,string25 city_value
															,string2 state_value
															,string5 zip_val
															,unsigned2 zip_radius_value
															,string8 sec_range_value
															,string20 lname_value
															,string20 fname_value
															,boolean phonetics
															)
:=
MODULE
//
 city_zip_value := ziplib.CityToZip5(state_value, city_value);
 shared zip_value := IF(zip_val<>'', IF(ziplib.ZipsWithinRadius(zip_val, zip_radius_value)=[],
																															[(INTEGER4)zip_val],
																															ziplib.ZipsWithinRadius(zip_val, zip_radius_value)),
			 IF(state_value<>'' AND city_value<>'' AND zip_radius_value>0, ziplib.ZipsWithinRadius(city_zip_value, zip_radius_value),
			  []));

	shared idsz := j(lname_value != '',
		zip IN zip_value,
		(lname=lname_value OR phonetics),
		(dph_lname=metaphonelib.DMetaPhone1(lname_value)),
		LENGTH(TRIM(fname_value))<2 or NID.mod_PFirstTools.RinPFL(fname_value,pfname),
		(fname[1..length(trim(fname_value))]=fname_value OR (phonetics AND LENGTH(TRIM(fname_value))>=2)) 
		);
		
 
	shared idsp := project(LIMIT(LIMIT(idsz, 100000, SKIP, keyed),9000, SKIP), xtz(LEFT));

	
	EXPORT lafn := if(count(idsp) != 0
						, false
						,	if(count(idsz) = 0
								, false
								, true
								)
						);
	EXPORT outrecszip := idsp;
END;