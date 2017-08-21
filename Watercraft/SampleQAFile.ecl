import ut, watercraft;

export SampleQAFile := function

////////////////WATERCRAFT SEARCH QA SAMPLE//////////////////////////////////////////////////////////

searchfile 		:= watercraft.File_Base_Search_Dev;

search_distrib  	:= DISTRIBUTE(searchfile,hash(watercraft_key, sequence_key)); 

searchfile_father :=  dataset( Watercraft.Cluster + 'base::watercraft_search_father',Watercraft.Layout_Scrubs.Search_Base,thor);

search_father_distrib  	:= DISTRIBUTE(searchfile_father,hash(watercraft_key, sequence_key)); 

recordof(search_distrib) tJointoSearch(recordof(search_distrib) l, recordof(search_father_distrib) r) := transform
self := l;
end;

searchsample		:= join(search_distrib
				,search_father_distrib
				,left.watercraft_key = right.watercraft_key and
				left.sequence_key = right.sequence_key
				,tJointoSearch(left,right)
				,left only
				,local
				);

search_random     := DISTRIBUTE(searchsample,RANDOM());                                                                                                                                                                                

////////////////WATERCRAFT MAIN QA SAMPLE////////////////////////////////////////////////////////////

mainfile		:= watercraft.File_Base_Main_Dev;

mainfile_father := dataset( Watercraft.Cluster + 'base::watercraft_main_father',Watercraft.Layout_Scrubs.Main_Base,thor);

sample_distrib  := distribute(mainfile_father,hash(watercraft_key, sequence_key)); 
Main_distrib 	:= distribute(mainfile,hash(watercraft_key, sequence_key)); 

recordof(Main_distrib) tJointoMain(recordof(Main_distrib) l, recordof(sample_distrib) r) := transform
self := l;
end;

mainsample		:= join(Main_distrib
				,sample_distrib
				,left.watercraft_key = right.watercraft_key and
				left.sequence_key = right.sequence_key
				,tJointoMain(left,right)
				,left only
				,local
				);

main_random     := DISTRIBUTE(mainsample,RANDOM());                                                                                                                                                                                
														
////////////////COASTGUARD QA SAMPLE////////////////////////////////////////////////////////////////

cgfile 			:= watercraft.File_Base_Coastguard_Dev;

sample_distrib1 := distribute(searchfile,hash(watercraft_key,sequence_key)); 
cg_distrib 		:= distribute(cgfile,hash(watercraft_key,sequence_key)); 

recordof(cg_distrib) tJointoCG(recordof(cg_distrib) l, recordof(sample_distrib1) r) := transform
self := l;
end;

cgsample		:= join(cg_distrib
				,sample_distrib1
				,left.watercraft_key = right.watercraft_key and
				left.sequence_key = right.sequence_key
				,tJointoCG(left,right)
				,local
				);

cg_random        := DISTRIBUTE(cgsample,RANDOM());
													
//////////////////////////////////////////////////////////////////////////////////////////////////////

sampleout:=  sequential(
	output(choosen(search_random( date_last_seen[1..4] >= ut.getDateOffset(-365) [1..4]) ,500),named('QA_Search_Sample')),
	output(choosen(main_random( sequence_key[1..4] >= ut.getDateOffset(-365) [1..4]),500),named('QA_Main_Sample')),
	output(choosen(cg_random( sequence_key[1..4] >= ut.getDateOffset(-365) [1..4]),500),named('QA_Cg_Sample'))
	);

return sampleout;

end;