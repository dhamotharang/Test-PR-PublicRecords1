/////////////////////////////// How to add a new file to bair boolean build? /////////////////
/////////////////////////////// How to add a new file to bair boolean build? /////////////////
/////////////////////////////// How to add a new file to bair boolean build? /////////////////

// 1. Get spc file

// Example:

// salt.MAC_Default_SPC({Bair.files().mo_Base.built},o);
// o;

// 2. Select Insert File from the IDE context menu and enter the name (e.g., xyz_spc), for 
// the specification file and then select SALT specification from the type list.  Copy the 
// result content from the WU above into the new attribute.

// 3. Change the module name in spc file bair_boolean and file_name to a name that matches 
// your data.  Add the directives to define the RID, document identifier, and source.  In
// the cfs case, the string version of the record identifier and the external key is the 
// EID field.
// Example: cfs_base == this is important because when the attributes are generated it will
// use a layout named "layout_cfs_base" which will be created later (see below in step 5.)
// You will also need an OPTIONS directive to tell SALT to generate for Boolean
//The specification file statements are:
OPTIONS:-bh
MODULE:bair_boolean.cfs_base
FILENAME:cfs_base
RIDFIELD:newrid:GENERATE
DOCFIELD:eid:HASH5
IDNAME:newrid
IDSPACE:MDR.sourceTools.src_Bair_Analytics
FIELD:eid:0,0


// 4. Save the file. This will generate a xyzBooleanSearch attribute, and will record what
// was done in a xyzGenerationDocs.  An xyzConfig attribute is also produced whcih you can
// use to overide the defalt configuration information if necessary. 

// 5.  Create a new base layout for the new file, similar to the following example 

EXPORT layout_cfs_base := record // note the name cfs_base which is the same as file name mentioned in .spc file
	bair.layouts.dbo_cfs_Base; // replace this with the new base file layout attribute
	BIPV2.IDlayouts.l_xlink_ids;
END;


// ------------- Create fragments attribute --------------------

// 6. Create a new attribute like "cfsfragments" for the new file.
// The purpose of this attribute is connect the source data to the xyzBooleanSearch module,
// and to define how to create the Answer Records from the source data.

// 7. Copy/paste the contents on cfsfragments into the new attribute.

// 8. replace "cfs" with the prefix string for your data.  "mo" for example if adding mo file.

// 9. Save, syntax check if all good, check in.

// ------------- add new fragment dataset to the fragment builder --------------------

// 10. Open fragment_builder

// 11. Add the following lines in "frags" section and replace "cfs" with name that matches new file

	// cfs frags
	SHARED cfsfrags := cfsfragments(st_list);
	EXPORT cfsfrags_postings := cfsfrags.rawPostings;
	EXPORT cfs_recs := cfsfrags.answerRecs;
  
// 12.  Add the delete persist action to the Cleanup_Persist export.

// 13. Add unified segment data for new file
// Example:  
  & mofrags.SegmentDefinitions

// 14. Add new postings file to the combined postings
// Example: 
  IF(Types.SourceItem.mo IN sources, mofrags_postings),

// 15. Add the answers records to the combined answer records
// Example: 	
  IF(Types.SourceItem.mo IN sources, mo_rec),

// 16. Save, syntax check if all good, check in.

// ---------------------------------------------------------------------------------------------

// 17. Change the date below and syntax check the following. If all looks good submit the job.

// #OPTION('multiplePersistInstances',FALSE);
// bair_boolean.proc_build_boolean_keys('20150708');