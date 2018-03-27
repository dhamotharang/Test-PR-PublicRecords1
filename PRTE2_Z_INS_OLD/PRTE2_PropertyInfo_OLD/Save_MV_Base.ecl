// --- NEW FUNCTION TO BEGIN SAVING A BASE FILE COMPATIBLE WITH MAPView needs ------------

IMPORT PRTE2_PropertyInfo, PromoteSupers;

EXPORT Save_MV_Base := FUNCTION
		All_Expanded := Get_Payload.All_Expanded;
		MV_Base_Name := Files.ALPHA_MV_BASE_SF;
		MV_Base_Layout := Layouts_MV.MV_Base_Layout;
		tradematerial_Lay := Layouts_MV.tradematerials;
		MV_Base_Layout trxData(All_Expanded L) := TRANSFORM
			SELF.insurbase_codes := DATASET([],tradematerial_Lay);
			SELF := L;
		END;
		MV_Base_Final := PROJECT(All_Expanded,trxData(LEFT));
		PromoteSupers.Mac_SF_BuildProcess(MV_Base_Final, MV_Base_Name, build_MV_base);

		RETURN build_MV_base;
END;