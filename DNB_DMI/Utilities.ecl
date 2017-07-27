export Utilities :=
module

	// Map signed field digit to number
	export integer Map_Signed_Field(string pField) :=
	 (integer)
		(
			map( pField[length(trim(pField))] in ['{','A','B','C','D','E','F','G','H','I'] => '+'
					,pField[length(trim(pField))] in ['}','j','k','l','m','n','o','p','q','r'] => '-'
					,																																							'+'
			) 
			+
			map( pField[length(trim(pField))] in ['{','}'] => pField[1..(length(trim(pField))-1)] + '0'
					,pField[length(trim(pField))] in ['A','j'] => pField[1..(length(trim(pField))-1)] + '1'
					,pField[length(trim(pField))] in ['B','k'] => pField[1..(length(trim(pField))-1)] + '2'
					,pField[length(trim(pField))] in ['C','l'] => pField[1..(length(trim(pField))-1)] + '3'
					,pField[length(trim(pField))] in ['D','m'] => pField[1..(length(trim(pField))-1)] + '4'
					,pField[length(trim(pField))] in ['E','n'] => pField[1..(length(trim(pField))-1)] + '5'
					,pField[length(trim(pField))] in ['F','o'] => pField[1..(length(trim(pField))-1)] + '6'
					,pField[length(trim(pField))] in ['G','p'] => pField[1..(length(trim(pField))-1)] + '7'
					,pField[length(trim(pField))] in ['H','q'] => pField[1..(length(trim(pField))-1)] + '8'
					,pField[length(trim(pField))] in ['I','r'] => pField[1..(length(trim(pField))-1)] + '9'
					,																							pField[length(trim(pField))]
			)
		);

	// Convert 4-character date to 6-character date
	export string6 CvtDate4to6(string4 yearMMYY) :=
		 if(yearMMYY in ['    ','0000']
				,''
				,if(yearMMYY[3..4] > (stringlib.GetDateYYYYMMDD())[3..4]
					,'19' + yearMMYY[3..4] + yearMMYY[1..2]
					,'20' + yearMMYY[3..4] + yearMMYY[1..2]
				)
		 );

	// Convert 6-character date to 8-character date
	export string8 CvtDate6to8(string6 yearMMDDYY) :=
		 if(yearMMDDYY in ['      ','000000']
				,''
				,if(yearMMDDYY[5..6] > (stringlib.GetDateYYYYMMDD())[3..4]
					,'19' + yearMMDDYY[5..6] + yearMMDDYY[1..4]
					,'20' + yearMMDDYY[5..6] + yearMMDDYY[1..4]
				)
		);
	export Fieldsign(string pfield) := 
		map( Map_Signed_Field(pfield) < 0 => '-'
				,Map_Signed_Field(pfield) > 0 => '+'
				,																 ' '
		);
	export SignedField(string pField) := 
		if(Map_Signed_Field(pField) <> 0
				,(string)abs(Map_Signed_Field(pField))
				,''
		);

	export SwitchDate(string pField) := 
		if(pField <> ''
				,pField[7..10] + pField[1..2] + pField[4..5]
				,''
		);
		
	export RemoveLeadingZeros(string pField) := 
		if((integer)pField <> 0
				,(string)((integer)pField)
				,''
		);	
	export BlankIfZero(string pField) := 
		if((integer)pField <> 0
				,pField
				,''
		);
	// For SALT
  export RecordType := ENUM(UNSIGNED1,Unknown,Unchanged,Updated,Old,New,Deleted);
  export RTToText(unsigned1 c) := CHOOSE(c,'UNKNOWN','Unchanged','Updated','Old','New','Deleted');

  export RT2CurrentHistoricalFlag(unsigned1 c) :=
		if(c in [RecordType.Updated,RecordType.New]	, 'C'
																								, 'H'
		);
		
  export CurrentHistoricalFlag2RT(string1 c) :=
		if(c = 'C'	, RecordType.Updated
								, RecordType.Old
		);

	// Determine if contact date range overlaps company date range
	export BOOLEAN ValidDateRange(unsigned4 contact_dt_first_seen,
												 unsigned4 contact_dt_last_seen,
												 unsigned4 company_dt_first_seen,
												 unsigned4 company_dt_last_seen) :=
			(contact_dt_first_seen >= company_dt_first_seen AND
					contact_dt_first_seen <= company_dt_last_seen) OR
			(contact_dt_last_seen >= company_dt_first_seen AND
					contact_dt_last_seen <= company_dt_last_seen) OR
			(company_dt_first_seen >= contact_dt_first_seen AND
					company_dt_last_seen <= contact_dt_last_seen);

end;