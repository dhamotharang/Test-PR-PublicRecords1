// DF-28230: Delta build 
// When processing Equifax full replace file, use the input file(s) to create new base file.
// When processing Equifax weekly update and/or Alpharetta daily input file, join the records in 
// input files with existing base file, get the new records and creat delta base file
IMPORT VersionControl, STD, data_services;
EXPORT Proc_Build_Base(STRING filedate, BOOLEAN isDeltaBuild=false) := FUNCTION

    new_inputs := fcra_opt_out.clean_opt_out_data(filedate) ;
    // new_inputs := dataset(data_services.foreign_prod+'thor_data400::temp::fcra::opt_out::new_inputs::20210204a',
	// 	                      fcra_opt_out.layout_infile_appended,thor);

    base_curr := $.file_infile_appended;

    base_new := IF(isDeltaBuild,
                JOIN(distribute(new_inputs),distribute(base_curr(trim(source_flag) <> '5')),
                        LEFT=RIGHT,
                        LEFT ONLY, LOCAL),
                new_inputs(trim(source_flag) <> '5'));

    base_new_dedup := DEDUP(DISTRIBUTE(base_new),RECORD, LOCAL);

    // Build base file and perform superfile transaction
    VersionControl.macBuildNewLogicalFile($.Filenames(filedate).Base.Delta.new      ,base_new_dedup,buildDeltaBase,TRUE);
    VersionControl.macBuildNewLogicalFile($.Filenames(filedate).Base.FullReplace.new,base_new_dedup,buildFullBase ,TRUE);

    // Previous superfile contains the content of base file before a new one is built. This file is used when population keys
    clr_prev_sf := IF(NOT FileServices.SuperFileExists(fcra_opt_out.FileNames().Base.OptOutPrevious),
                      FileServices.CreateSuperFile(fcra_opt_out.FileNames().Base.OptOutPrevious),
                      FileServices.ClearSuperFile(fcra_opt_out.FileNames().Base.OptOutPrevious)
                     );
     // Add all logical files in current base to previous base file
     setup_prev_sf := FileServices.AddSuperfile(fcra_opt_out.FileNames().Base.OptOutPrevious,fcra_opt_out.Filenames().Base.OptOut.QA,0,TRUE);

    DeltaSteps:=sequential(
        clr_prev_sf,
        setup_prev_sf,
        buildDeltaBase,
        fileservices.addsuperfile($.Filenames().Base.OptOut.QA, $.Filenames(filedate).Base.Delta.new);
    );
    FullSteps:=sequential(
        clr_prev_sf,
        buildFullBase,
        STD.File.PromoteSuperFileList([$.Filenames().Base.OptOut.QA,$.Filenames().Base.OptOut.father,$.Filenames().Base.OptOut.grandfather],$.Filenames(filedate).Base.FullReplace.new,true);
    );

    BuildBase:=if(isDeltaBuild,DeltaSteps,FullSteps);

    RETURN BuildBase;

END;    
