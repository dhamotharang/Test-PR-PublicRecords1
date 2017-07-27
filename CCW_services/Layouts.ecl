import emerges,iesp, FFD;
export Layouts := MODULE
			export rawrec := record
					recordof(emerges.key_CCW_rid);
					boolean isDeepDive := false;
					unsigned2 penalt := 0;
					dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
					boolean isDisputed := false;
			end;
			 
			 
			export search_rid := record
					unsigned6 rid;
					boolean isDeepDive := false;
			end;
			
		  export search_did := record
					unsigned6 did;
					boolean isDeepDive := false;
		  end;			
				
		  export t_CCWRecordWithPenalty := record
					iesp.concealedweapon.t_WeaponRecord;
					boolean AlsoFound;
					unsigned2 _penalty := 0;
					boolean isDisputed := false;
					dataset(FFD.Layouts.StatementIdRec) StatementIds := dataset([],FFD.Layouts.StatementIdRec);
		  end;
end;			 