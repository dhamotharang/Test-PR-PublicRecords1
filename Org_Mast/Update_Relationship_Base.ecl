
import std, ut;

Today := Std.Date.SecondsToString(std.date.CurrentSeconds(true), '%Y%m%d%H%M%S');
EXPORT Update_Relationship_Base (STRING filedate, STRING Affldate, STRING ORG_Mst_Date,boolean pUseProd = false) := module


	EXPORT Relationship_base := FUNCTION
		Aff_Table := dataset ('~thor400_data::Base::org_master::org_master_affiliations::'+Affldate,org_mast.layouts.affiliations_base, THOR);
		Org_Table := dataset ('~thor400_data::Base::org_master::org_master_organization::'+ORG_Mst_Date,org_mast.layouts.organization_base, THOR);
		//Indiv_Table := dataset ('~thor400_data::Base::HMS_PM::HMS_individuals::'+pversion,HMS.layouts.individual_base, THOR);
		s_Aff_Table := SORT(Aff_Table,LNFID);
		s_Org_Table	:= SORT (Org_Table,LNFID);

		Org_mast.Layouts.Relationship_base xform( s_Aff_Table L,  s_Org_Table R) := Transform
			SELF.RID := 0;
			SELF.Src := 0;
			SELF.iD1 := (string20)L.LNFID;
			SELF.ID1Type := 'F';
			SELF.iD2 := L.HMS_PIID;
			SELF.ID2Type := 'P';
			SELF.RelationshipType := L.FACTYPE;
			SELF.EffectiveDate := Today[..8];
			SELF.ExpireDate := '';
		end;
		Relationship := JOIN(s_Aff_Table, s_Org_Table, LEFT.LNFID = RIGHT.LNFID, xform(LEFT,Right), LEFT OUTER, LOOKUP);
		//Relationship := Relationship1:PERSIST('~thor400_data::PERSIST::org_master::Org_Base11::'+filedate);
		ut.MAC_Sequence_Records(Relationship,RID,outfile1);
		outfile := outfile1:PERSIST('~thor400_data::PERSIST::org_master::Org_Base12::'+filedate);
/*
   		outf1 := outfile + Relationship;
   		outf := outf1:PERSIST('~thor400_data::PERSIST::org_master::Org_Base10::'+filedate);
   		output(count(outf), named ('Count_OutF'));
   		mxr:=max(outf,RID);
   		Org_Mast.Layouts.Relationship_base to_form(outf l) := transform
      			self.rid    := IF (l.rid=0,mxr+1,l.rid);
      			// self.did    := IF (l.did=0,mxr+l.uid,l.did);
      			// self.pflag1 := MAP(l.did=0=>'A',l.rid=0=>'P','+');
      			self := l;
      		end;

      		new_Relationship := project(outf,to_form(left));

		// Note that this file is regenerated everytime the input files are processed and Affiliations & Organization base files are created
		// As such the RecordIds are created by the macro above & all records get a recordid (RID)
*/
		RETURN outfile;//new_Relationship;
	END; // Function
END; // Module
