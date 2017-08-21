import Ingenix_natlprof,ut;

		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;
		
Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc Trans_rec(Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc l)	:=Transform 
self.SanctioningState			:= 	trimUpper(l.SanctioningState);
self.LossOfLicenseIndicator		:= 	trimUpper(l.LossOfLicenseIndicator);
self.SanctionFraudAbuseIndicator:= 	trimUpper(l.SanctionFraudAbuseIndicator);
self.SanctionType				:= 	trimUpper(l.SanctionType);
self.SanctionReason				:= 	trimUpper(l.SanctionReason);
self.SanctionTerms				:= 	trimUpper(l.SanctionTerms);
self.SanctionConditions 		:= 	trimUpper(l.SanctionConditions);
self.SanctionFines 				:= 	trimUpper(l.SanctionFines);
self.SanctioningBoardType 		:= 	trimUpper(l.SanctioningBoardType);
self.SanctioningSource 			:= 	trimUpper(l.SanctioningSource);
self.SanctionDate				:=	l.SanctionDate[7..10]	+	l.SanctionDate[1..2] +l.SanctionDate[4..5];
self.LicenseReinstatementDate	:=	l.LicenseReinstatementDate[7..10]	+	l.LicenseReinstatementDate[1..2]+	l.LicenseReinstatementDate[4..5];
self.LastUpdate					:=	l.LastUpdate[7..10]	+	l.LastUpdate[1..2]+	l.LastUpdate[4..5];
self							:=	l;
end;

File_in:= project(File_in_ProviderSanctions.Allsrc,Trans_Rec(left));

file_dist := distribute(File_in, hash(FILETYP,ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID,  -ProcessDate,local);

Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc  rollupXform(Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc l, Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc r) := transform
		self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
		self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
		self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
		self := l;
end;

rolledUpProviderSanctions := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,local);

CurrentProcessDate	:=	max(rolledUpProviderSanctions,processdate);

MedSanctionSet	:=	['EXCLUSION','SUSPENSION AND FINE','TERMINATION'];
FedSanctionSet	:=	['DEBARRED/EXCLUDED','DEBARRED/SUSPENDED','EXCLUDED/DELETED','EXCLUDED'];

Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc tPropagateReinstateDate(Ingenix_NatlProf.Layout_in_ProviderSanctions.raw_Allsrc l)	:=	transform
		DerivedYear										:=	if (l.ProcessDate[5..6]='12',(string)((integer)l.ProcessDate[1..4] + 1),l.ProcessDate[1..4]);
		DerivedMonth									:=	if (l.ProcessDate[5..6]='12','01',intformat((integer)l.ProcessDate[5..6] + 1,2,1));
		DerivedDate										:=	DerivedYear + DerivedMonth + '01'; 
		self.DerivedLicReinstateDate	:=	if(l.SanctioningBoardType='MEDICAID BOARD' and l.SanctioningSource='STATE MEDICAID BOARD' and l.LicenseReinstatementDate = '' and l.processDate<CurrentProcessDate,
																						DerivedDate,
																						if(l.SanctioningBoardType='MEDICAL BOARD' and l.SanctionType in MedSanctionSet and l.LicenseReinstatementDate = '' and l.processDate<CurrentProcessDate,
																								DerivedDate,
																								if(l.SanctioningBoardType='FEDERAL BOARDS' and l.SanctioningSource='OFFICE OF PERSONNEL MANAGEMENT' and l.LicenseReinstatementDate = '' and l.SanctioningState = 'DC' and l.processDate<CurrentProcessDate,
																										DerivedDate,
																										if(l.SanctioningBoardType='FEDERAL BOARDS' and l.SanctionType in FedSanctionSet and l.LicenseReinstatementDate = '' and l.SanctioningState = 'DC' and l.processDate<CurrentProcessDate,
																												derivedDate,
																												''
																											)
																									)
																							)
																				);
		self.LicenseReinstatementDate	:=	if (trim(l.LicenseReinstatementDate) = '' and trim(self.DerivedLicReinstateDate) <> '', trim(self.DerivedLicReinstateDate), trim(l.LicenseReinstatementDate));
		self													:=	l;
end;

export update_ProviderSanctions	:=	 project(rolledUpProviderSanctions, tPropagateReinstateDate(left));           