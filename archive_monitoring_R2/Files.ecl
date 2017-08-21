// This file can be used to store each new customer file info (names, etc.)

QA := Environment.QA_NAME;

EXPORT Files := MODULE

  // ==============================================================
  // ==== DEFINES FILE NAMES COMMON FOR MONITOR UPDATE PROCESS ====
  // ==============================================================
  EXPORT Names := MODULE
    // backup workunits
    export WUID_BACKUP_MAIN := 'Monitor: main backup';
    export WUID_BACKUP_RAW := 'Monitor: raw client backup';

    // directories 
    export THOR_ROOT  := environment.THOR_CLUSTER + 'monitoring::'; 
    export BACKUP_DIR := environment.THOR_CLUSTER + 'monitoring::backup::'; 
    export RESULT_DIR := environment.THOR_CLUSTER + 'monitoring::result::'; 

    // Global filenames, shared among all clients
    export MONITOR := THOR_ROOT + 'monitor_db';
    export ADDRESS_SHORT_TERM  := THOR_ROOT + 'address_short_term';
    export PHONE_SHORT_TERM    := THOR_ROOT + 'phone_short_term';
    export PROPERTY_SHORT_TERM := THOR_ROOT + 'property_short_term';
    export PAW_SHORT_TERM      := THOR_ROOT + 'paw_short_term';

    // common files' types names
    export ARCHIVE     := 'archive';
    export RAW         := 'monitor_raw';
    export SUBMONITOR  := 'submonitor';
    export REPORT      := 'reports';
    export STH_ADDRESS := 'sth_address';
    export STH_PHONE   := 'sth_phone';
    export STH_PROPERTY := 'sth_property';
    export STH_PAW      := 'sth_paw';

    // customer files' names
    // NCO:
    export NCO_ROOT    := THOR_ROOT + 'NCO::';
    export NCO_ARCHIVE := NCO_ROOT + ARCHIVE;
    export NCO_RAW     := NCO_ROOT + RAW;
    export NCO_REPORT  := NCO_ROOT + REPORT;

    // PRA:
    export PRA_ROOT    := THOR_ROOT + 'PRA::';
    export PRA_ARCHIVE := PRA_ROOT + ARCHIVE;
    export PRA_RAW     := PRA_ROOT + RAW;
    export PRA_REPORT  := PRA_ROOT + REPORT;

    // PRA:
    export BWH_ROOT    := THOR_ROOT + 'BWH::';
    export BWH_ARCHIVE := BWH_ROOT + ARCHIVE;
    export BWH_RAW     := BWH_ROOT + RAW;
    export BWH_REPORT  := BWH_ROOT + REPORT;

    export ZERO_BYTE   := NCO_ROOT + 'nco_zero_byte';
  END;


  // ===============================================================================
  // ============         MAIN FILES (SHARED AMONG ALL CUSTOMERS)       ============
  // ===============================================================================
  EXPORT real_Monitor := DATASET (Names.MONITOR, layouts.monitor, THOR, OPT);

  // (NB: address & phones are supposed to be cleaned fairly often by Monitor process)
  EXPORT ShortHistoryAddr := DATASET (Names.ADDRESS_SHORT_TERM, layouts.address_history_ext, THOR, OPT);
  EXPORT ShortHistoryPhone := DATASET (Names.PHONE_SHORT_TERM, layouts.phone_history_ext, THOR, OPT);
  EXPORT ShortHistoryProperty := DATASET (Names.PROPERTY_SHORT_TERM, layouts.property_history_ext, THOR, OPT);
  EXPORT ShortHistoryPAW      := DATASET (Names.PAW_SHORT_TERM, layouts.paw_history_ext, THOR, OPT);


  // ===============================================================================
  // ============           CLIENT FILES, HAVING SAME LAYOUTS           ============
  // ===============================================================================
  // archive and raw fiels can be shared only (!) by "standard" customers:
  EXPORT ClientArchive     (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.ARCHIVE, layouts.batch_raw, THOR, OPT);
  EXPORT ClientRaw     (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.RAW, layouts.batch_raw, THOR, OPT);

  // These are shared for all clients, for example: NCO ('NCO::NCO_N01030'), PRA ('PRA'), etc.
  EXPORT ClientMonitor     (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.SUBMONITOR, layouts.monitor, THOR, OPT);
  EXPORT ClientReport      (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.REPORT, layouts.batch_report, THOR, OPT);
  EXPORT ClientSTHAddress  (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.STH_ADDRESS, layouts.address_history_ext, THOR, OPT);
  EXPORT ClientSTHPhone    (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.STH_PHONE, layouts.phone_history_ext, THOR, OPT);
  EXPORT ClientSTHProperty (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.STH_PROPERTY, layouts.property_history_ext, THOR, OPT);
  EXPORT ClientSTHPaw      (string client_id, string version = QA) := 
    DATASET (Names.THOR_ROOT + client_id + '::' + version + '::' + NAMES.STH_PAW, layouts.paw_history_ext, THOR, OPT);


  // ===============================================================================
  // ========================         CUSTOM FILES            ======================
  // ===============================================================================
  // NB: Archive and Raw layouts will usually be different from customer to customer;

  EXPORT NCO := MODULE
    // Full files
    EXPORT Archive := DATASET (Names.NCO_ARCHIVE, layouts_NCO.batch_raw, THOR, OPT);
    EXPORT Raw     := DATASET (Names.NCO_RAW, layouts_NCO.batch_raw, THOR, OPT);
    EXPORT Report  := DATASET (Names.NCO_REPORT, layouts.batch_report, THOR, OPT);

    // NCO has subclients:
    EXPORT ClientArchive    (string6 nco_id='', string version = QA) := 
      DATASET (Names.NCO_ROOT + 'NCO_' + nco_id + '::' + version + '::' + NAMES.ARCHIVE, layouts_NCO.batch_raw, THOR, OPT);
    EXPORT ClientRaw        (string6 nco_id='', string version = QA) := 
      DATASET (Names.NCO_ROOT + 'NCO_' + nco_id + '::' + version + '::' + NAMES.RAW, layouts_NCO.batch_raw, THOR, OPT);
    EXPORT ClientMonitor    (string6 nco_id='', string version = QA) := ClientMonitor    ('NCO::NCO_' + nco_id, version);
    EXPORT ClientReport     (string6 nco_id='', string version = QA) := ClientReport     ('NCO::NCO_' + nco_id, version);
    EXPORT ClientSTHAddress (string6 nco_id='', string version = QA) := ClientSTHAddress ('NCO::NCO_' + nco_id, version);
    EXPORT ClientSTHPhone   (string6 nco_id='', string version = QA) := ClientSTHPhone   ('NCO::NCO_' + nco_id, version);

  END;

  EXPORT PRA := MODULE
    EXPORT Archive := DATASET (Names.PRA_ARCHIVE, layouts_PRA.batch_raw, THOR, OPT);
    EXPORT Raw     := DATASET (Names.PRA_RAW, layouts_PRA.batch_raw, THOR, OPT);
    EXPORT Report  := DATASET (Names.PRA_REPORT, layouts.batch_report, THOR, OPT);

    // ... PRA doesn't have subclients, so this is formality:
    EXPORT ClientMonitor    (string version = QA) := ClientMonitor ('PRA', version);
    EXPORT ClientReport     (string version = QA) := ClientReport ('PRA', version);
    EXPORT ClientSTHAddress (string version = QA) := ClientSTHAddress ('PRA', version);
    EXPORT ClientSTHPhone   (string version = QA) := ClientSTHPhone ('PRA', version);
    EXPORT ClientSTHProperty(string version = QA) := ClientSTHProperty ('PRA', version);
    EXPORT ClientSTHPaw     (string version = QA) := ClientSTHPaw ('PRA', version);
  END;

  EXPORT BWH := MODULE
    EXPORT Archive := DATASET (Names.BWH_ARCHIVE, layouts_BWH.batch_raw, THOR, OPT);
    EXPORT Raw     := DATASET (Names.BWH_RAW, layouts_BWH.batch_raw, THOR, OPT);
    EXPORT Report  := DATASET (Names.BWH_REPORT, layouts.batch_report, THOR, OPT);

    // ... BWH doesn't have subclients, so this is formality:
    EXPORT ClientMonitor    (string version = QA) := ClientMonitor ('BWH', version);
    EXPORT ClientReport     (string version = QA) := ClientReport ('BWH', version);
    EXPORT ClientSTHAddress (string version = QA) := ClientSTHAddress ('BWH', version);
    EXPORT ClientSTHPhone   (string version = QA) := ClientSTHPhone ('BWH', version);
  END;


  // Customers we want to process first time: result is saved and has to be desprayed manually later,
  // using Monitoring.BWR_FirstRun 
  // IMPORTANT: Same customers must be present in [Monitor] below.
  // CAUTION: usually it will be populated for one Monitor run only
  EXPORT set of string FirstRunSet := [];

  // [Monitor] database
  EXPORT Monitor := dataset ([], layouts.monitor);
                    // NCO.ClientMonitor ('N01030') + // N1
                    // NCO.ClientMonitor ('N01037') + 
                    // NCO.ClientMonitor ('N01059') + 
                    // NCO.ClientMonitor ('N01063') +
                    // NCO.ClientMonitor ('N02031') + // N2
                    // NCO.ClientMonitor ('N02032') +
                    // NCO.ClientMonitor ('N02034') +
                    // NCO.ClientMonitor ('N02067') +
                    // NCO.ClientMonitor ('N02068') +
                    // NCO.ClientMonitor ('N020DE') + 
                    // NCO.ClientMonitor ('N03033') + 
                    // NCO.ClientMonitor ('N03040') + // N3
                    // NCO.ClientMonitor ('N03051') +
                    // NCO.ClientMonitor ('N04035') +
                    // NCO.ClientMonitor ('N06002') + 
                    // NCO.ClientMonitor ('N06010') +
                    // NCO.ClientMonitor ('N06099') +
                    // NCO.ClientMonitor ('N07003') +
                    // NCO.ClientMonitor ('N07016') +
                    // NCO.ClientMonitor ('N07018') +
                    // NCO.ClientMonitor ('N07019') +
                    // NCO.ClientMonitor ('N07022') +
                    // NCO.ClientMonitor ('N07064') +
                    // NCO.ClientMonitor ('N07066') +
                    // NCO.ClientMonitor ('N09023') +
                    // NCO.ClientMonitor ('N09061') +
                    // NCO.ClientMonitor ('P2B122') +
                    // NCO.ClientMonitor ('P2B426') +
                    // NCO.ClientMonitor ('P2B707') +
                    // NCO.ClientMonitor ('P2B929') +
                    // NCO.ClientMonitor ('P2B969') +
                    // NCO.ClientMonitor ('P2B983') +
                    // NCO.ClientMonitor ('P3A330') +
                    // NCO.ClientMonitor ('P3A920') +
                    // NCO.ClientMonitor ('P3A923') +
                    // NCO.ClientMonitor ('P3A933') +
                    // NCO.ClientMonitor ('P3B365') +
                    // NCO.ClientMonitor ('P3B950') +
                    // NCO.ClientMonitor ('PL5938') +
                    // NCO.ClientMonitor ('RP1188') +
                    // NCO.ClientMonitor ('RP1912') +
                    // NCO.ClientMonitor ('RP1926') +
                    // NCO.ClientMonitor ('RP1980') +
                    // NCO.ClientMonitor ('U14046') + // U14
                    // NCO.ClientMonitor ('U14054') + 
                    // NCO.ClientMonitor ('U14055') + 
                    // NCO.ClientMonitor ('U15007') + // U15
                    // NCO.ClientMonitor ('U15009') +
                    // NCO.ClientMonitor ('U15011') +
                    // NCO.ClientMonitor ('U15015') +
                    // NCO.ClientMonitor ('U15027') +
                    // NCO.ClientMonitor ('U15072') +
                    // NCO.ClientMonitor ('U15080') +
                    // NCO.ClientMonitor ('U15081') +
                    // NCO.ClientMonitor ('U21038') + // U21
                    // NCO.ClientMonitor ('U21039') +
                    // NCO.ClientMonitor ('U21041') +
                    // NCO.ClientMonitor ('U22050') + // U22
                    // NCO.ClientMonitor ('U22700') + 
                    // NCO.ClientMonitor ('U22056') +
                    // NCO.ClientMonitor ('U40012') + //U40
                    // NCO.ClientMonitor ('U40013') +
                    // NCO.ClientMonitor ('U40017') +

                    // ClientMonitor ('ARM') +
                    // ClientMonitor ('CBD') +
                    // ClientMonitor ('CPS') +
                    // ClientMonitor ('CPS2') +
//                    ClientMonitor ('DON') +
                    // ClientMonitor ('EPS') +
                    // ClientMonitor ('HHL') +
                    // ClientMonitor ('NAA') +
                    // ClientMonitor ('NAF') +
                    // ClientMonitor ('PCA') +
                    // ClientMonitor ('PCA1') +
                    // ClientMonitor ('PCA2') +
                    // ClientMonitor ('PCA3') +
                    // ClientMonitor ('RNB') +
                    // ClientMonitor ('SAC') +
                    // ClientMonitor ('SCC') +
                    // ClientMonitor ('SPD') +
                    // ClientMonitor ('TGI') +
                    // ClientMonitor ('WAM') +
                    // ClientMonitor ('WAM2') +
                    // ClientMonitor ('WAM3') +
                    // ClientMonitor ('WLF') +
                    // ClientMonitor ('WPF') +

                    // ClientMonitor ('PRA');
                    // ClientMonitor ('BWH');

  // EXPORT Monitor := real_Monitor; // full file
  // EXPORT Monitor := NCO.ClientMonitor ('N00000'); // fake file, to avoid Monitor processing
END;
