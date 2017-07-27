EXPORT Restrictions := Module
	Export setRestrictionFlags(String RestrictFlags, String PermissionFlags) := Function
		hasPermission := '1';//Permission has to be turned on to have rights
		Healthcare_Shared.Layouts_Restrictions.DataRights setRestrictions():=transform
			self.hasABMS := PermissionFlags[14] = hasPermission;
			self.hasAHA := RestrictFlags[27] = hasPermission;
			self.hasAMA := RestrictFlags[32] = hasPermission;
			self.hasArizonaPayor := RestrictFlags[33] = hasPermission;
			self.hasBillians := RestrictFlags[34] = hasPermission;
			self.hasBilliansContacts := RestrictFlags[35] = hasPermission;
			self.hasDNB := RestrictFlags[31] = hasPermission;
			self.hasDefinitiveHealthcare := RestrictFlags[28] = hasPermission;
			self.hasDMD := PermissionFlags[15] = hasPermission;
			self.hasEmdeonClaims := RestrictFlags[36] = hasPermission;
			self.hasHCCE := RestrictFlags[37] = hasPermission;
			self.hasHealthLinkDimensions := RestrictFlags[38] = hasPermission;
			self.hasHIBCC := PermissionFlags[16] = hasPermission;
			self.hasMDSI := RestrictFlags[29] = hasPermission;
			self.hasMedAvant := RestrictFlags[39] = hasPermission;
			self.hasMedicaidID := RestrictFlags[40] = hasPermission;
			self.hasNCPDP := RestrictFlags[21] = hasPermission;
			self.hasStateLicenses := RestrictFlags[30] = hasPermission;
			self.hasStateLicenseAddress := PermissionFlags[17] = hasPermission;
			self.hasStateLicenseLicNbr := PermissionFlags[18] = hasPermission;
			self.hasStrenuus := RestrictFlags[41] = hasPermission;
			self.hasStrenuusHIX := RestrictFlags[42] = hasPermission;
			self.hasSurescripts := PermissionFlags[19] = hasPermission;
			self.hasSymphony := RestrictFlags[43] = hasPermission;
			self.hasSKA := RestrictFlags[22] = hasPermission;
			self.restriction_mask := RestrictFlags;
			self.permission_mask := PermissionFlags;
		end;
		Restrict:=dataset([setRestrictions()]);
		return Restrict[1];
	End;
End;