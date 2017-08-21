import watercraft;

search := watercraft.Layout_Watercraft_Search_Base;

export layout_jr_patch := record
 search.orig_name;
 search.orig_name_first;
 search.orig_name_middle;
 search.orig_name_last;
 search.orig_name_suffix;
 search.title;
 search.fname;
 search.mname;
 search.lname;
 search.name_suffix;
 search.name_cleaning_score;
 string5  rc_title;
 string20 rc_fname;
 string20 rc_mname;
 string20 rc_lname;
 string5  rc_name_suffix;
 string3  rc_name_cleaning_score;
end;