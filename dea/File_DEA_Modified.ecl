import DEA;

Export File_DEA_Modified := Project(Dea.File_DEAv2 , Transform(DEA.Layout_DEA_OUT_base, Self.name_score := ''; Self.score := ''; Self := Left;));