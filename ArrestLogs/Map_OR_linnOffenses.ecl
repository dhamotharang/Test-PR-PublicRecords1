import Crim_Common, Address, VersionControl;

dInOld	:= file_OR_linn.Old(~regexfind('Name|[0-9]',name) and ~regexfind('[A-Z]',charge) and length(name)>4 and ~regexfind('CONTEMPT OF COURT',charge_description));
dInNew	:= file_OR_linn.new(~regexfind('Name|[0-9]',name) and ~regexfind('[A-Z]',charge) and length(name)>4 and ~regexfind('CONTEMPT OF COURT',charge_description));

layout_OR_linn.new T(dinold pInput)
  := TRANSFORM
      SELF.ID:=pInput.Master_ID;
	  SELF   :=pInput;
   END;
   
Din:=dInNew+PROJECT(dInOld,t(left));

Crim_Common.Layout_In_Court_offenses tGwinnett(dIn pinput) 
	:= TRANSFORM
	
	    arr_desc :=IF(REGEXFIND('ERROR',pInput.Charge_Description),'',REGEXREPLACE('/$|[0-9]|[(]|[)]|[-]$|[#]+$|[<]$|[>]$|FEL|MISD',trim(pInput.Charge_Description,left,right),''));
		
		SELF.process_date		:= Crim_Common.Version_In_Arrest_Offender;
		SELF.offender_key		:= (sTRING)'G3'+pInput.id+hash(pInput.name); 
		SELF.vendor				:= 'G3';
		SELF.state_origin		:= 'OR';
		SELF.source_file		:= '(CV)OR-LinnCtyArr';
		SELF.arr_disp_desc_1 	:= 'BOOKED';
		SELF.arr_off_desc_1     :=  IF(LENGTH(TRIM(arr_desc,ALL))>4 OR ARR_DESC='DUI',REGEXREPLACE('[/]$|[-]$|[#]+$|[<]$|[>]$|[*] ',TRIM(arr_desc,RIGHT),' '),'');
		SELF.arr_off_lev        :=  MAP(REGEXFIND('FEL',pInput.charge_Description)=>'F',REGEXFIND('MISD',pInput.charge_Description)=>'M','');
		SELF                    := [];
	 END;

dProject := PROJECT(dIn, tGwinnett(LEFT));




dRollup  := DEDUP(SORT(DISTRIBUTE(dProject,HASH(offender_key)),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev ,local),
								   offender_key,le_agency_desc,arr_off_desc_1,arr_off_lev):
								   PERSIST('~thor_dell400::persist::Arrestlogs::OR::LinnOffenses');

export Map_OR_linnOffenses := dRollup;