export MAC_SK_Move_v2(kname, move_type, seq_name, numgenerations = '3', diffing = 'false',isDelta = 'false') := macro
	
/* 
	move_type may be
		'Q' for movement from BUILT to QA
		'P' for movement from QA to PROD, PROD to FATHER, etc
		'R' for rollback.  Deletes QA and copies Prod into QA
		
	the last destination will be cleared
*/

#uniquename(ng)
%ng% := (integer)numgenerations;

#uniquename(built)
%built% := RoxieKeybuild.Check_Replace_Version(kname,'BUILT');
#uniquename(qa)
%qa% := RoxieKeybuild.Check_Replace_Version(kname,'QA');
#uniquename(prod)
%prod% := RoxieKeybuild.Check_Replace_Version(kname,'PROD');
#uniquename(father)
%father% := RoxieKeybuild.Check_Replace_Version(kname,'FATHER');
#uniquename(gfather)
%gfather% := RoxieKeybuild.Check_Replace_Version(kname,'GRANDFATHER');
#uniquename(ggfather)
%ggfather% := RoxieKeybuild.Check_Replace_Version(kname,'GREAT_GRANDFATHER');
#uniquename(delete)
%delete% := RoxieKeybuild.Check_Replace_Version(kname,'DELETE');

#uniquename(diffkey)
%diffkey% := RoxieKeybuild.Check_Replace_Version(kname,'diff');
#uniquename(diffbuilt)
%diffbuilt% := RoxieKeybuild.Check_Replace_Version(kname,'diff::built');
#uniquename(diffqa)
%diffqa% := RoxieKeybuild.Check_Replace_Version(kname,'diff::QA');
#uniquename(diffprod)
%diffprod% := RoxieKeybuild.Check_Replace_Version(kname,'diff::PROD');
#uniquename(difffather)
%difffather% := RoxieKeybuild.Check_Replace_Version(kname,'diff::FATHER');
#uniquename(diffgfather)
%diffgfather% := RoxieKeybuild.Check_Replace_Version(kname,'diff::GRANDFATHER');
#uniquename(diffggfather)
%diffggfather% := RoxieKeybuild.Check_Replace_Version(kname,'diff::GREAT_GRANDFATHER');
#uniquename(diffdelete)
%diffdelete% := RoxieKeybuild.Check_Replace_Version(kname,'diff::DELETE');

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

//DF-29296: Add the option - isDelta for incremental key movement 
#if(move_type='Q')
seq_name := 
	map(	  %built_count% = %qa_count% and
		  FileServices.GetSuperFileSubName(%built%,1) = FileServices.GetSuperFileSubName(%qa%, 1) and
		  FileServices.GetSuperFileSubName(%built%,%built_count%) = FileServices.GetSuperFileSubName(%qa%, %qa_count%)
										=> output('Built already in QA. No action taken.'),
		  FileServices.GetSuperFileSubCount(%built%) = 0
										=> output('Built is empty! No action taken.'),
		  %ng% not in [2,3,4] => FAIL('ut.MAC_SK_Move failure, numgenerations not in [2,3,4]'),
			isDelta => sequential(
			  FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%qa%, %built%,, true),
				FileServices.ClearSuperFile(%built%),
				FileServices.FinishSuperFileTransaction(),	
			output('incremental built moved into qa')),
		sequential(
		        FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%delete%, %todelete%,, true),
				if(diffing, FileServices.AddSuperFile(%diffdelete%, %difftodelete%,, true)),
				#if(%ng% in [3,4])
				   #if(%ng% = 4)
				  	FileServices.ClearSuperFile(%ggfather%),
						FileServices.AddSuperFile(%ggfather%, %gfather%,, true),
						if(diffing, FileServices.ClearSuperFile(%diffggfather%)),
						if(diffing, FileServices.AddSuperFile(%diffggfather%, %diffgfather%,, true)),					
				   #end

					FileServices.ClearSuperFile(%gfather%),
					FileServices.AddSuperFile(%gfather%, %father%,, true),					
					if(diffing, FileServices.ClearSuperFile(%diffgfather%)),
					if(diffing, FileServices.AddSuperFile(%diffgfather%, %difffather%,, true)),	
				#end
											
				FileServices.ClearSuperFile(%father%),
				FileServices.AddSuperFile(%father%, %qa%,, true),
				if(diffing, FileServices.ClearSuperFile(%difffather%)),
				if(diffing, FileServices.AddSuperFile(%difffather%, %diffqa%,, true)),
				
				FileServices.ClearSuperFile(%qa%),
				FileServices.AddSuperFile(%qa%, %built%,, true),
				FileServices.ClearSuperFile(%built%),
				if(diffing, FileServices.ClearSuperFile(%diffqa%)),
				if(diffing, FileServices.AddSuperFile(%diffqa%, %diffbuilt%,, true)), 
				if(diffing, FileServices.ClearSuperFile(%diffbuilt%)),
				FileServices.FinishSuperFileTransaction(),
				
				FileServices.RemoveOwnedSubFiles(%delete%,true),
				if(diffing, FileServices.RemoveOwnedSubFiles(%diffdelete%,true)),
		
		/*old way
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
				
				*/
			//FileServices.FinishSuperFileTransaction(),
			output('built moved into qa')));
#end


#if(move_type='P')
seq_name := 
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
						if(diffing, FileServices.ClearSuperFile(%diffggfather%)),
						if(diffing, FileServices.AddSuperFile(%diffggfather%, %diffgfather%,, true)),					
				   #end

					FileServices.ClearSuperFile(%gfather%),
					FileServices.AddSuperFile(%gfather%, %father%,, true),					
					if(diffing, FileServices.ClearSuperFile(%diffgfather%)),
					if(diffing, FileServices.AddSuperFile(%diffgfather%, %difffather%,, true)),	
				#end
				
				FileServices.ClearSuperFile(%father%),
				FileServices.AddSuperFile(%father%, %prod%,, true),
				if(diffing, FileServices.ClearSuperFile(%difffather%)),
				if(diffing, FileServices.AddSuperFile(%difffather%, %diffprod%,, true)),
				
				FileServices.ClearSuperFile(%prod%),
				FileServices.AddSuperFile(%prod%, %qa%,, true), 
				if(diffing, FileServices.ClearSuperFile(%diffprod%)),
				if(diffing, FileServices.AddSuperFile(%diffprod%, %diffqa%,, true)), 
				FileServices.FinishSuperFileTransaction(),
				
				FileServices.RemoveOwnedSubFiles(%delete%,true),
				if(diffing, FileServices.RemoveOwnedSubFiles(%diffdelete%,true)),
				output('Updated Prod key '+kname))
		);
#end	
	
#if(move_type='R')
seq_name := 
	map(	  %built_count% = %qa_count% and
		  FileServices.GetSuperFileSubName(%qa%,1) = FileServices.GetSuperFileSubName(%Prod%, 1) and
		  FileServices.GetSuperFileSubName(%qa%,%qa_count%) = FileServices.GetSuperFileSubName(%Prod%, %Prod_count%)
										=> output('QA is also Prod.  Cannot rollback.'),
		sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile(%delete%,%qa%,,true),
				FileServices.ClearSuperFile(%qa%),
				if(diffing, FileServices.AddSuperFile(%diffdelete,%diffqa%,,true)),
				if(diffing, FileServices.ClearSuperFile(%diffqa%)),
				FileServices.AddSuperFile(%qa%, %prod%,,true),
				if(diffing, FileServices.AddSuperFile(%diffqa%, %diffprod%,,true)),
			FileServices.FinishSuperFileTransaction(),
		
			FileServices.RemoveOwnedSubFiles(%delete%,true),
			if(diffing, FileServices.RemoveOwnedSubFiles(%diffdelete%,true)),
			output('qa rolled back to prod')));
#end

endmacro;