/*
So need in strata:
  ingest stats
    prep           W20150422-113510 -- maybe err_summary, other three counts + count of err_summary total
    run            W20150422-150050 -- maybe ds_roll,xtab_types and the count fields(put into 1 dataset). this is probably good for now
  data card        W20150518-145841 -- 
  some seg stats   W20150505-151052 -- 
for now.


i think we need to add the datacard to strata, at least for now because it will give us alerts. 
need to run some history through it first
add it to orbit master builds
send orlando the layout
we can develop our own stat compare service later

my bugs go into this build
strata stat for some ingest stuff too


my bugs:

Harrison's bugs:
Chad's code to monitor dataland compile times
code to check size of files from before, flag if same size
*/


/*

  SHOULD TRY TO OUTPUT THE VERSION + ITERATION FOR CHANGES FILES IN S25 FOR ALL INTERNAL LINKING BUILDS.
  for all internal linking builds:
    include preprocess and postprocess
      preprocess will slim down the file to just the linking fields
      postprocess will join that file to the input to update the IDs.  
        output that file, then delete the last iteration.
    each iteration will output the base file and the changes file
    then it will delete the previous base file.
  after the postprocess for a particular iteration runs, it will copy
    the input file to the preprocess to the storage thor(cuz we are done using it at that point).
  this should allow us to clean up as we go...
  and the commonbase file can be copied to the storage thor....at the beginning of the next build?
  ensure that all of these files that are copied are in supers so we can delete them(except for the commonbase ones)
  
tom should really be on the seg stats email.  --DONE
also should add a link to that email probably--can i send an html email from ecl? -- YES and DONE

  improve promote2qa attribute by using macro for some things to prevent them from running again.   --DONE

  add copy of the workunit history for remote children.  parent copies the file after being notified that the child is finished.
  this will allow the macro to skip over foreign children just like it does local children if it bas already been run
  probably should leave the remote file alone, don't delete it. --DONE
 
  add file and superfile for summary report to macro  --DONE
add summary report to build iterations -- dONE
still have a few other to add it to--for S25.

add Wheelock to build emails.
  
*/

/*

bucket size to 5
2 diff modules
proxid 106 module
2 normal iterations
5 106 iterations
1 more proxid regular

*/
/*
  fix copy xlink keys
  should probably put segmentation stats & strata stats into their own workunit for clarity
  do more RA work.  need almost a RA build.  Need to test out different RA strategies and then run iterations(on already converged files) to see what happens.
  Modify wk_ut.mac_ChainWuids to add extra parameter that will allow a lower threshold of matches, which if breached, will stop the iterations there.  So in this case, the pNumIterations parameter would be max number of iterations.
    if it is zero, the default, it will run all iterations(to be transparent to existing processes)
  do more work on wk_ut.get_WUGetGraph to parse it out.  this will be helpful going forward for analyzing graphs.  Would be cool to answer questions such as:
    1.  What is the graph with the largest skew?
    2.  What is the graph with the longest run time?
    3.  Search the workunit for specific code to see which graphs use it.
    4.  compare workunits to see diffs in skew/record counts/etc
    5.  maybe in time could put some intelligence in it so it could spot potential problem areas?  like this join should be local or hash instead of global...
    6.  
  macro to unprotect workunits
  regenerate salt code using unix compile of salt executable.  
    1.  patch salt spc attribute using new specificities
    2.  despray newly patched salt spc file to standard location.  filename has esp and event string in it...or in the file itself...?
    3.  cron job on unix box picks up spc file, calls salt binary to generate code in .mod file
    4.  cron job notifies job that code is ready in .mod file.  It does so by using the esp and event string in the filename
    5.  cron job quits.  
    6.  master workunit gets notified, pulls in the .mod file, parses it out into 1 attribute per record.  Then, it saves the attributes to the repository.  maybe sends an email to say what it did.
    7.  Then, executes any auto-patch code on top of this.
    8.  then, kicks off the iterations...
  work on putting hacks into SALT itself.
  


*/

/*
synonyms for prim_name.  10 diff prim ranges that have same prim names  
remove numbers, get other words that could be synonymns

/*
  prox prim names
  1. build prim name replacement table
      10 different prim_ranges with same zip?/city&state
  2. use Prim name2 field
  3. extra join with additional block on cnp_name, prim range, zip and left.prim_name != right.prim_name

  look at smarter cleanup placed in the build itself.  maybe also tell us how much disk we used in this build.
  cleanup for files/keys built that do not go through the versioning system?
*/


/*
Sprint 5:
  linking bugs
  for dataland copy of xlink keys:  kick off workunit to do this on dataland from production
  kick off separate workunit to do weekly keys?
  figure out precision stuff for previous sprints
  update chain wuids macro to accept lower limit for matches, which, if entered will stop iterations once limit is breached.
  wrap up chain wuids, review samples & precision macros and put into github for inclusion into SALT.  put into SALTTOOLS22
  for foreign key overlinking--will still have to fix the overlinking with a patch outside of a build probably beforehand.
  https://github.com/hpcc-systems/SALT/wiki/AttributeFiles
  ATTRIBUTEFILE:ForeignCorpkey:NAMED(BIPV2_ProxID_dev.file_Foreign_Corpkey):VALUES(company_charter_number<company_inc_state):FORCE(--,ALL):IDFIELD(Proxid):20,0
  have to wait for salt 2.8b1 for this functionality
  
////////////


  Sprint 4:
    Bug: 130341 - LINKING: ProxID Internal Recall: DBAs at an address arent linking (despite sharing a corp record)
    Bug: 123149 - LINKING: ProxID Internal Recall: Search is bringing back duplicate results
    Add Cleave for active domestic corpkey
      CLEAVE:solo_corp_key:BASIS(active_domestic_corp_key):MINIMUM(1)


*/
/*
1)	Releasing current build (20130521)
2)	Update precision number
2.5)Check out bugs to see if missing anything
3)	MJ test Â– likely done, but we never saw iter31 results
4)	Tying the entire build together.  I think this makes everything else easier and safer going forward, even though this task itself is big and ugly.
5)	DBAs Â– why so few?  (src rids or wrong?  Or spc is too tight?  SALT bug?  DAB suggested the attribute file output might give us a clue to start with)
6)	Duns number stuff.  This is where the duns number keeps apparent dups from linking.  When we just used the latest duns feed, we got overlinking.  We talked about removing switch0 from historic duns and making sure that current duns is also in historic (if no true historic).  So, really historic duns would become Â‘dunsÂ’ (most recent, but not necessarily current).  Another possible workaround is to conditionally go around the duns force when the name is an exact match (but I am not sure I like this as much).  
7)	Company name testing Â– we raised the threshold to see how it looked.  I think we should try to compare this to adding things like ABBR and HYPHEN to cnp_name.  this may need to wait on DWÂ’s cnp_name testing.
8)	DAB Â“activestÂ” corp key stuff.  This seems to have some similarity with the duns stuff.
9)	Foreign corp key Â– currently in DABs court


So, this is my list.  What do you think?  Did I forget anything?
Obviously, some of these take machine time, so I would expect youÂ’d have a few running in parallel.

Full build:
/*
Hi Vern Â– I have made changes to the best process.  I have a new module BIPV2_Best_Proxid.  Everything is run the same, but with a different module name.  
Also, I have another module, BIPV2_Best, which is where I keep the attributes to build the keys, the file names and layouts 
(The prod version has the attributes that are used). I will be creating a new module for the SELEID piece, it will be called 
BIPV2_Best_Seleid.  Both will share BIPV2_Best for the file management and key building attributes.
Also, one thing to look for before building best is the changes in specificities, if there is a lot of change in the data.

Thanks Â– Angela
*/
/*
how to run specificities if needed for each internal linking run(dot, prox, best, etc).  maybe have option in proc build all functionmacro to run them(maybe on by default).  then, it will run them
  but, if hacks are necessary, how to handle that?  might have to do them automagically with a function/macro after code generation. but code generation is only done using the IDE, not soapcalls.
if we can regenerate SALT code using soapcall, that opens up big possibilities for automation of specificites.  
  run specificities in master workunit
  patch spc attribute & regen code with those specificities
  optionally run function/macro to hack the newly generated salt code
  kick off salt iteration in new workunit using new code(only way to do it since the master workunit has already been compiled)
  super cool
  
reverse migrate contact linkids key code(from macro with extra persists, etc)
check sync of bipv2_proxid on dataland vs prod.  just had to make change on prod to remove extra carry field(source)
create attribute with all build keys that can output to check that they all exist and are the correct layout


Add Prox stuff
Add DOT stuff
prox in_dot shokuld be in_prox
maybe make it a functionmacro so can easily add/subtract iterations?
add wksummary stuff to each iteration(dot/prox)
create bwrs for calculating precision/outputting review results to files for precision calculation
mayeb put rollback code in proc build all so can rollback all files/keys and all iterations of dot and prox(since I will be passing in # of iteration for each to proc build all)
check to see if last iteration of dot and prox exist, if so, skip those iterations(and maybe promote to built if necessary)
some way to skip certain iterations if the files already exist.  so if 2 iterations are done, and you are doing 3.  just kick off the last iteration(after promoting previous one to built super)
change name of BIPV2.File_Business_Sources persist to right nameing convention
also some way of not stepping on build's persist(when running it weekly outside of build)
rename proc weeklybuild.  probably won't be running weekly.
add check of existence for groups of keys(so doesn't have to go into graph to figure out if key needs to be rebuilt)
macro to take the iterate code, and convert it into a constant string, and also save it to repository.  
then you can run it without worrying about needing a constant for the code.
function to get all sandbox warnings from workunit
function to compare all attributes from one repository to the other.  thinking all bip atts used in build.  
build weekly keys after that
add back BIPV2_ProxID.output_test_cases but use topn instead of sort
function/macro to output layout of xml file.  pass in row tag, and it will output layout(especially useful for child datasets)
*/

//add copy/rename of keys to build
//update dops page
//promote to qa at end of build
//put all keys/files into dataset for whole build
//rename bizlinkfull keys
//build weekly keys
//add promote/rollback code for each build
//add bwr promote/rollback code for each build, and also a master promote/rollback attributes for whole build
//make sure each build uses the "built" superfiles
//make sure I make rollback attribute for whole build that includes the copied bizlinkfull keys on each cluster
//fix BIPV2_Build.keynames because it now has keynames in it that are duplicated in bizlinkfull, etc.
//for promote to qa in bipv2_build module, make it only promotes that proc's keys(use filters)

BEST: W20130612-094008
      #workunit('name','BIPV2 build best base');
import tools;
shared pversion := bipv2.keysuffix;
																							
Best_final := 	BIPV2_Best_test6.Append_After_Best;																						
tools.mac_WriteFile(BIPV2_Best.Filenames(pversion).base.new	,Best_final	,Build_Base_File);

sequential(
 //output(BIPV2_Best_test6.hygiene(BIPV2_Best_test6.In_Base).Summary(''),all, named ('SummaryHygiene'));
 //output(BIPV2_Best_test6.hygiene(BIPV2_Best_test6.In_Base).AllProfiles,all,named ('Profiles') );
 //output(BIPV2_Best_test6.hygiene(BIPV2_Best_test6.In_Base).ValidityErrors,all, named('ValidityErrors'));
 //output(BIPV2_Best_test6.specificities(BIPV2_Best_test6.In_Base).Specificities, named ('specificities'));
 //output(BIPV2_Best_test6.specificities(BIPV2_Best_test6.In_Base).SpcShift, named ('specificitiesShift'));
 //output (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).BestBy_Proxid_best,named('BestBy_Proxid_best'));
//output (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).BestBy_Proxid_best_np ,named('BestBy_Proxid_best_np'));
//output (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).BestBy_Proxid_child ,named('BestBy_Proxid_child'));
//BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).Stats ;
//OUTPUT (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).In_Flagged_Summary,named('In_Flagged_Summary'));
//OUTPUT (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).In_Flagged_Summary_BySrc,named('In_Flagged_Summary_BySrc'));
//OUTPUT (BIPV2_Best_test6.best(BIPV2_Best_test6.In_Base).Input_Flagged,named('Input_Flagged'));
Build_Base_File,
//BIPV2_Best_test6.Keys(BIPV2_Best_test6.In_Base).BuildAll
BIPV2_Best_test6.Keys(BIPV2_Best_test6.In_Base).BuildData
,BIPV2_Best.Promote(pversion).buildfiles.New2Built
,BIPV2_Best.Build_Keys(pversion).all
,BIPV2_Best.Promote(pversion).Buildfiles.Built2QA
);


For the HRCHY build, I have been running this: hierarchy:

BIPV2_Build.proc_hrchy(ProxIDFile).dobuild;
BIPV2_Build.proc_hrchy(ProxIDFile).dostats;
//this module also has an export for runIter, which does the 2 above plus DoSuperFileMoves, but I donÂ’t have the right superfiles in place so I havenÂ’t been doing this.
//after I run, I have been manually updating BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL_BUILDING (once its done) and BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL (once its released).  Sorry, this is ugly manual work that should be cleaned up.

//XADL:
For External Linking, you run this file after the HRCHY build is complete:   
  BizLinkFull.BWR_GoExternal

//SEGMENTATION stats
For segmentation stats, run the following code after the hrchy build.

hdr := BIPV2_Files.files_hrchy.FILE_HRCY_BASE_LF_FULL;
Bipv2_build.proc_segmentation(hdr).run;

For RELATIVES

#workunit('name', 'BipV2 Relatives build');
shared iter := thorlib.wuid();
BIPV2_Build.proc_relative(iter).runIter;


*/