#workunit('name','Monitor simple counts; NCO');
import ut;
string WUID := thorlib.wuid ();

string RECON_STAT_DIR := '/newnfsbatch/recon/counts/';
string suffix := ut.GetDate; // allows to choose arbitrary date

// THOR detailed stat, including per score counts
FNAME_MATRIX := Files.NAMES.NCO_ROOT + 'matrix_count_' + suffix;

// csv files with stat: Banko- to spray from, THOR-file to despray to shared landing target
FNAME_CNT       := Files.NAMES.NCO_ROOT + 'count_' + suffix;          // Thor counts
FNAME_CNT_BANKO := Files.NAMES.NCO_ROOT + 'count_banko_' + suffix;    // Banko counts
FNAME_COMPARE   := Files.NAMES.NCO_ROOT + 'count_compare_' + suffix;  // side-by-side comparison

// Remote site filenames 
fname_banko_remote := 'NCO_NM_' + suffix + '.txt';
LZ_FNAME_CNT_BANKO := RECON_STAT_DIR + fname_banko_remote;    // (input) Banko
LZ_FNAME_CNT       := RECON_STAT_DIR + 'NCO_THOR_' + suffix;  // (output) Thor
LZ_FNAME_COMPARE   := RECON_STAT_DIR + 'cmp_' + suffix;       // (output) comparison


// ===============================================================================
// ========================= CREATE COUNTS MATRIX ================================
// ===============================================================================
unsigned1 GetNormScore (unsigned2 score) := MAP (
  score = 0 => 0,
  score between   1 and 400 => 1,
  score between 401 and 549 => 2,
  score between 550 and 649 => 3,
  score between 650 and 899 => 4,
  score = 920 => 5,
  score = 921 => 6,
  score between 922 and 939 => 7,
  score between 940 and 959 => 8,
  score between 960 and 979 => 9,
  score between 980 and 999 => 10,
  100); // all other scores (invalid?)

layout_score := RECORD
  string10 source;  // nco-source, not formatted
  unsigned1 score;
END;

// set unified scores
layout_score SetScore (layouts_NCO.batch_raw L) := TRANSFORM //SAMPLE (Monitoring.Files.NCO.Raw, 1000, 1)
  SELF.source := trim (L.customer_id);
  SELF.score := GetNormScore ((unsigned2) L.nco_internal_score);
END;
raw_in := DISTRIBUTE (PROJECT (Files.NCO.Raw, SetScore (Left)), hash (source, score));

layout_counts := RECORD (layout_score)
  unsigned cnt;
END;

layout_score_count := RECORD
  raw_in.source;
  raw_in.score;
  unsigned cnt := COUNT (GROUP);
END;

ds_counts := PROJECT (TABLE (raw_in, layout_score_count, source, score, LOCAL), layout_counts);
// ds_counts := DATASET ('...FNAME_MATRIX...', layout_counts, THOR); // if already exists

// prepare for rollup (first strech counts to the output layout).
layout_matrix := RECORD
  string10 source;
  unsigned score0;
  unsigned score1;
  unsigned score2;
  unsigned score3;
  unsigned score4;
  unsigned score5;
  unsigned score6;
  unsigned score7;
  unsigned score8;
  unsigned score9;
  unsigned score10;
  unsigned other;
  unsigned cnt;
END;  

layout_matrix Norm (layout_counts L) := TRANSFORM
  SELF.source := L.source;
  SELF.score0 := IF (L.score = 0, L.cnt, 0);
  SELF.score1 := IF (L.score = 1, L.cnt, 0);
  SELF.score2 := IF (L.score = 2, L.cnt, 0);
  SELF.score3 := IF (L.score = 3, L.cnt, 0);
  SELF.score4 := IF (L.score = 4, L.cnt, 0);
  SELF.score5 := IF (L.score = 5, L.cnt, 0);
  SELF.score6 := IF (L.score = 6, L.cnt, 0);
  SELF.score7 := IF (L.score = 7, L.cnt, 0);
  SELF.score8 := IF (L.score = 8, L.cnt, 0);
  SELF.score9 := IF (L.score = 9, L.cnt, 0);
  SELF.score10 := IF (L.score = 10, L.cnt, 0);
  SELF.other := IF (L.score = 100, L.cnt, 0);
  SELF.cnt := L.cnt;
END;
ds_norm := PROJECT (ds_counts, Norm (Left));

layout_matrix RollByScore (layout_matrix L, layout_matrix R) := TRANSFORM
  SELF.score0 := IF (L.score0 > 0, L.score0, R.score0);
  SELF.score1 := IF (L.score1 > 0, L.score1, R.score1);
  SELF.score2 := IF (L.score2 > 0, L.score2, R.score2);
  SELF.score3 := IF (L.score3 > 0, L.score3, R.score3);
  SELF.score4 := IF (L.score4 > 0, L.score4, R.score4);
  SELF.score5 := IF (L.score5 > 0, L.score5, R.score5);
  SELF.score6 := IF (L.score6 > 0, L.score6, R.score6);
  SELF.score7 := IF (L.score7 > 0, L.score7, R.score7);
  SELF.score8 := IF (L.score8 > 0, L.score8, R.score8);
  SELF.score9 := IF (L.score9 > 0, L.score9, R.score9);
  SELF.score10 := IF (L.score10 > 0, L.score10, R.score10);
  SELF.other := IF (L.other > 0, L.other, R.other);
  SELF.cnt := L.cnt + R.cnt;
  SELF.source := L.source;
END;
ds_matrix := ROLLUP (SORT (ds_norm, source), Left.source = Right.source, RollByScore (Left, Right)) : INDEPENDENT;
// ds_matrix := DATASET (FNAME_MATRIX, layout_matrix, FLAT) (source[1..5] != 'score');

// attach aggregates 
ds_res_matrix := ds_matrix +
  DATASET ([{'per_score', SUM (ds_matrix, score0), SUM (ds_matrix, score1), SUM (ds_matrix, score2),
                          SUM (ds_matrix, score3), SUM (ds_matrix, score4), SUM (ds_matrix, score5),
                          SUM (ds_matrix, score6), SUM (ds_matrix, score7), SUM (ds_matrix, score8),
                          SUM (ds_matrix, score9), SUM (ds_matrix, score10), SUM (ds_matrix, other),
                          SUM (ds_matrix, cnt)}], layout_matrix); 


// ===============================================================================
// ======================= CREATE/SPRAY/DESPRAY SLIM COUNTS ======================
// ===============================================================================

// common layout for comparing counts; 
layout_shared := RECORD
  string10 source;   // eventually will be "clean" NCO source: char6
  unsigned cnt := 0; // already calculated number of records per source
END;

// create a short version of THOR Statistics (for further despraying to share it with others)
ds_stat := PROJECT (ds_matrix, transform (layout_shared, Self.source := Left.source[5..]; Self := Left));
// ds_stat := DATASET (FNAME_CNT, layout_shared, CSV (separator('    '), terminator('\n'))); //read, if already exists

// try to use Banko file
boolean BankoFileExists := EXISTS (NOTHOR (
  FileServices.RemoteDirectory (Environment.LandingZone.ip, RECON_STAT_DIR) (name = fname_banko_remote)
));

ext_fname := FileServices.ExternalLogicalFileName (Environment.LandingZone.ip, LZ_FNAME_CNT_BANKO);
ds_banko_in := DATASET (ext_fname, layout_shared, CSV (maxlength (64), separator ('    ')));
ds_banko := PROJECT (ds_banko_in, transform (layout_shared, Self.source := Left.source[3..]; Self := Left));



// ===============================================================================
// =========================== SIDE-BY-SIDE COMPARISON ===========================
// ===============================================================================
layout_combined := RECORD
  string6 source;
  unsigned banko_cnt;
  unsigned thor_cnt;
  integer diff;
END;
layout_combined GetCombinedScores (layout_shared L, layout_shared R) := TRANSFORM
  SELF.source := IF (L.source != '', L.source, R.source);
  SELF.banko_cnt := L.cnt;
  SELF.thor_cnt := R.cnt;
  SELF.diff := (L.cnt - R.cnt);
END;

ds_combined := JOIN (ds_banko, ds_stat,
                     Left.source = Right.source,
                     GetCombinedScores (Left, Right),
                     FULL OUTER, LIMIT (1)) : INDEPENDENT;

// ACTION
EXPORT CreateStat_NCO := SEQUENTIAL (
  OUTPUT (ds_res_matrix, , FNAME_MATRIX, OVERWRITE),
  OUTPUT (ds_stat, , FNAME_CNT, CSV (separator('    '), terminator('\n')), OVERWRITE),
  FileServices.Despray (FNAME_CNT, Environment.LandingZone.ip, LZ_FNAME_CNT),
  IF (BankoFileExists,
      SEQUENTIAL (
        // act_sprayExternalStat,
        OUTPUT (ds_combined, , FNAME_COMPARE, CSV (separator(','), terminator('\n')), OVERWRITE),
        FileServices.Despray (FNAME_COMPARE, Environment.LandingZone.ip, LZ_FNAME_COMPARE, , , , TRUE)
     )
     ),
  OUTPUT (ds_combined, NAMED ('combined'))
  // OUTPUT (ds_res_matrix, NAMED ('ds_res_matrix')),
  // OUTPUT (ds_stat, NAMED ('ds_stat')),
) : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'NCO counts failure: ' + WUID, failmessage));;

/*
// this is how to schedule it on THOR:
#workunit('name','Monitor simple counts; NCO');
string WUID := thorlib.wuid ();

act_run := Monitoring.CreateStat_NCO;
//  : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'NCO counts failure: ' + WUID, failmessage));

act_run : WHEN (EVENT ('CRON', '30 7 * * *'));
*/