IMPORT SANCTN, SANCTN_MARI, Prof_License_Mari, lib_stringlib,ut,std;

EXPORT clean_license_nbr(string filedate) := function

// Get the datasets
SANCTN_license_nbr := SANCTN.file_in_license;
TransLicTypeLkp := Sanctn_Mari.files_Midex_common_raw.LicenseTypeLookup(srce_updt = 'SANCTN');

SANCTN.layout_SANCTN_license_clean get_SANCTN_license(SANCTN_license_nbr input) := TRANSFORM
   trimLicenseState 				:= ut.CleanSpacesAndUpper(input.LICENSE_STATE);
	 trimLicenseType  				:= ut.CleanSpacesAndUpper(input.LICENSE_TYPE);
	 self.LICENSE_TYPE 				:= if(trimLicenseState = 'NMLS' AND trimLicenseType = '', trimLicenseState,trimLicenseType);
	 self.CLN_LICENSE_NUMBER 	:= Prof_license_mari.fCleanLicenseNbr(STD.Str.ToUpperCase(input.LICENSE_NUMBER));
	 self    := input;
	 self    := [];
   
end;

clean_license_data := sort(PROJECT(SANCTN_license_nbr,get_SANCTN_license(LEFT)),batch_number,incident_number, party_number,order_number);

// Populate STD_TYPE_DESC field via translation
SANCTN.layout_SANCTN_license_clean 	trans_lic_type(clean_license_data L, TransLicTypeLkp R) := transform
	self.STD_TYPE_DESC :=  ut.CleanSpacesAndUpper(R.license_description);
	self := L;
	self:=[];
end;

ds_type_trans := JOIN(clean_license_data, TransLicTypeLkp,
								      STD.Str.ToUpperCase(left.LICENSE_TYPE) = STD.Str.ToUpperCase(right.license_type),
											trans_lic_type(left,right),left outer,lookup);



clean_data_suppress := ds_type_trans((trim(batch_number,left,right)+trim(incident_number,left,right) not in SANCTN.SuppressBatchIncident));

output('License data: ' + count(ds_type_trans));

clean_data_deduped := output(dedup(clean_data_suppress,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::license_nbr');

//Clear the history of the license nbr superfile since it is full file replacement		
add_super := sequential(STD.File.StartSuperFileTransaction()
											 ,STD.File.ClearSuperFile(SANCTN.cluster_name + 'out::sanctn::license_nbr',true)
											 ,STD.File.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::license_nbr', SANCTN.cluster_name + 'out::sanctn::' + filedate + '::license_nbr')
										   ,STD.File.FinishSuperFileTransaction()
													);

return sequential(clean_data_deduped,add_super);

end;