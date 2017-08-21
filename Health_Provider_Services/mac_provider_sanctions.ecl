import HealthCareProvider;
export mac_provider_sanctions  (Infile,Input_LNPID,Input_Lic_NBR = '',Input_Lic_State = '',Outfile) := MACRO
			
#UNIQUENAME(hasUniqueId)
ut.hasField(infile, UniqueId, %hasUniqueId%);

#uniquename(layout_seq)
%layout_seq% := record
	#IF (~%hasUniqueID%) unsigned8 uniqueID; #END	
	recordof(infile);
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned4 cnt) := transform
	self.uniqueID := #IF (%hasUniqueID%) l.uniqueID; #ELSE cnt; #END
	self := l;
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := %infile_seq_1%; //if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);

#uniquename(into)
HealthCareProvider.Layouts.Sanction_Input %into%(%infile_seq% le) := TRANSFORM
  SELF.UniqueId := le.uniqueId;
	#IF ( #TEXT(Input_LNPID) <> '' )
    SELF.LNPID := (TYPEOF(SELF.LNPID))le.Input_LNPID;
  #ELSE
    SELF.LNPID := (TYPEOF(SELF.LNPID))'';
  #END
  #IF ( #TEXT(Input_LIC_NBR) <> '' )
    SELF.LIC_NBR := (TYPEOF(SELF.LIC_NBR))le.Input_LIC_NBR;
  #ELSE
    SELF.LIC_NBR := (TYPEOF(SELF.LIC_NBR))'';
  #END
  #IF ( #TEXT(Input_LIC_STATE) <> '' )
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
  #ELSE
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))'';
  #END
	SELF := [];
END;

#uniquename(pr)
%pr% := project(%infile_seq%,%into%(left)); // Into roxie input format

#uniquename(sanction_data)
%sanction_data% := HealthCareProvider.ExtractSanction (%pr%);

#uniquename(layout_resp)
%layout_resp% := record
	recordof(infile);
		BOOLEAN 	hasStateSanction;
		BOOLEAN		hasOIGSanction;
		BOOLEAN 	hasOPMSanction;
		STRING8 	SanctionDate;
		STRING25 	SanctionLicenseNumber;
		STRING2		SanctionLicenseState;
		STRING10	SanctionCode;
		STRING250 SanctionDescription;
		STRING50	ProfessionalType;
		STRING8		ReInstatementDate;
		STRING50	Category;
		STRING15	Level;
		STRING100	LegacyType;
		BOOLEAN		LossOfLicense;
		STRING7 	StateORFederal;
		STRING100	RegulatingBoard;
		STRING50	SanctionLicenseStatus;
end;

outfile := JOIN (%infile_seq%,%sanction_data%,LEFT.UniqueID = RIGHT.UniqueID,TRANSFORM(%layout_resp%, SELF := left; SELF := RIGHT), LEFT OUTER, HASH);;
ENDMACRO;																			
