import versioncontrol,std,IDA;

EXPORT _BWR_Base_Change(boolean pUseProd=false,boolean pDaily=false):= MODULE

shared pversion:=IDA._Constants(pUseProd).monthlyversion;

shared DailyBaseBuilt:=IDA.Files().Basedaily.Built;
shared DailyBaseQA:=IDA.Files().Basedaily.QA;
shared FullDaily:= DailyBaseBuilt + DailyBaseQA;

shared MonthlyBuilt:=IDA.Files(pversion, pUseProd).base.built;
shared MonthlyFather:=FullDaily;

j := JOIN(MonthlyFather, MonthlyBuilt,
          LEFT.did=RIGHT.did AND LEFT.clientassigneduniquerecordid=RIGHT.clientassigneduniquerecordid,
					TRANSFORM(IDA.Layouts.Base,
					SELF:=LEFT;
	      ),RIGHT ONLY);
				
shared basechanges:=		j;		

shared ChangesCounts := if(nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_built))  <> 0 and 
                           nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_father)) <> 0
				          ,TABLE(basechanges,{did_total_cnt:= count(group,((did)=0 or (did)<>0)),
                                              did_equals_zero_cnt:= count(group,((did)=0)),
                                              did_not_equals_zero_cnt:= count(group,((did)<>0)),
                                              clientassigneduniquerecordid_total_cnt:= count(group,((clientassigneduniquerecordid)=0 or (clientassigneduniquerecordid)<>0)),
                                              clientassigneduniquerecordid_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)=0 )),
                                              clientassigneduniquerecordid_not_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)<>0 ))}));

VersionControl.macBuildNewLogicalFile( 
																				 IDA.Filenames(pversion,pUseProd).BaseChange.new	
																				,basechanges
																				,Build_Base_Change_File
																			 );

Base_Change :=
		sequential(Build_Base_Change_File
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.New2Built
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.Built2QA
);

Build_Change_Base := if(nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_built)) <> 0 and 
                        nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_father)) <> 0
											 ,Base_Change
											 ,output('MISSING MONTHLY FILE IN BUILT OR FATHER SUPERFILE'));	

export Build_Base_Change:=SEQUENTIAL(Build_Change_Base,output(ChangesCounts,NAMED('Change_Counts')));
end;