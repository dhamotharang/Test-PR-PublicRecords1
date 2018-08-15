import PromoteSupers, header,header_slimsort;
export Proc_Make_Name_xxx(string src_cluster, string dest_cluster2, string dest_cluster3) := function

//****** Build Base Files

src_cluster_name := '~' + src_cluster + '::';

PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_dob_dayob, src_cluster_name + 'BASE::HSS_Name_Dayob',out_dayob,2,,true,pVersion:=Header.version_build)
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_ssn,src_cluster_name + 'BASE::HSS_Name_SSN',out_ssn,2,,true,pVersion:=Header.version_build)
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_address,src_cluster_name + 'BASE::HSS_Name_Address',out_addr,2,,true,pVersion:=Header.version_build)
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_phone,src_cluster_name + 'BASE::HSS_Name_phone',out_phone,2,,true,pVersion:=Header.version_build)
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_zip_age_ssn4, src_cluster_name + 'BASE::HSS_Name_Zip_Age_Ssn4',out_fuzzy,2,,true,pVersion:=Header.version_build)
out_did_ssn := header_slimsort.did_ssn;
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.hss_household,src_cluster_name + 'BASE::HSS_household',out_household,2,,true,pVersion:=Header.version_build)
PromoteSupers.Mac_SF_BuildProcess(header_slimsort.name_source, src_cluster_name + 'BASE::HSS_name_source',out_nmsrc,2,,true,pVersion:=Header.version_build);

base_files := parallel(
	out_nmsrc,
	out_household,
	out_dayob,
	out_ssn,
	out_addr,
	out_phone,
	out_Fuzzy,
	out_did_ssn
);

//copy the logical files on dest_cluster2 
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Dayob',src_cluster, dest_cluster2, copy_dayob2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_SSN',src_cluster, dest_cluster2, copy_ssn2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Address',src_cluster, dest_cluster2, copy_addr2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_phone',src_cluster, dest_cluster2, copy_phone2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Zip_Age_Ssn4',src_cluster, dest_cluster2, copy_fuzzy2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_household',src_cluster, dest_cluster2, copy_household2_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_name_source',src_cluster, dest_cluster2, copy_nmsrc2_)

header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Dayob',src_cluster, dest_cluster3, copy_dayob3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_SSN',src_cluster, dest_cluster3, copy_ssn3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Address',src_cluster, dest_cluster3, copy_addr3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_phone',src_cluster, dest_cluster3, copy_phone3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_Name_Zip_Age_Ssn4',src_cluster, dest_cluster3, copy_fuzzy3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_household',src_cluster, dest_cluster3, copy_household3_)
header_slimsort.Mac_SF_CopyProcess('BASE::HSS_name_source',src_cluster, dest_cluster3, copy_nmsrc3_)

copy_files := parallel(
	copy_dayob2_,
	copy_ssn2_,
	copy_addr2_,
	copy_phone2_,
	copy_Fuzzy2_,
	copy_household2_,
	copy_nmsrc2_,

	copy_dayob3_,
	copy_ssn3_,
	copy_addr3_,
	copy_phone3_,
	copy_Fuzzy3_,
	copy_household3_,
	copy_nmsrc3_
);

full_files := sequential(base_files,copy_files);

return full_files;
end;