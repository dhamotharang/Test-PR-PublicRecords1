Transunion_Delete := DATASET('~thor_data400::in::transunionptrak_delete',
						Transunion_PTrak.Layout_Transunion_Delete , 
						thor);
						
Layout_Delete_temp := record
string12 PARTYID;
end;

Transunion_Delete_t := project(Transunion_Delete , transform(Layout_Delete_temp, self.PARTYID := '0' + left.PARTYID));

EXPORT File_Transunion_Delete := Transunion_Delete_t;