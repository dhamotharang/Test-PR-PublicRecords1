IMPORT      data_services,doxie;

EXPORT      Key_Addr_Unique_Expanded(boolean isFCRA=false) := FUNCTION

            location        := data_services.Data_location.prefix('person_header');
            keynameNfcra    := 'thor_data400::key::header::qa::addr_unique_expanded';	
            keyname_fcra    := 'thor_data400::key::fcra::header::qa::addr_unique_expanded';
            keyname         := if(isFCRA,keyname_fcra,keynameNfcra);
            ds              := dataset(location+keyname,Header.Layout_addr_ind_full,thor);

            layout_key      := {ds.did};
            layout_payload  := {ds};

            RETURN      INDEX(ds, layout_key, layout_payload,	location+keyname);
            
END;