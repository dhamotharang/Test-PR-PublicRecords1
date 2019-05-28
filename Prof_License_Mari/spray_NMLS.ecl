// spray Nationwide Mortgage Licensing System Professional Licenses Files for MARI	   

import ut
	   ,_control
     ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
export spray_NMLS (string filedate):= MODULE
#workunit('name','Spray NMLS0900 ' + filedate);

shared filepath		  :=	'/data/data_build_5_2/MARI/in/NMLS123/' + filedate +'/';	

shared maxRecordSize	:=	8192;
shared group_name	:=	Common_Prof_Lic_Mari.group_name;;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::'+ filedate + '::';

shared superfile_branch:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::branch';
shared superfile_branch_dba:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::branch_dba';
shared superfile_branch_lic:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::branch_license';
shared superfile_company:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Company';
shared superfile_company_lic:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Company_License';
shared superfile_company_dba:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Company_DBA';
shared superfile_individual:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual';
shared superfile_individual_lic:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_License';
shared superfile_individual_loc:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_Location';
shared superfile_individual_aka:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_AKA';
shared superfile_individual_reg:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_Registration';
shared superfile_individual_reg_detail:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::individual_reg_detail';
shared superfile_individual_sponsor:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_sponsorship';
shared superfile_disciplinary:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Individual_Disciplinary_Actions';
shared superfile_regulatory:= Common_Prof_Lic_Mari.SourcesFolder + 'NMLS::Regulatory_Actions';



clear_super
	:=
		SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
									FileServices.ClearSuperFile(superfile_branch),
									FileServices.ClearSuperFile(superfile_branch_dba),
									FileServices.ClearSuperFile(superfile_branch_lic),
									FileServices.ClearSuperFile(superfile_company),
									FileServices.ClearSuperFile(superfile_company_lic),
									FileServices.ClearSuperFile(superfile_company_dba),
									FileServices.ClearSuperFile(superfile_individual),
									FileServices.ClearSuperFile(superfile_individual_lic),
									FileServices.ClearSuperFile(superfile_individual_loc),
									FileServices.ClearSuperFile(superfile_individual_aka),
									FileServices.ClearSuperFile(superfile_individual_reg),
									FileServices.ClearSuperFile(superfile_individual_reg_detail),
									FileServices.ClearSuperFile(superfile_disciplinary),
									FileServices.ClearSuperFile(superfile_regulatory),
		FileServices.FinishSuperFileTransaction()		
);


SprayFile(string filename, string newname, string delim) := FUNCTION
    
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																			filepath + filename, 
																			maxRecordSize,
																			If(delim = 'tab','\\t','\\,'),'\r\n','"',
																			group_name, 
																			destination + StringLib.StringToLowerCase(newname),
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 				
END;

	

//  Spray All Files
spray_all :=
	PARALLEL(
		SprayFile('Branch.csv', 'Branch_file','\\,'), 
		SprayFile('BranchLicense.csv','Branch_License','\\,'), 
		SprayFile('BranchTradeName.csv', 'Branch_DBA','\\,'), 
    SprayFile('Company.csv', 'Company_file','\\,'),
		SprayFile('CompanyLicense.csv', 'Company_License','\\,'),
		SprayFile('CompanyTradeName.csv','Company_DBA','\\,'), 
		SprayFile('Individual.csv', 'Individual_file','\\,'), 
    SprayFile('IndividualLicense.csv', 'Individual_License','\\,'),
		SprayFile('IndividualLocation.csv', 'Individual_Location','\\,'), 
		SprayFile('IndividualOtherNames.csv', 'Individual_AKA','\\,'),
		SprayFile('IndividualRegistration.csv', 'individual_registration','\\,'),
		SprayFile('IndividualRegistrationDetail.csv', 'individual_reg_detail','\\,'),
    SprayFile('IndividualSponsorship.csv', 'individual_sponsorship','\\,'),
		SprayFile('IndividualDisciplinaryActions.csv', 'Individual_Disciplinary_Actions','\\,'),
		SprayFile('RegulatoryActions.csv', 'Regulatory_Actions','\\,'),
		
	);





//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		FileServices.AddSuperFile(superfile_branch, destination + 'branch_file'),	
		FileServices.AddSuperFile(superfile_branch_dba, destination + 'branch_dba'),	
		FileServices.AddSuperFile(superfile_branch_lic, destination + 'branch_license'),	
		FileServices.AddSuperFile(superfile_company, destination + 'company_file'),	
		FileServices.AddSuperFile(superfile_company_dba, destination + 'company_dba'),	
		FileServices.AddSuperFile(superfile_company_lic, destination + 'company_license'),	
		FileServices.AddSuperFile(superfile_individual, destination + 'individual_file'),	
		FileServices.AddSuperFile(superfile_individual_lic, destination + 'individual_license'),	
		FileServices.AddSuperFile(superfile_individual_loc, destination + 'individual_location'),	
		FileServices.AddSuperFile(superfile_individual_aka, destination + 'individual_aka'),	
		FileServices.AddSuperFile(superfile_individual_reg, destination + 'individual_registration'),	
		FileServices.AddSuperFile(superfile_individual_reg_detail, destination + 'individual_reg_detail'),	
		FileServices.AddSuperFile(superfile_individual_sponsor, destination + 'individual_sponsorship'),	
		FileServices.AddSuperFile(superfile_disciplinary, destination + 'individual_disciplinary_actions'),	
		FileServices.AddSuperFile(superfile_regulatory, destination + 'Regulatory_Actions'),	
		
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
export NMLS_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,super_all);
																			

END;


