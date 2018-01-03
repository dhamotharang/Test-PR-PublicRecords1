import doxie_build, doxie, data_services;

f := doxie_build.file_header_building(trim(prim_name)<>'', trim(zip)<>'');

export Key_Header_Address := 
       index(f,
             {prim_name,
              zip, 
              prim_range, 
              sec_range
             },
             {did,
              src,
              dt_first_seen,
              dt_last_seen,
              phone,
              ssn,
              dob,
              fname,
              lname,
              prim_range,
              predir,
              prim_name,
              suffix,
              postdir,
              unit_desig,
              sec_range,
              city_name,
              st,
              zip,
              zip4,
              county,
              geo_blk
             },
		         data_services.data_location.prefix() + 'thor_data400::key::header_address_' + doxie.Version_SuperKey);