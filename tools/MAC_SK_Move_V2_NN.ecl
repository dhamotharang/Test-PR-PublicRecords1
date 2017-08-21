import Lib_StringLib, lib_system;

export MAC_SK_Move_v2_NN(kname, move_type, seq_name, numgenerations = '3', diffing = 'false', version = '\'\'') := macro
	
/* 
	move_type may be
		'Q' for movement from BUILT to QA
		'P' for movement from QA to PROD, PROD to FATHER, etc
		'R' for rollback.  Deletes QA and copies Prod into QA
		
	the last destination will be cleared
*/

#uniquename(Get_Versioned_Filename)
string	%Get_Versioned_Filename%(string pFilenameTemplate, string pVersionString)
 :=	RegExReplace('@version@', stringlib.stringtolowercase(pFilenameTemplate), pVersionString);

#uniquename(Actual_Version)
string	%Actual_Version%	:=	if(version<>'',version,thorlib.wuid());

#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(built)
%built% := %Get_Versioned_Filename%(kname,'built');
#uniquename(qa)
%qa% := %Get_Versioned_Filename%(kname,'qa');
#uniquename(prod)
%prod% := %Get_Versioned_Filename%(kname,'prod');
#uniquename(father)
%father% := %Get_Versioned_Filename%(kname,'father');
#uniquename(gfather)
%gfather% := %Get_Versioned_Filename%(kname,'grandfather');
#uniquename(ggfather)
%ggfather% := %Get_Versioned_Filename%(kname,'great_grandfather');
#uniquename(delete)
%delete% := %Get_Versioned_Filename%(kname,'delete');

#uniquename(diffbuilt)
%diffbuilt% := %Get_Versioned_Filename%(kname + '_diff','built');
#uniquename(diffqa)
%diffqa% := %Get_Versioned_Filename%(kname + '_diff','qa');
#uniquename(diffprod)
%diffprod% := %Get_Versioned_Filename%(kname + '_diff','prod');
#uniquename(difffather)
%difffather% := %Get_Versioned_Filename%(kname + '_diff','father');
#uniquename(diffgfather)
%diffgfather% := %Get_Versioned_Filename%(kname + '_diff','grandfather');
#uniquename(diffggfather)
%diffggfather% := %Get_Versioned_Filename%(kname + '_diff','great_grandfather');
#uniquename(diffdelete)
%diffdelete% := %Get_Versioned_Filename%(kname + '_diff','delete');

#uniquename(todelete)
%todelete% := map(%ng% = 4 => %ggfather%,
                  %ng% = 3 => %gfather%, 
                  %father%);
#uniquename(difftodelete)
%difftodelete% := map(%ng% = 4 => %diffggfather%,
				  %ng% = 3 => %diffgfather%, 
				  %difffather%);

#uniquename(built_count)
%built_count% := FileServices.GetSuperFileSubCount(%built%);
#uniquename(qa_count)
%qa_count% := FileServices.GetSuperFileSubCount(%qa%);
#uniquename(prod_count)
%prod_count% := FileServices.GetSuperFileSubCount(%prod%);

#if(move_type='Q')
seq_name := 
   if(stringlib.stringfind(stringlib.stringtolowercase(kname),'@version@',1) = 0,fail('ut.MAC_SK_Move_V2_NN failure: Filename requires a "@version@" token to replace'),
	map(	  %built_count% = %qa_count% and
		  FileServices.GetSuperFileSubName(%built%,1) = FileServices.GetSuperFileSubName(%qa%, 1) and
		  FileServices.GetSuperFileSubName(%built%,%built_count%) = FileServices.GetSuperFileSubName(%qa%, %qa_count%)
										=> output('Built already in QA. No action taken.'),
		  FileServices.GetSuperFileSubCount(%built%) = 0
										=> output('Built is empty! No action taken.'),
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile(%qa%),
				#if(diffing)
					FileServices.ClearSuperFile(%diffqa%),
				#end
				FileServices.AddSuperFile(%qa%, %built%,,true),
				FileServices.ClearSuperFile(%built%),
				#if(diffing)
					FileServices.AddSuperFile(%diffqa%, %diffbuilt%,,true),
					FileServices.ClearSuperFile(%diffbuilt%),
				#end
			FileServices.FinishSuperFileTransaction(),
			output('built moved into qa')))
	);
#end


#if(move_type='P')
seq_name := 
   if(stringlib.stringfind(stringlib.stringtolowercase(kname),'@version@',1) = 0,fail('ut.MAC_SK_Move_V2_NN failure: Filename requires a "@version@" token to replace'),
	map(	  %built_count% = %qa_count% and
		  FileServices.GetSuperFileSubName(%qa%,1) = FileServices.GetSuperFileSubName(%prod%, 1) and
		  FileServices.GetSuperFileSubName(%qa%,%qa_count%) = FileServices.GetSuperFileSubName(%prod%, %prod_count%)
										=> output('QA already in Prod. No action taken.'),
		  FileServices.GetSuperFileSubCount(%qa%) = 0
										=> output('QA is empty! No action taken.'),
		  %ng% not in [2,3,4] => FAIL('ut.MAC_SK_Move failure, numgenerations not in [2,3,4]'),
		  sequential(
		  
				FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%delete%, %todelete%,, true),
				#if(diffing)
					FileServices.AddSuperFile(%diffdelete%, %difftodelete%,, true),
				#end
				#if(%ng% in [3,4])
				   #if(%ng% = 4)
				  	FileServices.ClearSuperFile(%ggfather%),
					FileServices.AddSuperFile(%ggfather%, %gfather%,, true),
					#if(diffing)
						FileServices.ClearSuperFile(%diffggfather%),
						FileServices.AddSuperFile(%diffggfather%, %diffgfather%,, true),					
					#end
				   #end

					FileServices.ClearSuperFile(%gfather%),
					FileServices.AddSuperFile(%gfather%, %father%,, true),					
					#if(diffing)
						FileServices.ClearSuperFile(%diffgfather%),
						FileServices.AddSuperFile(%diffgfather%, %difffather%,, true),	
					#end
				#end
				
				FileServices.ClearSuperFile(%father%),
				FileServices.AddSuperFile(%father%, %prod%,, true),
				#if(diffing)
					FileServices.ClearSuperFile(%difffather%),
					FileServices.AddSuperFile(%difffather%, %diffprod%,, true),
				#end
				
				FileServices.ClearSuperFile(%prod%),
				FileServices.AddSuperFile(%prod%, %qa%,, true), 
				#if(diffing)
					FileServices.ClearSuperFile(%diffprod%),
					FileServices.AddSuperFile(%diffprod%, %diffqa%,, true), 
				#end
				FileServices.FinishSuperFileTransaction(),
				
				FileServices.ClearSuperFile(%delete%,true),
				#if(diffing)
					FileServices.ClearSuperFile(%diffdelete%,true),
				#end
				output('Updated Prod key '+kname))
	)	);
#end	
	
#if(move_type='R')
seq_name := 
   if(stringlib.stringfind(stringlib.stringtolowercase(kname),'@version@',1) = 0,fail('ut.MAC_SK_Move_V2_NN failure: Filename requires a "@version@" token to replace'),
	map(	  %built_count% = %qa_count% and
		  FileServices.GetSuperFileSubName(%qa%,1) = FileServices.GetSuperFileSubName(%Prod%, 1) and
		  FileServices.GetSuperFileSubName(%qa%,%qa_count%) = FileServices.GetSuperFileSubName(%Prod%, %Prod_count%)
										=> output('QA is also Prod.  Cannot rollback.'),
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%delete%,%qa%,,true),
				FileServices.ClearSuperFile(%qa%),
				#if(diffing)
					FileServices.AddSuperFile(%diffdelete,%diffqa%,,true),
					FileServices.ClearSuperFile(%diffqa%),
				#end
				FileServices.AddSuperFile(%qa%, %prod%,,true),
				#if(diffing)
					FileServices.AddSuperFile(%diffqa%, %diffprod%,,true),
				#end
			FileServices.FinishSuperFileTransaction(),
		
			FileServices.ClearSuperFile(%delete%,true),
			#if(diffing)
				FileServices.ClearSuperFile(%diffdelete%,true),
			#end
			output('qa rolled back to prod')))
	);
#end

endmacro;