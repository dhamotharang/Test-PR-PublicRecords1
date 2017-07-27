/* NOTE: I made some fixes to filenames before spraying KY.  If you respray, 
	you will probably have to do it again.  There were 2 sets of fixes.
	
		1) 2 files had commas instead of . in their names.  Commas were changed
			to dots both in the filename before spraying AND in the moxie info
			file, which was given a new "_fixKY" extension.
		2) many files had .jpg.jpg extension which was updated to .jpg
			moxie info file did not have any filenames with .jpg.jpg extension
			so no changes were made there.
	
	NOTE: because of #1 above, moxie info file had to change as well, as explained.
*/

export File_Kydc_In := DATASET('~images::in::ky20040316', Layout_MoxieBigDC_In, flat);