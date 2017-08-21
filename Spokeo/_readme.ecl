EXPORT _readme := 'todo';
/***
Linking
We're LexID'ing the file twice. The first pass is as normal, note in the layout we're providing the LexID Score.
We're then going to do a 2nd pass with a lower threshold, I need to refer back to emails from Aleida how to do this.  For the lower quality hits our linking macro doesn't retain the score so for Spokeo we'll just set LexID_Score='LOW'.

Them I think the best approach here is to run twice.  
First time, with the default configuration that would bring the best lexID and then a 
second time with only records that did not get a LexID with the distance of 0.   

Dates
Rollup the infutor_header attribute on the following fields to get the MIN first_seen and the MAX last_seen: (Infutor.infutor_header)

DID
Prim_range
Prim_name
Zip
Ut.nneq(sec_range)

Join to the Spokeo file on those same fields to apply dates to their records.  If the infutor_watchdog attribute doesn't have those dates then do the same for that file as well.

Deceased
For the deceased_indicator we can't use restricted data, this includes GLB and the SSA restriction.  Kevin Garrity should be able to tell you how to easily filter what we can't use.

Confirmed Flag
For the confirmed_flag, use those same fields above to determine if the most recent Spokeo address (for the consumer) matches the infutor_watchdog result.  If it does then set to 'Y' only for that Spokeo record.

Inserting a new record
Insert a new record if infutor_watchdog has a more recent address than what Spokeo has provided.  Flag the record as being sourced from Lexis and the Spokeo input fields will be blank.  We're only adding a record if we have something more recent as the best address, Spokeo isn't interested in an additional historical record.

Better Address Flag
For this flag your set of data is all the addresses including what was sourced from Spokeo and also if we inserted a new record.  Join on the fields above and if watchdog.file_best has an address NOT found in that set then set this flag to 'Y'.


I'm sure other questions will pop-up and we can discuss over the next couple of weeks.  I'm scheduled for PTO this first week of January but you and I can still discuss.  The first thing to do is tomorrow verify the sample input data meets our needs.  If it does then please proceed with development and I'll notify Spokeo so they can cut a full file.



























***/