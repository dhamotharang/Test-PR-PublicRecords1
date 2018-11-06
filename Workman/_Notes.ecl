/*  compiling
      only run iterations once
      don't need to get results from the iterations...(not sure)
      don't send options for rerunning/skip/failure or output them to the childrunner wuid
      on failure just skip basically
      don't output the workman files, but do keep the wuids in the workunits dataset
      call compile instead of createwuid
      watcher might need a compile option too.  what is status of successful compile(looks like it is the same, completed)
      childrunner, watcher use the createwuid
      only wuid create that changes is the iteration.




// -- put in option for WorkMan.Cleanup_Super.  shoiuld be easy --DONE, NEEDS TO BE TESTED
// -- need to put in copy of workman output file to the parent environment.  hopefully can do this in the childrunner.  //DONE
// -- also make sure that all soapcalls here in the parent reference the correct esp, not just the local in case the childrunner runs on a remote environment.  --DONE, BUT HAVE TO TEST
// -- also in the childrunner, make sure when it does the notify that it uses the correct esp!!! -- DONE
// -- also get all attributes ready and check in with correct bug #
// -- then migrate code to alpha_dev using AMT.
// -- and then notify cody and kevin, ask them to test
// -- how to allow it to start where it left off + 1 iteration wise?  so if you specify the start iteration, it will use that.  if you do not specify, it will use last iteration performed + 1.  -- DONE
// -- easy to run multiple ones in parallel????
// -- function/macro to convert old wk_ut files to workman files.  should be easy project.  results child dataset will be blank/null  -- DONE
// -- add cloning to the childrunner carefully

  -- DEFEND AGAINST PEOPLE CLICKING TWICE ON RERUN/SKIP/FAIL.  
  -- also like to fix the formatting in the emails so the colons line up.  probably can use some tabs to do it.
      might want to look into trying to send an html email instead of plaintext.  not sure if possible, but look into it.
  -- need to prioritize my workman work into bullets:
      8. put the environment specific stuff into the _Control module so the workman module can be the exact same between envs.
      14. find all wk_ut improvements that need to be included in workman.
      13. when you rewind a build, it should not delete the files, but it should rename them with the wuid appended so it can 
          keep the history of the build.
      19. cleanup super functionality


  checking to see if all iterations are complete:
    1. might also be nice to have a boolean flag that tells it to compile the wuid, not run it.  this would allow, for example, any build to kick off and compile all 
        steps to make sure they are ok.  it would just monitor each compile like it does a running wuid, and email when finished with the error if it has one
        then it would continue to the next iteration.
    1. hard number of iterations to run.  Check the last iteration's workman file.  if it exists, then skip.
        this will allow running extra iterations on top of what was already run and finished.  mimicing the way it is now.
        problem here could be when we allow workman to start where it left off as far as iterations go, i.e. you don't have to pass in the 
        start iteration #.  How to handle that????  in the parent, it would have to look in the workman superfile for the last iteration for this process.
        But....for single workunits, you don't want it to increment the iterations.  like for non-salt internal linking processes.
    2. conditional iterating with max and min number of iterations.  check the final workman file for the iterations
        if it exists, then skip.  might want to also check the min iteration file.  
    3.  on reruns where the full build workunit failed, and you kick it off again, if a childrunner for that piece is still running, it should 
        abort it.  this will prevent lots of orphan childrunners if it cleans up after itself.

      1. would be nice if we could take an output(s) from the previous workunit and replace a token in the code with its value in the new wuid/iteration.  this could be used in the 
          multiple iterations of the same code, or in diff code run sequentially(by workman).
      1. would love to be able to put the summary file back in.  but it could be generic for the stuff we want, like a child dataset with field name, field value.
          that would allow easier precision calculation since the confidence levels will already be in that file.
      1. would also love to fix the formatting in the emails so they line up.  will make it easier to read.  might need to use tabs instead of spaces.
      1. put number of iterations left in the childrunner results.  or end iteration #.  in cases of conditional iterating with no end point, it could be blank(or just have max in there).  if use max iteration number
          could be that.
      1. platform bug fix to allow master wuid to wait in scheduler
      2. improved communication with user so user knows at any point in time where the process is and what to do if it fails.
      3. add optional conditions to allow for open ended iterating plus min and max number of iterations.
      4. change childrunner to one per macro call.
      5. if childrunner returns but the iteration has not finished(i.e. it is running), it should immediately kick off another 
          watcher and then go back in the scheduler.  doesn't need to be any communication to the user here.
      6. run multiple wuids in parallel.
      7. integration into SALT.  probably salt wrapper macro.
      9. point the wk_ut module to this one.  so the mac_chainwuids would call mac_workman with certain parameters.  like it 
          wont care about the conditions, etc.
      10. test the changes with Heather and possibly Cody for person header and also Mark to make sure they work and address
          any issues that arise because once the data team starts using it, any changes to it will be a much bigger deal than
          they are now especially if daily builds start using it.  This has to be right.
      11. handle blank wuids(soap problem so it didn't create a wuid) better.  if it does happen, the watcher is not going to 
          do anything about it.  so it should realize it has a blank wuid and then notify the childrunner immediately.  then
          the childrunner can kick it off again.  this doesn't really need to be communicated with the user.  by doing it this way
          instead of trying to kick off a wuid multiple times in the same session, it can handle it better if it keeps happening
          than it would if we tried to do it in the same session.  it would be like a loop, and could keep doing it until it gets
          a real wuid.
      12. when a wuid like the childrunner or watcher fails itself to get itself out of the scheduler, it should note the time
          in the workunit information comment.  this is helpful.
      15. the childrunner at any point in time should have a comment its results, probably the first one(after the parent wuid),
          like 'Status_Comment' that tells you what the status of the childrunner is.  Should also have 'Notify_Me' result
          that will notify the childrunner in case of emergency(break glass).  might want to know what is next if notified?
      16. add an html result towards the top that can re-kick off that workunit exactly the same.  so for the childrunner, it 
          could re-kick off the childrunner if it failed without notifying the parent.  this result should only be visible
          when the workunit fails, not any other time, so it could be in a failure clause.
      17. the watcher might want to have have a time limit on the soapcalls of like 5 minutes.  then it could be wrapped in a
          failure clause that allows 3 failures.  if it fails a fourth time, then it would email you telling you that it failed
          4 times, it is a watcher, and you should click here to kick off another watcher.  Or....even better would be if the 
          watcher, after failing 4 times, kicked off another exact duplicate watcher upon failure.  Wouldn't that be cool???????
          because sometimes they are sick and just will not do anything.  but you have to be careful where you put the failure
          clause because you don't want it to run each time, just after it has tried three times.  this will probably work by 
          using :RECOVERY(RERUN,3),FAILURE(REKICK OFF ITSELF), any by setting time limits on the soapcalls.
      18. The seemingly unrecoverable points of failure are when a wuid does not compile.  im talking about platform errors that 
          cause it not to compile, not code errors.  So, to mitigate this, each time i kick off a wuid, i should send an email
          with details.  Also, since the child wuid that is kicked off could fail like that, leaving the parent in a lurch,
          you should be able to re-kick off that child from the parent wuid using a link.  so no coding necessary.  that link
          could also be in the email, or it could let you know that you can click the link in the results of the wuid, instead of
          putting it in the email to prevent any accidental clicks.
      20. the whole returning with a status of "running" BS.  this shouldn't happen, but it still does.  so if the watcher does notify
          the childrunner that the iteration finished, but it did not finish, the childrunner should immediately check that and
          then re-kick off another watcher and then go back in the scheduler.  kind of like when it starts where it left off in 
          global restarts.
      21. maybe can name the links so that the whole link doesn't have to show.  like the rerun link could just display rerun instead
          of the whole url.
      22. TRY TO MAKE ALL PARAMETERS TO THE TOP LEVEL MACRO BE DYNAMIC.  TRY TO ALLOW THEM TO BE DYNAMIC, 
          SO THEY DON'T HAVE TO BE COMPILE TIME CONSTANTS.  this could potentially allow the top level macro to be a function,
          but....if i really want to be able to use the same macro to kick off multiple wuids in parallel, which would require
          me to pass in a set of ecl code to do it, but use the same parameter to pass in one string of ecl code for 
          sequential iterations, i still need a macro.  but allowing the parameters to be dynamic is still good.
      23. add capability to pause or stop the execution after the child/iteration finishes.  configurable based on results from the child/iteration.
          so it could send you an email saying that this wuid finished(like normal), but the childrunner would not fail yet.  the email
          would have links to advise the process because certain values were not met.   once you reviewed them and confirmed they are ok, you
          could click on the link to advise the process to continue, rerun or fail.  

  -- to fix or mitigate platform issues that cause failures, adding any more wuids to check other wuids only complicates things
      and creates more points of possible failure.  So i think what I should do is to communicate more with the user what step
      workman is on at each point in time and also give the user options on what to do if a failure occurs that is not 
      caught by workman itself(like if the watcher fails without notifying the childrunner, or the childrunner fails to compile, etc)
      what it could do is when it emails a status of which step it is on, it could also provide a link in that email
      that could do a specific action.  an example could be in the email it sends as it kicks off an iteration, it could
      give all the details(childrunner wuid, iteration wuid, watcher wuid), and then provide a link to click in case the watcher 
      fails without notifying the childrunner.  and a link 

  -- the whole returning with a status of "running" BS.  this shouldn't happen, but it still does.  so if the watcher does notify
      the childrunner that the iteration finished, but it did not finish, the childrunner should immediately check that and
      then re-kick off another watcher and then go back in the scheduler.  kind of like when it starts where it left off in 
      global restarts.

  -- maybe can name the links so that the whole link doesn't have to show.  like the rerun link could just display rerun instead
      of the whole url.
  -- add a link in the childrunner results that will allow you to notify the childrunner.  not with any specific eventextra text
      but just to allow you to not have to write ecl to notify it in the case that the watcher fails without notifying it.

  --TRY TO MAKE ALL PARAMETERS TO THE TOP LEVEL MACRO BE DYNAMIC.  TRY TO ALLOW THEM TO BE DYNAMIC, 
    SO THEY DON'T HAVE TO BE COMPILE TIME CONSTANTS.  this could even possibly make the top level macro a function which
    which would be cool.

-- making links in results
myTest1 := 'W20140710-132017';
output(myTest1, named('OtherWU1__html'));

this one works!
myTest2 := '<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20140710-132017">W20140710-132017</a>';
output(myTest2, named('OtherWU2__html'));

This also works!  I'm guessing any link here would work
output('<a href="http://prod_esp.br.seisint.com:8010/?inner=../WsWorkunits/WUInfo%3FWuid%3DW20140710-132017">W20140710-132017<\a>'
,named('OtherWU3__html'));


  ideas for gettign graphs:
    1. identify longest running subgraphs/flows, output them and also output code associated with it, in/out count and skew
    2. identify highest skewed graphs
    3. identify highest in/out count difference(percentage or raw count)
    4. allow to search for where specific code is executed in the workunit graphs
    5. allow to compare with another workunit, see diffs in graphs
    6. search for largest files output(whether persists or regular output files) by record count or size.
    7. longest running graphs as percentage of total thor time
    8. 
    
  write something to parse out workunit warnings to get the attributes that are sandboxed.


improve mac_chainworkunits to send email with extra fields, check status a few times in the watcher, and also output the summary dataset during operation, not at the end.  also when fails, send failmessage.
write macro/function to restore a workunit
use that in another macro that allows you to search for workunits, and restore them if necessary, and summarize their results in a dataset.
write macro/function to calculate precision.  
  could have a file for each iteration that gets put into a superfile.  
  After people respond to the review samples, I could pass into this function the Wuid for the iteration
, the number of samples that are good, # of bad, # of questionable, and it would grab the # of matches 
from the wuid, grab the dataset with the breakdown per conf level...then it could write out a file 
for that iteration and put it into the superfile. 



  WUQuery gets workunits, archived & not archived
       <Type>archived workunits</Type>
  WUAction will restore the workunit
    <Wuids>
        <Item>W20130603-104908</Item>
       </Wuids>
       <ActionType>Restore</ActionType>
  then u can get the scalar results or dataset results

  
*/