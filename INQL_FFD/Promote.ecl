import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote(
	 boolean       				pDaily      		=  true
	,boolean       				pFCRA       		=  true
	,string								pVersion				= 	''
	,boolean							pUseProd			 	= 	false
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pisTesting			= 	false
						):=
module
  shared base_filenames 					:= Filenames(pDaily, pFCRA, pversion).base.dAll_filenames;
	shared base_encrypted_filenames := Filenames(pDaily, pFCRA, pversion,true).base.dAll_filenames;
	
	export base           					:= tools.mod_PromoteBuild(pversion,base_filenames,pFilter,pDelete,pisTesting);
	export base_Encrypted						:= tools.mod_PromoteBuild(pversion,base_encrypted_filenames,pFilter,pDelete,pisTesting);
	
	shared lexid_keynames 						 		:= keynames(true,pVersion).lexid.dAll_filenames;
	shared group_rid_keynames 						:= keynames(true,pVersion).group_rid.dAll_filenames;
  shared group_rid_encrypted_keynames 	:= keynames(true,pVersion).group_rid_encrypted.dAll_filenames;

	export lexid           							:= tools.mod_PromoteBuild(pversion,lexid_keynames,pFilter,pDelete,pisTesting);
	export group_rid           					:= tools.mod_PromoteBuild(pversion,group_rid_keynames,pFilter,pDelete,pisTesting);
	export group_rid_encrypted         	:= tools.mod_PromoteBuild(pversion,group_rid_encrypted_keynames,pFilter,pDelete,pisTesting);
end;