/*2012-09-18T13:50:18Z (gwhitaker)
C:\Documents and Settings\gwhitaker\Application Data\HPCC Systems\eclide\gwhitaker\dataland_dev_EOSS_proxy\SmartRollup\fn_smart_OtherBusAssoc\2012-09-18T13_50_18Z.ecl
*/
/*2012-08-09T15:06:06Z (gwhitaker)
C:\Documents and Settings\gwhitaker\Application Data\LexisNexis\querybuilder\gwhitaker\Dataland\SmartRollup\fn_smart_OtherBusAssoc\2012-08-09T15_06_06Z.ecl
*/
// ***  I M P O R T A N T  ***
//  Paramters are UNROLLED dataset of Property, UCC, Liens, Bankruptcy, MVR, Watercraft, Aircraft Attorney-Client
//  along with the subjects DID
//
import iesp, PersonReports;

export fn_smart_OtherBusAssoc( dataset(iesp.property.t_PropertyReport2Record) inProp,
														   dataset(iesp.ucc.t_UCCReport2Record) inUCC,  
													     dataset(iesp.lienjudgement.t_LienJudgmentReportRecord) inLien,  
												       dataset(iesp.bankruptcy.t_BankruptcyReport2Record) inBankruptcy,
														   dataset(iesp.motorvehicle.t_MotorVehicleReport2Record) inVehicle,  
													     dataset(iesp.watercraft.t_WaterCraftReport2Record) inWatercraft,  
														   dataset(iesp.faaaircraft.t_aircraftReportRecord) inAircraft, 														  
                               unsigned6 subjectDID) 
						 := FUNCTION
					 
  outlayout := iesp.smartlinxreport.t_SLROtherAssociatedBusinesses;
													
  bkAttorney  := inBankruptcy.attorneys(businessId != '');
  
  outlayout normItBkAttorney(bkAttorney l, iesp.bankruptcy.t_BankruptcySearch2Name r) := transform
		 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.Bankruptcy]], iesp.share.t_StringArrayItem);
		 self.Address := l.addresses[1];
		 self.Companyname := r.companyName;
		 self.BusinessID := l.businessID;
		 self.BusinessIDs.proxid := l.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := l.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := l.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := l.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := l.BusinessIDs.dotid;
		 self.BusinessIDs.empid := l.BusinessIDs.empid;
		 self.BusinessIDs.powid := l.BusinessIDs.powid;
		 self := [];
   end;
	
	BkNormAttorney := normalize(bkAttorney, left.names, normitBkAttorney(left, right));
	BKAttorneyData := BkNormAttorney(trim(companyName) != '');		
//=========================================================================================
  bkDebtor := inBankruptcy.Debtors(businessId != '');
  outlayout normItBkDebtor(bkDebtor l, iesp.bankruptcy.t_BankruptcySearch2Name r) := transform
		 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.Bankruptcy]], iesp.share.t_StringArrayItem);
		 self.Address := l.addresses[1];
		 self.Companyname := r.companyName;
		 self.BusinessID := l.businessID;
		 self.BusinessIDs.proxid := l.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := l.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := l.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := l.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := l.BusinessIDs.dotid;
		 self.BusinessIDs.empid := l.BusinessIDs.empid;
		 self.BusinessIDs.powid := l.BusinessIDs.powid;
		 self := [];
   end;
  BkNormDebtor := normalize(bkDebtor, left.names, normitBkDebtor(left, right));
	BKDebtorData := BkNormDebtor(trim(companyName) != '');		
//=========================================================================================
  LienDebtor := inLien.Debtors;
  outlayout normItLienDebtor(LienDebtor l, iesp.lienjudgement.t_LienJudgmentParty r) := transform
	   Self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.JudgementLien]], iesp.share.t_StringArrayItem);
		 self.Address := project(l.address, transform(iesp.share.T_address,
												                   self := left)); 
		 self.Companyname := r.companyName;
		 self.BusinessID := r.businessID;
		 self.BusinessIDs.proxid := r.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := r.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := r.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := r.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := r.BusinessIDs.dotid;
		 self.BusinessIDs.empid := r.BusinessIDs.empid;
		 self.BusinessIDs.powid := r.BusinessIDs.powid;
		 self := [];
   end;
  LienNormDebtor := normalize(LienDebtor, left.ParsedParties, normitLienDebtor(left, right));
	LienDebtorData := LienNormDebtor(trim(companyName) != '' and businessid != '');			
//=========================================================================================
  LienCreditor := inLien.Creditors;
  outlayout normItLienCreditor(LienCreditor l, iesp.lienjudgement.t_LienJudgmentParty r) := transform
	   Self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.JudgementLien]], iesp.share.t_StringArrayItem);
		 self.Address := project(l.address, transform(iesp.share.T_address,
												                   self := left)); 
		 self.Companyname := r.companyName;
		 self.BusinessID := r.businessID;
		 self.BusinessIDs.proxid := r.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := r.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := r.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := r.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := r.BusinessIDs.dotid;
		 self.BusinessIDs.empid := r.BusinessIDs.empid;
		 self.BusinessIDs.powid := r.BusinessIDs.powid;
		 self := [];
   end;
  LienNormCreditor := normalize(LienCreditor, left.ParsedParties, normitLienCreditor(left, right));
	LienCreditorData := LienNormCreditor(trim(companyName) != '' and businessid != '');			
//=========================================================================================
  UccDebtor := inucc.debtors2;
  outlayout normItUccDebtor(UccDebtor l, iesp.ucc.t_UCCParsedParty r) := transform
	   self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.UCC]], iesp.Share.t_stringArrayItem);
		 self.Address := l.addresses[1];
		 self.Companyname := r.companyName;
		 self.BusinessID := r.businessID;
		 self.BusinessIDs.proxid := r.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := r.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := r.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := r.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := r.BusinessIDs.dotid;
		 self.BusinessIDs.empid := r.BusinessIDs.empid;
		 self.BusinessIDs.powid := r.BusinessIDs.powid;
		 self := [];
   end;
  UccNormDebtor := normalize(UccDebtor, left.ParsedParties, normitUccDebtor(left, right));
	UccDebtorData := UccNormDebtor(trim(companyName) != '' and businessid != '');		
//=========================================================================================
 	UccSecured := inucc.Secureds;
  outlayout normItUccSecured(UccSecured l, iesp.ucc.t_UCCParsedParty r) := transform
	   self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.UCC]], iesp.Share.t_stringArrayItem);
		 self.Address := l.addresses[1];
		 self.Companyname := r.companyName;
		 self.BusinessID := r.businessID;
		 self.BusinessIDs.proxid := r.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := r.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := r.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := r.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := r.BusinessIDs.dotid;
		 self.BusinessIDs.empid := r.BusinessIDs.empid;
		 self.BusinessIDs.powid := r.BusinessIDs.powid;
		 self := [];
   end;
  UccNormSecured := normalize(UccSecured, left.ParsedParties, normitUccSecured(left, right));
	UccSecuredData := UccNormSecured(trim(companyName) != '' and businessid != '');												 
 
  WCReportData := project(inWatercraft.owners(companyName != ''),
	                   transform( outlayout,
                       self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_stringArrayItem);													 										   
											 self.CompanyName := left.CompanyName;
											 self.address := left.address;
											 self := []));
																										 
	faaReportData := project(InAircraft,
	                   transform(outLayout,
											 Self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_StringArrayItem);
											 self.Name  := if (left.registrant.companyName != '', left.registrant.Name);
											 self.Address := if (left.registrant.companyName != '',left.registrant.address);
											 self.CompanyName := if (left.registrant.companyName != '', left.registrant.CompanyName, '');
											 self.BusinessID := if (left.registrant.companyName != '', left.registrant.businessID,'');
											 self.BusinessIDs.proxid := if (left.registrant.companyName != '', left.BusinessIDs.proxid,0);
											 self.BusinessIDs.ultid := if (left.registrant.companyName != '', left.BusinessIDs.ultid,0);
											 self.BusinessIDs.orgid := if (left.registrant.companyName != '', left.BusinessIDs.orgid,0);
											 self.BusinessIDs.seleid := if (left.registrant.companyName != '', left.BusinessIDs.seleid,0);
											 self.BusinessIDs.dotid := if (left.registrant.companyName != '', left.BusinessIDs.dotid,0);
											 self.BusinessIDs.empid := if (left.registrant.companyName != '', left.BusinessIDs.empid,0);
											 self.BusinessIDs.powid := if (left.registrant.companyName != '', left.BusinessIDs.powid,0);
											 self := []))(companyName != '');

  VehicleReportOwner := project(inVehicle.Owners(OwnerInfo.BusinessName != ''), 
	                        transform(iesp.motorvehicle.t_MotorVehicleReportOwner,												
	                        self.OwnerInfo := left.OwnerInfo; 
												  self := []));
													
  VehicleReportData := project(VehicleReportOwner,
												 transform(outLayout,
													 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_StringArrayItem);													
													 self.address :=  left.OwnerInfo.Address;
													 self.companyName := left.OwnerInfo.BusinessName; 
													 self.BusinessID := left.OwnerInfo.businessID;
													 self.BusinessIDs.proxid := left.OwnerInfo.BusinessIDs.proxid;
													 self.BusinessIDs.ultid := left.OwnerInfo.BusinessIDs.ultid;
													 self.BusinessIDs.orgid := left.OwnerInfo.BusinessIDs.orgid;
													 self.BusinessIDs.seleid := left.OwnerInfo.BusinessIDs.seleid;
													 self.BusinessIDs.dotid := left.OwnerInfo.BusinessIDs.dotid;
													 self.BusinessIDs.empid := left.OwnerInfo.BusinessIDs.empid;
													 self.BusinessIDs.powid := left.OwnerInfo.BusinessIDs.powid;
													 self := []));				
  VehicleReportRegistrant := project(inVehicle.registrants(RegistrantInfo.BusinessName != ''), 
	                             transform(iesp.motorvehicle.t_MotorVehicleReportRegistrant,												
	                               self.RegistrantInfo := left.RegistrantInfo; 	
																 self := []));
													
  VehicleReportData2 := project(VehicleReportRegistrant,
												 transform(outLayout,
													 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_StringArrayItem);													
													 self.address :=  left.RegistrantInfo.Address;
													 self.companyName := left.RegistrantInfo.BusinessName; 
													 self.BusinessID := left.RegistrantInfo.businessID;
													 self.BusinessIDs.proxid := left.RegistrantInfo.BusinessIDs.proxid;
													 self.BusinessIDs.ultid := left.RegistrantInfo.BusinessIDs.ultid;
													 self.BusinessIDs.orgid := left.RegistrantInfo.BusinessIDs.orgid;
													 self.BusinessIDs.seleid := left.RegistrantInfo.BusinessIDs.seleid;
													 self.BusinessIDs.dotid := left.RegistrantInfo.BusinessIDs.dotid;
													 self.BusinessIDs.empid := left.RegistrantInfo.BusinessIDs.empid;
													 self.BusinessIDs.powid := left.RegistrantInfo.BusinessIDs.powid;
													 self := []));														 
	VehicleReportLienHolder := project(inVehicle.LienHolders(LienHolderInfo.BusinessName != ''), 
	                             transform(iesp.motorvehicle.t_MotorVehicleReportLienHolder,												
	                               self.LienHolderInfo := left.LienHolderInfo; 											
												         self := []));
													
  VehicleReportData3 := project(VehicleReportLienHolder,
												 transform(outLayout,
													 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.OtherProp]], iesp.share.t_StringArrayItem);													
													 self.address :=  left.LienHolderInfo.Address;
													 self.companyName := left.LienHolderInfo.BusinessName; 
													 self.BusinessID := left.LienHolderInfo.businessID;
													 self.BusinessIDs.proxid := left.LienHolderInfo.businessIDs.proxid;
													 self.BusinessIDs.ultid := left.LienHolderInfo.businessIDs.ultid;
													 self.BusinessIDs.orgid := left.LienHolderInfo.businessIDs.orgid;
													 self.BusinessIDs.seleid := left.LienHolderInfo.businessIDs.seleid;
													 self.BusinessIDs.dotid := left.LienHolderInfo.businessIDs.dotid;
													 self.BusinessIDs.empid := left.LienHolderInfo.businessIDs.empid;
													 self.BusinessIDs.powid := left.LienHolderInfo.businessIDs.powid;
													 self := []));														 
										 									 
  PropertyInfo := project(inProp.entities,
	                   transform(iesp.property.t_Property2Entity,
										   self.Address := if (exists(left.names(businessID != '')) OR exists(left.names(businessIDs.Ultid != 0)) OR exists(left.names(CompanyName  != '')), left.address);
											 self.Names := if (exists(left.names(businessID != '')) OR exists(left.names(businessIDs.Ultid != 0)) OR exists(left.names(CompanyName  != '')), left.names);
											 self := [];
										 ));
 
	 outlayout normItProp(propertyInfo l, iesp.property.t_Property2Name r) := transform
		 self.Roles := dataset([PersonReports.Constants.rolesSet[PersonReports.Constants.RealEstate]], iesp.share.t_StringArrayItem);	
		 self.Address := l.Address;
		 self.Companyname := r.companyName;
		 self.BusinessID := r.businessID;
		 self.BusinessIDs.proxid := r.BusinessIDs.proxid;
		 self.BusinessIDs.ultid := r.BusinessIDs.ultid;
		 self.BusinessIDs.orgid := r.BusinessIDs.orgid;
		 self.BusinessIDs.seleid := r.BusinessIDs.seleid;
		 self.BusinessIDs.dotid := r.BusinessIDs.dotid;
		 self.BusinessIDs.empid := r.BusinessIDs.empid;
		 self.BusinessIDs.powid := r.BusinessIDs.powid;
		 self := [];
   end;
   normProp := normalize(propertyInfo, left.names, normItProp(left, right))		;		
   PropertyReportData := normProp(trim(CompanyName) <> '');
	 			
  outres := faaReportdata + WCReportData + BKAttorneyData + BkDebtorData + lienDebtorData + 
	          LienCreditorData + VehicleReportData +  VehicleReportData2 + VehicleReportData3 +
					  UccDebtorData + uccSecuredData + propertyReportData;
 				
	outResRolled := rollup(sort(outres, CompanyName, address,  record),
	                  left.CompanyName = right.Companyname AND 										
										left.address.city = right.address.city and
										left.address.state = right.address.state AND
                    left.address.zip5 = right.address.zip5 AND
									  left.Roles[1].value = right.Roles[1].value,
											transform(recordof(left),
											  self := left,
												self := right));
												
  // setup DS's for left only join below												
  outResRolledSlim := outResRolled(Address.City <> '' and address.State <> '' and address.zip5 <> '');
	outResRolledBlankAddr := outResRolled(Address.city = '' and address.state = '' and address.zip5 = '');
	// this is done to remove recs that had same company name and role but did not have
	// an address.  This join finds the particular recs that have just a company name without an address
	// that are not already in the main set of recs with company names and addresses and then
	// adds them back in a few lines down and sorts them.
	outResRolledNoAddress := join(outResRolledBlankAddr, outResRolledSlim,
	                              left.companyName = right.CompanyName and
																left.Roles[1].value = right.Roles[1].value,
																transform(left), left only);
	
	outcombined := OutResRolledSlim + outResRolledNoAddress;
	// Call function to dedup on linkids and name/address
	outResClean := SmartRollup.Functions.dedup_businesses(outcombined,DateLastSeen);
	outResFinal := sort(outResClean,
	                    if (address.city <> '',0, 1), Roles[1].value, 
										  companyName, record);
	
  RETURN outResFinal;
END;