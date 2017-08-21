Keith,
Here’s what I figured out:
We obviously need to create a process for this file to standardize it(the name, address, phones)  and bdid and did it, run population stats, and run a SALT profile on it.  Then examine the salt profile and population statistics to learn more about the data.   I have got this started by creating a module, bell_thrive, in which I put the code for this.  It is basically a standard build process, but without keys and extraneous stuff not needed for the eval.

Here are some workunits I ran:
W20110614-142724 (on dataland) – SALT profile
W20110611-214103 (on production) – full build with population stats

So, from this information, we can fill in some of the spreadsheet with what they want.   They also want overlap stats and uniqueness compared to other POE sources.  U can do these comparisons of the bell thrive file to the poe.files().base.qa dataset.  
This part:
For phone, email, and address, statistics will be generated showing content uniqueness, the relative lift of the record pool for each DID and rate of record-DID corroboration with existing inventory.  
We may need more information on, unless you fully understand it.  I think I understand the content uniqueness for email, phone, and address(just stats on unique addresses, phones, and emails in the file, which I have provided in my build workunit), but the relative lift of the record pool and rate of record-did corroboration…I don’t really understand what they want.

Rob Becker said not to worry about the 25,000 record collection consumer inquiry file.
Let me know if you have any questions, and we can figure this one out together.

Vern
