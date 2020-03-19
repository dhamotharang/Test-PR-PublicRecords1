/*
a.	Verify input records
    i.	Fields are populated correctly
b.	Keys are populated
c.	Check for duplication
d.	Verify production logic
e.	Verify lexid(s) are populated correctly
f.	Verify linkid(s) are populated correctly
g.	Verify name/address are cleaned properly
h.	Verify standardized code(if applicable)
i.	Verify global_sid field is populated correctly
j.	Verify source field is populated correctly
*/

/*
a.	Verify input records
    i.	Fields are populated correctly
*/
PRTE2_YellowPages := PRTE2_YellowPages.Files.YellowPages_Base;

OUTPUT(COUNT(PRTE2_YellowPages));
OUTPUT(PRTE2_YellowPages);

/* b.	Keys are populated */

Key_YellowPages_Bdid := PULL(Keys.Key_YellowPages_Bdid);
Key_YellowPages_Phone := PULL(Keys.Key_YellowPages_Phone);
Key_YellowPages_Linkids := PULL(Keys.Key_YellowPages_Linkids);

OUTPUT(Key_YellowPages_Bdid);
OUTPUT(Key_YellowPages_Bdid);
OUTPUT(Key_YellowPages_Bdid);

/* c. Check for duplication */

OUTPUT(COUNT(PRTE2_YellowPages));
OUTPUT(COUNT(DEDUP(SORT(PRTE2_YellowPages,source_rec_id),source_rec_id)));
OUTPUT(PRTE2_YellowPages - DEDUP(SORT(PRTE2_YellowPages,source_rec_id),source_rec_id));

/* f.	Verify linkid(s) are populated correctly */

OUTPUT(COUNT(PRTE2_YellowPages(bdid=0)));
OUTPUT(PRTE2_YellowPages(bdid=0));
OUTPUT(COUNT(PRTE2_YellowPages(link_fein='')));
OUTPUT(PRTE2_YellowPages(link_fein=''));

/* j. Verify source field is populated correctly */

OUTPUT(COUNT(PRTE2_YellowPages(source<>'')));
OUTPUT(COUNT(PRTE2_YellowPages(source='')));


