import doxie,ut, header_services, Data_Services, PRTE2_Business_Header;

//add supplemental data

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
record
string15 group_id;
string15 bdid;
string2 new_line; 
end;
 
header_services.Supplemental_Data.mac_verify('file_businessgrouping_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

Layout_BH_Super_Group reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
 self.group_id := (unsigned6)l.group_id;
 self.bdid := (unsigned6)l.bdid;
 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
bh_super_records := PRTE2_Business_Header.Files().Base.Super_Group.built;
#ELSE
bh_super_records := Business_Header.Files().Base.Super_Group.built + Base_File_Append;
#END;

export Key_BH_SuperGroup_GroupID := index(bh_super_records,{group_id},{bdid},
ut.foreign_prod+'thor_Data400::key::bh_supergroup_groupid_' + doxie.Version_SuperKey);
