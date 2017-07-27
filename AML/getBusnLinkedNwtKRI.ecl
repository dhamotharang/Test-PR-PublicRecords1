IMPORT UT;

EXPORT getBusnLinkedNwtKRI(DATASET(Layouts.BusnExecsLayoutV2) LinkedIds) := FUNCTION


LinkedLayout := Record

	unsigned4		seq := 0;
	UNSIGNED3		historydate;
	unsigned6   	OrigBdid;
	unsigned6 		bdid := 0;
	unsigned6 		did := 0;
	unsigned6 		relatdid := 0;
	boolean     	LinkedBusn := false;
	boolean   		isExec := false;
  unsigned3 		RelatDegree := 0;
	string2   		st := '';

	unsigned2   ExecCurrIncarCnt := 0;
	unsigned2   ExecParoleCnt := 0;
	unsigned2 	 ExecFelony3yr := 0;
	boolean	   EasiTotCrime;
	boolean     CountyBordersForgeinJur;
	boolean     CountyborderOceanForgJur;
	boolean     CityBorderStation;
	boolean     CityFerryCrossing;
	boolean     CityRailStation;
	boolean     HIDTA;
	boolean     HIFCA;
	string4   	 HRBusnYPNAICS;
	string5     IndustryNAICS;
	string4   	 BusnRisklevel;

	unsigned2   ExecHRProfLicCnt;
	boolean     HighShellBusnScore;
	string30  	ShellBusnIndvalues;
	unsigned1  ShellIndCount;

	string2     LnkdBusnLegalKRI;
	string2     LnkdBusGeoKRI;
	string2     LnkdBusIndustryKRI;
	unsigned2 	 LinkBusnCnt := 0;

	string2     BusLinkedBusRisk;

END;

LinkedLayout  PreplegalCnt(LinkedIds le) := TRANSFORM

	self.seq     := le.seq;
	self.historydate := le.historydate;
	self.OrigBdid  := le.OrigBdid;
	self.bdid  := le.bdid;
	self.did  := le.did;
	self.LinkedBusn   := le.LinkedBusn;
	self.isExec   := le.isExec;
	self.relatdegree := le.relatdegree;
	self.ExecCurrIncarCnt := If(le.ExecCurrIncarCnt > 0, 1, 0);
	self.ExecParoleCnt := If(le.ExecParoleCnt > 0, 1, 0);
	self.ExecFelony3yr := If(le.ExecFelony3yr > 0, 1, 0);
	self.ExecHRProfLicCnt := if(le.ExecHRProfLic, 1, 0);
	
	self := [];
END;



SrtLinkedExec := sort(project(LinkedIds(relatdegree = AMLConstants.execsLnkdBusnDegree),PreplegalCnt(left)) ,seq,bdid,did);

 
LinkedLayout  RolllegalCnt(SrtLinkedExec le, SrtLinkedExec ri) := TRANSFORM

	self.seq     := le.seq;
	self.historydate := le.historydate;
	self.OrigBdid  := le.OrigBdid;
	self.bdid  := le.bdid;
	self.did  := le.did;
	self.LinkedBusn   := le.LinkedBusn;
	self.isExec   := le.isExec;
	self.relatdegree := le.relatdegree;
	self.ExecCurrIncarCnt := le.ExecCurrIncarCnt + ri.ExecCurrIncarCnt;
	self.ExecParoleCnt := le.ExecParoleCnt + ri.ExecParoleCnt;
	self.ExecFelony3yr := le.ExecFelony3yr + ri.ExecFelony3yr;
	self.ExecHRProfLicCnt := le.ExecHRProfLicCnt + ri.ExecHRProfLicCnt;
	// self.HighShellBusnScore := le.HighShellBusnScore or ri.HighShellBusnScore;
	self := [];
END;

	RolledexecCount := rollup(SrtLinkedExec, RolllegalCnt(left,right), seq, bdid);
	
	
LinkedBusn := sort(LinkedIds(relatdegree in [AMLConstants.LnkdBusnDegree,AMLConstants.relatedbusnDegree]), seq, bdid);	



LinkedLayout  PrepBusndetail(LinkedIds le) := TRANSFORM

	self.seq     := le.seq;
	self.historydate := le.historydate;
	self.OrigBdid  := le.OrigBdid;
	self.bdid  := le.bdid;
	self.did  := le.did;
	self.LinkedBusn   := le.LinkedBusn;
	self.isExec   := le.isExec;
	self.relatdegree := le.relatdegree;
	self.ShellBusnIndvalues  := le.ShellBusnIndvalues;
	self.ShellIndCount  := le.ShellIndCount;
	self.EasiTotCrime   := if((integer)le.EasiTotCrime >= 140, true, false);
	self.CountyBordersForgeinJur  := le.CountyBordersForgeinJur;
	self.CountyborderOceanForgJur  := le.CountyborderOceanForgJur;
	self.CityBorderStation  := le.CityBorderStation;
	self.CityFerryCrossing  := le.CityFerryCrossing;
	self.CityRailStation  := le.CityRailStation;
	self.HIDTA  := le.HIDTA;
	self.HIFCA  := LE.HIFCA;
	self.HRBusnYPNAICS  := le.HRBusnYPNAICS;
	self.IndustryNAICS  := le.IndustryNAICS;
	self.BusnRisklevel  := le.BusnRisklevel;
	self := le;
	self := [];
END;



SrtLinkedBdid := sort(project(LinkedIds(relatdegree in [AMLConstants.LnkdBusnDegree,AMLConstants.relatedbusnDegree]),PrepBusndetail(left)) ,seq, origbdid, bdid);

LinkedLayout  RollLnkBusnDtl(SrtLinkedBdid le, SrtLinkedBdid ri) := TRANSFORM

	self.seq     := le.seq;
	self.historydate := le.historydate;
	self.OrigBdid  := le.OrigBdid;
	self.bdid  := le.bdid;
	self.did  := le.did;
	self.LinkedBusn   := le.LinkedBusn;
	self.isExec   := le.isExec;
	self.relatdegree := le.relatdegree;
	self.ShellBusnIndvalues  := le.ShellBusnIndvalues;
	self.ShellIndCount  := max(le.ShellIndCount, ri.ShellIndCount);
	self.HighShellBusnScore := le.HighShellBusnScore or ri.HighShellBusnScore;
	self.EasiTotCrime   := le.EasiTotCrime or ri.EasiTotCrime;
	self.CountyBordersForgeinJur  := le.CountyBordersForgeinJur OR ri.CountyBordersForgeinJur;
	self.CountyborderOceanForgJur  := le.CountyborderOceanForgJur OR ri.CountyborderOceanForgJur;
	self.CityBorderStation  := le.CityBorderStation OR ri.CityBorderStation;
	self.CityFerryCrossing  := le.CityFerryCrossing or ri.CityFerryCrossing;
	self.CityRailStation  := le.CityRailStation  OR ri.CityRailStation;
	self.HIDTA  := le.HIDTA or ri.HIDTA;
	self.HIFCA  := LE.HIFCA or ri.HIFCA;

	self.HRBusnYPNAICS  := if(le.HRBusnYPNAICS = 'HIGH', le.HRBusnYPNAICS, ri.HRBusnYPNAICS);
	self.IndustryNAICS  := if(le.IndustryNAICS  in ['CIB', 'MSB'], le.IndustryNAICS, ri.IndustryNAICS);
	self.BusnRisklevel  := if(le.BusnRisklevel  = 'HIGH', le.BusnRisklevel, ri.BusnRisklevel);

	self := [];
END;

	RolledBusnCount := rollup(SrtLinkedBdid, RollLnkBusnDtl(left,right), seq, origbdid,bdid);

AddExecCounts := join(rolledbusncount, RolledexecCount,
											left.seq = right.seq and
											left.origbdid = right.origbdid and
											left.bdid = right.bdid,
											transform(LinkedLayout,
																self.ExecCurrIncarCnt  := right.ExecCurrIncarCnt,
																self.ExecParoleCnt := right.ExecParoleCnt,
																self.ExecFelony3yr := right.ExecFelony3yr,
																self.ExecHRProfLicCnt := right.ExecHRProfLicCnt,
																self := left),
																left outer);
															
																
LinkedLayout LnkKRI(AddExecCounts le) := TRANSFORM

	self.LnkdBusnLegalKRI   :=  map(
																	le.ExecCurrIncarCnt > 0            						 => '9',
																	le.ExecFelony3yr > 0 or le.ExecParoleCnt > 0   => '8',
																	'0');

	self.LnkdBusGeoKRI  := Map(
																	le.EasiTotCrime  and le.CountyBordersForgeinJur and
 						  										(le.HIDTA or le.HIFCA)								       										=> '9', 
																	le.EasiTotCrime and (le.CountyBordersForgeinJur or 
																	(le.CountyborderOceanForgJur and ~le.CountyBordersForgeinJur))  => '8',
																	le.st in AMLConstants.IslandState or le.CityBorderStation or
																	le.CityFerryCrossing  or le.CityRailStation   									=> '7',
																	'0');
	self.LnkdBusIndustryKRI  := Map(   
																	trim(le.IndustryNAICS) = 'CIB' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '9', 
																	trim(le.IndustryNAICS) = 'MSB' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '8',
																	'0');
	self.LinkBusnCnt := if(le.relatdegree in [AMLConstants.LnkdBusnDegree,AMLConstants.relatedbusnDegree], 1, 0);
	self := le;
END;

																
GetLinkedKRIs  := 	Project(AddExecCounts,  LnkKRI(left));

	
LinkedLayout  busnLnkNtwKRI(GetLinkedKRIs le) := TRANSFORM

	self.BusLinkedBusRisk := map(
																	le.LinkBusnCnt > 0 and le.LnkdBusnLegalKRI in ['8','9'] and
																	le.ExecHRProfLicCnt > 0	and le.LnkdBusIndustryKRI in ['8','9']						=>  '9',
																	le.LinkBusnCnt > 0 and le.LnkdBusnLegalKRI in ['8','9'] and
																	(le.ExecHRProfLicCnt > 0	or le.LnkdBusIndustryKRI in ['8','9'])        	=>  '8',
																	le.LinkBusnCnt > 0 and le.LnkdBusnLegalKRI in ['8','9']        					=>  '7',
																	le.LinkBusnCnt > 0 and le.ShellIndCount > 4         											=>  '6',
																	le.LinkBusnCnt > 0 and le.LnkdBusGeoKRI in ['7','8','9']  and
																	(le.ExecHRProfLicCnt > 0	or le.LnkdBusIndustryKRI in ['8','9'])  				=>  '5',
																	le.LinkBusnCnt > 0 and le.LnkdBusGeoKRI in ['7','8','9']       					=>  '4',
																	le.LinkBusnCnt > 0 and le.BusnRisklevel = 'HIGH'  and
																	le.ExecHRProfLicCnt > 0																										=>  '3',
																	le.LinkBusnCnt > 0     																										=>  '2',
																	le.LinkBusnCnt = 0            																						=>  '1',
																	 '0'),
																	
	self := le;
END;	
	
	
LinkbusnNetwKRI := project(GetLinkedKRIs, 	busnLnkNtwKRI(left));


LinkedLayout  rollKRIs(LinkbusnNetwKRI le,LinkbusnNetwKRI ri ) := TRANSFORM
   self.BusLinkedBusRisk :=  max(le.BusLinkedBusRisk, ri.BusLinkedBusRisk);
	 self.LinkBusnCnt := le.LinkBusnCnt + ri.LinkBusnCnt;
	 
	 self := le;
END;


FinalLnkBsnKRI := rollup(LinkbusnNetwKRI, left.seq = right.seq and left.origbdid = right.origbdid,
													rollKRIs(left,right));

	// output(LinkedIds, named('LinkedIds'));
	// output(SrtLinkedExec, named('SrtLinkedExec'));
	// output(RolledexecCount, named('RolledexecCount'));
	// output(LinkedBusn, named('LinkedBusn'));
	// output(SrtLinkedBdid, named('SrtLinkedBdid'));
	// output(RolledBusnCount, named('RolledBusnCount'));
	// output(AddExecCounts, named('AddExecCounts'));
	// output(GetLinkedKRIs, named('GetLinkedKRIs'));
	// output(LinkbusnNetwKRI, named('LinkbusnNetwKRI'));
	
	
	RETURN FinalLnkBsnKRI;
	
END;

