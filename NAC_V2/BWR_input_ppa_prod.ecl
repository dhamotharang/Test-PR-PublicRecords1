﻿//
//	Dataland PPA/RIN Scheduler
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
+'wuname := \'NAC2 PPA Contributory File Processor\';\n'
+'#WORKUNIT(\'name\', wuname);\n'
;


ip := _Control.IPAddress.bctlpedata10;
datadir := '/data/rin_ppa/';
opsdir := '/data/rin_ppa/data_ops/ncf2/';

files := STD.File.RemoteDirectory(ip, datadir, 'ncf2*.dat',true)(size>0);

nac_V2.rNAC2Config	tNAC2ConfigForceLower(nac_V2.dNAC2Config pInput)	:=
transform
	self.GroupID			:=	Std.Str.ToLowerCase(pInput.GroupID);
	self.ProductCode	:=	Std.Str.ToLowerCase(pInput.ProductCode);
	self.IsProd				:=	Std.Str.ToLowerCase(pInput.IsProd);
	self.IsEncrypted	:=	Std.Str.ToLowerCase(pInput.IsEncrypted);
	self					:=	pInput;
end;
dNAC2ConfigForceLower	:=	project(nac_V2.dNAC2Config, tNAC2ConfigForceLower(left));

sGroupId	:=	set(dNAC2ConfigForceLower, GroupID);
dOKFiles	:=	files(Name[1..4] in sGroupId);

r2 := RECORD
	string		datadir;
	string		lfn;
END;

x := project(dOKFiles, TRANSFORM(r2,
					parts := Std.Str.FindReplace(left.Name, '/', ' ');
					pieces := Std.Str.SplitWords(left.name, '/');
					cnt := Count(pieces);
					dir := Std.str.ExcludeLastWord(Std.str.ExcludeLastWord(parts));
					self.datadir := datadir+Std.Str.FindReplace(dir, ' ', '/');
					self.lfn := pieces[cnt];
					));

version := (string8)Std.Date.Today() : INDEPENDENT;
#WORKUNIT('protect',true);

// NOTE: System time is standard time + 5; therefore, Sunday at 10 PM is actually Monday 3 AM
#WORKUNIT('name', 'NAC2 PPA Contributory File Scheduler');
ThorName := 'thor400_44_sla_eclcc';		// for prod

lECL1 :=
envVars
+'nac_v2.ProcessContributoryFile(\'' + ip+'\',\''+ x[1].dataDir+'\',\''+ x[1].lfn+'\',\''+ opsdir+'\',\''+ version+'\');\n';
every_10_min := '*/10 0-23 * * *';
IF(exists(x), EVALUATE(
		_Control.fSubmitNewWorkunit(lECL1, ThorName )
		)) : WHEN(CRON(every_10_min));
