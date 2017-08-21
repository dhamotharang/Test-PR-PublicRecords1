/*
   Experian National Business:
   
      Overview: Experian National Business 
      The Build:
         
         Quick Documentation to run the build:
            Unix Directory : edata14-a:/load01/spoke
            Thor Module       : ENB
            Tapeload02b Dir   : paw/spoke
            Orbit Build       : Experian National Business
            
            1. Check for new directory on tapeload02b.
            2. In the unix directory above, execute:
                        process.sh <process_date> <tapeload02b directory> [<dataland or prod>]
            
                  The first two parameters are self-explanatory.
                  The last parameter is optional, with the default being prod.
                  So if you want to test on dataland, put dataland as
                  the last parameter, and the process will run, but spray and build on dataland(and not rename the 
                  tapeload02b directory).
            
                  So, for example, if today is 20080123 and I want to use the 20080122 directory on tapeload02b:
                     process.sh 20080123 20080122
                     
                  Of course you can use nohup and redirect the output to a log file.
            3. In Orbit, create a build instance of the Experian National Business build.  Add the update file used in the build.
                  When the build finishes, update the status to "build available for use" so that it can be 
                  included as an input in the business header build.
            4. That's it!  You will receive an email stating that the build has finished.
         
         Build details:
            
            Unix part(process.sh):
                  1. Create the tapeload02b directory on unix
                  2. Download the zip file from tapeload02b to it
                  3. Unzip the file
                  5. Prepend an underscore to the tapeload02b directory
                  6. Kick off the thor build process which includes the spray
            
            Thor Part(ENB._bwr_Build_All):
                  1. Spray the file & add to sprayed superfile
                  2. Create base files
                  3. Strata
                  
   
   Notes:
      All of the passwords for this process are stored in files with strict permissions so that
      only the owner can read them(chmod 400).
      if you do not already have these files, create them in your home directory:
      ~/pwds/tapeload02b
      ~/pwds/dataland_thor
      ~/pwds/production_thor
      The usernames for tapeload02b and dataland thor are assumed to be the same
      as your unix username (whoami).  The production username adds "_prod" to 
      your unix username.  So you will need to change the username defaults if your unix username
      does not match your thor username.
      
      To run the thor build process manually, open in a builder window:
         ENB._bwr_Build_All
         
      Modify pversion to the current date
      Modify the directory to the one created for the new update file.
      Execute it.
      
      The thor process uses the following attribute's email address to send emails:
         _control.MyInfo.EmailAddressNotify
      
      Please sandbox this attribute with your email address.  Do not check it in.
      
*/
