IMPORT STD;

// The following script sprays a file from a Landing Zone to a Thor. It will also
// output (1) a sample from the file as well as (2) the name assigned to the file 
// on Thor.

// 1.  Copy the name of the file on the Landing Zone and paste here:
landingZoneFilename := 'lnretro_linkid_20171002_1_output.txt';

// 2. That's it! Click "Submit".
sourceIP         := 'cargo.risk.regn.net'; // cargoDayton dropzone
spray_folder     := '/data/';
sourcePath       := spray_folder + landingZoneFilename;
maxRecordSize    := 8192;
srcCSVquote      := '\"';
destinationGroup := 'thor50_dev02';
doAllowOverwrite := TRUE;
dontReplicate    := FALSE;
doCompress       := TRUE;

root := '~thor::cortera::retrotester::results::';
destinationFileName := root + Std.Str.tolowercase(landingZoneFilename);

sprayFile := STD.File.SprayVariable(
          sourceIP,
          sourcePath,
          maxRecordSize,
          , // srcCSVseparator (default is '\\,')
          , // srcCSVterminator (default is '\\n,\\r\\n')
          srcCSVquote,
          destinationGroup,
          destinationFileName,
          , // timeout (default is -1)
          , // espserverIPport (default is the value in the lib_system.ws_fs_server attribute)
          , // maxConnections (default is 1)
          doAllowOverwrite,
          dontReplicate,
          doCompress
        );

ds_sprayedFile        := DATASET( destinationFileName, Cortera.layout_Retrotest_raw, CSV( QUOTE('"') ) );
outputSprayedFile     := OUTPUT( CHOOSEN(ds_sprayedFile,100), NAMED('sample_sprayedFile') );
outputSprayedFileName := OUTPUT( destinationFileName, NAMED('sprayedFileName') );

SEQUENTIAL( sprayFile, outputSprayedFile, outputSprayedFileName );

// File not found error example:
// DFUServer Error Failed: Could not open source file //10.140.128.250/data/fileNotHere.txt (0, 0), 0, 
