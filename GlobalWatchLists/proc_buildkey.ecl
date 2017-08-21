import RoxieKeyBuild,ut, PromoteSupers;


export proc_buildkey(string filedate) := function
  pre := SF_MaintBuildingnew('~thor_data400::base::globalwatchlists');

//Build sequence
  RoxieKeyBuild.MAC_SK_BuildProcess_Local(Key_GlobalWatchLists_Seq,
											'~thor_data400::key::globalwatchlists::'+filedate+'::seq',
										  '~thor_data400::key::globalwatchlists::seq',a1,, true) // done
//Build country
  RoxieKeyBuild.MAC_SK_BuildProcess_Local(Key_GlobalWatchLists_Country,
											'~thor_data400::key::globalwatchlists::'+filedate+'::countries',
										  '~thor_data400::key::globalwatchlists::countries',a2,, true) // done
//Build key
  RoxieKeyBuild.MAC_SK_BuildProcess_Local(Key_GlobalWatchLists_Key,
											'~thor_data400::key::globalwatchlists::'+filedate+'::globalwatchlists_key',
										  '~thor_data400::key::globalwatchlists::globalwatchlists_key',a3,, true) // done
//Move sequence
  RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::globalwatchlists::'+filedate+'::seq', 
									 '~thor_data400::key::globalwatchlists::seq',b1,,true) // done
//Move country
  RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::globalwatchlists::'+filedate+'::countries', 
									 '~thor_data400::key::globalwatchlists::countries',b2,,true) // done
//Move globalwatchlists_key
  RoxieKeyBuild.MAC_SK_Move_To_Built('~thor_data400::key::globalwatchlists::'+filedate+'::globalwatchlists_key', 
									 '~thor_data400::key::globalwatchlists::globalwatchlists_key',b3,,true) // done

  full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::globalwatchlists',1) = 
			   fileservices.getsuperfilesubname('~thor_data400::base::globalwatchlists_built',1),
			   output('main file BASE = BUILT, Nothing done.'), sequential(a1,a2,a3,b1,b2,b3));


  post := PromoteSupers.SF_MaintBuilt('~thor_data400::base::globalwatchlists');

  RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::globalwatchlists::seq', 'Q', move1);
  RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::globalwatchlists::countries', 'Q', move2);
  RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::globalwatchlists::globalwatchlists_key', 'Q', move3);

  return sequential(pre,full1,post,move1,move2,move3);
end;