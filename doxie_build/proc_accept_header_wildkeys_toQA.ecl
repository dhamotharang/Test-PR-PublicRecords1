import roxiekeybuild;

roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.ssn.did','Q',mv1);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.ssn.did.en','Q',mv1_5);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.st.fname.lname','Q',mv2);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.pname.zip.name.range','Q',mv3);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.lname.fname','Q',mv4);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.phone','Q',mv5);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname','Q',mv6);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.pname.prange.st.city.sec_range.lname.en','Q',mv6_5);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.zip.lname.fname','Q',mv7);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.fname_small','Q',mv8);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.st.city.fname.lname','Q',mv9);
roxiekeybuild.Mac_SK_Move_v2('~thor_data400::key::header.wild.lname.fname.st.city.z5.pname.prange.sec_range','Q',mv10);

export Proc_Accept_Header_Wildkeys_toQA := 
        parallel(mv1, mv1_5, mv2, mv3, mv4, mv5, mv6, mv6_5, mv7, mv8, mv9, mv10);