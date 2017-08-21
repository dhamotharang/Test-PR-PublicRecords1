/*
DCAV2.Build_All & DCAV2._Flags


  //rollback DCAV2.Update_Companies & flags, DCAV2.Build_All(sandboxed to run build specific way on dataland)

tools.mac_Append_AID
tools.macf_FilesBase
tools.macf_FilesIndex
tools.macf_FilesInput
tools.macf_WriteFile
tools.macf_WriteIndex
Strata.macf_CreateXMLStats
Strata.macf_Percent_Pops
Strata.macf_Pops
Strata.macf_Uniques

  Final things to do:
  1. spray up all historical files.   first only the ones in the new layout.  old ones will have to wait.
  2. Convert old files to new layout. have to wait.
  3. Blank out existing base files so they won't be pulled into the build.
  4. Process all files in one build(I think).  make sure kill report and accessory files will be taken care of with this(are using dates)
  5. Copy over base files to production.
  6. Sandbox code to remove the __filenames because it is causing errors.  how to do this because we need new layouts?
  7. 

*/



/*
	so, if this were a regular build(not have to worry about order of recs, grouping), could just rollup(ingest) the records normally.
	but, since we need to create the grouping of records per hierarchy, I don't want to lose that data.  If I rollup normally, then
	if I take the new record when two records are the same, I will keep the current hierarchy.  But how does that leave the historical records?
	if we have the rid on the file....well, if the historical record rolled up with a new one, it gets the new rid.  so the old hierarchy would
	not be able to be recreated from the data in the base file....I'm tempted to not rollup at all, flagging the new records as new, and the 
	historical records as historical...so the base file would increase by about 500meg each build. Not too bad really...then the hierarchy of each update
	could be recreated if necessary.  Should the lncagid and lncaghid be larger then, to accomodate cumulative per build numbers?  And what about source rid?
	It would be nice to be able to preserve the order for any particular update in the base file.
	to do this, rollups or joins to collapse records can't be used.  all records would be in there.  rids would be unique.
	rollups/joins, etc would be done at keybuild time or when mapping to a header layout.
  the lncagid, lncaghid, lncaiid would all be incremental between updates, not step on each
	other.  so if you filtered on a specific update date, you would be able to recreate the hierachy for that update if necessary.
	you could if wanted, create a key on update date and hiearchy that would make it easier.
	the size is not going to be an issue since this file is so small...could have several functions/macros that will rollup the file 
	on specific criteria to mimic our traditional rollups and get it ready for header integration, etc.  
	This way, we wouldn't be losing anything in the build process, but we still can go back and retrace our steps.


/////////////////////////////////////////////////////////////
	So, need to add flag field to tell which file a particular record is from
	also, need to split out all three files, spray them up separately so can sequence them properly, and preserve the order to do the groups
	need to replace(in the keys) the root and sub fields with the manufactured ones we get from the order of the recs.
	Also, need to replace the parent_number with the manufactured root and sub of the parent, and the two jv_nums with their manufactured root and subs
	A roxie release will be needed since the enterprise number has grown and will not fit inside the old field.
	also add the dotID, lgID, divID and grID fields to the layout?  At least the dotID, because from that you can figure out the others.
	manufactured ids named: LNCAgID, LNCAiID	,LNCAhgID


Look at parent numbers that have a dash at end, but nothing after it.
Bug: 67758 - BRM - DCA - Enable Searchability of Ticker, URL and Exchange Code Fields

From DCA:

We have a question on the files you sent us last time – the last Privco file was double in size and contained more than all 3 files combined.  
Does this file supersede all three files,   does it contain all the data from all the files?  Any information help you can give me will be helpful.  
We still need to use All the files? 

Good morning. The PRIVCO file is a totally separate file from the other three Corporate Affiliations files. It’s a completely different data universe altogether. 
It provides for all of our “web status” companies. This means these companies can only be found when using our web product. They are not contained in our print 
products, nor are they part of the traditional flat files that you’ve been receiving. They are the companies that fall out of the traditional Corporate Affiliations 
universe, as their criteria is different. Whereas, CA companies must have in excess of $10 million in annual revenue, the PRIVCO companies are within the 
$1-10 million range. They are mostly private domestic parents. A few months back we were instructed to begin sending it. The format is the same as the other 
files, with all relevant data elements appearing in the same field positions. Also, this file will continue to grow as we build linkage around it. Hope this 
all helps.

George, I think for our purposes, we should use all 4 files since we just want the company location information, we are not concerned with how much 
revenue the company generates.  This will also give us a big boost to the amount of DCA records we will have.  And, in the future, we will be able to 
take advantage of the linkages they build around the privco file if we start using it.  The existing build is very old, so I think this is a good opportunity 
to rewrite it using existing build standards.   What do you think?

There is no linkage yet built into the PRIVCO file but that will change as time goes on. Currently, they are ALL domestic private parents without children, 
so, yes, those fields would be unreliable at this point, however, I would advise you to NOT use company id, which is made up of root (position 8) and sub 
(position 9) to build linkage but rather enterprise number (position 1), which is different,  along with level (position 7). Every parent is a level 0, 
with level 1’s reporting to 0’s, level 2’s reporting to 1’s and so on. When you get to the next level 0, the hierarchy is complete. This goes for not just 
the PRIVCO file but the other three CA files as well. Remember, they ALL follow the same format. I’ve attached another file layout just in case. Please 
understand that the enterprise number is a unique, life-to-death numerical identifier whereas the company id (root & sub) can change. There is no overlap 
between the PRIVCO file and the other three CA files, and, again, these enterprise numbers are unique, life-to-death numerical identifiers. Hope this is clear.

*/



ddcain := DCA.File_DCA_all_In;

tools.mac_GetMaxFieldLengths(ddcain, outlengths);

output(outlengths);


so, to be compatible with what we have now, need all executives on the file
so, could have the big file, with all the fields.
then, have a separate executives(contacts) file that is derived from that that consists of:
	contact name stuff
	address(both addresses)
	phones
	unique id


I could, split the file in two, have a contacts and company file.  Now I will have on both files, the enterprise #, the level, and the dates, which should
enable me to denormalize the contacts back into the appropriate record in the companies file for keybuilding.  Can keep the stuff in child datasets for 
easier manipulation.  This way, if and when we do change keys or whatever, it will be trivial to build keys on both files.  The denorm step to put 
contacts back into the companies could be skipped and the keys built.