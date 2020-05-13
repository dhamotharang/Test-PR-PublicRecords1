EXPORT Proc_Build_Override_Orphans(string filedate) := function
import STD,overrides,PromoteSupers,FCRA,ut;

OverrideBase := overrides.GetOverrideBase;

output(table(OverrideBase,{Datagroup,cnt:=count(group)},Datagroup,merge),named('DsLexid_override_base'));

//hit ConsumerDisclosure.FCRADataService to append compliance flags and get orphans candidates 

Overrides.Mac_GetOverrides(OverrideBase, dsout);

dsOut_candidates:=dsOut(IsOverride_ and ~IsOverwritten_): persist('~thor_data400::persist::override_orphan_candidates');

output(table(dsOut_candidates,{Datagroup,cnt:=count(group)},Datagroup,merge),named('orphans_FCRA_service'));
//output(table(dsOut_candidates((unsigned)RecID_ = 0),{Datagroup,cnt:=count(group)},Datagroup,merge),named('orphans_blank_reCID_FCRA_service'));

j_base :=join(OverrideBase,dsOut_candidates,
		left.RecID=right.RecID_
		and  (unsigned)left.DID=(unsigned)right.Lexid
		and  left.Datagroup=right.Datagroup
    ,transform({boolean Orphan,OverrideBase},
			self.Orphan	:=(unsigned)right.Lexid > 0;
			self:=left,
			self:=right	
			));

Orphans:= project(j_base(Orphan),transform(overrides.File_Override_Orphans.orphan_rec,
self.Datagroup	:=	overrides.constants.GetDsType(left.datagroup), self := left));
output(table(Orphans,{Datagroup,cnt:=count(group)},Datagroup,merge),named('orphans_override_base'));

build_orphans := OUTPUT(Orphans,, '~thor_data400::lookup::override::' + FileDate + '::orphans', overwrite, __compressed__);

build_stats := overrides.GrowthCheck(filedate).BuildStats;

add_orphans := if(overrides.GrowthCheck(filedate).StatsAlerts = false, 
  FILESERVICES.PROMOTESUPERFILELIST(['~thor_data400::lookup::override::orphans','~thor_data400::lookup::override::orphans::father','~thor_data400::lookup::override::orphans::grandfather'],
	'~thor_data400::lookup::override::' + FileDate + '::orphans', true), output('check Alerts and keep previous version in orphan file'));

return sequential(build_orphans);

end;


