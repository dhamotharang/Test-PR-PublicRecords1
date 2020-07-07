IMPORT doxie_raw,doxie,Relationship;

EXPORT Layouts :=
MODULE

	SHARED HeadRelSlim :=
	RECORD
		BOOLEAN subject;
		doxie_raw.Layout_RelativeRawOutput.p2_sort;
		doxie_raw.Layout_HeaderRawOutput.did;
		doxie_raw.Layout_RelativeRawOutput.number_cohabits;
		doxie_raw.Layout_RelativeRawOutput.recent_cohabit;
		UNSIGNED1 age;
		STRING1   gender;
		doxie_raw.Layout_HeaderRawOutput.fname;
		doxie_raw.Layout_HeaderRawOutput.lname;
		UNSIGNED4 r_first_seen := 0;
		UNSIGNED4 r_last_seen := 0;
		BOOLEAN   early_lname := FALSE;
		UNSIGNED1 parent_lnames_count := 0;
		BOOLEAN   subject_early_lname := FALSE;
	END;
	
	SHARED RelRelation :=
	RECORD
		BOOLEAN   inlaw;
		BOOLEAN   possible_husband;
		BOOLEAN   possible_wife;
		BOOLEAN   possible_parent;
		BOOLEAN   possible_sibling;
		BOOLEAN   possible_child;
		BOOLEAN   ex;
		BOOLEAN   gd;
		STRING1   gender;
		STRING25  fname;
		STRING25  lname;
		UNSIGNED2 age;
		STRING20  debug := '';
	END;
	
	EXPORT RelDetailsIn :=
	RECORD(doxie.layout_references)
		UNSIGNED6 seq;
	END;
	
	EXPORT DIDsOfIntWSubj :=
	RECORD
		UNSIGNED6 seq;
		UNSIGNED6 src_did;
		doxie.layout_references;
	END;
	
	EXPORT RelDetailsTemp :=
	RECORD
		UNSIGNED6	seq;
		UNSIGNED6 src_did;
		UNSIGNED6 did_of_interest       := 0;
		BOOLEAN   found_did_of_interest := FALSE;
		UNSIGNED1 depth                 := 0;
		STRING1   mode                  := '';
		UNSIGNED2 p2_sort               := 0;
		UNSIGNED2 p3_sort               := 0;
		UNSIGNED2 p4_sort               := 0;
		UNSIGNED5 person1;
		UNSIGNED5 person2;
		INTEGER3 	recent_cohabit;
		UNSIGNED2 number_cohabits;
		INTEGER2  prim_range;
		Relationship.layout_GetRelationship.InterfaceOutput_new.isRelative;
		Relationship.layout_GetRelationship.InterfaceOutput_new.title;
	END;
	
	EXPORT RelDetailsOut := {RelDetailsTemp - [did_of_interest,found_did_of_interest,title],STRING20 title};

END;
