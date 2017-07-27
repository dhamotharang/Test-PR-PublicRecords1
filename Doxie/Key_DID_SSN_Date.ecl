import doxie_build, ut, header, doxie, header_services;
export Key_DID_SSN_Date(boolean IsFCRA = false) := function

Suppression_Layout 	:= header_services.Supplemental_Data.layout_in;

slim_rec := RECORD 
	unsigned6 did;
	qstring9 ssn;
	unsigned3 best_date := 0;
	data16 hval := 0;

END;

slim_rec GetRightJoinInfo(slim_rec R) := transform
  self.ssn := R.ssn;
  self.did := R.did;
  self.best_date := R.best_date;
	self := [];
	end;
	
// NOTE: using doxie.Key_DID_SSN_Date will not work on all HPCC systems due to memory availability.
//dsd_tmp := doxie.Key_DID_SSN_Date;
dsd_in := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building);

dsd_tmp := doxie.DID_SSN_Date(dsd_in);

dsd_header := project(dsd_tmp,slim_rec);

slim_rec add_hval(slim_rec L) := TRANSFORM
	 SELF.hval := hashmd5(intformat((unsigned6)L.did,12,1),Trim((string9)L.ssn, left, right));
	 SELF := L;
	 SELF := [];
 end;
 
header_services.Supplemental_Data.mac_verify('file_ssn_filter.thor',header_services.Supplemental_Data.layout_out,supp_list_fun);
supp_list := supp_list_fun();

temp := Project(dsd_header,add_hval(LEFT));
dsd := JOIN(temp, supp_list,LEFT.hval=RIGHT.hval,GetRightJoinInfo(LEFT),LEFT ONLY);

file_prefix := if (IsFCRA, 
                     ut.Data_Location.Person_header+'thor_data400::key::fcra::header.did.ssn.date_',
                     ut.Data_Location.Person_header+'thor_data400::key::header.did.ssn.date_');
										
return index(dsd,{did,ssn},{best_date}, file_prefix + doxie.Version_SuperKey);


end;