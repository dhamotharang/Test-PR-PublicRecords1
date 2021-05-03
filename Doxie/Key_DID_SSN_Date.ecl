import doxie_build, doxie, header_services, data_services, Header, Suppress;
export Key_DID_SSN_Date(boolean IsFCRA = false) := function

Suppression_Layout 	:= Suppress.applyRegulatory.layout_in;

slim_rec := RECORD 
	unsigned6 did;
	qstring9 ssn;
	unsigned3 best_date := 0;
	data16 hval := (data16)0;

END;

// NOTE: using doxie.Key_DID_SSN_Date will not work on all HPCC systems due to memory availability.
//dsd_tmp := doxie.Key_DID_SSN_Date;
dsd_in := if(isFCRA,doxie_build.file_FCRA_header_built,doxie_build.file_header_building);

dsd_tmp := doxie.DID_SSN_Date(dsd_in);

dsd_header := project(dsd_tmp,slim_rec);

dsd := Header.Prep_Build.applySsnFilterSup(dsd_header); 

file_prefix := if (IsFCRA, 
                     data_services.Data_Location.Person_header+'thor_data400::key::fcra::header.did.ssn.date_',
                     data_services.Data_Location.Person_header+'thor_data400::key::header.did.ssn.date_');
										
return index(dsd,{did,ssn},{best_date}, file_prefix + doxie.Version_SuperKey);


end;