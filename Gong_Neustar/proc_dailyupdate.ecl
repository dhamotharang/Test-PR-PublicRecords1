EXPORT proc_dailyupdate(dataset(Layout_Neustar) infile, string fileno, string histflag = '') := function

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Add Sequence Number and add temp fields to prep for: 
		//		address cleaning
		//		caption propogation and 
		//		name cleaning
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		layout_temp_for_daily_raw_processing t_rawUpdate(dataset(Layout_Neustar) L, integer C) := transform

			isheader				:=  L.action_code in ['A','I'] and L.indent=0;
			isSubHdr2dtl			:= L.action_code in ['A','I'] and L.indent > 0;

			self.sequence_number 	:= c;
			self.Record_ID    		:= l.Record_ID;
			self.SeisintID  		:= map(isheader  => stringlib.stringfilter(stringlib.stringtouppercase(l.Record_ID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'');
			self.temp_hseno			:= map(isSubHdr2dtl => L.primary_street_number,'');
			self.temp_hsesx			:= map(isSubHdr2dtl => L.primary_street_number,'');
			self.temp_strt			:= map(isSubHdr2dtl => L.primary_street_name ,'');
			self.filedate	 		:= fileno[1..8] + '_01';
			//self.ven_reg			:= L.data_source;
			//self.special_listing_txt:= stringlib.stringtouppercase(L.business_captions);
			//self.fsn				:= stringlib.stringtouppercase(L.business_name);
			self                    := L;
		end;

		p_seqUpdate := project(infile, t_rawUpdate(left,counter));

		//Separate Adds and Deletes
		//project back to old temp layout to avoid having to run all the deletes thru the new one
		deletes	:= p_seqUpdate(action_code='D');
		adds    := p_seqUpdate(action_code in ['A','I']);

		layout_temp_for_daily_raw_processing  concatCaps(ungroupUpdate L,ungroupUpdate R ) := transform

			 self.temp_cap1 := if(r.indent = 1,r.dirtx,if(r.indent > 1,l.temp_cap1,''));
			 self.temp_cap2 := if(r.indent = 2,r.dirtx,if(r.indent > 2,l.temp_cap2,''));
			 self.temp_cap3 := if(r.indent = 3,r.dirtx,if(r.indent > 3,l.temp_cap3,''));
			 self.temp_cap4 := if(r.indent = 4,r.dirtx,if(r.indent > 4,l.temp_cap4,''));
			 self.temp_cap5 := if(r.indent = 5,r.dirtx,if(r.indent > 5,l.temp_cap5,''));
			 self.temp_cap6 := if(r.indent = 6,r.dirtx,if(r.indent > 6,l.temp_cap6,''));
			 self.temp_cap7 := if(r.indent = 7,r.dirtx,if(r.indent > 7,l.temp_cap7,''));
			 
			 //Propogate SubHd2 detail records that have addresses
			 //self.temp_hseno := map(R.temp_hseno != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hseno, L.hseno);
			 //self.temp_hsesx := map(R.temp_hsesx != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hsesx, L.hsesx);
			 //self.temp_strt  := map(R.temp_strt  != '' and R.lststy = '2' and R.indent > '1'  => R.temp_strt , L.strt );
			 self := R;
	end;

	iCaps := iterate(adds,concatCaps(left,right));
	return 1;
end;