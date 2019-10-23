/*

  FOR TOTAL THOR TIME/TOTAL TIME, the amount of time elapsed is sometimes different if the workunit failed.  because if it fails in the middle of a large graph,
  then it will not count the time in that graph towards the total thor time.  in this case, i would need to total up those times myself in WorkMan.get_TotalTime.

  SHOULD ALSO PUT IN THE PROCESS TIME.  I CAN CALCULATE THIS BY THE TIME THAT THE WORKUNIT WAS SUBMITTED(FROM THE WUID) TO THE TIME FINISHED.  THIS WILL ALSO HELP TRACK TOTAL TIME ELAPSED.
  if the wuid comes back as a blank, then need to handle that better, because it could be that a wuid was submitted, but the cluster is wrong, or the esp could be wrong?
    point is, when that happens, it should(if possible) send an alert email that specifically says that the wuid returned was blank, and then also send the code used to try to create that 
    wuid.  that will make it easer to diagnose why that would be.

  IN INSTANCES OF GLOBAL RESTART, IN THE EMAIL, SAY THAT THIS IS A GLOBAL RESTART(BETTER LANGUAGE HERE).  PROBABLY CAN DO THIS BY CHECKING IF THE CHILD RUNNER IS NEWER THAN THE CHILD 
  WORKUNIT.  THIS IS A RESTART..OR SOMETHING LIKE THAT.
  for the condition, i should allow you to pull a result from the previous iteration and pass that into the next iteration.
    this would help with checking which keys changed layouts so we don't have to do it manually or kick off 46 workunits when only a few keys changed
    so it could pull the key number from the previous workunit, then increment it, and pass that value into the next iteration.
    so what it would do is only return each time it failed(or if it completes), cutting down the number of wuids required.
    the condition would be a max of 46 iterations, a min of 1, and a condition that says if the key number is 46, then stop(means it has checked all keys).

could have restore link in workunits dataset, definitely have a link to the wuid itself in the wuid.

// Challenge 2
Problem: The total number of iterations required to run any internal linking build is primarily dependent upon the total number of new records ingested in the build.  
Currently no framework is available that allows users and ops to run multiple iterations with consistent interface. 
 
Challenge: Integrate Vern’s workunit manager in SALT’s spc file. Generate ECL code that allows user to run multiple builds including SALT internal linking iterations 
with persist files and key builds. Provide an ability to identify total number of iterations needed for the build. 
 
End Date: 31 August, 2015
 
Evaluation: David and Edin will verify SALT implementation, build attributes and identify winner. 
 

Note: Challenge #2 will also require basic understanding of the SALT development process. Once I have a list of individuals who are interested in this challenge 
I will schedule a meeting with Edin. He will provide a quick overview of SALT development process and be available to support any basic questions participants may have. 

need library into salt


*/

/*
  so, first I should improve the macro so it can stop after matchesperformed goes below a certain threshold(or the number of clusters goes below a certain threshold, or both).
  grab the # of new records from the ingest process(which should be done in another wuid)

  need a way to tune using the SPC the number of clusters to shoot for(already in spc) to figure out how many iterations to run

  perfect situation:
    modify macro to improve these areas:
      make the number of iterations optional if you have a stop condition.  Or, if no stop condition, it will stop by default after it has reached a certain 
        matches/cluster ratio(maybe 0.25%, so if you have 200 million clusters and you get 500K matches, which is 0.25% of the clusters, by default it would stop).
        it could also factor in the thor time into this calculation.  For example, is it worth it to run another iteration(continuing with the above example)
        if you have 200 million clusters, and it takes 48 hours to run, and your last iteration had 3 million matches?  is it worth it to run another?
        This could be a question to the user during the run...so it could gather this info, and then email you asking whether you want to run another iteration....
        maybe by default it could factor this in and only ask in extreme thor time cases, like the above, maybe over a day of thor time it would ask.
        if you have 200 million clusters and your last iteration provided 500K matches, is it worth it to run another iteration?  Probably not.  So, instead of the master generating all the code
        to run all the iterations(and needing the # of iterations to be a constant), the number of iterations(if passed in) would not need to be a constant since the childrunner would be 
        run in a separate workunit and it would take care of the # of iterations to run, and could do it dynamically.
        and once all iterations were finished, it would write out a final file(maybe a null dataset, or one with the wuid in it), and that file would be checked by the master wuid to see if 
        all iterations have been run for that linking build.  In case of rerun, the childrunner will figure out where it left off and then kick off the next iteration if necessary.
        actually, you may not even need the number of new records from the INGEST..... think the number of matches vs number of clusters ratio is a better indicator.
        this would be soooo cool.
        would also like to put in the option to clean up the files, into one file(but just as an option because this could bite us if it is not)
        this would also allow the start iteration # to be dynamic since it would just be passed to the childrunner, and the final file that the master checks would just be dated, with no iteration
        number.
        another thing the childrunner could do is to automatically check other iterations run(by looking at older dated run files), sort them descending and then find the last iteration #.
        then it could start from that iteration + 1 by default of course.  You can still specify both the start iteration and # of iterations and it will follow those directions.
        ****the watcher would also be persistent for each macro call...it would only use 1 watcher for all iterations, like there is only 1 childrunner for all.
            they could talk back and forth.  the childrunner would pass the wuid to the watcher, and it would watch it.  when that wuid completed/failed/aborted, it would 
            notify the childrunner.  and so on.  once the childrunner is complete or fail, it will notify the watcher to do the same(or it could fail the watcher).
            this will cut down on the number of wuids created to  iterations + 2, instead of iterations * 3.  
        *****the top level macro, mac_workman could probably be a function instead of a macro....test that out.. this would also allow 
             your top level proc_build_alls to be functions instead of macros....that would be great!!!!!

        So, by default you could just pass in the ecl.  
        Now, for salt use vs general use...
          these defaults would be for salt use, which could be a special meta functionmacro with specific defaults for SALT that calls the generic one with those defaults.
          for generic use, can't really have any condition defaults since you don't know what the results will be.  But, the defaults for the generic macro could be 
          start iteration/num iteration could be 1,1.  Because most non-salt implementations will only be doing 1 "iteration".
        
        maybe look at __html results that are datasets, so maybe each iteration could be in there and linkable
        remove the version and iteration from named results since the childrunner will be running multiple iterations.  
        move them to results, so the version is a result, and the iteration is a result, incremented each time it runs another iteration.
        the value of the condition could be a result too, so you know how close it is to stopping.   So, like if you had 2 million matches and 200 million clusters, and your 
        condition was # matches goes under 0.5% of clusters, it could output what percent you are at(and maybe the values that make it up(#matches, #clusters), and also the threshold
        to let you know you are close to stopping.

        This will eliminate a lot of code from the master workunit, which for large builds like BIP, will be helpful in speeding up the compile time.
        So basically the master wuid will just do the top level existence check for the iterations(if they are all finished), and if it doesn't exist, then kick off the child runner and wait for it.
        Right now after that comes back, it grabs the results and does some stuff with them....That may not be necessary anymore....it might all be done in the childrunner.
   after macro is modified in this way, all you would need to do is provide an interface with the SPC file, like maybe using HACK::
   and the thing would be that the workman module would already be installed in the environment, kind of like salt30, salt31, etc.  
   and your interface to it in the spc would be simple, and limited.  Since it would already be installed(and the ips and hthors and thors already specified), all you would need to know 
    in the spc would be:
      what thor do you want to run the iterations on?
      maybe your stop condition for iterations or a hard number of iterations(this can be defaulted to maybe if matchesperformed is < 0.25% of the postclustercount, then stop iterating)
      start iteration?
      version would be changing each build so that wouldn't be a good candidate for inclusion in the spc.  it would need to be specified in the BWR
      set results....this will probably be defaulted to some interesting salt results...like pre, post cluster count, matches performed, basic matches performed(look at proxid for examples)
      probably output logical file and superfile for enabling restarts...important
      
*/

