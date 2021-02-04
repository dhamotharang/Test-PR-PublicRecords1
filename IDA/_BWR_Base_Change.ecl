import versioncontrol,std;

EXPORT _BWR_Base_Change(boolean pUseProd=false,boolean pDaily=false):= MODULE

shared pversion:=IDA._Constants(pUseProd).monthlyversion;

shared MonthlyBuilt:=IDA.Files(pversion, pUseProd).base.built;
shared MonthlyQA:=IDA.Files(pversion, pUseProd).base.QA;

j := JOIN(MonthlyQA, MonthlyBuilt,
          LEFT.did=RIGHT.did AND LEFT.clientassigneduniquerecordid=RIGHT.clientassigneduniquerecordid,
					TRANSFORM(IDA.Layouts.Base,
					SELF:=LEFT;
	      ),RIGHT ONLY);

				
shared basechanges:=		j;				

	VersionControl.macBuildNewLogicalFile( 
																				 IDA.Filenames(pversion,pUseProd).BaseChange.new	
																				,basechanges
																				,Build_Base_Change_File
																			 );

export Base_Change :=
		sequential(Build_Base_Change_File
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.New2Built
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.Built2QA
);

export Build_Base_Change := if(nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_qa)) <> 0 and 
                               nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_built)) <> 0
											 ,Base_Change
											 ,output('MISSING MONTHLY FILE IN BUILT OR QA SUPERFILE'));	

end;