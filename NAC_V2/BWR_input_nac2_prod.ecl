#WORKUNIT('name', 'NAC2 Contributory File Scheduler');
#WORKUNIT('protect',true);

IMPORT _Control, STD;

//
//	PROD NAC2 Scheduler
//
envVars :=
 '#WORKUNIT(\'protect\',true);\n'
+'#WORKUNIT(\'priority\',\'high\');\n'
+'#WORKUNIT(\'priority\',11);\n'
+'#OPTION(\'AllowedClusters\',\'thor400_44_sla_eclcc,thor400_44_eclcc\');\n'
+'#OPTION(\'AllowAutoQueueSwitch\',\'1\');\n'
+'#OPTION(\'MultiplePersistInstances\',\'false\');\n'
+'#STORED (\'_Validate_Year_Range_Low\', \'1800\');\n'
+'#STORED (\'_Validate_Year_Range_high\', ((string8)Std.Date.Today())[1..4]);\n'
+'wuname := \'NAC2 NCF2 Contributory File Processor\';\n'
+'#WORKUNIT(\'name\', wuname);\n';


ip := _Control.IPAddress.bctlpedata11;
datadir := '/data/hds_180/nac2/ncf2/';
opsdir := '/data/hds_180/nac2/ncf2/';

files := STD.File.RemoteDirectory(ip, datadir+'incoming', 'ncf2*.dat',true); 

nac_V2.rNAC2Config	tNAC2ConfigForceLower(nac_V2.dNAC2Config pInput) :=
TRANSFORM
	SELF.GroupID		:=	Std.Str.ToLowerCase(pInput.GroupID);
	SELF.ProductCode	:=	Std.Str.ToLowerCase(pInput.ProductCode);
	SELF.IsProd			:=	Std.Str.ToLowerCase(pInput.IsProd);
	SELF.IsEncrypted	:=	Std.Str.ToLowerCase(pInput.IsEncrypted);
	SELF				:=	pInput;
END;
dNAC2ConfigForceLower	:=	PROJECT(nac_V2.dNAC2Config, tNAC2ConfigForceLower(left));

sGroupId :=	SET(dNAC2ConfigForceLower(ProductCode='n' AND IsProd='1'), GroupID);
dOKFiles :=	files(Name[6..9] in sGroupId);  //  ex.  ncf2_fl99_20190627_142000.dat

r2 := RECORD
	STRING		datadir;
	STRING		lfn;
END;

x := PROJECT(dOKFiles, TRANSFORM(r2,
					parts := Std.Str.FindReplace(left.Name, '/', ' ');
					pieces := Std.Str.SplitWords(left.name, '/');
					cnt := COUNT(pieces);
					dir := Std.str.ExcludeLastWord(Std.str.ExcludeLastWord(parts));
					SELF.datadir := datadir+Std.Str.FindReplace(dir, ' ', '/');
					SELF.lfn := pieces[cnt];
					));

version := (string8)Std.Date.Today() : INDEPENDENT;

// NOTE: System time is standard time + 5; therefore, Sunday at 10 PM is actually Monday 3 AM
ThorName := 'thor400_44_sla_eclcc';		// for prod

lECL1 :=
envVars
+'nac_v2.ProcessContributoryFile(\'' + ip + '\',\''+ x[1].dataDir+'\',\''+ x[1].lfn+'\',\''+ opsdir + '\',\''+ version+'\');\n';
every_10_min := '*/10 0-23 * * *';

NOC_MSG := '** NOC **\n\n';

IF(EXISTS(x), EVALUATE(
		_Control.fSubmitNewWorkunit(lECL1, ThorName)
		)) : WHEN(CRON(every_10_min))
	,FAILURE(STD.System.Email.SendEmail('nacprojectsupport@lnssi.com,ris-glonoc@risk.lexisnexisrisk.com'
																			,'NAC2 Contributory File Scheduler failure'
																			,NOC_MSG)
															);

