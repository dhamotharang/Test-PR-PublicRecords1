import versioncontrol,std,IDA;

EXPORT _BWR_Base_Change(boolean pUseProd=false,boolean pDaily=false):= MODULE

shared pversion:=IDA._Constants(pUseProd).monthlyversion;

shared DailyBaseBuilt:=IDA.Files().Basedaily.Built;
shared DailyBaseQA:=if(nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplateDaily_qa)) <> 0,IDA.Files().Basedaily.QA);
shared FullDailyBase:= DailyBaseBuilt + DailyBaseQA;
OUTPUT(choosen(FullDailyBase,1000),NAMED('DailyBaseOutput'));

DailyBaseStats :=TABLE(FullDailyBase,{daily_base_did_total_cnt:= count(group,((did)=0 or (did)<>0)),
                                    daily_base_did_equals_zero_cnt:= count(group,((did)=0)),
                                    daily_base_did_not_equals_zero_cnt:= count(group,((did)<>0)),
                                    daily_base_clientassigneduniquerecordid_total_cnt:= count(group,((clientassigneduniquerecordid)=0 or (clientassigneduniquerecordid)<>0)),
                                    daily_base_clientassigneduniquerecordid_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)=0 )),
                                    daily_base_clientassigneduniquerecordid_not_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)<>0 ))});
output(DailyBaseStats,NAMED('DailyBaseStats'));

shared MonthlyBase:=IDA.Files(pversion, pUseProd).base.built;
OUTPUT(choosen(MonthlyBase,1000),NAMED('MonthlyBaseOutput'));

MonthlyBaseStats :=TABLE(MonthlyBase,{monthly_base_did_total_cnt:= count(group,((did)=0 or (did)<>0)),
                                    monthly_base_did_equals_zero_cnt:= count(group,((did)=0)),
                                    monthly_base_did_not_equals_zero_cnt:= count(group,((did)<>0)),
                                    monthly_base_clientassigneduniquerecordid_total_cnt:= count(group,((clientassigneduniquerecordid)=0 or (clientassigneduniquerecordid)<>0)),
                                    monthly_base_clientassigneduniquerecordid_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)=0 )),
                                    monthly_base_clientassigneduniquerecordid_not_equals_zero_cnt:= count(group,( (clientassigneduniquerecordid)<>0 ))});
output(MonthlyBaseStats,NAMED('MonthlyBaseStats'));

j := JOIN(FullDailyBase,MonthlyBase, LEFT.did=RIGHT.did AND LEFT.clientassigneduniquerecordid=RIGHT.clientassigneduniquerecordid,RIGHT ONLY);
output(count(j),NAMED('Changed_Records_Count'));
srt:=sort(j,orig_first_name);
output(srt,all,NAMED('Changed_Records'));
				
shared basechanges:=		srt;	

BaseChangesDesprayTable:=TABLE(basechanges,{did,clientassigneduniquerecordid,orig_filecategory});

ChangeOut:=OUTPUT(BaseChangesDesprayTable,,IDA.Filenames(pversion,pUseProd).BaseChange.new,CSV(HEADING(SINGLE),SEPARATOR('|')),COMPRESSED);

Base_Change :=
		sequential(ChangeOut
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.New2Built
							,IDA.Promote(pversion,pUseProd,pDaily).BuildBaseChangefiles.Built2QA
);

Build_Change_Base := if(nothor(FileServices.GetSuperFileSubCount(IDA.Filenames(pversion, pUseProd).lBaseTemplate_built)) <> 0 and 
                                             exists(FullDailyBase)
											 ,Base_Change
											 ,output('MISSING MONTHLY BASE FILE OR DAILY BASE FILES'));	

DesprayBaseChange:=STD.File.DeSpray('~thor_data400::base::change::ida::built',IDA._Constants(pUseProd).Source_IP,IDA._Constants(pUseProd).despray_path + IDA._Constants(pUseProd).despray_change_filename);

export Build_Base_Change:=SEQUENTIAL(Build_Change_Base,DesprayBaseChange);
end;