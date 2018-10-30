/*

  we want to know:
    how many attributes have differences in each step
    you would like to know the scale of those differences.
      how to measure this?
        percentage of diff lines vs the total lines in the attribute?
        
    also, show the differences in the diff sttribute list at each step
      so, prod code vs pure salt has 5 attributes that are different.  prod code vs pure salt + hacks has 4.  display the 1 attribute difference
  

    so, overview is for this step we had 10 attributes that are different.  
    matches is the most different, at 30 differences which is 35% of the attribute.  the smallest difference is specificities at 2% different.
    the average % difference for all attributes is 5%.  and you could have a dataset summarizing these stats for each attribute.  
    this is something i could put into compare salt code and then you could
    compare that dataset to the next one generated from the next compare.

    if any atts sandboxed, only check the sandboxed atts against their checked-in versions
    if none sandboxed, then check all attributes latest version VS previous version



  THE ELEPHANT IN THE ROOM FOR THIS PROCESS IS OUR CHANGEOVER TO GITLAB.
  IF, AS GORDON SAYS, THE ECLCCSERVER WILL HAVE SOME GIT SUPPORT, THAT MIGHT ALLOW US TO DO A SOAPCALL OR SOMETHING SIMILAR
  TO PULL ATTRIBUTES AND SAVE ATTRIBUTES.  IF SO, THAT WILL ALLOW THIS TO HAPPEN.  IF THAT IS NOT POSSIBLE, THEN
  BACK TO SQUARE ONE.
I have attached a rough draft of what I think that the regression testing process should cover. 
We should automate steps 3 to 11 so that QA person can run them with a simple command or an attribute. 
(We have to keep it simple.) Please review and let me know your thoughts. 

Also, as I mentioned in our meeting, Wheelock mentioned that he will add a few changes in the existing 
hack-o-matic process that can allow us to validate updated code. I am hoping that we can use his process for step 7. 

SALT Regression Testing Process
1.	Load newer version of SALT to repository
2.	Create static input dataset (per header)

automate the following steps:
3.	Copy spc file from production module to new (or existing) test module
      using ECL tools.fun_CreateModule.  will need to copy the whole module so that we can compare the previous code to the 
      current code.  Although that will probably require that we check-in the copied over code.  Haven't done that before...
4.	Generate SALT code
      how can this be automated??  might be hardest part??  need to be able to run a .bat file from ecl code.  Or, 
      might be able to have a separate attribute type, a salt regression attribute, that, when saved, could 


first, automate this:
5.	Compare & validate SALT code
      once we have the .mod file from step 4, we can use that to import the attributes(if they weren't already imported by
      the IDE).  Then, we can pull the historical version of the attribute with the current version.  historical version 
      needs to be checked-in.  or we could just compare the prod module's version of that attribute with this new version,
      with the replacement of the module name for the new module name of course.
6.	Apply manual changes using hack-o-matic process
      using tools.HackAttribute2.  maybe make an output file for alerts.  check to see if changes were already applied.
      qa and alerts could be from here.  outputs simple.
7.	Compare & validate updated code.
8.	Run internal build using static dataset (Add stats that can help us determine how much space a build will need.)
9.	Compare results
10.	Generate alert
11.	Load results to strata or to other server

//not automated
12.	Verify results manually
13.	Pass/Fail

*/