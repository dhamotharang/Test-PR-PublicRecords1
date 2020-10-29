EXPORT _Functions := MODULE

	EXPORT fn_Expand_Phone_Range(dataset(recordof(Phone_TCPA.Layout_TCPA.Daily)) inFile, string2 phoneType):= FUNCTION
		
		//Assign Phone Type
		pT			:= if(phoneType = 'CL', '0',
								if(phoneType = 'LC', '1', ''));

		//Distribute Input File
		distIn	:= distribute(inFile);

		//Count Number of Cellphones in a Range
		Phone_TCPA.Layout_TCPA.Main rngTr(distIn l):= transform
			
			fndDt	:= l.filename[length(trim(l.filename, left, right))-7..];	
		
			self.num										:= 0;
			self.phone									:= l.cellphone;
			self.expand_end_range 			:= if(l.end_range<>'', l.cellphone[1..6] + l.end_range, '');	
			self.expand_range_max_count	:= if(l.end_range<>'', ((integer)self.expand_end_range - (integer)l.cellphone) + 1, 0);
			self.expand_phone						:= '';
			self.is_current							:= TRUE;
			self.dt_first_seen					:= (integer)fndDt;
			self.dt_last_seen						:= (integer)fndDt;
			self.phone_type							:= pT;
			self 												:= l;
		end;

		expRng 		:= project(distIn, rngTr(left));
		
		//Populate Expanded Cellphone
		Phone_TCPA.Layout_TCPA.Main expRngTr(expRng l, integer c) := transform
			self.num 										:= c; 
			self.expand_phone 					:= (STRING10)((((unsigned8)l.phone) + c) - 1);
			self 												:= l;
		end;

		expandRng := normalize(expRng, left.expand_range_max_count, expRngTr(left, counter));

		RETURN expandRng; 

	END;
	
	EXPORT fn_Map_Phone_NoRange(dataset(recordof(Phone_TCPA.Layout_TCPA.Daily_NoRange)) inFile, string2 phoneType):= FUNCTION

		//Assign Phone Type
		pT			:= if(phoneType = 'CL', '0',
								if(phoneType = 'LC', '1', ''));
		
		//Distribute Input File
		distIn	:= distribute(inFile);

		//Count Number of Cellphones in a Range
		Phone_TCPA.Layout_TCPA.Main rngTr(distIn l):= transform
		
			fndDt	:= l.filename[length(trim(l.filename, left, right))-7..];	
			
			self.num										:= 0;
			self.phone									:= l.cellphone;
			self.end_range							:= '';
			self.expand_end_range 			:= '';	
			self.expand_range_max_count	:= 0;
			self.expand_phone						:= l.cellphone;
			self.is_current							:= TRUE;
			self.dt_first_seen					:= (integer)fndDt;
			self.dt_last_seen						:= (integer)fndDt;
			self.phone_type							:= pT;
			self 												:= l;
		end;

		noRng 		:= project(distIn, rngTr(left));
		
		RETURN noRng;

	END;
	
END;