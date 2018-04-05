Import prte2_votersv2, VotersV2, FCRA, ut, PRTE_CSV, VersionControl, _Control,codes, mdr;

EXPORT files := module

EXPORT VotersV2_IN := DATASET(constants.In_VotersV2, Layouts.Base_ext, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')) );

EXPORT VotersV2_Base_Ext := DATASET(constants.Base_VotersV2, Layouts.Base_ext, FLAT );

EXPORT VotersV2_Base := Project(VotersV2_Base_Ext, Layouts.Base_Layout);

Export DS_Voters_Hist := DATASET([ ],layouts.Layout_VoteHistory);

Export DS_Voters_Auto_keys := project(VotersV2_Base,
Transform(Layouts.Layout_Voters_Autokeys,
SELF:=Left;
));

EXPORT DS_VotersV2_vtid	:=	Project(VotersV2_Base,
Transform(Layouts.Layout_vtid,
self:=LEFT;
self := []; 
));

EXPORT BaseNew:=	Project(VotersV2_Base,
Transform(Layouts.Layout_Voters_base_new,
SELF.name_suffix_in:=Left.name_suffix;
SELF.work_phone:=Left.phone;
SELF.precinct:=Left.precinct1;
SELF.ward1:=Left.ward;
SELF.citycountycouncil:=left.citycouncildist;
SELF.countycommis:=Left.countycommdist;
SELF:=Left;
self := []; 
));

EXPORT HeaderSource:=              Project(VotersV2_Base,
Transform(Layouts.HeaderLayout2,
Self.uid:= 0;
Self.src := mdr.sourceTools.src_Voters_v2;
Self := left;
self := []; 
));

End;
 
 
 
 