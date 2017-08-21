import Orbit3SOA,std;

EXPORT RuleSync(String pProfileName) := function
	SuperFileName:='~thor_data400::Scrubs::ProfileStorage';
	StorageFileName:='~thor_data400::Scrubs::'+pProfileName+'::ProfileStorage';
	
	GetProfile:= Orbit3SOA.Orbit3GetProfileRules('ScrubsAlerts', pProfileName);
	DefaultPass:=GetProfile(Name='Default')[1].PassPercentage;
	DefaultConversion	:=	project(GetProfile,Transform(Scrubs.Layouts.OrbitLayoutStep1,
																			self.passpercentage	:=	if(left.passpercentage = '',DefaultPass,left.passpercentage);
																			self := left;));
	RemoveBlankRules	:=	DefaultConversion(passpercentage<>'');
	
	PreviousRules			:=	dataset(StorageFileName,Scrubs.Layouts.ProfileRule_Rec,thor,opt);
	
	CombineRules			:=	join(PreviousRules,RemoveBlankRules,left.Name=right.Name,transform(Scrubs.Layouts.ProfileRule_Rec,Self.passpercentagetop:=(decimal5_2)Right.PassPercentage;Self:=Right;Self:=Left;));
	
	ProjectedOrbit		:=	project(RemoveBlankRules,transform(Scrubs.Layouts.ProfileRule_Rec,Self.PassPercentageBottom:=0.0;Self.PassPercentageTop:=(decimal5_2)Left.PassPercentage;Self:=Left;));
	
	NewFile						:=	if(exists(CombineRules),CombineRules,ProjectedOrbit);
	
	return sequential(
												output(NewFile,,StorageFileName+'_temp',thor,overwrite),
												nothor(global(sequential(if(std.file.FileExists(StorageFileName),
																sequential(STD.File.StartSuperFileTransaction(),
																STD.File.RemoveSuperFile(SuperFileName,StorageFileName,true),
																STD.File.FinishSuperFileTransaction())),
												fileservices.deleteLogicalFile(StorageFileName),
												fileservices.renameLogicalFile(StorageFileName+'_temp',StorageFileName),
												STD.File.StartSuperFileTransaction(),
												STD.File.AddSuperFile(SuperFileName,StorageFileName),
												STD.File.FinishSuperFileTransaction()))));
end;