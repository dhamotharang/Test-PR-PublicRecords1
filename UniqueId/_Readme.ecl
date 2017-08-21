/**************************************************************************
These are the steps required to build the unique id files.

1) Data Receiving will provide the file yyyymmdd-xx-MasterList.zip
2) Create a directory /hds_3/uniqueid/input/yyyymmdd and move the zip file there
3) unzip the file so that MasterList.xml is made available
4) Executable will convert that file into two files that uniqueid requires
5) To run the exe, cd /hds_3/uniqueid
6) ./ConvertGWLFormat_id3 yyyymmdd
   this will create two files: MasterListEntityConverted.xml and MasterListCountryConverted.xml
7) To spray the files:
	 UniqueId.SprayVersion('yyyymmdd');
8) To run the process:
   UniqueId.ProcessNewGlobalWatchlist('yyyymmdd');
	 
This will create 53 files and despray them to: /hds_3/uniqueid/output
.

***************************************************************************/
EXPORT _Readme := 'todo';