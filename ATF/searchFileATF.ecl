/*2012-11-05T20:25:43Z (Shannon Lucero)

*/
import atf, ut;

f := ATF.file_firearms_explosives_keybase; 

	Layout_Searchfile := RECORD
	  // unsigned6 ATF_id;
	  // ATF.file_firearms_explosives_keybase;
	  // ATF_Services.Layouts.Layout_firearms_out,
		ATF.ATF_Layout_SearchFile;
	END;
	
//ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,ATF_id,outf);
outf	:= project(f, transform(Layout_Searchfile and not [persistent_record_id, lf], self.ATF_id := left.persistent_record_id, self.did := (UNSIGNED6)left.did_out, self	:= left));

export searchFileATF := outf : PERSIST('persist::ATF_firearms_searchfile');