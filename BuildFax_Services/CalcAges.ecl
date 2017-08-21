import BuildFax,ut;

EmptyPermitDS       := DATASET([],Layout_BuildFax.Layout_Permit);
EmptyJurisdictionDS := DATASET([],Layout_BuildFax.Layout_Jurisdiction);
EXPORT CalcAges(DATASET(Layout_BuildFax.seq_input_rec) input, 
                DATASET(Layout_BuildFax.Layout_Permit) passedPermits = EmptyPermitDS,
								DATASET(Layout_BuildFax.Layout_Jurisdiction) passedJurisdictions = EmptyJurisdictionDS) := FUNCTION  

currdate := stringlib.GetDateYYYYMMDD();
isPassedPermits       := EXISTS(passedPermits);
isPassedJurisdictions := EXISTS(passedJurisdictions);

Properties 	:= GetPropertyRecs(input);
ids         := PROJECT(properties(rectype = constants.RecordTypes.Properties),
                       TRANSFORM(Layout_BuildFax.buildfax_key_rec,
											           self.sequence := left.input.internal_seq,
																 self.id       := left.property.id,
																 self := left));
addresses   := PROJECT(properties(rectype = constants.RecordTypes.Properties),
                       TRANSFORM(Layout_BuildFax.streetlookup_key_rec,
											           self.sequence := left.input.internal_seq,
                                 self.STREET   := IF(left.address.PREDIR=     '','',TRIM(left.address.PREDIR) + ' ') +
																                  IF(left.address.PRIM_NAME=  '','',TRIM(left.address.PRIM_NAME) + ' ') +
																                  IF(left.address.ADDR_SUFFIX='','',TRIM(left.address.ADDR_SUFFIX) + ' ') +
																                  TRIM(left.address.POSTDIR),
	                               self.state    := left.address.st,
																 self          := left.address));		
																 
RawPermits 	:= IF(isPassedPermits,passedPermits,KeyedJoins.GetPermitRecs(ids));
Permits   	:= JOIN( input,RawPermits, 
										 left.internal_seq = right.sequence,
										 Transform(Layout_BuildFax.layout_calcpermit, 
													    self.Permits      := right.permit,
                              self.yearbuilt    := (string4) left.yearbuilt;	
															self.sequence     := right.sequence;
															self.id           := right.permit.id;
															self 							:= left,
														  self := []));
									 
// Pull the Jurisdiction record for a given property
Jurisdictions := IF(isPassedJurisdictions,passedJurisdictions,GetJurisdictions(addresses));
minExclusions := DEDUP(SORT(Jurisdictions,sequence,-ExclusionMinDate),sequence);
PermitswJurisdictions := JOIN( Permits,minExclusions,
                               left.sequence = right.sequence,
															 TRANSFORM(Layout_BuildFax.layout_calcpermit,
                               self.coverage_start_date := right.ExclusionMinDate[1..4] + right.ExclusionMinDate[6..7] + right.ExclusionMinDate[9..10];
															 self := left),LEFT OUTER);


Layout_BuildFax.Layout_CalcAges CalculateAges(Layout_BuildFax.layout_calcpermit l) := TRANSFORM

isValidCovDate := l.coverage_start_date BETWEEN Constants.MinStartDate AND currdate;

getPDate (DATASET(BuildFax.Layout.Permit_slim) PermitDS) := 
          IF(isValidCovDate AND MAX(PermitDS,preferreddate) >= l.coverage_start_date,MAX(PermitDS,preferreddate),'');
self.roof.update_date         := getPDate(l.permits(check_roof=constants.Checked));
self.new_constr.update_date   := getPDate(l.permits(check_NewConstruction=constants.Checked));
self.rem.update_date          := getPDate(l.permits(check_AlterationRemodelAddition=constants.Checked));
self.bldg.update_date         := getPDate(l.permits(check_PermitTypeBuilding=constants.Checked));
self.elect.update_date        := getPDate(l.permits(check_PermitTypeElectrical=constants.Checked));
self.mech.update_date         := getPDate(l.permits(check_PermitTypeMechanical=constants.Checked));
self.plumb.update_date        := getPDate(l.permits(check_PermitTypePlumbing=constants.Checked));
self.other.update_date        := getPDate(l.permits(check_PermitTypeOther=constants.Checked));
self.pool.update_date         := getPDate(l.permits(check_Pool=constants.Checked));
self.demol.update_date        := getPDate(l.permits(check_Demolition =constants.Checked));
self.repair.update_date       := getPDate(l.permits(check_RepairReplace=constants.Checked));
self.wind_prevent.update_date := getPDate(l.permits(check_WindDamagePrevention=constants.Checked));
self.seismic.update_date      := getPDate(l.permits(check_SeismicDamagePrevention=constants.Checked));
self.solar.update_date        := getPDate(l.permits(check_SolarPower=constants.Checked));
self.sprinkler.update_date    := getPDate(l.permits(check_SprinklerSystems=constants.Checked));
self.firealrm.update_date     := getPDate(l.permits(check_FireAlarm=constants.Checked));
self.security.update_date     := getPDate(l.permits(check_SecuritySystems=constants.Checked));
self.change_use.update_date   := getPDate(l.permits(check_ChangeofUse=constants.Checked));
self.water.update_date        := getPDate(l.permits(check_WaterDamage=constants.Checked));
self.wind.update_date         := getPDate(l.permits(check_WindDamage=constants.Checked));
self.fire.update_date         := getPDate(l.permits(check_FireDamage=constants.Checked));
self.pest.update_date         := getPDate(l.permits(check_PestsRodents=constants.Checked));
self.natdisast.update_date    := getPDate(l.permits(check_NaturalDisasterDamage=constants.Checked));
self.mobilehm.update_date     := getPDate(l.permits(check_MobileHome=constants.Checked));
self.tank.update_date         := getPDate(l.permits(check_TankNoSeptic=constants.Checked));
self.new_comm.update_date     := getPDate(l.permits(check_NewCommercialConstruction=constants.Checked));
self.new_ind.update_date      := getPDate(l.permits(check_NewCommercialConstructionIndustrial=constants.Checked));
self.new_rtl.update_date      := getPDate(l.permits(check_NewCommercialConstructionRetail=constants.Checked));
self.new_wrhse.update_date    := getPDate(l.permits(check_NewCommercialConstructionWarehouse=constants.Checked));
self.new_office.update_date   := getPDate(l.permits(check_NewCommercialConstructionOffice=constants.Checked));
self.new_multi.update_date    := getPDate(l.permits(check_NewMultiFamilyConstruction=constants.Checked));

//Determine the not update since field for a given category
isValidYearBuilt         := l.YearBuilt BETWEEN constants.MinYearBuilt AND currdate[1..4];
iscovdatemax             := isValidCovDate AND (l.coverage_start_date[1..4] > l.YearBuilt OR l.YearBuilt > currdate[1..4]);
not_updated_since_date   := MAP(NOT isValidCovDate => '',
                                iscovdatemax       => l.coverage_start_date[1..4],
																isValidYearBuilt   => l.YearBuilt,
																'');
																
getNotUpdtDt (string8 pdate)       := IF((pdate = '' OR not_updated_since_date > pdate[1..4]) AND 
                                          isValidCovDate,not_updated_since_date,'');
self.roof.not_update_since         := getNotUpdtDt(self.roof.update_date);
self.new_constr.not_update_since   := getNotUpdtDt(self.new_constr.update_date);
self.rem.not_update_since          := getNotUpdtDt(self.rem.update_date);
self.bldg.not_update_since         := getNotUpdtDt(self.bldg.update_date);
self.elect.not_update_since        := getNotUpdtDt(self.elect.update_date);
self.mech.not_update_since         := getNotUpdtDt(self.mech.update_date);
self.plumb.not_update_since        := getNotUpdtDt(self.plumb.update_date);
self.other.not_update_since        := getNotUpdtDt(self.other.update_date);
self.pool.not_update_since         := getNotUpdtDt(self.pool.update_date);
self.demol.not_update_since        := getNotUpdtDt(self.demol.update_date);
self.repair.not_update_since       := getNotUpdtDt(self.repair.update_date);
self.wind_prevent.not_update_since := getNotUpdtDt(self.wind_prevent.update_date);
self.seismic.not_update_since      := getNotUpdtDt(self.seismic.update_date);
self.solar.not_update_since        := getNotUpdtDt(self.solar.update_date);
self.sprinkler.not_update_since    := getNotUpdtDt(self.sprinkler.update_date);
self.firealrm.not_update_since     := getNotUpdtDt(self.firealrm.update_date);
self.security.not_update_since     := getNotUpdtDt(self.security.update_date);
self.change_use.not_update_since   := getNotUpdtDt(self.change_use.update_date);
self.water.not_update_since        := getNotUpdtDt(self.water.update_date);
self.wind.not_update_since         := getNotUpdtDt(self.wind.update_date);
self.fire.not_update_since         := getNotUpdtDt(self.fire.update_date);
self.pest.not_update_since         := getNotUpdtDt(self.pest.update_date);
self.natdisast.not_update_since    := getNotUpdtDt(self.natdisast.update_date);
self.mobilehm.not_update_since     := getNotUpdtDt(self.mobilehm.update_date);
self.tank.not_update_since         := getNotUpdtDt(self.tank.update_date);
self.new_comm.not_update_since     := getNotUpdtDt(self.new_comm.update_date);
self.new_ind.not_update_since      := getNotUpdtDt(self.new_ind.update_date);
self.new_rtl.not_update_since      := getNotUpdtDt(self.new_rtl.update_date);
self.new_wrhse.not_update_since    := getNotUpdtDt(self.new_wrhse.update_date);
self.new_office.not_update_since   := getNotUpdtDt(self.new_office.update_date);
self.new_multi.not_update_since    := getNotUpdtDt(self.new_multi.update_date);

//Determine age for a given category
findage (string8 pdate) := TRIM(MAP(NOT isValidCovDate  => '', //Property not in jurisdiction
                                    pdate > constants.MinStartDate => (string) (decimal4_1) (ut.daysapart(currdate,pdate)/constants.DaysInYear),
															      iscovdatemax => '>' + (string) (((integer) (currdate[1..4])) - ((integer) (not_updated_since_date))),
								                    (string) (((integer)(currdate[1..4])) - ((integer) (not_updated_since_date)))));
self.roof.age             := findage(self.roof.update_date);
self.new_constr.age       := findage(self.new_constr.update_date);
self.rem.age              := findage(self.rem.update_date);
self.bldg.age             := findage(self.bldg.update_date);
self.elect.age            := findage(self.elect.update_date);
self.mech.age             := findage(self.mech.update_date);
self.plumb.age            := findage(self.plumb.update_date);
self.other.age            := findage(self.other.update_date);
self.pool.age             := findage(self.pool.update_date);
self.demol.age            := findage(self.demol.update_date);
self.repair.age           := findage(self.repair.update_date);
self.wind_prevent.age     := findage(self.wind_prevent.update_date);
self.seismic.age          := findage(self.seismic.update_date);
self.solar.age            := findage(self.solar.update_date);
self.sprinkler.age        := findage(self.sprinkler.update_date);
self.firealrm.age         := findage(self.firealrm.update_date);
self.security.age         := findage(self.security.update_date);
self.change_use.age       := findage(self.change_use.update_date);
self.water.age            := findage(self.water.update_date);
self.wind.age             := findage(self.wind.update_date);
self.fire.age             := findage(self.fire.update_date);
self.pest.age             := findage(self.pest.update_date);
self.natdisast.age        := findage(self.natdisast.update_date);
self.mobilehm.age         := findage(self.mobilehm.update_date);
self.tank.age             := findage(self.tank.update_date);
self.new_comm.age         := findage(self.new_comm.update_date);
self.new_ind.age          := findage(self.new_ind.update_date);
self.new_rtl.age          := findage(self.new_rtl.update_date);
self.new_wrhse.age        := findage(self.new_wrhse.update_date);
self.new_office.age       := findage(self.new_office.update_date);
self.new_multi.age        := findage(self.new_multi.update_date);
self := l;
self := [];
end;

RETURN PROJECT(PermitswJurisdictions,CalculateAges(left));
END;



